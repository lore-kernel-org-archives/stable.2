Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3F3C1F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782444313; cv=none; b=dGoXpdgumFUIWiLO8PqAH85QfBlSo/++uSu1f65GUV3cllwnxX+RcLEJ01mLkLnr8yIFpLR+xZ/ANFj8ltz0FbTR+ZIS0K0tY9u2Q5dwlGn6MrbofuFagcfqqlJFWmTpYCfP0XV4oUV6up3Q2HMzMIdVG4TUXa/sMr4wsdt5Th8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782444313; c=relaxed/simple;
	bh=Ux5+lGJwP6LBbsjx9rLhMSCweHr13fiQdtUrbhOlobM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tv06IZVeVORlXDhVtiD9a5G0octvUsLnnK4/RJ0SbruV5IPm1d7Dd1zsNKPdaKrXhJp/QFzdce9zK5zx0QAsEKfktJmZhMD9cVGWE2tZ5YJe8GboU3LwN0z4uSG+mcM3R2eY2NBOzfEDdw4ub+Qsk61OSRKfqdvFOg4N/HaZYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WLMnuF//; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WLMnuF//"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782444309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAXxVgUjspFRwFL/RkyK5xtXWU1EaEUoL3fXnAC+ilY=;
	b=WLMnuF//u9tPPAqJrZxZn4i0N40nEjPTUdUTFBNYBZ7b+NqKnvWWIXEkhC2M94T7rwC5nt
	slSAhdl1ejlz0D1vl4f8SzrXb1zgQXA9z6YzMaCN5NYNf/Q2xuiUPczuiuecOgCXc09z/z
	7EQW8Ec7zgRmcMiA6NYQYQjWZW0fcio=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 2/5] mm/rmap: use huge_ptep_get() in try_to_migrate_one()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260625112955.3254283-3-dev.jain@arm.com>
Date: Fri, 26 Jun 2026 11:24:28 +0800
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
 mel@csn.ul.ie,
 nao.horiguchi@gmail.com,
 ak@linux.intel.com,
 j-nomura@ce.jp.nec.com,
 pfalcato@suse.de,
 dave.hansen@intel.com,
 tglx@kernel.org,
 jpoimboe@kernel.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <35399716-4B47-4492-8168-B1F0AEFF6672@linux.dev>
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-3-dev.jain@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 25, 2026, at 19:29, Dev Jain <dev.jain@arm.com> wrote:
> 
> try_to_migrate_one() is used by folio migration to replace a present
> mapping with a migration entry. For hugetlb folios, page_vma_mapped_walk()
> returns the pte pointer to the hugetlb folio in pvmw.pte, but the code
> reads the huge pte entry with ptep_get().
> 
> On arches which provide their own huge_ptep_get() to dereference a huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
> etc to misbehave.
> 
> It is not clear whether this has a trivially visible effect to userspace.
> 
> Use huge_ptep_get() to dereference a huge pte pointer.
> 
> Commit a98a2f0c8ce1 copied the bug from try_to_unmap_one into
> try_to_migrate_one.
> 
> Fixes: a98a2f0c8ce1 ("mm/rmap: split migration into its own function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.	

