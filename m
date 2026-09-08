Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01027583ADF;
	Tue,  8 Sep 2026 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885243; cv=none; b=Ewus4xq1oYq8sw3Ep/I8zsNGBCBLvIHlhzQMgj8d7CgJTDun3AyM4DK6+Sz3U+m8BMfep6lKKU8VY3U4f62QM9m9a440y49IWv+diMbyiT2Kom3u+s9Ro9KJnEhCukNIgQ8M1Vmoi5wzjo2+w9Qmxdq8z2zk/PaZGvH/KyPeVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885243; c=relaxed/simple;
	bh=ozkAqPjGasSDM1LJnuJbeQcTTla5ZbRtl1dopL15zao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqdtOp/09W1HUhR9zN973EYkgVzT0n1J+Kqq0dRsoK4n2mncsWAgXUN00CVgcYwTacUF0HuB4DxnPZ5PRKQq3oMLZRMiFTxEmrR74B6HyW6Kzb7EPMxFjk71mDwys6XOar8DWDztESU/o0urn3S65ZC4iJwzUw7jKpLbcChqpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rU8xl68u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rU8xl68u"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1dpQ1268532;
	Tue, 8 Sep 2026 16:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fzE7CW
	BM6+t6y+9lndB3AQIYRRPQjODqWVfx4fSGiAY=; b=rU8xl68utzSTCvSnrbQJxX
	Jmw/alIAGgtY/mcMCWZjQITvRtO06Sd0cynMqKSqbnTXf2oBq0n3IkWkup6UWaBp
	rh1X9DaJgRwkDnukNiLnR8HjUtNpZ5l5rujei8zJp+/3im+xJdGpT14noZASWyvp
	Ow80glWGyjBLXLebSVc6mbz6TYuDQnTLCqB0zfQKFtRaT+gK2wsogBkg6t36RhHV
	y779nIAIdgG86Gsq5nGBKzj9rZJNzr/NdOGolNpRpSOzMzf/ITo/Lf5SVQBLh/wV
	W3CmO0cvZPgfEO2LZ2hHOu+11bcsKxzu6t7hl4lb3IghVsLHnMJ2C0GpTG771kcg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf05n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:33:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQFgS012026;
	Tue, 8 Sep 2026 16:33:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgcwdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:33:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GXanN53477660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:33:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5947820043;
	Tue,  8 Sep 2026 16:33:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B8820040;
	Tue,  8 Sep 2026 16:33:30 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:33:29 +0000 (GMT)
Message-ID: <9e88af75-52bd-4da3-9745-498238887551@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:03:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/8] selftests/bpf: Enable verifier selftest for
 powerpc64
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <74497c6a5a1abe5cc37780fe91aac8d42e266e46.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <74497c6a5a1abe5cc37780fe91aac8d42e266e46.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YEn-kMJKZAcObYHbEdzD8sO4oq4xLvxV
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa038e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=1BW1YgVLUHBJ7L-aX4oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX64B/A55bKoeK
 voSvyqMqNl9H1DdJPWmtcHoknlYTxIYaZzb6rBimvU3TwRyJ/Y0vyI3Ds6q5mcRYrFHxt7Z7zH8
 EoCmhewINKL27zfxvOTvVYaaGJwR9I8=
X-Proofpoint-ORIG-GUID: YEn-kMJKZAcObYHbEdzD8sO4oq4xLvxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX3NfRt8R+e+Ws
 ttakpLpGNEsixRwXT025egzCllIpWriRjadwTPjjlAqguverm9RYbNyoWHTc6ltWoDKVQ4Kb0gF
 p8vm8RXufMv2rrJT7M8Q8SbWHXx6qwHC4zhlgWzxlLoN1CpswiwzY9zoxKHsGrR41PT1pEYbVcm
 KYDxO+j887VfO9BY/9GxUSNZSOwlVH9C7Kcd3a4xKNlhVw33x3scXz4IWstpH4cEalN/Yqx710E
 5/zSHvUVGRDxoLTMX6qVR6RNhXLJ36N7CRo/3DrlGTJ9fZpL1DtrXAASpN7L5+8WA8TQ4R46Q5C
 Fa6xStfYsUGg/kOLVqvTbDwb6TV+CTajkBi2U2a6srWr8XT0NDpC2gysVEkF5TYMukUZv7vKoH5
 wWB4qHGqaQh1UY7kTqk5K+BslJi2DEdo1OnPHzXx097b5nrnNGnMHylZJ5OSdf5lIWeXXjAfnfj
 DYztOqS+szaYJ5AAxuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:46 PM, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
>
> Enable "__arch_powerpc64" specifier in verifier selftest
> for ppc64. Power 32-bit would require separate handling.
> Changes tested for 64-bit only.
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
>   tools/testing/selftests/bpf/test_loader.c    | 5 +++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index b0c441384f20..365008d1ed40 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -159,6 +159,7 @@
>   #define __arch_riscv64		__arch("RISCV64")
>   #define __arch_s390x		__arch("s390x")
>   #define __arch_loongarch	__arch("LOONGARCH")
> +#define __arch_powerpc64	__arch("POWERPC64")
>   #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
>   #define __load_if_JITed()	__test_tag("load_mode=jited")
>   #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 3ce32d134e2c..01b1420097d2 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -378,6 +378,7 @@ enum arch {
>   	ARCH_RISCV64	= 0x8,
>   	ARCH_S390X	= 0x10,
>   	ARCH_LOONGARCH	= 0x20,
> +	ARCH_POWERPC64	= 0x40,
>   };
>   
>   static int get_current_arch(void)
> @@ -392,6 +393,8 @@ static int get_current_arch(void)
>   	return ARCH_S390X;
>   #elif defined(__loongarch__)
>   	return ARCH_LOONGARCH;
> +#elif defined(__powerpc64__)
> +	return ARCH_POWERPC64;
>   #endif
>   	return ARCH_UNKNOWN;
>   }
> @@ -585,6 +588,8 @@ static int parse_test_spec(struct test_loader *tester,
>   				arch = ARCH_S390X;
>   			} else if (strcmp(val, "LOONGARCH") == 0) {
>   				arch = ARCH_LOONGARCH;
> +			} else if (strcmp(val, "POWERPC64") == 0) {
> +				arch = ARCH_POWERPC64;
>   			} else {
>   				PRINT_FAIL("bad arch spec: '%s'\n", val);
>   				err = -EINVAL;

-- 
Thanks and Regards
R.Nageswara Sastry

