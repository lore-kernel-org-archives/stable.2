Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73A35C6AB;
	Fri,  9 Oct 2026 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578314; cv=none; b=lPQqDRhLvGqbyV9d6eQBdgr06O10wJTyqFjTfS5T+ZFPeaOyEJzjDXDi9A/wZN7btn2w6lyfugUObIK09O2gDaiPB9tbr2fMs3WX/UvER2J5h6qfj9z6KiZuINGb0Dfj8tt/2yEzm5QDTyAkdHGv7sZq9rrfeHuXuB4hygFURaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578314; c=relaxed/simple;
	bh=c8a3P2CDArX4OxL7tNj7K0DkfxaUmqKkD9v76qbBMp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa90hkvEDXLh18yhSCs4A0nghBurDEvCNuphqARaKTz1Wjz6XGw4vrURhnWBMRFbvEg9FQzyETaFJetaKCQKcX1N1+y2ejoM6fw59j9o4Nj2SlZKWzlgFDUfEMbzXxLt08oZrtB4VxKiI4FJXBubOK97OYJ53kKToa6uzUqhqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvqHjuD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvqHjuD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BA71F000FF;
	Fri,  9 Oct 2026 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791578313;
	bh=y/LFL9/taYy2cwYsCSPk5V+auF0O2Bb7JZnwWhgA5BM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SvqHjuD7DSfowHNh97rZu6v7FwWPLex9GA7soWzWsQyNKB3v+LPC7fwAAR3ezbMLl
	 erYo4mOcocXZC5ZmtfEJaN41zkSVTFR4PlQmnVVNWNDFcMC12BAsjhJYonIvVvu14L
	 VlwHac6QlAjyMbDCg31XU03b5H1B/dLLPYc1U+rhhQL/sRyHgK//6KHAmxvyEgyZGm
	 2h5t1E1zdqHKyBlZJSr3+zRABa6ESRxS+W2CUpWtixr9tF3hZ5jrpm2HsUWTamEqBu
	 3yusekEt9FrzHkzQMrrH/q100cNJnk9dmxr/9cVSMVjwqE/VO9+dJS/7jbQQhpfhmu
	 myCIGW/rN3tkA==
Message-ID: <32191a71-b5b1-4913-a631-968ec299b125@kernel.org>
Date: Fri, 9 Oct 2026 22:38:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] riscv/mm: fix missing destructor for hotplug PUD
 tables
To: Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, osalvador@suse.de,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, agordeev@linux.ibm.com,
 kevin.brodsky@arm.com, bjorn@rivosinc.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, muchun.song@linux.dev
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <20261008073021.2512665-4-songmuchun@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261008073021.2512665-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 09:30, Muchun Song wrote:
> Commit 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel
> pgtable alloc") made alloc_pud_late() run the PUD page-table constructor.
> However, free_pud_table() still frees non-reserved PUD tables directly
> without decrementing NR_PAGETABLE.
> 
> Free PUD tables through the common free_pagetable() helper so that
> constructor-backed tables run the matching destructor before being
> freed.
> 
> Fixes: 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel pgtable alloc")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/riscv/mm/init.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 429a0b015ec1..62077539ee78 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1540,10 +1540,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
>  			return;
>  	}
>  
> -	if (PageReserved(page))
> -		free_reserved_page(page);
> -	else
> -		__free_pages(page, 0);
> +	free_pagetable(page);
>  	p4d_clear(p4d);
>  }
>  

Routing this through a single helper looks correct.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
