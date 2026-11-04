Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805376;
	b=IheYB9LG1c4YCN2KvOkuFita6bGn3X4fJ9VF7diL6/MLMV8WDSNhvCNHF5KQdVw+k86S
	 kDbEKinb73IU9CFFCMKpo04a/0v9JyQUQh8Pbsbs7B6f/NYgtBVEKHFrHE2KxMxEARF2l
	 uCCv9ea1GGT6oN8NZ811PU8ZvHTpGjOKeut8HE+HDSiIvwzgrL1paRhYaMRn/rdi7PYiB
	 8DpdN/qvPPvqmgFHbvMa36EHOwgc4vkZZDub4cnCtoK0Zicb6PxNuO4kzNYUDpd7xT554
	 IFJNePLSh9r/PF1OpHBRECA6eSg2596saNDkWFDhSLyyqDWIsxK0+N7gO/g3Z1m+xog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805376;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2QP5qMLgCjzR3Vq+1R7yHnSJoapXAZoBlu3K14T4Qag=;
	b=K/B1IlxWr8cF4P92ErT6wtwFgH1+0gneD5tEcl5k2EHRZWS9d4hgQwGTwo9Pn7gaywq8
	 RxEsIx7nVlTUjkFRUbZFZ5kw8mdddiyB0s3jp5oP8pboTBXo8Dh0fLduBGmSRE5lu17rv
	 Mmu/YCXj20h15lli7qnUUp0O3v53nPnZoXiLmYFS5KZlZrXCwyP+rMprNUv7hEmqbjP2u
	 GT39RIqftaA5gja1xIhW7bwc9QDJbB4LXcPqR12H3dDFSqedc9TF7btef6gX/V6IBb35H
	 AGSuK6njZcVEr9+IxwXnMcdSmqHw7n9326J31jz35+LuNVcjfrMzrXgKyn/AhyX+BsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NwrHw1Lp;
	arc=none smtp.remote-ip=95.215.58.14
Received: from mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF46082BDE
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31FF46082BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NwrHw1Lp
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y5MODlRDl3QiqtxOx5uVZzRjMa3zrlbQrFa1R/TJtnc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793805368; v=1; x=1794410168;
 b=NwrHw1LpmsBIwswo5wKeYjRD/cJXqjYbwgfklMVriQ9oURLjlDTfl/zLggxdnvTYym/OnKq1
 0ax6B6z/14WfVvEc4TcGopfGKXxJiVbo00QdorFvXj0s8F/6G2IoPSpEn0xuxlFtmrdc2kI90p5
 JXzmGZYYZB9EOGWk8F536pXA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b99bb3eec717c0ce;
	Wed, 04 Nov 2026 15:16:07 +0000
X-Mizu-Trace-ID: b99bb3eec717c0ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <bb136360-bbeb-41e2-9dc3-96d783e6dc81@linux.dev>
Date: Wed, 4 Nov 2026 23:15:36 +0800
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
Subject: Re: [PATCH v3 43/47] mm/huge_memory: split huge PUDs when adjusting
 VMA boundaries
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org,
 peterz@infradead.org, jannh@google.com, pfalcato@suse.de, hughd@google.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, willy@infradead.org,
 jack@suse.cz, ziy@nvidia.com, riel@surriel.com, harry@kernel.org,
 apopple@nvidia.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 osalvador@suse.de, minchan@kernel.org, muchun.song@linux.dev,
 xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, stable@vger.kernel.org, usama.anjum@arm.com
References: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
 <20261104031245.9524-1-lance.yang@linux.dev>
 <45508a75-7549-40e2-a71a-807a824ea026@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <45508a75-7549-40e2-a71a-807a824ea026@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/11/4 17:11, David Hildenbrand (Arm) wrote:
> 
> Thanks for the review! Please do keep reviewing, but note that more trailers
> (including this one) will likely not make it upstream as I am about to prepare
> the PR to get most of these things here upstream.

All good, no big deal :D

Cheers, Lance
