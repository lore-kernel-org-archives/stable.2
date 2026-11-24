Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549041;
	b=ZJmHyKgqpHoLvedT4JgD0Zngf1UzOK3+hpkVxdE7KHkBQtRaCKajR7jnMDK6YHfpPAgl
	 5rvar1E1ERXgPGSz6dhhWbT06Kui1C2yTynMiJHQQVezBMNTn/FA1l1FC3/82hE7NqTzS
	 8577TN5QoSFvBREZupR10sEvpm+pft7gWgYfLB50rUfUkfSWuwH94GJIoom/Dr5DlbhKl
	 NC28N3tASmfclKwWz4uvTjzJMG0tZ2/f3Z46P0b6552TNT/s5I4Wk+oiVPQCbwafOCMeS
	 3jGp/xKLQyJTzPpVVex2Xoxhwpe6RnDN7tDB1HC7zvlsinp0LM2+WC4KsJAJxq/JsGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
	b=sZjKZxkNyoWPxEzKelal4Y51tklZk/8stZzQh/9OZladtdDk9Il1Zo+lUgkxhj/4yYF/
	 b2ANlt252+d/F9vN56lx83gaJOVV5e4PuTpp0xw58pxlnXsUHNRT7q/o1Iid9uext3KKN
	 81H4Hz7VuoXlebgKgWgczdoidS8HxEeh4GEan3LN5wjXoOS2+Ln0bWwsFA82wjmzNkKHn
	 f0lHMQIIyEw6EzFroT7gP0r7hNlhQleCzthmXcLrg3WAvGhMunSYrN3pjyj8OBBS2YhbW
	 3scRYpU6QARDhloICj7DiQ4D4a2tQoA+1uukaBXzpj2muZLe8wRurxKeoYaSSerU4gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ArQqb01A;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="b7CR/Rfv";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B5606A33C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC0B5606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ArQqb01A;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=b7CR/Rfv
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOJYJJu2842081
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=OMjg
	nMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=; b=ArQqb01Alvqy+ezQ3O+b
	wFGaLKLkRPslDfTTnR/1n3YHEnzFvpSAXsSLtAema3OMBGvQTr8MjsfnQdizF1DR
	Y35c9K1YbdbrokVp6lJBFIYVrUHqLLS3WYYBtEDDKg/6m1bODWncA+LZwiNP1MH8
	Z3bx2LUxG6sfpmxDdUI+/kyZI7guQlRgIUWOBYQ6reZ57nqjYw3JFREOmJXGhsy0
	5UyyJqrfI8VjX2MlX1xqtk46jQix4pqRNZv16i1aL2PIz3aAJytU8fQlN33iF7Uo
	xruvXaD2EFNKvtzNiOaeLj7AUiUNlwagsbKMIv+l5TRcoparlTssaELubPi31AEG
	DQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5fangypa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:37:14 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5383d650f2dso88840211cf.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795549034; x=1796153834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
        b=b7CR/RfvfQFhd7RLSUV7lty/ZLnME/O3SIVBqogZpBKc5kWbTS6XOXLLtHAdx6qPnr
         GLx9wIF4Ww4QBBzLi1rfOBnuxr0JAv1yTnG4pUXExvThtMqTc97cKp+Z1h+pCVB4nXRo
         tgx8ds6qPdyVt2BG0hZu7Js1CUMYgRQoXbcHZ2L8eyOM8lgOjUJPCl7yqCAjRMmEMl8w
         7yEG3GKOnP3k9k9ABIteGqF13sEWTiupKHLO7WWmzv6jE6HmUFHqQtTtep4guibr4fvN
         fCeMtXZBo8LG9rK/kdXoR7e8/Boax5ngkEHQ2+xMkquXqR4MIvpygOuBEgr7JOmObhVL
         QKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549034; x=1796153834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
        b=XxsCMFd2AmVyP0uzDYo2tTxJoWwPL1Ng4anoPrMhyPzuUHn/Z/HqVNtExij6R5pV11
         6gLG15x7Pgq8xCoO/DvorAXQ40TxjBFp+gOpd8gTY3e9N+jPKnjwE8ejMJ2aLdeDoZrZ
         QhV5rNzcyCvwvr81+N6QboK57sBtYiuazGkG7HNDF0eZTb7msFt+HIDxuoF2O2pPkDBl
         ZwvB8R3cflaJJ4V948Xo98rZTo1f7y3BD+A5LMgSUVB+IIaydGh4IsQJ5tRBYE63pynz
         lIpptC7h7+RRy+qcOsJr5L0TwMz7qEXdZS7HsNuCOOKrYlPNSYQyEx/xChRnf4WqqqBV
         TaoA==
X-Forwarded-Encrypted: i=1; AL+hErGJEBz4r2MtILBYeg1GElycHX2w7BQD8OrXc08gZ9NCem7Mhr85cUUTy4MSNWMRT/qiXu8Azks=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8OXrzmfVnMpOzp/rcGdpfW21dDVKRvGwyEZqQubz3ZZQnqf1l
	WW2888akFG5C5hSi6tISHJ7NAJ0EQqs/66JZ9ucGWNcWaDURcRA8ZgSKF6hctfueU218rHYDeWl
	GVP2KkmLs2CqOtlxW2PJgGOJdPNp+IHd1ayQ8t3lo2GETKi6BWYu3Vw==
X-Gm-Gg: AZFdTZeQtqkP2DR+cZETBCgwK21wawXLINFAM3t5wRFpbB12M1LErq/ciKAwrPwZq1o
	h6WT6eR/RC9rwUHWd2grd0LgvO3nG5oKDHrZHQiUFBb9lWyYLu4FzoIHSv/kx2Rjdi8zHfS9ML+
	4SUMTsYgjDi7gO5YyTmb2DfX85NZ0eJeA+/avR0YAyHe/toExZM9M/JexiBfeXZ3jxff4aO15Na
	j/ptq6RmkNhqQSTMztehWCqoIULtpsVwl2O1IFmTc9jgocAGliLOufAMoXsBb+4Qa2Yh2q/A4iS
	C+P1YOEKBOX6cRXJihIcR+33LJBGL9MXqM1L205KqgVQPXobyNgAIGhHT5eykNKTK+Xq1OB0E7F
	kESVMz8tT5Al25ROVMe9KXaIPKTivPS/4A5znR/qYgEmAfPziFrCp+BkexZDswT3uLQ==
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id d75a77b69052e-55d76a5af8dmr288718101cf.49.1795549033796;
        Tue, 24 Nov 2026 11:37:13 -0800 (PST)
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id d75a77b69052e-55d76a5af8dmr288717631cf.49.1795549033344;
        Tue, 24 Nov 2026 11:37:13 -0800 (PST)
Received: from [10.206.101.158] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm140631006d6.41.2026.11.24.11.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:37:12 -0800 (PST)
Message-ID: <3ebb01ea-fe77-4467-a1de-7f30a91593f3@columbia.edu>
Date: Tue, 24 Nov 2026 14:37:11 -0500
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
X-Proofpoint-GUID: MEwcvCbJ7gTw-wF9FZkgB1hDUrsrGDWt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfXw6AjPjgiDrpJ
 p+DYB9Li0GNIzAtqt4mSlXDkv71wQldxsr5e0roVPcXhRJLFUnzmPCxXFvk979i8e4e0Ldcwphr
 M9c2nflieUsdeFrI3X/ury4t6If6LxM2u07XIbtO5vcvtpGGm8cJy2lu8f3NkWYzBdxTTiyuDQf
 /yoAwYd6jXcd7SF/m+m55RPKNflHVt8QbxlO4wKNJzGYc9dxtHkhsQUmm7JKYfONuH5xr2/InOO
 BWtlyQ8n10/Sw/u+pxCw6uMnjgqTN+3DUTDdoKnI7c8qnREHJSE8xOiNR0h9+WfUjCnprt/AwYB
 YfCldcviLrEBCXpGhahnIE/JRMacyAkZ9TOm26clMjrjfjaqfsztVBEL+VmPHbUUhrb/YAzmeaY
 hsXz4T3zRZ5GnNC/XfHSINIndUkYoANGmascuoOOn/ORV1GOyWyA1hJgy8pK6VU0Cnik2W3FXxz
 QHa28sjU+4fZjIIjvgg==
X-Proofpoint-ORIG-GUID: MEwcvCbJ7gTw-wF9FZkgB1hDUrsrGDWt
X-Authority-Analysis: v=2.4 cv=acr0Dhot c=1 sm=1 tr=0 ts=6b05e76a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfX1dX7OsXDk6pV
 QWI+AxvuqDXtVDJ/xMV23HKKv8xHpWAGPFf1EgEHNjlC7NsvsO6qfRyL6N/ivQ7gE1PrgSS06S7
 XXPEW5nFJWLINdsAJksKwj43YwmbJLgmMC8AE1peYzRrliClFXjJ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=10 malwarescore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240076



On 11/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
...
> 
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

@Andrew, could you pick up the rest of these (everything but 4 and 8)?
I'd like to send the next batch of uffd fixes I have on top of these.

Thanks,
Tal

