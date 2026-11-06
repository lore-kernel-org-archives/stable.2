Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958977;
	b=bppeDk+CYEz9eNJAxPhxKu0XxCS12Mr7Z2ML7vEuab4PIPi9UX3ogxz/agLdtvEOycku
	 peWSVcfelEXAYNb2uh2vhQnP68VgkcgNlFrLdB36GjIT0du/Pg3cZey4J981Gm0Ony7J5
	 RB6SLzwOuK4K5Q8ngNDEPYpdaukgNM4F79taLyd+jZlLvmYatmwl+SzIB5Ze1Kpl0OiGn
	 QgkcDRtwxew6sdOjiC9GxDuBs+o8POpy7eFC2nviGtRA1gPO41nTMg1lUs2gH+wGRdsMS
	 Tye0m4Upebic4VO5jOsG0D51m/8xz40wbeHf+Bm0IIfhy71Pvbu5CvJ0hEWjhY4WCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
	b=4cYRzuqU7bzFCnmGMTNLFwTEv6542VUjf+TC9lWT1MtkQYdk9FxDCk0D8y/2xM7A+xQV
	 Wq4cjgG5Z4XNYlSaVrkACeqf2zTa2jUR7uwjLRvMltZy276C1JWSPxs7Ehv3phzNyg9uC
	 AlaQ6DxGvvQdWi2pm9qiADW5c58FuLux9kuoqNSiXUxQsEbYxOAn8XWEJ4GYiAIKBckPt
	 z04/vGjyFPAMBtPPKRECXfUvEFqvQVXH25ww1l23Tw48pLP2zzF3DKJy5fi2Pes/9kcZn
	 yHaTIFrfGasH4H27hA0amsXKsBh4+jiesN5Hv61oak9OLk3qRg2uFFVh332Pag5qM5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1Xmkiwr;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA8606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BFA8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1Xmkiwr
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49376eb635fso41572f8f.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958976; x=1794563776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=H1XmkiwrX3YLzUoz8v63tW0K3f8HeQQMrYHC6NguBq0Yc1lHgV5BxOaPiQVM/nx5Kr
         Nv4Nkr/P+0smDYStmA0vxUWIevexJO6W3YeVFzXWxjpUb82YtyB7exO1WkMPRlrqshbw
         7gdELKEwKXzXZnlrkpHr1yD7exsMl5g9kqsHjwkVOrYoszaDhxn1MLxcOJF4sb/6L3MY
         sIdWD7L/keA+kAzxJc8rrEhKaeUKb4K3OJKzQ0cL4yoRHek+Sk1AtTQV2X8+u59Vj8dP
         k4wPQ0+F+f6g4v8Op0nmFGDXNrToQHYaCL+7LHoyjFE/RK0fmcwPf6Waptypct15sbUF
         jOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958976; x=1794563776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=Hb0O6CENNQCGP7JmRmwxvfI3QIOG4mEoe/NtrwDrgJiVOro1LRlwkNUlBkN9fjVKFT
         KYZho0j/jG35z6ZyQdCgptrHJ9oZTHDEY/afxilKrvfB17xkLeMX6UZkpAlVOVqbQKdn
         HZRVCVQiFkY0EKdRKrNVDK67BXWtpkx3nb6sxC6F6wl1YwQHLHyZu1sVQH+2lLJi8sFo
         PtaI55dAGZv30u/GcHmeIGD0eTr/ZcDRFRs2aXradpq51jCKhCmWXY2PE3ae66+yi+v1
         z2Z5Kf1K+u7288d4TlbsMJsxVY5/jo4NPZTnVc9K1jY0ZnNyRHY0M8KEyp/gyxPkcc8s
         H03w==
X-Forwarded-Encrypted: i=1; AL+hErHhMtzeeAKcnyEYshLJGgNn/+lrDuAXsU1PeNASM5rtpd66QUEqislbNNvPqSroRN73jTjZRmM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CwgXSisEQS+gO35JSn3aSOm4OAQymIunXUpjTF1MPSUUGWMON
	TiDpQANIlSkGUZyCheaRMHDiTwIaZ/la6r0Dy7pklnuZQJpK1aiNYscx
X-Gm-Gg: AYBFou0Ubg1gGyHHVuq5eVPcQeAOV/00XScBlFrRM/Z7ztW0Mv+TJHR7Rg3iDtQNFXK
	ZytexnMyJe2VTkWWthT/zcUUexVnwJbFaZRTKvfpEcsOcg5IpDjWcMv++yw6CotVjgvf6XNswiN
	sOVRmrYr7mNB4IIUz5taQVvTTVpP+Wd3DX7NmCFa+evab57y5MefpJrQaF7OJkC3tetRHAQAd9O
	IuOLyCSxQixFvxsViHjeYaEsQSdjXEvbBLoz/WEoXS+kLoiZsFICQUCxAylzVDwXOIzxMHIGC1g
	iR4edEKd6HvwiGd88FbWmYp09WWVMyvy5aPfnx2w4LvdUb13DXQyweWF3X6GMQ2YIEUe6GyzIeg
	hZDFpIaXJ/uZUjTSpIxLnNS34/aUPNLO1fuNwGMw92MbQo0I8o4qFtclSsBBL26ib1mYoJxe/7W
	ecryr8yMoXu0EZ3dtpDJsclLa3Z4ykIuNIN8lY/R8grSnoJLTuch9spRe4Q08V2+OC197BTJcrz
	d+7hUptJ0brRAiZGYL7IL0iiceZJEieNthDdpcg7xP/X/74jOtNfAY1m0Cx5JUERarS6oub03kp
	jXJUnxz/wGaoDd5dAdlEwlI=
X-Received: by 2002:a05:6000:26d3:b0:48e:6159:8274 with SMTP id ffacd0b85a97d-492765a3e9emr3874962f8f.27.1793958975594;
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7dbb0d4sm2752385f8f.50.2026.11.06.01.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Message-ID: <e3e15340-d6c0-479b-867f-e5eeac1e0e2c@gmail.com>
Date: Fri, 6 Nov 2026 10:56:11 +0100
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
Subject: Re: [PATCH 3/5] mm/mmu_gather: flush pending references early before
 the folio limit
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
> and defer dropping the folio references. In the meantime, page faults
> can refault pagecache folios, creating more references for the same
> folios.
> 
> Let's just request a flush after enqueueing a pagecache folio whose
> refcount reached a certain threshold. Start flushing well before new
> references are refused, regardless of the caller's privileges.
> 
> This is a temporary measure until we have something better.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
