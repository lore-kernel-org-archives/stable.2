Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74F41D22C
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791023449; cv=none; b=AFk6uE62SyqCm/bO4/7UGXqI6UJFr4i8TXRKswsS8dPWz3JkAC8WDiYXNZACBqojM2g2Iv/uKLgkLG9Oiv95YG9S/y6PWkpMcj3+6kqIP2kxKKES2xEd2WaNe7CRK8BiHzFJRRdIPJBeHwLs/f3475KZX5ztmw8eUbIb/jroANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791023449; c=relaxed/simple;
	bh=DShMsqHNVKO91T7Yyb+iFlD3Yt/tA9oiAmE9p8tWelU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkZNLSByG7BO621ouun+vxuZq5fnG119xxeXIBu9lXFnraHngeJsP4BqiQ8HoND7+uMnWstmFpcsVRmVLWWi5JFCebNOhlu0MYYlFx24k+sUaUwPW93SYnzO4svic5dNEMBPnoYrrVDV/zqfn3AKLnH6JQ5dTAX2g8V+mzaNh28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krUQWJpG; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krUQWJpG"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a7906f463dso238270a91.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791023439; x=1791628239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OIv8n/HT65OVykH/XmjfYmij9l4kWjigrp7qJ7DUYA=;
        b=krUQWJpGHiBGceHvMmIaFhEyAFPx5HaPneahLNOHKK8ViZm/ZmJFlhq/QQGJEG0WqV
         E98khnu84GUfDW1UlYvbrabZAlp/6n26aof9wsdcx2FpwY3o9kPB0zbEmAA2XKy6tZKA
         4pyc3ViM1oH/wbyQihDCHRGf5llcbNPdA8JqeA4cLLe41zXgzjGIg4lwA8hvwi7+s7UD
         U3cLfMhdJE15JEoHdG1VNFS+/XxrAMDOwmR8Qqop0zf3/9ruae9he62QRoR+iY2i9Vsy
         6uuOIZjO4s5l/MkME/QJuX4w73dj93R+y+UbowHC4Wh6mruDEKa7qBBT4611k7fMBy0D
         zrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791023439; x=1791628239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OIv8n/HT65OVykH/XmjfYmij9l4kWjigrp7qJ7DUYA=;
        b=Gr/fnXtHzwhBlJ5OK2F+2UWaDnKoiRG4BKQEN6GZ7bMrcfg1A/dHOSaORsNy2H/dM/
         jvcevAG87hJpmktaixZoY7MkyIl0htkpqZwfYEOSBY77frBjyl0/4hiY2RC5IoT6oiB/
         OVmJAnZfl8XjjYHLgJWb7ex0GrRGJx/R6j8cYcT6tGh1MM/0aCcNaZZrFScfFC5/0vI4
         ywnoZudlcc6lSr5+S+IVfFIAIkdxvPHRvKIJA2Aaq0dTQFZXFFz2MA0NijvaUYNVygXB
         pCR0FFS8SWmMVlVtFZnQTQy4n4PPQhK3s2MFhtYbehgyB2tA/bdoPlfhGtfqC/eUzgEI
         bGWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoILzwogbU7oBmG+yW5jb3LqI/EQiNF1jP0OJQ8KQhP9Vo0tE6dHVVr67mpe4fsPLn53q104A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn4zk+2nqOBSdLlELoIKVPO9nQE3KmCGyl6zcmna/g+uchAM5I
	Dezc2TXyLV8+wZWXV8FdPsF1XhQzAtDI/1zYCuIYW6K7hJM1/W3zq5o=
X-Gm-Gg: AYBFou0PxXrrA9Z/Sp5YqJjvv3ibzslMZAcAsRojxOAbK1SmysO/6+8gs8aarUtN1jh
	KZ2XysZzSGU+VRmKqbO4rhQsxvvLiF31nlBkt/PNcw5FVo6z7iDnL7kX3AHVqYXPOuo5smGVba0
	fmyTjoYfQ3VxAVQ6yeCZkxEA0SLJMko1buO4rlb6M+OZS40HAwZbvMmBoX8W5FxhkfgVIIBc8mN
	8o7M68Jz90Dvj93beYYnPhMzD8Eljy3HAzblypMtiadxag6HFR3/14LggoERepyiOnl24J9ho1R
	sjy6BZoD0GT2wBwtBG/f8OZW5smjJupqqWIdakTmiDMXRlbaBa4WbMj8U5VoVZHyj7meaV1CCox
	KiAgWBAwRf6qoxl9QTvefSYSjjmJrfNJ5lcERuCktKTrv3kOsWy7bFITH76PRIILlHJavJEufAS
	/tJcNQMxvZWYrVRkUXKuPb2gD8aOVc1rOOsRJsl5yjLWfan1t4XMV1wtjpEk0mNO/UOtFELk+MD
	75YxfuJZMMc+qowaDYfzMHvfw==
X-Received: by 2002:a17:90a:fc47:b0:39e:6a80:b795 with SMTP id 98e67ed59e1d1-3a6cec9b170mr4991753a91.37.1791023438924;
        Sat, 03 Oct 2026 03:30:38 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm2121961a91.4.2026.10.03.03.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 03:30:38 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org
Cc: peterx@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	mhocko@suse.com,
	shuah@kernel.org,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] userfaultfd: clear the inherited uffd bit in move_swap_pte()
Date: Sat,  3 Oct 2026 19:30:29 +0900
Message-ID: <20261003103030.63380-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003103030.63380-1-donggeunyoo.kernel@gmail.com>
References: <20261003103030.63380-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UFFDIO_MOVE on a swapped-out page installs the source PTE at the
destination unchanged, so a uffd bit set on a write-protected or
RWP-protected source lands in a destination VMA that was never
registered for either.  Nothing clears it there, and userspace sees:

 - /proc/<pid>/pagemap reports the page as uffd-tracked (bit 57), both
   while it is swapped out and after it is faulted back in.
 - MADV_COLLAPSE fails with EINVAL on a range containing it, because the
   collapse scan bails on a swap entry with the uffd bit set.
 - With CONFIG_PAGE_TABLE_CHECK, faulting the page in warns.
   do_swap_page() carries the bit into the present PTE and, since the
   destination isn't WP-registered, also makes it writable:

   WARNING: mm/page_table_check.c:202 at __page_table_check_ptes_set+0x185/0x1e0
   Call Trace:
    set_ptes+0x67/0xc0
    do_swap_page+0x990/0xfe0
    __handle_mm_fault+0x7d0/0xeb0
    handle_mm_fault+0x9c/0x250
    do_user_addr_fault+0x207/0x650
    exc_page_fault+0x65/0x150
    asm_exc_page_fault+0x26/0x30

Reaching it takes UFFDIO_MOVE out of a WP- or RWP-protected area into
one that isn't, on a page that is swapped out at the time.  It hasn't
been seen in practice.

A resident page doesn't carry the bit, because move_present_ptes() builds
the destination PTE from dst_vma->vm_page_prot.  Clear it on the moved
swap entry as well, then re-arm it if the destination is RWP-registered.

The WP case has been there since v6.8, where UFFDIO_MOVE was added.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/userfaultfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 74f04c323c50f..f39f109f17989 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1449,6 +1449,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
 	if (pgtable_supports_soft_dirty())
 		orig_src_pte = pte_swp_mksoft_dirty(orig_src_pte);
+	orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
 	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
 	if (userfaultfd_rwp(dst_vma))
 		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
-- 
2.53.0

