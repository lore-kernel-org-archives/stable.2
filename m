Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010135;
	b=CyQQAdFSLqryfKZoKYoCcoLorm9JjrtnZwWEwZVvJnMuH+lNlJ9cx91OAqXvg+hk9wku
	 aCQtI36gyKfOXXtOWyV7mz2p93J3CnGeMcwakA/ZCXN/F1mbIGY1RXxK2710VwwlielRp
	 VIc5j5zOYjm6onMbqXHeDvsCK+mnByeA+guCXYJlprYiquAbFZlFHVw2m9rS4JfHaAWxA
	 OmsQ+rW+Q3k3wLSW2VMx63avHzFAReg2KSOTghcqkzMbnx2ujeLpe4kw53NHQ2A5PYyiP
	 Js4xxF1Ce70qle5zr+rhZdF91+mps9GvHKmrtqZzDN+0vsL17q2XKJtd4vQ0X0Wzbug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:To:Cc:References:
	 Content-Language:From:Autocrypt:Subject:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fzZ8p4GcrJgIWf6F5LBlcZh4WchWnffp6/lWOYHVfoE=;
	b=s4sM9RK2RRXGpHE/MPoOP25Hzpe6mVkXHaWk2hti6Nsgso3t6BxGcHYIwW/zkOuWOJ9n
	 dp8PPpxVWsLqGCcrz3ts95WsVsoNwSUlgd/cmyaXZt/Yd/wrU+vffkd0bAyWtDFuNDGn1
	 xXrItAHAfReLTGPfQgekmUK90nAQZfjQwhw53dHBT/bIIJ+1qAYQ+ZTdvRYLYNxWabeTh
	 jnPB8qTkIxRY48Y+7qj4LnWv6+M1bX2hn1OBX0hm2OvyFlpVpWfg03t7U1hSWX473C1LS
	 8/32z66tqpYTyl4QpAVBqRPXRMPy6z5SQ5ee/tLYQf78ZEaa16wzeb3dwSPfFMiqPpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deepfinresearch.com;
	spf=pass smtp.mailfrom=deepfinresearch.com;
	dkim=pass header.d=deepfinresearch.com header.i=@deepfinresearch.com header.a=rsa-sha256 header.s=google header.b=XvvYdpnz;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD06606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD06606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepfinresearch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepfinresearch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepfinresearch.com header.i=@deepfinresearch.com header.a=rsa-sha256 header.s=google header.b=XvvYdpnz
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so5645725e9.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepfinresearch.com; s=google; t=1795010133; x=1795614933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:subject
         :autocrypt:from:content-language:references:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fzZ8p4GcrJgIWf6F5LBlcZh4WchWnffp6/lWOYHVfoE=;
        b=XvvYdpnzeqkgtFJOpqJ19gHT43CkiH5Iifke2y7RTt8o8Ys5azjcfUCO68P8NeGI5y
         HMHGfDnfIcedPT+IQwBqar3LBr79k1iiQnDLFdWCeRCLjh2XZfUTThAjKyepV1eAtn9s
         8MN2oZ61G9WluL42OXw7suy/B089UVEgw1eA8BNYpZoyWdMnUc5G7ocn0TR/brbUG1lT
         tmo22kxNEVWo3vxVM4YGd391KIDUhffvcaoqlVDlG/MTXYHACbWOVBnIEEE1oaba58Ns
         +cvY27mGfy0Idvc41NTfd+lqpbHFrK5z+CRpdnqAow+xc5X14+/FL83sYeqXO64KROyZ
         s84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010133; x=1795614933;
        h=content-transfer-encoding:content-type:in-reply-to:subject
         :autocrypt:from:content-language:references:cc:to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fzZ8p4GcrJgIWf6F5LBlcZh4WchWnffp6/lWOYHVfoE=;
        b=Tfh7vBTWJyPJpAITPI1iClRoKuEYkZb8cve98Q/Jl1484zN0UOc8nOyZC8rtmTXyFE
         Os5LILUz2JTu55YwJU+hEBhdiErNVGiSQp5s4rSeX7P52NNnzf8g20+K8wlYLMEfoHa5
         mfGat5CXWMjfEhc64myIpd2g/L89CpZeJlz8DQLPD0A9XGyDNI+m/TO1l75Siatrg1d1
         BkePAZLLrCC1QqYLQx+eFHi/9+73Bc30R92oep7bYDzb5zwlm74JeV2NqO+0Mv/ey/vi
         OR4oYYumHXxZa9wEVef72gg8GyJruCWEEcNrUAJpuz72sA5YzoxBDJepjxzKEfm1Ahaf
         L4gQ==
X-Forwarded-Encrypted: i=1; AL+hErFJ9Lmj6VF6rBYp1cP8n/p4SHsA6dUYQYWGO8pDo9Lbd5Ptu5AxDRbKUcbCX2wt689DmUmuS9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/so8dAnblXBOBOez7reCrGR6DiozacqtMuEtgF3zWkCY4CERt
	dXcbB99qExVZzL9z/XsZH59Low69xhlLhu/mOaNWoPvpn+IscFYj6LlGCXrypuXRGiU=
X-Gm-Gg: AYBFou2FTdv+UQNoSTnJkyEjwa1EVgF4Ibq/1V2alS6Cvct9x7VMuUE4FvbokOSlHyx
	GZHukzjzwxhcMPWDcQLn6TWXEqW2MZg2l7VEe36IasFeaw6kHdqDYulGI4N7cS0YN6eJzOHrDMq
	Fk546OcRNA5LhVQTq40ZvquntNnuO92ZzFjoWnNMyEWiKsVBttcZuYiXADTjmIHE/uhgEtw7ijF
	hzVCvG41K2KZribA6b2FKTm+kKxFDvBnAkVMwvGAB0EYeos8Yss1Qiewz+jpP7ZBsZFWCaVuyof
	rFqk11cfeLutfeKn+5sgh3JGq0zRpM+MU8SWpHlDe0d+GN/xBZOg5MlGS3dc2nAwO5TkHz6BCP8
	MOAl/GRK0Y/yVHxza5hI+EpSZLWPTK7q7o6dNwm9bOyAbJ+JBicMWHAcNfIcwpPAyIeTZEhKg9j
	bFZlk1W/j/nf7A0qEyDXkdJDX8PycbUiXo3Audfo6xcpbqf+XUEeRSGKIaw1UntjKsX6sUS8gB6
	+zuoMSSUm0qkb0Wypljztoi8tZZ00bSX99rXs4yovk0TDCx1G6tWD01ejCbe7+ItYFWo0eozoq3
	Y6jENCs8SpjbgnmD7TNY4lshvv9mW1z93W5qecOSTCAfDF/621IbGZVmKUPc8DfFQdIsxYJPaU2
	Y/6Qy6VErFobxWArjeWuCkipCT0FVjEtD
X-Received: by 2002:a05:600c:800f:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb7da4ec63mr52026205e9.31.1795010132684;
        Wed, 18 Nov 2026 05:55:32 -0800 (PST)
Received: from [172.16.14.5] ([67.207.71.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2c3c93sm99049865e9.13.2026.11.18.05.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 05:55:32 -0800 (PST)
Message-ID: <2c791bd1-7f9c-43e1-8a76-f3bbeefee897@deepfinresearch.com>
Date: Wed, 18 Nov 2026 13:55:29 +0000
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
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Mel Gorman <mgorman@suse.de>,
 Sasha Levin <sasha.levin@oracle.com>, Rik van Riel <riel@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Xu <peterx@redhat.com>,
 Hugh Dickins <hughd@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
 <20261118-file_folio_flush-v1-1-e9e739ed14e0@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>
Autocrypt: addr=cenk@deepfinresearch.com; keydata=
 xjMEar0rFhYJKwYBBAHaRw8BAQdAHz6z6MLA+mS1Fuz7sv4rdnByHh/NoO3hkH4hixSiOw/N
 JkNlbmsgWWlsbWF6IDxjZW5rQGRlZXBmaW5yZXNlYXJjaC5jb20+wrUEExYKAF0WIQTrPCT0
 JMi19/R1ti4EM3Wz2u4IvwUCar0rFhsUgAAAAAAEAA5tYW51MiwyLjUrMS4xMiwwLDMCGwMF
 CQPCZwAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQBDN1s9ruCL8FNgEAi48UZATA
 4fLQCEod98yy5j3o8AJ1FqI2atRtFZRuxP8BALjrpBK/eH606w5s82THH9hCWXmu9vhlMmUQ
 NiVUjIYKzjgEar0rFhIKKwYBBAGXVQEFAQEHQNXlOF5B8tyFRxW+4M9Ws0CGNVN//I4GaOEu
 Vqvl09ATAwEIB8KUBBgWCgA8FiEE6zwk9CTItff0dbYuBDN1s9ruCL8FAmq9KxYbFIAAAAAA
 BAAObWFudTIsMi41KzEuMTIsMCwzAhsMAAoJEAQzdbPa7gi/XN0A/3HYaeGJBCsWXe7xkZZl
 wDADkFGIqk6oSu7rvvRh2QPUAP9aEEF089q6fPA+dQdnEr12WX0Wh9+CItd9Yiz2WjmsCw==
Subject: Re: [PATCH 1/4] mm: flush stale TLB entries before installing a
 CoW'ed folio
In-Reply-To: <20261118-file_folio_flush-v1-1-e9e739ed14e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested-by: Cenk Yılmaz <cenk@deepfinresearch.com>
