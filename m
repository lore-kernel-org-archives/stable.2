Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793595491;
	b=YbD3tT3sB0a+0Dni3T9D3H6XQn5lmKX/KVzDZERX3C6VFNQrK9Wo7R/8DgfAGVWbYswv
	 o0EGWnQY8IkryRor7X447HM3JMYfvkKtPuQQBt29f9BjtvRL/qqduLAQ4AkJLu1lbxXpv
	 CrR3bCiHQFuj9La3jLxyLsLwd7Sl3tI9fFYWrU5qz09hO3vd1DdTII6L8sxA4nJ+aQ9kN
	 bxJZLFWeLwZBUEGhl9/NMC3q0h/Wl0AtlzFqd2EbNmbnBoh02Y8X4q/zRX5CnrXSVI2Tf
	 gFA+9zvc+YL5+rbuycu21v0jS6niXnmP3QOgWNGwwUlGRvvNw2eCoxmBT7TUZs5HNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793595491;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VjEa8aUzoMl3SYNFpAhF7zUKPZ6wHLLQaYP9asa0BH0=;
	b=FcA8BhOq9gR9oXYc/jwii6ew9jc3Ah8zMmTFdjUQJur0eoT1w75nHf7NG8HRlqKt2X+Y
	 s/pfn33r/kk53N/llLd0k9d73TLhTygo+lz7HdO6xnh6dDMSCmaWeLwtqmCVtghLMfB7O
	 JdS/L9NAPf9Z6LZge0xf54ObDc7JFvkQqlc34fIyVtk/ZrMQTx8TGg4g7U7PgT5Lb0Jum
	 Q3/mAaPNjr7zuP6ESsR2HYUv7D9VlMHdz4dQv2NNWwpa9oKw9XhKDE4LIwQjjmaIPf355
	 adaJmNbc0q2CZUy9+F7tdAfV12yYzQdEsxHthmo0q+/hiKMJhePNY542nUJXOVJ9f+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.197
Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B25606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 04:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18B25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VjEa8aUzoMl3SYNFpAhF7zUKPZ6wHLLQaYP9asa0BH0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793595483; v=1; x=1794200283;
 b=Hd5/4EfZTqDJhoJQj3RsxtDVnqKy1aamG9WHQGlhuYDbiUFMRMuVUh4U5WZxWeDr/5mCNBgn
 FHjhJk19Z2BSSg+yJ71g766NnsgHdRSQLGkOUEsKwe+DVjg5v3ia4eonJn1QqSAdzJyZEe1pud3
 zdEAiA5fQmMfolu9HsRAjM9w=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36faa33dfd74c51c;
	Mon, 02 Nov 2026 04:58:02 +0000
X-Mizu-Trace-ID: 36faa33dfd74c51c
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 15/47] mm/khugepaged: always recheck the pmd in try_collapse_pte_mapped_thp()
Date: Mon,  2 Nov 2026 12:57:53 +0800
Message-ID: <20261102045753.34901-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-15-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-15-d6437171ecc3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:39:44AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
>page table, and takes the PMD lock and the PTE lock to remove it.
>
>In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
>page table. The pmd_same() check is supposed to handle this, but it is
>only done with CONFIG_SPLIT_PTE_PTLOCKS.
>
>Fix it by performing the check unconditionally.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>[ david: adjust description ]
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
