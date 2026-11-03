Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707156;
	b=MLLdo5MkOykIPndz5goEw1/joam8u4AgFnuxT/snoSDtdTrI79mp03fVDDBkp7DEhlQF
	 SLeSEMxPlpTQ/SfZmNYMOm7m7lbrhOWqUA7En9mJvcgAIjrreUlM/ohGHiP56NhJmjEBD
	 mGVtYXsfUj4AYMxfDFaozoKOZDbrQ0BaM4v6G5G8UvfWFlXhjQnhfvVNU9ULvbPMbRenP
	 ch3o6EO4dU/cXeXqD0eFaYUjLAiUYoXCbhyOee3tFTIaFxoNqgZoLW6q2zipewwF9R7ds
	 M0e0JGLajTV1ujT/97NrWcxFcGX7DNOoBXnceXsdJ+EsXCOUv9xXlc86y+8Tya5CgVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oPfT2r0DJq5yqGsInZIZFg/Iplo7x3s5azqiGNXMZiY=;
	b=xvgPMRa5WX3X8M9RBCNsMIWY9S0wUjq6I30vWeB4wLxv2Arim7uNRWi/fNr5ZKFk713b
	 PyCpeaxekt8MT7xZ8iPTE33oVGOwtGqNY5uW1ZbcxCjIBGN/mRTDRipKGPPm9L5ORCGs6
	 Y4pcKhRcFmrhuWA+1GW1+3frQZDHTsdjwZDnfbhcMug/YraUe8m+9FHyzQV11T5ePtOTs
	 0yxzu+1YpPgVBJBdQcY2SpEXTMxJJaAsHAzYxqRrzMDN49YD2K9NCZOkPFMsuQk5J5idM
	 UAFo1q3uYjjx2uqmqRfjBXArlIiZyqo523bPyxbEfAYU8t2s+vfz7ZQHfH5jKCV7WEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0E9MnFR;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C6606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 324C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0E9MnFR
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a215e64962so37218875e9.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793707154; x=1794311954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPfT2r0DJq5yqGsInZIZFg/Iplo7x3s5azqiGNXMZiY=;
        b=Q0E9MnFRwZLfmMFoRQydzdxnoS2iQ3QxY+5eS9gx3faNv+6H1dBOIR1nXcTlGhMyOO
         02G1zQ0nsCTPbdhAAiVqOUGljxI2UDCmHSEBhZEhApPpwGKXri2P2pEmYhw0eufQZOG5
         ztOQB9to64WsBUgs+pehaeurpH9PRBW5SURkOt+E4BROAXjkgQI1rwL3o70IPBqayON8
         0pwad79j7ATrm6l3hgtY9ZhHBhpVQkRsEyotcWJBYTJOif3biBMJmB7FM3TMWJiZTm70
         CbzilfH2eTk1KgrkWtFtzc7wQxaA8Chb1EvJYu7e2kzs7BQitQ87iuuJxNt7Br3ILzgt
         BbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707154; x=1794311954;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPfT2r0DJq5yqGsInZIZFg/Iplo7x3s5azqiGNXMZiY=;
        b=iK6gl5Rn6DSGhcPrgcDU904dZ872Z8o/jyo4Nr8u2bo/Rjai/2Oh4IqDYIBN+jOT8U
         U4T7nIcBnbW48JvOg7/Qpoted4FhUYs9iXDaQwT4RiihBblZKAzUhJ+rK9N8rjL/CO04
         wxtv7aqmuRV5fnK1Us7rkdGtB4vowwcmiCQ8ZWUq0a6LYK7RdwTB6f6PFPCzOVw8Z0Gl
         rr+gAErWydQUgbtiqbsZPI1Vx+3QTdghtZvMSLO6MmEurERpJYUBPhzKV2XsiQw17ejU
         7JnWgJRXeky9gY1hsXDz2Zw7ewJpO5yuqofUOCwAkwy3cuaqeXKK0v8TKhRilvvQ6MtY
         BrxA==
X-Forwarded-Encrypted: i=1; AKwUvBy5VZbxCTftU5f4AX0r6p/y7tQHgKqYaIU2X+htpez2qonEVBinEM+DWVm5D/QK1KLPeLTvzis=@vger.kernel.org
X-Gm-Message-State: APuU4Z83Ti2kCWPZSTxckky6xC2jxKu3+44PBnniwqfDdr2cA9pScpVo
	tcMHfNCWawgZlqga66XJi2AjIGOEhtT9kX/sWsIvueiGzD6Lc9xH3INm
X-Gm-Gg: AYBFou1QiG9VGvDVwyDhC3g8oFDjyVM5/nVcplwiPkhCo/GbUyaXJ6z5HzrR15o91ZP
	b+sMMV1vxZErTbroeCrieUYbCgn1GriYAvMrDnERSmX3kYQEDt9Ex8b+DG+F5cR/lF3kivRJtiD
	jJJyby66wANGN6UHHr7jNyBc0KsjMEINTdt3QG1fMbc3ULwT9pWLK1aWNznUUuMOZRZzVIG512u
	c4FtX01yKZiGEeHJ17aP4ZcYgZRB7EVxjjSr/CFIzIsuCfgnelj7cVM3A3qjvuxTmSl/fqehJaK
	xilHTTxJv0IHBg2vJR6JNdADnwo/Le6USVGQmnS5/kqoJVAb0ClsmVDBwF984rvR8loggmdWA5r
	I7NPAzH3CxTFh5MVvHVcvke2aAsIlACisbUOOSRaAwkilLQBiS/qHupkMa0yWZ8xRA4kjzgPjFa
	L30uM9TaAMgqOgIyAKGz0JSojEYh6gTD06mf876O/OWFqbD6b+0RNlawKcUQn2NbuCekWb4VA+o
	DfgBa6lk2GMUVDywuHSN/mFzYAajyIHL87J9FBm2q9Kf87BAZKJqLQGo42YHcy/cSL203UJqVSS
	66YBpVsf9+RQvf77rOsJvxQ=
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr201283785e9.1.1793707154535;
        Tue, 03 Nov 2026 03:59:14 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a93232f0sm53255815e9.10.2026.11.03.03.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:59:13 -0800 (PST)
Message-ID: <41851e94-640b-418f-bdc9-45db3f9842ad@gmail.com>
Date: Tue, 3 Nov 2026 12:59:12 +0100
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
Subject: Re: [PATCH 2/4] mm: hugetlb: skip CMA allocations under
 PF_MEMALLOC_PIN
To: Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>
Cc: osalvador@suse.de, David Hildenbrand <david@kernel.org>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
 <4EC5E593-7537-4659-879C-95ECC2224D2F@linux.dev>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <4EC5E593-7537-4659-879C-95ECC2224D2F@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 11:56 AM, Muchun Song wrote:
> 
> 
>> On Nov 3, 2026, at 16:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> With gigantic overcommit enabled, a fault during long-term pinning
>> can allocate a fresh HugeTLB folio from CMA despite PF_MEMALLOC_PIN.
>>
>> The folio must then be migrated before it can be pinned. However,
>> fresh gigantic migration targets are not supported, so pinning fails
>> when the HugeTLB pool has no suitable target, even if the original
>> fault could have allocated pinnable memory outside CMA.
>>
>> Honor PF_MEMALLOC_PIN in the HugeTLB CMA allocator so the fault can
>> try the non-CMA fallback, or fail when allocation is restricted to CMA.
> 
> Wait... I think my Acked-by got ahead of me here. :)
> 
> There seems to be a rather odd distinction that GUP is missing.
> 
> The usual reason long-term GUP must migrate a page out of a
> MIGRATE_CMA pageblock is that the page was only borrowed from CMA by the
> normal page allocator.  The corresponding CMA bitmap range is still
> available, so a future CMA allocation relies on being able to migrate
> that page away.  A long-term pin would prevent that.
> 
> However, a HugeTLB folio returned by
> hugetlb_cma_alloc_frozen_folio() is different.  It is the actual CMA
> allocation, not merely a movable page that happens to reside in a
> MIGRATE_CMA pageblock.  Its range has already been marked allocated in
> the hugetlb CMA bitmap.
> 
> Therefore, CMA cannot allocate that range again until the HugeTLB folio
> is freed anyway.  Long-term pinning the folio does not seem to make the
> CMA area any less available than keeping the HugeTLB folio mapped for
> the same amount of time.
> 
> folio_is_longterm_pinnable() currently only sees MIGRATE_CMA and does
> not distinguish these two cases.  In that light, rejecting
> PF_MEMALLOC_PIN in hugetlb_cma_alloc_frozen_folio() looks like working
> around an overly broad GUP classification.  It also means that
> hugetlb_cma_only users will fail the fault, while other users may consume
> a gigantic contiguous range outside the dedicated hugetlb CMA area even
> when that area has free space.
> 
> Would it make more sense to fix the long-term GUP check instead, so that
> an explicitly CMA-allocated HugeTLB folio is considered pinnable, while
> ordinary pages merely borrowed from MIGRATE_CMA pageblocks remain unpinnable?
> 

makes sense to me. with hugetlb_cma_only=1 a 1G FOLL_LONGTERM pin can't
succeed at all today, even on preallocated pages.


-- 
cheers,
jose a. p-a
