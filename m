Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933356;
	b=c9gaW9cuKtpSepsxZ96iCUybERkTTvskL3G0/qqExnb38LYeFur78rPEh3XgjCR6xM87
	 Y1GABVeW6Gys4Q4fZojc2QOs6nv0W6FWN2axc/rFAdm4Hg78Eus1n9I/z7VtOALr8PZdJ
	 BCW3KY11q7aod7o7gPbt0Sy8pFR8zEdlBQZKc7/PCoC95kt6pEefotKQf9hQfOyGlDxwP
	 1nLe8ToNUAsc9OTD4B0G/u0oMDmmS6iftZgqF0JTmqWwMPwMl4ZwXOg4kd2le9uQkzK3T
	 1LJgvLH2CEcjFYGV7JdPwB139mae6gVkKbM3XlQBb0zf00aXTRyGDIXfm0mg0Ivdzrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933356;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MhQ3c2PQxxIs273fLfDsJaAlMJ7k+j2UNp/PTN7YehA=;
	b=vnesSp0KsAyCa9oGQy5yFRyAg8yW7VdXfSoou7w7FnJiHOzgRgshQcOtKqa4Uqfko4nw
	 A5tU6d/2P579PkesL2HdVq2aZjnFeniL4k9HSrRcrgrg4cJMV1s3lbbay0Qg5JG1c463K
	 FE98FaH4waiGCsXJ606Ms9sck/ZE0f3xHEyWPMGEy3HLU1ZTIXPENHRt4n8hfQj/06tCU
	 GeMPB3M7Qp883JrVUFZLm9kV8zsj6RdMmkmJfVmpz4BljJvzYQySjONUxUn0u9Xi+a4qN
	 Z+Bb8TeWYOzhgBqPGrsW8IKmeNzTNk/avkRdsUOXjrRsWoXSoMesQnOLem77ZcUOsNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QYzRZBdU;
	arc=none smtp.remote-ip=115.124.30.131
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDB606A332;
	Fri,  6 Nov 2026 02:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DDB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QYzRZBdU
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793933351; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MhQ3c2PQxxIs273fLfDsJaAlMJ7k+j2UNp/PTN7YehA=;
	b=QYzRZBdUo4vmbD7D7WIAm31Q9xSnwQWALKdD0Gd9MBP9iKxK8o4/etn4td7zq3R70RZ5Y4+VBvgKiC6NEsEtCMceEyAgBY4+KybTf/GySPmCje2gJQUxhGoUFvEJ7xzgPvhqWKDCDA5Dk7vlxtKX6D5F5rFdxD2OJbtLQjeyhLk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XEAEjFl_1793933349;
Received: from 30.74.144.130(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEAEjFl_1793933349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:49:10 +0800
Message-ID: <b3035814-fa08-4e85-b3fd-a254e5b0a825@linux.alibaba.com>
Date: Fri, 6 Nov 2026 10:49:09 +0800
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
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in
 MADV_COLLAPSE
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Hugh Dickins <hughd@google.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Zach O'Keefe <zokeefe@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 2:16 AM, David Hildenbrand (Arm) wrote:
> madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
> uptodate. For example, shmem fallocate() can put such folios into the
> page cache.
> 
> collapse_file() already refuses to proceed with folios that are not
> uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
> such folios, leaving handling to the page faults.
> 
> Note that collapse_file() effectively clears shmem folios through
> shmem_get_folio(); let's keep this fix simple and simply let the page
> fault path deal with that.
> 
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
