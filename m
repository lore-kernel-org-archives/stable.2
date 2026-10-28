Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184078;
	b=2ni0S4xZsm+qd2mVBfKVOFkGQwaJHOs9koWWCuHZABQi2iqDifmB6Jhb1QRcZ2IrgSe9
	 HhPsDP14AuuihtrQhB/Tz4/ff6eA4PcW56od4HfcuMXHvjq/c55zv/S+3IxzWytyrB5ge
	 2FzBAcZEPEuX5iFDGmM4k1t9hMu01kO8/aPJFB6ktANgFaJ0IQp/kwBSetjYwBg7qyT82
	 loYNxMPP6pcNycytPl9l326zYMhhsLNaEKgmjlO0gXadw+6S00eSG0WX958+ZNnRJ+SOr
	 TMzIqZjd85vVrh3TlHhYFL+iSAfv0Akehw7nCgQgl6gZO7+1snLBCAUiiYJs4Ht+81g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184078;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7ohDeqYAoftxje+G2/ZUXITZjGtasxeCYee/Ib/dRfM=;
	b=x1rKVV5OYgc4cFEIofTMh3As8hJEB+rOIk6s8vtfrc2r/J4+RzAthlLLLx5qbWtWzO+6
	 aK3wyK0Cka2jpCIm1knWDxoyYe6HlDggWVSZWBAlbcaWJQXjRKGy7ihcjtaSc18MtzWAf
	 ql4L9c3Yd5OVnDBWaF3x1C0b2OiyU0KTQ7iw02K83r7cOk2JN9dvgoXmOPkcYsNmBDzFa
	 wFOXtt8F0xUuk7Lp6x7nfmQGXjBW9GI9ywJqZV2ThKAfVJ0v24Jt/9XWAb81+8V76qcYL
	 uyn/P7bu+bRG9yvb+/ldBUL8SVLjXnG7RHQuoluOXora6HvBxsUXzaQ5emAYbEwh1dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uW0yxWCj;
	arc=none smtp.remote-ip=95.215.58.222
Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DD606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uW0yxWCj
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=da6hytzw+BnB+C5CyqKjthZJsFrZnHpNjbdkzPMyrmc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793184074; v=1; x=1793788874;
 b=uW0yxWCjiuY/QAk36l36xDIbaSJ/T96tA0HP6WqCEveTeJBUYemWYRj/4Kdrl9erGZEE7or5
 sUiXKW8oNGaHZWY2AFZKIRSJoe9vBiTzTCKv4/3aisN/9I/naSVMw40cQwofFWY2LRNiPMMzlhF
 fBex+2wJ8adqN7qch7lrDyRo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b2f499d91e478fa4;
	Wed, 28 Oct 2026 10:41:14 +0000
X-Mizu-Trace-ID: b2f499d91e478fa4
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
	stable@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when deferred_split_scan() races with deferred_split_folio()
Date: Wed, 28 Oct 2026 18:41:07 +0800
Message-ID: <20261028104107.31470-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
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


On Tue, Oct 27, 2026 at 12:17:30AM +0100, David Hildenbrand (Arm) wrote:
>Since the deferred split queue became a list_lru, the isolate callback
>moves the folios it took a reference on to an on-stack list, linked
>through folio->_deferred_list, and deferred_split_scan() takes them off
>that list with list_del_init() without holding the list_lru lock.
>
>deferred_split_folio() does not know about the on-stack list. It only
>holds the list_lru lock when it looks at the same list_head, and it can
>run for such a folio: a THP is queued when it is mapped, as a candidate
>for the underused check, and is queued "again" when a part of it gets
>unmapped:
>
>  CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>  list_del_init(&folio->_deferred_list)
>    next->prev = prev
>    prev->next = next
>    entry->next = entry
>                                      list_lru_lock_irqsave()
>                                      folio_set_partially_mapped()
>                                      __list_lru_add()
>                                        list_empty(item)  -> true
>                                        list_add_tail(item, &l->list)
>                                          item->next = &l->list
>                                          item->prev = tail
>    entry->prev = entry
>
>The folio now sits on the list_lru with ->prev pointing to itself. The
>next removal leaves the neighbours pointing to it, and they still do so
>after the folio has been freed. With CONFIG_DEBUG_LIST:
>
>  list_del corruption. prev->next should be ffd4000000270090, but was
>  ffd4000000278090. (prev=ffd4000000270090)
>
>Fix it by grabbing the lock around list_del_init() so
>deferred_split_folio() cannot race with it.
>
>Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
>Cc: stable@vger.kernel.org
>Reported-by: Josef Bacik <josef@toxicpanda.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
