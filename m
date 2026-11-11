Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439323;
	b=yosZDE4mlDUWWQGbI/5k2+HK0LiK5vvIS+e4Wu9I9bT5nW3jnMn+X2ybJY1lE2ilEM/a
	 dw60lEgxREIhXx+Px6824NMhGMRln6oT+zF7JnUn/VMBld/6VPiO1JQPD8jApERTAQPSp
	 YBijuvStfWqECUrH8cKyM76WooGW9VnyvLenyJn4TnBO3I79kEPHlfteMqS0wx3aWcBv9
	 lyjedFgJIIHTBngKXkqVqdqxh+P9x5fZGtwFQCuqKMnuJbETICOrKnFO1QRpcdcYDxRfp
	 iKcY5LuhoChTjEsFY4IEwRuqZqRisVS+YzbQkMN7NG3xpiVOcxt1cIUmv2B6DWlqByQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439323;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3RDZDLRTYQ+pehNWhTTSvj1YCHvxKOaaZEnb+1PpFOI=;
	b=yyyzezueLsl5YLp1/puJNkwA+GUdi/kNnr4iNQZQFKCr/j08AiNg352BD9APRdTzgAwH
	 WDjRMJFbwivOrmWtUHBRIiBaU0+WjZiUQSxLjw7vbRGJRwCD5ZMQ3BAVEGW3c+NqXYRJW
	 EZTUqKe2iSUY894f6sLtlgHn6mJq9I1w71qP1ODKrvectvkWr9KbrS2hobuBPAds3Oyv0
	 yniqeUKY9q3gyf6J+3kdaxkNspgaQoztWuHrL4R+ZbAaiuGkcMlPPq7ZFaNOFsWPu3RLy
	 nM6j9yZ/VzRlA7iXnslyI2NOOSGsebARlag7EXNSjcPylcysqgzlgPujLnVSIVpVr3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=qyRHIxrd;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SOvVPQ8k;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B00606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B00606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=qyRHIxrd;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SOvVPQ8k
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMCNEj1796666
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=3RDZ
	DLRTYQ+pehNWhTTSvj1YCHvxKOaaZEnb+1PpFOI=; b=qyRHIxrdjV9xuKPMPbEN
	Q8jUh1svYxpXYQNwH52ReU/BhOJWekTdwXBixTj0mWGaMR2DlDzVgswqXjE9m+7Q
	NAp6z/bl1lbHdMnl6UHxJAjpVxQhbr+wyiIA1WEXfVwbGh7YPl2f4UcDlKxR/vC3
	2/W049z57Qz+vl2Y6qPrOqEgceLy3T2vDXSjZN6VdW9RuK9mVz/6++CZV7JlNdh2
	1oNf4n/NWezx68jbnYmcesANpzJLOjiYZJHyZ8sufMcPGoPWYlm5huXbbZeq3G+O
	PIr47hCB8sieDQeEShcp6BsWiXLCyk79iyeENSijxD8VvgkIaeq+s1u7bku6iNqe
	7A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvyxkgwsj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:22:01 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91256a7b7b3so59037356d6.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794439321; x=1795044121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RDZDLRTYQ+pehNWhTTSvj1YCHvxKOaaZEnb+1PpFOI=;
        b=SOvVPQ8kRjBWJNJd4287bI2gUKRZlp2V1o9FmxIvHbx4b97n95ETcRt0rxlUSSxe0e
         FPYGvK6P8LVjuCOJS7BEpfeXti6taniWJQ7PUHK0+yc1aXaRvTheR3xZR81mO3ArhGul
         K33ReC4PTi+pL7aZT706ZksFA5x5mMYjII43udip8DBtidoayb2owbHn/xS/zTnj7l9P
         RATlDk/ICOmYBLHGsLWHmBFw1yW2SVohS8/rzj4jtRJfgI/rDBk5sJDmtQMKDijGlOEa
         HNwEpQxaWzdfCShzSe0TmvOekW6MEdFFfM7FP5cCxsIiJjX6HSeW2Q1brMmPfNQW3gbv
         gDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439321; x=1795044121;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RDZDLRTYQ+pehNWhTTSvj1YCHvxKOaaZEnb+1PpFOI=;
        b=BIUGRvxI2U2b2Tu/RQRu9gZSQZty0l9w6g4gWSGN/w+dEqsMrkXh9ZfVum1jimnhrh
         7J1kH2M7yhKorBSLmw6rhEdzvqbTg9TbXTBlTUlCPID1VbptAcC6DKRHDaMePjXYYMxo
         DH0hB7c+pyVjF+aHYN0ec2tu/+hZtqU9mUf+Nz61xRwShTglTm92P1aTvV+33PT7cX0r
         ee1FvRAbXilRUwxeoVIUkRo/t7ZS2BgOjIBlD4EQKwNzn6zXNk1d81diuqODYGbwIYUL
         aeNR8L3ecHepY9dK4tmvl9VkPrzjwmqFi0BKT91z3elZ1VGDDW00+1dxKSSNMVlI7Drt
         ZZzA==
X-Forwarded-Encrypted: i=1; AL+hErHxZ/6lPtf8JAH8enqmnx102Yb2XSw/W6lBW4yA/rX50TcQlSsjsgMdojwBG4ArEhZ8g1lhxCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+k9CwuHChliPXCzoqm+NHMZRZy/JF5K0QlfyXxPMZxXqPiphEI
	He2DxNYqyZsiK12DiNwXWbxZTtsbjTdp/awZDNMnNlcvmoh0JRlQXNdIhU6DqJ0mck66TvvOM/K
	uc5uvE+q3BENibThnPbdXIGb4fsfawFTIy8hfXdnlXocHRaynL0o+4w==
X-Gm-Gg: AYBFou39elcwOEnF5trTsYTHAzplFr3mAuZgKS3vTzOk8y66ZWv9GHKjsLVLBTT7HvN
	vTwcte+FAfRx/UJfqy+G5qOMHGZa51V/oJfVA8OrxYt4vGbYpJh926nIrCb7fWR+q62d5gIm/Vx
	MeEigR6I8Gite0d45TmvJ6xB1mYxFt8u99b7g8BgdQxlNhZc644r6qz7KSIu84hm0h6sYQgzZWr
	n1skzicRI+SR1eTpmr8odYM7kHqL3K+lu1c7zp69eP2fOZmqgF7YxgIqMHnQd/Ukb2GUhFTx789
	EGVedv7OaXVUIA6prL8ZUUV0Pgt7nHT1kxhreXL2vzXTTep66khlJcwxT8gfsT+kql9vw5nl5/c
	QwRRNY3LCav2sODDZ9qe7kBw6sQ6tUzrfLW1r1d5iBPXIN9yLv0ase+lSVKhm6fBKxYDeH+QS0d
	bYMCAYDj9x4rtGMXRftKXt46zGZLwQG83HlazEu5N6ekJrmyVLqw/O6qUxeIgmYPzT6hqP5C0Sx
	5iDXixkoCFf3l66qexXDuCdMKMd2OZITKsGm0fAgg8Zr+/ZyCCdLpoyVVCPwbTQrg==
X-Received: by 2002:a05:622a:2510:b0:535:a5fb:67f6 with SMTP id d75a77b69052e-556c1b5dfcamr59717021cf.66.1794439321370;
        Wed, 11 Nov 2026 15:22:01 -0800 (PST)
X-Received: by 2002:a05:622a:2510:b0:535:a5fb:67f6 with SMTP id d75a77b69052e-556c1b5dfcamr59716571cf.66.1794439320866;
        Wed, 11 Nov 2026 15:22:00 -0800 (PST)
Received: from [10.206.190.80] ([129.236.225.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04d8d93sm57942026d6.17.2026.11.11.15.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 15:22:00 -0800 (PST)
Message-ID: <a87cbd92-0e07-4f84-9a6f-8db0b1778fcf@columbia.edu>
Date: Wed, 11 Nov 2026 18:21:59 -0500
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
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <42a60f57-5323-f981-8ef3-2e5d67623902@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA5MyBTYWx0ZWRfX5OkQn9NqsbLH
 UozjrmoHyDsC2NSDtVSF2Kh/CI1IivJj7N129rkuYgOS/6rSkn1kBOlivS0xX2sgVGl9M6Qoa1f
 81fKD3tD52djsUnqHlZifKPVU6Xh3V20p8SdEushQL7ICjUkk1qFQi5673EBOj0+BSBY/4vjNZY
 Q79POxs4YgxV8OxYrsrunwo6cwY2fCjIGNHbkcCHDaWqNNXIby9W9iY154CPdJu71W9fpWpUqD8
 p2P1kz95F2ciV673SqvdURcC9RrAiOWAJNK7ikHyFWWLBv/Sid6v5/+J9snVHKm9RNHSv841a3a
 nVSVYqjECChQ30Qox8KW7IFulgh9zrZ8yAWC77JpQVIFAyZtHvF9+svyt3cYZroEBfUEaJO5CAd
 sHeRKOUGLyx33S+3AzL9aQIb4JVDDyzFAP+V1XyYj/KDE93LJIyjMcTvWLYEq5Wx4jJ+OrPGgKn
 wdY/uy4DWfbyKjB5UVA==
X-Proofpoint-GUID: _LxdxexAtd9FrSntdCRiIAqboyO5HLcK
X-Proofpoint-ORIG-GUID: _LxdxexAtd9FrSntdCRiIAqboyO5HLcK
X-Authority-Analysis: v=2.4 cv=L/yI0OT8 c=1 sm=1 tr=0 ts=6af4f89a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=F4ifJYvLC05xlQRgS51V4A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=oSZCGD4z_m2zKWX6BwUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA5MyBTYWx0ZWRfX9iD8NQcFcmz9
 tPGp8gWXihB9h3Ur0KSGWM1L/je9iONKvbyBZRb4gfnFSFFDohGL3rHxoGa748v2Riu/W3Vo0nI
 8oWps1gKUUPE4qoTwqNuseNr6YnSFELw7B5f3C587ajszqByoTRP
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 clxscore=1015 bulkscore=10 adultscore=0 impostorscore=10
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110093

On 11/9/26 2:23 AM, Miaohe Lin wrote:
> I have no idea why the error on P itself is ignored, could you explain that?


My bad, I should have explained that.  By then P is part of a hugetlb
folio that's still free or being set up, so get_hwpoison_page() can't
take it and we just end with "Ignored".  Nothing marks the folio, so
the bad page goes back to the pool and gets handed out later.

If the folio is already in use it's even worse... it gets split as a
THP and hangs.  (That's a different race though, I'll send a separate 
fix for that soon.)
> I think we should clear the PageHWPoison flag we just set since the retry path expects
> we have cleared the PageHWPoison flag in the first round.


Agreed, as long as the page still isn't hugetlb.  Once it is, HVO may
have remapped its struct page, so the clear either hits the shared tail
page (read-only on e.g. 6.6) or gets lost while HVO copies the first
vmemmap page.

So how about clearing it under hugetlb_lock only if the page still isn't
hugetlb, and otherwise skipping the retry like the second round does?

> I suspect this won’t solve the problem. The below race might still exist:
> 
>    Task A (memory_failure)              Task B (nr_hugepages write)
>    get_huge_page_for_hwpoison()         alloc_fresh_hugetlb_folio()
>      /* P not hugetlb */                  /* P becomes a tail page */
>    clear_non_hugetlb_hwpoison
>    goto retry
>    get_huge_page_for_hwpoison()
>      /* P not hugetlb */
> 					 __folio_set_hugetlb
>                                           hugetlb_vmemmap_optimize_folio()
>                                             /* P's struct page now in
>                                                the shared tail page */
>    TestSetPageHWPoison(P)


I think that one's covered.  With the patch, the "not hugetlb" check and
TestSetPageHWPoison() are under the same hugetlb_lock, and
__folio_set_hugetlb() moves under hugetlb_lock too, before HVO.  So A
either sees P as hugetlb, or the flag lands in P's OWN struct page
before HVO gets to it.

Also, with Muchun's vmemmap_remap_rwsem [1] HVO waits for
get_huge_page_for_hwpoison() anyway, so if his series goes in first the
hugetlb.c part can go.

[1] 
https://lore.kernel.org/all/20261111093747.50048-2-songmuchun@bytedance.com/

Mani

