Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414786;
	b=m9HSrgds/u5ZZHYLA5fMBf1+Z4ZnenC6TqRtfHNWCsa4HAM4UtMBZt6CoLJeOefdTqXj
	 feyUtxp7GNCDX1oMPxCbXIRHV3+zeV0uq9IhSzzp1+JWFgx+3I8wCWRKfg6wrEO9L+eZq
	 gTA9egplPTDXI13PvkSXWhTPqINQqQu66hnR5Uqj6tJ+VlZK/PYj1WUd7EnO3nCRJjoYj
	 snj1APXGNQoGc0Ldec7iNp4FEqiQTphKDDxfxPIdL+D8GXLNbmQI6/H9ZijgbJYon+36p
	 h3OvzSgqJqoHaSwqPQBmyKQuViZobqdkxPZ7H8+ns+52oZw3DjTNQvOGKffBASCfzSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414786;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BF/0+ZUXITScNNxomDscQG5wnwCmvZaai5xQhO9sUeM=;
	b=WOmPYCmJruWhY4bimXzt7ybNAKl+vBEmqLmeIzoX59JKi/VKghUbr3iyxc24o3O8DnWc
	 4DQz2XiyukzRfJkUWNJIDuM/hTkIDUJaG0trNBqcRzSaWz3USFK61qG+fd0pAvxb8WZyq
	 NX1RYkojsMZhE2lCFG3FAqMYOzd3QGN4yiBu3NumAyOXe/rbgS3gJsD7le8nH/7sdioGk
	 FysRaeu8Uunkh8oYwIBAXFPSSJoRrL4UiCvTzikOwDJ6+cqq+WJ1IXEmDJlbA1iHOuT6Z
	 0Kh3k9Rb5Ybo+GPvs8H/OKs86YaolwZr1OXvB+WXpOmOgvIe94jIw8WYVfTeeb8ZZ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=aJErLLce;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=m5sveQ6A;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30B606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C30B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=aJErLLce;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=m5sveQ6A
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN3YjPj3926150
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=BF/0
	+ZUXITScNNxomDscQG5wnwCmvZaai5xQhO9sUeM=; b=aJErLLceONn0l2Dq54F8
	As1H9x/izFTp9OY57U5Faobi5tUkVGFaIiEJtK82FRCiYOLAr3g+rJ3/bb6KTriB
	kk1Wxv8CHIO3PWNtpJQ0ANxzXDaJPXZONLl7yBH+EE9lwHN91IwcRGTQQuZCk5Ni
	Ex6by1+1odkwG4CdEQpKg1sVk0z+dYMPxHFsdHMxBZBrO5RYl8duZVlfuBh6Uyd0
	E8edBG2cRGRi3laQXQdbtlOv6CKhgl3TKoTcbiLU791TjZoUkXugdK/8N/XTXhJM
	yIxZkpa4HUYNiBVb4zC7q+2hya++c5fbM8W+OHOlZpEBqeC4eKtUE9le/5N/WAU4
	AQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j3tkx4p87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:19:44 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so552775785a.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795414783; x=1796019583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BF/0+ZUXITScNNxomDscQG5wnwCmvZaai5xQhO9sUeM=;
        b=m5sveQ6A86gTPz4ilE0VM1nIaOKtF3frM/MDVA0C7wFc1+3jA87zITWnHBz2E43Dmi
         67BWw7DFBSUvmaBKvV4tFLaGu+fXfbWJGiNVYKebKM3gP4ET+wFZb+TyLRKSC6Wh+UaZ
         6KP0v5LyCTVY5/pOQEhzYwFGsdYiTw10Sei4eH6vGlpZE4Ek3v1bHG/9ONnpkdZfYrlr
         Z1E/RALwoyvYCBRP1ZJjZGOIc6AuamE2lrl/E4G2aMChboJCRi/I3SEGhoDHIbBftPIx
         i2QiPy2+rQCzrUhOONz8nEjlR/Dg6/Wcih3JO9VCshnXpCXHIE9Q7c2ZG/4WuMZBLcb4
         22Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795414783; x=1796019583;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BF/0+ZUXITScNNxomDscQG5wnwCmvZaai5xQhO9sUeM=;
        b=SL/6ZSVHGp1sYiVLS9DL6fqXkvEEt1kVSvqaHYYUnRcOQPEyAM5X308zx5yzjnGteq
         2faLwlKWN4aMDzkxl4FUj9rBAn9v0N5TVATehBUCqPd4JkvrZhV6ceS9zDksY3O9gyCz
         VIRW/LwYaWApF0Ry6tM3Lq34YEXWBAMc7mf9C/hKkzwJTi/k3eF3O50HS/lasXvZKUCO
         b2/zj5GAcyxeSIjYZMhuohtJicINJgg2F0iB+x6oewHhqiRsVtTGSzgeb45bE3o4louZ
         JD4nMZ4TrAk96q7Hev/Zb45+3PgrNDO7WymhWbHt2vq5FqCRmMkiWFS6l7eoE0Gn4lHl
         lXGA==
X-Forwarded-Encrypted: i=1; AL+hErGrvm39s3Bz+128ydS4Pj7u0uFuEeRDCqocYW3xgEDCBQaeNIe4ZjCfPhH3gE4KpKr6fSjxLqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Wv/454hHh8IsQkIa7EvQ1IGnq9LougiP4AFT/ticP98Ey1hRL
	PmJjpN7lyQcHyZVqzsERzLjPnSsS0nmGV8Y0trOAitPoPKAyKdNGXR3rY3fJJvHlySDkDNWJI39
	xVKbl1twY7t6yPuueez/vngLSYpSRzSs015s1c7dDi8hynD0k0hq38w==
X-Gm-Gg: AZFdTZfF5zf/7HIRIhCOgofY8CxPppF6P+YwI1ZJWEJAfrI0jm4uAakCRFrnSoA4Kfv
	Wg2IwVmeCeceAjztSerXllTb80Je8OJVDNw6/S6Yt744F9sBx14XGvV9vS4OD8Elhe17Ak0MHfX
	oWi7S/1a8mIr1ZzId4PZm8LQf1LmLacx7fy4Qb8Hb+9ReZKT+iPg1B9yd1v0vruSu8CAdc+dBAF
	8ydftkxO7426Zu6Bsf5F8RNKn9kRBirVaALavtjYJSfEQOIXkuCny63lRCy9n7UDs0E7THuXBDD
	xAz3Hu9Tye/b6HjX98/F7oFC4bo5XBZVej17NtBb5GK7swRxsav6i8PBb0bmKX9QzcZKBrF7/JZ
	w8yeEOz6dzqB0EaAP4ikzV/fzyHo6GpDycgOOFw8Jx02ccG7F//es6JUuSDnx/oTUIwFgxorU+D
	5vcooHEVghcl8Ngw+egPN8Lk3nEL2h/du8wkLUkv2fttD/z4sylgCgIG7eP+xOeZJT2eAY1HJFh
	rT9otjMzJ28ptPTXXdNq1MoVLyoD8HaxvwL8dfSeJ2V1b4jpC7DT8iptt5Owv71jMf2rM/DS4lk
	DaUScXLEXAJlJxfQrTxMFYw=
X-Received: by 2002:a05:620a:3c8d:b0:949:b99e:1d6f with SMTP id af79cd13be357-949b99e22ffmr1153850685a.0.1795414783572;
        Sun, 22 Nov 2026 22:19:43 -0800 (PST)
X-Received: by 2002:a05:620a:3c8d:b0:949:b99e:1d6f with SMTP id af79cd13be357-949b99e22ffmr1153848885a.0.1795414783255;
        Sun, 22 Nov 2026 22:19:43 -0800 (PST)
Received: from [192.168.0.76] (dyn-160-39-51-212.dyn.columbia.edu. [160.39.51.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41c105sm746775285a.39.2026.11.22.22.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 22:19:42 -0800 (PST)
Message-ID: <08b18b88-3ab4-4681-bec8-f4564fe9f1dc@columbia.edu>
Date: Mon, 23 Nov 2026 01:19:42 -0500
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
Subject: Re: [PATCH v3] mm/memory-failure: set PG_hwpoison of a non-hugetlb
 page under hugetlb_lock
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@kernel.org>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20261106-hwpoison-hugetlb-ro-v3-1-c11186963647@columbia.edu>
 <42a60f57-5323-f981-8ef3-2e5d67623902@huawei.com>
 <a87cbd92-0e07-4f84-9a6f-8db0b1778fcf@columbia.edu>
 <b0f30561-aabf-2bf5-2204-20907c40ef43@huawei.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <b0f30561-aabf-2bf5-2204-20907c40ef43@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNCBTYWx0ZWRfX0Wk4WgtpiD7R
 bgbFeE2Kn8Now+QFYiyqLrxWi5UWJVYvfX0bWw8f+fOnXonm8NfduLH4NZs61e54Cdd1NYQPRfR
 hM5mM94lywmJ+GDr8Yl5M+fAD96S02sjhZI/8K73PXIjWuf6lC+Ki7Jv0hUpTrn5aEon1vZ5kxq
 4QlVGxrxWluCT3MYNYvk8wuvz3eDELx1KwBGCnZF18xuAWmaM6oXTUOAK+DjPjvLXNvePiM5Lhs
 jaaySA+l8efynO0y3z1pkqe6Kz1CqvlHh9heimCVz5v+YYckhZvXKHveDPO3us8krMCBq9KcU0y
 GwAxyGKpTU0qaKBo+VLwYajrKt9ruVdXHaQBS4TWJ3FJVLaacg0g5X2zJXGIqDgRKF4o/a9xRCd
 W74D2yyvpKi0FlJ0YQvEN27EqDhJgFEeI8OIDyLN8RmhPM051JiNxPpMWMkjpa/KgDVVK+mJ5Uq
 1fBL76//Qcd1gLxHBkA==
X-Authority-Analysis: v=2.4 cv=W8qtxhWk c=1 sm=1 tr=0 ts=6b03db00 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=l9izRfKDRJJ6Wn/vzKnQSA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=ZeqcaTA9yHy8FKGpf-oA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNCBTYWx0ZWRfX8uyEsgYBRGsp
 1yQxvyx4TvKvsEOpV67Oc4vQ/CR+Q7qbT61rSjxkGngoAxeGqB6L9cKsAa0h73fbXeeEBuJrJLG
 juI0hZardCTNeue02mJTuzvdLAHYUr/R+uI+M1Wg0ptTYdVQs1J6
X-Proofpoint-GUID: 2UZpQoG2EFmn_2jJTVpEeoReXgn41qhF
X-Proofpoint-ORIG-GUID: 2UZpQoG2EFmn_2jJTVpEeoReXgn41qhF
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11974
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 spamscore=0 bulkscore=10 priorityscore=1501
 impostorscore=10 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230024



On 11/17/26 2:01 AM, Miaohe Lin wrote:
> In both cases, will the hwpoison flag be lost? If so, would TestClearPageHWPoison work?

Only if P's struct page is past the first vmemmap page, since HVO frees
that one. In the first page it's copied, so the flag stays. And
TestClearPageHWPoison() is still an atomic write, so it'd fault on the
read-only tail (e.g., 6.6) the same way.


> If the page becomes hugetlb, should we skip the retry path? try_memory_failure_hugetlb
> can't handle this case?
> 


It can, the only problem is the stale flag from the first round. With 
it, hugetlb_update_hwpoison() thinks the folio is already poisoned if
P is the head, and unpoison_memory() drops the folio ref twice if
P is a tail.

Now that Muchun's vmemmap_remap_rwsem is in mm-new though, I think we 
can just clear the flag under it (unless HVO already moved P's struct 
page to the shared tail, where it's gone anyway) and always retry. 
That'd also let us drop the hugetlb.c part. WDYT?

Mani
