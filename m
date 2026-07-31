Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC013AB498
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483042; cv=none; b=KImW7xHhZoKgUTVDwAf3X08O2hwmXAsW7IRuz4qPdN2dmWZd2PSXCK6+ctQeiiQBwdioxher1srA056KWoyWaDybKuGESUUh/DqFx0dgIXX8bkrnVSuKc6BtIrnGtdh1Cvw4VKZ6htEyPaEWFRCyTl7TN1783Rdlvwi9PbMisp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483042; c=relaxed/simple;
	bh=ws230jDp6Le67PM370HntSHPb6BWySaE7hpPdaRTbpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lx+cpJNnq2tUQI2ZrV3kexKhGgxI1+tFrpILWbOUjO9P6RSSv+Ki6y4uChpHJbgIi+iangFK0ozG2gNV0lGI+7ztINJZWem64vrc+G9E8yZQRICew0mF3VQEehMi+NRtb8HkrJQRquyUpeHuRWCufGqDPNGr9h/zp67ZvtSRwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i0qsr+6N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mxv/B3Ph; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i0qsr+6N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mxv/B3Ph"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7ScEt3241099
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jukmAepEItxoJN8i97/lVV56EabbQ+hdagvD7H46HpA=; b=i0qsr+6NL1EB7Hsy
	/zCmShLgoc3aq6iwEs8yk0f05xuqDds3rsYebsILRNXDIqZLKe004GSvhfnHo4PD
	zKElQ0MoQnWSkA7YTW6lXeXzsPekQJbLEanFL64L/Kz3FwBgP0gpIAifs7xJF7/Q
	H7tKFKQbROGft1mZ+YKKIPXfUbCbigb1O1W595B2lgnmA37w+V6b6e9EKQGl/Wf5
	sx8JEyDYMtttqSc/UMdY2I2Z4D8p6hpIdfLGcZ3IvYYAvT/Sj3GLQ8OpUfUXOekQ
	fvsaB0lTY6EzTFtcB0M8jFvunGg5gJpCA/LM/VUM2zYpATpxeUwU+jOHxmmYRR3D
	T/BphA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frqbfg068-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:30:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb687f82eso9878305ad.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 00:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785483039; x=1786087839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jukmAepEItxoJN8i97/lVV56EabbQ+hdagvD7H46HpA=;
        b=Mxv/B3PhWiVvQVDzH7lHlwEVPqS8DZHQ/Ii4XoSBXvnOomqIBbNRi545XT5RXedtVS
         BwjXEVDvjuScn8Bhzx3GhyZbJZluvsUnVqDVdP0CwRvDCKXzh2xjP3OM1W3056D8y3bE
         G1K3EW+stdbD0KOW5WDFNaS4gHJ5vrHpGNFndt7FzjHwnW1ZE0wdswOhTCQvQBQ5dWHG
         9VYapPKziBy43vnpLoQjlKDa2MzBHdE2qWQOumgqMg93HuOX2/1VjR4tuLwkR7WJz4mq
         qQPuogAMP9CrXA/+TufQJs3OrMLew5CUmiLjRVZBDeLziOUnEcpSC/lZCX2Xa6YPO5DR
         Ohvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785483039; x=1786087839;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jukmAepEItxoJN8i97/lVV56EabbQ+hdagvD7H46HpA=;
        b=OSyXcoLigXa0bjVMXRkY/fAKQPY1KFi5/NhP6Tj57dCyjOkpu4m/T4bd1UgPTHRsHr
         KTKAvBxYpdprYKt8WMG60kyOx4fRUcK6etHLhnwgMkDLglpkCqJoZiP4q9ga+tvFDgza
         t4zDBrSm0dDPzmegP6sXtHf7m3q0wCx40nJfkfMtfuQ3r2/suX2yo37dyYkwLwBPdf6U
         1opJtrG9iNkoEbApWA7+eFx3KlUugZ0m3r1yJHiSJvojn2+xuHFCkErj+YHx5xCwtN9J
         i9OXlRkjqCrmkzgVHLrgDj0VGvMGmu1RBu8Q0DgPObCzPpPkTcgprcqY9wlhoBy/FhlC
         EkdQ==
X-Forwarded-Encrypted: i=1; AHgh+RoulUuYq5aS+A6uB5bxef9fPMSnd/djWLggY5z5Sr+VQ5jx8VeAAKX5sJ4vXCgbugsZOJrQQvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm94ikSUucgw7/2sS/WRIKKk5adnRbXLryj307qEM7gZ0ccAJl
	wgst3qGary9Am1YJitllrBaRXQH7w/lRJgwV1zMMPHrTSNbes/kTXQkH0hlvk8M0jn+QG89sVmc
	/d0QZYy6YxwPj5/s7sCMGfVUUf8FiyNrMUl9iUyL++TIiUNbGe323OpfAxA1r/2hQZQU=
X-Gm-Gg: AR+sD13jSnLDvOoF9l36FC5T1nBkSmvmNYd1ltlxiQZb4Xtdl87ALrpz6w+nopoRSHC
	5UlyJWH0oom9BGtZgAnP3E+bOpTG259ijJZyq1Q9Q10S7pIJ2pOZyXEZWHDnOfdEcjxGsRdDMq1
	Z4P0w64/FCEIsYqZ4hlmklva2mC4iM7D/uBcdQCeKcdxceEcKLzY7i9gWFSF1xcsY1b2x9g2+ck
	9Z6GLD56CTHJGllQw61oYJ5dO/LtBYyDtDky6P7FX4Du4rb7UZgJL5qr6eheHmKM74Yyhx8xuKT
	Dp4Id5XUpJwEusgA/FcnCFZSQA4xgXAtdOu9clfDxOLluBiV8vohZlcpaV3k0J+Okxo5VY3wiXx
	GuivxyPzRql92SZtfjqsYwv5Au6NPxWuDe+z3iDBpye0afNKTBs6HO5EOYHxW4UgZKcb0ODIImA
	==
X-Received: by 2002:a17:902:f78c:b0:2cc:d807:369c with SMTP id d9443c01a7336-2d046ef5899mr10209495ad.45.1785483039583;
        Fri, 31 Jul 2026 00:30:39 -0700 (PDT)
X-Received: by 2002:a17:902:f78c:b0:2cc:d807:369c with SMTP id d9443c01a7336-2d046ef5899mr10209155ad.45.1785483039005;
        Fri, 31 Jul 2026 00:30:39 -0700 (PDT)
Received: from [10.133.33.123] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae60139sm1872645ad.29.2026.07.31.00.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 00:30:38 -0700 (PDT)
Message-ID: <e7aa133a-0d06-48f6-90e0-1255972bd462@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 15:30:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix possible memory leak in
 ath11k_dp_srng_setup()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260727105532.118164-1-nihaal@cse.iitm.ac.in>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727105532.118164-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MIFQXsZl c=1 sm=1 tr=0 ts=6a6c4f20 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=45AEqwlmaGsIJYzuV-UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MiBTYWx0ZWRfX/sfnEC1c8dvs
 kEYSw8zC60wjQyRVSTIeetbSbVA9jxCJKsVxePlCMq1vUc0xxxkt+xSOzvBJYN3o5HdAMeh3FO+
 1VyqRfI5y8aFobdQ0CavE6KfgJN86cgITBF2q6gbcbGJBuvQbjpR+PoNGLB8yKg1YZAlN40qOYu
 vd8ONLjtCIWMl3DhZ3v7/fTn4wfqs8pETvD3coUb1u+AM1dGXuFEcS712d9rMExZOjBOVKraPBx
 tB5JM5wWmQSjjrhPb3LXn+rvCg7IdVIcCoRUJtTt8MSRAYsxEEL/nfSbElWn/pIppF2oR+w0DFs
 Fy4PbYqDhNmHGbIZn5Im7Gx8vx8JXKBjZoXwHHB30DmQoHKW49b+7x9Wq3KExOIPyTx75OBgG/z
 e6GErjtCTUHPweVdNTLRq960KQccHaHF/sS4YwkHdgrmZdEaoYSIzyL/eLOJSeD50uWRHNk9Hvd
 R6tSEn62sM9V/WAAuYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MiBTYWx0ZWRfXy5Bgftc9dFBD
 X5NplOkBqBlBRJO5OfQhqgMI/cqp7nfautws2a3ahotDtOTI7jcmPkAn22Qd78Aw5rbMn1xUCJS
 NUO5+56hUlYnuOPcWq+XVf9Tumo0qmI=
X-Proofpoint-GUID: g7L9V3DeR9Zxgr_Y_kvOXqDZwvGwgS9S
X-Proofpoint-ORIG-GUID: g7L9V3DeR9Zxgr_Y_kvOXqDZwvGwgS9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310052



On 7/27/2026 6:55 PM, Abdun Nihaal wrote:
> In ath11k_dp_srng_setup(), the memory allocated for
> ring->vaddr_unaligned is not freed when ath11k_hal_srng_setup() fails.
> Fix that by calling ath11k_dp_srng_cleanup() in that error path.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.

this info is useful hence can be put in commit mesage

> 
>  drivers/net/wireless/ath/ath11k/dp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
> index f389b97acbdd..c3a16da1cba7 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -324,6 +324,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
>  
>  	ret = ath11k_hal_srng_setup(ab, type, ring_num, mac_id, &params);
>  	if (ret < 0) {
> +		ath11k_dp_srng_cleanup(ab, ring);
>  		ath11k_warn(ab, "failed to setup srng: %d ring_id %d\n",
>  			    ret, ring_num);
>  		return ret;

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
