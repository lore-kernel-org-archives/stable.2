Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692001;
	b=wRcQFYXAwfBcdhdgU2aiPc9ks5Gw/eFioYTgaKAszH7TYcrGpOSSwkWi/UlnWAku8QKE
	 hLK4uxmpqYg4c0xAYNYBf6Evoruag5vBSVyX6r/knbRv87+c8O2FdN9ZbryfAwPOFy3sf
	 jffp7a6QU3ciQMObVbl09KY1ziQhROH1zKETm+DMNle13/iNfpjv4LEdBU7xgW66rodYk
	 /IApDaUx4RwO3Vb2TsTziV9vt4bXcNG5qO9CxWNWKjK9u4MJBhTQHtn1zXIcuya6d5wP0
	 WJuJ7Q/30pqTJ2Pcno8kJuQV8PEDIVrBGb0wEs08v00YFRqrfpxTpgdXytmArIDP99w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692001;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oy20coKOo4RVez7QDzR5SPGemys71Bilu2eltbE7agM=;
	b=eJ8LIeoO+SqpyeTbpO6XdMFqc1BoVlSOiYwBWmT5/QwNWcliS6FZFkTWji66vAmTw4bm
	 p5BRabMMm027YeRUJptJvXgel84RTQ3m4rc7hA8uK6Mu9qQuCHeCMP4LbpdVtymrWfPaP
	 3zZi+eduTZ+qNnnBvgAzUEmx3H5bGxkqZIvQATQwIpOGGKvxSM9biTSIsh9fRwJY5r9Lu
	 dRiF+f/7TGGgIEFVmqySD2rK5YHs6B/wJGF6XmNNlSA3LjWDPCCcpr9P7AiGq2fKNSCpK
	 Y/QslyPRTQKGK9z/F4cgnq0voWGLb4kxlHprLs6TqpFDTdhstdz/qRXTUttlxDnEDBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E02606A338;
	Thu, 26 Nov 2026 11:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1E02606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 49a4ca20e98b11f19a56ed5b684f684d-20261126
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_MAILER_MTBG, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS
	HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED
	IP_UNFAMILIAR, SRC_UNFAMILIAR, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5164b479-3906-4282-8c19-e641c61d65a5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:5164b479-3906-4282-8c19-e641c61d65a5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:0a6e950a75cdc679f99637ba237caaba,BulkI
	D:26112610033528PJVL0O,BulkQuantity:4,SF:10|38|64|66|78|80|81|82|83|102|12
	7|153|841|865|898,TC:nil,Content:0|15|52|99,EDM:-3,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 49a4ca20e98b11f19a56ed5b684f684d-20261126
X-User: lihongfu@kylinos.cn
Received: from [192.168.43.7] [(114.246.238.190)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2135561116; Thu, 26 Nov 2026 19:19:47 +0800
Message-ID: <a7bb101b-e9d9-4e03-9854-33ccc6d6eda9@kylinos.cn>
Date: Thu, 26 Nov 2026 19:19:41 +0800
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
Subject: Re: [PATCH 02/21] mm/hugetlb: fix truncated copy result in
 UFFDIO_COPY
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dave Airlie
 <airlied@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>,
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>,
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>,
 Alistair Popple <apopple@nvidia.com>, Wanpeng Li
 <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>,
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Sasha Levin <sasha.levin@oracle.com>, Guillaume Morin
 <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org,
 Hongfu Li <hongfu.li@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-2-db27fd2f71a8@kernel.org>
From: Hongfu Li <lihongfu@kylinos.cn>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-2-db27fd2f71a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 11/26/26 06:33, David Hildenbrand (Arm) 写道:
> From: Chris Mason <mason@kernel.org>
>
> Folios that span more bytes than can fit into an unsigned integer (e.g.,
> 16 GiB folios on arm64) are problematic with UFFDIO_COPY: the result
> from copy_folio_from_user() can be truncated, possibly indicating
> success instead of an error.
>
> We will then continue with the folio that has stale data, and make it
> accessible to user space.
>
> For example, if copy_folio_from_user() fails such that the number of
> bytes not copied is a multiple of 4 GiB, we'll get an effective ret ==
> 0.
>
> Let's fix it by simply testing the return value directly.
>
> This has medium urgency, as it's an information leak.
>
> Fixes: 8fb5debc5fcd ("userfaultfd: hugetlbfs: add hugetlb_mcopy_atomic_pte for userfaultfd support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: cleanup code and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Hongfu Li <lihongfu@kylinos.cn>

> ---
>   mm/hugetlb.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f46c85fc0cd0b..d57964914e18a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6568,11 +6568,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   			goto out;
>   		}
>   
> -		ret = copy_folio_from_user(folio, (const void __user *) src_addr,
> -					   false);
> -
>   		/* fallback to copy_from_user outside mmap_lock */
> -		if (unlikely(ret)) {
> +		if (unlikely(copy_folio_from_user(folio, (const void __user *)src_addr, false))) {
>   			ret = -ENOENT;
>   			/* Free the allocated folio which may have
>   			 * consumed a reservation.
>
