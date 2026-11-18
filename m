Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015620;
	b=B5o4y9FXHQFmKFxM8IPQ5IJm7AtUbbumVEBlUVufeIgUfCvNXvPBEDcarwgC4vfAtOhs
	 kLjDDP1awVO3eSJmS5gCBSgF8PWmJqNwMXl2pBGA/VA9zw0jJcEu5mC+1Gn7rM868LIme
	 +Ci6Ykdsp0cIm+zimhVWW/zLarOneMHPsb+3yWPsuoRMzZ+skb16n/BJAwgt6Bz5mMY+w
	 LwA4qZ+tO5EENUKFp22O/UDhyMNS0VxRF9qGmpGaD0vQqM9+L3Yj4pzu/0m6pwJ62VlDB
	 /hFBWiQlP0SPlNTmyGToQnxjrbUfRbJaDqJLReNeJVVuO+qlLrGC7kaJY+73nUSnO4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015620;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
	b=jXFA3L8MXv+JkQ4VpLViLXH6CeYKOTdAprbBJEN98xSO3S1DGPqgWYMM7FOF7Xer/5qd
	 mhcO66xMBQWkBkQAdQI+GgxuJynEXt7KxYd8kBJsTVG/Ad9EURzCJZrTfaDbdwXnm7rL9
	 p4u3/zaQiC0Ue1ZFXs+WrYT33yTJi/fD3XPn1UoRhVJBqxj2PaqgauNRN1P3OXH6CitUY
	 vZrJ4ODq9XPP0gmcE9XU1wJl/yD6tXbVSnXxuixIwph2pmEHsdSAUqzABJ71Qw8VJfnXS
	 L2Nwfrr4jS44Vt0x08QPg3fSr9yHZv3usXfc5cmr0u7XHc84dNfI8MpCGEKBnl25r8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nkgzzLi3;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=eNGLzMnc;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C6606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F5C6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nkgzzLi3;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=eNGLzMnc
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIEgGkA4066111
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=y03Y
	2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=; b=nkgzzLi3h9HeG8fKyYEG
	uDh31vyXH1oYKrz4We4FN7MFzIgxKgw5bbl/1yYWvjel0KI9TY0DcA4tf8wyHfUO
	E9S3VBpfvNnGIkq1nWd7rxaJV0Lqs7OrEOCpyx0/oBVIQHwhYGWzDerPT+uUwcIw
	UNDOHrTbQpKsrdIawLbTecxwoOgThMzBSetvGLfhD1Fr+I+bJ8XjXzV/tn3a/mwj
	WnmC1oaXxkPmI1tAL5NMf/NM2XxF0DEM+oYOVbl6k3afNC9MEBBmKm7ao0MfRmEk
	9PYcQAKRmMuhT+Cw6VRw5kLAg34WlAdslNZkvKUYJ/1MhKqj8LIxnHzWfAB0TDWa
	AQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu74d5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:26:58 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94960bd17b5so180964485a.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795015617; x=1795620417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
        b=eNGLzMncLaD/gULnBB44zNnS7Dv4FStMKpQi/7xu023CAaSTwBI7HWkCyE1E5YWhC+
         1kiFjXZKFj8+RgDAZ1hdk51QxLbNs0CSM8RpFrIqBwwxkAk7TRswMjEi+QwoiZlQzazO
         e4z1u5ofToDqWcNa3NsjffkxTXBgxKwMe1iOFbCGp47iXjVmxNabEo6YnrEjLS96p8WO
         3WvT2Y2QGwdYCKhXPFfoREfs5wZyUi9d5jfAUhZdX5N5/Umb6g65IMdcisZwmY/nudM4
         XMHhjw0eb2Bt7y6891a4kwtTFuJuWObV6UANmwVG+eqh6f0a/YRlJ0+S/NtJw1R8SOML
         Ur2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015617; x=1795620417;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
        b=VkM3ZWlOST1iwrQeZCqdC3LI/R6XZd32oUgPQAnQ6awSL9HVUbq6TgbNVNon3kaWja
         Os6CoNweToBcwOnrMBiKODw5uDxFPjh3YRDYqorkzcu0oJmbIfw1Vs84cW94POp+Zrdp
         BHD91Vuo5qTCJuqGqVvLkCbiM4VOGMRyQGNhPgUb/pgrjgMpdjifbxFfMO/aA6Wo6DgR
         W2qmLAo0uZv++h2IfPzZcBgr5MwdiU7k2socYPX3+7lWQ+FxL0rkSHVLl9q3KHPaGkYz
         /lHeMrWpebGqNjpV1q5GHpxhN6/4erewqdi4H6/cC2nHZ2HoulkC24LEeovgyIBd0Mz2
         4KQw==
X-Forwarded-Encrypted: i=1; AL+hErFVS3eJ3lMkWggk8A1MlEefjr/iKHk6iWyVLoT3O2o1KHYUqMQ8qa6CYpoVG0btRCm6RNTsCcI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FvoJssX8CLBh4wT+/GQ9i6yq3dPltpu9xYa8lYyND891k4P0i
	vgLlwwAp5I0bTWzMu+XaJ/dUlkHBS90pSktam0/iH0JlFQg9EeTDM428R44qOcgfLhilmVYXacv
	6IiAUwzjF91v9KpXoykevVRPye+IyXFkvwKBvYemCEU/Qm6c9jOK55g==
X-Gm-Gg: AYBFou3qRD7XlOP8NF8sLFOOMtd7/pBFTE3CbNAuKH6Ic4BomIK7loXkTVJ4YU6vTYl
	ay1afe9teL6Xl+07H1SIks6H9FRlGN92ibBRcvRVYq5gssrZQ7VEttGd++DwYscuUX8X9o/rC/2
	kNJqMiiKp5BuA3Kz0PwXFeqVDoqWiRJezVqEPTGJR1lrQSxTtG/0yspEVrvVo8YmH0whE/DGtuZ
	xdRM/CgSBNG5QJayYpCLJHG/9/90Weo74EvsieZP/13nmWvomf2W8UyzoRsuvOR260TyqijEDR8
	KP1E4zGjCWM4C3BxlyfcA4QFLD+qMWmd5B04OR/zwVnx9l3TvoUpLf6TC6B3lfOdwk4SiiZ5ARU
	8+T6DSYVhu8aIG9XJYvRxyeb+KzasCO9+3GKPSthPixh6UgfL0/qXtsrCv8Wgzqc71YXnPKHRMu
	cvLFC3bduzpH3Q3M8y4Ns35g==
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id af79cd13be357-949995f04bamr536125185a.59.1795015617453;
        Wed, 18 Nov 2026 07:26:57 -0800 (PST)
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id af79cd13be357-949995f04bamr536117585a.59.1795015616695;
        Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-14.net.columbia.edu. [128.59.176.14])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b72055bsm204599485a.12.2026.11.18.07.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Message-ID: <7d31ba34-8b5f-4eb2-9864-145ea80c3412@columbia.edu>
Date: Wed, 18 Nov 2026 10:26:54 -0500
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
Subject: Re: [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Breno Leitao <leitao@debian.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XW46MIuOnBGcOnTZjXpx1H3Iti3OwI9P
X-Authority-Analysis: v=2.4 cv=RIImjIi+ c=1 sm=1 tr=0 ts=6afdc3c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=2zM0HjzktFauw5hoOd8SpA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: XW46MIuOnBGcOnTZjXpx1H3Iti3OwI9P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfXx8QeNSp07VWF
 z4/W0BLTVLUlOHdx7S1cWqF00xL9Wbpcn+08sZrlKH6mQQ3mbGeSxgu1O0veUDwmnDqq/Xishfc
 1MQLCB3DLfAf5Jciw2JZNv6LWK14UBIz1gu2Boq4cNj3gM0kniS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX3dYpP7W+LPsg
 IguZqGBKSv8Zqv7Rnoq1X3MEJzB9xOUaRBWC8nl8pEH5vuyu9kJvY+U1R5LrY2jbAiBfTJWN2sM
 9aEyYgV5IMtHkXKg+Q0hjDAjxFfDXajqbCKNHq8KoHbC9zurnKOUIZm9w8+IQnxupH3jWdNcEB6
 CiEnqgBitLNLanJ9t554Eq8wItB3JKqvd+WWGy1Q35WsoM/0mgfCpiiro4Miv7WeuLKiSAfREc8
 cT669qYrTEAK0W/l8Ngb73g0GfBM+N/Ek3JvZW+73OrdusP//kUMzmKA0TF5Rfb4tvH3R4nXyF4
 aD3gu/jkKUuMsETWvL08PsdveG3bIwdGHnLgM3FzET68YAYVoTvstCvu7H0JMOA0dpCVyQdgW85
 Ro1my6wpEu+IIe+T+ECtC1b1FwAfIcuFmW5WskRCxw+9v4hALakj8D+TlvlyyLeRU649IpTKRxL
 33S9YCmuU/xCt4KLU9g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11970
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=10 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 impostorscore=10 bulkscore=10 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180061

On 11/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
> On 11/18/26 05:28, Tal Zussman wrote:
...

>> Patch 6 has little user impact on its own. It is included because,
>> together with patch 7, it allows removing clear_uffd_wp_pmd().
>> 

...> 
> So, I would be picking up ...
> 
>> Tal Zussman (9):
>>       userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
>>       userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
>>       fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
>>       mm/migrate: warn on a writable migration entry with the uffd bit set
> 
> This
> 
>>       fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
>>       mm/huge_memory: build the moved huge zero PMD from the destination VMA
> 
> This
> 

So my one concern is that (as per above), the mremap patch removes 
clear_uffd_wp_pmd() after the huge_memory patch removes the other user.
Splitting them may break compilation. I would've left clear_uffd_wp_pmd()
alone but then it throws a nice ugly unused code warning :\

>>       mm/mremap: resolve uffd state when the context is dropped, not during the move
>>       mm/migrate_device: do not migrate a uffd-protected zero page
> 
> This
> 
>>       mm/userfaultfd: check the hugetlb alignment of every VMA in the pre-scan
> 
> 
> After waiting a bit longer for more review. Andrew can take the rest.
> 
> 
> -- 
> Cheers,
> 
> David
> 

