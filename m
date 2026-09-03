Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B214E56E3
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450000; cv=none; b=PpAiO4rv4O2v9AUuBqXGYNfqT6dv7+5rH6D5kqjJf/On4BaX52J7waoLY+R+DqAdeQcz+N9R5Nuly3vDZBCS4i7NeHrudybtchxSl7Do2shxXFA2cthrBPUtYuxPd/pBPQUr3BLxNI1nNXsXjWiOXZTjiwafKOQuPZBRPA3Plyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450000; c=relaxed/simple;
	bh=n1P4SR373b+oAgJOwknU/AR/y5PRnvjV87qEWpRHQAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IgPT2stJSw7iQVsLhEg4hti7GS7FovRz6QM8cRqA6joFpNQMYNAOtRVdOGB0ja5XZTZKJRrqZkt8p6Om8t7NNpsT+Xrz56lavmhqHnPH2MvUYA7RB/P+/cOI/jyUIUzY0Muwp3pJMbGmsu2iRSQI7hJA9E/yxyYl+tgXxJhE6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fjwYdHR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fjwYdHR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11021F000E9;
	Thu,  3 Sep 2026 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449998;
	bh=G0vCYOZv0b7LQb5u61qkdOqwk527EiyupMOr1TgLHeI=;
	h=Subject:To:Cc:From:Date;
	b=fjwYdHR+xHxZzeYZUrb1FSTVOH3xcsvifcgxQlVIi8G2EDR/3Ejq0TbTzx+KNAfxv
	 SKU9/DspNkbIi+WqQmw7SfPZekQMdVRdDPre/GkASyyBV/kLA6/8FIlGrPOSBfGJTA
	 vPd/ne1hwbQQoL5MyVQWJiRWNUCyAxo94WsqYyvk=
Subject: FAILED: patch "[PATCH] ALSA: FCP: do not copy out an uninitialised init response" failed to apply to 6.18-stable tree
To: baul.lee@xbow.com,federico.kirschbaum@xbow.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:13:33 +0200
Message-ID: <2026090333-knee-unfrozen-751f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4335e387786479889e6db691fe06d345e52ea536
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090333-knee-unfrozen-751f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4335e387786479889e6db691fe06d345e52ea536 Mon Sep 17 00:00:00 2001
From: Baul Lee <baul.lee@xbow.com>
Date: Wed, 5 Aug 2026 10:38:04 +0900
Subject: [PATCH] ALSA: FCP: do not copy out an uninitialised init response

fcp_ioctl_init() allocates its response buffer with kmalloc() and copies
the whole buffer back to userspace:

	buf_size = init.step0_resp_size + init.step2_resp_size;

	void *resp __free(kfree) =
		kmalloc(buf_size, GFP_KERNEL);
	...
	if (copy_to_user(arg->resp, resp, buf_size))
		return -EFAULT;

Nothing clears the buffer, and the only writer of its leading
step0_resp_size bytes is the step-0 control transfer:

	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
		FCP_USB_REQ_STEP0,
		USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
		0, private->bInterfaceNumber,
		step0_resp, private->step0_resp_size);
	if (err < 0)
		return err;

usb_fill_control_urb() does not set URB_SHORT_NOT_OK, so a short or
zero-length data stage completes with status 0 and snd_usb_ctl_msg()
returns a small actual_length.  The only check is err < 0, so a short
transfer is accepted as success.

snd_usb_ctl_msg() copies the full size back unconditionally:

	buf = kmemdup(data, size, GFP_KERNEL);
	...
	memcpy(data, buf, size);

Bytes the device never wrote are therefore restored into resp unchanged
and copied to userspace.  step0_resp_size and step2_resp_size are each
validated only to 1..255, so the caller also picks the slab cache, from
kmalloc-8 up to kmalloc-512.

On 7.2.0-rc5 (arm64), device answering step 0 with a zero-length data
stage, s0 = s2 = 255:

  # init_on_alloc off, no spray
  step0 window [0,255): nonzero=94/255
  000: 00 80 60 06 00 00 ff ff 18 00 00 00 57 01 ea 01
  010: 08 78 22 13 00 00 ff ff a8 c4 5f 80 00 80 ff ff

  # same kernel, kmalloc-512 pre-seeded with an 8-byte tag
  step0 window [0,255): nonzero=219/255  tagbytes=232

  # identical run, init_on_alloc=1
  step0 window [0,255): nonzero=0/255  tagbytes=0

  # all three runs
  step2 window [255,510): device words matched=62/62

a8 c4 5f 80 00 80 ff ff is the little-endian kernel text address
ffff8000805fc4a8.  The step-2 window is unaffected, so the disclosure is
exactly the step-0 region.

Zero the buffer, and require the step-0 transfer to deliver the full
step0_resp_size bytes so a short data stage is reported as an error.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 46757a3e7d50 ("ALSA: FCP: Add Focusrite Control Protocol driver")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Link: https://patch.msgid.link/20260805013804.38839-1-baul.lee@xbow.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/fcp.c b/sound/usb/fcp.c
index 6f5dcd35e1d4..8f52a3dc9ec3 100644
--- a/sound/usb/fcp.c
+++ b/sound/usb/fcp.c
@@ -486,7 +486,7 @@ static int fcp_ioctl_init(struct usb_mixer_interface *mixer,
 	buf_size = init.step0_resp_size + init.step2_resp_size;
 
 	void *resp __free(kfree) =
-		kmalloc(buf_size, GFP_KERNEL);
+		kzalloc(buf_size, GFP_KERNEL);
 	if (!resp)
 		return -ENOMEM;
 
@@ -1022,6 +1022,8 @@ static int fcp_init(struct usb_mixer_interface *mixer,
 		step0_resp, private->step0_resp_size);
 	if (err < 0)
 		return err;
+	if (err != private->step0_resp_size)
+		return -EIO;
 
 	err = fcp_init_notify(mixer);
 	if (err < 0)

