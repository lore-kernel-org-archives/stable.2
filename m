Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509817;
	b=hiNvckAEdP1G2cDaOFcOVuzNK8WBD2L4pxMNH5XTL/FW6UkXLjPSSJqpFm3fvL4owJLH
	 W8u7PfqdvaYrLEfIEKohsLdT2UkLy6U9jx0IDYVfbn7PAbj/a3QsqGbcCbTvUhYQ4zHmn
	 69XxfwGlbJlj6SkFxDb+sJAaJGjVn7ywPB5f/bwXdPNSaxHfeK8MSW+JB0S6UXohbFiEB
	 a1maCyJw+mwXrnK7y4R85FCwZnQuc2FNwTYWa/Ht4+KsnjNw92dAnOkfwS/fspwbn3Vn+
	 XBYqWPZiijyYbWz8edlaCpYYLxcitru86jbtwIU9ekzq9Ai3HV1wfDSI+hIUVs1UmQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509817;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=21TKgW0K5jj6gPfdA/HfsQSmThGTrU/SrwtxeoW1Kw8=;
	b=Lc5KfrP9IF0aT6YNjqKhXPiNLv7KMMypKiTDKY4aDjcS9uX0ZPgvJi9sGJyCBWMy0Wxz
	 xJCjhJrMIukWOfoaIZrYbHHyJGi9EnVwmyLcqJGtwR8tZ1ZOdLKjvnKHhyJKYoFkYz6r1
	 og5z33nlt1SAVTxosrq7CaTGx61i6r1f+4T5tcQvGhVuP3IIccHixKTo7Psok0Gg0cUKO
	 hnSVdTkJI6q2XyTB+xR5qw4+5Px0FidE3EDXpejEdSPRfXkJEA6jJsek8J4SxfHMspztn
	 9jy84jRAcw932s7Zm1n6Onxq/1jzd6jhao00NCWvI4YDQ4MpSloyyor2/5Woq3o4/ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QFvgJkmo;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D253606A326;
	Tue, 24 Nov 2026 08:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D253606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QFvgJkmo
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO34mGk1412604;
	Tue, 24 Nov 2026 08:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=21TKgW
	0K5jj6gPfdA/HfsQSmThGTrU/SrwtxeoW1Kw8=; b=QFvgJkmoQperorJhQoXt/M
	tInTxbM0op4umEjumKTF2Sxgoj3C7Wx+NxNw0FwCk44x8+/zvD9qF8wG7BhopRNb
	kfg9reC8JtYiGswymmpBuFq4r63Ig9uAQhGL9084S9fWrxCVnF7krUOJDaW/8wwn
	K7kb+b+Z0f1+4sEKa+2/VOPI2ap4GQ+EGV+lgYm5m+pqS+GTMZ2SfUpaVh3ftBjX
	g31jQV33DYwI5TmzVd51aaL00qAtmFX3cEoOW7yimcT48OsT5Lbq7ldNZUqi/QYz
	Xr7e8JE/LFFJWoxDZYEUfJ9w66njh8IiqDDAXgFI+S6+97V+QHZ7KrTU1wzZ4KgA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa6v7m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:42:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8di4w2086934;
	Tue, 24 Nov 2026 08:42:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vj1p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:42:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO8gEbE15925834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 08:42:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70A2F58052;
	Tue, 24 Nov 2026 08:42:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B090F58050;
	Tue, 24 Nov 2026 08:42:01 +0000 (GMT)
Received: from [9.43.57.13] (unknown [9.43.57.13])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 08:42:01 +0000 (GMT)
Message-ID: <a4b839a8-b710-4dc7-8b48-847d0526070b@linux.ibm.com>
Date: Tue, 24 Nov 2026 14:11:59 +0530
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
Subject: Re: [PATCH v2 3/4] powerpc/spufs: consider vm_pgoff in
 spufs_mem_mmap_access()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin
 <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Rik van Riel <riel@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
 <20261122-access_shite-v2-3-808d8d2aa700@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20261122-access_shite-v2-3-808d8d2aa700@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfX83QlkRE/0mbR
 rSbqFVtgR0hZ7p7222GUVWClMGUQMQp177LOEKllQdCkGG4PmVzEaDJqym9zfZi8w906ss6ZEZq
 O7kwesKNucqAnGYQhXNruSUskMWo5Mu5QIEUFc5aTfLTHixAql3u/NK/AxKy87d5I90/B+bePMp
 va9G2OkkDKI3colkcgsG7m7NHbkDnFjKQMnnNaaECNkH+0ppr9BJZiEi8XyfAG7wo22XVByCfz6
 lxwvlHhJ6j7L4V0DJNufFmlwV6SmR9rADlacAfYMlI5rcgqfjaIfGOYfiUSVcMBeHoAInfk+4yV
 ddl5+A2snQxmZkBU46/Z9SqhF+ThRn71MkYqILS55qnRaW+a4IU8sakm6IGidXe9s02ctPb7dIz
 CJkri276R3EvFi7LQhRxQFpI5VSuqQ7tVGHTaFRJiArBT0fUGQ362waZxE/pETEwvqPbvMDdkC3
 O6zlXsfGgP6v4xMLZsA==
X-Proofpoint-ORIG-GUID: rQbUKh4nIiE8IXo8G5N8XMBLAUi8qg9T
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b054de9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=J0W00IkS15A3C8My_cQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wYVClD_dI4O0Mxc2R867DqpheE8clw8Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfX/JRXOzmPmam+
 wVJRsZSa1X8Rw8FTMHaGZ5FUkSM4ElkoYrscS5eX7fc+0HpJl3beTU7+ONmTkA7vNBvunwh2u6s
 3vIhhaEf7Dg1wq6W7uNEBvI7VoCH5bk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240033


On 11/22/26 11:25 PM, David Hildenbrand (Arm) wrote:
> spufs_mem_mmap_access() calculates the local store offset relative to the
> start of the VMA and ignores vm_pgoff. After VMA splits, debugger reads and
> writes access the wrong part of the local store. Mappings created with a
> nonzero file offset have the same problem.
>
> Properly take the vm_pgoff into account, just like spufs_mem_mmap_fault()
> already does.
minor nit:

subject can be
"powerpc/spufs: Fix local store offset calculation in 
spufs_mem_mmap_access()"

rest looks fine to me.
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> Fixes: a352894d0705 ("spufs: use new vm_ops->access to allow local state access from gdb")
> Cc: stable@vger.kernel.org
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>   arch/powerpc/platforms/cell/spufs/file.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
> index 98c47bafaf678..0a46d6f7178ab 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -248,7 +248,8 @@ static int spufs_mem_mmap_access(struct vm_area_struct *vma,
>   				void *buf, int len, int write)
>   {
>   	struct spu_context *ctx = vma->vm_file->private_data;
> -	unsigned long offset = address - vma->vm_start;
> +	unsigned long offset = address - vma->vm_start +
> +			       (vma->vm_pgoff << PAGE_SHIFT);
>   	char *local_store;
>   
>   	if (write

>   && !(vma->vm_flags & VM_WRITE))
>
