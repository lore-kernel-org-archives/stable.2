Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814380;
	b=IMFoDlJJxf3P13OA/LlJRO98FoEFNx9x56vQwV1THuiqLHbxCG5FZ/55DvTgZQFex/rT
	 UYNVJZI7Tj09dz7Bv7EZUWkeH+ycrJcs9g7uPMELfLjLNJRvIi1qfWo5m0A/mEDKmIunG
	 A6L9ttz65H1yOkF7DfrZyISAfZTJfmSNHm/fXIJxKB0WicHlu13F6HeZQqwwYndrLD9Pn
	 QvbCx4fSdQ+mSuipWpG/lmeNpDeeGZVQFgt/5dSNvtc+qyVHUTtxCWcKiVsbjtrV04ywD
	 ljZC47IDNAen2Zvi7eTR7CtCs2lmfLXGe/5bB8IskkbdcLKXv+6Z2L8ShH1/D+sQb4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814380;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1Lb0d+nlQPwj2uxwrjLTKUVhOeG90QM798BTau5rOQU=;
	b=Ii14Ywu5EsRuLnqyT+fczMMdSq6nOqy/is/HaaG5R2RRGXTuss4H26Hs/ZJf5oye28rs
	 752oWuNFgd9SBMq7TORq/TKhYTktpVXxCGc0f/7jaD/WCfmuzGukXzyitgDBNHo33wDmg
	 7qeFO0W7e8eGUWcuAhRP2OaYS+8nyXpxfrCed3LZtl/rSIsPjf5/UP83JvaPiybMNARZe
	 HFVxyhbyfRptq2B1LPn25QYfdXaXMyHmc4dn+l18/xQHh/+c1bZIdaJ+BLa8Xa5LQEift
	 Gaq1Uz5BkxczalT84vVklFU+kL+ImltHHBKJDuRDonp7DzF/tjvyARzgwcjlTmuHc0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aIT7S67W;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D71606A31C;
	Mon, 16 Nov 2026 07:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aIT7S67W
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794814375; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1Lb0d+nlQPwj2uxwrjLTKUVhOeG90QM798BTau5rOQU=;
	b=aIT7S67WovzDeADTdzTC5uHCMJUj0JPN/oWtXIZK+F2DGHkeokGy0A1tCbRGCXVip6FSkXuyL7tGPpDFAM/OpNEI6c7KsUUTMVkuvsGTy52eAXJCB1mNk2DzQ8SyeA25WUazsJdUZooFFc9SecZ2HMfengSzapzfLImwMeKFP3s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XEnXkf5_1794814373;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEnXkf5_1794814373 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 15:32:53 +0800
Message-ID: <4bbe4321-ab91-40e4-bd15-6428660d8ea9@linux.alibaba.com>
Date: Mon, 16 Nov 2026 15:32:52 +0800
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
Subject: Re: [PATCH] mm/huge_memory: flush dirty file PMDs before removing
 rmap
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, Ross Zwisler <zwisler@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/14/26 1:15 AM, David Hildenbrand (Arm) wrote:
> Unmapping a file PMD can lose concurrent stores when it races with
> writeback. zap_huge_pmd() removes rmap and drops the PMD lock before the
> gather flushes the TLB. Writeback can then clean the folio while another
> CPU can still write through a stale writable TLB entry. Those stores do
> not fault and dirty the folio again. Filesystem DAX has the same problem
> with its dirty tags.
> 
> Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
> has been flushed") fixed the same race for PTEs by adding delayed rmap
> removal to the mmu_gather infrastructure. The PMD path still removes
> rmap before flushing.
> 
> Flush the TLB under the PMD lock before removing rmap for dirty file
> PMDs. Skip the early flush at address-space teardown, when no users
> remain, and for mappings without writeback, including shmem and device
> DAX.
> 
> Use tlb_can_delay_rmap() to share the PTE path's architecture checks.
> On s390, clearing the entry already handles TLB synchronization, and
> __tlb_remove_page_size() immediately drops the mapping reference, so
> rmap must be removed first. UP cannot have concurrent stores from
> another CPU while holding the page table lock. Make the predicate
> side-effect-free and set the gather's delayed_rmap flag when an entry
> is actually queued for delayed rmap removal.
> 
> Queue the folio before the early flush, while the gather still has a
> valid range. Keep batching references and drain a full batch only after
> dropping the PMD lock. The early flush resets the gather's TLB state,
> so draining the batch does not flush that range again.
> 
> Although writing to files through mmap is generally discouraged,
> unmapping such mappings may become slower: each dirty file PMD now
> requires a TLB flush under the PMD lock. Future work should properly
> extend the delayed-rmap machinery to PMDs and hold the PMD spinlock
> across multiple entries, so their TLB invalidations and rmap removals
> can be batched.
> 
> Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
> Cc: stable@vger.kernel.org
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/linux-mm/aoWw_iKEDLjKL2jr@thinkstation/
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Suggested-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
