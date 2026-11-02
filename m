Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619893;
	b=qoN+1edP6Qn/BDxnPCQb41Zbpownhj8z89tfvbbu3wYTvrqoI0FKilrm70k8EvQF8r0W
	 kTCKJyuN1fql6M5LTCmYdQxQ06Nr4soDDxQSFlnxFsC8WyvkzmUzrIqumIWrYPCG5iYoN
	 ppVYoTR+ivLnO3ktBtHWUGkpUxR6Et8IRHOHYFArPNiRw8qfCIxuN6MU0dszX/E2rTko7
	 SmzVS/GTJ7xRQohXCgHHgC+XfWh5rLSPnsI8OS6/qcDnyYJvhU56zGNzxEPGCQERM/KTU
	 4cDtQGatRZLj0d4efOXpvZ8KHxe4ovPSKpf54z8gJWtlY3zOig9Qmi2LTVx6F920/lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619893;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=who8ZKKpx/jTygdDf46XygrUGTNQ5Ti9QGrea7MK2kQ=;
	b=cAg2UIfPLO0S5XcgcMaI53txwo/IPypBstfNL78xnGHLga5mOMrYz9VKt7BjNnW8mZZC
	 wwXjAjdrzOihQotlfjsEFjvGdmgwbEAaCvwlbIigfeUaLCHs39okEfma2vwyHIgjfYt2D
	 5kyOROhnfIIv+KpNxNtm1XlsqRxb9GYufpY6vHhnFguB/EkwvOqk7+OP31cKnsqQKQagr
	 GyEG4OfephuDoWh91RchjXqBm3Ina2e3ClD2VBviyCjuhlPzlje5aWawiTKlEmKNn0nwY
	 fXKmBCfXm/LcKY6njBAc5kqpDR0lQxmPaIPOQdPoIGVCjItrJ7AVhq1wsJy0yPMuL8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zb1GeGbo;
	arc=none smtp.remote-ip=95.215.58.45
Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8D60A2603
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC8D60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zb1GeGbo
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fgRhZQDSEmJFZyIgGkSRYKnhjZ4Z1l5m8LV8w/ZXnHw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793619890; v=1; x=1794224690;
 b=Zb1GeGbojxXveT3cZxDPn//4R8A7h+RMO72HLl435m67FVvM9SHf44yaVVp55n3SAPWWoirq
 Hz8XE56QJlzs5IpeJmF7MvIRESwEWtyXzDq/oA5mLYy34SDIJOr+HdZ4EG3OGTtz9aHGD3cJfWY
 yqj/TBZodxsUUHX+M5Y8plAE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6ed161f8dd0a3c59;
	Mon, 02 Nov 2026 11:44:49 +0000
X-Mizu-Trace-ID: 6ed161f8dd0a3c59
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
	usama.anjum@arm.com
Subject: Re: [PATCH v3 30/47] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
Date: Mon,  2 Nov 2026 19:44:42 +0800
Message-ID: <20261102114442.65682-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-30-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-30-d6437171ecc3@kernel.org>
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


On Sat, Oct 31, 2026 at 10:39:59AM +0100, David Hildenbrand (Arm) wrote:
>move_huge_pud() reads the old PUD and clears it in separate operations.
>Hardware accessed or dirty updates between those operations can be lost
>when the saved entry is installed at the new address.

Yep. HW can still update the A/D bits while the PUD lock is held :)

>The raw pud_clear() also bypasses page_table_check_pud_clear(), while
>set_pud_at() accounts for the destination mapping. This leaves the
>checker counts unbalanced for mappings tracked by page table checking.
>
>To fix it, simply use pudp_huge_get_and_clear().
>
>Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
>Cc: stable@vger.kernel.org
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Reviewed-by: Dev Jain <dev.jain@arm.com>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/mremap.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/mm/mremap.c b/mm/mremap.c
>index 0d06d7f37f19a..16e736c72d9cb 100644
>--- a/mm/mremap.c
>+++ b/mm/mremap.c
>@@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
> 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> 
> 	/* Clear the pud */
>-	pud = *old_pud;
>-	pud_clear(old_pud);
>+	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 
> 	VM_BUG_ON(!pud_none(*new_pud));
> 
>
>-- 
>2.43.0
>
>
