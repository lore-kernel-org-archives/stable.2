Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041313;
	b=Zg1aJiFBQWH4Rj0412ULQ7eO6dBUTG7OhSAqrWJNBX5qdJBPcHuqAAFAQXIX9gHeBRhR
	 RMJVfl20WiBE3LWuPpal1W3NDHsMAXEQfdE9GGmsnylNJqhOYpPbAFBTCxsz1hGFqDuHs
	 IBJy0fSjybpznUJ0/qBTMaLrqeIJyNoOIpMPQ1IzMTZCitms+AYZPk4d7oQY3yj4jv6hK
	 Rb/PKJ5rUA/QhSkbqx/lekCQHH1Crx+e/6Zi7877rj/HtNSgJUUW6r5EalZ+QdHvfA3Y0
	 5yCheOpG3UAAzmJQK8GkGNz9d8oYshKyA3PaaTeaku7GlQ1WTbiEtqG5UfeI9mh/TjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+wEj8CWquloqUtruK2jACBvwnRpGsJYik9FeeinA1ng=;
	b=ruOnOly+gmfjVOYV6JvSlvrWGAT/Nm/menzvAcUSsKQ40d/Bm8pk6SHFFBLT6j5SmvCY
	 wRv0J/d18t3IUzp6l5Xif2of/RFKDzyHKBCNgXYVg7vt7P/vR4YN0oIK91oBA3Rp5lI7J
	 8iwD5FD6tiVxEPSUdNBB2ME5c/TiMwyrHqCpDrMZiWuXct9BfipPYme98J6Ir5C/Zm1PW
	 Rnk+r9w2tDAudDtzhoz9wSR1Usueo44CmCWZVOAAHVAATyRyBOMvPzNCrbwlnqzx+3hcf
	 0r8mJAjg04cA1woiSHd8nVZ7K/dAJohVlhZYI6wKwKY1XytZZOjktvj6fzTp247jUZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pGRNfmS9;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E365606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E365606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pGRNfmS9
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so16289725e9.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795041311; x=1795646111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wEj8CWquloqUtruK2jACBvwnRpGsJYik9FeeinA1ng=;
        b=pGRNfmS98w+QY0eyutrVZ4vvk5cqFOyy/I+CThkz9hde2+IK9TM7yfxhZieeDRbuJq
         A7bqb0eODI6dFfNjVvKqY4t4sdRGV8wTZd1otbjojVfdg4l+MBG4UVyK9TdvBZqb1Lbn
         mq3y+8oKROpj9r2b3hgYMAvR4zRdT/S3T7eNc2rCSKXzam409hTEDdWvnuqGbNw+dKVZ
         7vcegWMaWtYmDVFdmkb2Oe1wDDccgg2yw3pErYBvoCSLzGr9pVlL3wNPNGg8nLJWhw5h
         /2QZJ6rZWFdkA4uNkSAwxzntIQ8hRts76df+A8+lTjHWS28P9eC+WeXh/OFxkZPYnnkR
         Ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041311; x=1795646111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wEj8CWquloqUtruK2jACBvwnRpGsJYik9FeeinA1ng=;
        b=PyZshJX9IJdWtZcPpQci311ZsjIwpx/X2UBk6dJCy2rDg1PARtJKattA43nN5LL1uH
         NO0HWtU+iJHFsvZivTjQx4lHu3GAODBKL0goqnzBdDSyWHC7NWMg0ZHtGLpY2AS8cs55
         VratSQkvJU8drptTRKGoQ0fDxEOKwpqySWn9KVe/4SQH6+BMnOaHNtDKViiwhGUb23t1
         RitV+raXQVIgKgTXt9jGnHZrGBuiiejrx1PkmyHj1vUgeFTFB65YHcWOxGIReCBCdwya
         yaYzzNauYd+gYmjtK/nMSWDiFU1eTdvkl+6hgMKg4YBd9lBa4jPJuMIt2+bLjQVYbGPy
         lYlg==
X-Forwarded-Encrypted: i=1; AL+hErGHOGFmPfQBkr0x0XvwDRPxsskCLt3be9n3cOzr+Mdvim9mgQIJmiS0slLZ1AFXaxXPloV3AtM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+taXLgn2BlFjljxapUpnoKXG9a/ey3iW6+0uSf2hQZcbqkAx8j
	Sn7GXcRm3k1/RplcZp4riatQCJThGfp2O+RGpU7O2fPXBFDzGYX4NtUk
X-Gm-Gg: AYBFou0aO1DjFFyw7BG/HjNumUE07q//dUggmJEHVSbz2ZhZK9f6O9OwjRG2jJdPIPS
	Oi/7spkIamPU6JuR+H0ab5zlC1RtlevKO9amsa3bvvMs95D0M+WtwhX5Orl81kRTO0crB66PUUt
	y8AiYxB1m1eqyTNDru7/cz5L5OuTsL8hbvvP4rdph4YtUZeWduNJkmpSieskdR1ilXeUrlA+HpG
	rBgQF8h1r9J8kVPitiMxirHLJ1yGFLpbit+P0RHQVY0oiGI6FoDq3FlAqURVlWHwxWtPHLKKcUJ
	Ttlhg0xurStEO8miwA8seTpQBJomzEDnMJq5xwlZgd5ABO1LNWJoyM+biG5Og68q9+Fqx5RF9Px
	Chp04PX5RS1zqSIXAdRdeHQfRfQicPTmPQejk5Tg2oAh4XfsDDUMAkJrCDQHEMpAqfW5hzwAUqA
	BMoWE2Cckoz4rldAo60NYKlltI3uv7V4qbLzfZICpEbARDtx2ErDriKDOJGR8EKy/275EgTYSyF
	3oqnLZfTJtP00X7GogkFsbCkNNOx9h1Wl7VnjKdKkFojAQWSYo1/Oyz4Vbfb+TueVLK48DKAojT
	WSOBy6HBEYZyYBeVcW/J5PQkfxSEF0XLPw0H5aRhC5Xaxg==
X-Received: by 2002:a05:600c:4e92:b0:4bb:6a2d:b440 with SMTP id 5b1f17b1804b1-4bb7d6d1df0mr87283275e9.2.1795041310455;
        Wed, 18 Nov 2026 14:35:10 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb845223b8sm2954135e9.12.2026.11.18.14.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 14:35:10 -0800 (PST)
Message-ID: <e0a946fa-19bb-41fe-adbf-8ead08009ab9@gmail.com>
Date: Wed, 18 Nov 2026 23:35:07 +0100
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
Subject: Re: [PATCH 1/4] mm: flush stale TLB entries before installing a
 CoW'ed folio
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
 <20261118-file_folio_flush-v1-1-e9e739ed14e0@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261118-file_folio_flush-v1-1-e9e739ed14e0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/18/26 10:20 AM, David Hildenbrand (Arm) wrote:
> Zapping PTEs in zap_pte_range() defers the TLB flush until after dropping
> the PTL for clean page-cache folios.
> 
> A concurrent write fault in a MAP_PRIVATE mapping can then CoW the
> page-cache folio and install a new anon folio without a prior TLB
> flush:
> 
> 	CPU0				CPU1
> 	LOAD(ADDR)
> 	 -> #PF
> 	    installs R/O PTE -> A
> 					fuse_open()
> 					 -> invalidate_inode_pages2()
> 					    -> zap_pte_range()
> 					       clears R/O PTE
> 					       // delayed flush
> 	// Other CPUs (incl CPU0) still cache ADDR -> A
> 	STORE(ADDR)
> 	 -> #PF
> 	    do_cow_fault()
> 	    copies A to B, installs R/W PTE -> B
> 	    // no TLB flush: PTE was none
> 
> CPUs with stale TLB entries will still read from the old folio while writes
> go to the new folio, until the TLB is flushed.
> 
> We really must process pending TLB flushes if we are not faulting the
> same folio back in.
> 
> Fix it by flushing the TLB before installing an anon (CoW'ed) folio in
> set_pte_range() if a TLB flush is pending. Zapping itself stays as fast
> as before.
> 
> Other faults are not affected: unmap_mapping_*() users only remove
> folios from the page-cache after their own TLB flush, so until then, a
> refault maps the same folio again. The exception is a concurrent
> invalidation that removes the already-unmapped folio from the
> page-cache before the zapper flushed the TLB; that is an unlikely corner
> case that we'll not handle for now.
> 
> Note that we don't care about MADV_DONTNEED followed by a new read
> fault, as MADV_DONTNEED only guarantees its semantics once the operation
> completed. CoW faults will flush the TLB either way.
> 
> For example, imagine that MADV_DONTNEED zaps a page-cache folio and
> doesn't flush the TLB (but still holds a reference). If the page-cache
> replaces the folio, a new read fault might map the new folio without
> flushing the TLB. That's okay, as MADV_DONTNEED did not complete yet.
> Same applies to MADV_DONTNEED of CoW'ed folios when re-faulting the
> page-cache folio.
> 
> Memory reclaim, which removes folios from the page-cache before performing
> its own batched TLB flush, will be handled separately.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Cenk Yılmaz <cenk@deepfinresearch.com>
> Debugged-by: Cenk Yılmaz <cenk@deepfinresearch.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
