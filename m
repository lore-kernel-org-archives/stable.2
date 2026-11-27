Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795750768;
	b=c4DMP8x1YC11Bp79r0WuJwchzGUnDh6uN+K1g36VLw2KiVjTJ4VJyQOBlLc9hqVBhaqq
	 djfLsQwlF1NP8ioM21POlYz1n7q4EWLea7QCnEto1vHvSigV3DIo4BnHwst73V62C5d4R
	 CILgF+STBC+vQ/YQ6/8VJwaYM5P1Q/CKnaUSObTZhGG93jeXnJI4eDTOIU0U93Kk0EWe0
	 voHmOxAG5RCcX/2xFuuUgPql3VHKJNTXyvdvfhY1W/OnH5pSvp5NiZQflgSv/gy1IElc4
	 MAMGqbYos97VL0dWwd7stqgGbry1DUlZKxErrRnNNEvhNRpg48ctpQAZFUfixzfvBbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795750768;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=IHm+FzKE36SnVI1ZswFKXcG12/LjELz3/7Uez7uAtfw=;
	b=jPsruzMh6DgUxBjIGuJ8zKyphyegrGWFNPbCriP3UUcWomFEoMfb7IC5bpfzsdYt2cv4
	 Pt2a2lEWi3DTuM8TfhUgePVon7WxHS6Ok/D+nOkK22b2AMGCI41stcXMxCmclZ2W44BsV
	 Hp9wgWaXuEUWFiK+UJDx7SfWNi/aByIZGx1sYz5uDEcCHuhnglJLRVWjYuvNQOF1PQgcc
	 AN4peunNDBdFQ7+VLN0ZP5gLjKWWd5nfO1YhIhoGCLnx+rcIHshS8N8OGAoDGzY4wBanq
	 f8u91ppf507/Ps36QzXnj4hggcc2NoGMy7GhtidRM5o+/7mTa4+E9pSWnghcedzGVJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Hn0vhtFS;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB4606A31C;
	Fri, 27 Nov 2026 03:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2EB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Hn0vhtFS
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IHm+FzKE36SnVI1ZswFKXcG12/LjELz3/7Uez7uAtfw=;
	b=Hn0vhtFSl58AK7IVHA/YiEIzohLqbCLCGUmSwjcbzQy2l2GmeVkpwjZIyIAR4RzvvNyUb3BWB
	Gc+l5mOP5/i2dfAGiSxUkFrHLW25kC2TE/l9+bZ/MaPNKH0ZtFnZBMes/LQRuyrebWgfrhZbUxu
	+LCKQ/Kw8BIhUy0nwOjinzU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jbK0B5kz2z1prMP;
	Fri, 27 Nov 2026 11:39:06 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D12D540575;
	Fri, 27 Nov 2026 11:39:24 +0800 (CST)
Received: from [10.173.98.163] (10.173.98.163) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 11:39:23 +0800
Subject: Re: [PATCH v2] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>, "David Hildenbrand (Arm)"
	<david@kernel.org>
CC: Mani Tofigh <mt4022@columbia.edu>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, Gregory Price
	<gourry@gourry.net>, <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tz2294@columbia.edu>,
	<stable@vger.kernel.org>
References: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
 <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
 <2e11ba52-b5c6-463e-a5ea-c165ba935704@columbia.edu>
 <89037847-8875-4d8b-a8f3-d77a59aaddea@kernel.org>
 <awf6RghUETgb41pr@localhost.localdomain>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0b947b66-81d8-e921-ec57-76bad1ae1202@huawei.com>
Date: Fri, 27 Nov 2026 11:39:22 +0800
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
In-Reply-To: <awf6RghUETgb41pr@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/26 17:22, Oscar Salvador (SUSE) wrote:
> On Mon, Nov 23, 2026 at 08:45:37PM +0100, David Hildenbrand (Arm) wrote:
>> We'll have to find a way to make that reliable. Everything else is just hacking
>> around it.
>>
>> Why can we block concurrent offlining through get_online_mems/put_online_mems?

I once tried to fix the race between memory_failure and memory offlining [1],
but ultimately failed.

>> But I hate these functions.
>>
>> Or alternatively (better?), have a memory notifier that block concurrent
>> memory_failure() by grabbing the mf_mutex when MEM_GOING_OFFLINE and releasing
>> it when MEM_CANCEL_OFFLINE/MEM_OFFLINE.
> 
> I think this is the way to go.
> memory-failure is a shaky operation and over the years we have seen how challenging
> was to interact with other parts of the kernel without crashing.

I'd also prefer making memory_failure() and memory offlining mutually
exclusive instead of adding more ad-hoc synchronization or spreading
get_online_mems()/put_online_mems() into another path.

> 
> IMHO, we can try to be clever and try to workaround those issues
> (memhotplug vs memfailure) or just make the two exclusive.
> 
> @Miaohe: Thoughts?

We've already run into quite a few race conditions, and there will likely be
more in the future. memory_failure and memory offlining happen very infrequently,
so it's not really worth adding all sorts of code just for them. Therefore, I feel
that making the two mutually exclusive is a better, more permanent fix.

[1] https://lore.kernel.org/all/20220226094034.23938-1-linmiaohe@huawei.com/

Thanks.
.
