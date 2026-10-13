Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E0152E07C;
	Tue, 13 Oct 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906398; cv=none; b=IGUDThUF9Ck7/3/rP5FuNL95tbO1B6MA9wS07rNVcyOt0x77nAcx/oCSH/nl+GdBAwhkgNCNgXSeG+D+5rxtH9BTemcFmp5Lgul8gka5bVH1qH/xAxeGl5khHjBeW4ay0eLwM+/iJ1jqcC/K/iV3whVIPGAznktH9fByNwd7NS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906398; c=relaxed/simple;
	bh=0+SkemdQ5RdIVSDhFwk1CDFjL1ey9nZZXcddJZzDyn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1YoCmVYFqCO7uEDfOfdEEP8ncEakG0qsvqE9fCgu7ULPxvZ2j9jkA7cTrU2zYUl3a91BxAu5wz39vJTKl+4zOKUAh4TRYJEDUV2nUg7RFHrEugl25nYQOPWNZTpE4s+Zec7tE9ZRlaMPcCCykEEKcdEtryUtHfBSkxzWNSwS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lRhpxucs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lRhpxucs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210DA1650;
	Tue, 13 Oct 2026 08:46:33 -0700 (PDT)
Received: from [10.57.13.106] (unknown [10.57.13.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C3783FA32;
	Tue, 13 Oct 2026 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791906396; bh=0+SkemdQ5RdIVSDhFwk1CDFjL1ey9nZZXcddJZzDyn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lRhpxucs9r1hSijFNWdvNkrzvM+4YX3s8AQOkMMLTKiDkd8+VFpyiYfcSLMqt9IMJ
	 3VFIrdHZ8R6/NSTrS86UQbde7kSX4GQddPWf1kMf8bMHsbMZ5DaO09ya3CYUSyLmIN
	 qQRasCGUPcCGBWQSeFCJyxvTeA2ok7m6/IW+K14s=
Message-ID: <3eb77f76-1558-4b1d-a8ad-d25da8b0b68c@arm.com>
Date: Tue, 13 Oct 2026 17:46:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] riscv/mm: fix missing destructor for hotplug PUD
 tables
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Dave Hansen <dave.hansen@intel.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-4-songmuchun@bytedance.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20261010112457.49485-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2026 13:24, Muchun Song wrote:
> Commit 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel
> pgtable alloc") made alloc_pud_late() run the PUD page-table
> constructor. However, free_pud_table() still frees non-reserved PUD
> tables directly without decrementing NR_PAGETABLE. Free PUD tables
> through the common free_pgtable_page() helper so that
> constructor-backed tables run the matching destructor before being
> freed. Fixes: 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special
> kernel pgtable alloc") Cc: stable@vger.kernel.orgAssisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>Acked-by: David
> Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
