Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B091D47142B;
	Tue, 13 Oct 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906395; cv=none; b=BCEKB6ALXG2g7ouisbUG6SIJ/knh6SLSgyLdjlAuCSoUpQrY2oxaX3zuCCFpaMyjghPK8DnpxuoAXXjxCmWPsjMJvfPP0afaiOmiP67VZS+BbwxoPRFLB5U0hKMsyGd9HJR4Ns05VQ74sa4p0HLqlM/uiw4+80y834tmBLYs+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906395; c=relaxed/simple;
	bh=eMq2mDhfJOst6GyLz1Fcuo6efNgXRerZYOqtWjNZhOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4RcWnYc4ZUIci7n46XaPKhEpwCCuvlLiiUgU7kbYximHXpm9PdC22GU+N3RztOgjcvkWgdvG7TA31tbj6hWCkpI/W1uiD4BaX6ZHLsu4Rmo7h0XSrNDcrHaf4ffoKlRPvqEH+JULJ1cUEEWDYujjKgBf6rFS0nypVuLcOx+AsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kgXLF/sO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kgXLF/sO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 278D7169E;
	Tue, 13 Oct 2026 08:46:24 -0700 (PDT)
Received: from [10.57.13.106] (unknown [10.57.13.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE6DF3F673;
	Tue, 13 Oct 2026 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791906387; bh=eMq2mDhfJOst6GyLz1Fcuo6efNgXRerZYOqtWjNZhOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kgXLF/sOnmA/PaXP6KqDXjeIIPMuJW8hGp/vG4LTJIbgJAMKEq+rFi9KOnkBxr2Mp
	 bkt1V8H8Xs7ERmZYQ5D/uHy1DT8Mz3tJmtmFa8Gd2DjouQowQllwPE6ZsV7jtWw/y4
	 j1YlZw8422v0Rx693Qyax36zmWLe8F6JxZOz0ID4=
Message-ID: <d63f1f76-5bfe-4206-b6ce-189d6948a909@arm.com>
Date: Tue, 13 Oct 2026 17:46:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] riscv/mm: fix hotplug page-table destructor
 handling
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
 <20261010112457.49485-3-songmuchun@bytedance.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20261010112457.49485-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2026 13:24, Muchun Song wrote:
> RISC-V uses the same memory-hotplug teardown code for linear-map and
> vmemmap page tables. Late linear-map allocations run page-table
> constructors, while vmemmap and early allocations may not.
>
> free_pte_table() unconditionally calls pagetable_dtor(), corrupting
> NR_PAGETABLE accounting for constructor-free tables. free_pmd_table()
> avoids that for vmemmap using is_vmemmap, but mapping type is not a
> reliable proxy for constructor state. In particular, it becomes invalid
> once runtime vmemmap tables use the normal pgalloc helpers.
>
> Introduce free_pgtable_page() to select free_reserved_page() for reserved
> pages and pagetable_free() otherwise. The latter runs the destructor only
> when PageTable() is set, handling both constructor-backed and
> constructor-free tables.
>
> Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
