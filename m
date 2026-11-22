Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374158;
	b=Wk1tbGD8lRrheVFL0pFNqXvUPId4Qsgv+ZLIGyT5DTRdT8I7ANOnpbbVOmkVF8YbwGJk
	 B2/8owmojZ3hjcYVBPcL59nAtTaV8ze7hJth44vGwXFddmsRcad93nvMg0Tq6veZ/c7pN
	 yExZq55SyUhS7Tdq5AeYtFJuYOQs4wwNkOtu8EmJWOHUFxqxF+3XFpqlp31XKr0p2GqvY
	 ENRNSgyjPyqMgM73306ZPCT2C1Cl9xM+lsAhy1s1t8RRHwWDh/i4Le9QXV2Qk+2s6a2Uj
	 hty9D7LwNtWnCIPFsaIr44gXwodfgTzvvFcJgQtRWZE0eJ6kKFtf6QH7tORtMvzZlLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=Lp0osgtiZVKWMvtaLvxNrKUfcz8WxeL6pbk5OTyZtio=;
	b=W0jELFUL9QPvDUjHFDpL4qv6LZYS1AhU10YYiYJBIpZtTlzldvBquXACcPTrpMx7CFBw
	 QpowrDOlpep4h/n96i6rnEBZq1mJTix/qbsvmqBVUuaSNDhWeMvS6ssynASpMA0ubrHRl
	 VpV1U1/5z0qTLDffioC+jnZ7+aA1ytoewe70dXJMqae72+KETteL1EkeGefjSrP2uBwux
	 /fzKrUSi3YF46Qmgbdl/p8lyCRnaXYd1ZACHaJvxj2nY4aoz9T0f//c4+ZhJS8NumqOkW
	 VHYPd8lfdKsHIFTjd9tdJSNlNMPCoc16+J/90Cx6NKO5B81ka9zYk7rI+YCkzjL7ZWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uQFeWFLZ;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE0606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 19:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FCE0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uQFeWFLZ
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-949b0d32315so236444985a.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795374156; x=1795978956; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lp0osgtiZVKWMvtaLvxNrKUfcz8WxeL6pbk5OTyZtio=;
        b=uQFeWFLZsxcxcM3Y5PRguhI2N3sC44abIIYqvAJ5480AJO17aLrxmv/Mrc1sQy/1Ab
         e/GKhbYXMeYyweITHXj6HCJ5gXaNgtkOfrWlaaL2ktZHbIG6vePBtVvSQorfGijae/dp
         HG4fydroZks/uH9axcRNOtC70y4ETiD0cGLFyv69QD5/lMjRMg2fKsg7QTLJK8jM/qTJ
         xnKeI6VcXjHi+oOkz55ieTVlqga4f6mnk5x7VYtdcWZMCVgnDd3ZsKJTb5g5Hl/CZIzv
         kA+8BnsxL/pxPlzjn+2FoD/PXx7Y5Ub/demE8XrMa8TEZOOXCxxI7CUMEutpIaJPR//1
         M7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374156; x=1795978956;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lp0osgtiZVKWMvtaLvxNrKUfcz8WxeL6pbk5OTyZtio=;
        b=J+nnoqLw887p8vp5xkm9y2bOHoHpLqYUGFut/POjWo8M09SQZLt4SdN3tb373FHOtn
         PBfjjf/Lc/5Sx12iGvhmY3JxD+d/UgKbSYBQRxCgm2IGC/AFq4hxmlwBMtafVdrxvY57
         2MAK9ka3BH+4v8wD3fSpP6OUlbJuVoYmwSUMbevagNWUsk9grjCejTlJk8xQ1LtNAvFU
         os1YkhNEDBEwBwB5m0trlXNZiEGeQ1COayJrek83qbX9XOvRC42yHQ0dhiSU73Yg8/vA
         oKO5pFGP7J/+ZbkTJa8A4Z+LSjfOF5609ked7QaowWuF+cRyf9YXuM/FU/7ExcNzcYNQ
         9ETQ==
X-Forwarded-Encrypted: i=1; AL+hErEhOmCHWaPvAficG8nzkgFBybVgLh0U9Kl54UkEA3N4tnBwB0C53qiYvhWghnZ2dAsvJRR60HQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b6s1tH6iFSxEhZrKYJmAUmJUeafzsabjO0i1vjHpkrmzJsoWd
	ojJeZ52vv3pfrIgPKUGXgJqCMlnLzKXIywfLMEXZ/UKNqdJlHVIJW9DDHOYK9yc++dLAnhGhvR1
	uD1bN
X-Gm-Gg: AZFdTZe5KktjOiHWw4t30Hb0ecXb4RuI45PEaZ8sUg+BJ5AkbCkR5xWGGCtX7OtpCfo
	g+dErp7LzJQkezRBMPvovguUxqJ4XaJKLyYIhzKKM2HpfArL0pYPNWSd04Md4UEOZhaQ2HTIMfg
	0J8eHVFmLqvenIXWgp3ag/eFHphH2yAYxcDzaxUuZ6/K8fS1spsyTX2I6f1eFdqC4PPUEQZdf/t
	B5NM2rU8TyOUjzoIBazuO8KTaTvJB4vJNkn7KfrFUYxUIl8Z/gg0QsS6TM+PdjQR6Dj4H3IwpHV
	fIBnAg49rXz8O/x9/uwv7qqdkTljN/+fG/vwE4LyJLxQdbiyaiyw4+6k96dzayjBTsRVTLdNHZ5
	d/6GqT4eoKpgoZO49VTTadqCEY4ixzBvUCTXYe/t5vUDarlB8WkgDNRtABC/GYkR6mqtZloaeGP
	KnkfjFjacQe8NQe5zWshylw6ZDe37GYO6xax4VCTFYE26fC7TAv6fQpJQ4ins/zrAkmwFjYETXk
	wmjPNaALRUHg3bEmUo87IQMgqNMWv2q0cAXtsnO/pS0cy3Rg66/LDOco9TQtxCqsmnZQT9RdNoY
	kvIB1oOJSvVct4yGQtClKW2HMVpunUI0v8IctHSTdOYs2EoOFS9jaCK90Mapi3m2jSmosGWt/PK
	38He7CASNDUu3+eDz9cLBFzQYk93k
X-Received: by 2002:a05:620a:a403:20b0:949:c967:eb68 with SMTP id af79cd13be357-949c967ee7fmr803688985a.1.1795374156268;
        Sun, 22 Nov 2026 11:02:36 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb4219c4sm651293585a.41.2026.11.22.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:02:35 -0800 (PST)
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
Subject: Re: [PATCH 2/2] mm/migrate: allocate destination folios before
 locking a batch
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
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
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-2-83c56185b0fb@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-2-83c56185b0fb@kernel.org>
Date: Sun, 22 Nov 2026 14:02:34 -0500
Message-Id: <179537415429.412063.2442586940573913371.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 13:42 +0100, David Hildenbrand (Arm) wrote:
> Migration locks folios without holding a reference on their inode.
> migrate_pages_batch() keeps a whole batch locked while allocating the
> destinations of the next folios. If such an allocation ends up in direct
> reclaim with __GFP_FS, reclaim can evict an inode through the dcache
> shrinker, and wait in truncate_inode_pages_final() for a folio that we
> hold locked:
> 
>     migrate_pages_batch()
>       migrate_folio_unmap(A)
>         folio_trylock(A)
>       migrate_folio_unmap(B)
>         get_new_folio()
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
> Consequently, allocations under the folio lock are dangerous if we
> cannot prevent that scenario through an inode reference; and we want to
> avoid grabbing inode references, because we might then drop the last
> one, and would have to evict the inode from migration context, ideally
> without holding any folio locks.
> 
> Allocating in a NOFS scope would be one option, but it would have rather
> bad side effects, such as direct compaction not migrating file folios
> and the OOM killer not being invoked.
> 
> So let's fix it by allocating all destination folios of a batch before
> locking any source folio. Now, we no longer allocate destination folios
> while holding folio locks, which also avoids holding these locks during
> direct reclaim or compaction for these allocations: an improvement on
> its own.
> 
> We keep the destination folio of a folio that we have to retry, instead
> of freeing it and allocating a new one. If we would have to allocate
> while already holding folio locks, which can happen when retrying a
> failed split for longterm pinning, we leave the folio to the synchronous
> fallback in migrate_pages_sync() instead, which migrates folios one by
> one.
> 
> Note that nfs_migrate_folio() still writes back the folio while holding
> its lock in MIGRATE_SYNC mode, which allocates memory. As NFS only
> evicts stale or unlinked inodes on the last reference, this is unlikely
> to deadlock; this must be sorted out in NFS code independently.
> 
> This has medium urgency.
> 
> Fixes: 5dfab109d519 ("migrate_pages: batch _unmap and _move")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

I was able to reproduce the issue and validate that this
change fixes it. I used FUSE to do multiple allocations and
migrations while triggering the shrinkers to reclaim dentries /
cause FUSE to reclaim the inodes.

In the base we end up deadlocked, with patch 1 and 2, the
migrations succeed but the reclaimed folios will just end up
freed at the end of it all anyway.  Some migration work gets
wasted either way, but that's fine.

I agree this is better than the NOFS option. 

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

