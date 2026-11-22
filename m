Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795354028;
	b=qYNwqWMN9MI8yyk7F/AsxfM7M8nbHVHM7x+2z7KZVZvJ8ydzBTI7Qe3YPdSogpEJ3nZs
	 I5giLfbKu+sgUn0Cqp83EpRDvKKJSFyUS0v2g2P0RyH4c/mszi1lVfEDJilgzuEimLg8K
	 qZehJT3lHT4EQi8tewCw7ze65UOjQtHWmdFnVtx2ifrNIjO2xaDAClvFyysCO+vVPylvk
	 A1ALEkSJ81bPwq+yiw9hDU4iAnvLDheAoG86XEjWtoDtw5Ui5c/1LHsr2kBLv9Ewe5xF5
	 sg/ucUkyhP6Vl49PAQPwe121yu+Jpslrbx7RcOY/zNMumudSAzE3WlxNAaDBPbfO4gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795354028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4Vjxsk05GCtbwT9AzJDYSYJvCFKsZl/7LIPSbKWoOhY=;
	b=16psN2ss4SVJ/5vyoz+M5h1NFINgDgPIsb/qIpesA1k4XLRjlw6f71EdhKcsw8xLohP0
	 al3nKCSETFwckH9YINRSzJYE71PvP/i2tftyDzB9RDqmns/84R0HjuBQf2xGDMg5cxr3V
	 zNhKgXPmNbAl+xpjBvyeYXAM39amTHkAYWTHujq1CQPU7gF2GKzRtAMhzvyA/DjOPqq0w
	 xVDmXOpYOQAG0/Vp1RmYIElIhORvkhc8fiSk4cEM9szZ5PaUj1TI+1dIdTTmTajK9eEv5
	 ulOYdfAwrxZL2P6yqqGJzzYqzSWzgasKP5XSjmStLsCtaXsjnHc2Mcoyg6DjsPjuUkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWBK8Lve;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF889606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF889606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWBK8Lve
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49465892f7bso1805548f8f.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354026; x=1795958826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Vjxsk05GCtbwT9AzJDYSYJvCFKsZl/7LIPSbKWoOhY=;
        b=SWBK8LveNa9UkbHBm4O5xKybHXeO4OqyHTTMAlJxuExokHq7c2NB5Ajz4Iqzpd1L5J
         hLV3dZfQXmev1POxyzjJeAxg2JDrlRfM0673B38pz4ZeyUeloOBj9M6pBPga8Q3RyX8z
         ja+5ABvYY75kr5SW9LW/K4Bwfa4UfF93cRd10XMQCsGMvi4Q3K9HpncodYWVPVrDsu9Z
         S6xlWxljQo2nIr7XUOzbNOZNHoL2sV5UwyjisXNT0OGVAf0dAx5AfZtbPy67uYivwHK8
         WjM/G8MsWpqEARPDCqNVC7W9G0fMFyVN9TG//ZUl1FwmS16u+oIFBC7SXeXtsxTQgyP2
         +05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354026; x=1795958826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Vjxsk05GCtbwT9AzJDYSYJvCFKsZl/7LIPSbKWoOhY=;
        b=pJX0On5qeCcch0X4rMxxZ9WJNole50N3J+KIjIGadL9b7KP511HZaH+ds6VS9mvfBp
         Yxg9+E00u29PBmE+HI8WBBDRP890RlaF/fxyaIuSr2teMkkFb1bAxKmpVjt3sPHzngpJ
         Owx7P5TejtNQoYhD5oYQwt6OoXs/ITiMM0q9Lm87mW5h0WC47OKVtRhXGW2bml64l5I7
         8V461t7HqKCKCrTtls/dmNusOPsAxYyfFauUo9ZhJlL72VWZGyZUIZOaMUr8+DGn8HvJ
         LjYuTOwaJAa/TuRmGWhH+PT6b2oG7t4rrj8S6C4tuRUd6PfoPY7EnXwkj6JOKiltbkRi
         cSKQ==
X-Forwarded-Encrypted: i=1; AL+hErGKCbZ4bvn35CGCZiY4ZMmufPW+JZzGkoa1kOr2syiHrBuOSDI3Z3LDyq5CfE4NNlCBv9fw2kk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OPzeP1Nmq21SIHGI5yqsPBWjqdHmWA01h74G/Kbs5S4PpnVeJ
	n6CvAQVDmKokCXCm0rIUxtMqzbHxYiR8l5MqMKBBPh9ExEUIXvN7HwQC
X-Gm-Gg: AZFdTZcNvcPNDydpa3OoK+6mRSBOGbxZppvwFVFNxaog3dMAEwU8b9eYe79Gw5iDct/
	6ZtCZJCQ3xBeSW2zVoTuRdwCKtKEm2pkFXeS/HZGygi4PYjP+TH9TNtQe/uftB0c591CJI2Vf3T
	yYqhPupu5dkQ7QbFBGLQbA8Pz6rHk7PHgk0COQ6V3Iv8FXM8lJYE4gY5eUGiP8slw4Y45BKE9tt
	9XtW9NjxJRq1ifU7uL8kCSITxEVmAVD2qdr1VZBBxcCvezSyWC4aiO+tmDNMAx6rn+P8SDOLNj/
	5IlcT2Ozfmw3OPPwljGHgScZlWKWEvnaQaZfIRyLSP50yk81cIKq4klZ/tAF9Skj4O23FNyNAHX
	Ko+JlA7j4SEcCbeBrxjfRug58YizCGtZ7bCmZkLlrn4CZu60GJ4dBoqqWW/4KfUFzlGyu0lT+Hq
	0e0Xcme11K1ajsA0zNGbHjsSEH92nOSwJ5KUNnWg2MjrPefRFOCjWz4HVdOdLp5gLvh4kT6/inB
	XJE45JItfNh+k6DX+aIW4bxOKfdQethkxngQDSBpKmY0MKj/CHvk05ieTt52KMZdlpq3dp1OY2J
	Lg0uhUdpB4W+PoqAQ1l4giX+Gw==
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id 5b1f17b1804b1-4bb8880f283mr194508305e9.19.1795354026164;
        Sun, 22 Nov 2026 05:27:06 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm113782625e9.2.2026.11.22.05.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 05:27:05 -0800 (PST)
Message-ID: <08fabb3b-d717-4b52-8c9d-d4c996e97bc5@gmail.com>
Date: Sun, 22 Nov 2026 14:27:04 +0100
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
Subject: Re: [PATCH v2] mm: hugetlb: allocate larger early CMA pages first
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, akpm@linux-foundation.org, fvdl@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20261122065527.33123-1-qi.zheng@linux.dev>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261122065527.33123-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/26 7:55 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> With hugetlb_cma_only=1, early HugeTLB CMA allocations follow hstate
> registration order, which can depend on the order of hugepagesz= and
> default_hugepagesz= parameters. cma_reserve_early() advances early_pfn by
> the requested size without aligning the start of each allocation.
> 
> On arm64 with 4 KiB base pages, 32 MiB and 1 GiB pages share a CMA pool
> aligned to 1 GiB. In a 2 GiB CMA range starting at 4 GiB, allocating a
> 32 MiB page followed by a 1 GiB page places the latter at 4 GiB + 32 MiB,
> violating its required 1 GiB physical alignment.
> 
> Simply rounding early_pfn up before the 1 GiB allocation would leave a
> 992 MiB gap and advance the cursor to 6 GiB. cma_activate_area() marks the
> entire prefix below early_pfn as allocated and only frees pageblocks after
> it. The gap would remain reserved with its bitmap bits set, and releasing
> the two HugeTLB folios would not reclaim it, permanently losing 992 MiB
> of usable CMA capacity. An alignment-only fix would therefore also need
> to track and reclaim such gaps.
> 
> The same alignment issue can affect non-LPAR PowerPC64 hash MMU systems
> supporting 16 MiB and 16 GiB pages, with 64 KiB base pages and
> CONFIG_ARCH_FORCE_MAX_ORDER=7. The 16 MiB size then has order 8 and is
> also gigantic, sharing the 16 GiB-aligned CMA pool.
> 
> Allocate early CMA hstates in descending order. Each range starts aligned
> to the largest supported size, so this preserves alignment for subsequent
> smaller allocations without creating gaps.
> 
> Fixes: d2d786714080 ("mm/hugetlb: enable bootmem allocation from CMA areas")
> Cc: stable@vger.kernel.org
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
