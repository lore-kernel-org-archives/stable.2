Received: from mta1.migadu.com (out-132.mta1.migadu.com [95.215.58.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACF28B7EA
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609142; cv=none; b=gUZ3OcZRFrgoaUgJJUI9JQcze2BOg6IzujeJck61Qutg9HE+F4La6HcRCknOQQUXNO4q/f7hVysXmgQfgiOEowydOK3OA3ToqZ7Tbzzi/eTAFDSF2NSsyimsF7Is0OpKuo6CHTCHJgVa2Wqmr6LSelPtmN8XccYGXepwfLe/l1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609142; c=relaxed/simple;
	bh=HkTvJBnAIE0ZS4t3l1CJ6+YMsi7vy8/ugr2w69S/OBY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=b2q5yu8HNc8XjD83DieCR9Co8GrZfiY+3mF4Tv0t+ZsEHTGjAOAUpg1/8a9Hm3HJhHYLDTlzzuTndbd4Y4Z/vDUhdaRwpfZeHglokU2nqiNeK88f4QAs/qA4SuC0u8SNownb8yzc1ok9Ltrg9vwKCE9fBeaJulgQqweYl3W++ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTAfOgS0; arc=none smtp.client-ip=95.215.58.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTAfOgS0"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HkTvJBnAIE0ZS4t3l1CJ6+YMsi7vy8/ugr2w69S/OBY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791609137; v=1; x=1792213937;
 b=cTAfOgS0fTtSt7e7QjdoBBL069Fi7tMpmbwUTn/QqvkOQZ41ZZ+3msXWO10R8eAQtHFhptJv
 EskLdPfKJay6WX7V4ZqYHHuo/Jj5x2AJTELD/k7cKMLxuVh4rkjdXzvoaVRMuHyedDzwZ4G1PVM
 2Xp9IGcLRTeCe83yxMGzNhyM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7bb1c1c289ae0b48;
	Sat, 10 Oct 2026 05:12:17 +0000
X-Mizu-Trace-ID: 7bb1c1c289ae0b48
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 1/4] x86/mm: fix missing pgtable destructor for vmemmap
 tables
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <bd47fc12-f1cf-4994-8b42-45fc68944072@intel.com>
Date: Sat, 10 Oct 2026 13:11:57 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
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
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AD5E5149-5786-4E46-A7C0-995088282179@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-2-songmuchun@bytedance.com>
 <bd47fc12-f1cf-4994-8b42-45fc68944072@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 04:54, Dave Hansen <dave.hansen@intel.com> wrote:
> 
> On 10/8/26 00:30, Muchun Song wrote:
>> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
>> pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
>> tables.
>> 
>> HugeTLB vmemmap optimization uses pte_alloc_one_kernel() when splitting
>> a PMD. Restoring the vmemmap backing pages does not collapse the PTE
>> table, so a later memory hot-remove eventually frees that table through
>> free_pagetable(). That path currently calls pagetable_free() directly
>> without decrementing NR_PAGETABLE.
>> 
>> Use PageTable() to identify constructor-backed tables and run the
>> matching destructor before freeing them. Keep reserved and
>> constructor-free tables on their existing paths. This also prepares
>> vmemmap teardown for generic runtime allocations through the normal
>> pgalloc helpers.
> 
> Could you please take some time and trim the bits out of this changelog
> that the LLM inserted but that are not super relevant? For instance, I'm
> not sure what the first paragraph is trying to say. It is apparently
> missing some context.
> 
> FWIW, I really don't like the LLM changelogs on their own. They almost
> inevitably need human editing to make them usable. I really, really
> expect humans that are sending x86 patches to spend some human
> brainpower on them. In fact, I expect folks with:
> 
> Assisted-by: LLM
> 
> to be sending _impeccable_ changelogs in v1 because their LLM saved them
> so much time that they can spend gobs on their changelogs. More than
> ever. ;)

I agree with the general point that LLM output needs to be carefully
checked by the submitter rather than adopted as-is.

However, I think the first paragraph is relevant. It is intended to
provide background: commit 49f599666420 changed the behavior of
pte_alloc_one_kernel and should be canditate for Fixes tag. The second
paragraph then explains that HVO depends on pte_alloc_one_kernel, so
that change also affected HVO behavior. The third paragraph describes
the fix. So the changelog does have a coherent structure, even if it
can be trimmed.

Of course. I just wanted to explain that I did review the LLM-generated
content, and that I did not simply leave it unchecked.

> 
> Oh, and it's an x86 crime that we have:
> 
> free_pagetable()
> and
> pagetable_free()
> 
> Any work that makes that coherent would be much appreciated.

Maybe rename free_pagetable to free_hotplug_pgtable_page in
a separate cleanup patch?

Thanks,
Muchun

