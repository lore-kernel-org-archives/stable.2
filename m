Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89DB3AFB19
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236879; cv=none; b=Xu+U5oY4+gPsTqTqz0bXyqrabSKkzKxzKGvE41/DQGC7j7CmGtR3eutfsBACdyAnCVw1JCY3+KKy1mXfYdh5dGpxqLtRXDx7CeByDhX/VWEJQD6iKjCw2QlrbfW0op0C4ArlUUC6g9R3IOFQt0dqbk9b5237LWVkSLfcaKpETrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236879; c=relaxed/simple;
	bh=Y4R+/M+C3UzI5yoGU3nZUo22t5wBgIhNVWgwEg/Cp48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mp/6DIEtd4J+930kM3mw4+OqoyadNhDH+oRDfO/k5B6jlSIzl6qGQxpwLYCa8SbTrC/wnjH2ZxhmGn9gWCpy4XqWmIUXbaeJpHq4Gkza8QFBZUZPmfj3d51C5a6APFS5liODYu98A56qZEfydqpVsmL35wSXHZaWef85AUlXRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iltpixIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iltpixIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093411F000FF;
	Mon,  5 Oct 2026 21:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791236877;
	bh=M5d/ApCtGWDpQFoqxr+HNye5SD51hecZ8uMV9/iq+jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iltpixIbHBf1+/Q+J7wg0KlwfANOoTLr53DY+6KuKn2BwpFWHwKV6quL56xjGnSxJ
	 iyQrlROGSV0/nNKYTOXm7FsTA63abNusob1yucMk7XmCL5w3tJcbxaHI8LmW8tMNz4
	 sfqO5XtHZPnwf6+ZX0VuEGhHo1805mgZckftFGeMgiVcT5FtivjK8BhljCyOc/5lox
	 kGELH8mekcLVsvKspvXo8GcOhV9fqKZEbIQ8m8c/ITstB4z7xtG+7kfwYg7hMx0dhx
	 ZA7LRyulfdNhw+k4pNkV+yIUzMCcItWoid5y3XruQi4BheiHqNSSPrKmTjJsdVrOsq
	 FqAPuDbZzqFyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tty: serial: max3100: shut down timer before freeing port
Date: Mon,  5 Oct 2026 17:47:52 -0400
Message-ID: <20261005214652.3378317-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100500-unsuited-steed-dcc4@gregkh>
References: <2026100500-unsuited-steed-dcc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit db0949bbd06db0a75b4b1076f1e25194be7d956a ]

max3100_shutdown() stops the polling timer but returns early during
system suspend. If the SPI device is unbound before resume, the serial
core does not call max3100_shutdown() again, so max3100_remove() frees
the port while the timer remains armed. max3100_timeout() may then
access the freed port and re-arm the timer.

Add final timer teardown to max3100_remove() and use
timer_shutdown_sync() to prevent a racing callback from re-arming it.
Also free the IRQ and destroy the workqueue there before freeing the
port. Keep timer_delete_sync() in max3100_shutdown() so that a
subsequent open() can re-arm the timer.

The workqueue is created before request_irq() and destroyed on both
request_irq() failure and normal shutdown. Its presence at remove thus
identifies the IRQ left registered when suspend bypasses shutdown.

Free the IRQ before destroying the workqueue, in both
max3100_shutdown() and max3100_remove(), and cancel the pending work
in between. free_irq() waits for a running interrupt handler to
finish and no new handler can start afterwards, so a racing handler
cannot queue work on a workqueue that is being destroyed; the
force_end_work check in max3100_dowork() only narrows that window, as
a handler delayed between the check and queue_work() could still run
after the teardown has cleared the workqueue pointer. Cancelling the
work also keeps destroy_workqueue() from waiting on a queued work item
in case remove() ever runs while the freezable workqueue is still
frozen, e.g. device removal during the resume window, before
workqueues are thawed.

This issue was found by an in-house static analysis tool.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Cc: stable@kernel.org # 6.2+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260927055957.561030-1-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Adapted IRQ teardown to use s->irq instead of the port’s irq field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max3100.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 8290ab72c05a3..c31cce1c0182a 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -568,12 +568,11 @@ static void max3100_shutdown(struct uart_port *port)
 		del_timer_sync(&s->timer);
 
 	if (s->workqueue) {
-		flush_workqueue(s->workqueue);
+		free_irq(s->irq, s);
+		cancel_work_sync(&s->work);
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 	}
-	if (s->irq)
-		free_irq(s->irq, s);
 
 	/* set shutdown mode to save power */
 	if (s->max3100_hw_suspend)
@@ -832,6 +831,15 @@ static int max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+
+			s->force_end_work = 1;
+			timer_shutdown_sync(&s->timer);
+			if (s->workqueue) {
+				free_irq(s->irq, s);
+				cancel_work_sync(&s->work);
+				destroy_workqueue(s->workqueue);
+				s->workqueue = NULL;
+			}
 			kfree(max3100s[i]);
 			max3100s[i] = NULL;
 			break;
-- 
2.53.0

