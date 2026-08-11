Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98F2931C3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458551; cv=none; b=CFVvBRwFb6OI6e0SDNYIKfEMCVQj94F089+Datmg9bpwu35rgzI8JGwPsMSXd4jUyURlWV5LS/krr4VVJy82ezZPu4gXpNofQIg14DbOoWnD5w88OQENXbGaByOfHfNg9gHO2CQCSU+f0Lan6Wsix1zfOCRRDavylbOd9sVysek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458551; c=relaxed/simple;
	bh=ZMKglCqVFXjvtgIXuZifnh47ei+nnVi+BRmkcnYy+sQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pz0BTpL7w53Ndnu1OTBPlVqE+sbBsvk4nYY4132V69yeZO/VCYeZ7QAJ8z78yGmefGi0HT+FYBRZQeYkOQVuyGnRCf6rWk2d3ljDpsC0IRC6osvNw/ZI+vVdUaZGVGnvyzxHHMBYj1vvGOHmOJAZM4aUHzJkAR8P70pSg/8QJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlHaDTGn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlHaDTGn"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so946222b3a.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786458549; x=1787063349; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QkL6quPpYZOmrSZlgR7q8t7HlM3bpCXuTHsi56o560Y=;
        b=XlHaDTGnwtcAeIrTA9Tb4LPZQ6BPgYu3YtJ4yawxOIeldm93ZV30tRjKsn0EmfKow7
         xD0F3crhDmfHILmgbl+RIaxaFNqhfBJC9zOzG1h8HcSOwXEtTm9gIawOeA+BPxST5Eup
         tKIBJN93xfBKwPimvbBsyNVWRybBiKoaKLCb0g+KzNAuhP5FWV/pq6zoPdxMWPynD0W/
         z7TFKCcNClldB5Ip//SIYymf75GNj8jpkpnf3/FGGP7c/Rz4ty/mtql4OL++Ra4xjaJ2
         8H9Im+wrOaGJE13puZuVQnJG0V2IOT2b/qFCbml1Wt4BRE0bYHu7E2Mi/Da1Gk1CaakZ
         UrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458549; x=1787063349;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QkL6quPpYZOmrSZlgR7q8t7HlM3bpCXuTHsi56o560Y=;
        b=sVAFfgR+80MOmNUd77xKK0bKWo6zYNDUMqTqMu4u+stV6oAfm+5SwUkWvU9fMvd7XE
         xHYPbUhp4updw6zGvSVyY2xqxBsXxNtu9o0aM2VhX/BFZ9XmlrVMfarGD22NK0GSWTzA
         tX6cW6+vflzIgKKzwsG4JSniDrdnu0zy1P6NHJmyg+P5kFQpzi0EAHfU9icblLfGSk54
         KhSN2/e+8GBUCvoOROHLfRTEPaBygYzy8+80bDXc3JpY0qwCeYg7lyfuerJjEx1C64TB
         jOgEwDekeqZzD0pdO6VI5L5yFF9TUOI7pXoiVP+XE7MBBgG59/OD4AKKO1hLYu9sFqjd
         9XqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqrz/fJ39GCFecOGdik7+14a6JnmlusmZgUK1psgyVkf1ugC2DkcGGmP2Mrug8s5/YDjmTlwPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSJQUb8d3Rf4HlLRSa6FSY8hoK7vxVUjPw3T9QfWzk8hPY5E2
	J2urdK1Czadw68SnjGjBfFQcH7QhCv9Zvrq+uvdYxKI3waNksw0f3JWF
X-Gm-Gg: AR+sD11bgiz9grKzfmcDtUcumLx72kknbQNJlZeaeVNLys2xLOQs5KqHudZuc3NdXCU
	WaktXhPodpFKzmHtX6IW2dLU0xKX+ZsjSgaqSer8+QF47+aBry8LW0ANx9ZlgluxXHeu2kmS9aU
	bPWsQ3g87cODNTJLAlnn7PyAcWykow078+yg5yvE1GKBkav5Wq+40a9uUFYntj2lDmSdOk6qQ4m
	f1YptURJMPK4O40zv8v+6eAGG9tsNFfBxGxkb4QmyXze0Trkqw9fJ2YlKqINPP2P+/1go8xVtJn
	oUQqjA0h2+ttpJhPDWtP1B2yfnWqfpkcKV91wRa2KFrmzOW1DFcyDc/wfELPGdCClBo1XSgTtj2
	zfBqyKKPmWulW71Xo/uH2z+YKXZPTSqPxfQnzyWTVJB5DqS09bJWomT5WQu92baJo2NePW+MzOc
	eo/8eve9MNEeenaCy/p14CbSGtvykeygEBmP4YknYq5MP0sdPpbEChJlTIIAg=
X-Received: by 2002:a05:6a00:138e:b0:848:8619:c149 with SMTP id d2e1a72fcca58-84faf42c2efmr824043b3a.2.1786458549054;
        Tue, 11 Aug 2026 07:29:09 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa954fc8asm890209b3a.50.2026.08.11.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:29:08 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/2] drm/nouveau/dmem: fix DMA unmap size and callocated
 accounting for THP
Date: Tue, 11 Aug 2026 22:28:49 +0800
Message-Id: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKExe2oC/yXMUQqDMBCE4avIPnfBhFJCr1L6EHW2bsEoWSOCe
 Pem7ePH8M9BhqwwujcHZWxqOqcKd2moH2N6gXWoJt/6Wxuc4+7KaS4bYuFhwsTruLDoDmMEiIs
 i4oOn2i8Zv6Hmj+ffVro3+vV7SOf5AWu1zIh9AAAA
X-Change-ID: 20260811-b4-nouveau-dmem-thp-fixes-e8ef1afff282
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786458544; l=1559;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=ZMKglCqVFXjvtgIXuZifnh47ei+nnVi+BRmkcnYy+sQ=;
 b=BoaoApiS8sm/+sfuksuoGEKYu0rzRHDSGrA0yNMo6P0a/eAtz2lAgOnDDCgBuQuP0XlJFp1Dp
 j8eAjUVMULPBHmIZgK5qC2TH5H0uqNmEN6oKiq7Z6bRRZADtjalkaaJ
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Two independent, stable-worthy fixes to the device-private THP migration
path in nouveau, both introduced by commit c32287471077 ("gpu/drm/nouveau:
enable THP support for GPU memory migration") and still present in
mainline.

Patch 1 fixes two dma_unmap_page() sites that pass a literal PAGE_SIZE
instead of the mapped page_size(). For an order > 0 folio this unmaps
less than was mapped and leaks the remainder of the IOMMU/IOVA mapping.

Patch 2 accounts for large-folio splits in the ->folio_split() hook,
which previously left chunk->callocated unchanged. A folio counted once
at allocation (+1) is later freed as N sub-folios (-N), so the unsigned
counter underflows on the first split/free cycle and the chunk leaks.

Both are confined to nouveau and orthogonal to the in-flight "Remove
device private pages from the physical address space" rework, which
touches nouveau_dmem_page_addr()/nouveau_dmem_chunk_alloc()/
nouveau_dmem_fini() rather than these teardown/accounting sites; they
apply and are needed independently.

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Zhenhao Wan (2):
      drm/nouveau/dmem: fix mismatched DMA unmap size for large folios
      drm/nouveau/dmem: fix callocated underflow on large folio split

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260811-b4-nouveau-dmem-thp-fixes-e8ef1afff282

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

