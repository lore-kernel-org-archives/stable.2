Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDF3F1056
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444670; cv=none; b=pw+9E3rmNERST+Jo4/aUfK8uqYcqdeKlV6pdHzqJxLttNm9RqsdcHwa2gpFI5onQwTIeAeTjVayU7Y4RhBPhr+d3KY8B7jgKjozgUssLMqlbcpOrQhErvY0IZQL9HgzKz9pU60IlDJj4MzmKUeH/cr/5SPWEVJV7Fe9cKMPdifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444670; c=relaxed/simple;
	bh=PUS8vg3eKrh52MewEnE+dnBAdvwDYq9NGtz9BnZ1fUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmjul4WLB814cKZrpLlfCm9K/kMMIwmm0APAyNm17zRAKPgh4HrgX4NB1NS8+No3J5/Or8KsTuLKBZ3PYmdheXAihLDXN9NLZo7QBp9qj2L56ZUITYxduqzKsmy9D0HiX/PaXIZbojB+p1J/mLnC+PO8NE0/3ptTY7Zt713LcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FpovHUhc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FpovHUhc"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a02551822eso362928a91.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791444662; x=1792049462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvkPG82zfhFkpnOg0JOtNiptSg9vrvtxMEvoINVoQXE=;
        b=FpovHUhcuDEvm7F2ohacfhQnj5Il6NH9HXU9MtyERNKOj2wtaBebj06SWmgZRamX12
         kKaRUWgcjg2CvcSDUAewqYWidoXztkaI+lGG5YAVQb+ZnM91vsZS7+VbuDzpVGQq9/g6
         d/IdDa20ChtYGcgWs0RDJGi0gJp8xMd+lknh4l9mIQOIx82RcJnD9LzM7MbRoLGpv4WJ
         X0dKunGBtkvG9p6/9JMnKp+Rc6irG1t5BO6qlap5Ye61yDTSMKNrRTweZxpWW+4p3LWI
         PVLxteVd7gJFLPX0F2VoTI1plaFGAIe7PIx7lFkTzarbLgFVT/+3VWUU/Lk7bWlu+Xq/
         D1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444662; x=1792049462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RvkPG82zfhFkpnOg0JOtNiptSg9vrvtxMEvoINVoQXE=;
        b=GlqKH8deU8LN8xOBKANkmOsoh3QENq6nAcbfWOQAHnm1wpnqFFBbEWZDobbc9qOp6s
         do8xs7Qi0tXPpkfKdz6JbfZv6wYBiR+op1oshTPV6m693PHQlzUE+OrLPF8l7/OztBir
         MG7/1UUF8OvwfiEdyBLqil/ARMJmDQzIq1T93MaXAnEhQR2HLg6ij/TkkIYW1GSSAFlX
         oDuvwo1Zfmv8DtbU5TEA1/KBGsYHYN6SIdjMtq9CcssVfrYIAM6jxA4WAP1ST8z/qOnI
         bzToBrPdrpvQ07dzxrGasHkWkmprozSB3y6Ma4iyfMEmqthdblLmLUe2yUefiDHd0igq
         /YYg==
X-Forwarded-Encrypted: i=1; AKwUvBzJ6flDTttjgWkpS37tk99Ydq6cUMeU8qh7tbdkRHDz/D+nk6pSJyk0eArW+0w33PB6Ddxs8oU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6ZDkJrWxYpLUdHmMxFbsnMP+nw0yMYBk7cFjp9zAdZ6OKYRt0
	hh0m5OD9EshcAbgPqbHFrW7/xkS5l32VSmIabzEf3yiMuqzNE1z3C00kZpF4vcG3+1g=
X-Gm-Gg: AYBFou3q9YBkf7q57l5qq/eoAJcljllU7ZlNFFCwYGIQcoBOrKQQd2SozathTqGYoPy
	D4Hw+LKimUyjeRbJUZ00gg4A6j5tk5L1LhtJvH7IMnNM+JTJ2MLG2Cdp7Z49dQb1pvD5c/UinGg
	Ba32KSuFng9BOFtHkl5Gxmz/wY3h+yf/cFEBeU70YUxylXiOIoC/iBeiYWH0mmVCmxqn45iG8cF
	EtAfURD2fmdRFHKAD6SHx3mRNXLQ5hggCGKkQmROAVyVTxziAvbIzN7sjm8k+NMPgNF+n7WSOr6
	JEF2abobJij/DKP9JVQ602C5DLkMC/Hq85FzWNnJG5R04Fyc29dlHaf+9RyhOuqahlu2ULfnjwa
	KS31KtkuKt8FzIQ0xV+kjfVAn+9zXOj84KlH3xIAiLqCmZ+ELmAhHjHs2D4wFlcwEMCmnfxZmp0
	5/fysEN6RQr2O3E63R+gmAWYYdRr3ug+j0fJzhV9yaElGDBiH26XSfphd/s2Vb7O/9UfEkwnT9W
	qw+ImmDOWjTHm/LBY0=
X-Received: by 2002:a17:90a:610:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3aadff48952mr575784a91.8.1791444661248;
        Thu, 08 Oct 2026 00:31:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a438f25dsm3114715a91.2.2026.10.08.00.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:31:00 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	david@kernel.org,
	osalvador@suse.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	bjorn@rivosinc.com,
	apopple@nvidia.com,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH 4/4] arm64/mm: fix destructor for unconstructed hotplug page tables
Date: Thu,  8 Oct 2026 15:30:21 +0800
Message-ID: <20261008073021.2512665-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008073021.2512665-1-songmuchun@bytedance.com>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c594b83457cc ("arm64: mm: call pagetable dtor when freeing
hot-removed page tables") made free_hotplug_pgtable_page()
unconditionally run the page-table destructor. This matches page tables
allocated by the arm64 mapping code, which runs the corresponding
constructors.

However, arm64 also uses the generic sparse-vmemmap population code.
Runtime intermediate page tables allocated by that code do not run a
page-table constructor. Freeing one during memory hot-remove therefore
runs a destructor without a matching constructor and corrupts
NR_PAGETABLE accounting.

Use PageTable() to run the destructor only for page-table pages whose
constructor initialized them. This keeps the arm64-created page-table
lifecycle balanced while safely freeing constructor-free vmemmap tables.

Fixes: c594b83457cc ("arm64: mm: call pagetable dtor when freeing hot-removed page tables")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7343ac9294f8..688b33095651 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1495,7 +1495,8 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 
 static void free_hotplug_pgtable_page(struct page *page)
 {
-	pagetable_dtor(page_ptdesc(page));
+	if (PageTable(page))
+		pagetable_dtor(page_ptdesc(page));
 	free_hotplug_page_range(page, PAGE_SIZE, NULL);
 }
 
-- 
2.54.0

