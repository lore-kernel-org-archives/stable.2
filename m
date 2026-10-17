Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081929A9C3
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213772; cv=none; b=Qn0uEEdmXEVEll2kP45DMpRf2bEtuS2aBIHVub8BTAOfMEDr5WCPQGt6Ly8E4ZRKbfnxPTBJH2FVzNy672kOjmDX14BHsPIOpKwb3VR05ob/PKOFzCrc0+ViShOeCKAjJDa6QPDQF6lji0Idgw37NuOJrXNz26D+2KvEnQN3/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213772; c=relaxed/simple;
	bh=6/qYlEhJHSxlMKX7o7HI7DT+c0x8I+YT/0Zuz+mG7pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtrW6A3DhK9tRUwbeYttEMt6HtskHY3/dUlyIAsfcWPDvouefdpX/AEyfXSww5OEWG/F4oYfvpSJ9NO2XY0dga90S2sni4iHp6mjGqNtkN500NqbhBXPvuDmwKeMxdbFoCuWgW2+7p8Cy9Ws0udSTWlSt9kOW+DRZWUldfQ2rKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfC8YMdC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfC8YMdC"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so462771a12.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792213771; x=1792818571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBiMjT8ldL7Ky1jQPlUb8oCa4/bnIv7ADJeJybOOjZ4=;
        b=qfC8YMdCKJDTW5GAXi1+FcXcVTO1gWbwoOAnsblKWh1gFwDc4KTLz9ryjWrDjIHgD0
         IO+FclmSsW+Iw0P38W3U6+R3+6/7f8P23BJ9KKtii4Ah7eL4OCOok1meESSvr3i+jPtq
         4kLldCxQiBfLsCA1gg4iWy/xhWd1Am2EITrcmb10DIGIRmeSeIruQKDg4MaLToZ3rqQH
         gmbx0rlhLkRD5SfL+Y3C12yNit3a8Hb2gZuUnfaBLu4ePZISx6AmP/vS6xCT1dgoorJu
         LOlN+PCMfPH8aBI2bGfngi7kF4KbyvR/6q/7ydY+pZArhhAX0CzPLh7a/grpvBnnpo51
         SgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213771; x=1792818571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBiMjT8ldL7Ky1jQPlUb8oCa4/bnIv7ADJeJybOOjZ4=;
        b=dDMmO0wu/4oUfoJLDzxL7JxPDQAMr6WFwR+oICMnytpxiO7DYfGIe18mCZQ5fUKDat
         ZnKd+5la/mhRUXiCBeDfeAeQDnVMaxw1NA+yvEkFsIV6xMtYIc1rCg0YO+VxmG0Rla/o
         sbgLnXCY5f5VT95c4SwYM7hGeJ8oYBJvc+XHMwU+JQ7CXOG6YSncJbGZL8Uu3Wo7hbYk
         JpaE2lDtWtPK9E2t3y4/isBLNfJ9AHjpMMKaRIiisKxFUT52/yuTmI72QxB12ll00OgT
         g0YbdnEXpqVF5eLud9Qfw+eL47/9QDPXkjnqzPuPit3INNtqYn4O66frGovHJmdy/W0w
         zptQ==
X-Forwarded-Encrypted: i=1; AKwUvByXA4T2omX/ujdvX+25Zjd5qsZ3cBZCpZPyJbqJ9pVsU5c8yj5iuLc/O6Gp1N8QFYycEGP9txc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhry3tNsx6TLsYb2iS4YXrnNEpqP1spwglucwcPbg6db4d+8Bs
	XCS3dIJkvm+QOwPHu4eXegKpeprk/0dMvh0j7JW8D+QyNQTXOQ/CX3ig
X-Gm-Gg: AYBFou0HR41zQr8Y7amwp7//sG2WsRil3DOqHzyxaZ7mWxAwAB4Rsd5vj48AjYu4uoi
	znyg8gGIto7wX8KCwpjl/n25GfdurRNTWhuVvKHAPachScNm7hKRBRcQtTGAiw46UYW2DsmVXGb
	sUzmYBylu990l/jFQYdaTZpG9OJsApZ46+WGSwmU+qMbEnS1URf7pJUiOgfs3iau1lnFL2xwj0P
	3reI3/BpJ9o7cIP9cYpG71P+luFpo9i3OF9YHYDg6jeU2EFzGPATNZwyWLfeNXu42+oX0N+w4E2
	kq+80w78Ux30MvEocu37t2I2UXTMHJwaeY9s0ATwgdln0k4viR/+tc9rmVC5A0s3GC42wm2j78+
	il41FXV/P8tE3RJvxlRalcIvuxnC1Ah1Dkd0oOetwV9Ikx+FnN1zPYZ6TTwD2WL0qdPGaVtvaWu
	6696dY0NgGQlVHSvPxC/R4LalK6kbeRBwQ8g7Gvc+d5WnExYSyoIP5MlV4Mh5DQ+x7y2hVgBxgC
	BtSAv0061OZERpP2HUOHv1PWZHM8WZCFzybpNjizT42VlxJw89535axg/UxnMSkYfbpkTajwUJ+
	3WWeKEifi/o5C2tSRZHPDRL94pm0tzskqgWxeo87KXzxRV+BeQ1Yv6jCdvz+isSDvnwAxpYAsfJ
	R6OAw+zRlAZDzVeL2mwsa
X-Received: by 2002:a05:6a21:6b88:b0:3dd:a00a:1715 with SMTP id adf61e73a8af0-3e2263d5f61mr1225361637.48.1792213770605;
        Fri, 16 Oct 2026 22:09:30 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89febdc2209sm1446036b3a.33.2026.10.16.22.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:09:29 -0700 (PDT)
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
Subject: [PATCH v2 1/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref with memcg disabled on cmdline
Date: Sat, 17 Oct 2026 05:09:27 +0000
Message-ID: <20261017050928.128582-1-sidchintamaneni@gmail.com>
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

