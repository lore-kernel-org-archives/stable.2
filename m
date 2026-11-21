Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258098;
	b=qY5YRy2FAGzy9wy76gHGr3thaaGGUD0qKo2OYyzsQQwT18RbkGg49be39PivSnVF8xzI
	 dzke8dLMVEMKdhb1ev3qAKtRtpJzsLCG92D5VF+uUZRZ1NII6RrI24qbG0IAB/yRLldJx
	 gtphoSW0Wr2eBq17MdBEpd1V/gYaaSst+PZcOjHN7/SvjnvNQ4sDBVOQ8bCr62NuQVrz1
	 0RlxA8CoQ9YRlyb1kQOoE0b8xU+zssctv52EJjh6IMO+W6WpVlPo75DflZGtgC9JdeoMY
	 683z/Kg/8LMsmrR31348mbPamnLNMGkY755ruLVVrcvIaXGg3qBTDUpjXZUF0LumUJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258098;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=H844ouKcu89wqaDaGvID9peNPao245E6sX0x5p75VlY=;
	b=l2OtqHkQ0w61TUj+FrxGNIxwwa7gH8kg4OHkdQBQlquxL1QorjHYJOMM8Mi9grAhs4Hc
	 HW3QVcF6Ttb0ujie8w5CIVsvKgp4wO3EbwYkLZxAlbxzNXSm2bAt0RXBMWOVvO+Y/jWhI
	 6btjV71vJZBnznoSfp2AtQU/qtqx5r9dQxXVhlC7y+jarrLLRNrW7nsYmK+pEyYcdEOnL
	 BT89W6bjdG/eddBqTBxK4k5rUxlUAGP3T4TSVmq9hqlehqAg5CLXh+CDG4+iDM/nz+zrH
	 +9cOh+/RJpM3L6Jr+PuxDS8NKgDBofr7tmRoaFqnLkHv7xiVsspM76quZDu6c5b/xvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Vc0/zWM3";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A936606A325;
	Sat, 21 Nov 2026 10:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A936606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Vc0/zWM3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6934D1575;
	Sat, 21 Nov 2026 02:48:14 -0800 (PST)
Received: from [10.57.93.173] (unknown [10.57.93.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D267B3F673;
	Sat, 21 Nov 2026 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795258097; bh=LWvhA+JKvTLjW7JOpSb4mg9kc3djq13jibSTget6C78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vc0/zWM38R8FTcWCHAViA0/Baa+4ZHh1v2TjkzkH/2li+snCxtoze+VH7hEqmS9pg
	 2Tzy4n83cHpQ5wkiBwlTHgAmWIDljCj/w/oxzt8Vd1l/dcVzFW+CiflosE6m9xE0iw
	 z95D0p1LJjTbpKknzcc96wZ3fm4g5DY4VFRMfuXg=
Message-ID: <100de3fa-ce00-4dd5-9a50-9182968b5a8b@arm.com>
Date: Sat, 21 Nov 2026 10:48:13 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: mm: Add an ISB after remapping the KPTI
 page-table slot
To: Fuad Tabba <fuad.tabba@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Kevin Brodsky
 <kevin.brodsky@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, stable@vger.kernel.org
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
 <20261120121638.194154-3-fuad.tabba@linux.dev>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261120121638.194154-3-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 12:16, Fuad Tabba wrote:
> kpti_map_pgtbl remaps a temporary slot with break-before-make, and
> kpti_mk_tbl_ng then reads the page tables through it. The make ends in
> a DSB alone, so the reads can fault on a translation of the slot made
> speculatively before the new entry was written. With the temporary page
> tables in TTBR1 the kernel's vectors are unmapped, and the boot hangs.
> 
> Add an ISB after the DSB.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> Fixes: 47546a1912fc4 ("arm64: mm: install KPTI nG mappings with MMU enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  arch/arm64/mm/proc.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 12aacc74f7647..7ca36d59bf77f 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -262,6 +262,7 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
>  	orr	pte, pte, pte_flags
>  	str	pte, [temp_pte, #8 * (\level + 2)]
>  	dsb	nshst
> +	isb
>  	.endm
>  
>  /*

