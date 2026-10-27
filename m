Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072434;
	b=S5Etaa0jtkcuRJSzQ3SIHDTyHLnQvmgfu/7eYH3AIsgFIC0EcI3pDPnnSnalpUOTuCcZ
	 cj6yu5HiGhfwITL7aBTd7jacA4sfPFAELSnN8bfDtOQ042G8d0QVTIP/RWirWTduryFzC
	 bGJyzpiB5tzPI3Biw0cbG7VPPl/cBVcsxFmBj3o7dDEKgTJKYNGb6mfYBaZiWkZAR8PU/
	 tLPMbIb+lTZz1Brkd2GwvZYWOgw8QNx5QVrRC0Db9mcqFzrulUB3miJkmWWeYGjtgwhHe
	 N5DU6MNjfZO1Rmt/i5DkIbyQ3cmWTsHnw9AhvcoLbwIzGzHWpQYnF3SGC9aPrOtWCZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
	b=zuC4PGnP3olAP9J60EYu2bQXAU5RdYMP2B59mlst+vjYxud/DHAEy7n3a9hGLO6zm2jg
	 VekcblZITZRXHwIdNUPdfTR0/c7DAqxqvmeb1r+YY9vxtloo+LlAT++1OenK0xLiA+5ne
	 4OLITJgnG+zpbkQr/qSJZZ4RuG3T4AACQIl0zqUp1XNAcu0ycwShfs8cqd9c1aOWFc95p
	 gsGwEXLlGMROkUaDvb7ujaGpJ16DUBnlYdFwmZ4WgvDVVUNGc6dNyIM20nKGDsGK4HGiB
	 cWFyavK/XAZAeF0wA+8KaYgFE4ttTHQ5UHWmovsOdkFwAnuAUc+3HwclLN4lk1Uik9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89015606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89015606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c315869241fso478335066b.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072432; x=1793677232; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=klpxKBx6XIdguBPv1gdEeaxX3Q5nBOE0QyQKgI+nQtmFi2e6yyGoD1z99atiOq/X0L
         29MGF1ep4EQ1gv/+055Qkplcqf1YtKuIcCv5aGSKHjEYK3jS7yM9nfCIB9wNkxkiBkUw
         3XYbbVntwybyBZUIqAVzhr/u8Gfrjw4XN/c1wAbiBcjL3VyyvbdMABrMl8JljkCI4HBP
         HDeVnIkL+LtyK7DjLzJaTMJ1PXNZWLEFJCqh4gUIf6KP43zgwJECwGuEgMjpM78oIwbB
         yrbDn8qUsI/PxLnPvbStsGGa4HcTlJR/M8tesdaSKCW5YkmlnkFTtYdIc+MJU/KUH2YX
         ocTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072432; x=1793677232;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=2rptJgtnxTS3Z3yorQgRcExws8gfm9NuAVQeZa2EesZA4CpQASlzd22OmFbxzIkDjo
         R3EM6cvB5zfp3OXBPO7jqnjotnU7Plo4md07trOjUPZrDVsLmMRfNsm4Ii1AVm+UwNG6
         SD7Q6AyuGFj0qsQrgQSUeNfYuz/F6C7nPhoBv37ORD8iKFVv95QScJ98lKly7hTDdhs6
         dWsHmJba6+EDfPhd5BrKPxu1ObYag2dzdy/zuKXXwuN9kLEDdbcF5CSomo1JrzP3jxyL
         /INDrfdtFhbqtVUPDJ4gaczatIC/VaHXBjTiqRhGOeg6UKnjYJlg+gvriPkcSfaK+Q8m
         pQTQ==
X-Forwarded-Encrypted: i=1; AKwUvByLiDXjhTfp6BjwLu7sEw48VLBlFjhP8IsSDfN0Nx+XxA0EzwKO+1xLc3yrVItE2gBeXel8WAA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6F+QYd0aIkUJQIziGDhDdyoUVVU55SFdxdVLFZZDPs6XGYvRv
	DoKqSpanLaVilBgm9SugBfP19aLvhxih1xbxBar0s4fhLjGuMGG5wOmz/sVmAwnYxco=
X-Gm-Gg: AYBFou26gviA/ncE2zXHBTnBR+3OcE+G1bWjVMDj8GxFyILdW3xBFL1s8ySfdhGw5iz
	LJYSe4ufGpS+1UflpP/7zSHOydnNOVczdyEmKNhPFvbsP9JCntIlmTIKf7gZwoq2FTVSUE2+lo8
	uflLph15vaPSN4CQar9RSKVNPp/8DXY/0RZQoJldPpaT6oKWFwST9F3k7khd4HfRP0Ej249PCNS
	u/2aydcoZm5u6+Nib40+6Dcd34J98cWTgA8b0NZssal65SgZKUNcNNqEOacbGu6TUGHT3xnFHb6
	djkaEQSydkJMFjxD+Mzs0+mSHpeayfw6KdgHoqKUCadNvBtgNMnvZoBeu+u3VtZD6xusgcgrqee
	Fw6wm+0VWEQhwJmIRJ49VYttnOFD7eMnAY5Gymm7LfySn0Gjg6KOVD/OBZ3uuYokeZ6VqqDcHzX
	v8O3pCIZ+XfFzLMdr9HE4GY+WQIvYGhe+jXy80hRVBXa455yrF4OGEjUN7/pb4W/MmCNd0kSD87
	ctyR0aGyeIMdJm5kllSubGxgnJdsLAcoql+CV5iky6/GA==
X-Received: by 2002:a17:907:971e:b0:c46:723d:600 with SMTP id a640c23a62f3a-c46bde9f783mr916491966b.41.1793072431944;
        Mon, 26 Oct 2026 20:40:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e784esm379153566b.19.2026.10.26.20.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:40:29 -0700 (PDT)
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
Subject: Re: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
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
In-Reply-To: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:40:28 -0700
Message-Id: <179307242835.1171062.11616590599815003560.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> __tlb_adjust_range() takes the size of the range which has to be flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> gets truncated, possibly to 0.
> 
> On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
> 
> Fix it by flushing the proper range instead of the truncated one.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
