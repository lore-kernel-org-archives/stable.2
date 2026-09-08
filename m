Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BA572693;
	Tue,  8 Sep 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885119; cv=none; b=Quva0287LBh6GUnQm5BTlA9nkApIyQffBijPDQ9XY8rb+Dar8hxU+r8jeXKsAeNRNXdQOKx42/5BDDyYnzNKG/HNpJpwIPzj3bKetBsqaLP5pm4nRKUW1tDFxMZmZUeg8SaLhz7OzpNc47EEnpoD3N67icfuU9NVoVjb7/OyPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885119; c=relaxed/simple;
	bh=m2toDxNwd9flAMZjtVqRU/Bb7LRkL0j7gDzyRBnauQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpNlPGP5yDeGxj6yY1yeHVfxw3LBTPZ0WWKHA51XyQOfdfX7vI+qkwuyjVkJ5iIVYzETSfB4+FotduRffoBy6scnsRDUTT2gBMlgop2TkNjw1ragHs9GcS9WOMtzfBHk3dqYVPM0UWQsYn0kmF8ClunG9yPGVppPJYVNWNocyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o9P9LUPY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o9P9LUPY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1VhG1094382;
	Tue, 8 Sep 2026 16:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+lLAxJ
	EgDfz0IHluMf+QRQOiiEIZIavb79C9YQ/JbZA=; b=o9P9LUPYMEcoJX/6FeMB7u
	LB6XON39XmaluxwKQNZ34c23LBhhw4xbvNDw5tmnL90ckGsCHuYXiXjD0OeI/pcZ
	+ALf8xCnFRLYj1UllWPsy3knqFGvY1snp1iqP6AtbqD/o0ifWbgqR9DOvuAFZA9j
	AxexOQ5ucHxhRtca0Lv6OucCGcAb/1lUdbWgjVB/yc55UMfEUsDPk+wgNfQshMqn
	70lHeU/0TBHOA37edMkUaq+hL/vjwrb0y9o/+QJm5upu9b7nwSM+pxAump9fVnIe
	Eg405ZPNJtdXRT4OBpOAtnROxTGD7QsVk5RPSkjL5e3NQnFHGc86VymGlT6ZWPYw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj884u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:31:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQEdD031283;
	Tue, 8 Sep 2026 16:31:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw55yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:31:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GVUrY52101438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:31:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E926D20043;
	Tue,  8 Sep 2026 16:31:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44D2420040;
	Tue,  8 Sep 2026 16:31:24 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:31:23 +0000 (GMT)
Message-ID: <ffecf223-fe43-462c-9f20-4128f762c90e@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:01:20 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/8] powerpc64/bpf: fix percpu private stack leak on
 JIT failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U9mP4fZrS65La30m8mF5DMZS24Q_PM7J
X-Proofpoint-ORIG-GUID: U9mP4fZrS65La30m8mF5DMZS24Q_PM7J
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa03866 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SG3J2fsUutJ-UIamL3IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX18mwzR+Ck01x
 1nEFes6YQPBasCZK+0GMnprA7KQwtxYK9B5dBBV+fjyj+0qq6CiC4HSUgNrsKSCUYlKWI6cnysO
 5CsmanrKlNqu9ZeASxck5YPLuXpg4gc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX4HeuRJTI1Jji
 yPg6fcif8Huw0vBVewB0j8xNbILM0ISRLmsCDbbRwzzpvg7B9WSLDP/pEUbI7ZDt2zSJgIawDzh
 O5W0xUP4i1XwhEzafNf+BbtzaCJIyoDH00J7ZxJIt6Ky37nHlua9VhCTuDug7ALMbHAHgqJNcAF
 8WSNKRC57+LfJj/7ZbmnHrgIEHSa9ZvlVaREPX1CTZ0yenKB0Gsdp37UTu/Gz2TE5X3TGJGHn87
 3jAljva0rg3mMcEqJk91IjAvbxyOikoCVF5c0x5mlk1FmqgfCLMgSq9DWa3LoE/opG87igQyK7D
 DbB9N1tiWr5E+K/Xp/6azEqNas9ifYA2PPjG1BzGbUOv4nKlm/69qjF3cKS+BFhtHVjsxcoqCXI
 DuXNGNom7CJBBt2vpb1w8zW5xtj4Dy4pLRJtl6Bsc9b1jjWCyKaIzTagn6YPlweHT1vQFeRPYyp
 evJYMYQZ/eQ7S20AzeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:45 PM, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
>
> The existing conditional statement in bpf_int_jit_compile() frees the
> percpu private stack at out_addrs only when the image buffer was never
> allocated.
>
> If bpf_jit_build_body() fails during a code-generation pass, the
> image buffer has already been allocated, so !image is false and the
> percpu stack is not freed.
>
> Because JIT compilation failed, fp->jited remains at 0. The subsequent
> bpf_jit_free() path only frees priv_stack_ptr when fp->jited is set, so
> freeing is skipped here too, leaking the percpu allocation.
>
> Fix implements freeing the private stack whenever fp->jited was not set,
> i.e. compilation did not succeed, instead of keying off !image. !fp->jited
> already covers the !image case, since image is only NULL on early-failure
> paths where fp->jited is likewise 0.
>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel.org
> Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index a875521ff904..8f7501954d9f 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -357,7 +357,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   				(void *)fimage + FUNCTION_DESCR_SIZE);
>   
>   out_addrs:
> -		if (!image && priv_stack_ptr) {
> +		if (!fp->jited && priv_stack_ptr) {
>   			fp->aux->priv_stack_ptr = NULL;
>   			free_percpu(priv_stack_ptr);
>   		}

-- 
Thanks and Regards
R.Nageswara Sastry

