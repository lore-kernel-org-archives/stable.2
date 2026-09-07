Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902C48C403
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783815; cv=none; b=KRBr44no9m/pgNWoyhZ6DBY4kfqQXa+Cm2IWaCGpuC81sibiXE5dUBqDrVWlLvfVCNtRqSl4WD2ek3+to6YJHD6NiKhCUjl9SgbCQGCvCUEoNAOP+j1M/rurr91NJu5WXRfZTbsMbG2Wsw+aDTEN3+uxNRa4spW28rF1Hmk7VRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783815; c=relaxed/simple;
	bh=YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDsnuTwE5GHIzu2PCWVU0tU347PWn/Lx2R2IgBEbLUeMCHcySk59lXLOWRrhmwtzmARHThcl0teWRAGmrVbUzd92vhiChSGg7/Z2PvSgTaKXbn9ZbC/lsgW9yT3YVZLvK9kLU6nNWlIAYtODQVFBFd2SXXa6tesQB0JBwj/5YZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Umpnsa+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+YhLcUY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Umpnsa+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U+YhLcUY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AmpIn2652023
	for <stable@vger.kernel.org>; Mon, 7 Sep 2026 12:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=; b=Umpnsa+At5I+OcpJ
	HrJY1EphneNQ5Wdy1LKbaES1bD0Y3xLT4pF9/G/d5pme8whAsiw7gaAZqhaWI4c9
	ffg7Pn6I/pMCnupSohA5hB8DLQt3W+6VXAQ8P/3VpAcPY1gwxu55MQKiqOcSaWvo
	jDhRoCDiDgBxzGsiRo/VQyyNU32Et2Lc4QHoX2PPCvxh/uqNyDZvdRdr6Kq9WLrj
	nYduZWBPYj7SwhfUJcy343oVXpPkALdqAVWqkooPaCLhEC4iFO+VvxzltJiSb0kb
	WqkrDYxbQCg1AvlxjYafSoGNOrRkB9t8E8vX60DA3ieSmAV0oQer5eEuWoYautil
	0+b1vA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty0kgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 07 Sep 2026 12:23:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939a28482e4so20265485a.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788783805; x=1789388605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=;
        b=U+YhLcUY2bBPHMfwir0yol0Pv6Kg0+cXfhKPz68vBRZxaAUZDpxLQJZNZtwiGZm0bu
         owyLT2/k/ea9dCzjD4aLNYDEvvuenEjT0osS6AG59dUaPOwmJuKGkqfLW9qbrvSA5Kmk
         WI+hl5peZgUKBNkdmw/qs9hyTGJ75YPOJja35RxM7ZawgBauIm4zliYEMRQZLnhUUqQn
         t2T3ON9h5CCVZ1eSVQKiNdxbGFhDBAmfHhFEYLLKxwSoJS0PXRebgY/1rcmVNMeeZRLe
         YlExGaz3x97kPo3fUCcAYA9lx3Pl20Owq9MSKQXY9CN9gWEIxQeGJAV5rvS0ukg3hBJx
         Tr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783805; x=1789388605;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YgPQAqGAhvGod4elCi6c9RafBPUF1Jnx4Tkb+xELDMU=;
        b=AieZPbRUSdm+z1sIuj7N7BY+8rkwmUghWLunhQAdeo1S4rLHjM//I/BmNYj8+3ALvd
         60bPcIGlQ8HnL7RGzHF8qPZ5TMlKMHVNOCKLa2799HwHnbUnxdf6IWkgeNEhn4wZ/vg/
         jmzBJMF3GqcKRnfP3FWkVxcLtHW1gXqmwWjHvqGGqoixf1SOIn1wL+cnOWK+tGtxKyIN
         y7A2NFJPrG1UUngEXE0T4euhwMYW3/KMxO0D0n9F7h6wSiTNcUMxw6abfYkdtvRIYtce
         kvtCNT9D4v55jpCzENirai8XhrxUwdhSQr5mXax3TZA0a3AwbaiAwW0g6Dh52MWxV2xF
         xw0g==
X-Forwarded-Encrypted: i=1; AKwUvBwVwkJTsAgKGvLuh7eSWInqcnovGiuUgY2ntv2FFuO5KZZwPy1hdZGFzLEa1nFfKFFYFjLKldQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kYr06AJ3wGtJiWEnmkToEY862U8bvc7X8lgjHmc54sh7o6nWKW
	Y0XxUU1j+aoh7UXJh+yODEEpt/wycudrAkfiSbpkNcmJc1KD+o6ez2KV5zfPqxNIEOnT3eC8OD3
	gVCSnE2TBsBr5r7uhLu/ymGRacWhhorOWTokz0FGsGMUcAl3M46jOsqUozBU=
X-Gm-Gg: AYBFou39yoFIikCsy4z9JnuqvJhFBvisMx9BNJO2Bu/15weqQTUZMOa6qLnoh8B9hcm
	rZqa6bGlh4/sOaJJDiUfheOA/TAunVV+s3TanStvtKwCvkGdQrI90MIUW/Xw2+7NLaNqzWdO5pV
	+K+5D8l0UyqCrZN1cRAMVlirOuIMMPDhBboFF3mQt24vJ7S2VSH8uB8/4kAk65JhrDB9DvQS++W
	rbgJKuYd4BkU4XDCtS9SYfPabAr8jUgu7r5CS5xN01C4nkdY/8GTa6TxjoN/LRQTYr6tab7wB2q
	l+m0CERN1W1OOOt2sfEbXePTROzK4NE0OoB0uIrXJS+9Wk5QlIFPNkkoqzmSsMbHUn0Q2oEdoYE
	oI09U1m/1A+1TMajdSyEI7g==
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr865311685a.3.1788783805439;
        Mon, 07 Sep 2026 05:23:25 -0700 (PDT)
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr865307685a.3.1788783804918;
        Mon, 07 Sep 2026 05:23:24 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26263cb042sm330890766b.47.2026.09.07.05.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 05:23:24 -0700 (PDT)
Message-ID: <ac8d6fd6-8bc1-45a1-8b3e-a57b437b77b6@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:23:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
To: Aamir Ahmed <elb12345@hotmail.co.uk>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org
References: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9eacc4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=y7GlcLeVpO5nAozT490A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 3zNyVuHLf3KvtyjE7_KjcwYZ4I1FSIdd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzNyBTYWx0ZWRfXx0dh3uhu81tK
 lyt1kBfez/MZgaN4aUVOEYNA6voJv408If7NdF3M0olL1G7ODQ28hVlhOvGK1K3ZeTQK1MVjGrI
 gbKpOmFqv8ihf7y16bbqU7Wa8KKnVpM=
X-Proofpoint-GUID: 3zNyVuHLf3KvtyjE7_KjcwYZ4I1FSIdd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzNyBTYWx0ZWRfX9reRBugSxkg0
 lwlU5HMiHaXAN/H7bFoa4kAinaF/900gB6I451PBYH0WyWHigW+Tl36SUxrfsPpLE4V1LBxEsYe
 5VIai7dEpGRLdC6ZxMFpLoASp2gmSswj950/uY7lpG856+LDzCIirFfM70HO5QJKdz16/1LsZFc
 CNGniUxoDWE1sUsOe3+QBVyEH9rrjamwMkdoSCE16k+3v0vAINiVGUmPUlp9CFtTQN+HptAoBjE
 5m1QJGyReg/rpGNHxRe9z/zzqMJHe7F5N3ELxlSV6on2aZWKHb933JKnf0T5D3si61hXKQlko51
 YtKZ6xeW7XTGY0n8ykg7xwJY2aXZAOKIxaIgmt1OAicbZbbWxqewAIyfb8Nf4tZMsw/l2LhYdwT
 siy2XsX6tGX+MIsz9peRmdqmZ0em3N3kwjn+W0LzN4PgSLCPFukbbue5eOIBROstf8jVfUsrVCY
 8n4rpJ2kSIbQCEEEl9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070137

On 9/5/26 10:48 PM, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ipq_cmn_pll_register_clks() due to .num being assigned
> only after the fixed rate output clocks and the CMN PLL clock have been
> stored in .hws[]. If registering one of the fixed rate clocks fails, the
> unwind loop under unregister_fixed_clk reads .hws[] while .num is still
> zero as well. With CONFIG_UBSAN_BOUNDS and a compiler that implements
> __counted_by (GCC 15.1+ or Clang 20.1+), this triggers an
> array-index-out-of-bounds report during probe, and with
> CONFIG_UBSAN_TRAP the first store traps so the CMN PLL clocks are never
> provided.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
