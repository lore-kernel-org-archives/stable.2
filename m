Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997979;
	b=ftWYkAakBrpvGGc0MUillhRfueT/0j6HR0I9aFz2iPqS9YOCtMbFV3WSZSzrZRiazsy/
	 D7RBlE0fPbmfxj69h4HAFgzTjp8avMiuSw3z8A/DGZ1z5sYfjnybVMXctX47H+MJhEuvG
	 vJzM6Vy4mfDc5ycWcCTJZhMH/AE9ixeYIYbjQ9UyPlqphRySHwq0rX0P1N+bAdJ7noPbw
	 yKbPMoW8GwtlmZip1ITB6skFF9rZNIBZwhs8oa5uxxgptClKMztElw2WplQmwiT1PstBL
	 FF4hISMDMR9I0sPLMvP+F/xT8/E8ng4QTrMB2i+nKvvsBi73uDs74FKFNIcANL0f3Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
	b=mGVjHAMJqMwHEdUf9MsLM/SvtGn3bf5Px9uVMFbBfKKcDeOZa8JMdlSf7jwvPTQ4GSiW
	 9feQucwi4USSpicpzArtD0G5qIU5oRhOrPd4c6nPq5yhahUdd134B38YjrbRoI4yBOs+X
	 jQb5vkRakROIhcS3uc1fGt9viPzHqWCMdkQ+rOS6TOP5PwL8n/aZ0LsiLKcyA9PBHLGBu
	 Xn5iIE6diOSWmFrx0K43/1SvcpmY0QfWTQP0QjHu0a7gYe/IdAKmkGMAvOqSqVoD7LNLu
	 LYO1PK/PySBgsg5XpRT0Grto1k5U5HEvaI4g7r25CrJLcVTrZTlrcu3nTsqm9oXMmpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ia03zhgk;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58361606A331
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58361606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ia03zhgk
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f1cf92c9eso100695385a.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997977; x=1794602777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=ia03zhgkg8F62JJYs7M675TbPFObrCOv0u4oHOTJtFvqnTcmUDcbBVFNeSxJ9PD1Vd
         X3++rXu7ynGxcD6HJjYul9kMp2mTDpSN23R4UUoU0ZwdqEDcmhgNvxGOesSBXgouN8oh
         WDELPOC7iRZZXkBkQkIwq6qlSeuTE1ejJR5M5F/LnPE30IX4g/Ud6Zh3xUNRGf4pAPVX
         dMOu9Z+AvpbbS4FXZzZIAHlPF/xPfKu2d/QsjpRhkxiFFOUWUxlXnYq3llP5eRSIsIwj
         Judl3kx/z9/513cMlbrx7zq3FMlrSz13MdWcwld46RFB6UfDXOczNFtCUB4PVH9CamY8
         GLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997977; x=1794602777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=Gf284mbWE+hg1Ug9rHjbEL7xSHCOHlXdkLVuZ+kWCdIyXTDiggvTSE8L4jINutOQcP
         ElJclpGEQiNGU3NdBFMXVTy0aaOuO7znl32FSExax+JvybJ7mwhQM67pFCEdRKDoEc9A
         sLi7055/YI+m0FnVivJnJUt5BTPgV2nQtq+Ac26S/LlvgxUTUpx6+Z78PpysvXIOFaQm
         4r0HxS7ZCgSq/fj0OKiJm19O0JzTHsD2FgzawHYvoQn3t5CsZX9gzg4Fsgu0WM5MEJEv
         NJ2SemRjTD+rnxliUpBCHK3tdT4yzWLLHDV3iACfX4QWCCEpIgD2EVqNBX3bc3iVg0vI
         OukA==
X-Forwarded-Encrypted: i=1; AKwUvByj5bQvsZSsPk97vKU1dC9FUpCoJ0J0AOU+558R9UIikE4/IbWhYCeRnvFFAGEienNySTXAQ/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zCOyM/BAu3G9rOxpISAySGniBH4yjdd/hWK4DHRYkvAqYyH7c
	wozgIQecPzTp9a2YFts+RvoGxFLKv3IZ2LcMj+8L6BGvA4zmzE9sheb0qvzobOa1h1Q=
X-Gm-Gg: AYBFou1eTZ/aeRRsbThboEZBeleA/6rZPJ/1R9Y3ktS1q6QH2+Y05BDkrnKo1OtbpOw
	xrl6h/23RB2w/S7aSOsesLmfA6N8rvbZlYc/TWQYpTAn45mbcBlgsBxpLGbgIsulLr7+Geam8nz
	nlvlLPQ34flhBXx3MQ+50Qa67hUR2aPyMTb+bltvnU389lPmCf/e/cy4cHKFbVR9ZL2uayYMyCU
	ZDwg08MLo7K4mkabJ4+lrJKhJe6+oPZpyL6nTbrb+/AyGkoWr0mG1kqiGGdiGqTxbLn30KVonjI
	TN7oHzx7B34iNlFO21BElUQDGAdLOONbIWI75ycdy1SllEbmkT6cKHnI3tdfH9MbXwpPFrIzbu6
	bVSNMrbdhsAfIeLlIopwamVqb29jQR6vZiotP/YM6i17OdAEpFsx7RtvuNyS689S2JVO7A2P5aL
	OtVegAnVrgeRVQ5GzSfrbAU2vBIdfDEhFNXY/EzmVCwtAwDmQ4sxVEhSqXA4d1jdMLKT/jSJP25
	yrbTCBypcIqenZn2lHup2HEqyHYQ4bm1dBT/5ApVVVkIOU/NXIwT6EdN3Ow55ThHRKegKsVueOw
	g0ZHN/Ny8WqZVe2cY9I6A2ye8C6PzXbUBZPFOe0OirsdgWXAlIZ2bVSD+fJ+a2ZXp4ES2k6wn6O
	nEMEaMpE+3Q==
X-Received: by 2002:a05:620a:4507:b0:939:a003:7127 with SMTP id af79cd13be357-945f35a6235mr574216085a.52.1793997977262;
        Fri, 06 Nov 2026 12:46:17 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6ac8d02sm28364526d6.42.2026.11.06.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:46:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQpE-00000007fOt-0vRe;
	Fri, 06 Nov 2026 16:46:16 -0400
Date: Fri, 6 Nov 2026 16:46:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] iommufd: fix cleanup when adding memfd folio pins
 fails
Message-ID: <20261106204616.GL663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:13PM +0100, David Hildenbrand (Arm) wrote:
> folio_add_pins() can fail after memfd_pin_folios() succeeded pinning a
> folio. Upcoming folio refcount limit checks will make this easier to
> trigger.
> 
> Let's fix three problems in the error handling:
> 
> 1. pfn_reader_release_pins() uses the allocated array size instead of the
>    number of folios returned by memfd_pin_folios(). With large folios,
>    cleanup can unpin uninitialized entries. Remember the number of returned
>    folios and use that during cleanup.
> 
> 2. pin_memfd_pages() returns on failure without releasing the pins acquired
>    by the current call. Release the per-page pins for folios already
>    expanded into the page array, and the single pins for the remaining
>    folios.
> 
> 3. pfn_reader_next() returns on failure before updating batch_end_index,
>    even if the batch already contains successfully expanded folios. Update
>    it before propagating the error so cleanup releases those pins as well.
> 
> Fixes: 92687c793644 ("iommufd: pfn_reader for file mappings")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/iommu/iommufd/pages.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
