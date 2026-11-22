Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795331295;
	b=Pzi+WbLUZ7V2JES0oApbgx/dm5FARvYf5nyccAi/vSwKxBuhEg8KV2udic8Xr0fTak1L
	 59waEv/tcU9B34qsZL0SjJENbI+9f0umQeSuHa4my3lE5OO/g6lzB0geG7HT65FHeNBy+
	 9TxfAUOnNIGoMgmmG3XR1Y5I705mYwpS8CeQjl6om359VQrAb8EUbnK5OUOCyUT1wNCJU
	 OBrq9Crr+Qo9BwGtsPEKoj6WbbSWt1RVuWfi493OQcSueNYuFBG7AxO0oWHuxSBUiCWVQ
	 PTLjLiiAKf8EuQIag13kpyvVE1fUKVj+29xURaYj6q0KY0NZ7+dYvyZExPz9arlkf1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795331295;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fpVPbeFMltrY5ZOohyFH/1X6RQS2degmMqVdNbfmucw=;
	b=BurEBFK3P60/6ZmXf9N7InZt1V2LOUphM7/wxYMU881qT42ADJlui4mfL366RxSbCRaf
	 h2A+wjx+CIXwDZuBWBNPcCERapYafV9RigCJRtG/aZUg8V47c90X30gneyoS9Nmx2NQAP
	 irLmtZiRALsI61c7sXnCeaOqtHsA9yC8BDUeblyolnd6hYrMuHBtVmbWJv7e5Zi5u1VF2
	 82+qJaJsaz16fxdpqs+pfkUmQ+7FmaqQXNHkk6g94EtS/YlFgtzMKXra/PUM1zCpDwrT0
	 YSXK2LgCuYzAfIO2yhEcmi+pbO8VkDoNc4JVbC0IzEJHrUTvHds2FX+VdB1QXGVATNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=geJitgqO;
	arc=none smtp.remote-ip=95.215.58.83
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7E606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66F7E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=geJitgqO
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4aLff9bBf+2cChSkzEnmwM9IlWonQJ2YgakFBBad1qc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795331291; v=1; x=1795936091;
 b=geJitgqO+QKGcX7KwbBVpRh5EJR5WxhjjYzpDT91cUFCGUUm3nIi2Mn4nZwcqjCF+AveauGQ
 s+3kSxQSEFjQi3wjc5omYGZt+OokSbr8EdFhiW9fOPKdZkAedvzqjNKQHwmPs+S1KGc3nr18dJt
 vR4cy6NVDWGo4xOz3BSNZCJc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8ffee67358adb4e;
	Sun, 22 Nov 2026 07:08:10 +0000
X-Mizu-Trace-ID: b8ffee67358adb4e
X-Migadu-Flow: FLOW_OUT
Message-ID: <bf367035-ee89-4489-b268-631120ac1143@linux.dev>
Date: Sun, 22 Nov 2026 15:08:06 +0800
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
Subject: Re: [PATCH] mm/list_lru: fix potential infinite loop on xa node
 allocation failure
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Kairui Song <kasong@tencent.com>,
 linux-mm@kvack.org, stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261122031143.3639941-1-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20261122031143.3639941-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/26 11:11 AM, Muchun Song wrote:
> __memcg_list_lru_alloc() populates missing list_lru_memcg entries
> top-down, from the farthest unpopulated ancestor down to @memcg.  When
> storing the entry for an ancestor (pos != memcg) needs a new xa_node,
> xas_store() sets XA_ERROR(-ENOMEM) and leaves @pos unpopulated.  If the
> following xas_nomem() also fails to allocate, the inner loop exits with
> the error still set, but the outer loop ignores it and reruns on the same
> unpopulated ancestor: xas_set() then resets the state to XAS_RESTART and
> retries the store.  A one-off failure is recovered on that retry, but as
> long as the allocation keeps failing, e.g. under sustained memory
> pressure, the loop makes no progress and, with no schedule point, becomes
> an RCU stall / hard lockup when the caller holds mapping->i_pages.xa_lock
> with IRQs disabled.
> 
> Stop the outer walk when xas_error() is set so the existing cleanup frees
> @mlru and the error is propagated to the caller.
> 
> Fixes: 28e98022b31e ("mm/list_lru: simplify reparenting and initial allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-21c1dba9-8d6f-4368-b38b-9a57cacb056f
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/list_lru.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


