Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD6136351;
	Sat, 13 Jun 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354959; cv=none; b=Fo2T2RuZa1kWwtq9uGyWbXQboJVDoS4HOqy6W4dRyo1OrJMLXeDAOR1oBk+9oQEriVQAKPvFMDjazEKmhe/CQdcS2NwtCdbhCx/8sm30+DkSg6Ea1LDGc+JWzQ2M0zFlItSHMkfWZ3/yI8uqgKz4MQMduxXpmp1LHg+RvV6VB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354959; c=relaxed/simple;
	bh=q/XwynGT8GH0L771RBDMZka+i5feFkj0Mdu0afgv1Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d77kQ2zOUY3it8UUL6xH39BVg8dCE7i4TskJwR0dgcIJm+OdR4uNEzrb4WS5TivTLZwZcpTD/QgzXPLCJP8HtodLfS5FfcY7Kuwd11/irocDWxw2QNQiBFtXTbXBoWQs5xbEegMEG1xykzTly2WHCgg5FIfGrIbiKTqPIRLUYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NTsNM86l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NTsNM86l"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBIb0b596718;
	Sat, 13 Jun 2026 12:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hLHStC
	VWrOOTfNcvUH5pjn9Lz2VtviDgQgAnmcQa6yM=; b=NTsNM86lytCt+5Jwc/yNFy
	+KGmVoYHar/m48/K/T5B+wQfXUtyoZmlKF412ireuFotG5VtFOpRSR027aMp5Eoc
	ZtMeCKdtDi+2VDqrQ50jKrZJaQVkdPXUXQyG4R+unzjhb7D5mFT76mFB0rkUpLDZ
	GWKSdpxuOIYx8gBm4mTzU4JbGh8xpqiM53Ef5BNQ/+iB0OH/SQPV0KwuGYFNR2/u
	qUyTIzqUxtbJyppEoH6bFrEVl6LrlN7F6smfkduiKLUk+2WIXw1LCMHJ1PZAcM5B
	DQAmtGC8kHEKI9AcXJ4iBqiBxY7OTV4FQQEz+5EqT9h3JjkD0BMaqkZPeLPVCjjA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkrqty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:49:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65DCYfHR014798;
	Sat, 13 Jun 2026 12:49:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09v0a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:49:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65DCmvch56361244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jun 2026 12:48:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1099620043;
	Sat, 13 Jun 2026 12:48:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 495E420040;
	Sat, 13 Jun 2026 12:48:54 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jun 2026 12:48:53 +0000 (GMT)
Message-ID: <0c29bb5a-6869-43be-9056-99321ff999f2@linux.ibm.com>
Date: Sat, 13 Jun 2026 18:18:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] selftest/bpf: Enable verifier selftest for
 powerpc64
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260611153826.31187-1-adubey@linux.ibm.com>
 <20260611153826.31187-5-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260611153826.31187-5-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDEzMSBTYWx0ZWRfXyNaAh+jrea5Y
 B/iEV6vOcu542ilfBZh9hkwyFnm8DSQyuvn9K7ArRCT/qn1Yvo4TGcMHdK3QBACxk/EgE0Fj8uk
 bfqliD+1NdKtsZXkekTwN6RM/yN/6Nc=
X-Proofpoint-GUID: ybCa8I_HRitgvY1iayfA85ezoQ_cdyye
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2d51bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YUt_uYXBFAbkqV_xTswA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEzMSBTYWx0ZWRfX7DhMBC/Xzqbl
 YCBONIDCH59Gf7k6bc0W0Y/oTx4sHWr5Oj5vPMrrP8NikaRt871n7QP09VPB5m4T59xuU8inSmc
 q6NHsVTc27OMA3HlTYQduu1OgqB0mWAVKq7EcvdsqJy8CPUWIrs5y0T4V9US9uw5Znf0RKClap6
 P+xukrBbqzKCzd28GvRqsjn25rJaDkQ091Mg+15RkNn1CUVE+daQRY7lzN2NuLEDMS8Z7xqQ2Dd
 4SXWMjsXdjsAI/ONOcvhtUp3MDes61piGF3ey/LfseJNEtbC7Wyse3QNh/cATYtouqSvXJCbH/K
 Ogm8SJRBCgG695lt7gKydcLsL9Go9rIFSMf/48ODSlZRnIyqdWc20DczyBi/cVFUmaBfs5YXk8j
 TgcdNmCcJhj9TLjbftGbmXtvpWURppDv7T6M/NO5eKH4cBAPN3mRDMR28v96WDPdGlE2ntr9TIs
 b5SzkHAxCX9uLyHCqkw==
X-Proofpoint-ORIG-GUID: ybCa8I_HRitgvY1iayfA85ezoQ_cdyye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130131



On 11/06/26 9:08 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> This patch enables arch specifier "__powerpc64" in verifier
> selftest for ppc64. Power 32-bit would require separate
> handling. Changes tested for 64-bit only.
> 
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
>   tools/testing/selftests/bpf/test_loader.c    | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 9eeb5b0b63d6..cdc2a3de3054 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -158,6 +158,7 @@
>   #define __arch_arm64		__arch("ARM64")
>   #define __arch_riscv64		__arch("RISCV64")
>   #define __arch_s390x		__arch("s390x")
> +#define __arch_powerpc64	__arch("POWERPC64")
>   #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
>   #define __load_if_JITed()	__test_tag("load_mode=jited")
>   #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index abdb9e6e3713..d5589355ed9e 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -377,6 +377,7 @@ enum arch {
>   	ARCH_ARM64	= 0x4,
>   	ARCH_RISCV64	= 0x8,
>   	ARCH_S390X	= 0x10,
> +	ARCH_POWERPC64	= 0x20,
>   };
>   
>   static int get_current_arch(void)
> @@ -389,6 +390,8 @@ static int get_current_arch(void)
>   	return ARCH_RISCV64;
>   #elif defined(__s390x__)
>   	return ARCH_S390X;
> +#elif defined(__powerpc64__)
> +	return ARCH_POWERPC64;
>   #endif
>   	return ARCH_UNKNOWN;
>   }
> @@ -580,6 +583,8 @@ static int parse_test_spec(struct test_loader *tester,
>   				arch = ARCH_RISCV64;
>   			} else if (strcmp(val, "s390x") == 0) {
>   				arch = ARCH_S390X;
> +			} else if (strcmp(val, "POWERPC64") == 0) {
> +				arch = ARCH_POWERPC64;
>   			} else {
>   				PRINT_FAIL("bad arch spec: '%s'\n", val);
>   				err = -EINVAL;

