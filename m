Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130213;
	b=IZhWEz/LAdO67FnibGoKMS0m5T2qQ4WJ8UEbU7Q4IcwDEtGvSl7Tb92LK1T4hFSxGcuC
	 xYZado+Vm0oXZx2NZ4gkv9uxhRWp2dyS8YgB/TvY1eGhyMaDN5IsZ9o46tYDlPyJAs4sv
	 4cgEexkbniM+5ZoQcw3z+aa7istIMcAteEA0i6JAP6Dha6PnJxg4w2rF/w8Qxm3ZGXMlw
	 gjCHMcMhIVmtVrprVKiXZR59KUY+Um8febBOn3wd+dgu36t1cL6gCHvpRrSZWcnt3wra8
	 2/iucLpqpmB+yl48ws0ApedV21qLsREltDfNcRhPKXiag+DfBB3eZFyX6WoFsk04ZZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
	b=SeHcc4t9TLUeS+p6fjQqcCy57DscsO9lg6HrDmUcDzs5Htwg0ixmm7uwFq33HNSt+E/F
	 3BP+saKp2StmZrm4Jl9M9QjUDY4jB/xcnY4Sb3vLzMGSCSDAuPrQwlDFG1AuiBgIhDr+F
	 xsp56zA0DRseKqn2rwDAcM4oDAsITNzDvBwgj1cd+9stkCZ4IIfa3969Mmtk1SqyosVy9
	 CpXp5VEaJKjNl6KxVn5fZSwYTEGVYzbkkT2tg2dEVA0d2YLfjtkpTCkZRwkD3HdEkIEgQ
	 zAI1RDDmoBDsbaass9ASWo3D6oKc+kepzxOCMIXwhZKGBx4sM9R/2YozzE7LzKefD0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fKvu3sFl;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB0606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FB0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fKvu3sFl
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so445ad.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793130212; x=1793735012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=fKvu3sFl+ouMpBGe8QCxA/Po0tluUmY2cadQ5kspAESt99gU0otrCAvnCSeV7d6AMG
         nOJN76SW+5T4b89TdCObf7StqhqC5yuKT0Xa/e/MapWdVtpzLtKN2Qlut3EgtOYh/7BP
         MPFGdTIbjbI3NMLynzjswqcJUo6qUs4Fbp/l6sbS7XErYabWce0lM97r2Muq1h+B+NOY
         yACxHY1q+u2K8gXE1fj0nLilv5P5r0KMvBJx1xD0NR2cp9VharpDnFu2LcIgoIKT6gV2
         PJlApj1CY8zjAhY9JN3oV8+YwlHOQb/i9h/w7so1nt9/GQ6yRkZ8QtO/Y3IZocJ0d2Lu
         EPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130212; x=1793735012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=stA1c8PKZaPhWLB76c9fLCofC1Z4hf9KLZetye8ndASuDzzPVNVRQ8Z+FsjWoamQ/x
         5nk3efy9Rgl+SLtHqO9I6MMK+NmFdM1BzRZabxiHrcv4d4Gf4RN9hqUsFmS31Av+C0xU
         WJPfwKUjKgusyh703OQoIlmgcCriUg0u7P3ZaAiquouHKZkUpQQEzfR7KAINUjQl8lxy
         5uhPMgdyXZXS2XRpJd3VBQIxdg7QycFcu3S/8MQyctM8h7gmSdiitenlILjGRo9rNByz
         4zUXs0f2nf2PJXhRbKU3snYKJGWiov0z1uEuCwRe8tRdvaHrMhv0H7EWe03NrSV/HAZA
         YEPA==
X-Forwarded-Encrypted: i=1; AKwUvByQSZMd/tdRM9XkyCUOiiQ+LvdbdItC09dOwATcziFd/SXc8eyXfrP5LPEZqfUK4qCSHCHSLxY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDNAwhl1yx/cgAuS4jQrxui7DnRMiuyxBVv572awpppwRePGl/
	ui5Rh/B/Nu/7hBbthq3fDX/UfJSatyNhp7Hfh82/7lP9OLkWuyTBoyHIXj5bEY09WQ==
X-Gm-Gg: AYBFou3GS+l52h69OM6qlpt8yP8/lBnhwwVLZ4oAyF0auMhz3blq/Y9BAB8p45UAttL
	VZ3yZPyd5mypd65U4eOU3/ZtyzgQge/0nCnKFXIk3d4wt5IRY9ZVJNPwWzc+dsBlEZuK9NPsKyE
	y2W0VTA2OjM2qxIXesCt6+5xZ1thaoshs1GJcjYMBVNMdzGsyxAI7fbn1r3KBm9KJfL+3Rf8V4P
	qixgfRyATUgzsxGgK8E8/dOhCQr3Rom9sihL9fLHfUPdSSFTqOBYd6EQsDiHMz0Q1qC74tRh3uh
	mbp53/HYVGB0ja8+VhSIDgp2XuF70kczLrAGqIOlYq3y/wDJQSpsISZxffdIR/fr44IfEYG1mAx
	3w5QXNUBPRh68N+qlVL2OgkOaOFEnK3A7Pmr5N4ZoXLl6iKx52ILl0osPIB7/fCgTN4MuGODrnr
	LrTY9ekE0I2831P5V+Pml/dv80qESPkImvbMyxEeo+1PCu3SM89Ggdr3hJkhNT2n8HiCNHwxLmp
	8RA6ZUhnr/ywtXjaZxyZXPUHUmm3EiDWP5O4IJ5ge3ERkjbfv9QnrjwnlFOQJhb18d6+6Z1IPGg
	lYjFER+TmQ68eH3OiwZi3AXEkOgzJ9wzwPYQMlpHDQ/80of2
X-Received: by 2002:a17:902:d550:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb01986bddmr124955ad.13.1793130211108;
        Tue, 27 Oct 2026 12:43:31 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578f19b3sm251941a91.17.2026.10.27.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:43:30 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:43:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
Message-ID: <auD-r_lTZ71vbSKu@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:40AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>memfd_pin_folios() pins folios obtained directly from the page cache
>without checking whether they are uptodate. However, shmem fallocate()
>can leave newly allocated folios uncleared and not uptodate. Callers
>such as udmabuf can then expose uninitialized memory to userspace.
>
>Clear non-uptodate folios and mark them uptodate under the folio lock
>before returning them to the caller.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comment ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/gup.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
