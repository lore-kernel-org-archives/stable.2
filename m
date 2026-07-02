Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BAD42A790
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981231; cv=none; b=R1W3lTxTne6B3t41YNsUDnlCdSCf8ctwsnAVM5MZYKbH4AznZ+XECQA/PN2NopfP4k+3IcL6GmY3i+MKnLDetkov39oUee/K6DQk+8TgiBWSdU09CPOTofK5bESeVL/haQxKouq6GcYncHOIJ6pB04VZkQTCBrXCV5Hm0B34L3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981231; c=relaxed/simple;
	bh=B8tJJylgSzwicd4/Ou8KHfoy0REk1bTZoXh89fMGD30=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XSU62+bpqKTfFhf574fyh45ZnNnBKuln4f84hVVmyQ4pWdDlLkq77OE+Rgm3rMEsLsUa5alTPLdECEsfYQjxK31T0k+ilSMODZcW7dIKK8YwK381FHnMC0nwgbecqLfZXeXjSyT6TiXm19CI3bwy7i+TginMHJC2jFOgWulXn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJ0Y0Aqy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJ0Y0Aqy"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782981227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyxPIQyiRY94UmnatdvvXHm0PH6iQcFy569ksBi+Ngk=;
	b=SJ0Y0AqyMS9M2n2QZLRzV1CPGIMZPLVfRQEKWNUmoYjG8lKgVlBsK23Sq7KAs/mmzgEz+r
	yA/YQ+R4wSRzWGwmuCE7yTqfBDSlerC0fAv8AtZef1qE5HYDgFwTX2JGVoxG7O1hdV5b/4
	JZKbHPW3AKseFmIiWCmAGoK0KJTfGys=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 5/6] mm/page_vma_mapped: use huge_ptep_get() for
 hugetlb
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260702051341.126509-6-dev.jain@arm.com>
Date: Thu, 2 Jul 2026 16:33:06 +0800
Cc: osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 david@kernel.org,
 liam@infradead.org,
 riel@surriel.com,
 vbabka@kernel.org,
 harry@kernel.org,
 jannh@google.com,
 lance.yang@linux.dev,
 kas@kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com,
 apopple@nvidia.com,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 gourry@gourry.net,
 ying.huang@linux.alibaba.com,
 j-nomura@ce.jp.nec.com,
 nao.horiguchi@gmail.com,
 ak@linux.intel.com,
 mel@csn.ul.ie,
 pfalcato@suse.de,
 jpoimboe@kernel.org,
 dave.hansen@intel.com,
 tglx@kernel.org,
 catalin.marinas@arm.com,
 will@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6518FA25-16CB-4BC3-B724-B075B0D1B425@linux.dev>
References: <20260702051341.126509-1-dev.jain@arm.com>
 <20260702051341.126509-6-dev.jain@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 2, 2026, at 13:13, Dev Jain <dev.jain@arm.com> wrote:
> 
> check_pte() is the final validation step in page_vma_mapped_walk().
> It reads pvmw->pte with ptep_get() to decide whether the entry maps
> the PFN range being walked. For hugetlb VMAs, that pointer refers
> to a hugetlb entry.
> 
> On arches which provide their own huge_ptep_get() to dereference a huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(),
> pte_present() etc to misbehave.
> 
> It is not clear whether this has a trivially visible effect to userspace.
> 
> Use huge_ptep_get() to dereference a huge pte pointer.
> 
> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

