Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793096590;
	b=cNnnox9vBWVjHIgkA/niGliIgA9gvqjLHj8ZuLgzQ0fygNmDKpBjkr6N/bSIKLHnMTAQ
	 Ra8PunoqXqEcpJo6PO3nscwE1xMBGxthX/1fiiEFqcUEilJsThsIGhLCFRrTuxFl00vGS
	 j+br1EfX8LHajaoXF4RDQkJcosTXcw1XjutTM/QUSShxSRHb3XZR6lJ24NPM5s18HNyVW
	 yb34l1xAFU4P6164aztJQjIklHSxnAFP1va7AYh39QMatqYjWXoe2c8PQuABCFv5XsGG3
	 qL6drWJJPfQLLpHbZnMoj2pELGrgJV3DnzpFpvFXJFhrFq7eBR4Fn+oBFDAT169o7+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
	b=ilseSrMEA1Dw6jEOeZjSRp1aDfg+QT2/yltzXXwsawh1kH1q62o79mTvxJIIQk6aHe8r
	 n/Gk4dfX3yJQTPsIhnC7mc7femMSQ3wmb03Tgp29hHvQVR7AdFrZZk4g7se5QsZ5j/5ZI
	 TtwmFm332RX3tqVjcx28enAjv2dytu1o4ZzW+7G9SmLjCxyjED6L3wJMfOsnXRcUQeost
	 79ir0Zg6JR1I4G5K45csZhuZcnEkjEO9RvFk+nUe4tVaR14silC0KPGc6q8c0FQwDEk6m
	 oSmQO5cCOSfRYjVTq9Fx1+j5vhKlRU+2ZszrUd39SjA/kxquwHRdVKhqBpTDfTL02rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EF606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4EF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4322d310e7so585452966b.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793096588; cv=none;
        d=google.com; s=arc-20260327;
        b=FDLHte2/R5hooxLW6nAWRl0pBMp/ZwwboJYP/vOHxj+16SRdf9DNDEkFO5CRNBE9Dq
         3DZGFf7ZRByIjIAioXXip3XDyflNwu0aPYfv/6DwXwspvVwCv2jvWfX3VOWlI3IYdRmO
         NwssKuElPEtL44LMkEzl2lZ2Iq+R5V50zze78R5AkoWyJX6lWtd/NJtrksAxwVLrEA13
         f64yNV4eYvTMvE+Q1YTdEf6IbyzpTDr40ccTk45fRSFZZpK+qMy136iRV2HUNzdmQmZi
         SlXyYXtXGQ638oJBzTekwWYYJmBwLcVN7wLStrzg+4yIB5Jb5wf2lSNemJTSNxFFfW+H
         65Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        fh=iELzzrf8+pBPjXKrnt65ZpFLWfrU8Yh+B/TRfp1EvKE=;
        b=pysCi+hQJH2FKiwC4FvXigv2Vw5o87MWLrl/KaMarPooWGNdOZP/JWw/6FcumnoNyF
         9RNA3UQbesArgBlGan6HcnWv3oOEeZoLJM3YAsEUB3svCykVTkYEbRkHoSVZOzq8vy2o
         oaurTBILmlNUyFaj/ZNEedCNZsdQOTpgTi+oOSVWK6M1ZFtvSfU7HGy476y4V5HCpv4y
         HlPPAjAdadiad39mP23tAOYWS15A2I/2RnRr/CGjTtN5UizEx+fc6lnuM0/cNw/HR7Sw
         RYYBgGV+RaCZd2yaaLiwxdbmosx2aHhL/tTsTSmrdpiccXbLS2xPDr/sCEVxhCMOQu7Q
         tJhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793096588; x=1793701388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=rlxPCoS9TacJB5sbR4/DuCvg1gHofa48v4RHRIbBlyZQUhw6r7bL6zg7MUtgoZBxKQ
         lt+YYPbrvQtc79S9rfvuPcGOb7C0BZY3qgF3U0I/tVnJgBGJx6xt/DMQpY30uai4QsoX
         P5Z/pcj6R7IGmpyEZjIkQ8RE3etZC17RDFgvcM6Y+9bhDyYYZoMMp/cQ3dx0FSoFEG3E
         yCnpC60BmhPOCYYuljKb2FIw3gC9JotwIBxNU1pFqurxlv0c49doWeUpfGKBEj/1fv6d
         Iu3zIa2GIe2Vu2FDkwEINlHF1PCgOTqXmfejtN27WWbwQvMYwFzZDiaJKRXsAeQtFbxn
         7XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096588; x=1793701388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=apZ++5zznOh9XjF2uV5qQpMMCvfQOw/LfcmUdEDCRiiHDiWtO0CUh6eL2oc2QmIdFy
         TcjlW7s1Ddor2SoPMgbn8Z3CtgQ0sT9nsthWtXK9HnyXO3Wmj4crwUhVp736uQnNmba9
         yydXLKQFBq2jWPQXjt27DKfpO6JfzNyD3qYd5S7fFm9v7MjWDnDVUmbGpZ1aEbmfvLSj
         ci6YJMcnBUG9h/hxuDqme0VWKbnoa6tDeloZoOFy5IvHD7pfRMjeKz+lD0cDvf2dUlJV
         K9Yy8bdiokWDrRaKN4mLty0EogimVQqgGJ+pQ4Ub2pydJwuMSwFv2JrS/GVhzaEM0KnO
         H0LA==
X-Forwarded-Encrypted: i=1; AKwUvBwkKoVzkFmWoMY9p6Nq7U+blvfvG2KhJPB06bULqGxS8aYW4FN8nAgLk0NCKdoSsk4C0KQ9Vzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhvf99eW/Bn6vaWAhpm5i6p7qGYwncXm7/h/Z17QmkbpecNA+B
	g7wJhuLhGtCPHsv/NR1xNbsGyh0Kv8e1rT2LQzec5e78POkTSlDS4TrkLIDMsrDmhUfx4C6vyjl
	s7ZEKHnhQmsmNEEfl6LLu1CptY6whFr4=
X-Gm-Gg: AYBFou1JZerjR6T790rVJAZwHQyuEQuVgLiLJSfXcCKPYiS9YS0mOD7SPYKgVCIa98u
	MS3yaJyToiCpAjC8NFT1ih63zQGGzjzQ4F5SQm203UlZTdCHzSnSzkF+cfRjk0rtYaNczsxZQCI
	/ApTVA+/ZkqplWgdTM+M3Z3iqYX42GxfB1zyC5GYEM4priCeC4hUWdc7Of6qKxpCFZaMnivT8y1
	UZVsZMyP6swtpeIAKwRntommLQ41TxhD5imKRGN2FBPGzocVJ/n8CZeu+7ygFr3fmNFdK5PdLdX
	b7DzLI3HbY5V6e0KFk+KFRlV76Yrklkzx7K9Ab5CAUYHrk+IieBaYDubdmTEw10SMIgCaKYNK1k
	x/KuSI3Zw3EterNWwpTlheKCQ4xyzbMbKKcUoeaRcMIZGb/7m54EYx4Si1GqWur2wFC6rrg==
X-Received: by 2002:a17:907:86a3:b0:c31:5bb8:4b3b with SMTP id
 a640c23a62f3a-c46bdaf85e3mr1028439166b.2.1793096587718; Tue, 27 Oct 2026
 03:23:07 -0700 (PDT)
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
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 27 Oct 2026 18:22:29 +0800
X-Gm-Features: AclHuK-sc-Sst_xgCP0rWexz2ICrmdMlmxE50eDjh8zWXXtcyxqz8s5Avp5yS-o
Message-ID: <CAMgjq7CgeA5OYUuXAQF-PQ_LkmsLw2V3VzRwPUdMYTcGCmYCbA@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
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
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Kairui Song <kasong@tencent.com>
