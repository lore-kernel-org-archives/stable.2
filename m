Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E39472F67
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663786; cv=none; b=KqBm7yPVyOqETGzFlsFNzc1fm+JNlm2MNrW9GL+WIYOaGCEzjBHrTzi/4SHUrxQOzZZUYVNGvqzcrQbbB+lMd4DQOZgcGcBvEPKmmgaeRqeROPlpQHPSngkaIrotLuEzSY5h1m0o+zU9QIrlpl6M59I223gzo36b2voUN2ZFCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663786; c=relaxed/simple;
	bh=3Zv6SBLe8LE9P4b0xt7gwZe3HRhqTcI223JkEElwIG0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nQ/oaTXCdjOqQBSv8SVvhYw1GPHzSGGIRg/YCY9JseWHH0SHh1phU1/ptFC73irQ83HYhHWjwAt6CLUls0/bu69xhJ7adxKyVECDJq9g/LW8dOaB901CdB8XgXDRHnJl8rr1jFsJ/02Ru731H+cUGJ82DJYkhaU82M6DdiJ1h3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nyRF/+YS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nyRF/+YS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774531F000E9;
	Tue, 25 Aug 2026 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663784;
	bh=ZB5z4JDqsIsOHHZOFfgI6SsggELYhuZwyFjZevZQImA=;
	h=Subject:To:Cc:From:Date;
	b=nyRF/+YS3gMc7xvPfisBYeASJR34Q0fMaSFBfW6vesdbCEXe71f7kNnlkfXrbaUxN
	 JakiuoBcKtsqQZ+mdG+zGBrxj0fMnY7fZqiXl9whsxwqdJTyD9xApNqLhc9pLn5SEl
	 vkEOerppISjBl6P+OEuBpInb3FYt+GyipyO6V1Rk=
Subject: FAILED: patch "[PATCH] HID: uclogic: fix use-after-free of inrange_timer on remove" failed to apply to 5.15-stable tree
To: security@auditcode.ai,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:15:57 +0200
Message-ID: <2026082557-kindling-coping-1767@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 506fd50a9027340f0e9dcc587d10ccb03312dba6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082557-kindling-coping-1767@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 506fd50a9027340f0e9dcc587d10ccb03312dba6 Mon Sep 17 00:00:00 2001
From: Ibrahim Hashimov <security@auditcode.ai>
Date: Tue, 14 Jul 2026 19:39:46 +0200
Subject: [PATCH] HID: uclogic: fix use-after-free of inrange_timer on remove

uclogic_remove() cancels the pen in-range timer and then stops the
device:

	timer_delete_sync(&drvdata->inrange_timer);
	hid_hw_stop(hdev);

timer_delete_sync() only guarantees the timer is idle at that instant.
uclogic_raw_event_pen() keeps delivering pen reports until hid_hw_stop()
stops the transport several lines later, and every report with
pen->inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE re-arms the timer:

	mod_timer(&drvdata->inrange_timer, jiffies + msecs_to_jiffies(100));

A report landing between the timer_delete_sync() call and the transport
teardown in hid_hw_stop() re-arms inrange_timer after it was cancelled.
uclogic_remove() then returns and the devm drvdata is freed, while
hid_hw_stop() has already freed the input device drvdata->pen_input
points at, so when the timer fires ~100 ms later
uclogic_inrange_timeout() dereferences freed memory -- a use-after-free
in timer-softirq context.

Swapping the two calls is not a fix: stopping the device first frees
drvdata->pen_input via hidinput_disconnect() while the timer may still
be pending, so a timer already armed before removal fires on the freed
input device in the window before timer_delete_sync() runs.

Use timer_shutdown_sync() before hid_hw_stop() instead. It cancels the
timer, waits for a running callback while pen_input is still valid, and
prevents any further re-arming -- a later mod_timer() from an in-flight
report is silently ignored -- so the timer is provably dead before
hid_hw_stop() frees the inputs. This is the ordering the timer core
documents for this "timer re-armed from another path" teardown case.

Fixes: 01309e29eb95 ("HID: uclogic: Support in-range reporting emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b73f09d26688..0b8a83fa6c5b 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -548,7 +548,17 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&drvdata->inrange_timer);
+	/*
+	 * Shut the in-range timer down before stopping the device.
+	 * uclogic_raw_event_pen() re-arms inrange_timer on every pen report
+	 * and keeps running until hid_hw_stop() stops the transport, so a
+	 * plain timer_delete_sync() here can be undone by a report landing in
+	 * the window before hid_hw_stop().  timer_shutdown_sync() cancels the
+	 * timer and makes any later re-arm a no-op, so it is provably dead
+	 * before hid_hw_stop() frees the input device drvdata->pen_input
+	 * points at.
+	 */
+	timer_shutdown_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);

