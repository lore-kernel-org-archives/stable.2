Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868039;
	b=eAelff+wNOowEIdWbopVp80CzgmK4WByJ+htgmn0ukb5LrkoWm0BveuJo74jgmC40S1F
	 cw5meYSpDzSEOJUEk5Q1ExPWebws1htrZh7ep+2IeqMqtqh+lKeBRLCXsSK3rRDBoutXK
	 qBxIFetZ+c2Ll2gVpsj4bTioeBAx5wXiWWNOwhqxgFEXpbZ3JX1AW3o7cWkYIL2TycOZD
	 XuHaL/Io2ji2Ws/H1Nsy8//ZgB7sU2XnPJN4XaK9XReBicIvDA301iAw34RtitYWGu05z
	 2sV3zRTO7O+K5ok22Mi69HYtdS06sobQSMOc9M3Z/kggPtv4S8EkIvRs4XAp8VoSl9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868039;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4vyYjn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=;
	b=xNDFQkiZE+Dv1RhqzJQywe6KvzDs/rv1vZgeCVVfwV8WXhYUz8gRG3Lgu2oYORtCZ0xU
	 eKK4MC9k7e6zCg5CcWceb9V2FKHbrkMd5wwtXFx5qJS40B/HpkPbI5apq/ad0NKHsN9V3
	 u/M8Y5EueSUFCz3Z/w7tfQs62WLdt+002IV7zJYKjDG/d7RmbTV7/x/7GnooRkucRDMRb
	 kk2yQj7NRFSUHoV+yx069EwCvGM4ZRLUjmadhC7dTMPoc7HWENSruQrcr3Zkzjzmzrui3
	 LwvQ8S9Rppa1I8tM9met9mg5fSyhrURq11gQhdam4S7uV6XpFf5W3VK8Y6345i+bHug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=X90VZJBR;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=OqjQShhK;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B66606A895
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5B66606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=X90VZJBR;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=OqjQShhK
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLZ2wO1009830
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=4vyY
	jn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=; b=X90VZJBRvXvcQtWvtSML
	cYnBp83zg3R4X+C8UXFrR/0ste+aFkHEr5U77ylXLx4BUEcLYtTW6B1yLY5tikag
	7hbIrco84ujOdJmB2/epEniEGsLrXYXe1ogsWavEfw24C3fPqOCdzA4WKEAhAoyl
	W+BiUtmuvDa6x3vhdpUGfQ5zewpasoXg2DTVzpK9IPd5mjYO/hG+kBfhrQrDAV0h
	TUtAwtC3EWjhSAGNAofYPlS0P3Hgb+oa8+ffNiiYvUKtYpZ8PZri4s2OAy1x1STh
	BOsI2Jk34RJ5O2MDTpfuwmsMD70Zy63yJ+SR5N0pc/kQZMhE9m5dnWGWEc5XOo47
	cw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059qudej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:27:16 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91ef0fe2914so27189236d6.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794868036; x=1795472836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vyYjn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=;
        b=OqjQShhKdsOzCEp9sDHRO07pMjPNWkhEsx5D9hKW4kZheIOMb36jRTMc0L6Bqe//Ix
         iftZ7ACLorkN1cC+x3lModR96EeXDIMQmNlssDAivIm7xwEBJRBakvSxealfGnpLw8yA
         jpC/fUhORfKNP5xoxMVYgTjOZLcMGEqNvHSb09jtOP3J367nOTh8rVAT+/ggq0642FSb
         Tg+VZvLepva5YrgLaXV/zDo2CURzn3tBpMki+mjgjQxqkRRj5XT9zYQBCBr4DCmr2I4f
         rnEclJLdHDRCXy2OxQtXvH8bW2+p4neBZc2SIFa/BN5OS9ElMNZLdlIKoXBSlHk10bKF
         0Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868036; x=1795472836;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vyYjn5UPo/7vDc4ZQ9k3Cq0mbqo2jzpmjoiYSVxIwk=;
        b=Y80JXeQHkeLg6JLaEzVLkeiNKUnB8QnUgLz0wwFVpCcxeBTbWTnjN7Y1w1sl8TiO6t
         CXLaexoTzyZlrfOnUfImfeh6hSa9Z8evAOtPdIqZtRohmTH89WpXUErorKmtuWtydu/0
         BVCrxqJuaQ0IhbTX7laQx35SYfaG533LUAuCHwpF/9nY9GToHaSdwXCUdmGbt5fwP3jy
         p/pjoLXfu99e2ZFXMnEwziAVRu0Tp9I0UCKV9RbBlRquZur5ZlxIBdSW1k3ACOH+c3t6
         WJd0gu2CUrfQdBlYcR/x5g/8rKRljVMoFPSgbA7JlbyN7YrH614RJ3S4169C/SfBH4cD
         Jslg==
X-Forwarded-Encrypted: i=1; AL+hErGYCWE+JHbRwyvmynvCkoPevfNjCtRvmWUzAGHglKv4+j09m0qGO6iWD9P6rQ59T1q6+is932U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1NIYGdPFkj8ckZAeSkEtVtjaLk39AviejVmLYzomLXPLZywli
	vyhvdFv9B/XJgfiCamDiEJ5PmSQmhzSshl4AetuTW45aGbi+brePrJwPY+DxwVLrx/oWhzABcHH
	H95h66mRrCs23lNhqiaJ63V/Rj7Vi3XrdWJyWc1g4UrV1zWo/3/6Ziw==
X-Gm-Gg: AYBFou2xBaiq/0hl02FrCgAXray5XHqBcusLLGRYtdpMtFDCddstHQeiWTKTI1w1vJ9
	Ksu4R1OpZ8wocQEO7N0mqZPSMMCfdQdEtxRaFn6hX3K7QBq171RcWI3IwiL9CFMbhtTh/2WurvD
	hTbPUxP8dsjUDxsKD8ub+7tE8bK37RNhZiAorSW+UpQ39LXxogO8Brjvvc9e840d0jyTgTn1zwl
	rmZF1yGsRp9+7YOTVnWNK0yjJljoJaTON/YeVM6a8Zr3fzLADvPnJuTtp7i8R9WNj/UdUzg9I7E
	kt9w34VT4AnEsSsyMhJ7Uvzi5poutD1/MHZVq/K5GG6wbvb/cYeq1NN0tLejo6zk12co6HeVkaI
	uKQwYFIOmJOXmOrCM4I5Iekv1YAKiEfNTHQ6o1p4DFKFgtJNqJ06mS0jcHAbOoWknoNgKq/YQPd
	VeQwaPcFdfVWBMo/+cLHp1F5da
X-Received: by 2002:a05:622a:4188:b0:55d:34d4:12f1 with SMTP id d75a77b69052e-55d34d41f99mr93205861cf.34.1794868035999;
        Mon, 16 Nov 2026 14:27:15 -0800 (PST)
X-Received: by 2002:a05:622a:4188:b0:55d:34d4:12f1 with SMTP id d75a77b69052e-55d34d41f99mr93205151cf.34.1794868035325;
        Mon, 16 Nov 2026 14:27:15 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55c3b7a4adbsm66513611cf.19.2026.11.16.14.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 14:27:14 -0800 (PST)
Message-ID: <eba4fb71-6baa-455f-8899-87567af898aa@columbia.edu>
Date: Mon, 16 Nov 2026 17:27:13 -0500
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
Subject: Re: [PATCH v2 1/9] userfaultfd: use anonymous memory for
 UFFDIO_ZEROPAGE on private file mappings
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
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
 <20261116-uffd-state-fixes-v2-1-4397a0196479@columbia.edu>
 <cc865bc8-b96f-4385-97b1-976de4465ca1@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <cc865bc8-b96f-4385-97b1-976de4465ca1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=L/qI0OT8 c=1 sm=1 tr=0 ts=6afb8344 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=U30RilsMMHCo0eZBjZ0A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: yVSY3CZhTz35fT6Qadhr3Sv8cAFHeYLy
X-Proofpoint-ORIG-GUID: yVSY3CZhTz35fT6Qadhr3Sv8cAFHeYLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OSBTYWx0ZWRfXzYIVnJeXVMVz
 vx3B4j8Oc5qQoHhJsvix+J8kXFrpWXGBsVMuqPYUh75XGiWkLPbvtGL0O9YD2eNpIKV+knPKJqE
 AVY8cK9B2pT6AuK2OssDEWLlKUcsU390PiLEJ6ycVbC/WGe2hLyBuvXA/E4HKMYnfiRbRpugZuG
 QtFAowkeDLXtP+QMWYpM7wqX3qJU3RR2WiPyMoEILOxQrfSRd2tu9NMJHYOZZuzcSSzp1FBdNdo
 1t1qy6o8BBnxkGU6UojiSFApUamkcb2UMvthuvRW4YMmgMPof5cJWH5Sv0oOsbvWAXx9MNRtkNq
 rKNjgbikT9IK8J9huX18NLDgnpVvRq434zBbsE2mUzpgK5lynWaciobOS7MvQF3a4pR2ADxd6bb
 lXweK24J5o5iYbuQbqQPVwP2M3SZjEAJdz1I2i9XbgtFyQqNIBn1UIX/UOta2z9TsuQ6L8upmZV
 Yy+BOE4hia1GTRXVNFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OSBTYWx0ZWRfX2qyE8YUo/9rJ
 kWYNSBQ1AnHuevJzY9eI4ZSTB3j29iSHkIBdm4ULWjAnc4imON78upewNU9TkYSrzT2aESG+sWK
 hbnX8eGvvBwd9bkuGQM3AIiua8VD6u+YgA8rd0uj0rMcrnYv/1oL
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=10 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160089

On 11/16/26 3:16 PM, David Hildenbrand (Arm) wrote:
> On 11/16/26 21:02, Tal Zussman wrote:
>> If the mm cannot map the shared zero page, UFFDIO_ZEROPAGE falls back to
>> mfill_atomic_pte_zeroed_folio(), which allocates a zeroed folio and
>> installs it through vma_uffd_ops(), no matter what kind of mapping it
>> is. An s390 KVM guest with storage keys or protected virtualization is
>> such an mm.
>> 
>> For a MAP_PRIVATE shmem mapping, that adds the zeroed folio to the page
>> cache of the file. That is wrong: a private mapping must never modify
>> the file it maps, and the file might even be mapped from a read-only fd.
>> 
>> The ioctl can also fail where it should succeed. A missing fault is only
>> delivered for a hole in the file, but UFFDIO_ZEROPAGE can be called on
>> an address that did not fault, or can race with a write to the file. If
>> the file has a page at that offset by then, inserting the zeroed folio
>> fails and the ioctl returns -EEXIST although nothing is mapped at the
>> destination address.
>> 
>> What we want is what UFFDIO_ZEROPAGE does on a private mapping when the
>> shared zero page can be used, and what UFFDIO_COPY does: only check that
>> nothing is mapped at the destination address, map zeroed memory there,
>> and leave the page cache alone. The zeroed folio path did that before it
>> was moved to vm_uffd_ops.
>> 
>> To fix it, pick the ops in the common folio path, as
>> mfill_atomic_pte_copy() did for UFFDIO_COPY: anon_uffd_ops for a private
>> mapping, the ops of the VMA otherwise. That makes
>> mfill_atomic_pte_copy() and mfill_atomic_pte_zeroed_folio() redundant,
>> so remove them and rename __mfill_atomic_pte() to
>> mfill_atomic_pte_folio().
>> 
>> UFFDIO_ZEROPAGE no longer modifies the file, and only fails with -EEXIST
>> if something is already mapped at the destination address.
>> 
>> Fixes: f74991b4e383 ("shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops")
>> Cc: stable@vger.kernel.org
>> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  mm/userfaultfd.c | 46 ++++++++++++++++------------------------------
>>  1 file changed, 16 insertions(+), 30 deletions(-)
>> 
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index d65184d9a480..61a712e1f9f5 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -531,15 +531,27 @@ static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
>>  	return 0;
>>  }
>>  
>> -static int __mfill_atomic_pte(struct mfill_state *state,
>> -			      const struct vm_uffd_ops *ops)
>> +static int mfill_atomic_pte_folio(struct mfill_state *state)
>>  {
>> +	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
>>  	unsigned long dst_addr = state->dst_addr;
>>  	unsigned long src_addr = state->src_addr;
>>  	uffd_flags_t flags = state->flags;
>>  	struct folio *folio;
>>  	int ret;
>>  
>> +	/*
>> +	 * The normal page fault path for a MAP_PRIVATE mapping in a
>> +	 * file-backed VMA will invoke the fault, fill the hole in the file and
>> +	 * COW it right away. The result generates plain anonymous memory.
>> +	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
>> +	 * generate anonymous memory directly without actually filling the
>> +	 * hole. For the MAP_PRIVATE case the robustness check only happens in
>> +	 * the pagetable (to verify it's still none) and not in the page cache.
>> +	 */
>> +	if (!(state->vma->vm_flags & VM_SHARED))
>> +		ops = &anon_uffd_ops;
> 
> Oh, but one comment: why not check for actual cow mappings?
> 
> 	vma_is_cow_mapping()
> 
> is your friend :)
> 

Probably because I didn't know about it :)

This is already equivalent since uffd registration rejects VMAs without
VM_MAYWRITE, but I can switch it over for consistency.

> -- 
> Cheers,
> 
> David
> 

