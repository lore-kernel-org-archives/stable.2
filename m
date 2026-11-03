Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718056;
	b=VZlU/7RJu94nKmdP6aox7+AM/TFg6BGzsPT7QAYXVAnOj8q/05PZlv4vvFeaAYJsgC6f
	 F28C0dEP7aVUh/CUFuVPKb4mQT7Kksj+5i3agGD3WvBjifD+1kNpKswcHbO5GoSB3urr/
	 WJ2gemq1W3sFELKZb482RCWmSEj2LH+ushZcf+ucR8ePwxxaEmt3sTBrRVmjdzN6CS5DL
	 vct7AKYdoObnedNc6HkMiaiXVRy/SRRWbweCCIjCgJ1ni58Cfvt4DZR25kQOTn/pTJx1H
	 ezOc5FF6TTPcM56u7aY7AroOI2P7PP6G3IQkLQCh4w/pUSuaJ53Bq9xzpMQVnMaRt5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718056;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bA0DUmnnxVPUL6fKcA1U0PeMmih16OqQLXC+FqdAHTU=;
	b=wGGZZyTVMcrcxJd1iM2AZfcSeDTEdVe5Fg0FWkXRixi+m+0GE1F8+1siJ7MnWeZPv0Ia
	 vP7lzxcM+Yf+rFfCvZfUidvvXUHXwgQ7I8PAnrMMc6npPODZ/MWM8F7DHTSNGF6GY3MkV
	 GMBSD+akLNbpklOq458xzFNoPFVctxTBc445c6iVfSOkoDzwBVss8SMRwsojBqvCG00zn
	 0rlZamdVkcBGKOTzIXvhyNco8nBou0yI566Eun5RZ+zxpC9jHkAd/F+bPJjV5ET5byDts
	 9cWevF1yPymmGGs0ru+I1445jWrG2ZxlAHMv9gDo5AwzyaCL3FV/WPvU9m11DLUV2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3K6pDSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE4606A324;
	Tue,  3 Nov 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3K6pDSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423AF1F000C1;
	Tue,  3 Nov 2026 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718056;
	bh=bA0DUmnnxVPUL6fKcA1U0PeMmih16OqQLXC+FqdAHTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d3K6pDSFh52zVCjIc/hBdsflRe5uFDEz0Fmn1nI+IKthHiXVq1OjvLBo8PS8Y7GfJ
	 L6G5tw9QmaAoflgCwnDY08eRL/Ga120L9Q1f7tOGn94gVVV4Zdt/sQyCLyuZhP3Mxp
	 UmONMR9peZ0sBrCDpOCrPthNxS+XUm5DPf7OZLwL9Rv3d3KK7VGugZs6A3VMEANKa9
	 OivpMxXoXJ/30qchLqIfmTlrvWU2x1m87FS8C82zMIbmuXeYq2tYTDcslOIE+U1x35
	 BgtTY9XjTURfxoHL+kKtzxrdkdqBnO9Ub7CK+2Z0a/9pA6XNBVVaMuIH942o52QY1U
	 aLWb9/Wg3nTbA==
Message-ID: <a5270059-e5a7-4c8a-9f04-96135f79ea72@kernel.org>
Date: Tue, 3 Nov 2026 16:00:45 +0100
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
Subject: Re: [PATCH v5 07/12] mm/mmzone: read each zoneref slot once when
 filtering by nodemask
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "Gregory Price (Meta)" <gourry@gourry.net>,
 linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, rientjes@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, muchun.song@linux.dev,
 osalvador@suse.de, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 Bessel.Wang@huawei.com, jiang.liu@huawei.com, mgorman@techsingularity.net,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-8-gourry@gourry.net>
 <DML8OO28WT5O.3U6NG100XWKZP@nvidia.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DML8OO28WT5O.3U6NG100XWKZP@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 04:01, Zi Yan wrote:
> On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
>> __next_zones_zonelist() tests a slot's zone for NULL, then reads the
>> slot again to look up the zone's node. Offlining a zone's last block
>> rebuilds the zonelists in place, so the second read can return the
>> terminator:
>>
>>   CPU 0                             CPU 1
>>   __next_zones_zonelist(nodemask)
>>     zonelist_zone(slot 1) = NORMAL
>>                                     offline_pages()
>>                                       build_all_zonelists()
>>                                         [MOVABLE, NORMAL, NULL]
>>                                         -> [NORMAL, NULL]
>>     zref_in_nodemask(slot 1)
>>       zone_to_nid(NULL)
>>
>> Current GCC and clang merge the two reads, but nothing requires it.
>> With mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a
>> nodemask allocation between the reads while the node's last movable
>> block goes offline oopses every time:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000060
>>   RIP: 0010:zone_to_nid+0x0/0x10
>>   Call Trace:
>>    zref_in_nodemask+0x9/0x20
>>    __next_zones_zonelist+0x23/0x70
>>    prepare_alloc_pages.constprop.0+0x16c/0x190
>>    __alloc_frozen_pages_noprof+0xaf/0x330
>>
>> Read the slot once and test that zone. A NULL zone still ends the walk.
> 
> It is better to spell out the rename from zref_in_nodemask() to
> zone_in_nodemask().

Added:

To achieve that, rename zref_in_nodemask() to zone_in_nodemask() and
pass a zone instead of zoneref pointer.

> 
>>
>> Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> ---
>>  mm/mmzone.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
> 
> Makes sense.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> 
> 

