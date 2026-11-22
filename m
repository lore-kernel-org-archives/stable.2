Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367819;
	b=Fz7oNMoR8OfcGEzVT5hEzS9wexPErh1POIsNd4p9rBM/51EQgrQJAGRxtuCsreZDBx9t
	 NbICevgyRq/Sz1Pa3mtN5gs6XydR4tScr9nh94Th/cZlMzjXvM8fCfpxqFnEdlA7TNhH/
	 cl5QS0lGRFFOactxyLPJCt7APLaX2TjhnWZqWdlVMWG292C4aiLchx03C8EnAkA270CTG
	 TWC8McsPclX6K45TZzi2Cb2dlk1KjW4YDXg5bQ4YaxiSvGpNb0Ql0pm4wkgMOyZWXjaK3
	 i0/O0DIZP17RZk7zPoQ2TfvL+Ge+muLqx8PL64sdkrmseTSqT+iH/fPhwFOckKstHmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=uZBVsygS6D/XCIyZiy9rHnS3W7U40v2cBdi6mraqHsc=;
	b=ECtoiXWoqy/f1g/98umu5LB/c73my9VrIBmLSYOugGFmLK657TSPV69O7K6lC4fpl4CA
	 eeZfGfUBFpoHouxnfDjG+jv4McdO81MYGdoE7WnLfGETr0SyPJOI3ulrIBmK7w3uCPnnR
	 6Z4fvU9ztuc99cBv493hZa6ejqCBgkEY4o5sUsjqYj8ULXvWN5mDLKWy4ECJzoeny8J5K
	 JXndtbIUlV0TcK5pQYoVoPD4gU74T5t38cfi3lYMKuerPWAdaANJeAXlEIDqOiwIFaW+4
	 +HgGBsVHZziB/pY1DCrjSPLFyDfOcxVbpshMQ+GoZJt8xIHQ9KMs6ZggMugqPA0aNIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCUWiBBI;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08766606A33A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 17:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08766606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCUWiBBI
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so13445215e9.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795367817; x=1795972617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZBVsygS6D/XCIyZiy9rHnS3W7U40v2cBdi6mraqHsc=;
        b=mCUWiBBIqRJAdhZb2luukoWxDreQFeot995UR88igZcIS0eYZwCiUfOG4BIu8WBURh
         Jz7I+C5KnQAK8p48KYG+i5xHtq/Erwa6N+A8cM72sf4Y9nFejquJg2I/1ckw76GjPW+y
         iS/Dlq+IYSeHrvebzDZxCmewV4Xxm8capneCg1wVXsyZnJBOOfaJmugwbDe790KhzYmF
         Btx/MyCTV7/38TA9OsUKVJvr51Z2jiG+X6f+spWGWrGenhnQt/8ErarOv3o4P29JS3B3
         e1I/8S41h1Ej++B26a8Ofo9iLAZaeRNlKnT0Y1Dlbu+vBR2j9f1lvzryGl/0OUBJZ0Gc
         BuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795367817; x=1795972617;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZBVsygS6D/XCIyZiy9rHnS3W7U40v2cBdi6mraqHsc=;
        b=iJXKnzYBqK99HMX8ScLEW0fKMLq/76rAA9LKCT/XEtTjgVNNzSz5lNkPXBCNsWFz3K
         6Lg9ixQwp7Mji2EsRMLLTAl12FSAu46tY71n+hbOS0Doflano6A4Twrn/QWMNqnfjEZG
         /5ZXIOKwzXO2WfNlxwNTDdvjHB8W9z7V/iNND8jefr0+/W8Hx0RKqENhOhovcyAN78tq
         OG1OW3xxbn5Dxq4dmgpDQuZSDVyu0Hjo0+ag/oMtYmxulR8R/j6Xej1f0ug6Tugw4vq4
         f5fVcK71gZPtnZ5lzKuCt6XwmwRXJ6SvAglhjVgSW/b/G/QSQQCm9t1Jpr0xOslrLhl4
         wa8w==
X-Forwarded-Encrypted: i=1; AL+hErErxvFvAETqEIOxJVTOSvez8zM1G/h3+YHKajcP8Y2wulLG9XKQDgcbL2xwwCix94a0YmF7Fj4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g+AMeBOu2//ObGPUsgR7qAynBazi7F97sQCphjo5+v2QAdHev
	i9/tfrN/e5HxdiOXxdDbVuqS8bfk1VIkStzcM2l3vv9m1RpCO7EkwXUE
X-Gm-Gg: AZFdTZcaKlFpoM8JKDFLyIMl4Yn3Bnfyva7CLrNBaQBPXc/1yteqD1igFdLndXat7xW
	1Td32WcVlbhkY7LwrPFHJGL0onffyKC9NsX3JtxR3hjagWjQ2jN1dd7SfE28VSkrE6pXcHHc4mD
	5US3Dvd88THIYInZSxDbie9EdT+KoPK7NaKH+o3cowfWvphx+TY0GzEV56FFRhJJ7O/L2OXFYXi
	B9Jw7t4TE6z0ZIK4TU2Bk/cxmlJU+Xkhc2bRViZt+kaQR4T2Nk4EMoiQEht+EKuACBaXtNZytz4
	u8FLRFSlRthUCzrybZqShV+oCoNA+iwgzsqij9VXvom6hfaEey4uRYOaIe2AnIPbN9POjXqEUD0
	mR9jzpuq2YlnZvhuY/r5wSBvAqBwb/qwPxRSg++uxmcyRjMNRIaEn3T/0qPhXDX2oAck80HYIcV
	NK/f6RYD+MzRANkQWphMDaLeBmzcsQu6Kr2ZEjHPg+YUqr/n/RYB636COTIzyULVyGO14mWChRg
	AgS0eDpK0o7HTECuOZT2f4K9yfzrVbSSX9hd3T0FqpZNgaJlOChdIwAumKAWngFyQXivS/CPtKx
	7HVOz1vRsHZ+3M7egps9YFju
X-Received: by 2002:a05:600c:674b:b0:4bb:6947:3e1d with SMTP id 5b1f17b1804b1-4bb8892c0fcmr182147755e9.20.1795367817148;
        Sun, 22 Nov 2026 09:16:57 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm18145971f8f.16.2026.11.22.09.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 09:16:56 -0800 (PST)
Message-ID: <2da64337-5135-46ec-b7ef-0e1654f76238@gmail.com>
Date: Sun, 22 Nov 2026 18:16:54 +0100
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
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/26 1:42 PM, David Hildenbrand (Arm) wrote:
> Various callers (migration, memory-failure, s390_wiggle_split_folio) split
> locked folios without holding a reference on the folio's inode.
> 
> Splitting a file folio might allocate memory for the xarray and call
> filemap_release_folio(). If either ends up in direct reclaim with
> __GFP_FS, reclaim can evict the inode through the dcache shrinker, and
> wait in truncate_inode_pages_final() for the folio that we hold locked:
> 
>     try_split_folio()
>       folio_lock(A)
>       split_folio_to_list(A)
>         xas_split_alloc()
>           try_to_free_pages()
>             super_cache_scan()
>               prune_dcache_sb()
>                 iput_final()
>                   evict()
>                     truncate_inode_pages_final()
>                       folio_lock(A)
> 
> This requires that nothing else holds a reference on the inode, and can
> be triggered most easily with FUSE, which evicts inodes on the last
> reference.
> 
> Further, xas_split_alloc() charges the XArray nodes to the memcg, and on
> cgroup v1, memcg reclaim waits for file folios under writeback if
> __GFP_FS is set. That can deadlock if writeback waits for a folio lock
> that we hold, for example with ext4.
> 
> Let's fix it by splitting folios in a NOFS scope, so callers don't have
> to care. A NOFS scope also covers allocations that filesystems make with
> their own gfp flags, for example in filemap_release_folio().
> 
> On NFS, splitting folios with pending writes or ongoing writes to
> fscache might now fail slightly more often, until these writes have
> completed. On netfs, only folios that are being written to fscache are
> affected. All fairly irrelevant.
> 
> This has medium urgency.
> 
> Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> Fixes: eef88fe45ac9 ("s390/uv: Split large folios in gmap_make_secure()")
> Fixes: 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
