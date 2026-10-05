Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051236E470
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239629; cv=none; b=rHXNaR2m+fg1e9t8EzC9HWh/Q5sz4Zty7fZ+ztoswZIfRxYKxSfJEPjm7HJRROcTxK95k7g0CHiacVbY39WTSYnmIdnqitgbLn+jSDSVK1aFABlbnJ4H63n6tJMNx0W6i2Ppw4+w4AhpQY8or7gHrHdaTi1mZtFm7Tq9I6zDsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239629; c=relaxed/simple;
	bh=lSAbdO/ZrIN2neFdrefjo0+YCnZsv8OtsSWUBIEzQPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiO7eEyGXi7lyFOZY9UzuR5zNeyfAp2FuQ19yYNIeyUxeKYQBx2VkG2gqB2DtNfu/rPTe27UCJqUjC1z+LzVZ/20aOplFylqiLlmV59jR/a33Q3pTeWpRp2xuGXEsUa2J7mBAkZgV9uq8eBPKTkty4kYbOwLmwB3pKDVw9QG+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsgZKMay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsgZKMay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B451F000FF;
	Mon,  5 Oct 2026 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239627;
	bh=aLY556Ny8CB1DoX7GNyJnNjUVIBMBKQo3xCGkOwcPh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YsgZKMayadAFfvLVWoOnIH+C/56hfHJ6iToZq7gpzNjiHpGr5vUGcJQetEUFtDR20
	 O2hvFcFmz6YdvnDgVmqcgIggIFpOy8lYxBxrvQZeaN+Zp67uZJ6tkVcKSJ/Axb2TOx
	 hh6P6GYAAUzm8d2M2mFKBLa/MoUjBZ8iGZaFyW64xa26vYH344bmD/bk3+ghgga3nw
	 EdmxdzwmV4SvgJP2Mmr+eubOYV38LttPN2YgVpgqZJ7nOJWeTA6t5WZEjlGhB/Z8GY
	 8Yzle0tT+eYMklTfUxg4paEHlXLrJv4pXzaauztJkx55xcRIJkeRVzphWoU6WLO1K0
	 PXIXRTDbEf3cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tty: serial: max3100: shut down timer before freeing port
Date: Mon,  5 Oct 2026 18:33:44 -0400
Message-ID: <20261005223256.3427262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100501-duckling-overlying-9d15@gregkh>
References: <2026100501-duckling-overlying-9d15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
[ sashal: Replaced unavailable timer_shutdown_sync() with timer_delete_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max3100.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 17b6f4a872d6a..a1b24c7d5d865 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -571,12 +571,11 @@ static void max3100_shutdown(struct uart_port *port)
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
@@ -835,6 +834,16 @@ static int max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+
+			s->force_end_work = 1;
+			/* Only the timer callback can rearm it after port removal. */
+			timer_delete_sync(&s->timer);
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

