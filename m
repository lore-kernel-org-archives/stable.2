Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346502;
	b=nJ+0DQTAKz734TqEWv1xJzzRBIsPro/T53TiCIjld+cea9qMkZJGB+mwEO/2cXekeTih
	 nREEgSKBT/4dQQSvidet1xCl0a04P1/r0kOl8qIytuSiZ+3QsyEmY7x0WW7wVOADOuKP6
	 eUPmI5PyGT2MtPRr9fj2hUidF0lIEMIhBiZzHiVOHFxI6lPdL1CXIG4ChZ43CHiJwNqTb
	 HEItlvGmtmx8GxK/6Ydyg2qm6HjGmrT0PIFu0b3HLmodNKEuNFxoPC7uoWDQRvTMldUuH
	 /pVMU9npJeRpqSkjq6JEEzbYIV0YxwBJDhquWBDDALEzDgtbiTMsTWbruYw8ew8YyTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mOqbf5f8IOrYsXobBY3T9L29gUMiYe3oysuU/ey3bJU=;
	b=Z2KkrOUfYFVT98Qwh2j9fW7I6HcA5RGT+jp30lPH1VVD3qJbRbuvUK//oo5AUcI5AX0u
	 b92ldIgH1wa3AZTHZEj957LGoMzD++cOd9FkPSHRaYq23g62Np9nTk0MDfIZ2wlIp+F6n
	 z9iZ/UKK98ETdrGwQG2ZKFG3KONHOap6vo/lqKBwesKMIrL929YHSLQph9sXT0n3VYQh8
	 JzfiThfRnDXiiezl92+MMNKpuz3/MQdKbUVHUjGpSVofySOr7LbtL74+94eQzu2Ih6As2
	 h776UlcBlh5VuYftWxUoAAP4KImDAgg83cquUcEDT7gL+cycirKBMI8jHC5q7365pJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQ5xwQ6H;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190BF606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 190BF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQ5xwQ6H
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so31768565e9.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346500; x=1794951300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOqbf5f8IOrYsXobBY3T9L29gUMiYe3oysuU/ey3bJU=;
        b=cQ5xwQ6HxvcHCdVO4r6Zx1QKFnlw5WLHnAF1G9hPEgTyBn03UOrvZjE9idlHwO1Ry9
         Ua4VMMAmZ4MUqxSKUEOgOuNZ8EZlSYLFOQjjxypNvGBlSnE00SnaVz/OC3Yd/f/JKk3d
         ixozxVkn48kkO2fGlEyzbhH2W2i842magCGSlXzocmY234qZXqjWwV7fXieUZgClA0Fk
         YKBkqZje0zuORPfMlu7J2D8lQ2b+Dg4ZUacCiwBh8g9bF129dWhdYYppNulvfYEBvGbV
         0igXXgKVF8NZwyyzVntYU55XI+ye345Kd4eCvg/S9bVkz95mzJRfifF8IZHZaI69Klde
         HUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346500; x=1794951300;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOqbf5f8IOrYsXobBY3T9L29gUMiYe3oysuU/ey3bJU=;
        b=dn1fPgxki3p9jtnrf17H2rfcWXbyLoAhvWfLDYlx5bKdcmMFQL3ItIDLvrUp6HYDDp
         YoiMI4MJ97xNYQQyoQVFpxa9hT/CxnYhW5gqlyr2zd+2kN2PIhXgRl3+5F3CpQg8Nc3p
         TScocIqW+bED5jCC/Z4NcjlmhOlWwtehj8C5FFKGq4PTTGtz3AZhB2pt18A0rbKqc/0E
         AGn37G+zsaHh7n0vEV7elFn5psH/TMCpT3SnQi9HZyWvcnP+uvUuB6X2a13RtRgG8Rxq
         OcUtqnht1pozg1V3o9L/ckGQNj3hWa5ZSHrYVla88FonYsDezXAgJDUdLgbcKhKWsG+W
         kJbQ==
X-Forwarded-Encrypted: i=1; AL+hErFPIP2sTLFLcqJswA0tCnZduULFGw/uoFd3t25X/i9e2g6X6heIaUVQC7oU6HmNv8EszmCtybY=@vger.kernel.org
X-Gm-Message-State: APuU4Z97JkdVWvtX+d2ThL9a84ijvVgs4An4Vu+bxkaKYGvqpM+gk+QY
	YbLMfs2SdJjahuhzziJcB/bn9XILS1WSBuKSE2i3qzBwlMtvQPK+59fM
X-Gm-Gg: AYBFou0aG3Jv3RgPj5ecUcTVYqvmSqPm8Jk5qknK2gEbwYjmq8gQXIShl3NNutk06eA
	nLNq8ja4hwI2V1GAWdCLS6xRmUwPgnoM4E1vhowi/gwZsDU57eoWV/paSADpGwrvcT+sdAuNblp
	d9Xd2pxrcWf1cpm2G5MQ3pGQQRTPaqYx5LSDRXwUSNJ6nDlqLCOtk2s0UcDuYazsAh+qXnLIUpH
	0shJhd29kx6N7x4qFIW1tN3vEVgC8KodZejoyI5gQ9cifho/XKihtYRMqaRNJQyetKP6ir9O80u
	SoJcX9aYm8MJQjXtpnYyx7tPOIj1amPpRrL+2vhBIR31VltQCu84uSaLXj7UgpaUhbUm2E64ERX
	nYCmvFHqUj7ggNgoXBXqfgP7o4kt1hGVaQUNsa70+T6IYFoGMn4leRu4UQ0Spy5mNqa5Wrb9S4o
	WKcT+USC7NMP4Oy38xtDjaCyVOuUpMJBch9CRco5Z9YGmIQtj5afxOV+X4fxLfdeNQF+SFUm3Ga
	h0RA+ZkQvVXDFVKROzFD1NC9O0ujG6L90YBFa9MhVNY9mFVTzR/R6XxXmsHSsxJytu/WWWr9XRz
	OdueHEpXYZ7Jiqjnx6ekSn4Q
X-Received: by 2002:a05:600c:364b:b0:4a1:d766:758 with SMTP id 5b1f17b1804b1-4ba08e1f572mr8423245e9.16.1794346500171;
        Tue, 10 Nov 2026 13:35:00 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3fd2sm7670526f8f.52.2026.11.10.13.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 13:34:59 -0800 (PST)
Message-ID: <cbcd04e6-b0c6-4a8b-9f89-4f57a4c50864@gmail.com>
Date: Tue, 10 Nov 2026 22:34:55 +0100
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
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
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
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 9:35 PM, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject
> additional references when splicing folios into a pipe if the refcount
> is at its limit, similar to how we handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Introduce folio_get_checked() for checked reference acquisition when
> the caller already holds a reference. It warns and fails on a non-positive
> refcount and rejects additional references at the limit.
> 
> Use folio_get_checked() in splice_folio_into_pipe() and
> fuse_ref_folio(), returning -EFAULT on failure, like we already do for
> pipe-buffer duplication. Similarly, make try_get_page() use it instead.
> 
> Likely try_get_page() should be renamed (or removed) later, as it doesn't
> match the folio_try_get() semantics and is confusing.
> 
> If we hit the limit after splicing some data, return the number of bytes
> already spliced. Teach the callers to handle errors, and stop
> filemap_splice_read() if we only spliced part of a folio, so we don't
> skip ahead to the next folio.
> 
> The check in try_get_page() also covers pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Note that we deliberately will not fall back to the slow path of copying
> the folio, particularly as the folio might have an invalid refcount. If
> it is ever really required, we can revisit.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM :)

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
