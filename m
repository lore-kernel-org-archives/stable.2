Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8183C3787
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870176; cv=none; b=ZWfMTJyWgL3l6Tc3RIJcr8vZk4xj3eOTMzLIGQL6z988fiKZbEWAE7zspE0jjFJWR9JqgcAQpX54RcETo/mXoi5mRbX2JZQ12o3vfvvENmGthJ56SODeJQRzbwTQ3PzbvxPlezL065Jq2mhaed5C3oLkGuIVcUdnZ71iDtk8Gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870176; c=relaxed/simple;
	bh=YsRLVfbg40orIRSJHOzYUlywA2u4aejXbsXg1zEcw9k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UQtV2r8VHU3sSuAIT2JQIU1i5ZBAZoh1LgfGAe83vYg4gfixo5ysQdgRoSh+aZ1VSdQeebGC6eIbg2J1i6QDMgDzJOMmMlBY2/hehO3BzDWImtLJrJ2i/CUrjjCdFcVtC6iosttBhZg70lP3OYccXsBWTMb7D+MW+sbmYHm+fYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivXh85jd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivXh85jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AD31F00A3A;
	Tue,  8 Sep 2026 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870175;
	bh=4Uva79H4irBsUJVKNB9i7pbGs95dnIt8aykG6H0GhDw=;
	h=Subject:To:Cc:From:Date;
	b=ivXh85jdtR6kWcSYAYcKEMl6+Sc08jrcqOZrQ2Mm4AgDn9h0wIOWjU6E5rEnN1ZJQ
	 Tq8JWFpaJylue8B8/Vt6p9C56LEYO1hSqN0kwRgrKYuopCV59i06kpDfhZ0MqFSF3j
	 CrktFXAfkiYR/H989NXuwzR4IkADqF8WR85C03f4=
Subject: FAILED: patch "[PATCH] usb: storage: realtek_cr: fix use-after-free on disconnect" failed to apply to 6.6-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:22:32 +0200
Message-ID: <2026090831-imbecile-crinkle-7c3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4ffee1aebb0c0ffcda9faffd17834ea9b00d42cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090831-imbecile-crinkle-7c3e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ffee1aebb0c0ffcda9faffd17834ea9b00d42cc Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 27 Jul 2026 21:34:14 +0900
Subject: [PATCH] usb: storage: realtek_cr: fix use-after-free on disconnect

realtek_cr_destructor() calls timer_delete() before the chip containing
the timer is freed. The timer callback may still be running and can
rearm itself, resulting in a use-after-free.

Use timer_shutdown_sync() to wait for the callback and prevent further
rearming. Do this unconditionally because ss_en may be changed after
the timer is armed.

Move timer_setup() into init_realtek_cr() so the timer is initialized
before any failure path can invoke the destructor.

Found by static analysis.

Fixes: e931830bb877 ("Realtek cr: Add autosuspend function.")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260727123414.44700-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index af038b897c6b..c4b28744693b 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -916,7 +916,6 @@ static int realtek_cr_autosuspend_setup(struct us_data *us)
 	us->proto_handler = rts51x_invoke_transport;
 
 	chip->timer_expires = 0;
-	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
 	fw5895_init(us);
 
 	/* enable autosuspend function of the usb device */
@@ -934,10 +933,7 @@ static void realtek_cr_destructor(void *extra)
 		return;
 
 #ifdef CONFIG_REALTEK_AUTOPM
-	if (ss_en) {
-		timer_delete(&chip->rts51x_suspend_timer);
-		chip->timer_expires = 0;
-	}
+	timer_shutdown_sync(&chip->rts51x_suspend_timer);
 #endif
 	kfree(chip->status);
 }
@@ -982,6 +978,9 @@ static int init_realtek_cr(struct us_data *us)
 
 	us->extra = chip;
 	us->extra_destructor = realtek_cr_destructor;
+#ifdef CONFIG_REALTEK_AUTOPM
+	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
+#endif
 	us->max_lun = chip->max_lun = rts51x_get_max_lun(us);
 	chip->us = us;
 

