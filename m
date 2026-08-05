Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033540A92D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923506; cv=none; b=q8A+phizljy1aQZq6JvNlO9LZv0kIdr0iaTnLeII+8+/IKNBuNO3rTpLEWaSv+swZUfW4RJt2iLWPoKMqqxUCppiG0vvMl10no+La84o02lzWjSin9mbDkQegqsP5+5uaEmT8vQX0fmg8RPnOudcPadYpXovwRcv7nEeinVPeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923506; c=relaxed/simple;
	bh=QFM7AMKU4RXwGP9obr9bM9LikH8JUn/fNm7E3dfSGRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XihOB3p5Ovs/y8PGhKUrDHULSoAZZ1vPDv5EdRnmjQ+uQkqjbR24Wx5CD/x1d1O8SgEbuh6uNl3ojH+6h0fwJd214qJMvUWeZbBdRlcZ6whkz8fpcoaCtk6Nm5zi2sJL+3pLVrUQYKQGokZz0kyywZLNbXTC5OD4WruYuTYqz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=meZ1yApO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j7PAkvhR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="meZ1yApO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7PAkvhR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6759DfM82442038
	for <stable@vger.kernel.org>; Wed, 5 Aug 2026 09:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1IU+TsuZ564fFaBd33xIc9jlaZuK+lX3HGJbEgaHb8g=; b=meZ1yApO36DwW3G5
	W2RlIfPaGWXXsr4/9NKjL8wrNqrfq9z2iBHeeWFAiN7OGo9zFg45utFeNQ1LWqxH
	j5474T9+wznaWwdvwrmiAuBUmwgv8lhoqIesbIYS3m0ETKWcu8CGQyVwjAtHFF3j
	mJwJ7ed1XCMqa/cJISRWGHUsQYhgrktqgqcZc8/Es2RYT+cj9sRAGMOnPDCyz70w
	ATWfBb5T8OAtU5LN/8J7dDSRNaaGz1sn6QIE8jzJOEq/nsNuds5FoOf6/+OcxNLq
	S6cGpQuFazHVYyiKvmMb+H1osRPA2WEg6tmHeGH09Wt++dBva5kBujlCXGehrYLv
	8RymtQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c085rh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 05 Aug 2026 09:51:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86a9ef97so14845545ad.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785923502; x=1786528302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1IU+TsuZ564fFaBd33xIc9jlaZuK+lX3HGJbEgaHb8g=;
        b=j7PAkvhRJpIq3mX0ZPacQSu5pOjlNymmBVRW1A+R5qm8dm0fFjHBNyo/qUpf7GNMSF
         Y3IuTjT75BoluCIN3c60dZDbFlJ0f9y7Pllv9CdbxOmRibtiyXzzsR4SNrujZvSmd8xZ
         bLiwjGQl5Og0/JtkLQkbhUFgbfXmUCpTNqEoehRcGt9peu1WOFZR+MstuBEgdYjrHYrT
         OjxK6Cfwf19pmgrH7k1rPuu3bgssTJKRWO7C0GSIb3yrGA1zq9DTS1ft9gx3DRBhJ5gv
         aWs4tupMVXdkDZsN27fF0b/Yh1n3hTyOYBVRicIu6z3a9qLpOPu2C+NX4fke9kf+0m3p
         Uwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785923502; x=1786528302;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IU+TsuZ564fFaBd33xIc9jlaZuK+lX3HGJbEgaHb8g=;
        b=Ok/27wfZgVNIDGSMb5l7QRtifYEl+AffsW5KPI+/NHKQ3i5847Vm3oHsHT8y5ID2bn
         Xjwzr5hK40X39guLM8qpC3asfAYD7FQ9kvtNunjxnfTns+b73sXKnW2J+jSvtkDsd7gM
         uK+lTLbTEa/s4nFIC7swnfH8ljcDcFb06+ZnVRzs/BzlFS2rY+WCy4b6O6gctQcBgnZJ
         d3z3GQwcAsbzc006UdBVlsTc7kQUURKCrMWdTNXTsahmLwksIZ2Sk5xESC/fn1l4XlOl
         qXZFbvFM1p1+KqI36Yc+d3UDKln5BGFJEOHnJXBz6BvXeH5PehIQa33GbOFG91ye2f+Y
         zu7g==
X-Forwarded-Encrypted: i=1; AHgh+RrDVoozKBnDfDk1QAp6EwNnHUUQ9zjfnzSINKGiKQSWixu2mkawSJCkXyo8chACNQrxsf4Y9Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/o3e7aTVoI9q9iOMjfRGLkyBY8y+pSKCuyrEHiefcb0/C3Bz
	3ThMwD1IobH0Nw/bwut1ZyBHXQMTuNHBUVkfIEXKlpvj+6ihNRMVec/GEiitOFQpO2SRjIslK/5
	7rSXTyMEeC2QQECMLlVDuYzODmiwXZoEOeaJj3CUxj20IkMOgN9oECOacG2M=
X-Gm-Gg: AR+sD111g8qgwZdj+EQwc8oZRERLG0U9c+ZxxY9IbnAmmdsXT0J/7D+9IK+/vSZN3Tl
	msChVs2/N/jWjjBVolY75MiHAAxd5pwE7fd4x433v63xsc5hpYHl4JuCf+gFsIG/V7cPDZBrdXZ
	et9xsSPDuQdEGA/R+RCnGZDQlu6MIgYgb22lXPIFXyoeBivGFZfgRc/KHkninDZ0XmEwiUSDsOb
	2uhzjuwe0PvtUkUbQzdvCrENuJn0o6Vs+Nkjcx3g/HF01YKAGFfIF1elmN7uGa5UBy1kzOTzx/3
	O7lb9yMaB4SSIQwcXNy5Yi2u7zwNac1U4YY2XBIBZveU49mIlAL9R73PQXN/NRJ/PESdZWFLjGB
	zsX9fRK6SBX/sCltyup5nV35b2ZQeclA/EEX4n6jN
X-Received: by 2002:a17:903:4688:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d0ca7fbc9amr66562485ad.10.1785923502438;
        Wed, 05 Aug 2026 02:51:42 -0700 (PDT)
X-Received: by 2002:a17:903:4688:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d0ca7fbc9amr66561995ad.10.1785923502033;
        Wed, 05 Aug 2026 02:51:42 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d7e4csm14825638eec.31.2026.08.05.02.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:51:41 -0700 (PDT)
Message-ID: <63a41170-b20b-4a9a-8d60-12d2226e2f76@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:21:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix possible memory leak in
 ath11k_dp_srng_setup()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, jjohnson@kernel.org
Cc: nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
        justinstitt@google.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, baochen.qiang@oss.qualcomm.com,
        stable@vger.kernel.org
References: <20260801114911.91483-1-nihaal@cse.iitm.ac.in>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260801114911.91483-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NyBK32Ct_54_dJKWKwdncGy9YX6tmmyN
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a7307af cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i0Dr3GctjLOm-fFF1aoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3OCBTYWx0ZWRfX1tepFoGHKzYE
 QfHzgEvOqk7NuRg1eZGEmVFg6ozYLIa+EAG/JjQsl4YFStbFdk6bJ1DMT24eZPA6vWCrKAkleUJ
 xHxr3mlCYw2oC2eFP6WnchKAauchFxQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3OCBTYWx0ZWRfXz+4m0NYZFF/E
 lb9ZKui2EH7HuyU1pXPTfd2/pbxfQZvvu+VUScSIp4539YcYlV7bdsZ8MmGLNjPSXxy8w241j4r
 lwZZvMhH5EFoOFUKHt3Uw7bF1nydwyJP30zKrtKAjXTTMEnd3wTKWk6u5r2pMpVx9Fu0Z/BToE0
 FNuP95TJr2B7q5IsnFtFIYnEi4z2YICh2PaOAhxYMrzGPu9NOCU5HJbFkWMD8Q+C9JqPjZWDvr5
 pCc463y3t4nsGsvOh8C/8gwIjZUjDPA/9wdFImAYrhHZiSoFOo45KIKKZuWdmWO8bzViDltalLX
 9/Z4Rxzb73DQ5yAZgUpqrgyRGQgaIuoj3L+lbVM7CPnAC5sqsIS8YVwFUoJVWqIAIRBbIJN8c0T
 5sP8sePEgT7AYwBr6ECmZqJArwkuRKUUHf3oet3j6wlNxxqBrVHplCcqDBBtQNRTaFhQnLrFR/s
 Inzj/jN88D2+HIiuNgQ==
X-Proofpoint-GUID: NyBK32Ct_54_dJKWKwdncGy9YX6tmmyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050078

On 8/1/2026 5:19 PM, Abdun Nihaal wrote:
> In ath11k_dp_srng_setup(), the memory allocated for
> ring->vaddr_unaligned is not freed in the error paths that follow.
> Fix that by calling ath11k_dp_srng_cleanup() in those error paths.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> built on the LLVM compiler infrastructure.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
