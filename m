Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F54322FA
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235016; cv=none; b=vEpTvwExj/r/kXJX4vL//v9KL80kMDj528uRNWPDbdVtZQOTKG9W4SSljS9la6EVTtlwP8n0UgQYd2P+cbt9sizUsuXoe/jBSZbWK4EuEbnHE/ZD9RuNyDfWd19oZEgqFYw9Tmbdv8anqfzMsMmtbQAybzViDsXDfk88+CDFCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235016; c=relaxed/simple;
	bh=H/09Awy0Wow8he0iuUjbYNtLCcgE1/04W5EuWcTgx88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJSqxH2QuukEPetI2h0xZ/GIi7uVc3a+g/IAZ/uMIS7fKKJrUfcSegsZvZYaRDl4iIL3p6+a4lAGhfbwzEEvdp1X3dt8qb9dq6jz14CVnAsqFxQoEiD7hH5uctuYiBWO+YpZPpoJTCokloQZ3dOiZoT5iHu1eG1bZH4vmYTmhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz3yf/vj; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz3yf/vj"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1218344a91.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235015; x=1790839815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6F8IvUZIEGfXb52LcJZy68sW3q/eTCjBvXuldSNAIWg=;
        b=Qz3yf/vj2mxSLDysJ6S3tMjKG5yx0TjGYFrH0PBqJfxa4+BL5WuyiKKu/gsvMzrl3x
         ABfpThb97VGkYmgUyvZnu/P36EQYJCAVGIOIV8QKbWdwH8LHLp3x0OqtopxZ6/bpGnkP
         Vqo0SfI130sGvzlX6Dzk3X4I3ECOqwghNWdXfw2D3APlNPX7lOn9QKwOcB6dAfAX1s/D
         NEeTByo7QrUeBBE17pfK8HJH2MXMxPIYrLJ8KMWg936hMV0XNbdLF/aGb5Y0Xzsvzeq2
         blBrtAJ+2UnzWw0axl3HHw2nzgx3Vyut917pdIsg5W39JZZ3vDQuqDJV1OpB5Tw08oVi
         T2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235015; x=1790839815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6F8IvUZIEGfXb52LcJZy68sW3q/eTCjBvXuldSNAIWg=;
        b=nXELHmZyAwUW3JeHX51PWTz3tJB1waOkC3UOTurWvDeg2Gf6fQmICgC/5Ay4nnnC6E
         qK+U8y05+rWt2YVnMVEckwTezZ7GwJrhe0+MlhNfd6OVhIG+vynJRn0cOUSq2aXxT4rB
         cX9FSWjq4l0vCIY8Wiy03XsF5OhFDFwF2SVl47VNYp2VyNfreDswiDvz0M7M+1YXvOf/
         TiVomk4qtGNYmwe5Sn1sDGenjiBT9oDyyT+8XItP0LTwayYp7xcGMJLlgJWFZYITbq4e
         V93jLSobC+ZfAPW7e0eQ9j7dbrHisWMJ7oAR4kE74POBi68E9JQKsk8CVFymZKdES/eB
         LqlA==
X-Forwarded-Encrypted: i=1; AKwUvBxgFBbWSDq+j3Mz4c+/9diP8nWXMIvX72hmEg55xaK4BDi80Vxt4bpiihQuNpXOIWj5lmTCc9U=@vger.kernel.org
X-Gm-Message-State: AFuF++kMnYRiWF48SK3mamPXJZF7DnifFriAfHzYV++0JDy60AZBEave
	Vzb8g57Cn9KKQhTUgc67UKHrbYs/It9HsXzhHWyqt1ZPN90BArJvEWzh
X-Gm-Gg: AYBFou0ulSNfpQk0WSt+NVGJb6bRUhlepZqEJyf90YryIE4ncpcvBZ3CkHGcksTkNuZ
	yX+xLF2bgKOXCYrQw9OrfztHCBPAWWLvyensrjKwvVjJXaLoUN7N4y5u06T09Dvi2fu25yC9ecm
	8kvne+fApq5OxLMgK5UkL+N3hbUNQRGW7v8MyKjxelUNmSs1UJFeZreZ9L6HGz2rwN9sKBEbraZ
	tx3GgJsG3Vr39w+DFCGt5jSU1NttLDB04ko6wirMR8jO6anrY2CaqOKAAyODhfXkf9hDKkRaTWl
	w6AapR725uymF6bNc9IgsBDmTuf4kXDqV6HDf+pwXf6/CwYCxNZB9C5+11TzI8ybiSKkUYLBKLa
	/eAZayOl8XioP/T9hanfMmBpOTJLd1BfGuVJwpycio8Rpt480Gp00Y2SRhc4pCx+j+PHxnHfxq3
	zLKKJ9ZJQQmj5KStXTPGnMDX51PVBTqKv/a5FVOLWgzrLR+tkFtg7TNK1JBzkSU8Na9lNSYJ5DA
	ms39JiiIawW8vHl6+lteRGbsef6on6Ce2Wtn0HuYos2oGvgPe4j+KWSuV9fQKxBbjXYmLS3Plev
	PY8YRNMnjQ==
X-Received: by 2002:a17:90a:ec88:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-3a098b4b35cmr1393507a91.19.1790235014790;
        Thu, 24 Sep 2026 00:30:14 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa0bsm3184726a91.8.2026.09.24.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:30:14 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/udl: clean up USB resources if drm_dev_register() fails
Date: Thu, 24 Sep 2026 07:30:11 +0000
Message-ID: <20260924073012.2742968-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-3-benquike@gmail.com>
References: <20260924064434.2541959-1-benquike@gmail.com> <20260924064434.2541959-3-benquike@gmail.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Reviewed-by tag from Thomas Zimmermann.

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
