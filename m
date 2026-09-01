Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB04CCDE8;
	Tue,  1 Sep 2026 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788242607; cv=none; b=taK3fZkioM3dHKy2qKvyu5zYEuxS2Asrvv4JI1dxksvtexdQEV9qznH7nymwdtLle1I3UWJDSxt9miUi0OmTXI9eAzyFv/hXAK0zfhiZ18f+qE9lPX6bkxgwKrFhKknGVEVRiymVmyOBOEpo3DAiur1Na2RNp+NOYCebx1pVbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788242607; c=relaxed/simple;
	bh=EMILxeSo+x247RV8NHHT526oEoCUszKjH0K8y9tHbPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hknNz1k4PNv3HDxwQf/YzGOfRAC9/CmY3h+SMELMWlIAp5I0yHH+W0PPCQYLVgJNS2+YlEnipkjRJc1C87eTagtqQquy2TEzbQHxj09loEVbhslmeFVAJbZgalWgytHzgac2WaBOcyqufXZhpeWg1A6syuM20pgYOcEPuiKLJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUhhVyOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUhhVyOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED331F000E9;
	Tue,  1 Sep 2026 06:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788242606;
	bh=OVVXt6GL/R8LJuqc2RyttdvOJVfaBZ9xBw2X4e233ZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MUhhVyOwcEp4HPu4Hpq3eXRNrfCeVbDYxsEItQhTwKCEOCTJBgGPimPAYXiVMXRm5
	 KxXPYs6FlAjLeibRwDqpu8hEhq4geSlr5sRws3WKXI0CmrbdW22WNlK/fX7BB1OmKC
	 wkXldLmkyUF0EHGZ8Girh5GhTy7ufzRDnkMATzULhDfgFSfc9+/kyzbSrl3FaZKIfz
	 GnA2102sdMy5dlNQY5jgjHDRMUVmSjMQWdUlLzcKdF9SuINcoi03MmBZj5Wpwc79GR
	 Vxk/lKf8hYn8UtMgTPIsWlcmVVqgs+Skn4Ohb/iTnVdouYfETRn5oso1LneCaopZ3j
	 mJp3IJeMfG4LA==
Message-ID: <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>
Date: Tue, 1 Sep 2026 08:03:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/mm/pat: Acquire init_mm write lock on
 collapse to avoid UAF
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Will Deacon <will@kernel.org>,
 David Carlier <devnexen@gmail.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
 <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01. 09. 26, 0:27, tip-bot2 for Lorenzo Stoakes (ARM) wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     be4f4ab413d15e2b44f6bcda3b607eb707a7712e
> Gitweb:        https://git.kernel.org/tip/be4f4ab413d15e2b44f6bcda3b607eb707a7712e
> Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
> AuthorDate:    Thu, 13 Aug 2026 12:01:24 +03:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Mon, 31 Aug 2026 15:14:58 -07:00

The committed patch to tip is bogus. It contains only the guard definition.

> x86/mm/pat: Acquire init_mm write lock on collapse to avoid UAF
> 
> x86 implements page attribute modification using its Change Page
> Attributes (CPA) mechanism.
> 
> This tracks properties of ranges such as cache mode through x86 page
> attributes, and as part of that logic manipulates kernel page tables.
> 
> Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> fragmentation") ranges of kernel page table entries can be collapsed into
> huge page table entries as part of this logic.
> 
> As part of this collapse, it frees the page tables which the collapsed
> entries previously pointed to, and it does so without any relevant locks
> being held to preclude concurrent kernel page table walkers.
> 
> The only way this code can be reached is if CPA_COLLAPSE is specified, and
> this is only set in set_memory_rox() via:
> 
> set_memory_rox()
> -> change_page_attr_set_clr()
> -> cpa_flush()
> -> cpa_collapse_large_pages()
> 
> Notable users of this are execmem and bpf when manipulating executable
> mappings.
> 
> However, this is problematic for ptdump as it walks ranges it does not own
> and thus runs the risk of a use-after-free on page tables freed underneath
> it.
> 
> In addition, concurrent CPA collapse operations are possible which can also
> cause races.
> 
> Resolve the issue by acquiring the mmap write lock on init_mm across the
> whole operation.
> 
> It is safe to acquire a sleeping lock as all the callers invoke
> set_memory_rox() from process context and in any case,
> change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> mutex, disallowing atomic context here.
> 
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Will Deacon <will@kernel.org>
> Reviewed-by: David Carlier <devnexen@gmail.com>
> Tested-by: Atish Patra <atishp@meta.com>
> Tested-by: Nikunj A Dadhania <nikunj@amd.com>
> Cc:stable@vger.kernel.org
> Link: https://patch.msgid.link/20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org
> ---
>   include/linux/mmap_lock.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index bec0eab..b8a13b8 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -630,6 +630,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
>   DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
>   	     mmap_read_lock(_T), mmap_read_unlock(_T))
>   DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
> +DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
> +	     mmap_write_lock(_T), mmap_write_unlock(_T))
>   
>   static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>   {
> 

-- 
js
suse labs

