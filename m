Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076019;
	b=mZI+5s202SnSI2lgPiOuTwgfOGzMHKiFzd15wy4TP6nRDZGCRnCJzp044r21QnPTt90t
	 zm3W10835eNGkJniW2ofqQMsHrjFrdW9vGduc+OlhUs1+JKi5LpRxe4lnWT2WjwR/WRhB
	 aHnZl+XK+wt76TV8Ubd6hzlGAtsZJt+G5zsEcTkNN+bcZacQQVivTvyMQPnnKHvit6uRv
	 qjQeNfp1yHivdVFrZOGdwtBPrFYc4nJB2Ju09uliO2CRjpdqbWxyG4rhUCATSNm8tIcWC
	 xSPK0gaBpJZCZtwhK8IRD9Pppb1t52Sj11us2L3lb5bxiZ2JTZFGpqK89WxkpxCi29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076019;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wVhySGQl9o0rB8pMhdyfDXMh7D/DmTgjZ/fmBI7bd2o=;
	b=RfS2n3J4/2pPApSgZNF/H3Gikr6lxuQNEVPe5EjCSVncT7g0OPMkdrXoQX9Sgm1vtMqt
	 yRwhOztmtrq5tv1QALqq3tPBLP/+e/NKMTmgP80XDe+ViLLzl1CX5OxdHUdEjsmUCqNsP
	 ZTdLhn91o7BuU+g8ey+e8s7iM6ycq2juW7IV/3mXlV7ZivdJqYOlDy2xxkhQoceDLfKq3
	 ilFyohrhHLXQ8pwsCWkDsykgsVD8exjdE52gvo/HwWnzQSKw+sxmB/5CkXCzjDBYtL21K
	 Vf4od+cxCRC4gp3PLByG1dMk/A/uJyV1wwR8yzuV+fdLfOC6mHhziY75X6ED/Lo4nhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XDGihdt4;
	arc=none smtp.remote-ip=91.218.175.162
Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073C606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F073C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XDGihdt4
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qE2tL1Fo3Dp82uNSJ3pSzSpKtJMDbDdNOIJXBRddZ58=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793076016; v=1; x=1793680816;
 b=XDGihdt4ZXZSKkXO+jRZXkOpmdHa8OUM6cFOSmAps24oEMsf2ooVdRYDmoXKu/oheSgp0VDb
 Rn3GjO/Ky+lH2k/6+tGGdmReHpmI+swg5Zuqm0F7avRBZVwTiJhu6exZ8a3i2t2NI/L+hwYgffs
 3P/75uZtm7Xoz+kpvFy1R1Os=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f24c8c8b657afccd;
	Tue, 27 Oct 2026 04:40:14 +0000
X-Mizu-Trace-ID: f24c8c8b657afccd
X-Migadu-Flow: FLOW_OUT
Message-ID: <e4ea12a5-ca26-4c1e-99e6-899eaea449c0@linux.dev>
Date: Tue, 27 Oct 2026 12:40:04 +0800
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
Subject: Re: [PATCH] mm/huge_memory: fix deferred split list corruption on
 partial unmap
To: mt4022@columbia.edu
Cc: Kiryl Shutsemau <kas@kernel.org>, Kairui Song <kasong@tencent.com>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Nico Pache <nico.pache@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 tz2294@columbia.edu, stable@vger.kernel.org,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, "Liam R. Howlett" <liam@infradead.org>
References: <20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/27 08:22, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> When a THP is partially unmapped while the deferred split shrinker is
> scanning it, the deferred split list can end up corrupted.  With
> CONFIG_DEBUG_LIST, freeing the folio later reports:
> 
>    [  523.871401] list_del corruption. prev->next should be ffd40000005e0090, but was ffd4000000500090. (prev=ffd40000005e0090)
>    [  523.871412] WARNING: lib/list_debug.c:62 at __list_del_entry_valid_or_report+0x177/0x220, CPU#0: thpsplit/63
>    ...
>    [  523.900715] Call Trace:
>    [  523.901753]  __list_lru_del+0x5f/0x220
>    [  523.902588]  __folio_unqueue_deferred_split+0x238/0x520
>    ...
> 
> Without CONFIG_DEBUG_LIST, the list is left pointing at the folio
> after it has been freed.
> 
> Since commit fafaeceb89a5 ("mm: switch deferred split shrinker to
> list_lru"), deferred_split_scan() moves the folios it scans onto a
> private list under the list_lru lock, drops the lock, and then removes
> each folio from that list with list_del_init(), which sets
> entry->next = entry and then entry->prev = entry.  Another task may
> in the meantime partially unmap the same folio and call
> deferred_split_folio(), which queues it only if list_empty() reports
> it as not queued, and list_empty() reads only entry->next.  If that
> happens between the two stores, the folio is queued again, and the
> store to entry->prev that follows breaks the new link:
> 
>    Task A (shrinker)                     Task B (partial unmap)
>    -----------------                     ----------------------
>    list_del_init(entry)
>      entry->next = entry
>                                          deferred_split_folio()
>                                            list_empty(entry) is true
>                                            list_add_tail(entry)
>      entry->prev = entry
>      /* overwrites the prev link that
>         list_add_tail() just set */
> 
> Use list_del_init_careful() instead.  It sets entry->prev first and
> then entry->next with smp_store_release(), so once list_empty() sees
> the entry as empty, the shrinker has finished writing to it.
> 
> The reproducer repeatedly faults in THPs and partially unmaps them
> while the deferred split shrinker, run through
> /proc/sys/vm/drop_caches on the same CPU, is scanning them.  This bug
> was found and replayed using a deterministic hypervisor currently
> under development, but the non-deterministic C reproducer can
> typically trigger it in the 10-500s time range.  With the fix, nothing
> is triggered after 1800 seconds.

Well spotted!

The race window is rather short, I guess, but partial unmap can still
sneak in after next is reset and before prev is updated. We need
next == entry to mean we're done touching the links before allowing
the folio back onto the queue.

> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Reproducer: https://github.com/manitofigh/thpsplit-repro/blob/main/thpsplit.c

Cool. Your reproducer came in handy :) Hit the corruption without the fix.

Tested-by: Lance Yang <lance.yang@linux.dev>
