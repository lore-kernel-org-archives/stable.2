Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82F40B11A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232279; cv=none; b=UXUdmDCtjt9dmHeHDTpnwko701CgBZUM+2eU5VT2zQ9afDyg24HrOSruzDDTK6gIP8O4UPhQUJ4L2GwdqVmM5bpRW1cRp/OU3NagBFg9pP0LBV9n/VJJbRSCkxfaMD/djobm2QrbUBB4pZW3XqAXVSHTmyo8t79AkB18I/NiIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232279; c=relaxed/simple;
	bh=ukvUDfcmPUk7z35xGpZVTCZMAIP2r1Bq5vGRpHJnqag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNMePcgSlb9Knuy/MQujU9CvmWXb6rLaSVym7p0Iy1GS6+hhrL1SAQ899TKuCtiUDerrOcEQmVh8zxLKCe4Zo4LtnCT8E7hZQAPfTeGkzrsKKAr6b25iribd21YsFRwpnVK8e3wQO2+Qhp+r9hDFIONou2BpTDwGU+3xmb/7SVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHWUJiou; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHWUJiou"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so544496a12.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790232277; x=1790837077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umxBSp7tBrSSHgI3ytYK5kk1etwT5sOaqeI9/AKYgrI=;
        b=HHWUJiouMdoGFisLQyZ3wctT5IGsCMbEjdPOceLYnELd6rqgcIYdD5kL/hLfgRmXNp
         6briAOWA7dkG7/aoRYLdKlpWPtQmzs8koJBOQGUuIwuK7nRwqmVKjQN1gjDxBMssdYcz
         LOr7KS5j5QZRZOP4ju/e1RBEzuqFxhuDeAEJoyWNrzu2p6j6Pr173o0f02tx3x/CETGL
         9SwgEytgvRcWQpay2gBGbwhSnVXZpltJVRBoRt90qK6Fl2uYi5XjKPDOQQNFVhKs8Q/G
         ZBXynt8S8Ir6ZRD1ngKxOYdwYt/gfkeZyRxRstjyY+J29gtpNsmCgnv1MJe5/RlNsh98
         tlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790232277; x=1790837077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=umxBSp7tBrSSHgI3ytYK5kk1etwT5sOaqeI9/AKYgrI=;
        b=u7v8PaSeT30KlRHuZqZkYpFT/ZII1q4ZBKrFOEILy8jFd5wRzYZFy8YaSqnYxlFTXL
         vi1Z2SUTx16YO3dSAxYqFpnGShMdUGivy+hx77zbJP4uXnVSdsDAdbTj2xDhtC0KrLwu
         xvuIcZMLvdR5IQqJyHUaZ2kVQy3fJjJX1+c78fZiQA+kLCi2mxlxuvl5Mb7SbZJdu8aO
         SiPrHYbpYiajee2PYYFAh8YI3pQBxfNFr14/n9pswjyxQfAuC0Oh7p/vzUL74tae5Koc
         Ch+uTVIsO0LbJw2AAoFVori6y6KvG21dC9gnTda6O8JhpwTlESm6OThQ4NtrkHSZuhRm
         U55g==
X-Forwarded-Encrypted: i=1; AKwUvBzcZ2uL1jcd+Ht1VeNG8KVap5OpfOAT+9NpvZ78IPpz4vGMzOKsk9y29XBaX3BACV/IZX2j34M=@vger.kernel.org
X-Gm-Message-State: AFuF++lKYb2m8p+bG4oD2pFxqZhmjhY9+E3VUL60er5MFA4Jwlro3P4a
	qvCulMYnhGkE48lKRoRaEQKYHciP1KdjqSi7dRJDqeCjQJyG+oirex0E
X-Gm-Gg: AYBFou2lqWzw//d7Y+4PdFqDcLHzvHFqNuzymvdNaKuWEvfYAbg5vLy9kEr5/Zr3DTc
	52zr7TKBqzrARg2lpbIlSuijsfwISHjFIn1lYDYpjts8bqAka5iuOyyBA0B2qivY8GIc9oldDgZ
	0WA4OxddQJPxh8S1an+06wgDOfAHVd26iic+ikub4sKXoNPmBV7IADlDavCwhVkHYNfeW8Q7fsO
	oR8MqK6MeQwlCNJgwNTNvXODLudhrgk3bst1ZH3YdIuZ39uX82XVXDVMubWM2Z/Ul2zjFHOePHu
	BItsGbh0FjqxMFhRaVRD3ssjKDXzc23D0PKZE61qGXkxnmP7yX9tQAS4ISurCWWKK+F2wJVQAqF
	v3aVzzLT41vCah41JD6fJDpKvSymSx2vLsPxnzUeyQYJoqGlKuTc0PZ7DRPr+3HUAkNx7XK6Ocb
	QZeiacwbM7KwEuE6wBOWdLjEB4IZWTjD+lhWes5oJHextYbUEQeBOPmEzd7QmfSyBW27ZJYJDmn
	3gXf5ifOhGgSubixMkNtS68u6cOqTXGjYDA+9Xc89Qxn5SuNEvPsRt8ZC122rwD+E8iN7fNcZ8c
	PKC5ui3OrQ==
X-Received: by 2002:a17:90b:564d:b0:39e:6c66:cbdd with SMTP id 98e67ed59e1d1-3a098acb900mr888044a91.21.1790232277226;
        Wed, 23 Sep 2026 23:44:37 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa0bsm2960830a91.8.2026.09.23.23.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com,
	tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 2/2] drm/udl: clean up USB resources if drm_dev_register() fails
Date: Thu, 24 Sep 2026 06:44:34 +0000
Message-ID: <20260924064434.2541959-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-1-benquike@gmail.com>
References: <20260919223511.3889061-1-benquike@gmail.com>
 <20260924064434.2541959-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In udl_usb_probe(), udl_driver_create() calls udl_init(udl), which
allocates USB URBs and DMA buffers via udl_alloc_urb_list() that are
normally freed by udl_drop_usb() in udl_usb_disconnect(). If
drm_dev_register() fails in udl_usb_probe(), udl_usb_probe() returns
without calling udl_drop_usb(udl), leaking the allocated URB list and DMA
buffers because udl_usb_disconnect() is not called when probe fails.

Call udl_drop_usb(udl) when drm_dev_register() fails in udl_usb_probe().

Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd by simulating
a registration error in drm_dev_register(): on the unfixed kernel,
udl_usb_probe() returned an error without calling udl_drop_usb(udl),
leaking 8 allocated URBs and DMA buffers; whereas with this fix applied,
udl_drop_usb(udl) is called on error, freeing all URB and DMA
allocations.

Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 2/2 as requested by Jani Nikula.
- Added testing details in QEMU on drm_dev_register() failure cleanup.

 drivers/gpu/drm/udl/udl_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 1922988625eb..239a6983f49f 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -97,8 +97,10 @@ static int udl_usb_probe(struct usb_interface *interface,
 		return PTR_ERR(udl);
 
 	r = drm_dev_register(&udl->drm, 0);
-	if (r)
+	if (r) {
+		udl_drop_usb(udl);
 		return r;
+	}
 
 	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
 
