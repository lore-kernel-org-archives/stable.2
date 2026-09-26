Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAD43E9F5
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790426519; cv=none; b=jzLVCnb+1Lllp2b+zeCMlVVvtHJEmnZq4BMZ8VH2CsDZqzr3vbG6jDyhk006tUMHD5tipeUyBcLB4b8yfMiOwQDbAXIfxvhU9NZGrkvRRXXau77On2BjTaX8NYmOnie54a3vfgxwQ37Uh8iPpTsPI8JgIIy8S37bfLS5YAq7KNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790426519; c=relaxed/simple;
	bh=Ml1aH6GZhiGDEygMeUydHkl4HCTe9wDi055w1rPW0VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAKFUJohJJDVbGOLaZTUEcTyUd9wQR5PUUkEXWi2wPaTZunqMn4nvvAs2Pbw9L2xNyzug+Vh1Czh15pluY1e/h7dnex4fgSvDwKo2g8X7FyYVomJ7wAigm+6S+r2P07ZKZ/Fj4Y9R6p16JG1nw+Wx+hgW/7yU2SM/3049sy4gnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j84pInwQ; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j84pInwQ"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc791f087e3so507507a12.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790426517; x=1791031317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxUX0NroNmM2djP5qsrTpM2pYvDo5f/LrOtTkWteY6U=;
        b=j84pInwQZRHwkWcyTYrzjMYCi+Q1SLa9EzyNIH2EK5V5S0niWVk83bvcRVi9ncqFoY
         H+W33oBvZnn6l8wXrq7vFDEpKPl3cRn8BufcUqUi0HbFfKsvJTBgnbwYNuThH4vXPN80
         WRmry/LstsQixxvmKmdODhpLRstpTDIOWUW1xcshCU39SATglLLgOKtlyR3UUHQK1LaV
         L+RmrFJl816r1d/qaXLcxEQTu5sbRMT3hgNWyvKoNulqkYtgMn0zVszlP5FumfU6VrRc
         ibt3q0dFue7oj50t/heqGbR/BOV4JY1bJT00Lk7ti6kO0pflhpLE2987vMPa6K939rtY
         FXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790426517; x=1791031317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YxUX0NroNmM2djP5qsrTpM2pYvDo5f/LrOtTkWteY6U=;
        b=DM0DP9ftcdo3ASJ+5+gvg4mccc7lAye4leV5Wxn8mPqOjJo3G3K9WETy0FAVSGvKy4
         p9J8LOlrq3ou933YJ2koZ2VOvN4F6hGkY6EVLf20U7cagNFmgR2GCgJN9M+1xpdMTzjd
         DJMblBkYzR06R4D98HCNU35gf9dW/IloRO3PcrqRo3rYCDNq8K2mpdm/wLfszkB5G7+t
         F9WUbw8AbUTNLsvtxn105iK0rg2JD0o70peCHsrmH+JlTLuDP0lwLiMJBjdCVRWvxeDa
         NOF8c5YEc4BZYPKtBl22PIqRQS41gi7ffFBdffAi/TUbYsLSoe1a6eXmuAmbCuwS6ZDx
         +F1A==
X-Forwarded-Encrypted: i=1; AKwUvBxYXn3lemnHEpLUhTh/x9p1CBdbxmq1+j8lmA26+9hOXhz7ZYSAHOcfXSIphMmNCeiGKewvPgc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjOkOaKx/cgyHjl/p65J2cppMROK0H80IAaMFyX8fsPmiaoRod
	VSx+hSxTFjgHhO5jNnj52T1YTpcInct9TIGlz3EyO3uOxEHFCaZ8z+M=
X-Gm-Gg: AYBFou2CbhCm2dAbNN7IB+kFobXFLs+roZHJYW6ZcggHE8QdyK5NgFsYYb1gKkcFXj4
	RzmHPqv6FHDmKitZYF2209dzXNA9sOjXFHmoAly8FdpweJ8fTRRjlOetga8tu7MfBsHUvAPwXw3
	Yns5OcQlR5TDBDwWMMOVL+dAl568n2oF1gyy7wepFE0o5gzVf0Ggza9t7WjbRaFqCkKL8DRPXTP
	xwt0JjbxN/7fxA8MH8Ly6jGCAqMGgX/nJnXH0H9HlnXScmJJ/2mRNm8Pjpo/QOpb70OKgLSwM4n
	mtUIUGmyVVnI7DVAz6vS1FfstzceIUWLZQ4W36n2C5fwociLOPFuDFWkOarvc+ENfRO9NISFVfO
	wZoZHMNWzTVEfMi2nLaXuYPoYYvC7YwYIVXCkrtXL43ff25IHntCRNq/S+tnxmO6MX/BCoBGF0s
	cwTeVBQIEYiqUa2FpJt3/J3wzItx0Qh3hjOsCvyyeF+G0Ow5fWJ0rAHi8PEnkH3F77mv7+XHpOp
	Tm/CB6qBX8fjl9Exmfi4fWouDvzC+cWJyU=
X-Received: by 2002:a17:90b:1a8a:b0:3a0:cb48:df68 with SMTP id 98e67ed59e1d1-3a0cb48e2afmr3146943a91.13.1790426517221;
        Sat, 26 Sep 2026 05:41:57 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0cd1c4ec9sm5965212a91.16.2026.09.26.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:41:56 -0700 (PDT)
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
	kirill@shutemov.name,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] userfaultfd: clear the inherited uffd bit in move_swap_pte()
Date: Sat, 26 Sep 2026 21:41:44 +0900
Message-ID: <20260926124145.2878520-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926124145.2878520-1-donggeunyoo.kernel@gmail.com>
References: <20260926124145.2878520-1-donggeunyoo.kernel@gmail.com>
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

