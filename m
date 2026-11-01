Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547981;
	b=PU/aancg0ni+zJQ4LEGLHZv1rof9YwA2ne6C8l2BkomOJoqc8mAN4Ub9AkxofjIgYEgy
	 p0jSBYkLiR3zvYAZlfLfFQ4DMoALzxrDZyMxT822rZVVszQZ6AGJiIjrSYr371mdgaMxY
	 Ah9BQ2eOfAktc39RI5hHw463VBBZzDlqWZ/Rea+GF/Uf1FGaIjIiHMGw3ORMwlvbApI3V
	 XSSeFu4+H1zjN9O7Yo7qUcgXYTy8cJnyZ+F8Lz3APzTrtiHJWHjE5SslaFTgqMjvT9qUn
	 s15QIIfE6KUmH401sCmTaEHUDhhwmAAEkndoxqsLLEcRa8gui9jwmWhgULbA5b5/cAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547981;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Zh/eyo6M2RHjRsF25F61w93yrzGMZmR6HtXDWGgj+0M=;
	b=LIBrdpzXs4ri3FdocV8myvU1z3R5pI6vLEIPzPUqJcQ6jnx1N0YpX3vNqQ6fRzMSWNd6
	 Keg0H1otkGxY9C4MeDzKeGmkhUIRLjUcRelLAIgaauyDWvCdsv779QSrlX7BPdEnHlZ20
	 8vmk4aWfjbUNv44yWkr4qW9qBUR5jhvNIED8EV4qo7NfkXBvHNSFYP/kwB6PoCypLuuWY
	 nyoW8Z99dzu3XWqU7a868BGPAOBnCfbABkwP0xfGoTEKEJBfort0SeNdue4evoTtUpSW5
	 QaLbc87smzGVwDTGx2+VFDCcFSZN2OBIhaslFRdPghTofG0MxkGpin6UdHSzfJe7FRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=fiXWWpqr;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=PAg5dkLY;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DBA606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 15:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DBA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=fiXWWpqr;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=PAg5dkLY
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1DVaIf751482
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 10:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Zh/e
	yo6M2RHjRsF25F61w93yrzGMZmR6HtXDWGgj+0M=; b=fiXWWpqrhEKnabq+O8Qe
	4p7MYiwp1IDmw2sq8ufILH2S//wrTtB8haPB1cgQBujDVeOIXG6VJunRZXdBf6zs
	7JHGnMMl6Xcq3vIedZbeSkWZqstfxnhl7FFsHW9d1qxFfTlUvuTddjf52ub4yYMG
	uibGhVgGx2ub5WlBiT7fHWrJv/R3ffdUvtCyGjOH4JO9aGJj++jnAT0v6cD1SHfy
	UqtIlJTuhjlLAc3I0MR70WOxpSMHZfwix/P6cZKvsy0B8x+LOj+UUSGvjUpWVXGc
	guF9bJR/lpXWy+vHTco3ETjGKkDw9LZ7Lsp56Q4vFEYFLrMl+31gFdOCDKGb5+2o
	Lw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnw6ntary-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:46:14 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5337f26ee19so65676021cf.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793547973; x=1794152773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zh/eyo6M2RHjRsF25F61w93yrzGMZmR6HtXDWGgj+0M=;
        b=PAg5dkLYAOVBadZv84nNTi58qj+v7qcgrKTcF75dGAtyBxo+0JNRT8OqKv57zgxDiz
         p+WK/Q9xSzgQwmp0XGnqQmr/mxK8+FbM/u+SqPAqTM2gRuoHa+GS+G+sZ5z+9yW1OQBU
         EJJMOeBi1eiRfTbhU/k/hJgW/+s1WeGup/5ENkM3MX+osT56ecnFlQSXA2ajGd6IZYmp
         9SwpKo6TJnIwL2Y+b04lmWN8S+ugGSCUGihVzkr0mLpvba9Zzhi1ioznJVUBnZM25cRJ
         bRf1pLWgSZyNbQpHF7FMzH6VCADtVraa7RomPSTaqf4dOsT9xgMz0q+Xjh8nOsk8tQFF
         dk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547973; x=1794152773;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zh/eyo6M2RHjRsF25F61w93yrzGMZmR6HtXDWGgj+0M=;
        b=LFvJo9cDB8SGuaR2U7P9tM0X8x9UlRP+zPuZp2XT7kMvpCHWlbCT5zivqiOy+HY9WK
         nZh/IQC8ipV+VIj2ArpG/YN++uHSY+GHEbW3WK6nBeSGZlIY21fg0K8nz5NiHBU6Qiaf
         ZPG1sWhXcQUv2Tuj9zZ5DkHekqm2NWEQhl66YrJd1LyK4ndjjbA2nQgdMjNL2/anxs3Y
         fmJSvIy/EAvqqNQlQX36yZ3gdRIxq0MUrSUkkRbnfn8RATTxfEDu0EFPIgACM2suq7sD
         CKChcjAoJL9xcqcbk50KNmME7b3BEhd4JF8U3SqMFkU9PswRObZfNpzWInw+OjfPUypI
         M5NA==
X-Forwarded-Encrypted: i=1; AKwUvBzjEWTEqA1r9U8aXORy3Yg/4I8tr/3TrqXgoxW6O4ywjzI/73c8VvXTsrrNsbOtbQZz12fpeUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK165PwTRLmmpHbzLeSEWoUhGeVChE/XfMhnoy7h2CFBihc+T/n
	QC7E8ow6tzBJ3TQG+t7eS58Cqyx4pJPnXLQgsrp9V58KflfiN8/tDEP0FnpiFMqBUGaJLO8TAhR
	J/0SyUUDgBKCii3Sfz9vsGyPGyebTyhP7di1escanEmtzWLdRyqyzWw==
X-Gm-Gg: AYBFou11NbekV95egixeh37HtksMRshKBXAAHWdD29xT7u5NGHGB3BbPjohaTDXMBw+
	hLyZ08Wts2whI/bG1d4djtDW6kYI/07FFjgRhOR8WdNVsnM2HBzK1lN5khIXqqcCZJhRwu6EhQn
	qNhEeD7kAZmIETAvz/vXvj9jagc1KojisyHI+5EJH5a5NsvHfjJflLwjWxPkGWWX+cezY2YnuPp
	m3RfCwrSOzcgBMTr0KB6Nqoxajn57LZ75E+JiJ7w31P5ALo4H5YSDyJvQEs9XtD58hHz3xg58m0
	C+GWrS8RF7tIBAsUb/QcFu/MCQLE+s4RypoH6SSeZxYtt3GURjlY9IBOHE3yq5RpH+V6W3F0X07
	6SAuNWUAwRagkiS+Xr9L12uu5RRFQpyq5lUyEP/ByxV84J4JHWaKRF8dhHN1SWkxP2eA6P0pdSj
	n1L7HtoGPbmZ89Z0KRAHlmloUpRvpHOUBa1Nb+y+baDQD6qWcNjgy4VCjeu8C2c5XWBl3ybFE8J
	2lbjFDQpLhk7rb80GWJkmEOkuygkNV9dClX1F2527tvMytVt5TdE5UMhxh01UK+7fbsEF9dQWof
	sCZKGAmwS8jOMj62Rk8=
X-Received: by 2002:a05:622a:2445:b0:536:6c22:e346 with SMTP id d75a77b69052e-542b7ef7ee4mr131486221cf.68.1793547973589;
        Sun, 01 Nov 2026 07:46:13 -0800 (PST)
X-Received: by 2002:a05:622a:2445:b0:536:6c22:e346 with SMTP id d75a77b69052e-542b7ef7ee4mr131485721cf.68.1793547973169;
        Sun, 01 Nov 2026 07:46:13 -0800 (PST)
Received: from [192.168.1.187] (ool-18e492e0.dyn.optonline.net. [24.228.146.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm68905836d6.4.2026.11.01.07.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 07:46:12 -0800 (PST)
Message-ID: <930e2b99-df87-4aeb-88d0-d12d012edbf1@columbia.edu>
Date: Sun, 1 Nov 2026 10:46:11 -0500
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
Subject: Re: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
References: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
 <04ad7001-bdd4-47e1-9a80-5b2464da1044@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <04ad7001-bdd4-47e1-9a80-5b2464da1044@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA2MiBTYWx0ZWRfX3bPMttSqk3dE
 zxONrtpQwoQ5iwGwRgJofT60q0T2EPgrTadx2w7Xt2znvgZrTwo9T1NwVQMt5bqVNnN1uh5f15l
 fLFd34ZcRezhHEvKdflrvLWyKOjrcRDc2QfL7KbC94k6WgLPXw8c
X-Proofpoint-GUID: 1qep1sgeapF8VEnmBYwLxONyjjU0L81T
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae75ec6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FE+fbgsriwsnvVT5CFHM3g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=JsHdwqBLpqT9QgIBurUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 1qep1sgeapF8VEnmBYwLxONyjjU0L81T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA2MiBTYWx0ZWRfX29hw/l9aQVKd
 PYHAZQLeO4Asv2OywvZUtOTTfc1lSHwTsqlsEBP8knLU15yEare7XyyZB3uWiTQRcEcgFgnobJe
 qM03eQonsiMgo0nyKR5q/uyCw7M4EZizbr1ssrUJIpl8xDbfhjpdj5fCx0XwFPpxWsInWMimeYE
 HXyHp3d0AypvUU2m0VctTEXLaZeqqQl9YnlValITxXIMoewXRxEhh+VfTU8hjT0MYVJjXPsQ/RX
 z3Wl8PZ+a84fQrYSxnwPw+AEeVMTBUNo+TaEcq84PwV4bdZTh3r9+7PgbMv38JjHgTYQWmCv2ZX
 f2hRVjfGpEOinzS1/ciAdxxFZTPZhzLVAMDMD9Ji9rMdyqoZ7f7Z903Mud+MsFLon90bvyaK9f5
 UIBALg1hw57vdfCx8CrMA+yV6wPw4gSSEZNQwSvjJsAZK8fJgSQUa0kjK878eGH5Dq40sSCVY68
 skmKi7kp1ACVs61jytg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 bulkscore=10
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010062

On 10/30/26 6:15 PM, David Hildenbrand (Arm) wrote:
> Why is this special to large folios? I guess because a single PTE keeps the
> large folio alive, right?

Yup. For a small folio the one PTE maps all of it so
folio_add_new_anon_rmap() is fine there. For a larger one it marks
every page as mapped and exclusive even though only one PTE got mapped.

> Can you pack the existing handling in do_swap_page() into a helper, pass
> nr_pages, and reuse it here?
Sounds good, I'll do that in v2 and send it against mm/core.git
for-next.  One small thing in the helper you suggested though:
the first check should be folio_test_anon() instead of
!folio_test_anon(), otherwise a large non-anon folio would
still get mapped.

Thanks!
Mani
