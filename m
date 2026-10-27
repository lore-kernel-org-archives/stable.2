Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124245;
	b=kDfbC7mwpV0pc69RPrVyCdxOBXAgBO1ARMtLXBLEU457q0Kf1oYM1yNxxbZE4/qMLxMK
	 AD8x91xToIK36DvVXBvDmCVZOfKU0AQqoCXuQwpC1IU3yjPTGEUflxfDpwvZKvUGJEhih
	 PWr6aGRue0RidfT9H7+hUbGSKsZ6ZQ4IZhzbJIlo8C6h+IU4SDlepphpAx2BdL6ooHxCQ
	 l+Dk0fscVASxHyqMGvryuXzhyK2ackzFFrPTG2gh7RWIao6cidVjyOUTPq8Oeiw0SxYKq
	 hARZsgpA8LsgmNHMyBTTptWh03SPQi0n8uqpzWz5GPr8ISpSpkgEzLpzypIapb8UBxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124245;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
	b=OTfxTpTkS5ITeB5m8NsrRS6+mdoUj1S3E3KB8o5r4DbRpnRFikuE+Rm/vwP0VQW7uFe1
	 CnMzyyusQT2yj4/yojwFx4Eq9xayMpJrfohuA1FVcG1jCRkK/neJLtAKijdb2orOoYrFZ
	 kc4WHzAw1+qv9XvrUFq1rDLCm+pmebAICD8zO/GAqmUxUVUBaCyllMB1oSPiqXsIwjwKc
	 EO7t72INJwWC4VQikeXSLlD7ThSqQkeIaWjJJAWpcaiGV2aJhC6QiDfWAUBZM9Xb3EMJj
	 tluSOa7KPQySLtTkMoqb+UUdxMwQJ7Ed4VNWA+/nFGGr9hyqgtRNJZoHEFd/r2IVhpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E310606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E310606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=HWMW+LuC;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=MkOva+DP
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHh2pv1193405
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CbwQ
	ln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=; b=HWMW+LuCz6utW8S/VyIJ
	rHuo4CHhRhfcBnkgT2it5oCdt4YIlLKc6jaoFTG6NBRm9OQx8/Gj8cgBC4Do0iWk
	mAEHeGX4ZEQrgjmx5BHUqwprw2uw/fxZQF3p+JzRElcb76yXcKt4GQvOnFFzOajv
	msygurYhvvDfEXZY1Y1OFRcS/MQ3DzxL1Zn7WjVKu/boL2iCknUIbvotLMEHVOFn
	8z9EcTAubn7A/+OQElkqnT0CU8euYHGKsuMyJovfBE9MpfZ4akkMjYw62aGpHRD7
	9NYu/mzCxLPH6caGTchbWrsAFJNSQvq09+77FlRkr73QTb2lnAcZCq5a3XUaooGA
	UQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hk0kk88bf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:04:03 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a7c17166so3709066d6.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793124242; x=1793729042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=MkOva+DPKFBicQaIHSSly2JfoMAicHAbd7jFFZ2jAPfMZSSAxwOfcC3CPShO84ijPq
         ZECGGl73Kz7/09FPj4HtrAatZ8+T45RQt+M4cGZiieC2QJbgruC3B154GGVXb7OAzN+0
         2UhtrH2K//SHtIBzgQwch7+1xSTuSdd3XBXrSOFftUuUdhA49+eAWmetIwHQ/lmQkNU1
         eDgkpiPJIa7m+mdnAJUQCGKhtaBLbGtQoh5/+RjGZf2sev+2X2y5UVI9n1Ip2H0WcVvt
         DLiMDqjdZzodxrWp70M2mYAtjmKnXIkOjZKPebpETepX3BO/HR7B5Mv3SiADMWH9paOp
         KEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124242; x=1793729042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbwQln0osS5Ody02EmE3zfTJ+96bXVyWs9ItOG40Y20=;
        b=hbL823ist3hKHQUunT57epgQDudlnLFdez850eytNwmWUTHmsUeL8ZcK2uy7I2hyd2
         eEb5vVE5lK2PzkUVw1p3XSKPLkD5i9I6L+pq9oIqOGXC5pw3ovngbCe2Y8Tcny0UjcLa
         +GmjZCyGc9vZzIHBdMScIYOAIcuVmtUzH7+Mh93w7MlH0DJJVxC2zjLCIH5La0dwcauf
         hu609GdqxmG8LIEO2Px2wPXwmx7mS4mc1d1KPzz6czKQrU8o6apqfSf6sfA6qidNLENh
         Z6rYbsp7Etsw4YUCYEWm+uRM8W2YmMEfhLrJuJlbHrJSktm82zosUmYTDNv88UPcjcEs
         6x6w==
X-Forwarded-Encrypted: i=1; AKwUvByTlnbvawyR5ZeD3Xodw35GywDMQT75f8zHU/r51sIahR00WJPB/ICztFMIgQVtraBSPve9yEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHiP/yWXsuGuFDC64SsGBqTpjcUXM5L/jfQ/fD8zadG3oQB2bL
	KiuLmv2dXP5sgPrbm2nXNfzlk/zUzPNxHJW9akri9Vbsm9cTJ8L8dSMwCbE202O9WWVBX09HABv
	z/RYDyhENkSKaVua0KKqP5ml5BHH4/i1dEmxeV+bJ3u+ralD6Sc9gRQ==
X-Gm-Gg: AYBFou1FCbjPgzucxxy44/VXkSfHR0z/Vmv9WHbi+FDcbcu23jdKoHo5whm9GKC5XlZ
	fdimJej4ECNs5AsNXzYjYmWurNVxtex/LXA87qqE/Fjry9uVm5p981juugSs/5DRir6GF7F+CjQ
	qNue7noqLQFIQVsuwC6uy7Y7gssislg92Q34CuJxTf/bbcFDC/y4pgn/aB4vuXVQrcRxk2tw1wH
	uqkpTwuSm87W17iGx1d5vvTfmXVzKq5HOuQ9k9w8zdy8f7HD9xNRSQ3hsNwC8wNZoN2Cydi032D
	EtMUOUqYD/TbXasSI7dQNpguU9eNSCAaMvLKrGx1R2/beB9Uq2eeuP5M0P6rjmaDGHaP2i49pEN
	D7rRS6xrMDaCzgQLefETBEfrHK9X3ltpQATOC5FtEGjEOcIrhLhnRohq4lCDajeie2aLCWvkKDF
	e5fblw0hmRGKTJdDQfvVP07Qy+IXMnZ+11nw6ByLcEJkkWBPm9Y0nj3aErWvTUk6AIiZX5vVH4I
	GZQAR5jb2D4JcA=
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547499685a.82.1793124242406;
        Tue, 27 Oct 2026 11:04:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2a06:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-940ef9ed966mr1547486985a.82.1793124241704;
        Tue, 27 Oct 2026 11:04:01 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a94a5csm1037624685a.41.2026.10.27.11.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:04:00 -0700 (PDT)
Message-ID: <208738b1-35df-458c-9955-e2e5318fd2c7@columbia.edu>
Date: Tue, 27 Oct 2026 14:03:58 -0400
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
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
        Barry Song <baohua@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
        Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
        Gregory Price <gourry@gourry.net>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-cxl@vger.kernel.org, stable@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
 <auCw2-_yjh1_RjiO@cmpxchg.org>
 <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <5d431bf7-8813-4e2c-a40d-b45d4ff39a5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZCCWJJKshX0Hghznm0QE9XUfVgY-sc3r
X-Proofpoint-ORIG-GUID: ZCCWJJKshX0Hghznm0QE9XUfVgY-sc3r
X-Authority-Analysis: v=2.4 cv=F47C5ahN c=1 sm=1 tr=0 ts=6ae0e793 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=pJWPUViXIfCbsMganCcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX5+ONBzw8Ue5l
 +jwGSWvas44OeVDDoIlL5JUHHMPFTMQV8M5tyS49Vu7Y4PdYrnebiIWFB5AWDNFtXlVx8K4o47N
 sehPNYfCHtBVRw5udhD2Da7XzYCYLudLOIL28ff32HbplGlrgTnh2A4bNARW2xqIzHJXxJ7EcDl
 l5pojGZqwTN3RyNzbbuQhOelGj8bXbKVXLbXkfWxSCQH5iGFNGkJYurcGVORir7Q8SFPnHchLbj
 mG7plWFtslhGXjV2RMUa8TLn00Ur1BlE58kuzfK2z6N/gwq9O5mT4W2dIv3O3I7myM04Bz5WRvV
 g/z3kDSYko4KjmrnZDUu2pNiX/9AfXKuDNnZp1EcpbS20YPU5nMpC3OC1adHgeqfxl7o/k9golf
 112i07f+SnMfeMvHDOOgjPa2OtRnwd0aMsrrAIaP6XKSPg2ldCm6rd+L+rUm62SRN5Z1pEhCkb8
 pxnB+0xzCH40ou8S3PA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX/7xlLFbBIrti
 eretOwm996lFLiqpRVl0Op1J+6ZfAnr+HxMDsaxJsjQ6KCPLLaoSKKFM+OGQbXIFtnEFZv8tqvL
 RM+ON0eonyFkS2ZmkkLyJn+RdRMIFCg083Mc3vOGeNkjKHtIfBG9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 priorityscore=1501 bulkscore=10 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270071



On 10/27/26 11:15 AM, David Hildenbrand (Arm) wrote:
> While I have your attention: This variant works, a different proposal used
> 
> list_del_init_careful()
> 
> instead. However, that is documented to require list_empty_careful().
> 
> Do you think it's worth looking into?
> 
> 
> https://lore.kernel.org/all/20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu/

In this case the careful variant is fine without
list_empty_careful() since it writes ->prev first
and then ->next with smp_store_release(), and
__list_lru_add() only writes to the entry after it
sees -> next == entry so it can't race with the ->prev
write anymore.

But your version also covers the PG_partially_mapped
race your comment mentions, which mine doesn't, so
it's the more complete fix anyway.

Thanks,
Mani

