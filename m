Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9444BCA8;
	Thu, 13 Aug 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614375; cv=none; b=YxnA1fWXJeZtrTt5Yxl80v/uKtqnf246K3KI+Rx+uUosFUKSPtE05yqBdsMpvNU6/9Dku02JOMEz+hT4K9yX0ZZ+sws5Y931fhoCmFujPGlLpSsWK9bhYzQFzWTK6KxqBy6OjHRnJFdCLLtlvRrJq0qgb+ZKcSEYNMRe6fLTBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614375; c=relaxed/simple;
	bh=AiIRtIowgb+uuTFbjnZI39k2QY6jaawhgvey9PCCIyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9bWJ91h9sXVIvR/HreJ0fLoLPA5/1vg0Jgi5bcM6SzW7gDj+dQ9WvWIO9n8hm/IkPCfAKWkQReFxbZrH6nNazEaV3q6hiCDxMC+sI5si1cqaxGw6zGSMjPZAd8p29TYFvmI4CFv0c8mAgqeGB1gLlZglU3qonEzPejdOSIfytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKnQd5xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKnQd5xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D021F00A3A;
	Thu, 13 Aug 2026 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614372;
	bh=+x2tiBGgnfXYaaYiZV+xganvGkJiR/qvbRK36a01nqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DKnQd5xlGQw8aHszKjwfbFCCC8y3Y7nwaZ0WSBdqVQgD7c4L39ViTScf20Tx2H0Tc
	 qSF5ay3tU4XMK8P3l9UG03o2FhYZZGlQK3EmSVggbqr6RVQV5wTpZQQSMBgqoVpnHY
	 /auQxWhMNLIDXnBsrBUjwNIgBOb0koxdy77mBXjQWwZRY+scOqG7bbIFoehCaqw8CT
	 +zLSgJUul/UYABxCySVnf8x2W0XiJA+JayL1r34pqVMZTLIOj6OKxlqkvUTqRv4LrR
	 /ZHKqBbBbam8hdsA/SdaE0v/ew0RIVcBt2IA+buPMpHBD4Opr6/oxZiQAcquf3MPAT
	 S178E9QyFkVAg==
Date: Thu, 13 Aug 2026 10:45:48 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Steffen Dirkwinkel <lists@steffen.cc>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com, x86@kernel.org
Subject: Re: [PATCH v2 5/5] x86/mm/pat: fix effective RW computation in
 lookup_address_in_pgd_attr()
Message-ID: <an2Q8Blco1diidCy@lucifer>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
 <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>

On Thu, Aug 13, 2026 at 12:01:28PM +0300, Mike Rapoport (Microsoft) wrote:
> lookup_address_in_pgd_attr() accumulates the effective NX and RW bits of
> the walked page table levels so that verify_rwx() can detect mappings that
> are both writable and executable.
>
> The RW bits are folded into a bool with
>
> 	rw &= pXd_flags(*pXd) & _PAGE_RW;
>
> but _PAGE_RW is 0x2. So consider the accumulation line:
>
>         rw &= pXd_flags(*pXd) & _PAGE_RW;
>
> where rw=0x1 and the right side evaluates down to 0x2. It'll end up doing:
>
>         rw = 0x1 & 0x2
>
> and rw always ends up 0.
>
> This way rw becomes false at the first level walked, regardless of the
> actual permissions, and verify_rwx() treats every mapping as non-writable
> and never reports a W^X violation.
>
> Add double negation to the right side to normalize the _PAGE_RW flag to
> 0 or 1.
>
> Fixes: ceb647b4b529 ("x86/pat: Introduce lookup_address_in_pgd_attr()")
> Cc: stable@vger.kernel.org
> Assisted-by: Copilot:claude-opus-4.8
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Yikes, good find! LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/x86/mm/pat/set_memory.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index fbc418dfc597..430d0b448371 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -754,7 +754,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>
>  	*level = PG_LEVEL_512G;
>  	*nx |= pgd_flags(*pgd) & _PAGE_NX;
> -	*rw &= pgd_flags(*pgd) & _PAGE_RW;
> +	*rw &= !!(pgd_flags(*pgd) & _PAGE_RW);
>
>  	p4d = p4d_offset(pgd, address);
>  	if (p4d_none(*p4d))
> @@ -765,7 +765,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>
>  	*level = PG_LEVEL_1G;
>  	*nx |= p4d_flags(*p4d) & _PAGE_NX;
> -	*rw &= p4d_flags(*p4d) & _PAGE_RW;
> +	*rw &= !!(p4d_flags(*p4d) & _PAGE_RW);
>
>  	pud = pud_offset(p4d, address);
>  	if (pud_none(*pud))
> @@ -776,7 +776,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>
>  	*level = PG_LEVEL_2M;
>  	*nx |= pud_flags(*pud) & _PAGE_NX;
> -	*rw &= pud_flags(*pud) & _PAGE_RW;
> +	*rw &= !!(pud_flags(*pud) & _PAGE_RW);
>
>  	pmd = pmd_offset(pud, address);
>  	if (pmd_none(*pmd))
> @@ -787,7 +787,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>
>  	*level = PG_LEVEL_4K;
>  	*nx |= pmd_flags(*pmd) & _PAGE_NX;
> -	*rw &= pmd_flags(*pmd) & _PAGE_RW;
> +	*rw &= !!(pmd_flags(*pmd) & _PAGE_RW);
>
>  	return pte_offset_kernel(pmd, address);
>  }
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
