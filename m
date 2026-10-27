Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132680;
	b=twQo21Mwv2RuKfAfn+e2MzHt9bmXljEeFUB4rJSuYySjOEDvXGpoFB4PPU6OWuFqSk7o
	 AfxKyIw3HBIE2vNuEM217jdu1SIn8z2BQVARpylgDxeyBNDnAXLwzeY4h+1Aa2usWiDAk
	 GRw4GvJJaGlfPZuEDiqTvWNMsIxu7R68d0Bnor4ybQnSpwQWJIA7jzepHmQrXqEeZXdM/
	 +MSv6lz8bQgLXXEms66ysOxRh5C0lSICK7TetMGswU9IG4WCIDBa05R484cpwuHiPKWRz
	 dFtTL3ALq+ZDogAj7mLPeyXApPsAmK3pD/fSr8r/YmxHGppIfkBV8kryxhx3Y81+WbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132680;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pDrzL4ldTnZQIT/GAoRY8qgOJKT6dHcsc7F2wuy5Kmk=;
	b=ngcdl4bropI+MYgymAUpoCpB0DX7JdwRbze8eYkt3J9MqXDym3rHNA40nRiMEZ3qHbNb
	 /fXdtdznGcmYjqyHojQDrHLW64iikbn/KWHUYOqOra9JisU1W8wlQW3N4Tzs+HnFBjpiB
	 UN2qIS48Hx7wcNF4/u/EUuw/IamZT4F51184ctqklcLZXiX3iUDlSMykpZyfdO3t61JPg
	 dTyGAlgCn+e/Ge1YPUdwJWn8YiYUwgeev7WTpQyruhE+F3SJVNQeTFdSPWrWkQLx8Lyu4
	 nTSRITcsJRUoGWmWYImkN+oUcrf1aPqTmvt+9kXaNdBvDMgA3H7cH3LqLcX1B66yC7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzDseVK9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CF606A330
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzDseVK9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A371F01343
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132678;
	bh=pDrzL4ldTnZQIT/GAoRY8qgOJKT6dHcsc7F2wuy5Kmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FzDseVK9Ysko91Rkuq+QlEaFb2aAO095E8N7yIyvvONeohFAvEsNuXL/t50nDF4QA
	 dB5RS0qSQDyYKaQaQWzOLKiy8bN7OzmckzsSTJ0jnH1Qw/2x2YaVSN6GxSjIbbxDx8
	 6YPifMscpbIXjfoVMUUATqDBadzckblpHh5eoBXFbwrjvTULXKrPFYypotdKpK58DR
	 T3W5/x+BLgYO/uqSgOwbx0psff5ZkS+yXOS1sCDyFfPieQMn9gqqd1jDYw169JcsjM
	 H4Tthi6yhRiV7WxwtKCJQJaKm6v8skUAG5+0ZkEJfKUFputM9fxnc7vdLjTMxWwDOl
	 m4R1HwtIFSlZg==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e635220b4so15668585a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:24:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzElp8nFE8iQHpEmwNhgvFo1SfSfyWyKjMhFCIPZdr/Wr/QHgHzeD7F4yxJ8p3L0mT7mc/3oBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoK+hnvNpJuW2vDoCzCjUDVfoCejqyNXLhGZ/cReFpkT2t10zp
	Jh0zCOXv++Aud4tWtgAEuF36f5cIXKnpHyCgKR+097UJAPrHcs4O0mwzEfteTh4nYn4++why5y2
	JmQ7e/iuSpttRONeXHMySBTAljRVphl4=
X-Received: by 2002:a05:620a:2a03:b0:93f:611d:a18e with SMTP id
 af79cd13be357-94408cfc2b6mr7042985a.55.1793132677465; Tue, 27 Oct 2026
 13:24:37 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 28 Oct 2026 04:24:25 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4ytMqpLJ7wQe_gUz6Fo+BBK6ym-T6kjwgrHi7HNM0LiZQ@mail.gmail.com>
X-Gm-Features: AclHuK-1Qeuu3Mu9aA1DkXbl4G55KJdsUzpEs7vpxIgxIJbJWhUve_AqW65AwOY
Message-ID: <CAGsJ_4ytMqpLJ7wQe_gUz6Fo+BBK6ym-T6kjwgrHi7HNM0LiZQ@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:18=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
>
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
>
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the P=
UD
> handling is required as well to handle folded page tables correctly in al=
l
> cases.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
