Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702629A9C3
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213650; cv=none; b=i0TT28+Bk7SF6f/CTxl01sHA1BTuSp/IQIaUjsGQQMtfDs8Ip8xbPqILb6DAHyOqut/jHgEwV/oZqvjrr1hgVAVhuSIbD8Bxf7VG8n3MYqMwBfOde/OMhycOBef4FyNiYIs6vxK9dDkhFDTs42njC6Xyz3RYks/Z/oBEMjrLLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213650; c=relaxed/simple;
	bh=6/qYlEhJHSxlMKX7o7HI7DT+c0x8I+YT/0Zuz+mG7pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4cyAILNU34/+VQkWqikh/aD8gGlUns633YNmECXao3PmLL+8Aqi0ilKAYrbdUwNErRMlr1VW8wtAh4BegXk9TJdMppiUldL34MbqDgDYajcuDVyQ+XY62NhZg4xzHY/bm4JuNpfob3C68CG3Fy7P3XENN78awz6xvUyqAgVy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvWag99b; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvWag99b"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89d4030cc57so316502b3a.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792213648; x=1792818448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBiMjT8ldL7Ky1jQPlUb8oCa4/bnIv7ADJeJybOOjZ4=;
        b=lvWag99bsYIKt/+2rBh7ekOV/4jvmSQIgDlKusd1AEoUzi8Ly/7XKQKyeV0chQO3EU
         1aL5kGntrv5VouEfrZGFciLJJp6mJLEx/m4btdLRdKSdTN0QorKQ0Kl0FSIwTaYvJ6hO
         Z8aYZOPegBNItB1j0vuUsAPd5tDl5voQlpJi3FMQGgVd0TGJQNCpyFxL9bJpxBr0ASfb
         UiVC26pgLZFoO9KYUZqviU/PtVfJpmxW2AIyNjwOQfd8DDwXSg37OgNJ6WD/dpwAQUTt
         S8E8yLLeiFAIummQBzCwykm4lNYptfstSAPbghMETA/mYTMmYSID4JdJHn/3ck8jMNtr
         Cx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213648; x=1792818448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBiMjT8ldL7Ky1jQPlUb8oCa4/bnIv7ADJeJybOOjZ4=;
        b=ji6dLiUANdH/+D5WWLRZy/nNzNxs3wO7p1Hw8xDqzmPZ64wM3BbkGsvTGBQgaeodnb
         8w0KbHvnxNAAPFN5AK/Z745oHjCuknC8ed+H7X9H3+1MWU8fbpeO1B/diL0vETHFAY/3
         SoZGkk/BN5QKThayftNCHtQCuJaGucEO1/JWBLcJcHAMHRlYHSF3ijQbvK3jrIOAky9q
         dbeDZWIP1MVac5P5JuVAEnWNwcHEOH6kzKh+HbNecx4CyhiuQ2GQ4WYXVVImv8x9oVjq
         pws35r13jDkwmbLWnFjIr6QFiV4zofhYUq9BKSnpWeNRRCvHyHsUu03BR4NvfCMOyt/T
         W/uw==
X-Forwarded-Encrypted: i=1; AKwUvBySS3LUFcOVUpR93bx6A24aGssG6vhDAnNWyGBtxZvaq/LRL+/NxaaG7XowP5Ns5+Gi2syxC2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9oRqCohq8I1s/fzosrWhAYTFyoqbD6nb0z5UDhfIv4aEYQsqC
	fihIz9K1malDqhyVDUMJHX+nqFH0RT7Zbml/1WjIWaetnd0EPwWVSjk+WKGiTw==
X-Gm-Gg: AYBFou1/lLes35Tq7SBjI48QIm9JsNfoH7Mug8gIqIk25/9ne3tdeGxvyNcJAhJ4jbw
	sPB6o8Eq8DezPI+VjnZbitQ8T8B1H4TlOQ9jma2jZbpwH1zjzPE0RHmIEJ7klu0ubF0sYArXsI0
	l0utRZlrftlz4s/AdX5//tLxd/EpXQGIRuXyqenuMNoc+6Ix6/6DCSbyTTZfeMhE9Hl/UAKdhk1
	ibstX4+vIQnoSm5CBCQxJhH81UD3mghJJ66l0BiCBS3YwKS7VymhsKMZyPYKlPyKZn8Z+opLKnS
	WmakuiN5IPYeA/Bq4nN8BNcTupam6GF+YcvPQ1gPL9M8G8gqlleqAc1FhLzgpA6akd1umInyJYI
	CqHG5I1gOvUoHJjZtV/TKazJdFnEiXrZ2gLKvTe1F/cRLEm0yROzGbDYmhfYoetMRRNAv2UHCUV
	SjPNFVR6hH8eC2KmrNSDDHm1OvrB3YxLKcFMI8qkwWMFvopd1+QXR46RhfqZpezy5YKXucVgSZ8
	QXLS5F0nxel1J16Ujd2qb3oJoL38wsyz9TBO/fTiMo362NEaM4olN6hzefk/wzrqDQSF+uqEmy+
	c06MSQIs1N90JgqEMY2gnQj3+ydvtXunFA8cs1TmsUUXGRiQkgOgeuYl5JsNAXhN5E+MzhtTG6z
	CQG4YV3uOmQ==
X-Received: by 2002:a05:6a20:6a22:b0:3d3:ae40:51e2 with SMTP id adf61e73a8af0-3e225f398b4mr1200716637.22.1792213648057;
        Fri, 16 Oct 2026 22:07:28 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65484a66csm2111964a12.2.2026.10.16.22.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:07:27 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: 
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	stable@vger.kernel.org,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH v2 1/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref with memcg disabled on cmdline
Date: Sat, 17 Oct 2026 05:07:22 +0000
Message-ID: <20261017050726.128260-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MEMCG=y, lruvec_pgdat() returns lruvec->pgdat, which for the
per-node pgdat->__lruvec is left NULL by lruvec_init() and only filled in
lazily by mem_cgroup_lruvec(). Normally that happens early, e.g. on the
first folio_add_lru().

With cgroup_disable=memory, lru_gen_shrink_node() passes &pgdat->__lruvec
directly to shrink_one(). If direct reclaim runs before anything has
called mem_cgroup_lruvec() for the node, which can happen during early
boot under memory pressure (e.g. a kdump kernel), get_swappiness() ends
up dereferencing a NULL pgdat:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000005040
  pc : get_swappiness+0x68/0xb0
  lr : try_to_shrink_lruvec+0x54/0x2c0
  Call trace:
   get_swappiness+0x68/0xb0 (P)
   try_to_shrink_lruvec+0x54/0x2c0
   shrink_one+0x8c/0x240
   shrink_node+0xc6c/0xe08
   do_try_to_free_pages+0xdc/0x570
   try_to_free_pages+0x124/0x278
   __alloc_frozen_pages_noprof+0x6e8/0xf78
   alloc_pages_mpol+0xc4/0x1c0
   alloc_frozen_pages_noprof+0x54/0xe8
   alloc_pages_noprof+0x1c/0x40
   atomic_pool_expand+0x98/0x300
   __dma_atomic_pool_init+0x58/0xd8
   dma_atomic_pool_init+0x154/0x170
   do_one_initcall+0x64/0x350
   kernel_init_freeable+0x214/0x430
   kernel_init+0x2c/0x208
   ret_from_fork+0x10/0x20

The classic LRU path and MGLRU before per-node lru_gen_folio lists
obtained the lruvec through mem_cgroup_lruvec(), which sets
lruvec->pgdat.

The above was hit on an arm64 kdump kernel (6.18-based) booted with
cgroup_disable=memory nr_cpus=4. It also reproduces on mainline on an
arm64 VM with CONFIG_ARM64_64K_PAGES=y, CONFIG_MEMCG=y,
CONFIG_LRU_GEN_ENABLED=y and:

  mem=160M nr_cpus=4 coherent_pool=512M cgroup_disable=memory

These options only serve to force direct reclaim early in boot; with
160M the boot eventually ends in OOM regardless. On mainline the first
LRU reclaim happens while unpacking the initramfs, and faults the same
way:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000005040
  pc : get_swappiness+0xd4/0x150
  Call trace:
   get_swappiness+0xd4/0x150 (P)
   try_to_shrink_lruvec+0x44/0x2b8
   shrink_one+0x80/0x1a0
   shrink_node+0xd98/0xea8
   do_try_to_free_pages+0xf4/0x4b0
   try_to_free_pages+0x110/0x360
   __alloc_frozen_pages_noprof+0x8b0/0x1718
   ...
   __filemap_get_folio_mpol+0x2ac/0x548
   simple_write_begin+0x44/0xf8
   page_symlink+0x178/0x198
   ...
   do_populate_rootfs+0x13c/0x200

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Cc: stable@vger.kernel.org # 6.3+
Assisted-by: LLM
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f11491ee9ed5..0c57e4f1eb15 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5253,7 +5253,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 		sc->nr_reclaimed = 0;
 
 	if (mem_cgroup_disabled())
-		shrink_one(&pgdat->__lruvec, sc);
+		shrink_one(mem_cgroup_lruvec(NULL, pgdat), sc);
 	else
 		shrink_many(pgdat, sc);
 
-- 
2.45.4

