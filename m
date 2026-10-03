Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705F2931EE
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033253; cv=none; b=OWhUofXGJ2YztVw6QxhDKQhY5FTdXWFeCcRtySIIHTfNnsZzn9BpJE8p6DFIxk6/I89UaabMuy755RGbBsHO1AnIRHuu0fck9nDq5disSD8IGa+KgiVEJR2GVkD9oNqHAkOr/tC0BCtWrDxVYNXwoCAYlXg/9OrSypMR7wO1iKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033253; c=relaxed/simple;
	bh=mVWMlrxqNk9ABxXqOEeFwj+D+OtaS0KLW/Opk/RXnYE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PoTy300D4uO1q256ZeU0Q/5dT9clEzxC3SC+92qtoy5hWXsuaxM2L7H8vf7rhMCF0Dy1gxjur2FjY4xPOT9kJdadPWJTqlD2PEA2p1jIEIZKzvt+nrhTZ9R68X40mHtziIYCOj7/WCBMHoT1bIkWm7XSEBt+JzwItpxxwG33kAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYsg1W/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYsg1W/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8615C1F0089B;
	Sat,  3 Oct 2026 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033252;
	bh=MEsmkrVV6WxocmHwI6+GJFl155BUn+WEr1YS5eYppAM=;
	h=Subject:To:Cc:From:Date;
	b=JYsg1W/MNxPXKOudJlp1UWVYYSAHh0PtTQqGhPNXqLFMErYvLFpcQxGiLXXToZ+Ai
	 xvGUkJD2kbkDaEEaQlL1M/011jS6qRPegMX2twN+xmdxy3QYm9XDKKpYCqDD28RpKp
	 l4zEUYGRy0OcbCZ9caT0hyA7+kJLm+XsFHn4dO6w=
Subject: FAILED: patch "[PATCH] HID: multitouch: stop the release timer from being rearmed on" failed to apply to 5.15-stable tree
To: qwe.aldo@gmail.com,bentiss@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:14:03 +0200
Message-ID: <2026100303-fender-underage-9574@gregkh>
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
git cherry-pick -x 5acb2dace582f061aab5e14c399ac9480315f44b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100303-fender-underage-9574@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5acb2dace582f061aab5e14c399ac9480315f44b Mon Sep 17 00:00:00 2001
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Date: Wed, 23 Sep 2026 08:58:47 -0300
Subject: [PATCH] HID: multitouch: stop the release timer from being rearmed on
 remove

mt_remove() quiesces the sticky-finger timer before stopping the
hardware:

    timer_delete_sync(&td->release_timer);

    sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
    hid_hw_stop(hdev);

timer_delete_sync() waits for a running callback and dequeues the timer,
but it does not stop the timer from being armed again. The transport is
still delivering reports at that point, and the report path rearms it:

    if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
        if (td->mt_io_flags & MT_IO_SLOTS_MASK)
            mod_timer(&td->release_timer,
                      jiffies + msecs_to_jiffies(100));

A report that arrives after timer_delete_sync() has returned therefore
leaves the timer queued. td is allocated with devm_kzalloc() against
hdev->dev, so it is freed when the driver is unbound, after mt_remove()
returns. When the timer fires afterwards, mt_expired_timeout()
dereferences the freed td:

    struct mt_device *td = timer_container_of(td, t, release_timer);
    struct hid_device *hdev = td->hdev;

    if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))

Simply moving the teardown after hid_hw_stop() does not fix this on its
own, because mt_expired_timeout() calls mt_release_contacts(), which
walks hdev->inputs; the timer still has to be quiesced before
hid_hw_stop() tears the input devices down.

Use timer_shutdown_sync() instead, which additionally makes any later
mod_timer() a no-op, so neither ordering constraint has to be traded off
against the other. This is the final-teardown pattern the function was
introduced for, and hid-wiimote already uses it for the same reason.

Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.com?part=1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index ab4ac261fe76..4e19a0c4d238 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2249,7 +2249,7 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&td->release_timer);
+	timer_shutdown_sync(&td->release_timer);
 
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);

