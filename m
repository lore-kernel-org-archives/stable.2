Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120778;
	b=aaaOLvxWPzqJot6cDMUa5b70aQTECsfWompwzUByCel1lYSeQIGb25NrND7uICsS4OFC
	 xIntoFou+xzKMi2YCVDDMQE3jkBgZHWkPaC5x2fX9UkpB3y06oQBrZbt9u/bPxzTgUPmo
	 1EYwf1W9ZeQUCICGUJ7irjXmUFwUqUAFKdwLgiPDNQcvqoSZH3E3zirpjh1/laJrDdMd7
	 vww4+lZ0WpAXzgmEJVSfeIGX/olUZ6Vd+IZWcpwam8+FEchcLjziOeMsx4RVZGGsKGo9X
	 IRfHI5CFRaHU+AXVhxR0ux8hmDUQWRvkUSRwUpphI4swe3cXlAWsEYe8R4FvNw/O+Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120778;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CIRKIW6FyjGByuy1vcj3Kaosm6T+AEo/GoygfORs3IQ=;
	b=kPU4sTQR3u+23ZwYwxjOjhbMxEr9CH8WN/rhXwBcFV51vjN7o+x+niTaNLCzCw7Ofnub
	 SVrF0FBy/fOooSJEhrvs+fvk11oFjfYqS7L8auNxeDgLTO2fDSGWsCW101WTFuik58leS
	 +lhG0a5xSaqBfpWD2RsSiBYPBHWs+RnkiYDtEwgTXAbKjyzan+52v2huH3NmHJIp/2C+U
	 9+28SaX/aEq4alUFFrgWvi2R6DEuPtyWkwSp1ecXkajD/UhL1gow26QrrVhVqbyLwSRxi
	 0RdHtD6cax8gR29f1TLJ9aoobzHGN0whsC95BP1oNw5ajwRNwI1fMwJtUR45yoUPjZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LX9oQFb3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3B606A320;
	Tue, 27 Oct 2026 17:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA3B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LX9oQFb3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D61871650;
	Tue, 27 Oct 2026 10:06:12 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FEFF3F7B4;
	Tue, 27 Oct 2026 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793120776; bh=YfBOcf/1p0yKe28rQCyfQziZDw3iZcDMCiJAcTFH3s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LX9oQFb3JCU/nRh3HOHfyGm75yvY2AqOJkXgl4H1OUrL+YV/yfv5t2j4NyOmkDQk9
	 wJjiz2smZNW3BasgYXW2q2tqg9DtW18Hjbi6WScVSvfUxSgq2xS9N/BwOrfVKoiH+i
	 KRo062zN72Uh7zYRswDgomQDOFjW4Mykh8WDYZzM=
Date: Tue, 27 Oct 2026 17:06:11 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Hansen <dave.hansen@intel.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 4/4] arm64/mm: fix destructor for unconstructed
 hotplug page tables
Message-ID: <auDaAw5IR-ZFvqJ5@arm.com>
References: <20261023063428.3658761-1-songmuchun@bytedance.com>
 <20261023063428.3658761-5-songmuchun@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023063428.3658761-5-songmuchun@bytedance.com>

On Fri, Oct 23, 2026 at 02:34:28PM +0800, Muchun Song wrote:
> Commit c594b83457cc ("arm64: mm: call pagetable dtor when freeing
> hot-removed page tables") made free_hotplug_pgtable_page()
> unconditionally run the page-table destructor. This matches page tables
> allocated by the arm64 mapping code, which runs the corresponding
> constructors.
> 
> However, arm64 also uses the generic sparse-vmemmap population code.
> Runtime intermediate page tables allocated by that code do not run a
> page-table constructor. Freeing one during memory hot-remove therefore
> runs a destructor without a matching constructor and corrupts
> NR_PAGETABLE accounting.
> 
> Free intermediate page-table pages through pagetable_free(). It runs the
> destructor only for constructor-backed pages and then releases the page
> through the page-table freeing path.
> 
> Fixes: c594b83457cc ("arm64: mm: call pagetable dtor when freeing hot-removed page tables")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
