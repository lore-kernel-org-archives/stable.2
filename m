Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0557C9F
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910517; cv=none; b=miM+QRQsUfT6dZfoAtcqAqEqiOSx9weW01uxK2lgYuVXptOMZSO5qg8R5j+bMRn9x468U/W8i1xsV4XMrKA4AfrKt6SXZnfLeySWY8V/FlbWceBUDRjWj63oac91QLDwewbbfazd7EgSIGAC8aBtVE1THHpMLIrlHPjEKTiVFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910517; c=relaxed/simple;
	bh=8IuohYJIFQq7XvofNgNPwVDtDoQLhfZC62FmH3VKmfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNvErqoMog/BcP8MNitOwATbzwgwe+lVYLKnwGWod2tvRIAqfIAfSuTI4f+G9SGzzraWVIo2MlwNLH9FDrffWXMf5nafrcIgBzu3dAZZ6+88/hjrVz65SsLkBVcGNPjRqBs3P0wACORwEiqHtPnRiBTCneQ6YmivUvp+3N/LzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIVI867I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIVI867I"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d7200b2e15so8992335ad.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787910516; x=1788515316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=glXaJJLLc7413zYTPQe8CxMRLtRUMADuZ7/9ajV0cjY=;
        b=IIVI867IcRoqi9VOfWGb0hpKKI/vEC3ZJcN/3n9jveYsiJaU/Z0R3y43lfPa+FM61s
         vEvJvBqoDmkM3VeKbxfkHt0kNlRCSucw7ZguMoZ74dlvLKdpxfeKVt+BNJp8LbST/UIB
         CG2KRMHfFXcHxxj2igGRixUz7LZIcE736TAFuZ90hcFUKo18EpoCbbxV2eb5Yen7Srid
         Xr90QHSmPQj1krce9k6W9Dhvl2RuefA80UmVNGSTatQnE3RzD6JdKt9s2RqvOa5fS2R6
         LCKuavItkaWAWefLjLmn9O05Rv83abIk8evGKtadFwTXYxW8LpUY1yUXKbosyZDxBzu8
         CP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787910516; x=1788515316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=glXaJJLLc7413zYTPQe8CxMRLtRUMADuZ7/9ajV0cjY=;
        b=YGpqH8RSlf24BD1yx0YEFCim7CpWo/pzLQUZ00+vKDrb4iTk+q9NWZ20+c1wsC3xsC
         HSMcdkcvdCthR9J/OisvqZO3wBf4vGTbiIdkYh770rDUHEbofmg/djOSToOQpRGEA0ag
         47bJ23AM0+GxtsoyR30hsJzY6si1sraMxybENU8RjU1M4t0w3MrNzds5DIliTBtdEcdM
         6IJ7GXUmLHIYw59svFNB19YCmluwrwfvtcz/gqEiLBVt3/OYOZhzEqBwcgYxqCiSmywu
         0xOcHQ8cbZKFM2L3N4PI327nOcjKaNI+FMekk5c6qExmYa8RWx0xiyf0LT5AlGb2K1aT
         dyVw==
X-Forwarded-Encrypted: i=1; AHgh+RoSMhJfiQkipzIivxEYJWvlUj6sA0qzlEriP8Rv1NGYBY3ax524xhh/0eb93a7zp/7EUtFysS4=@vger.kernel.org
X-Gm-Message-State: AFuF++mgIPEUZLm0ShYkMHiFdt2OIRgy7wfQDFAtns3wdwIL1NF/u5LK
	pGv3BE8EvALJOssWBTVXQOzrTGLXKlX/hj8z/VEi29RKjdKZqVId914hT23W8GvIDE0=
X-Gm-Gg: AR+sD13dATSVBRjtCfIbfowTxGYzbEbhJ2TyuEFjg5WC6TEPK8R6/AG+ZInZZDEmtpy
	pHUHCpht4P0KNto6Qfnz4PNinj7l09i5hc3fHaIhE39H0hO70zYhenYJV0j5+y+diDdREugU2aH
	m9pb7iCFQaMg/pmbuLztuV9s+UFEqPBvw+vSWziw4YHf/fELRh7+4Vyy/i7mwI8gM7zw7RQfZ6D
	QVY5TpCsBWzJpzNmulsRr08Tb5vPz/qTd0CCyvesUF/key/76IZJYdezi0clbxJc1i6O8AxT8Cd
	WWbBLK54Q+gUkwKFPEFuWoVAeexEahWFJ94DHdo59ddAI9hxOKSsyg/YdESXGfq0VPfdfEY5IJO
	tg3uL8G7nyx8//mGPCe/BgaZJeHouoE+3dwEX1EdK3wK5xxo2e/1Mv0RpmLZKNYx0o00hRzmdWP
	orCNtsE/sG7K9aRvcHx8O7J3FScEajHFq4Fqzp88zKP6ylb+Wfn66DLC9//xRgvLe0V59rqvHiN
	t5KoCs=
X-Received: by 2002:a17:903:3a8b:b0:2c9:d88e:f996 with SMTP id d9443c01a7336-2d74dee96b5mr108548445ad.9.1787910515336;
        Fri, 28 Aug 2026 02:48:35 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759531f5csm3778075ad.28.2026.08.28.02.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:48:34 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/mremap: fix locked_vm accounting for MREMAP_DONTUNMAP
Date: Fri, 28 Aug 2026 17:48:22 +0800
Message-ID: <20260828094823.594279-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

When mremap() is called with MREMAP_DONTUNMAP on a locked VMA,
vrm_stat_account() increments mm->locked_vm for the new VMA while the
source VMA is still marked VM_LOCKED.

For a normal mremap(), the source VMA is subsequently unmapped and the
munmap path decrements mm->locked_vm, balancing this accounting.

With MREMAP_DONTUNMAP, the source VMA is left in place and
dontunmap_complete() clears VMA_LOCKED_MASK.  When the source VMA is
subsequently unmapped, VMA_LOCKED_BIT is already clear, so the munmap
path does not undo the increment from vrm_stat_account().  This leaves
mm->locked_vm over-accounted.

Undo the locked_vm increment in dontunmap_complete() before clearing
VMA_LOCKED_MASK.  MREMAP_DONTUNMAP requires old_len == new_len, and
only VMA_LOCKED_BIT is checked to match the accounting performed by
vrm_stat_account().

Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
Cc: stable@vger.kernel.org
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e8df5cdb0ac..37ea5ee1986 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1334,6 +1334,14 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	unsigned long old_start = vrm->vma->vm_start;
 	unsigned long old_end = vrm->vma->vm_end;
 
+	/*
+	 * vrm_stat_account() accounted the new VMA while the source VMA
+	 * was still locked.  Since DONTUNMAP leaves the source VMA in
+	 * place after clearing VMA_LOCKED_MASK, undo that accounting here.
+	 */
+	if (vma_test(vrm->vma, VMA_LOCKED_BIT))
+		vrm->vma->vm_mm->locked_vm -= vrm->old_len >> PAGE_SHIFT;
+
 	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
 	vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);
 
@@ -1343,8 +1351,6 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	 */
 	if (new_vma != vrm->vma && start == old_start && end == old_end)
 		unlink_anon_vmas(vrm->vma);
-
-	/* Because we won't unmap we don't need to touch locked_vm. */
 }
 
 static unsigned long move_vma(struct vma_remap_struct *vrm)
-- 
2.43.0

