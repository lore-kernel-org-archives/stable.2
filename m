Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBE376BC1
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190332; cv=none; b=t/fJyw8ECtH97Q10zY0/rqggkLETgpKZ49EEFI0w29PYd0lowIa6Jw1P3dbA1Eu8J+5pL5kO9MtUfBgk4gDollhwUgqz8XAlivhTlaCkQh59CbubJvDM9O74id2+dnXCzzWRvjTTML7stLPGEiPU2XVzH8UBEtZPXWdKruiLx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190332; c=relaxed/simple;
	bh=hmmAPOLYrLNgFKU1qbHEFRQ6QH8CsdU7hq/txSetJpY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QrR7D2bLxlCbPqgkfKJBo3pqUs/xoHtdakyyEU8QR0B4cem1UnNobJ7wee0JC0SXXK50Tco8tS4sttFWV8dC5cHeiXoIqJEn7vDJGzxhp7RZIqLGFs7K8kA/qt2hIPnaoPvi6hKhl4YRxbYa1FJ0r7DzJkchaK2gL0jJ365zyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AeYh1M8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AeYh1M8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F17B1F000FF;
	Mon,  5 Oct 2026 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190330;
	bh=N2lB+m7dDhm/M27w2xfWGYhcL5xdiaVWQAvmjpwB5OA=;
	h=Subject:To:Cc:From:Date;
	b=AeYh1M8cR3lHQ9DTsJYSZ/WOnhm6huUOkuEboNOz2MDccNVLVj26V2GNIUVvRqb19
	 kTO7KfPHDIWEkYLuXp2VbuQgdwtAEg2W7CHnX9iqGEkfVL9M6nTsYPLjkLJIZyDfu4
	 TXlepEfh9DT8mEjsTt9OcfK/u6JjncjdkcPQVa8Y=
Subject: FAILED: patch "[PATCH] tty: serial: max3100: shut down timer before freeing port" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:52:00 +0200
Message-ID: <2026100500-tipper-geologic-7516@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x db0949bbd06db0a75b4b1076f1e25194be7d956a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100500-tipper-geologic-7516@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db0949bbd06db0a75b4b1076f1e25194be7d956a Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sun, 27 Sep 2026 05:59:57 +0000
Subject: [PATCH] tty: serial: max3100: shut down timer before freeing port

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

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index a5a5cd68f696..f858a6669011 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -535,11 +535,11 @@ static void max3100_shutdown(struct uart_port *port)
 	timer_delete_sync(&s->timer);
 
 	if (s->workqueue) {
+		free_irq(port->irq, s);
+		cancel_work_sync(&s->work);
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 	}
-	if (port->irq)
-		free_irq(port->irq, s);
 
 	/* set shutdown mode to save power */
 	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
@@ -753,6 +753,15 @@ static void max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+
+			s->force_end_work = 1;
+			timer_shutdown_sync(&s->timer);
+			if (s->workqueue) {
+				free_irq(s->port.irq, s);
+				cancel_work_sync(&s->work);
+				destroy_workqueue(s->workqueue);
+				s->workqueue = NULL;
+			}
 			kfree(max3100s[i]);
 			max3100s[i] = NULL;
 			break;

