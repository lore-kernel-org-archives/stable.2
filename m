Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC313D88F7
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386781; cv=none; b=aZ7mWTGJzBh3/GKdR1T1KxDdP2HKW/LSzRsf+hIQP6GdDw3KPEXguq4pW9fBbLzL85t/xwkxhvN2V1PVnKR1FeuRMZumKmZ0tolG56e3rvdccwRYz1AKlYOT5A6Z4SJDsgH2n1eOk7RpwCTNO8PwDly3JpH5mapnpUG+0TNbFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386781; c=relaxed/simple;
	bh=Uc/Rm/8WbppIw3KMH18yWQrNEi8EgOmOYl4vwnXvZPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzyTGY00FsTjeSUIGmzzU4kPiwzLpe7IdkyVPUpUhu+gDh5pB4TJVd7wZbZJLytNHWYEQC/JWIWuYF/UH/e5SZ/F2I5BhZjJpWodNg48tdSJ8pd4G8iCfG3+Yt+uyYyhAqHIDmylVkwYdqopWNXgjm4vFhDWjkJEYEBLRszZzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6UyviYp; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y6UyviYp"
Message-ID: <b6c11065-8e4d-4d27-baf6-e94c1db51175@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782386767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8lDCA7qPRr9jNsO+3q9qYqPG2WVRS7I1dNqVMGwaE8=;
	b=Y6UyviYpeIDfCsWOPdJyWLxNNBjydnptTaNt2p5gWx23Z2RluaCf6poV/r+diWTABfr+I0
	HIH98jXon0jcczHx7fpTBUxLcBLzRXSWHMwF4VC1cTs2Pyb/R8J9B01RgCv1HGo/3YLJNC
	J3ycJAZ3UrXM9cEZ7Csv2aPEimTX3kQ=
Date: Thu, 25 Jun 2026 19:25:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD
 handling
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, balbirs@nvidia.com
Cc: akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 ziy@nvidia.com, sj@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <20260624085756.6598-1-lance.yang@linux.dev>
 <20260625095728.woikmkxb6gskth3b@master>
 <2252683e-df5d-47ce-b15d-1036bef8d063@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2252683e-df5d-47ce-b15d-1036bef8d063@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/25 18:37, David Hildenbrand (Arm) wrote:
> 
>>> CPU0: pmde = pmdp_get_lockless();   // sees PMD migration entry
>>>
>>> CPU1: remove_migration_ptes(src, dst /* device-private */)
>>>         ... via rmap_walk(dst) ...
>>>         page_vma_mapped_walk(&pvmw /* src, PVMW_MIGRATION */)
>>>           returns with PTL held for the PMD migration entry
>>>         remove_migration_pmd(new = dst page)
>>>           installs a device-private PMD
>>>         next page_vma_mapped_walk()
>>>           drops PTL via not_found()
>>>
>>> CPU0: takes PTL
>>>       pmde = *pvmw->pmd;            // now device-private PMD
>>>
>>> So when PVMW_MIGRATION is not set, current code can return not_found()
>>> before we even decode the locked PMD as a device-private entry.
>>>
>>> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>>> device-private entries") made the
>>>
>>> device-private PMD <-> PMD migration
>>>
>>> transition possible.
> 
> Doesn't the folio lock help here already?

Ah, yeah, I was too focused on the PTL and missed the folio lock ...
Don't have a caller like that :) Went over the fix again, nothing
else jumped out.


