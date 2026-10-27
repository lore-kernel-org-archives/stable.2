Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135871;
	b=40XDQik6PDKsb07LfFJQiGfKzylOUqChzRkYctGrkZAuU0M9v9TrifHUcYyefC29sesv
	 s1xPSb2SXrn4BWdIBGGA88NmyjywgnfJVvMse32mD0B1BCBRbWNCXvrarbkrlJgWz4bsa
	 6l3saMG2wulkRxbepF1fnrT92lCQLDdCT7uVCcLbnRdweVWFv8bSPAU4nETA5pJqlTPDW
	 wU0kusGev7JqG3zaAPBIPdO+7n6LMpCJ0AhQdxpCcw1M3YA7npcm8yo5WkNsxzx27CMyj
	 o+aV5/JdWVWxdFLmfj4yPLnQLbmHyPaYgnj3JU00DLl6BODZwF9WlPiY+tuvETJrYTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135871;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=lgbyT6PeI2khIu3G1MvqRPb/iNuJirnyDT1hctA+7wQ=;
	b=PwGCgQIxh2a3OPJTU/wrE3kzLyBfQqcp35Vy6neA2RzqFkWr54LiBnA3BFmbewjwkwd2
	 ma6joq0ZL4gvUE6qDzQDI57Tskjhympi9OGD3WGPMnytTVuL+jx0/jYlQyUFG8zffj3Kf
	 OMc2kq2a+ugh2J82qxXZh0Dcs2NwboG+M6lBDG1uBAzY3jGe5aFWadXTDQuZ5NXVKUTel
	 BnaDDeFnB4fMPuN0YYlYZCVfjFhL/+2FRNfPLfmOITsrr8vAN/Eka7SPMv5tt3BQLlePm
	 DcsLubuivOFNAjBISxmAKyPUq+D4JQ/s/83fL/HyxCkPx4Qr55NDDdW0eo4N/pgrkDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=b8pWdd6I;
	arc=none smtp.remote-ip=209.85.160.228
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E2606A325
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 180E2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=b8pWdd6I
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-533861a59b8so5264021cf.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135870; x=1793740670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgbyT6PeI2khIu3G1MvqRPb/iNuJirnyDT1hctA+7wQ=;
        b=ad/pu7mw26v4UrhRRsMqAC/flRJTLBIoJJbp7N+kmoNKyUsdxFVjzR/8B1KEviApuj
         wSFNEodOrmIxFg7uzsmBevk9J+abPCQXsVQpPcPOz6jlk2IpqovEhP8YheVHA8SE1Gr7
         uyuMuwmRbEgNgdehl/J3tbmS1n3zeZy4LS4i5oX8I4cRArvI6G6G9odxaBRx+ORDOMfe
         VWsh0s1OOM4npYCqdRAO6//Au6zXMIIgY312a4XZl5Xjt1ePv2JH5W5m/Ge2yaRtDfz/
         vGYGyVYRqxxxwd21FzSMg6+UU/gpvwzetDMe3s33LduC6dth8mMPLi+4wYnJYo2lE7Hn
         iAew==
X-Forwarded-Encrypted: i=1; AKwUvByo6Qf4hRHIvzosV1/Fi3y9FEL9/U/stESro+9ye5SVh6y0xC3jJdyMqBdr08gNDGydzQTbVE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXuGGbK7t9q0q26SQymwYzMayPT29jtHNuRIf9IiabEHW+7DgQ
	4DucCnDRROmcUjv/QVHEYmQVchhk4QLp7clZzKF8ujtqfEBNgbb72J2qT2e/GMFgX+zRI5f4wjI
	JvRDCSlDNiPRxOl8o2EABeuJ3R8mNBPcop9EKvZg+ErieLm4zgPIGyTRD9CAnWtFG5PrMLX3nfC
	Ux8Ak+WvL4wPaEWY6mV/nEeMMeHW2bUR1N57ZMfmkJ7Rn9mUo2ElHyqCqIcotlIOVG8d+AC95Sw
	r2rDy2C
X-Gm-Gg: AYBFou23k7CMPUNobPG5z71onF9T9h+wF+w5NYTKYv3JeUgxEzAiDCzAS3WqJyJ8ErP
	RJDjgI5EJxhluhGpjZpM8IbOx3zZnVNvhzEkFNOB9eIH3CYoYmH2hIpLVGAbb/n5Ng/WvsnHMoA
	zqV3SGVGhcvFcy3I4Uwb2WEwHSi62S7pdLrBx9Mjt2Kqrvw8EObYz4mvbjTko+lSU/+IU4AzgJy
	KIyYg51b1rIvgIW3iFoaXXIU6oaYQHgP2vVZ+gTKQFWheRKSF61pT4mEam2nog8Q92f00fIXVQY
	gTfOQi5Cy7W65V3p30s98RlfkdstAkUSq/h5KG/8uLJM+WITZruqkayb4zxjwJBXWqcqv3L8Mkl
	mbHxC/ygeCBkT3TNEU4sLZ9OazzI7WLuuTh1WEL3MwEB3hLq3fjTDTZuZPfBzyjk00ZEz2D7T8Q
	PtTEPXohTapre6EC4GEZgB3mBP2GoDAxtX
X-Received: by 2002:a05:622a:506:b0:536:66d7:8ccb with SMTP id d75a77b69052e-53fcbfdee70mr10129211cf.51.1793135870046;
        Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-53837fa712asm787921cf.20.2026.10.27.14.17.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a1e2485fdso644461eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793135868; x=1793740668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgbyT6PeI2khIu3G1MvqRPb/iNuJirnyDT1hctA+7wQ=;
        b=b8pWdd6ISZUAdc6U3o5WKgykXSq/dddJVOD/aIriuYcVu7qAwd72w4lwv5t/S8iCdB
         Ad3dOJX6wIZy2PzbxGkyiUni35v6T2g2zLPR2TRBhMVlQ4dRCz2AXR//mZk5JLl2UvTY
         4wd+poPzPv64FznhCctCuFKqHnJDWtIpnTdkw=
X-Forwarded-Encrypted: i=1; AKwUvByoM15FMeZ1heuoEgnFXYigjEdeDvt427L1r8ASMpYn/d9jHje57oskr2V58i43T8XM38E7fpY=@vger.kernel.org
X-Received: by 2002:a05:693c:41d7:20b0:367:3d68:8480 with SMTP id 5a478bee46e88-36a20115c41mr798414eec.0.1793135868001;
        Tue, 27 Oct 2026 14:17:48 -0700 (PDT)
X-Received: by 2002:a05:693c:41d7:20b0:367:3d68:8480 with SMTP id 5a478bee46e88-36a20115c41mr798388eec.0.1793135867298;
        Tue, 27 Oct 2026 14:17:47 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:17:46 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	yunfeng.li.nb@gmail.com,
	tomas@slax.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] drm/vmwgfx: reserve dumb buffers while detaching their surfaces
Date: Tue, 27 Oct 2026 17:17:27 -0400
Message-ID: <20261027211729.646988-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmw_bo_free() detaches the surface associated with a dumb buffer and
clears its guest memory binding. It reserves the resource, but does not
hold the buffer reservation required by vmw_resource_mob_detach(). TTM
releases that reservation before invoking the buffer destructor.

KMS clients destroying dumb buffers can therefore trigger the reservation
assertion from vmw_resource_mob_detach(). GNOME reaches this path through
DRM_IOCTL_MODE_DESTROY_DUMB during cursor and display updates.

Reacquire the buffer reservation while detaching the surface and clearing
its dirty tracking and guest memory binding. Acquire it after
cmdbuf_mutex, following the command validation lock order, and release it
before releasing the resource and GEM object.

Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c0b0dc..a6d7156e4281 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -55,6 +55,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 			/* Reserve and switch the backing mob. */
 			mutex_lock(&res->dev_priv->cmdbuf_mutex);
 			(void)vmw_resource_reserve(res, false, true);
+			/* TTM drops the reservation before calling the destructor. */
+			dma_resv_lock(bo->base.resv, NULL);
 			vmw_resource_mob_detach(res);
 			if (res->dirty)
 				res->func->dirty_free(res);
@@ -62,6 +64,7 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 				vmw_bo_dirty_release(res->guest_memory_bo);
 			res->guest_memory_bo = NULL;
 			res->guest_memory_offset = 0;
+			dma_resv_unlock(bo->base.resv);
 			vmw_resource_unreserve(res, true, false, false, NULL,
 					       0);
 			mutex_unlock(&res->dev_priv->cmdbuf_mutex);
-- 
2.53.0

