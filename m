Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC364B04B4
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786308331; cv=none; b=tgS862Hdl5RWaGZ1IZt4Xg/5CwrXBEldvqSKRneeSi9xAbTZ4dPkgZ/qf83NRCE1DY/s2Xk6FD30qndWHTd4mlVYuwDlwM1kGbjeCQ/QcecK3mdhpBabZwim7XF9pgeL2FMYWwRa54piezhpi8PgH343eXLZWHlbn6vRfV43Ef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786308331; c=relaxed/simple;
	bh=MqTELALw9FxSwVjna8Koi05qShBvnZ0X38tR/exprJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6c3ZGzV6pLy1IgW7aqDCNY2OuwQXEFTxQJwq9cFbeqXDSfwnHuIo0rieJHxdt/H0S+IX9MEXzYN6UkMqs79Z85NoO9UclaSlc7Vaq6FyxuvNicuUsF9E11zq1M2a7mCW5NWssIY61E7aFApUeW1GRiaLOYITZvNXWZ+/LGeGiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MzmlEY6X; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MzmlEY6X"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so814091b3a.3
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 13:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786308329; x=1786913129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XyGxfjuoeJ32dis7pvONjDYcrymIUOl2huVjP6Wi2rk=;
        b=kK3qg+Cqb8UcR2v887JegOUTAK/ooaUo3o2H83rRPykUYQft5Q4zboeQhud6rLNKL0
         bsei7BOz333md53yi+jFCjQ+GDFgqDCyZjFdzVMisXriCjKGrd9dxrLFYtR8kx1INjok
         9QHK+c6BdzDD35ZdhOYbFMbg74uOiX3WRyksWffpzQ5qbQtN/W65HIlre94sHci94K0m
         UwwasZt5UWQN7zHNBdOE8o8RuznrahBg4M9x6Q997awCRXMwXpCdbwdPaO2YLAIdda5n
         refUBurAxx6U1XdCNFWuW/TuDkUqvUZbWOpQ1xk++rSPxvkkPGSLL47xLmnvwY5Wcv/x
         bwHw==
X-Forwarded-Encrypted: i=1; AHgh+RoQGltqszVUMxBm/H3wyYGq5CF/ok9Qps4JCQusqbeN4w8oq3oZmS7m42kfQHRsFFjwfdSRtUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhoekB5To/upLmOEsR+YwRBGVwsaUEAtmOcqGznbxFJypibKr7
	LG6M6c91o08PjRVcO3ChG8PmxTl9B6gVNYPOK6unE5hCAUiYt0MTf1hPSnhoPF14bfIAnNOrPY9
	+CHRV5m3hOwMtuBxYh/yyZM/uUlCow93tl+D/r8QpdFt1/Tq+Df/c/gigzjiaGcGjXuJnPU6jCK
	oYq6cC8bIQGHaLE+hQTRx55X34EPnj18yhAvV5YtqkAriN0K9dd6Ognrppv5EJqR++OoouEEzGr
	f7r9Gbo
X-Gm-Gg: AR+sD10eGIn4KyhM9nv7YcXVCG2MWzjrFJkpr/A6/UkV9/2JQr4ZzXHIvXqhkNZGHMe
	capTxtC5cT/np5BtbFS75NAqFwyS2ELpIUArvx+vp9g2zZq0OfWj3+3HFQZWtHrE14LXtfF3HXQ
	8OwSzVV1VbKTj4j9qmomi9e4/vAvIvtOb2BgiKpdtHSlZyCNlSpVl+1HwLDR9xI20qyG8nT7ZBx
	5+iMBsWVVjLAkznUOjlqK0DJDGqpAaOxGwv+PreV5xstWlEyeeQ66e0skjDkRIPi6FUUdn6Ey88
	CISCbLhurspqO/iOzqpy0+TiMmDi29m92wUFo4BbXD3s9/FkPCfR1xqeh5y2PF9hCWuR72hsStW
	TpdUfPoPjGygt0g42pCMt+VTgLAiefj78XY/34L9uODLHPsdVJhk33XhEoQV2yBrYBuiEVUaxsj
	NlzBU6EojtYpYYKf4Ufd5WYpb4q5wIDw==
X-Received: by 2002:a05:6a00:8019:b0:848:4a48:9f9f with SMTP id d2e1a72fcca58-84f4fee000fmr28436555b3a.34.1786308328857;
        Sun, 09 Aug 2026 13:45:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84f5a2215b4sm2094270b3a.1.2026.08.09.13.45.27
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 13:45:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21c01cf3so23706171cf.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786308326; x=1786913126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XyGxfjuoeJ32dis7pvONjDYcrymIUOl2huVjP6Wi2rk=;
        b=MzmlEY6X/fMpi5v2yZiadLfw51KoiMmMW9HcvMGaNmg3zaW0iYmsjg21ssapY+gizN
         dqvrsodUnJT5/vjOkpVRFcezo4iM44/wkxPvNwGcrQCGraMXT0lR+IMRnZgzLfd9i4Qy
         kbIE8ztXu7DwG4+oGyqWYgjFmjDB3K2FJGVX8=
X-Forwarded-Encrypted: i=1; AHgh+RpW+RKnQc9BM+H3Nwo5lS1+1D9aUCsQAnsvuT2DCZM+Gqpqy5PPUta6uDJi2O4ozODj4DlbCZw=@vger.kernel.org
X-Received: by 2002:ac8:6903:0:b0:527:7027:cc1b with SMTP id d75a77b69052e-52d0b220c2cmr284918911cf.32.1786308326176;
        Sun, 09 Aug 2026 13:45:26 -0700 (PDT)
X-Received: by 2002:ac8:6903:0:b0:527:7027:cc1b with SMTP id d75a77b69052e-52d0b220c2cmr284918641cf.32.1786308325694;
        Sun, 09 Aug 2026 13:45:25 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1659c1d8sm57920951cf.16.2026.08.09.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:45:23 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org,
	Youness HFA <hfa.youness@gmail.com>
Subject: [PATCH] drm/vmwgfx: validate pitch coming from userspace
Date: Sun,  9 Aug 2026 16:45:15 -0400
Message-ID: <20260809204515.211045-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Validate the pitch, alongside the box dimensions before trying
to copy data from the underlying surface. Fixes possible
out of bounds reads with cursor snooping.

Fixes: 2ac863719e51 ("vmwgfx: Snoop DMA transfers with non-covering sizes")
Cc: stable@vger.kernel.org
Reported-by: Youness HFA <hfa.youness@gmail.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500190..f4d14b00d7aa 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -324,6 +324,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	u32 box_count;
+	u64 src_extent;
 	void *virtual;
 	bool is_iomem;
 	struct vmw_dma_cmd {
@@ -372,8 +373,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 		return;
 	}
 
+	if (box->w == 0 || box->h == 0)
+		return;
+
+	src_extent = (u64)(box->h - 1) * cmd->dma.guest.pitch +
+		     (u64)box->w * desc->pitchBytesPerBlock;
+	if (src_extent > bo->base.size) {
+		DRM_ERROR("Cursor snoop source of %llu bytes exceeds the %zu byte buffer\n",
+			  src_extent, bo->base.size);
+		return;
+	}
+
 	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
-	kmap_num = (VMW_CURSOR_SNOOP_HEIGHT * image_pitch) >> PAGE_SHIFT;
+	kmap_num = PFN_UP(src_extent);
 
 	ret = ttm_bo_reserve(bo, true, false, NULL);
 	if (unlikely(ret != 0)) {
@@ -387,14 +399,16 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
 	virtual = ttm_kmap_obj_virtual(&map, &is_iomem);
 
-	if (box->w == VMW_CURSOR_SNOOP_WIDTH && cmd->dma.guest.pitch == image_pitch) {
+	if (box->w == VMW_CURSOR_SNOOP_WIDTH &&
+	    box->h == VMW_CURSOR_SNOOP_HEIGHT &&
+	    cmd->dma.guest.pitch == image_pitch) {
 		memcpy(srf->snooper.image, virtual,
 		       VMW_CURSOR_SNOOP_HEIGHT * image_pitch);
 	} else {
 		/* Image is unsigned pointer. */
 		for (i = 0; i < box->h; i++)
 			memcpy(srf->snooper.image + i * image_pitch,
-			       virtual + i * cmd->dma.guest.pitch,
+			       virtual + (size_t)i * cmd->dma.guest.pitch,
 			       box->w * desc->pitchBytesPerBlock);
 	}
 	srf->snooper.id++;
-- 
2.53.0

