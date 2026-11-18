Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031434;
	b=y40nf7f/6clt/cOe8kybiJVkm20FCb/oMz2JQovHJR4BXaD0uMr3sW0BjTd9qPEC02MQ
	 25iYpAjYpDKhuHajtqmK+cOvrppYJ14UhRdObVIjR7hcrG/gCd1HFeQmTt8g4v7A7R93A
	 bV+WsB1o7BfQAIOyo+3dGlxy27/+DLqCWEfaPV08wKw9oGMMYTwn+Iq6X2vEH+8qWf2+J
	 HNhE9zafO+2Zy/2WBY3UI23pjdtGVedqBMU5MnkXRD3VAj0jNJLVDumzZCmNUUXrvRYvW
	 NO6SbTnYnwg+qdj+7+3pBOl3Byt2SPsXhbnNHZXMvaq5TyczBId9BxpXT9/jyMbLomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031434;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
	b=CjtcfWGBf6gPhgzTD4NAaVVEwKF5QVP/b5EohsJNYiuUNCWc13GuG7gY88mpLOPQ+q21
	 Z6hRSKmfylOf4HAVynG58j8LvJiHyCMZJORBuJvqpgYgCVRDWXuCA14IizwR9Yyv3NYAn
	 jqfKpDjU9OZsfTYQ921tsFFGBq0okZb0IkDQPgatvmc1mqarzFQsfgu2nxsPiLQ3LDIs1
	 S9xTFspz1bVdCKqHSar/lcaPcueA3IQfvC7M4Kjh+Wpg4OYclINWRoMN8RkusUsZeOnJm
	 Z5cBP7FyxkhJ1pU1uG1eH+oc5wEDJDbYWdtcDBrwTebvP5lUKqLo4roY1V7ogw7CNBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AvcKfCxg;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=YHVVVoWA;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B0606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683B0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AvcKfCxg;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=YHVVVoWA
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIJYa0D1487911
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=r7xQ
	Eq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=; b=AvcKfCxgh2FO1dLQ8zx+
	4vXb/ToMs6lkdoSyUzHR7J5mA8oTJ80Evn6C7DQAcQmCKyyCXCcVPXC1AY2BPV+D
	PrxnrOdal+rGAkWkiyrbM+AqOwlZAQ1nJhZU5MP+bzgPUyn08QXjS82Qla/J+pPH
	iCcg3Jt/KcqKZ5SUTzgJwHBANnntnyE+Pl4ScFWubQmhtGSgKuvD11x55l/MrryD
	qpYkODcKqypwoTWy8gK5UZs7YAS4kt/NOgHbNYfZYGtlH43Z2m+cRpG1dhxCVAtF
	QizC4R1HjcRvzV9dgt1KKEHn2w9dfl+PcmY3Jg7zuQba4dl/aGh85fAhkp4sBQiD
	SA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j1g61hbsr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:50:32 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55bf3e01e65so33329301cf.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795031431; x=1795636231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
        b=YHVVVoWANcVc83FlR+/D5H6u0kCJP7B/v0FdTstDGgjgb0pwh232znaxg7S4pKVFWq
         nJ0Zs8nMR+JMfcLnfTnICG34bvhannwOXI+kHG/izds4p7Mg6WoCoMhSeKa1UMHqGqAO
         BOZkbvRckKzDqyqxLB4IUfOSuCNpX+w/YsUmvSmnrqYiqyn5qs6YqITbcji6w0AtixWi
         kLPS8JKO0pNIzIokc6iGXxUe1JjOsGh14cufcqzZ/l5e1P0+dpuf/3oW1Y1wDxbgF3Hc
         a3IkbkHKTdYYlXlvhmxArcBhbHpQuuPH9bINVI0tpH7x8vZalR4N1k2PE+4zwfwgOK9j
         fbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031431; x=1795636231;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7xQEq0S5madAXrgChKTKdPfHb7gKwfhdlAPY6R8vGQ=;
        b=fveQSJay7AzifFG0+a3fBZ/D48T3CKh5rqULV6oRuPGb3Tdc/J770nc0W/NEDmcxws
         Qw30vBUYA5r0k1ny9sEKmzVswGUtWFiYcCR0kr9DQRXbTErTlab9qUH5xECJtPIQ8Xyu
         GO4Kw0wAQo7GrMOddHn1aNLJnmCKZXINOxj9RjIMrw4MBHCZjJpVtgC9wJaghK2ntCVj
         GZIbxiZCw9kxxQe+cublabANEL1+BoT+gsbXVQAYfZrM0YJ0y5AeUnHUzT9h9yznGzJ9
         SZ5KNZ7kDLBC5QLcIsSJfaiNO9mF0QB6X4p3HPp/n+jTtgOyZo8lsnrp+XiW2Ou2SEEw
         SJxA==
X-Forwarded-Encrypted: i=1; AL+hErEYg13by5r1jI5uZTC4YZ4MZyPngRE66p/04TMpJLCttdnfD2kVDVeSzhCVRKgWhOaZ3aSTv3M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OMlqidLwLaC5fshpcwztYcJQ5IZjUptMzdOyRdEuYYF5lqomR
	OjdSqj4hTrwuFJKEZkLCRMBvfqQrAEnhrKCCnZ+iEjJ47JpAbboPtyfIhAHq9toMTbFuK7Oe4X6
	Vz7ZfEnBuSfgkquUzYjMkngM/y132gtGU4BvWEescQXgDVCN+4xpoiA==
X-Gm-Gg: AYBFou0DoFKVwhu/Bbqwh2OMQOiknYnBBKvfdlEVuSDvFAZyb6bKfKdQaRQ7Q6PCuhK
	h1s/qrUZJj7r5EsbuTvTUlvUCxd9LV7mcQRLgchkLKFNirozBM0NczXNzJ17HEjuArtfLo1aqEb
	oncCfBMaQ3K15vj6fc+OVpXgW23NICo+mCzud1YDInVe5zwVXjL0ypscirUk2gNhJktilUwDwKV
	pXlmgCiVSW51rYLcCKqkQ4ZRO+o0m6LU3HqfDzlK5reLG3NbRv/B3BuyF86Mk6R24hbdNdpQNAC
	7JBZSd8bmdxcEySOwDFeR8WCu2WXgB17CJEobIdPtfFPtAG9v+HR8tn9CGbLzBjn9p2ZF7T1xXT
	/NBiuGypxeevsYKzrbsIzT3VQYQZiFgNLMqyRd4rWNMrst2aQC8eqXytZohauYmGMs6Q8EJ3SY7
	BT6OUhDd5E/+1MrVEknlmL2A==
X-Received: by 2002:a05:622a:5807:b0:536:252a:dbf8 with SMTP id d75a77b69052e-55d5a537991mr56617201cf.14.1795031431362;
        Wed, 18 Nov 2026 11:50:31 -0800 (PST)
X-Received: by 2002:a05:622a:5807:b0:536:252a:dbf8 with SMTP id d75a77b69052e-55d5a537991mr56616931cf.14.1795031430933;
        Wed, 18 Nov 2026 11:50:30 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-14.net.columbia.edu. [128.59.176.14])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66c24503sm7189751cf.20.2026.11.18.11.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:50:30 -0800 (PST)
Message-ID: <9a6599cc-f47a-4a27-ae8e-91c8a1a523b5@columbia.edu>
Date: Wed, 18 Nov 2026 14:50:28 -0500
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
Subject: Re: (subset) [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
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
 <179501525761.13527.5348420494097607881.b4-ty@b4>
 <d05636be-5a37-46e1-b6d2-30950b7778b5@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <d05636be-5a37-46e1-b6d2-30950b7778b5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfX37Hxyk2H2SYE
 HYTZj/fZJtiRVRe0JfYIaBKGcwLzSz8AhSkbYl4SlVZ4L41e0iBMlQhRFgSXtXuO+Pd+0+z2CYH
 66ZDj/QMkI1ClZ94+R6RxTitd+a6byA5spkwRt1pcov1egM+f9cv/r4/KbLRPDWUnUUgKmV6iJ/
 r3YjbY86wXhrKzeL55Fd61Q/qZ/e1Z6nq97HWjToKHoCQd7h4C8vwYY8+jpDHXbW9eTHgy3OitM
 9YQTVRekbFWxJwkXSGUySEct+UYEyy2799ITtLxpjwg2X4V0aRdt0JceasPC9LuUn7Ac1xA6O0A
 B8OOkdaReCE1rVIi2uca3a+vVwJqO1AUTanOi+BFapAENOas0ku1G371ikrk1jB7OltOEr+kHgW
 8gcFu04I8zCJSEWqlmj8lrIL9UxJLKBWKosk7ph9yTbIn/cH9BfFngHsNRb7QV/+sR9liqSVb4C
 xA69YCxV/rglam5M+jw==
X-Proofpoint-ORIG-GUID: cyuYckWMrGgC4DXRE2ABmED8RUWTDM6x
X-Authority-Analysis: v=2.4 cv=Ms7HeGae c=1 sm=1 tr=0 ts=6afe0188 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2zM0HjzktFauw5hoOd8SpA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=b7hxIIQ5yigvctP09d0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: cyuYckWMrGgC4DXRE2ABmED8RUWTDM6x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfXw+RpfPtyM9zP
 23l0n39v4dET74RrgyNirTA0zYXL2O6tCVrhX90hViUO53tpIDi/2Xvw0L1PQ4jL7vC89HDLwIV
 NvBF0KI12YBX4FyU3wxiFRqjWo7uCejr7ABD3wHN/QsdcxpSH9V+
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11970
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=10 clxscore=1015
 adultscore=0 malwarescore=0 lowpriorityscore=10 bulkscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180076

On 11/18/26 10:37 AM, David Hildenbrand (Arm) wrote:
> On 11/18/26 16:20, David Hildenbrand wrote:
>> On Tue, 17 Nov 2026 23:28:40 -0500, Tal Zussman wrote:
>>> This is a first batch of userfaultfd fixes, with more to come.
>>>
>>> These were found by a mix of regular old LLM review and by having an LLM
>>> write a TLA+ model of uffd interactions with PTE bits and other state
>>> and seeing what issues fell out.
>>>
>>> Most of these fix places where mm code loses uffd-wp or RWP protection
>>> while moving or migrating an entry. Userspace then either misses writes
>>> and accesses, or gets pages reported that nobody touched.
>>> There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
>>> file through a private mapping.
>>>
>>> [...]
>> 
>> Applied, thanks!
>> 
>> tree: mm/core.git
>> branch: thp-7.5.misc
>> 
>> Applied patches will appear soon in mm-next, followed by linux-next.
>> 
>> Please report any outstanding bugs that were missed during review, so we
>> can either drop the patch series or decide how to fix it up.
>> 
>> It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
>> though the patches have already been applied. If possible, patch trailers
>> will be updated.
>> 
>> Note that commit hashes shown below are subject to change due to rebase,
>> trailer updates or similar. Further, this is not a guarantee that the
>> patches will go upstream. If in doubt, please check the listed branch.
>> 
>> [6/9] mm/huge_memory: build the moved huge zero PMD from the destination VMA
>>       https://git.kernel.org/pub/scm/linux/kernel/git/mm/core.git/commit/?id=ec36bf72
> 
> 
> Aaaaaand undone. :)
> 

Thank you David!!

> -- 
> Cheers,
> 
> David
> 

