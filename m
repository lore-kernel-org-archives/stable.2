Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449392;
	b=R9U4kzNLvWKBy+QY5ifWwAqIzBPIkNLKJKe3eogoYzwVmuH42jv4meFJKB0flgJ2MGih
	 d2sViiosgeS7QhHh6Hi0EJYpH1x0dFSfJ1NMvnqvRm+Cra5Pl/o1FU40xG4LCjELTLkiQ
	 9vpdGy+SQv8PDrsR5oOMVe9O+JApMw0wnrJ4IWN1iGM73JHXDkjVuKRD9bqhSXzZQIRY8
	 AsJwCibh4gl5C26nQVbW9o/+zpccHAl2BmhhXUT1PGJK7PfB7h2UPo/4CcwaZZ93rXASi
	 sIrzr5Td6cWKsIvVfepr7bwJT5ZXsAGvrSjKIgasLT5YhXFA90XndJMcxpG3u2mZQsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1iu8dF8wc/98Y/bB5y3HpkLA11uus7KR1dgFqBlOtqg=;
	b=2DUFg6iCMcF1HYZZE6uMSq0/6YXtr5yyxjx6qfhRzJAdibh4++AT57ubxm1DZWmt4iDx
	 PjOQnFidkO74SVtZ6xgF9RHysYjWOpVXwRAUcyuRuRl7In5EVLPv3WnyyQ3mI90IWv4SC
	 o2P7kVcywI9rolAC5P/dzL5PUMWi6ryl7E7KoPVjyO77Hcf/tmXMg3Srvvpm62rrwTHY/
	 FQ3nf/tBxS0AIjVIttuThsmqmLX5Pp0VTkXECnRXONSyaMsVkHm2Dmmcu1bPuUJgQK8lH
	 LIIp+NTz3cSsVz2+STBkHpnWYu25mo2jKgOsCIgq80ZZUayh6ANFDCfHCNw9EujohqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WjfqQPsr;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969B606A321;
	Thu, 12 Nov 2026 02:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E969B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WjfqQPsr
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMidDa2306352;
	Thu, 12 Nov 2026 02:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1iu8dF
	8wc/98Y/bB5y3HpkLA11uus7KR1dgFqBlOtqg=; b=WjfqQPsrJyttWPRWNrMUqd
	Ar6ImBZJyTwnpXHg07B1wAutdP5g5i1cCQh9b972m2a1rKoKb88QwdB1oV0ATXFA
	k7hSna1FMbmuFphRC0asqiWyi3haF/gGJLNWsfeSSGOJbfpNTJ80mAkPOZ6PNGJq
	LyGMPG5x5O7UAJJkB2xsMGwZNK0N7KIMFZu0F0j4esre201vGXqQ4JjrUiUQDxNg
	+NNAdMcklKrU74/vU2DaTvU3LS4OqaGtXgi9s3CfAtqg2udoZtnw1PfjfhkZmpAf
	SGiRlaTK0xF3If4ERe0tF1qvX0Wcp6C6GiNimEK+dAIDD87yEupHAhC7C8rb94JQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkw2a2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 02:08:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABMZlqY2884944;
	Thu, 12 Nov 2026 02:08:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51vpd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 02:08:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC28lVL33817184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 02:08:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4723058055;
	Thu, 12 Nov 2026 02:08:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0676F58054;
	Thu, 12 Nov 2026 02:08:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.115.82])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 02:08:45 +0000 (GMT)
Message-ID: <0d1363e419054c1aa1b0bfee645314c7e4aec0f5.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix kexec measurement buffer overflow after
 failed loads
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin
 <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Roberto
 Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 21:07:59 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af51fb1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=9NJ1M8o-uok3-83kKqgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwNiBTYWx0ZWRfX4PiV+UtruZPo
 HVVm29HJvtepzmSkRwBT81qxIVou1aGN0e8cmdE4sks5EFwnEzQlf7UY+S/GQfY89oVcb3Z4NEQ
 3k5s9PvffczKuxADmU6/xN9c+Ts9jlN1HReMxsDpMPqRcc6Y7LTn8Olm1ea2KffdRetYpZ4+Cgj
 oVurO4oXvUs9Q4Ps9kjRHqxSfxV0nn8LNG31IhfATVgtS0eTqw/PUsZGk9qDmQzJkZu4GqwiDS2
 sZtoj9L7rAhwifPg8wmeWruHXVZN9jkEYypDH5UB7xlutnEL8tyv2IW7XJ2cXUoHybABT2w8nmV
 Ygs75f0uwrvlTp91mvKvItpwnODxltIN6ZCXPfr8cL2SPj6dKuzozX9SYwvm7l3utYmYHOuZNVx
 rJFy1lNJUVOVp/49li1Cabk27iUpKATwoRr9E6XxS4x8tHy6H9tmnnSgVDQGnB+MVctnFFhukkh
 JOoVNyoKs+pqWmQg03g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwNiBTYWx0ZWRfX//pdLJv3QyHV
 A+SuMYssSsUozeEaJHaUFTaJ8ZIT9K2HazL4B1RPjzRfTXUxD/cmfIIblHUGQbhAAJwK2BR1Iu4
 CDjJAiKyTiqMQvErxoXKsqTJqSSKahA=
X-Proofpoint-ORIG-GUID: znoC92lzsjFKVvDY35sb_RwZQDwVlJ1E
X-Proofpoint-GUID: LV_6VWisdAf53i-Jlzcok5QIWpn60s9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120006

On Sun, 2026-11-08 at 19:04 +0000, J=C3=A9r=C3=A9my Jean wrote:
> When kexec_file_load() fails to install a new image, it can leave the
> global IMA scratch buffer larger than the IMA segment of the current
> image. When that image is executed, ima_update_kexec_buffer() copies
> the larger log past the end of its reserved segment. In a test, KASAN
> reports it as:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x28=
0
>   Write of size 868426 at addr ffffc9000004e000 by task init/1
>   ...
>   Call Trace:
>    ...
>    __asan_memcpy+0x3b/0x60
>    ima_update_kexec_buffer+0x265/0x280
>    ...
>    blocking_notifier_call_chain+0x88/0xb0
>    kernel_restart_prepare+0x18/0x40
>    kernel_kexec+0xe4/0x130
>=20
> Limit the dump to the smaller value between the scratch size and the
> installed image segment size. Update the IMA mapping only after
> machine_kexec_post_load() succeeds.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Thank you for the report. I agree with Mike that the machine_kexec_post_loa=
d()
reordering should be a separate patch.

For the overflow, rather than clamping at execute time, how about not chang=
ing
ima_kexec_file.size for an image that isn't installed?

  1. Set ima_kexec_file.size only in ima_kexec_post_load(), from
     image->ima_buffer_size, and stop ima_free_kexec_file_buf() from
     resetting it.

  2. Reuse the buffer if size >=3D segment_size, instead of only if they
     are equal, so the buffer is never smaller than size. The buffer no
     longer tracks size, and with staging the list can shrink.

Please don't remove the "segment size can't change between kexec load and
execute" comments. They are still correct.

Mimi
