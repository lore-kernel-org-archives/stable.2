Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF592347537
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947179; cv=none; b=mEMQZIG94dwT1O76ZKlV7CDsCBIxYMCswRWNX8/9sV/GJWGrm8K8yhvMbkIR3LXRX4R6VirS9fy5uHL80dFkuRTHUxTV1qPf1ooXTy4HNeJz5Djj1qYLEOp1Y/j21ZWibIYtKtbYOh9kIVMXXAKKzUFwxCbW18GrirwH9gJhPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947179; c=relaxed/simple;
	bh=gMALnF6/pN9knXQ6BxYbLgffxmxz79OMAtIKxYqvabE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGRgN6CHvHkNTPgG5U+IGMbnurBUCgagLIAyrDjH3hpxAjhKY9QMbM1/+HUZxtoIc+uvvlJs8MEixxYp3BXK8orNjWlb6bqVkf/QhUlz2LAWvpbFOoA+1N3FwzAIshqzjJASzpCsI7SUHxWYEMeYjILQzf4YgmSDIi/8Qtn8E9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b=TIvb4mRU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="TIvb4mRU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso82056475e9.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788947176; x=1789551976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ej2jXznQ8MiiebMcPklRSS9215NaFP0hQU6L/r3E0Cc=;
        b=TIvb4mRUxwuiDKCSIyzWSzpCnNzsy/tVIP+Hqs/dctX8E+gGBVUx9hwer4JCrWuIE6
         faLBqBnnqU8EV2I1nVaPsROnbXy71FBQ1F/UwxxGrCLumJb9UNWRx/XLT9kApb1d8K9T
         y1SZg8gZybnF+cdRxZgT2bwTwjY/ShLmmAT5zaO7k0/+j2FiiDLI88Mqk373aTTYiYJJ
         4MaSlVLYMXmTHF1IklCUuOxM/TJMqR0yeBzkRUsSvX/CovF414yorr1+rN1LlUOECQ+V
         1kEtSKRvsqM1AwmuZSc0cyQQpEsY5g9uzrf06pgFhN4uuN4EWxo6jR19ltZKMQ/mBllX
         kRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947176; x=1789551976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ej2jXznQ8MiiebMcPklRSS9215NaFP0hQU6L/r3E0Cc=;
        b=Bcmshy5nHzhBhkq0xcAnqEuRxdkrjku0+O4wmh+cpMusKkDvlKSXW9DzKeT5zsRpbt
         JPH6iJTUcUtcx7/oLtiCUO4XVSlRqRGRzTBmS757pjf6DFtCq+BUJGgBpvD9olfc+S25
         R0njOgqi8g7rU1aeOdPbvbFt2s6OKPOFtowE8sc5zPFCwVA5q4BbZx6sSeZ5bmEQOCZB
         W6FzPXzmdkOz3ABNncIkx0uIAQhsfLNR54Euv8tBjXpTW5sMPE+ZQjRxZobs9fm7UPQU
         dA3Ndf2ahEW6T5WdIAmvmM+vZ7v3bTCh/fNgJXDLnRFmLT9vOXElLb8x1vs48ogNEuIF
         B1ew==
X-Forwarded-Encrypted: i=1; AKwUvBzvJjxmjFj4tlgJVFW8ZfUofYQEcevJVSapODckOWBxni3d5hx7IQ+FXDjsKGh9qOppzQ8f88M=@vger.kernel.org
X-Gm-Message-State: AFuF++mSnti7QK2xIHMINlLnNUc0HleBaIZjkW7WJqOXJy+5YrKThmsf
	zRUAWc9R7H/ZHerXpe5QdAyXQNUm8sq8BCVa7X3yrjvbu9o0yY60SIxTh2lTVl61D0wIiXXN5f9
	axkEmrhj+
X-Gm-Gg: AYBFou3Wy6eeN5L3XqoUO1YDhmb8jhcuglDT40ZLFB7g1pWrlnfkFwEDcMA1IhWJIzO
	YTni1IoSDAqqspwSbTdtDMa3nDgICIzPr4Opbb2V3w2FthEPpa8aDExLraUmXvKuNT+rxzuMbKm
	NeskfcV+iz6agfER9scH2DGMUjQL5pykL/zv/H/UgfuCCnJopDoIASeCPj3lOg75+QN2zu90DuH
	EbYg6HvLncXfp/Q17BWgqocLT/G8oTfhoktOAHdG9ZeRT6CYG4VzuPq9ePdKRvZuGkCagkXoX4o
	+QmAaEKcdp+NHPDJJnDFLFlOaKNujL4JX76ETh0zlUWA5TJB+gnqJlonxsRldMqJww4g6HcJnbJ
	uLzTBRegGojw0E7NwuZoes7PRX4qlyEusD++XAgq4Sd9OPNzueQbTdmeSYftMXCsoIcnsqzXCVM
	O1ix0pml43TpSvr/ETK9VoAy0s5QzYAeu8sqRg3U6yxR62l+7GRMCmhP95kmubfFBlTqRGX/0h+
	zQaSTgvxgBsGExwwucOMM1UQ4w=
X-Received: by 2002:a05:600c:8b48:b0:49c:fff9:f684 with SMTP id 5b1f17b1804b1-49cfff9f6efmr260109905e9.21.1788947175442;
        Wed, 09 Sep 2026 02:46:15 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf772692dsm537897555e9.10.2026.09.09.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:46:14 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	kevinyang.wang@amd.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH v2] drm/amdgpu: don't migrate a dma-buf into VRAM while runtime suspended
Date: Wed,  9 Sep 2026 10:46:09 +0100
Message-ID: <20260909094609.1541-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909020854.58462-1-mike@fireburn.co.uk>
References: <20260909020854.58462-1-mike@fireburn.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
attachment, so ttm_bo_validate() can migrate the buffer from GTT into
VRAM.  While the exporting device is runtime suspended its SDMA rings
are down and the move fails:

  amdgpu: Move buffer fallback to memcpy unavailable

An importer on a second GPU reaches this holding no runtime PM
reference on the exporter, e.g. a compositor on the APU submitting a
frame that references a buffer exported by an idle dGPU:

  amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
    -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
      -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move

Only migrate into VRAM while holding the exporter awake.
pm_runtime_get_if_active() takes a reference only when the device is
already active and never resumes it, so it cannot deadlock against the
reservation held across these callbacks.  That deadlock is why
commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
when we attach a buffer" v2") removed the pm_runtime_get_sync() from
the attach callback.

If the device is suspended or suspending the buffer stays in GTT, which
remains accessible while the GPU is powered down.  A negative return
means runtime PM is disabled, so the device cannot suspend and VRAM
stays usable.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

v2: hold the exporter with pm_runtime_get_if_active() across the
    validate instead of testing adev->mman.buffer_funcs_enabled.  The
    v1 check was racy - the device could suspend between the test and
    ttm_bo_validate(), so amdgpu_bo_move() could still see the rings
    torn down.  Reported by Sashiko AI review.

Is this the failure that commit c52feb436539 ("drm/amdgpu: Disable
runtime PM for externally attached dGPUs") was working around?  That
commit explains how to detect external attachment but not what breaks,
so I can't tell which.

If it is the same thing, could the pci_is_thunderbolt_attached() ||
dev_is_removable() check there be narrowed or dropped on top of this,
so eGPU users keep runtime PM?

I can't test that here: this box hits the bug by missing that check.
The dGPU is on an oculink port off a native AMD root port, so
pci_is_thunderbolt_attached() is false, dev_is_removable() is empty,
and runtime PM stays enabled.

Reproduced on a HawkPoint APU [1002:1900] driving the display with a
Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
offload.  Without the patch kwin_wayland hits the call chain above
within a minute of the dGPU autosuspending and the desktop stops
repainting until it resumes.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..c89846f266d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -189,14 +190,25 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		/* move buffer into GTT or VRAM */
 		struct ttm_operation_ctx ctx = { false, false };
 		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
+		int pm_ref = 0;
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
 		    attach->peer2peer) {
-			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-			domains |= AMDGPU_GEM_DOMAIN_VRAM;
+			/*
+			 * Only migrate into VRAM while the exporter is held
+			 * awake.  A negative return means runtime PM is
+			 * disabled, so it cannot suspend either.
+			 */
+			pm_ref = pm_runtime_get_if_active(adev_to_drm(adev)->dev);
+			if (pm_ref) {
+				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+				domains |= AMDGPU_GEM_DOMAIN_VRAM;
+			}
 		}
 		amdgpu_bo_placement_from_domain(bo, domains);
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (pm_ref > 0)
+			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		if (r)
 			return ERR_PTR(r);
 	}
-- 
2.55.0

