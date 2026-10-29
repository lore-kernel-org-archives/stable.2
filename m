Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313053;
	b=glQo76IO+XwaVaxFawRB6nyPAjqUJatQvJqBgEFTkK0cCEVxX+JByY5rTqqbFmPmgJs9
	 igUd68+XlE/BTTdKDx9uVAgeibLGDVN1FnHXYVk9fzpbwIqBtB0fEESIBw16inv8/AjaK
	 VeQhyzLzh4xlxEWGXmETmxBon0rU7VcxkeflTtk93jtGptkNFlauARPhE3T0d48UrHWFi
	 vEXXBk0dfTlFC8GrLIpv2RwZkfJVR4p468qUz1Z5Rhfynn9znpsFDCaGitzNTEBU3Ov4I
	 jN4bzhCNzStEERL9CQbGlMLNgPjO6NIpMveoVgJa0LeA3c8izQhO80YwZhQawE0yvWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
	b=XwMrvsADi9poa6e8Hx5XeVbxXp5FFspMd/2shjWfBqFwEd2vCXJ24JvxIP3+jZi2XWyD
	 wB67ZIyInogNXvRr32hHeseJrdfD2fUU9g36T5QCbclH/fAdo1Wtpy9hybcn3Zb93/fTN
	 5CKunD5V0gtBvXXxIWGzl1F01PlNCZahqcjvYgahOU4TKY3PMdJ0Z25NfbEzEsEFEsK7Z
	 bgRHit/kI898J3LAfzS3Vb/h2NT6spPs+xSd5ll2QJ33GQZix2XTL5FHrnwdrARo8jdFS
	 FMox0TTMnRt/g+nCi9TFAFUAo9Xw2ue9Cl/r1RM82G5e5W4s8yKWPejFdh800s7311g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VSHotii2;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FE606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VSHotii2
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c7b00a75fso1237546d6.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313051; x=1793917851; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=VSHotii2iA/Qci+re5k9+hkvQxKjnotN/2zPP0cTQVX8b2J8BjE60+OcYufQKoVKvx
         a+j3LCBHF1DpLlIDKR7gb6PpKNODYEXP5niM7fAnH7XdFH7GFuaFd3xcGQIGPOzeeZ36
         dX2hldmlIJ3DR5XmGdNwQLj7XhdPI1h4ZuM7QOuzWnRVpoDso9hh2meI0Lui5uI/IuOk
         506s3mKiMnXlDNPtgHXynDbZfoZM5erpE048exc19KkqyliRV6xYwunu5BjsxA79iI4j
         XwHJNuL76Wix5UlGfgAKC8Pr4DZ0OiWTffDcTDfMEgS1ueH/XIz4VWe0mCZo0xJKxe0s
         aGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313051; x=1793917851;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=o+fhGPl0kEPC5v1ormYBiPbMuKxP6rxhdfHdUsjBIJFG9wB/RaiD1qUWy0LAWtSmNa
         YFkESN05KiCKmwBm9T2zj7Ep7/jvNUuB+ay0m3mWZ1hi0KwoD37ntdPu5QBt6mOf1tbV
         2OV/pSmcpRJ3mE3XbcveUvHOiKFgpSz8qF7+vOFEJN2iJfI9pgvImUlMqlVJLWktSpRw
         tKTOBCFKsarKwBviOMlHxAp5mz3z/aQ4wPTJ59fCWUyg0P14P19auHvfWX6W+HLj2As+
         0w0iMJaI1j+kbRTWiI99ggpin+kIGtzmDcZPR3LxhWQcv/JX1LsMWLISgsT1rdotdgqb
         v5Jg==
X-Forwarded-Encrypted: i=1; AKwUvByPZMThOh8dchW2tbEorLNOEOzwaE0tenZN7o1n2HaYTKSZdxt1d9hWS7+T1HsXe7rRDEf+QZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfGX7L4YAhNgAaHYFb1x4Dz+A8SUZVQm/UiAvriJurTUJ1TeQs
	5rI8fZdvIUQxawK+17KVh+IFHPCjApTLIbFTAdRD8tipyS1+HwNpvmNCLhI8GDMOoLk=
X-Gm-Gg: AYBFou0fDPBXJ/Z2i7zhwKQqUowlkHef/PkNvuQfsbny9PgFYhvwFd6bq+EMNtmQcO/
	DBftegxBRGl4ITSiY50IW4p2tabZ6WVGZ/p8/dzePwgm8iHVOxe33rYYhIzwLDxXCcmFT4yprr/
	KJjB3Qnogcg2sn5jTg7ZyKmv37vJXk2T9Cagk8CUE4PjJ5FbwmPk7Mgq8k6fsIfVC4++STHjnrk
	GKmNb9fvCFaSDRzWcs0+oS1+occN0ZLhP5QoyRqpq3YXPN81MYdnnZHGGYRHI3I/86L4ywRtHxe
	SzwC5iXlLh1DMEImGIYfDQxh0f2wcGko0W/RzrO5BhgfrETEMeMEUg3pOAgRWeXAkVSR/izBvi6
	0Z6nbdvInXkzXAxzRrs5JpEYFqTsefpzVo8/BKw7Lr9i5RR2IAbI6jYZZLJBT7f4+ooNqTqH11v
	M2UFbYyXAjDDJo3fuugRDZnWnEaCDUGKnKWb4fzqTbdYwp06tqJWARF4rZKy0YlPK/jbbqK4aAL
	ePU3e2pW5GxrGQhFZfNtBevrAOCuW/LKKMtUwjRH/6zwI0mb+8PojuPENE7nqgs7q+cp/rVpMXJ
	+I4SdAbvJeGQXpXh3SZVO5/tuD3k3thnYLsPokjRsxx3rL5bBtYXytaq7n9IsOHFXXi9E0Hqvw9
	5
X-Received: by 2002:a05:6214:5f10:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91ca4ae90b0mr5824286d6.15.1793313051262;
        Thu, 29 Oct 2026 15:30:51 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca68e5f47sm398016d6.42.2026.10.29.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:30:50 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 14/47] mm/huge_memory: fix zapping migration entries
 for device-private THPs
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:30:48 -0400
Message-Id: <179331304801.2127828.6570375349219520262.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A PMD migration entry can refer to a device-private folio.
> zap_huge_pmd_folio() checks the folio type instead of the entry type,
> so it treats such a migration entry as a device-private entry.
> 
> Installing the migration entry already removed the reverse mapping and
> dropped the mapping reference. Zapping it must not repeat those
> operations. Concurrent MADV_DONTNEED during migration back to system
> memory can trigger this.
> 
> Check the PMD entry type using pmd_is_device_private_entry().
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

One note below, but it's not a holdup.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> +	const bool is_device_private = !is_present && pmd_is_device_private_entry(pmdval);

pmd_is_device_private_entry() already returns false for a present
pmdval - so !is_present is redundant.  If there was a reason to open
code this, then keep it, but otherwise you could drop it.

-- 
~Gregory

