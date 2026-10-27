Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072574;
	b=33VSrsQhCmivDbBAWRdMD1F2XTxHDvZdb9OJ9H0n5hrTikkxoY5TPsZPOfmcaMrJmH4Z
	 riCBgs6kxB/x+SGeaqjtvH0lBTVv8d7zVKBMAlhgyrluPXyyOlVh+zpk48gEbrWCZ/c5h
	 ifapo2PVx43MLsmg7ZwlEzITARPAZMgarmNj3L2cNeA1tx9bTcVKQ8DuThgVtHfZMKYW3
	 LYJDG6fLnQBSwyHEqJBbj1cWLBTrP8KkEIki4Z56zU78Xkv2jtuFsQv7ojuZOqxJ0PepW
	 CPdBsvILq1I7bhHEkAROoLL45IU+JspN7lFvgqi215HDitcPg40LY3cnTwMtgroSdtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
	b=y5Wq145mAOcPGU8Z7/Alol7wg4T2OWda2IBJTLp15UiOZZAIxp9fBmCJXnV3aLKoLZF4
	 kA4snnJ0OBdiSPae+Vllk/slzvQh8BQL5zBwuwcXNt4mCmEsvdowKBZeLbnIRZ4IiqzkB
	 SX6mgHHBoXEdIYpDO94PuqDCvDHu8dw8zprN776z60xCGgQB8i4AlpiNicjnY82Qc1WqS
	 81OvnumJ7XbNtmPNxsN/SfTu7yc4YXjtkIoiW2i7iBXmGI8oRBDlRIVxzjr3gT0e6Z8iP
	 5sSBw0JyUOqUiscTeKGPUFV2CqUJnGK6NcXzm/XKMAeWqIfAzjNZ88bx+UQz7f4I73A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9995606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9995606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4682977f9aso427191066b.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072572; x=1793677372; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=TP6Wb0G9zLDqWuDXb4AhwPpwuHlSKdtp7vOXpYDf7eGm1a80xAQ1Kk7a3BAwdBSgbf
         7jIsPCCAndPaIyaXMt1h9L+v3YN04he2Yn/CRRvHVdHgoUlgLlSgwa9hE7a1amSX74cH
         Kwjdvwabbe16pgNJqcLstwt0irlt7+SuIDQSlFjPA8tQknv+O8lFGJzh6gB7RDu1kMgs
         b7Ioo0qZ28U44QqcJ5fTkQnZXkb4QTONZ/A3yzR+1a7MYD/SYCY6zoTd6EcwzJuhItLH
         0B0L6IlHYe4/Vnwr07ZM2/roJJBr1DR/QdSECM7/FpaBVLw/yoke4fT7pykNvEVAzfsJ
         pBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072572; x=1793677372;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=1ce97YnOi/h1Osd9nlDMSO9qJOCIl2eu1hoJwBYS1JHQ/+EK/HSDnwDc2JcFsOnzoH
         LnCQ1CdaDw7yjh4sEdFRVJ76sSM+jebu+h9rJ+NgHP5H1fY1ZrxLsnWJkVEtEAF6Q36m
         lYc7dBoopulITAOoGJ6wF3EuYgdjZM2y4bAPzw1202qodC+Q9iYPjIAb2Mi8dE4BkF4F
         lz1etD/ZbW5JGyGFNFZhe9510DQPaOpj/gWn3U88Vq3q2mrmr7ESK96tyRuOQ93Rll/B
         Fv2pf4b2Z3qhTCAH94A8qNkSjxeX1JLPXyXJykiU4s1QcxnOVXO0JfgxBJ9P52BZW5yJ
         EqCA==
X-Forwarded-Encrypted: i=1; AKwUvBwoaUhoL8ZOwiZS7eCDXaIKDZNGlflaofmEvRDW9TscuutrGxLI1FrOaXjSIOcldHCFMHbV45U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxY+v1xs+PXnR6gN2FOu6Ue/GysxCP+ZDXPrKV2H3xg8Bo2Yda
	ZadrQ48ODyt5X80HFj4BHd4G707zjfTK081mEeJJL02VNFN4D76duJzorTfTtCokAw4=
X-Gm-Gg: AYBFou0/acmfcNE6ek289abDc4ih3ngg7A7yXsMvHQGTWkqFqOMkp27bsW1SQd6HWYp
	xII3S8eGPWB7lJCeC4f+qy083XyIRMD47pkjTVb9sbgHF1b2Pwf9PmqrRPy/UCj2oWq/+xe81qK
	Y6OYiYo1N5a00A0e3fa/BBQJI0QXid4ObHrNhu0KMYMtPa5VuFxv8JW6fOEQxLczL+uD0FXfpIM
	o14VQcPw9voHdlZNDmsyBsitxLSPzZ3CF3rdG2EOeH4ura8eg4yhJVW9X5shFmYRZK5oAuykwn7
	kV4/VeSax9Q/O7O4Isb2vPvYNFFQWdVqUPU5/qgqm1RkFh2NZTEQXe+/CvIhpDSpXBQFqeeSi1n
	R+ky5m5R5GZKYUtvGEKtIa0KkC3Py2d4c1n8OSAQhvxGrb9zCPIgRPwoC860j17YSOg3h/ttAga
	ft2yDnuzUGv3wpV/yM99xPDgTZqHxxklMY89/ckNC07aJhjcgZeAWPV84e4M7te3JlTsO8eLCh8
	VGcl8hsB5GvtP/1xSZIeP9/6fPetH6UlHkox3WsBX7bQ7hs3nnYl4G+O3D38+6MA3AO
X-Received: by 2002:a17:907:96a4:b0:c42:102f:15d7 with SMTP id a640c23a62f3a-c46bdbf000fmr901757066b.10.1793072572116;
        Mon, 26 Oct 2026 20:42:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4a::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649997sm382056866b.42.2026.10.26.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:42:50 -0700 (PDT)
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
Subject: Re: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:42:49 -0700
Message-Id: <179307256988.1171062.17835586018092384558.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Radeon uses a non-NULL notifier->mm to decide whether to call
> mmu_interval_notifier_remove() when freeing a buffer object.
> __mmu_interval_notifier_insert() sets ->mm before validating the range,
> so a wrapping userptr range can leave ->mm set after insertion fails.
> Cleanup then tries to remove an unregistered notifier for which no mm
> reference was acquired.
> 
> Set ->mm only after mmgrab(), once insertion can no longer fail. While
> we could fix radeon's code instead, setting ->mm on success only makes
> the code more robust.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
