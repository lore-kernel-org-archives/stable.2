Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146375;
	b=P8rEzZYOmGGJbHayeKe3MZ20tHXjhyA4nm37gMF5AFCJnudIhoMZFYgNhFbJ7Y4jUwzu
	 48pn4b0c4YdbYGaGekwMWIYekolU9I08RgID1w1KrURsW+ddJQ6j3A4g2aJi/EVCwICGA
	 iCgjIE13DekDpc1+iLxN4U2GYIfnIvEPL66jaLHUUqD+mxGECFKM93QaYWDdpKJZMeA9L
	 FSYPQpTH3lNmAUF5nkkAKv21/U4ICqr0QIDgbGxMJNsf6joRLa7ncf1epsrjO2Ff6fLzW
	 1pf1jfiu9RjA/YQJkRpaFm/wPyqg+0wiHgtn5NfaSkEH3QNF0lRAOKsJK+6G0l6IzJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146375;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=Ov5PXrThZFLHfyzJInb6D7h8b2OrOQGcnTyb4KYS+vA=;
	b=eXP3ZEdKiBewrO1XHqpt5x0g5W0NKT04fBaRAeVM8FRl+xW7BOlsybyUsrD5Mhnk93J3
	 i4gyIjEN3KsA+PXVlPeYFZZk+vUI00HtCavQqrVA7zWV9bnnLZEWKt0hfp7SU8bkdlLOf
	 qfgLsqlTr5S9Pv1Rd4F4FKtAl8aQysJ9B7EQIt8Na2vRR8EG8tz+stJaj1ygdOgTzM/nw
	 4tCGSy27zsqgFi0VHfJvyL+JyDVjHmEBerLYFZY5KSHH3PFVGGisP8+zpXM5ybB3DnV2X
	 g8UNvBkEuE66MMDo67gu1QGUvJ9gyN+D+yHHH6gQqCA1pr1ZmeJeQaUDanNlaTr6tig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jxzmHuI6;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BF606A320;
	Fri, 20 Nov 2026 03:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2BF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jxzmHuI6
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ov5PXrThZFLHfyzJInb6D7h8b2OrOQGcnTyb4KYS+vA=;
	b=jxzmHuI6+S2AM4qB3E6tP2vW2EUIm1a9lvlv02TDGcNki//Y61eFm1ApxoIQgdj3/h5NwLoHa
	a3ofvYZNVW3pp5D041bES22Fz+KwZQhv0ZzdinV5+BrMqyfZ0UyikSZIFcJbGC16ojEpb5VuKCs
	la9j/D50g/n+bztD1j+E+is=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jW1TF0f7VzRj3B;
	Fri, 20 Nov 2026 11:45:53 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A9A4B40683;
	Fri, 20 Nov 2026 11:46:08 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 20 Nov 2026 11:46:06 +0800
Subject: Re: [PATCH v2] mm/page_owner: fix double decrement of stack count on
 unpoison
To: Nilay Vaish <nilayvaish@google.com>
CC: "Jose A . Perez de Azpillaga" <azpijr@gmail.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan
	<ziy@nvidia.com>, Marco Elver <elver@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, Oscar Salvador <osalvador@kernel.org>
References: <20261119234804.1740734-1-nilayvaish@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <539112f2-06a8-7c3a-cf95-0d6d63a7a5a5@huawei.com>
Date: Fri, 20 Nov 2026 11:46:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261119234804.1740734-1-nilayvaish@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/20 7:48, Nilay Vaish wrote:
> page_owner counts, for each allocation stack, how many pages allocated
> from that stack are still in use. The count is incremented when a page
> is allocated and decremented in __reset_page_owner() when it is freed.
> 
> A page that is hwpoisoned while in use and later unpoisoned passes
> through free_pages_prepare() twice:
> 
>   1. On poisoning, the last reference is dropped. free_pages_prepare()
>      calls reset_page_owner() but, because the page is PageHWPoison(),
>      keeps it off the free lists.
> 
>   2. On unpoisoning, unpoison_memory() drops the poison reference and
>      free_pages_prepare() calls reset_page_owner() again, this time
>      really freeing the page.
> 
> __reset_page_owner() decrements the stack count both times, although
> the page was allocated only once. The first call clears
> PAGE_EXT_OWNER_ALLOCATED, but the second call never checks it.
> 
> If this drives the count to zero while the stack is still in use,
> stackdepot treats the record as freed and warns on every later
> allocation or free that uses the same stack:
> 
>   dec_stack_record_count: refcount went to 0 for 92274844 handle
>   WARNING: lib/stackdepot.c:517 at depot_fetch_stack+0x5c/0x70
>   Call Trace:
>    __set_page_owner+0x110/0x290
>    get_page_from_freelist+0x1225/0x1440
>    __alloc_frozen_pages_noprof+0x1fc/0x1b00
>    __folio_alloc_noprof+0x12/0xa0
>    alloc_migration_target+0x81/0x1e0
>    migrate_pages_batch+0x1f2/0x14c0
>    migrate_pages+0x9c3/0xca0
>    soft_offline_page+0x189/0x570
> 
> A single soft offline followed by an unpoison is enough to trigger it,
> because the migration-target stack that the offlined page is accounted
> to usually has very few pages.
> 
> Fix it by decrementing the stack count only if PAGE_EXT_OWNER_ALLOCATED
> was still set, i.e. only the first time the page is freed.
> 
> To reproduce, boot with page_owner=on and CONFIG_HWPOISON_INJECT, soft
> offline anonymous pages with madvise(MADV_SOFT_OFFLINE), and unpoison
> each old PFN through debugfs hwpoison/unpoison-pfn. Without this patch

Oh wow, this issue should be very easy to reproduce, and it has been around for
quite some time. When I tested earlier, CONFIG_PAGE_OWNER was enabled, but I didn't
add page_owner=on to the boot parameters. :(

> the first cycle prints the message above and 2200 cycles produce 6597
> warnings. With it, the same run is clean and all stack counts return
> to their initial values.
> 
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
> Signed-off-by: Nilay Vaish <nilayvaish@google.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
