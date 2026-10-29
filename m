Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236833;
	b=G2aqf6VwaO6IqDmQT9F2YBCdxkXuiY4C8MMnWpuLgyBqVp3SpltEH/YoCQPWX+HZDEsy
	 h9Ksphk4iysdSnSjIvn94pfQqCx/eNRoe+gLWNJ6JkOZ7eMsHVAK5bMMz1JtpoZo/Dm1w
	 700IDpqpHcWHLOpe/oO3pIXGj+rU479Ja8GcY8djCX5jBijDopyqYRmn5OObmmhv3FXMq
	 dJluClbsuKeBiCQckQI5s2XDZ7YBaJdBFPo7uNUtyB1XbMwaNGtQkIDcdPLc8lN++7PL/
	 mNWpnYb0Av2ZF8xt0YcBrOx7jXpt3eSDgWOIN8esSx8u7tNmKCbB8M+ZBYWJQCaEbbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
	b=tUC1/JHdw7QTMv8HFAYcqZRKsR6kBI58KU36PkyTDGEv03+eyaBEOZu35zbXBLCnWo+c
	 hx4nFg9Cc2xANRejP1xHBXH1CDgrdGtpob8TKlIcEjIJXYvTYkbElCAkZTMKGfTg+IqWq
	 R1kxITKkoTHzwxddCaWmBV5Gyps0dFcabCxdkB6Davv/TsEqIqSXeZasi+vOjIseaeVXQ
	 F7zGvSYF/S4M70w2RoTzJ0MHIfFrRpekHQiYJ7KuhcnPHlO07AwDWqag1wKwCVdSgD9Is
	 toV5/lAHfs8Za0FU8/jpkTmTgTu0Gywd+vVD19GiYJb6DX7f9CpgWJpU9dzl8izgUQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="X0XY/GAi";
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B07606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16B07606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=X0XY/GAi
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso374348a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793236830; x=1793841630; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=X0XY/GAiMek/vFbkNlCS++xCJPhcJpRxEM4fx1Ljjv6aCGTfMX2iHg06Cuvz3jbJ3x
         Q0dDwGr1BIBMf5kqCtqsb5bfcPFaFZlUqEnSi6skik2W1J4zJ5GeZ5elYQvrlDRe91e/
         CP3Ywj3kmY6/6N/XufcgSAxLlc+irLxiHwNEWl3k5M1t7aKrd+VArviVR+LRPwX+IZPm
         GpA3SbXg+reoCoke8l+SC4GaT3nXvce2SqP/adtt8ITzlbRj4F9bRx8OgSUJIJiobyeZ
         u80Of7gLVfSgCHHisozRXuwKcVBjIh2eid1AKfwHBlqSo1BxKhOy27h+nd0r4z6VpL4i
         tJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236830; x=1793841630;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=qe3+tsV0iM2/EmHRlVAKe896fY8nPdS6+3MQUkRdjsbo3aTxcUbTy54GazWmzpy2Oc
         nui/+I7WQhgjs1FihrUlNXMIXkp3TjPg8EQimOpRy8s5U48ShVh7hMpt4N3H+/tkI1m8
         2hwcMNIFdZIX19Yp7sFw+pCQS9FKdqK45nT8Mfw7u6xyCvUxHR8vXqImVlzrWemGGsQ/
         GqMdU19joo5OwYHVfbZPHGwnRXjtiai4bfDt2dQygwcLp5MFtLyjY7bs8aB9Fx44MOAK
         B9jSWRNVYC9yvV0W5b+qwavs0ywCM4sMzWB8DCsNK3aesqzLepxHxadH51YUKuE16qdO
         2iCw==
X-Forwarded-Encrypted: i=1; AKwUvByg9ljKFlwJUY/QG/DlRRJqlcF5BEeWzVgXBrQCuhPqFquAS9BtlhczTLs0pruV3lvJhd9gnLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHjjqq/2sUPg3Oakwa7Tfb07pKItwamVXS9Iv8RccDEE1CkmHe
	yPAF0HV5gUOdHU3eVdxcTwLk7QClr36d1fr246GR3k0oqnA6H6MsZ4HpzELqktrrvBs=
X-Gm-Gg: AYBFou0q7Rq3QdHzADInEDntTSvZGxeejJpELUnToEpeplB1RcMwn4QlfX0R3DvCcgO
	n9jonpblNYgMaP6D/FTnpGxOFHhYmopN46PZPl+DsPRxndqFtK6mONnKvdKCbew9PkKwKNFq1KX
	HbKQP5Z35+FnEMtjuL9RG110NipDtqwbO1W8GfQJlzxw4r0rrORwZpgNRzbH0pNGqcpzcQmjW6r
	Jp8J0beN2TTMeXE+/+K4h6YmkGoIBGOd9kqVql8pWLd9wmZ3P+4ZThaiJrTVKEIi96nFs1wmUx3
	Qf7SNWG2kmaTH9REHx34ljfPUzIHonbNgNQSDmkjD3uARj9Uh/PkXgui87ORbFAuZfA3f5MXmVA
	FvamjHHrqLvPFtK+AtxpKjNrmffzwU9UNshM9t6MyXxfp/A8HBE0TzLPlJ0u9XYXMIylWhhA8eH
	mPNtjYS2jHEd3H2adMBkoj5ccLyme/EIfWY57HlIZYTXniuWNdKS8PuiqX4ce+58KtRkiw25Ejv
	ZNGnCd5in0Wj11eWhP50Aq7nTeB90oNvBSejKwK98lszExWPxwWUUGhQ692p7TH0Jt6gBBLHGM6
	OEZfvSq0JJU56j9jkXT6
X-Received: by 2002:a05:6402:c507:10b0:6b4:8d8e:c5c9 with SMTP id 4fb4d7f45d1cf-6b4b0b82678mr569270a12.4.1793236830233;
        Wed, 28 Oct 2026 18:20:30 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649f69sm671275666b.43.2026.10.28.18.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:20:29 -0700 (PDT)
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
Subject: Re: [PATCH 15/46] mm/khugepaged: always recheck the pmd in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
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
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:20:27 -0700
Message-Id: <179323682749.453251.17316394789253085295.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
> page table, and takes the PMD lock and the PTE lock to remove it.
> 
> In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
> page table. The pmd_same() check is supposed to handle this, but it is
> only done with CONFIG_SPLIT_PTE_PTLOCKS.
> 
> Fix it by performing the check unconditionally.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: adjust description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
