Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958640;
	b=SO2uDWzXcenOS7wuomt1P+nVyJl8B0/YqDCmo7EZCA8POrPwpVXWajogqbycsb3hyZiQ
	 iiIFVlFPqR71szLXzcd+fONpZiVl1QxQBAJOUSaBKPAojFVaP6jOLkBWouExZbM+5KdRg
	 6GfSlAdjIA7c1kbE3VuUReZYYslOY7yb5UzMc5lffcPosdUcW/Jkq9PvKJH9n2xxG68tw
	 S7nq+++2oMG9DBk5kqcllsjvPjAatsOiIRQOfW1zfl9VccTPhIbHJ3j+ZGIXKTJ5KLFCZ
	 d6v9n1HS7SwheAi0dlwBbw6nM2eQAkAyHa3l3qy+Krz3crAjlVcKDgOZ2ehsEDJ5olQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
	b=Zb7J1D41a16rSlVOnF1M5RK8oFLQ66nQsFbAjdGseHDuICdX07OmBhgTX8qHHcafqtDC
	 vcPIkOyTOrq6pLX0Gx6XtH9ZVs0auIDb5XUs20kIyOHCe71dC99QkN1bgjkmRwd1EXkyN
	 oV9SBnezBZ5K86meV4cmnrHWHayrFvEhcy/3loEBxlA7xRJ0+rUenYWMFTW94MWxhmIJP
	 eWTLDfN3PkPr/0Zdbq0OCdIfge4rbjOAZLRvAj+Pk8ZBTw/ILZY4eRYjxugu2djtLD99E
	 Z5y1weoSU5EPcuUhdbbKCXw8Vmkec56HutxloeMDJcMAgeVlNpQYvSr413P3QDVnntg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1D9H5iu;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6D606EEBB
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD6D606EEBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1D9H5iu
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490585eddfcso290439f8f.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958638; x=1794563438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
        b=t1D9H5iuTUmjdPhOVJmZIub2cA7iiSUr41ZQ3yS+raxwi2K9JW5USUNO1Ej8W7ktyy
         jDlpr6IYaICDt5N3782Vm+vT8R7N+VD6e282WCZUIr3qHs3ymqVae8nOek4p5Qr6O/oS
         dqZpOzvc4Swchkzri6wDXvUOBTWJM5lyg5UOT7Y/iAiO/bDMWNay73N2vmeXoqlrNWa3
         CWfy2PPZ8DtSbf0uhLB61kRz/tBH8yhEbP0mgAap9N/KETVXb+EF1zhC7HOG5tW8CGpR
         ZOvm0YUZZDiDTRNjJd5C/6nVAnSAYqMrPeB1m3dSCFZzIl8NAmnARF5bgl9O49QSbyKD
         /grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958638; x=1794563438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
        b=MZGf0a3rlZSNzHJxcBy3eShIFvrTYtM7XqJu+NJzF6WNehxpQIAmHnTJoi3/Jei2pv
         wrLvZew0qJ5v/M468P7eCOFME8Hm8f4R8/jIv7ocEfkx8XnT9R0KMFEpL0YD7TGeIrnJ
         0nTOetVNvy+O5pFlFXHM0mCfncS0z1ZCrX6fBZRNlwcB+8huJMKre50gkAf2NW5oiE3r
         tVehxjktyVSuZdRIeaGrw5S0LNZ+Vv6A4F0FTvbECQ7m+sl9TBQUDfh3bdbaNZcvMeZq
         IKhRclaKIHYuJn8XyyawVPHDw4/QSKciyN6fXVsSvaNO6ONrlkhRLdWfi7cJkbtlXKIj
         26Lw==
X-Forwarded-Encrypted: i=1; AL+hErEOVfIQcDQ6JX9YS+nws3IjZ3MapBTle5jnWZuwXoPn+Pjj5iVJADN+k9roaAd+XJUNEAiWeo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RMrgd6LzU4/3jvqIvOws9I7tdTc/Epn/UP6boLc+Wn2Vc7PKU
	qx/8z3VigLTkfY+3BvdM4FGpOooeahoyi3QnFsxWUFpGVS9QUYrdwd+p
X-Gm-Gg: AYBFou2IOvjlpTtFIfRJ0/0h/5dV7VYZN9vLCegPboJti2TANmQSA/Ew14dYWTuFN5a
	8U/PSKMcK40qouFxQ+V6Ajk0GNUTCpClipGLu8EgmvVUMISsckP5/3Kp4xeJj6ZmozKx5RC8pW8
	VQ42eHNevTayFSwkvxJoZUxOUqlYsaGGmmMi2pmbLJDv/bDXbraxwe415ElOX26PnOFGNyIiTxw
	cbODQ04FJ4XRDrnwGE9TKjiLgHxooBvvghC58RNXc/esRuA5+SCv2uoZDvL6n+KrJvT4MnJtZmg
	JeCFjikaJjhyQ4nubDafgjxyZIX+K89mpHd+oNnP+ZyzxEki93D/uXfJpZcFJYVx/2qE3T0mxEh
	VI0K41UvaM5h65g/cfs3itjeLi9PyQk/BfaovdEVL7LVip4KoUNlJyim/Ryypqj0oLb9184Sf9c
	b2xKT4cm74Nr2fqUPXe/Ty6VhTatYpGeBVR1hDfLQORzy4e/OKOXsqxx++mvdoJ3HF4Fl9on0bm
	5fgy8v5BDEfCwxbZMvtAjsQSI8Wq/yFXVLROVb3AFyLrbrIVmfnaD7JkMbhleCUAPutNOJuTQRx
	9otZfcb/SiJXSmCKnF0IvQU=
X-Received: by 2002:a5d:5d82:0:b0:491:83e7:32bd with SMTP id ffacd0b85a97d-49277f88313mr3982559f8f.50.1793958637679;
        Fri, 06 Nov 2026 01:50:37 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d60e78sm2755152f8f.1.2026.11.06.01.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:50:37 -0800 (PST)
Message-ID: <6662ae76-c8dc-4bc5-9730-bf9f537ca9cb@gmail.com>
Date: Fri, 6 Nov 2026 10:50:34 +0100
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
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing into
 pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject splicing
> folios into a pipe if the refcount is at it's limit, similar to how we
> handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe().
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
