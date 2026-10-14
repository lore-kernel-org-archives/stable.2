Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD404E50D9
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971750; cv=none; b=mtlnpzJ/DPNLXKSGR59LoJX82ZlA6TrlZqcXTp8scSY/68oVNFOTt8imPi1OzFQu2jjOrQm1Bs3DXe9FosZtvQdbYdFUxleGm7MSzJDEGNC5cRT7oi0e8h1t7IEOmYuBTGHqk+ygWLOjDNI5gvgMNgq7UVaKGUSL9G36vlWgPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971750; c=relaxed/simple;
	bh=1k0jSncaSaG1GK8A6Gfo0GhCTJx/dG9NhZo9sT8j3iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvzFdP85pv2IhjviAdPZRZ+LKmSxf3GvNuWwv67HEmPqcD62aPqAX4ruhxpnzU3Vx01dh4/towfNgTWA+VEi6OuevVzONU+esSbNitlo84mpbD/QPrpbWi3FrLIwO9TSAh8/oA2RhYbloH/LFuiau2BrM29coQre2vVjVQitbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG+ozoJD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG+ozoJD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e60f9af6e6so6379005ad.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791971749; x=1792576549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eo7EXw67vjv6v+p6PQKohVa243q8P8L2AoGfCHvln/U=;
        b=gG+ozoJDTBYfmcGzypThUy3iZ/ZTCo3RWvMotm6UehKTDxzS5mWITyvD53X+xLVZXy
         3OeowXT7PXHFFoNajjhu0Mhbdmbrge5rg7eGFRf69va4WqMuvQwmrl2t3Mn/LesOHXaD
         OPIdXmFBPEnt2s1cmTb2aZFgoGr9JRA8RlsKkbycQVbfPo3dSAimCq0zQTyD5NaKZdwf
         fYfu7y4HmNMreKc3bJ6R1h/c2ktcqQdA9MxebCR5+e8Moo66nfr2s08aYHIer1CXvsCf
         vDTQuHwXhfnkpbsaBePqSJpPfPEVOkQrmgvxChFA7DXgdcAd7j028OxGOIEKdPhZs4us
         uTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971749; x=1792576549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eo7EXw67vjv6v+p6PQKohVa243q8P8L2AoGfCHvln/U=;
        b=CkHVdwuSsO8b0V43n6VKrBwi9nEwz/6rLs8fdHYRrhDvERhH2ik7J5uBrr3a2JGnOb
         SW0xHAS21X5rUscwyrD30qoU9ECR4pOnT4Y77e8Bw85vi+fxYfQMf+2jUVBnqfY4ZDkr
         fJ64x9GUletGybNy6sSIln0ZEA3MVtG9m/V6258q8zIkTygR+hx/MtMsd+XIF8Kq2MmR
         hKYH/r73sJT/k86HGovZfkt8WwkXq9FkSibdXWI+4O2kMStBic0lVQr1Xo3IwPnEdqNI
         rC6xKHN5vDirLlEfK2bV/JMgg5vS0y6UlSi3c9C0/86jsCsu/M1Sxl+VYMrLmaSzR1j8
         aN8w==
X-Forwarded-Encrypted: i=1; AKwUvBzxZT2ea9TCBnIiAfELOPfkBePBoxkKJeX7oGKWZpTDH/xR27y5+j1MZyQGNYsC+UlJEhxt9Do=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnehzUhVhpDFNMHw8XfQxfr/tA2DlBqhdUHKXKkSJmoyf+1MHA
	zc/StTHCtDCxqGW19estnb3hVwWc1/Llh2MDnk4JKYiPzGEfZ26Rlcty
X-Gm-Gg: AYBFou2kvPpur0vqUo9qi1c1h7PfmaRTLQR0h1eXzzIrcZbB1rCXOt6wQnsDa/oHVH9
	sH5v7mf3zq4jJ5jD/e7Theo8w6jh26eueHRTnNGMOQDtZSfYeFkJBBvu9zZ0P0kXqm3bAlm/HVr
	v6ZsY54+c5mwL0hPFK5gpr8ZR91pJK2emF2m4kgWvRWxRotGzE+2LT9elSK/0uf6atN8d/FcvGA
	Ew1T3gz0DfVz5GPNMYV2GSkuAgX8NI0hsGFyi58QBvI7uBY2Zd2J1D+2XF0ksFfZKnjLV4OleBE
	2cvc9cnzVWkgFQgOG94ZhsYllQqzWOq9MSlKsvke5ELVPxOBgkCFGk74y5oBkDcvvFcXUij/SkW
	uVbPjrGsWbs6XgVtY6oDSZNgUryKQpIZlFXhoZvLmL4DQ6KwSHqC8hgPlVtw2XsJVSsSsu5g9gk
	C8DzrGXfjHnbEL+bhfBCY0dUE+0i6rVWy1Iy7Z3FWLm1Sku38K6YigUuznVbwE022pVlHWspadU
	abw
X-Received: by 2002:a17:902:f688:b0:2dd:ad74:ac22 with SMTP id d9443c01a7336-2e842cfcd6emr137809885ad.29.1791971748657;
        Wed, 14 Oct 2026 02:55:48 -0700 (PDT)
Received: from chinocute.lan ([123.20.221.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b5924sm67131405ad.47.2026.10.14.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:55:48 -0700 (PDT)
From: Ngoc Quy <ngocquy0700@gmail.com>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: pin mm_users in do_pagemap_scan()
Date: Wed, 14 Oct 2026 16:55:40 +0700
Message-ID: <20261014095540.3261469-1-ngocquy0700@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PAGEMAP_SCAN ioctl takes mmap_read_lock() on an mm obtained from
/proc/<pid>/pagemap without holding a reference to mm_users.

proc_mem_open() deliberately grabs only mm_count, so a consumer that
touches the address space has to call mmget_not_zero() first. Every
other consumer in this file does -- m_start(), do_procmap_query(),
show_smaps_rollup() and pagemap_read() -- but do_pagemap_scan() does
not.

Without that reference the target can reach exit_mmap() concurrently,
and exit_mmap() calls unmap_vmas() while holding mmap_lock only for
reading, which does not exclude the scanner. For ordinary VMAs this is
harmless, as free_pgtables() and remove_vma() run afterwards under
mmap_write_lock. A shared hugetlb VMA is different: __hugetlb_zap_end()
frees the VMA's hugetlb_vma_lock inside the read-locked phase.

walk_hugetlb_range() can therefore load vma->vm_private_data, have the
lock freed underneath it, and then down_read() a freed rw_semaphore.
The load happens before the freeing side clears the pointer, so this is
a use-after-free and not a NULL dereference. Any unprivileged user can
reach it with no huge pages configured, as hugetlb_reserve_pages()
allocates the lock before the VM_NORESERVE early return.

Pin mm_users across the scan, the way the other consumers do. mmput()
from the exiting task can then no longer reach exit_mmap() while a walk
is in progress.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ngoc Quy <ngocquy0700@gmail.com>
---
 fs/proc/task_mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..8825b01f5e38 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3231,15 +3231,18 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 	size_t n_ranges_out = 0;
 	int ret;
 
+	if (!mm || !mmget_not_zero(mm))
+		return -ESRCH;
+
 	ret = pagemap_scan_get_args(&p.arg, uarg);
 	if (ret)
-		return ret;
+		goto out_mmput;
 
 	p.masks_of_interest = p.arg.category_mask | p.arg.category_anyof_mask |
 			      p.arg.return_mask;
 	ret = pagemap_scan_init_bounce_buffer(&p);
 	if (ret)
-		return ret;
+		goto out_mmput;
 
 	for (walk_start = p.arg.start; walk_start < p.arg.end;
 			walk_start = p.arg.walk_end) {
@@ -3294,6 +3297,8 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 		ret = -EFAULT;
 
 	kfree(p.vec_buf);
+out_mmput:
+	mmput(mm);
 	return ret;
 }
 

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0

