Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85154B1B4
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653238; cv=none; b=WHa0bSZQC7oVk0nw5wl+Gy91cMOX9s1VikksRjBXCaH6d5w955QL2NY3m7FMUnOe4yH+bQxiQMqTC/5Gj5u4IWB0nrJ10vC9QPi+0RSXSQ7kNH41lLBPhIZa543Wg/0EARw27yzezn22be4JCdt1NWG4OkvJ2sZe3QFI0JGW1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653238; c=relaxed/simple;
	bh=mfzetHJUn51ArerYHqF6aiA8NuXaOVldE7r6LWhO0uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5F9tre7fr6NKBdwPeL63mRek44ZQUN6glC8EG/HxGfJoNWWZvxRdI4HCOjEq7JdJnEkAXAi7Try33/IJgNSAeTf5Y1DkVBBAwgHX7krF/dl8FGPB/WChUA1jIBfd4T/faFUPqM9KUWMlAUpkMow1InXsTTWyzEnBKeNME4CdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En7S3FAl; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En7S3FAl"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2dd88a115c1so9216735ad.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789653229; x=1790258029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNzuklJ6syncehvRtPRFyTK25DIYgkrFQvB75keaveQ=;
        b=En7S3FAlvb7xVAltzwxtYNx6weFJxSA9G721seTvYqMG/5AxdoRiOV4uoXMN8E/5dT
         PY5h60hPKDNjabO8buj8Ilq4c33Uo48tIAQnqnox34Cp+RdePYdm5VezPfZSsa5YWYsZ
         EUyo+MpLRAS9Lbl2t5VRWOzxtOdIArs7tGYgVWyurAKMvLPZ9RuV7NjM0IXMfa8g4+RZ
         bOojSlI5lggddrHVadGBi7sy0rQ0zgD1MysNrvb/+KavfbHSmFBtAa1u2P9JY6CbYefZ
         CoZNUoy7xCslO0s7nwgFqA/B3YegNZqYU5X0K8VEQhg1NANIJbXvx3ISm74IvEK792no
         bKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653229; x=1790258029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNzuklJ6syncehvRtPRFyTK25DIYgkrFQvB75keaveQ=;
        b=HlZTCddiVoTr/xffSWazQpW57I5AVHn3qdBkXA/OYlGe8ocRbVCJigoZLsde2JVb0S
         fIQwls+uTcuJicutaqp96hJRxnQYuCHOQfz44Y3OP6X3J33bIb6ETAfJZB2xK7OKoXrn
         BMvFa9YKYNkGmiv58p/fOm6CdarRU4wilnMX8dJWBagKo42w6qqLOaWgvLi2wdSdimW4
         HsEl4GRt6H75WeG88ZEsS6WQmvkI628MxUqjMg5bMPJIek7BoDb2THlXJLfSGqP+opdq
         hhnMMS+OWSyHtt+7cFm30jds4i55PdW/KdkJiwDFZrNYuGaTqqwYfnECPUx/jOrIhyZO
         +K4w==
X-Forwarded-Encrypted: i=1; AKwUvBzUyKVsazuabxLIlbhsI7/bkva/o+HOzIM805ao6mYcs/CRqcvnkv1XzSjzA+Mxf4cezeY6YZI=@vger.kernel.org
X-Gm-Message-State: AFuF++mbh/J9oRORVV5cTCSiCgKGjQL5rrbCtbLdmbzjYgpbHWB/+Lbn
	ZltHH0XkOyEWZW0GSD2LmSegKA8gELaCarBAqTUefA4iM6FEnwdIdg7b
X-Gm-Gg: AYBFou2tzxYevzcu6HjRh9yigTM8HIPoF5Up3KFpbVsYGA86zi8DnfayMhVLH1hb8OM
	cmRTvNJXrlYN3KapiqBZlxX46x0wk1fNnfo3ZW4nmdy3oig0K+Q0aXUOgM4x1VLfedzhw7jrt12
	sL6xospN7/MzMzE0k7NvyMgYvoPos20FAFfhzcJHIL7LL0Sxz6rUMeM07kGcbsO1P5kLgdNcTas
	/YsTW7cOuzuKdrEA82QM4q9VWCMXL6lDfPwd8jsazIQH6tnKLmRLUqa+Ep4NzcBm4c3Y2r4C2Jy
	uefNyWhHqVzlIASwiy/taCYSXR1+BezoPTTDLYXJesp/I2HkXTSON0iZRRRhL6dAEoKTppPfSAb
	zK/SCY5dqTdQVJdXxJEP956k9a6+WiSh8HfSJZpIETCQWSGPDg0ngxq0dAEsvPVWft3MnvSExH0
	h7lNddZ/dHFjqdkFOVa6SB8PnjrtEUpnQbscz80wOfBtBXstoVS2KRTZ7Wa1eDwhuB09uIclosI
	Rn8x2Y+9KnhIqVZAu1hCq9cGGi1IkRZDQ==
X-Received: by 2002:a17:90b:2ec7:b0:39d:f317:44cd with SMTP id 98e67ed59e1d1-39e1e4907f3mr22997029a91.14.1789653228453;
        Thu, 17 Sep 2026 06:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:2428:17da:9062:91b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e360ddfc2sm5303334a91.16.2026.09.17.06.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 06:53:48 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Nazarewicz <mina86@mina86.com>,
	Robert Baldyga <r.baldyga@samsung.com>,
	Felipe Balbi <balbi@ti.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] usb: gadget: f_fs: Fix NULL pointer dereference in FUNCTIONFS_ENDPOINT_DESC
Date: Thu, 17 Sep 2026 21:53:37 +0800
Message-ID: <20260917135337.65444-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917135337.65444-1-ndaugoing@gmail.com>
References: <20260917135337.65444-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user space sets up FunctionFS with only full-speed descriptors
(e.g., flags = FUNCTIONFS_HAS_FS_DESC) and the gadget operates at a
higher speed (such as USB_SPEED_HIGH or USB_SPEED_SUPER),
config_ep_by_speed() detects that the function lacks descriptors for
the current speed, logs a warning, and falls back to full-speed
descriptors. The endpoint is then successfully enabled via
usb_ep_enable(), and epfile->ep becomes valid.

However, when user space subsequently issues the FUNCTIONFS_ENDPOINT_DESC
ioctl to query the endpoint descriptor, ffs_epfile_ioctl() selects the
descriptor index solely based on gadget->speed:

	switch (epfile->ffs->gadget->speed) {
	case USB_SPEED_SUPER:
	case USB_SPEED_SUPER_PLUS:
		desc_idx = 2;
		break;
	case USB_SPEED_HIGH:
		desc_idx = 1;
		break;
	default:
		desc_idx = 0;
	}
	desc = epfile->ep->descs[desc_idx];
	memcpy(&desc1, desc, desc->bLength);

Because user space only supplied full-speed descriptors,
epfile->ep->descs[1] is NULL. Dereferencing desc->bLength triggers an
immediate kernel NULL pointer dereference panic.

Fix this by falling back through lower speed descriptors if the current
speed descriptor was not supplied, matching the fallback logic in
config_ep_by_speed() and historical f_fs behavior. If still missing,
fall back to epfile->ep->ep->desc (the active descriptor), and return
-EINVAL safely if no valid descriptor is found. In addition, mark desc
as const to match struct usb_ep::desc and avoid discarding qualifiers.

Fixes: c559a3534109 ("usb: gadget: f_fs: add ioctl returning ep descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: zjamg <ndaugoing@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 43962e05eacf..c64a268e98a4 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1877,8 +1877,9 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 		break;
 	case FUNCTIONFS_ENDPOINT_DESC:
 	{
+		const struct usb_endpoint_descriptor *desc;
+		struct usb_endpoint_descriptor desc1;
 		int desc_idx;
-		struct usb_endpoint_descriptor desc1, *desc;
 
 		switch (epfile->ffs->gadget->speed) {
 		case USB_SPEED_SUPER:
@@ -1892,7 +1893,17 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 			desc_idx = 0;
 		}
 
-		desc = epfile->ep->descs[desc_idx];
+		do {
+			desc = epfile->ep->descs[desc_idx];
+		} while (!desc && --desc_idx >= 0);
+
+		if (!desc)
+			desc = epfile->ep->ep->desc;
+		if (!desc) {
+			ret = -EINVAL;
+			break;
+		}
+
 		memcpy(&desc1, desc, desc->bLength);
 
 		spin_unlock_irq(&epfile->ffs->eps_lock);
-- 
2.53.0

