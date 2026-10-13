Received: from mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2C2FE074
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906006; cv=none; b=rrGCfla86AZNqytsciZPYlZO65RxLJe/Zi75PuPr50csDNhVQaexcB2w5z2VFhx01sMOtvPww5Eq7ky69losaWllmDmopPical9INabwF6LlegqlSmhoVYFnj6GjN8bndH3tL0Cbjjdi+3B7ZauITdroTaso7TESUmc8RZvr92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906006; c=relaxed/simple;
	bh=wvI3yQEb1pra9snQf3HMPf0AqFlWoLGzhzZcKtUO3i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNzKmXk6xPFdRZNQGVoXMx/DCG5DfqavYbJAGWM6i6I2jEGxwcm2athCZZHxNpUDjcMzTlWH6a0h86nsLzd/WACv9MgbeKK0YXmjo+nLqgn6euBTKmGAsR6gAfk/mueTKke4rcxnv0E8paObvMB3ydWl80sOB54JVKE7hiaZqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CbIVFpFz; arc=none smtp.client-ip=95.215.58.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CbIVFpFz"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wvI3yQEb1pra9snQf3HMPf0AqFlWoLGzhzZcKtUO3i8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791906002; v=1; x=1792510802;
 b=CbIVFpFzbvBZ6HFblwi9Sb2Ng2vo/5CtHr8jdpUpJfyFP0rmHhgvjF6nrCEl3FMJIiJRgIr9
 ZbTVdh9AQTmDCe9FB8/Vz8xt/XXiOxJkF47VA0MZ6d/yz2HAiJ2wybh9QD08SWvhHFaU5MWfNII
 rFg/yXiVkz6lsZ4pqqBAewts=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0335801ba07d6e44;
	Tue, 13 Oct 2026 15:40:02 +0000
X-Mizu-Trace-ID: 0335801ba07d6e44
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: zhaogongyi@bytedance.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	lance.yang@linux.dev,
	mark.rutland@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid PTEs
Date: Tue, 13 Oct 2026 23:39:53 +0800
Message-ID: <20261013153953.77575-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261013093600.54995-1-zhaogongyi@bytedance.com>
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Oct 13, 2026 at 05:36:00PM +0800, Zhao Gongyi wrote:
[...]
>
>Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
>Cc: stable@vger.kernel.org
>Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
>---

Good catch! Thanks!

[...]
>diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>index 0acab179f..851fa2e44 100644
>--- a/arch/arm64/mm/contpte.c
>+++ b/arch/arm64/mm/contpte.c
>@@ -463,6 +463,13 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
> 	if (!mm_is_user(mm))
> 		return __set_ptes(mm, addr, ptep, pte, nr);
> 
>+	/*
>+	 * Keep the producer-side invariant documented in pgtable.h true even
>+	 * if a direct caller passes an invalid descriptor with PTE_CONT set.
>+	 */
>+	if (!pte_valid(pte))
>+		return __set_ptes(mm, addr, ptep, pte_mknoncont(pte), nr);

set_ptes() is the only in-tree caller, and it already clears PTE_CONT
before we get here ... no? Why not fold !pte_valid(pte) into the
!mm_is_user(mm) check below and return __set_ptes() directly?

	if (!mm_is_user(mm) || !pte_valid(pte))
		return __set_ptes(mm, addr, ptep, pte, nr);

If a direct caller does pass a !pte_valid PTE with PTE_CONT set, I'd
rather add a VM_WARN_ON() to catch that. Silently clearing the bit would
hide a caller bug :)

Cheers, Lance

>+
> 	end = addr + (nr << PAGE_SHIFT);
> 	pfn = pte_pfn(pte);
> 	prot = pte_pgprot(pte);
>-- 
>2.39.5 (Apple Git-154)
>
