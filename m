Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC552ED39;
	Tue, 13 Oct 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906408; cv=none; b=X0Z/UMshibxNz+OmEWdErBRyP5P5wJQmUcu9llCrdYoDBMxC71o2++FAZwwM6zlb7NBszw/DVwg120ipo3JSAu9iH0oCcbBY7xrAYF8o9SRqMiGY3JeajKn32np89tHvA4+u3vge1VIRTjkSa3RgPpRZGTXqt4PikjUeLgIYG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906408; c=relaxed/simple;
	bh=JeRaURUo5EbmMLuGd0BOhxrctGp6NHfz84lMXFt/WCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdUsf8MhgQtHBEXPW6gK/WiGu1kzqz2JgXyZVYtQkll7+hPea+I615bvxgoIIrH9QuMgDagCrqaKFlfVsQC9TGlFNWrOeky76LHoRVMAtxJKVWENYcE1BKwWdy8hXD07fhcsxkUt2ijKOVPsXIBH2nrqmr6dyMoj0yQLjAaUlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X75FUdGM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X75FUdGM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D442A169E;
	Tue, 13 Oct 2026 08:46:41 -0700 (PDT)
Received: from [10.57.13.106] (unknown [10.57.13.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4FF3F673;
	Tue, 13 Oct 2026 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791906405; bh=JeRaURUo5EbmMLuGd0BOhxrctGp6NHfz84lMXFt/WCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X75FUdGMBAZYYdPrK2BcgKxQkWiUuX/Mev7U3QTFrR/D2ZaBM94pw0qWGcNhIsrhi
	 HNgW0pdzZ0TS8JEbWeGOyWyZ+WWETzZd6VBjM69GJs3SFC+HdmB5a8oKbOxUfqjRFR
	 QT19CD1NHaJSx1sqnq4l1v9tXFIlJQAsH36l+TS4=
Message-ID: <9a36345e-5301-4636-aabe-557d923e61f9@arm.com>
Date: Tue, 13 Oct 2026 17:46:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64/mm: fix destructor for unconstructed hotplug
 page tables
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
 <20261010112457.49485-5-songmuchun@bytedance.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20261010112457.49485-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2026 13:24, Muchun Song wrote:
> Commit c594b83457cc ("arm64: mm: call pagetable dtor when freeing
> hot-removed page tables") made free_hotplug_pgtable_page()
> unconditionally run the page-table destructor. This matches page
> tables allocated by the arm64 mapping code, which runs the
> corresponding constructors. However, arm64 also uses the generic
> sparse-vmemmap population code. Runtime intermediate page tables
> allocated by that code do not run a page-table constructor. Freeing
> one during memory hot-remove therefore runs a destructor without a
> matching constructor and corrupts NR_PAGETABLE accounting. Free
> intermediate page-table pages through pagetable_free(). It runs the
> destructor only for constructor-backed pages and then releases the
> page through the page-table freeing path. Fixes: c594b83457cc ("arm64:
> mm: call pagetable dtor when freeing hot-removed page tables") Cc:
> stable@vger.kernel.orgAssisted-by: LLM Signed-off-by: Muchun Song
> <songmuchun@bytedance.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
