Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624284D5A1
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456416; cv=none; b=OUuKfhKAZr/zpFJkkTcSkxg2K7dABq4zo7wPVcAIdzYt9DtZqPatigwQslCZvW5Wnq3MWWR43WFPzqZeXH+wWag/G5aSJWL3uM/UxnR5McmvtL7pyT+zkOrU+20yZWUcQc8ZPzHHwNIQUdgoE0vFQ33SborbYvdzev3HQ3lZbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456416; c=relaxed/simple;
	bh=UTsJbixj5f5upm1yDL4v2oYlqoNy1xwwPfF04Oakgjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBqGoqAEBt5uStARD0IGqFTDWPRQwSMRonWsw031bC0sKx3ETHwqdcEpzcI/xb8M+XyCxvw2W+yoQjluCiMKphPZQSdev4WGn01OUPX6lDNLHzJIhbgxWc7/iXDnpit+Og12XgYHiMDaiY2FbYW/2jLsDqV9aHjTGnbI69EK0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdeQMyLY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdeQMyLY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49e6bad7b79so26302165e9.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789456412; x=1790061212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3/q6Adnz7lpVRwZWpJQefNRmiB7gYNF+Y1dkZ8i2uhk=;
        b=TdeQMyLY483Qp3Ir6tu8G6PkGn6zU2tSNhUlJuxdPVNh6QrxeOSx0ZvzVGn3YZaE2i
         jsXLQpnqLRsGCnCCl+SWQz2U36ut6w/rJp2DPnwcSnIuKg9m02l+CS9DvG5IOD88bmnJ
         804fzUEtb/ji/A5EsdGcWuLSO7IxCSO9vo3gYwkvRgPyUg7hNRiObI9uKfGRY8KmXVmU
         lVVzBNjmh4mH+Y7hz1z0Sbq5Lc5+Gjdi/6W9/42Yotkzi0P08HGaXlg0W9PUQozt+ZFw
         x4jiZcyA6inmc60uXUgXidAfiaerZU2bcmEgwvf5z1PmgroC1/U3JylX2a/flHzKcuB/
         5+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789456412; x=1790061212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/q6Adnz7lpVRwZWpJQefNRmiB7gYNF+Y1dkZ8i2uhk=;
        b=vCCyt0iHwoVywVItyDPBuM1dfTp6kVJmQ1Ob5gec1oTS1rcP1l0wJm2sK18M6oXaaM
         yCD9XOVvMsAjTr1RhCJlXblZD/gGbt9yOlltp5tJQn207IK1F5W46CgKxqg3N37EwMYe
         X5XKxcwDd1HDPlAOTze/6lSu1ElftDLHMaNojmmx4gVXI4Hlt94XB+YkxkOHU5Ru5TN3
         Ss5LG6aIUEXfEwwRFgk28f8G18il6WIjc/7kVaU5Zftywdeaeuz06D+fpQ3o7e1vVZXY
         n2qv6ryhqPzD3raTlpyUchn6zfC6DKPRkG7bVMFmIqmIEr2F03xbJSdD2k8q+wftZP6A
         bqJw==
X-Forwarded-Encrypted: i=1; AKwUvBxuUlqwi5WN2Ylrpztg4dKU4FQYCAMaOsv5NB4GRk1wjkWHKB/gtIyKNZx+WCw23mw8ZSl4wYM=@vger.kernel.org
X-Gm-Message-State: AFuF++n8CkRcoWaNqpCsUtHGij3xORCszFKN0tRVpGtDHcYeyYcgMKQd
	BRis/3NDMYshyV+nkLgnB1lgKcD2/FgfQq8zW29NLNqLvc+sVapaF+gTU1NCV+3Z
X-Gm-Gg: AYBFou2+HXVSn+E2TCDpglsNaECds4gZnskjb7XBN8HCxL1kGR6hLPthYRpoBnyJgYg
	cTmdix2k99x/NJoobRR/Ho1K9yxKOWqgEgeLfOyC3gUPjgfuhdozsgfd7ZJm7e3x95joGbgze+U
	8HprQPBWiz3sSAVeS4gCOqlm3/f3v3OcwQRMoh9v+8P6bLu4P8e3wiIk1eGy9hp0W5RVw5WNsKo
	Zcylo7h5kWWXi0CeKkgVusuYTq8hLv/UwNwok9oY/ONqFeX3aQz0vuI3OHCOB3nq45OEQzF2OQ7
	mx0/Bqs/jNs3WbMe+GIp4jq6cADvSu7COHUgmQvEWxqydQ8OAf5oDhAhFJZHpp6IsCHzV6SWgst
	faFEmgQAYx7GRsQ+37gt7TfuJkav3XsFTdx0Rxfw5nkk8qkNK9wOOk9sjlzHdP5X182m4bdA5ft
	RJj5GQNZiH/cYWLRBDoyDJ1oLwN+zHOt47XIxo373TYphV4qACINTG/Fqy6rwOPnW7KPx8nZaiT
	bHYPOsl1APLPag+JbyGGGGeCE3C5TPOgBEiYewxerr4KLoHSf12madD8T6fQ/DYi3DVYnMoFo9r
	5dylt+pbTJOfMp0rsg==
X-Received: by 2002:a05:600c:3586:b0:49e:747e:c00e with SMTP id 5b1f17b1804b1-49e7a64e729mr82091545e9.9.1789456411633;
        Tue, 15 Sep 2026 00:13:31 -0700 (PDT)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef735cesm42941345e9.6.2026.09.15.00.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:13:31 -0700 (PDT)
From: Orgad Shaneh <orgads@gmail.com>
To: tsbogend@alpha.franken.de
Cc: linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	osalvador@suse.de,
	stable@vger.kernel.org
Subject: [PATCH 1/2] MIPS: mm: align hugetlb mappings in arch_get_unmapped_area()
Date: Tue, 15 Sep 2026 07:13:24 +0000
Message-ID: <20260915071329.15125-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since hugetlb mappings were made to go through the architecture's
arch_get_unmapped_area{,_topdown}(), every architecture that implements
those has to align hugetlb files itself. The generic implementation and
loongarch do it with huge_page_mask_align(); MIPS was left out.

A non-MAP_FIXED mmap() of a hugetlbfs file therefore returns an address
that is only SHMLBA aligned, and the kernel then installs 2 MB PMDs for
a VMA that starts in the middle of a PMD. The consequences on an
Octeon (CN63XX) board running a process that links libhugetlbfs with
HUGETLB_ELFMAP=R and HUGETLB_MORECORE=yes, all within a minute of
start: the neighbouring 4 KB page table is clobbered, the TLB ends up
with overlapping entries ("Caught Machine Check exception - caused by
multiple matching entries in the TLB"), process exit trips
BUG_ON(start & ~huge_page_mask(h)) in __unmap_hugepage_range(), and
freed pages leak into unrelated kernel structures (oopses in the irq
maple tree, in pte_offset_map, ...).

Do what loongarch does in commit 3109d5ff484b ("LoongArch: Set hugetlb
mmap base address aligned with pmd size"): when the file is a hugetlb
file, use its page mask as the search alignment instead of the cache
colour mask.

Fixes: 7bd3f1e1a9ae ("mm: make hugetlb mappings go through mm_get_unmapped_area_vmflags")
Cc: stable@vger.kernel.org # 6.13+
Assisted-by: Claude:claude-opus-5
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/elf-randomize.h>
 #include <linux/errno.h>
+#include <linux/hugetlb.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/export.h>
@@ -72,8 +73,11 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	}
 
 	info.length = len;
-	info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
+	else
+		info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
 
 	if (dir == DOWN) {
 		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-- 
2.47.0
