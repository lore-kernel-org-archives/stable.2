Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C0E555
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195497; cv=none; b=SWiQYgB5LJKUAyOKhj/Tg/Ui6NOnMyiX9tiv+9GMXo2Ad3mbmZDV9ing63/tAPmxBZ9Tsqkt0MPvxfxmD0F1KbC1/0hx77wnVFQrQHV96XetuZDHBjpmSBu4R1kDgL6d5+PkM7U/aKU0TjO+4nEmIGjRdu/wtVplDZ8n+72Ss1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195497; c=relaxed/simple;
	bh=6/qYlEhJHSxlMKX7o7HI7DT+c0x8I+YT/0Zuz+mG7pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mj4CM6CSPvBDdb2p/LAm4Qsny1vp4b1Do0H2ATS32oywmZp/uJGgSXyyvWv+3m59ysHD616X9BoGDOD7vEE+U+ZTDG4rEy6Uz9SorgUCXwTVTzsmlt+zCLn+8rGGi3CBmT/uzDJBylCa4ZX14xt8qnDuRX6f42CeEIL5XSMOTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABXhLn1J; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABXhLn1J"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so463970a91.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195495; x=1792800295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBiMjT8ldL7Ky1jQPlUb8oCa4/bnIv7ADJeJybOOjZ4=;
        b=ABXhLn1JrHn/1sKXLDqSqPT3tOxX9nb4NDv08QUpcWND53dDiyh+RQXk66t+AHn76i
         35BWs1WGYGaNW+LSJzXUbF5wc4PcRO98vGufCZtxJEiGsO57knWQSkOOJXg8FWF9x78g
         HZw0t4HgVbVkZsiPvFo5dyehS8aKdRIUjqTe3qIHN+iMUw7/0KWl38bvSlCKAB0q+Swq
         +TD4TP8K4K42xg/HhslvedAM6vWZRz2NcNLoXia+HEeRSxsJ4C4EN/fX1xJqM3ph0Bja
         zxMKf6ooBwnUKh7Rfp1pTPkIKQPkJUH0jyAy/M62QDxH7Dzj+4d00112vp55dF1SgjqI
         52Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195495; x=1792800295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBiMjT8ldL7Ky1jQPlUb8oCa4/bnIv7ADJeJybOOjZ4=;
        b=IaVXezu4P6gi/lnLSmH1UIsMIkF84OtPIqPw2ANtoYU5CqEUo4gPMRMVvvce8FsAQ2
         wfD8s+GnnCmg3v/tdqa3ZnKqHHxikXOdGsnpXPBYCHWoHFP0j9V4Lz90kMAz3a8wpJbb
         eaaX4dl2gVWKSbatscQhELuMP4B6FKo+UgVvg2k+y457TVQC6JoO6UXGi8HJz1H0oC4r
         M+S+GRqi322XtymVx94iBzNMaodAXXAfKmtOy+5bBssVYppW3vYIDfepoGnQQEmoXmU4
         K67MzpdBsT28V0pbDiHcRuljRItCHljbBlL2dEFwXmOiQVkiBtoD6OHJIVaaFnoGUHRd
         JG3w==
X-Forwarded-Encrypted: i=1; AKwUvBwnLdMZruZpxXjwVMlJpASqgWeZHJNlxgR5X42jT5SWvjeSzP2vDwr8TBn7efN3q0YuQCEzkrI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpt/QIYawHOGgEHjfwwbn9jUjy0quVU29YQRVBC58GBH8tiYBO
	3+AvhG5tWvXYZ6Cf9Ssa0A1Yp7InjZVPQWWK6PMMp6tOM3ZzLgGs/Sw1
X-Gm-Gg: AYBFou0wW93ZLiJ4Vq5y5Ox/95zhsuWovIeobF6BO4YVaCP/cXUj8+LNvFo+1ptAGT8
	oE3caSNd07DoIwE7I3w/O5rYJaZr2GAHdMAjW8Tte78LM5HJTX6Ckv/BW3ziQg5aUsZl3FxhC4O
	77PfPtd8Rb5NelVz/bVbl6DEuVjZx/w/J9PqD0zZc7eKpuFqrll/rLLyMU3JCRykpW9vBg0TQcT
	BkdQusucBqUqgg46T+hMtZbwMxJWuenVW2UwyynhXcRGJq8XEW1uHYqJiYx4iUMnAQ06nijZJbp
	+WsVmrKVJtnGcDrkpfq1K4uiuE9GmNJCmW9/Di9CTAXTZ+I2V7K1uUhMlR5Fz39Yl+hMpAJWXs8
	ozWXwxQ/Ty0qP4+Ofj+bzvl9AKAZ5n+4Adjz50HTpjEtw0nNVhG7Ol332UuwIkHnZno/8zFLiXf
	6ihN6+dDOg4zZuJ447VM609DVyRRc+0BVVmQhuNuuSYsO4SPANWiy1AE+oZxwYp7Ay5MSUYdAZF
	ILbJIyz8k6SuNtvMHnWC4DzJWeR582IAWrtBwvHxYXNL7X/eUdzQ16T5ksuDVb6liyfgvrj5lRJ
	JBqwqLBCPTot8GPvkvv0rRvZpESKw2W0DNhRVqc5x2WoW0yD9LBDwjZe3gCRLVwoTQOJGDYPSyw
	aLPCopam60Q==
X-Received: by 2002:a17:90b:2e46:b0:3ac:9e76:aa9e with SMTP id 98e67ed59e1d1-3acee276f13mr1245594a91.3.1792195495154;
        Fri, 16 Oct 2026 17:04:55 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm3284963a91.0.2026.10.16.17.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:04:54 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@kernel.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	stable@vger.kernel.org,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH v1] mm: multi-gen LRU: fix NULL lruvec->pgdat deref with memcg disabled on cmdline
Date: Sat, 17 Oct 2026 00:04:51 +0000
Message-ID: <20261017000451.89536-1-sidchintamaneni@gmail.com>
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

