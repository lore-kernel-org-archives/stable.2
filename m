Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CB568550
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980134; cv=none; b=Z9bhOI6VCu7gJJ4QhmKyhRejtT55lBfN2fB0RIvFbxR3D1J38mK9tPsX1taL/XxRPdtvpMxw/lfHP1Ab7fWL/C6LURsQIoRVZzTHdJ+yik/4GVgd9Y06i8wkGnR3GtJTw10Ko6b0c4bsYYjzdUQFNkMbEUxNPjZ0fUUZTsyTAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980134; c=relaxed/simple;
	bh=CHDjRqXTzODFC5xB1HvvfcUfiMj5et2URQ6KpT/AGmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtAG8x4/FqIXTztYLmylK/wTGkUtfBKlUPHFfoyu0FneademrMmNN5tX7du9og5KjqdtucHX6RwdTIMEfreu4PX+iMlJDowYrH47awYVb2W4/lqC1CMTu1ps89Dd22feA7qethY0UUt9GFl5y/QqtRBxSwkK1lvoAitJvdUXtwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLX5pAsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLX5pAsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDA01F00898;
	Wed,  9 Sep 2026 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980128;
	bh=uijOTHhFYhtEhIXB4osJIssYt4Wv8J9ND42gyvl5MQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLX5pAsLhQFsooU8vhJYeGao27L7AzWMMyJ3xVI6F0ypT8EexuVpjTsTLx3XeLWyX
	 mJEyd4t3tkiYMZ03B+tcToU9JCiicJEQFukmZiSpA0kLBKrptMCPCvPk016H5C7wMG
	 63xIukYe27D+ibC2aPKOMTYQMkdqSlmF6FixBKzfNZEtqk+U1LcKCJ2AQlsacxoI1U
	 E19xhPlSCBGizyyoGMVAtt11FpG/T9CwP4YdTVX1Aq0GxL0smPQsjBB3v0G2DKbgSD
	 GWm3jxICmb+YpKDzoxiwgOJLDUeO5liN4nB48ODO+/fGaK2UQt1s4S8YhC5Cd6rgKZ
	 WZ16ZFZUnxOkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: FCP: do not copy out an uninitialised init response
Date: Wed,  9 Sep 2026 14:55:24 -0400
Message-ID: <20260909185524.3490593-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909185524.3490593-1-sashal@kernel.org>
References: <2026090333-knee-unfrozen-751f@gregkh>
 <20260909185524.3490593-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baul Lee <baul.lee@xbow.com>

[ Upstream commit 4335e387786479889e6db691fe06d345e52ea536 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/fcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/fcp.c b/sound/usb/fcp.c
index 3ee5ea415f655..a17bf0028a8ad 100644
--- a/sound/usb/fcp.c
+++ b/sound/usb/fcp.c
@@ -494,7 +494,7 @@ static int fcp_ioctl_init(struct usb_mixer_interface *mixer,
 	buf_size = init.step0_resp_size + init.step2_resp_size;
 
 	void *resp __free(kfree) =
-		kmalloc(buf_size, GFP_KERNEL);
+		kzalloc(buf_size, GFP_KERNEL);
 	if (!resp)
 		return -ENOMEM;
 
@@ -1033,6 +1033,8 @@ static int fcp_init(struct usb_mixer_interface *mixer,
 		step0_resp, private->step0_resp_size);
 	if (err < 0)
 		return err;
+	if (err != private->step0_resp_size)
+		return -EIO;
 
 	err = fcp_init_notify(mixer);
 	if (err < 0)
-- 
2.53.0

