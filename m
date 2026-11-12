Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466622;
	b=RFEkwzsVdGnNCumK/YjUjBFrszCvHCYEXXwZEXhoeebLqTUmlryxb/ZbUofRCXjVJTlO
	 782BHqm38/x9wejqaq7mcZJ/X5g+EwjREF7BqVKS8ApRGEZZ7H1IekF8MQxNiqpo291xk
	 vtkXJGo/2nrOfYBk48jNF7q3u3cyyQdVXThxhjoSYpcoAXT4OfbIOPmCfEo/ZcjnXzDJD
	 Dcr5WTojKCUlM5uEd2IxANsyq6QdZeGJOHQ+Ozzf0f0qQGSPKdlJqWclsrMoOgLvI6um8
	 OzVu8Hw+2XszbXyUQ2aWcL/q7iwwBThxsJs4tGOePXd/z86MBaSC6wqHi6hA6oxnzrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466622;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JO6FW3tawApcJIwTTcR4zJNDJEYR841HkFnpVbs8+pI=;
	b=2PTs0SEPAQKAHdHOE5Rku1qqJpbGwm7ERhfdWi2bnOJUhIJHAzY8S7bdg/R1+Xjam4jT
	 m+qJrdKh1WHjCCzix/BBA6dnc6KTOia0A3/KQ1vGPLi4vk+WNVX+m1PmMorcS1gZxvt9H
	 1/R0N5DkmPKx0WUsy4zJqfrdFP0Z5WOWEVZlnYvpYoE9KW3jHYH5eXHfGtQBmo+CSMMl8
	 eL1KQsl/1/hZdS7iwgPSuCD/fSG3zmLvpyz9JNrT86AdMw9IRDFvs6vP+3s24eKqcfH2Q
	 bAP6d4l1DE0DAhqCp8suRld5G2iUbjdgMYYkgSy2cJv2bqZxAfyIv7BdCOgDFbGUUdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MSaSPZrw;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2F606A323;
	Thu, 12 Nov 2026 06:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E2F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MSaSPZrw
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794466616; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JO6FW3tawApcJIwTTcR4zJNDJEYR841HkFnpVbs8+pI=;
	b=MSaSPZrwSImpTjQeit7lfj3V7ivitCBnkn4/es+8mH5j77EqkfPublLS0WOasMlSPZoSZtVAY98yov4tdN23/CzsvVFv8s+eyQXgStJ9m8xndSdXNLNOKY/ECSMSRzBmNNVeRn8p4gfKrElg//KP+JJhkSwXDG7DMyVdYJE+Dls=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0XEbCXrk_1794466612;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbCXrk_1794466612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 14:56:54 +0800
Message-ID: <dc7e9478-6f03-4ee9-bf41-ebfc4a8f7edb@linux.alibaba.com>
Date: Thu, 12 Nov 2026 14:56:52 +0800
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
Subject: Re: [PATCH v4] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/26 11:19 AM, Zi Yan wrote:
> __split_folio_to_order() calls prep_compound_page() on each new head page
> to create a compound page after clear_compound_head(). prep_compound_page()
> uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
> and frozen and no one else is supposed to modify the folio's flags.
> 
> However, code calling migration_entry_wait() can reach the folio by PFN,
> then access its flags. It is because softleaf_entry_wait_on_locked() used
> by migration_entry_wait() sets PG_waiters concurrently without taking a
> reference and the frozen refcount during split cannot block it. Meanwhile,
> __SetPageHead() does a plain read and write, so PG_waiters atomically set
> by softleaf_entry_wait_on_locked() will be lost if the set happens after
> __SetPageHead()'s read and before its write.
> 
> One example code interleaving:
> 
> CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()
> 
> 1. clear_compound_head(new_head)
>     new_head->compound_info = 0
>     (page_folio(new_head) == new_head now)
> 
>                                             2. migration_entry_wait()
>                                               softleaf_to_folio(entry)
>                                               page_folio() -> new_head
>                                               (not the old head any more)
> 
> 3. prep_compound_page(new_head, new_order)
>       __SetPageHead(new_head)
>         tmp = new_head->flags.f  <-- load; PG_waiters == 0 in tmp
> 
>                                             4. folio_set_waiters(new_head)
>                                               set_bit(PG_waiters, &flags.f)
>                                               enqueue on waitqueue, sleep
> 
> 5.     new_head->flags.f = tmp | (1UL << PG_head)
>         <-- store; overwrites step 4, PG_waiters == 0 again
> 
> Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit(),
> and CPU1 can remain blocked indefinitely.
> 
> Fix it by setting PG_head along with other flags in new_folio->flags before
> smp_wmb() and clear_compound_head(). The remaining compound page metadata
> is set after clear_compound_head(). In that way, after
> clear_compound_head() makes new_folio visible, nothing overwrites the
> PG_waiters from softleaf_entry_wait_on_locked() by modifying
> new_folio->flags non-atomically.
> 
> While at it, use data_race() to suppress the KCSAN issue reported by Ye
> Liu's patch (the second Closes) on reading folio->flags in
> __split_folio_to_order().
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Reported-by: David Hildenbrand <david@kernel.org>
> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
> Reported-by: Ye Liu <ye.liu@linux.dev>
> Closes: https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
