Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041355;
	b=VDNoj4N+4CXsOgAM651nAhPgd6Rfxe2Pbl+RaC39nLp+7GIWqiyq/VDU6Qv7DlUxd97s
	 ebXCkdyQ/zDtxJNp1+rIYZEFiF743Lqlx18rZHttkX8Tg9xGhY8GXmIitPKGjM1LHttbT
	 l5jL3kjbDKYcT/F/Ohb2hsga2fBF3z0K5KdUcRgAjMLucQf2Il0HtvHyvGfhL0pyDipdI
	 DJ7oAPPZUqXgCICFgins5oWvObe5RmpPQal01GUx5H0wPC/T+iN6383o0pcRFFeP9ZFeP
	 a7A13iJX2bIssY1eFwXxWhHKayHvemkhao4i4IFYyx2X7kFFd1EgjBUX7XycdDRLMZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/1QlJHCek+NUM+XDDyqHX4umCUytIfs6olrzBCKAfC8=;
	b=MJ/1Kw5cjUfnZGcqc8mYQp5Hu7ovT4u42f50lEjiehqFRKaA8w0je9k4xE2kdtPaqwto
	 NNszjkAw3vyvkj/VIHDjCIREpUwud2EDbZrSY/PFZTDYXUffdphXuaTQjJ8wjmEDgC6qr
	 QbOCbMQHbXbVT1XywLCDSTmNRL5jE1m4X+788HCVgsSQ31+Bv1vq9PZzZwquiRGmRbrtc
	 a3gJjFjxxE2DIl+2TsCGWJXLap3k6pPiJrCM+6bxU4h4nQ1UWX5qI93XUSNpGzm39EwZD
	 ACe/fURsWcQNt58ZcUk032xCHp0chsoHUqv/qO2f3csuiTpCGdGzo+4plVZOhmAHcCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2k9Aopr;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA32606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA32606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2k9Aopr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491846221ffso1293807f8f.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795041352; x=1795646152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1QlJHCek+NUM+XDDyqHX4umCUytIfs6olrzBCKAfC8=;
        b=z2k9Aopriz/s/DdJBcHB96CxFi9cWMysyIavKi0+kegv2HKMstRYQHOC4Mqo4PI5Gn
         nx9x91MTbTNzLMdNMBz1NseyiIRkYsrxrzMxd3V4SEunBHQtBJ4G5YDTDpLtgZixhWkq
         /qqdYESS27oMnu+7KoFJmoqbfFphM2TMYu7OFKQrMvy03ZSKipNikKNgbb9+M7VVGfnq
         0uc2YV1r3hvRw7bKWswIqb/2A0JI9uxhQML48EA0ZY5plsnH2mZO5N52dJzG+K9LAYLL
         EGDe3kRWWQy5ukKqvoPA8gxeUKHc/GaIjXURRfPAXyn+6obt8fC5G7ETRYPzYFUGEFW3
         TxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041352; x=1795646152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1QlJHCek+NUM+XDDyqHX4umCUytIfs6olrzBCKAfC8=;
        b=QRp89YAgetJ4DSSYRtPg+dxq9I9B9v4HhdEAEHT77ZDij3wobf1l8mmH4c3SiG9Ht/
         clZm3cjubx1Oh8O2+cwEtLBvi8reNkgm1irXKo8NGLj3Jn5nNuWOBsAN6LWKCJ39dWTQ
         oyCbz6rEBFMQV5k7LsRixVsPm/CoTW2wPN/euZYZOF3B8i+rSc8f/+7+lgpZVdC7hhQL
         FqG1uh6f1UhtzqV8zCTGIh23lw0xr/jWR+B0tRHVyPqMr3qRwcPCsL1fSg7sCqbLu3OG
         FTUwd8dK08ca4dYsDCDr3EgBighGVDljbJuK6LhSpTe+HJ4ZGZb1wTqCPq9nqxcETwan
         k0+Q==
X-Forwarded-Encrypted: i=1; AL+hErHhllf/19gDDl0IceCAj9h6Anz0wBmmIui3GW2jHSkqpT/kuezis9LMDpjjuDbQvpJa04lA3NY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cV7vlEdemGdt5YuTcS2L7XgjvWNNhNsXzy8wbd/A//J05bz98
	dY0yUtiOnCWR+QupxHsaZBMk2GVBg4fdz2Nfa6uQw4x0hoYLFq7GWSCm
X-Gm-Gg: AYBFou1IE7FfBOniURP7zCOz1gBLdPrqGIfaEI/S8vANnC/g+beUopHWgUJiKydGdux
	xEIY9O7rQ1ob8zpdw19tyNEXXD3vuh/k5fIGEciySFLlFCsuWhCLWcOuL0+J0cxsd6mv+2u4MWC
	PeqZlPuWPzqJcRu6wRaoDuSK+eZ9CAhadpJqrEOpT14fP42NfJeGWtTiqlJP49hwVL38sQYRbTf
	PR/knulz6t/+e9N5wLXt5J9H59MVMiDDvncirHcOElEsa6LFDROCyLEHS86X0WxT4P22Yjg4+kR
	fQrmm6pgDkKM4rwDqfQg1ZDQ/ZscfHWJbRWWa8YLaIHMXvEUU20qd/RbMM04B731OuJU0lFi6ce
	Zq3MbLUNzGM7bKQPOvnZ1sVkdNqGs+iRWH/SCBNAxybrDcjiWG2HSRFQUAIZlSPE1MAWqiLEY4L
	EqMxHpz8GvpbJUsKEV0/3cIAAnURqSnT4RyViuTJ3QosagUSHutBc83v3Iqa1/RrYGGujScuQnd
	24ZHxiA0PhA+KeIorYJDlicM8CozKZFslDcjBNdD2XTjZLOS376bxbVYAlNqy4vzU42q6M8mPTw
	CWSYMCAvTIN13AZf/QBi7C9b
X-Received: by 2002:a05:600c:4f14:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4bb7d6cc934mr90494465e9.1.1795041352279;
        Wed, 18 Nov 2026 14:35:52 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb844ee2absm4881495e9.13.2026.11.18.14.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 14:35:51 -0800 (PST)
Message-ID: <ad22c01a-dfd0-46ac-bd51-ac5d331c9a89@gmail.com>
Date: Wed, 18 Nov 2026 23:35:49 +0100
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
Subject: Re: [PATCH 2/4] mm/vmscan: flush deferred writable TLB entries before
 unlocking the folio
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 =?UTF-8?Q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>,
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
 <20261118-file_folio_flush-v1-2-e9e739ed14e0@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261118-file_folio_flush-v1-2-e9e739ed14e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 10:20 AM, David Hildenbrand (Arm) wrote:
> try_to_unmap() with TTU_BATCH_FLUSH transfers the PTE dirty bit to the
> folio and defers the TLB flush.
> 
> Reclaim must flush the TLB before unlocking the folio, otherwise stale
> writable TLB entries might be left behind temporarily: writeback started
> by other mechanisms (e.g., fsync) will not find any mappings in
> folio_mkclean(), so it will neither write-protect nor flush anything.
> 
> A write through a stale TLB entry after the folio was cleaned gets lost
> once the folio is reclaimed.
> 
> However, reclaim currently does not flush the TLB if the now-dirty folio
> does not get written back (e.g., gets activated or kept instead). Fix it
> by flushing right after try_to_unmap() if the folio is dirty, which makes
> the existing flush before pageout() unnecessary.
> 
> For dirty page-cache folios that reclaim activates, we will now flush the
> TLB immediately after unmapping them instead of batching the flush, which
> is the right thing to do. Performance-wise, it shouldn't really matter
> much, because folios with dirty PTEs are usually young and reclaim won't
> even try to unmap them.
> 
> Fixes: d950c9477d51 ("mm: defer flush of writable TLB entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
