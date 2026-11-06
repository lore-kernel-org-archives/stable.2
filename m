Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958143;
	b=jjun+bFjGeTkIo5JpxIqnBcbt0PzqIWPXY/L8nCMRFOaceNxP0E4FymzhJt0RiEYILd0
	 l0vWYMhygzy1xaTQ5Jgfy/M86mehshHB75cCmECO4Rkt7gnJZSF8LPPHRsTBEpns3SMBl
	 Dj6KwiNU/jw19Cx6POWCBWel3sfthhbPEYW7n/8/HWw+bYGi+SnkM++scFcCSlqucNZo2
	 6SV2m5QuNnuiZ72VyNMv6dD2lKiFm25Txm0We1FoaYlR/blx09nyeLHqlnHEbyKPEOgSm
	 Gxkuo/EJ5iIgMKTvSuINuhpBR0loskwFFa1PE/VlrYVelVf5DYwuwQ4VdLxm9Ag6aLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
	b=IWbYMowovxwCH2mkk4LPl/FPgam2EwkANGtmKX9Fb110WtJt3bTZvZ7hwddlmtikfTVK
	 UU1qdGvA2OTcptNwqO0h6MnzaZRWw5WjUIuFOJjZS7cydCSRBlbZmvXP6YIEQ/pNfYUlB
	 UKu9iaepeplq3HzB0M+gVl1XiYK/GpmAz26vjKaoC3bqq11PgQUY24AM9WZ6RrKtmfrM+
	 O4MGDCMhMeSG/O1/iJuK/9EA6s0n3p7kTh8SOd7t5vLOGAbskBl90smsGQeqA710n6BSP
	 Hn7woUKYDiNOMohvUWO7GJh/Ny4LaOKLucM80jETI0G32hrkF9GlaSZhcmYBuVDnCYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5aviNlW;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A2606A90E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05A2606A90E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5aviNlW
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so3188255e9.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958141; x=1794562941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=f5aviNlWe44WrD8IRdQX6ADMuIeIzKR0W9+k5UrolgZdhp5s/PGxmiZR+YoERBoVJ/
         6icSuT1pJK1BhDf9IIxn5cOoFPu3PXRcOjMBVS/auhQmMFJtiS811F3SN0M+HYUhfQ3z
         zv/RNhWZeAqD7XzxOLY04ZCApDq0VHzqjeoX1GyvA8W4WDjDzzcBAxWierLV9QWXD/NZ
         UQ+7cbI6on3aS/XAL23R+H0tD54FGUBzA783tY3f96ogm/iz8k5ihmez/pJCMZMaPljs
         p05ksTgKwyP1b297hjQpu/uHw9xgDm+3JpKi0vgksCEUrs8AbsWwzuqXcRGIAUH0fsFK
         Fu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958141; x=1794562941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=yD2kwrczAdpZpsMGLKs0jkOKojrIyCLyqRicTtRE9fIT9OldxUZ93ylEooAguZdyP/
         0Ft8M6W0x7GC9mM+YwK8VYfuay7XS+yh5FUBIlqm6WDgHESdt6U+dRc0OSK9yrvg5eOi
         qBqwWeHh7iCZmWiIZtE3v4kVLYsl1omsEliBiBeMWFC/HBWMIzwsrsK0QcIdXrCfcA5N
         V3mxs4DOQkdwJ6flQvAAeO510stWuk29GZYZohzoxYREaP+JU0dF01/GZRT0PuK4FOC1
         ySlwefD/TbyLLJit5WxklgmqkKx5GkZ6GvBZ0EUlXKQd6YFaAj1+3PnNApM/vjek4C/P
         edLg==
X-Forwarded-Encrypted: i=1; AKwUvBzovr3ZnT6IkH1fbjiWsylswG2r9sVnM5pRTIPkWe+tJBdKOsF8duFKgjaNyeWnkzdP+q1HIrw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lTf+EZFZdArxppLmEcj29AjTvcnAGCmTT50y15FEx5hGGeJDx
	nqlTFxW5ccq5NH556mFzrYuFFI8Kp8yRonCtqgM6n7Mwi7fV9WgHtJBD
X-Gm-Gg: AYBFou1gb6GZlOmqE1HziUc7VvMLigKlp4y3kiPadewt/UWXQy5Cn5/EPQvT4X/XGLD
	lpb8OuNBarRJGGhCq6sxQ73jOrZzBsXTwA5WqSzKF2mOYKEA1GtlWvsJjoD03pjPT7np3jy/8eh
	gFAO4fPzGi7BBSBJHalq0yi7FMrCSXR3pXYufnFmyoCgNLeWe3NqW2eYYO3ScZqNS1MBsrzT1gF
	CtneFGbdg1pM7A+yAP8WW0cDaBs0nCWypMhRVV7uL0RasDCg9Gg/fzqj9Oy0XB305kDAZY52uOD
	nwvmULWD76iIwS/OrO+aM7VHpe+HqETcMvhvV2oCaNQb7YCR2b/Tg9kPlvdJabGIU2u0LQLveTQ
	RQz+nPvYW3I0iO/wjY5/UbDe4gvzdWY9MwxtRE5uA/BD/FdaZnNEiku5HdPTfiRHphZqp1EyWcR
	BgkvUSKE/8Hk74L8BnJP9C5xzMdubQ47yPtOUTaZ83a1EHVvAY3G+Dzsd0IXRMddzhOAq3KjTNC
	fvA5mpqv/McpX9OPWB2PiLGi2k/98y03ptQwO/cnaU7ry6SrzyKGeY8tCOrSLzYpQzPEWUkOqtt
	/9PLrSny5hO7phrvagOwmvc=
X-Received: by 2002:a05:600c:c168:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4b6db2ba2demr25269125e9.4.1793958140866;
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b741cdd8d7sm22361285e9.1.2026.11.06.01.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Message-ID: <528e3a0e-04fb-427f-88c7-63a7f4bbc505@gmail.com>
Date: Fri, 6 Nov 2026 10:42:17 +0100
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
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
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
 iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> With large file folios, overflowing the folio mapcount and refcount
> became possible. For anon folios it is currently not really an issue:
> each large anon folio can only be mapped once into a process.
> 
> That's not really big news, but it's about time that we do something
> about it because some modern technology might find ways to abuse it :)
> 
> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
> refcounting"), however, file thp support was added later.
> 
> File folios can be mapped multiple times into the same process, allowing
> for processes to hold many references to the same folio.
> 
> As a short-term solution, let's introduce two folio refcount limits:
> one for ordinary consumers and one for admins. Leave some headroom
> before the refcount goes negative, which we really don't want (having
> the mapcount go negative is also not expected).
> 
> Start reporting SIGBUS if we run into limits. When restoring mappings
> from migration entries, instead zap the pte/pmd entry. We allow for
> slightly exceeding the limit to keep things simpler.
> 
> This is far from ideal, but better than all easy alternatives we can
> backport comfortably. For now it fixes the big problem: letting
> the refcount (+mapcount) go negative and cause trouble.
> 
> This is only a temporary fix, we'll follow up with something better.
> 
> While the refcount checks are not required for order 0 folios, let's
> just add them for consistency: each folio_add_file_rmap*() and
> folio_dup_file_rmap*() needs a prior check.
in mm-new copy_huge_pmd() now does a folio_dup_file_rmap_pmd() at fork,
since Konstantin's "mm/huge_memory: copy file THPs at fork like
copy_present_ptes() does". doesn't that one need the check too?

the rest LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
