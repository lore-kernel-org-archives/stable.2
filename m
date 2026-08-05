Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432D261B70
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893890; cv=none; b=W6Q/adtksw8PFi4qp6xIARHOcXtn61ae5H/sIKJNoc6Y6piDCNLg8uzJlBHIRyqDrUkCGfDULBa1HAX2eD/D8XPAQsM/w4NnsM1vvpvA8ZqE4K+fCFJqzZhxRl8+mi3ZGxedS8N4taPSfdKbxqpiGxpG8SQKmknd8gngu6mbk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893890; c=relaxed/simple;
	bh=5dXT5zFZx7tyIqtr8lCYyvpmc29kkA7AFdIpp4VU9Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLlQugnDUAxfS/DrK0pa9LWuF31KzqfqfzSK4ou9Y2aVguGdUqGesOAX2JHGJY4BvNi+e0pLcDMBvpYFRxbkRGRadyWuo83LLSU/uQWOOT24aJoOlsAU/ajZjEmOigMrQiDjUkXhtJnqjq5w/tt1dbEgsmsG+BkKAuBKY0aRdOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=gKF1N7Kv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="gKF1N7Kv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf50c6f235so5930345ad.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 18:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785893888; x=1786498688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s299Fhs4WKIhYcduu+EnoSm6nbyI7RdT+IYT+hOsyoo=;
        b=gKF1N7Kve+UKY0aNGgxbC24f5W0j8aoUL/zDlxZkCiiS4G9iV5otPX/6+ADzDISK0V
         z/TzyeMUGhDqTvsxPrOW1x2LSkhluOUB89hCohLHbYG2aRHHR275fEr0hHtXk5+xA4KQ
         nCmitoLUUK4qpybqG/oCOKTxQlOPoogqvpO7yMpcfDmIY4jBMvMWxmvGzAjZTF4AYRSB
         cG2XmyMaDZEvX2CRJIhSmDVw0FbEBrsy2RoT3OvcJ3m2x6QqXWEjfn8w2XxsA9xXq6sa
         DyOf47HFDGLLvt1p0lx9kcsnytXjhVY9RP9gLzYd5puDetRSFp8NS/Khtq6TZ994aUFD
         NlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785893888; x=1786498688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s299Fhs4WKIhYcduu+EnoSm6nbyI7RdT+IYT+hOsyoo=;
        b=q4P05+oD1kRQT7Mj79/iK9za919d3YUCkhyVkZBGulVxCKWVcVbVE7SieuUb6UwaHM
         6Y4Ij8ASHG8q6vJkMHMC7zjVqy/dbiR6s9c6TpsangPprGzJ1n01YvdQHzmHUzEb8AaX
         KkABjQ1qqz7XZh7fFvzYu0nnXUZ3VbJKtG2LZ7Yi7X6zAaEmVr8u1Tjfpz1UW24lAnSa
         Q6fDDb9D6iul/ZR+lV3OZK6qa0UtOwZIyK2ATaASG3TXFqQMrrpbWhvOACrXbV32nOdu
         1Qx2f38TADJ9QK6ibl6a2BTHFhUqdmzSHiDybjoVUk4xsbXnwi4viKX2e7eFRK60ifwz
         afsw==
X-Forwarded-Encrypted: i=1; AHgh+RqPZB5Y+qmL+Uox93vjLXORtg9k6rE0rN3pq1xkbxpvjeibhXi+8bfYYw4g1FG96qk6fFMmlfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrmeprLfEALeP6kN0gDxgT/3dT1sqJRSeif41jAtgm9ioWPoF
	UKd2MSlU5+BcHcPP0ziW+TS9Xc7wsWF78kBcnGeUthZCpKT2Z4+l4CuJfXlFJhy2MOr8Iua+ixY
	vvyKfzRI=
X-Gm-Gg: AR+sD13TqJpcus8kzj/cxDPmTgIDdfKuVvc6NB/p2rLsMxU1FXJ1J0AmwnueU56Jqk3
	+2ValO0poKM78OIR/nFTx2epSBs+M+dYiS1jYIcGRp87gOEGqVHUc2sXDkUXuSbOhxx0NN5DZAL
	pEgu8GOpB6oIYDyVeJ4HWzikAcSkcV08K0OwvJ6CzhtLoAyh9tR8l4UcnHMxxkXDVw/zhCRI1x3
	TmY3Nyg8o2BWw23mjH85t7sYhYHJw4TEdYCwA+aYsHhndAislMLzu2CLxSD91tx8Y9r8PCZh0fK
	t7qa9T2woog7l1VR7tQJZZQU8MpMAEWcO5/q+7jPbzguvQgfHH3heJTV5RH9sH+2qTOcZvaJCuK
	iQRS1IeIhA/pQjb28Ksz0CTfyuYMI84eyuWPmHvCOwtNd6UNwav0teVp/pnriXwVbVLWz5HYUu2
	gdZaIoz/DFHa/+sLgXWsfVwnOERhEQ1zciZ8RuOcrh2WWR53q7++CHFFruK31FRCCx4HshoWdZd
	ExkHggw2anPoWNag8zzyUdQIf7o
X-Received: by 2002:a17:90b:5112:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-3903c5919c4mr3048226a91.12.1785893888394;
        Tue, 04 Aug 2026 18:38:08 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39039179b07sm1138157a91.5.2026.08.04.18.38.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 18:38:08 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: g@b4.vu,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] ALSA: FCP: do not copy out an uninitialised init response
Date: Wed,  5 Aug 2026 10:38:04 +0900
Message-ID: <20260805013804.38839-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/usb/fcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/fcp.c b/sound/usb/fcp.c
index 6f5dcd35e1d4..8f52a3dc9ec3 100644
--- a/sound/usb/fcp.c
+++ b/sound/usb/fcp.c
@@ -483,13 +483,13 @@ static int fcp_ioctl_init(struct usb_mixer_interface *mixer,
 		return -EINVAL;
 
 	/* Allocate response buffer */
 	buf_size = init.step0_resp_size + init.step2_resp_size;
 
 	void *resp __free(kfree) =
-		kmalloc(buf_size, GFP_KERNEL);
+		kzalloc(buf_size, GFP_KERNEL);
 	if (!resp)
 		return -ENOMEM;
 
 	private->step0_resp_size = init.step0_resp_size;
 	private->step2_resp_size = init.step2_resp_size;
 	private->init1_opcode = init.init1_opcode;
@@ -1019,12 +1019,14 @@ static int fcp_init(struct usb_mixer_interface *mixer,
 		FCP_USB_REQ_STEP0,
 		USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 		0, private->bInterfaceNumber,
 		step0_resp, private->step0_resp_size);
 	if (err < 0)
 		return err;
+	if (err != private->step0_resp_size)
+		return -EIO;
 
 	err = fcp_init_notify(mixer);
 	if (err < 0)
 		return err;
 
 	private->seq = 0;
-- 
2.50.1 (Apple Git-155)

