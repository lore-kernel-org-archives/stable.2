Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F90448CF1
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458556; cv=none; b=O58SKtwZLud6N+I024WuXafBpUhKujpl/CoNL4tIOc1r3BzgG9xpSnvh/uFh/s6GWkXQHrXx4VFGSNAjIR75vijxKXab6nGvGGDwR9O+jrbauEHS0tXwUm6pensytFF9KE65bdFf/COhbT7O1+ZGHW+JOSThlP+/KCPtjEnBFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458556; c=relaxed/simple;
	bh=Ms56ytpwHSeFHdp6KwntU4e11PGxIQxSST+kpBvVKeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgdc+d60j/Brpc4wfcvhBb2ehnj43IhdbgpqWdB1S+bh3otQyE5VdxTDUrfxM4jKc7YyGA5RaO8dObcRMijjnjJJT4jrQ9qC0oiuVxOuNQ6WReTE74d/aGkvb7OkMdWdw9mLSOJywYrzJsd//a3yR400tiE4cFpWu+bO+JVu/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ9Q/Mez; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ9Q/Mez"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2077566a12.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786458554; x=1787063354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAc0xtFPkF9VlmAdoL5DiXZFcBGbk3oumqjK2pi8Bpw=;
        b=DJ9Q/MezLnCkApGg7vVhsfClUAQQoGr+UjMnOcP997gBJcXphuejaI+/1l5Vqrww9I
         3YsS3ozpT0WSY9quf4gaCzsnJJx23QXGasrKdcod6P0W92VoJzPqnkCwgV5FFNb/S/NE
         7lcH02eVfSiB++SfWIlm4IlSk5NPD46oKw7rRVYCqqp/HFXGJBN0DK6lZ7b27Qo1zRz6
         HdpP6JAZejV6//ISQmu3WqEJqLsJOZYwqezVvajriNIt84BnPs23D2tL0RktHhmV5XLI
         KETkr9HCblemiaNxEWAkdeKhUTDyIQa9YJU+gVJvlZwgSrao7PsJrsoyYdaO8NwpYpSp
         pEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458554; x=1787063354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAc0xtFPkF9VlmAdoL5DiXZFcBGbk3oumqjK2pi8Bpw=;
        b=DgieK9G7hQKgh/K+VSR3LBZfs2bVLAuk9Io2YZ2VK0t4D2ikcl1VF8M6qWykSspqN4
         AKxirFMZKTSbi6+ezz1egzlwMOTAh8xMZVVBYF8jTDAyGNQEajG0Yaq/ed4zlaxx0TUr
         /7PckwauV5MeXiQH5drkjQRQrVqO6Xj+VdWrBsghMFS8L1Mqyu4CPjNzfOs7FQgI2K1H
         lfsai0dYG/tb8cYhlI1g3Gpg3R5v/n+Vy7N2WH7tkDBFlHPfwRoGKkWL1+5MXHNdQQHF
         rzIwljM0zHIDEMppH5pYrdcGZe/CBjJeYAN9dc0fgXGsW7nkbPrQGWdUveTe3lrOdMLG
         GXWg==
X-Forwarded-Encrypted: i=1; AHgh+RouPLwrB/mLrpaiytJKyMZyYlINQnxIz1sI1cU+vI/MjOh3iWxoBtRvlnHM2IzCRyeeDsl75Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6i8R9+9fMqH1HWbpjM09EYD4ZYMw4DSRQrQXuh85fl1wPpVx
	7g6EzVGhE2csWfVohufBLzDrGeh0zQnLbQPVahqBjHCTcrViUrIs/pEL
X-Gm-Gg: AR+sD12FOBuUHx2lB9sguwgyXQs24VaADrMpNni+Dm6FqcyQsKiXafG7VO2I9XAwifC
	hiPb8E5e2bHInXeRUWnChke/rGYnj1Al8aV7EzCia8Y33qMYUdZK8wbaWPQ8MuO6YgXn739ng/9
	yqpkRNTnMoj3kBbCHZO1xgPb0VcMFPgGWzMox5lAf2E2W8qcnhZpvyJnWC4ytEkIiq7KmJcDJ1w
	zfsSlibZFY0V2bcopwk8r1C4SXKusbA2zHgmGpPMVxx+p0J0gxYLQoruXKbY/+AuTijTW3vmXE+
	q8ebIa/SHkq5UKWbrGh165i9y5FwXS3AdEPGMdcQT73N+nJLRhlMi+yEDeYiGIlXg5IT4GcchO9
	hT1dlrrExEIno7h76Zwaf+VW+JT0ghXnJKtw2NH12KktDUfyH1Xg0TkP8RdB9cytfEvXAM8cEEP
	yh0qsOK3xy3uFNmlSwfUf74tRtbvIuuB/nAYppnm/tZSVAcbW3pLwfhQgS0gw=
X-Received: by 2002:a05:6a00:3d52:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84fa8686d9emr3316247b3a.5.1786458553736;
        Tue, 11 Aug 2026 07:29:13 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa954fc8asm890209b3a.50.2026.08.11.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:29:13 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 22:28:50 +0800
Subject: [PATCH 1/2] drm/nouveau/dmem: fix mismatched DMA unmap size for
 large folios
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-nouveau-dmem-thp-fixes-v1-1-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Balbir Singh <balbirs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786458544; l=1970;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Ms56ytpwHSeFHdp6KwntU4e11PGxIQxSST+kpBvVKeU=;
 b=J5mecMWmZ3choz70xb/rBRDm8mbs+xBBy0WtROvpD9chGghI1Y9qX2K3DiSCMBIRSYRdUvbwn
 J4w19x36HDnAC44CAx0r8knwMUTbJhDgWQGJ/Qk8KO7+ukM2tsSaLMa
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Device-private THP migration maps migration buffers with page_size()
and records that length in dma_info->size.  For a compound folio
page_size() is PAGE_SIZE << order, but two teardown sites still pass a
literal PAGE_SIZE to dma_unmap_page():

  - nouveau_dmem_migrate_to_ram() on the success path, and
  - nouveau_dmem_migrate_copy_one() on the copy-error path.

For an order > 0 folio this unmaps less than was mapped, leaking the
remainder of the IOMMU/IOVA mapping.  The other unmap sites, in
nouveau_dmem_migrate_chunk() and nouveau_dmem_evict_chunk(), already
use the saved size; use it here too.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 9442ec6e1f6c..d2abee3efb9a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -267,7 +267,7 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	nouveau_fence_new(&fence, dmem->migrate.chan);
 	migrate_vma_pages(&args);
 	nouveau_dmem_fence_done(&fence);
-	dma_unmap_page(drm->dev->dev, dma_info.dma_addr, PAGE_SIZE,
+	dma_unmap_page(drm->dev->dev, dma_info.dma_addr, dma_info.size,
 				DMA_BIDIRECTIONAL);
 done:
 	migrate_vma_finalize(&args);
@@ -772,7 +772,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
 	return mpfn;
 
 out_dma_unmap:
-	dma_unmap_page(dev, dma_info->dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	dma_unmap_page(dev, dma_info->dma_addr, dma_info->size, DMA_BIDIRECTIONAL);
 out_free_page:
 	nouveau_dmem_page_free_locked(drm, dpage);
 out:

-- 
2.34.1

