Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772953;
	b=Qxle1Wo83pVQoTfjZ6KGbODbmGwzkn+ynRfL6GMxdVQdzrM99XYycHDMTmB+dCQ8qLCH
	 K1OXAIT5daFVeKX4BGG4a3wrHhSUxJZYOXifWdyhjKFpkXaQx1su7t5wZ6ZqmF8trcZGk
	 7LHjbWA80YCnqnYtnjYMnwQCDRTBQNQ1A6Z6GE5qxHbMTIxWGuhID4PvM7BsOH7X71IGw
	 3jFGzzEMTF0uYYaF5Y9PY0UOcTZecx2BTICPPzXNhh2CgzdPot4PxL6s3AZOuBZYGNNXf
	 KTWlIaFBYP0HVyyUoISGYOQSPNZgFqHTVdiP5UhZ9LC9B/nlUTwR2K+eLi4toLgQWHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772953;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wVlqWYb0itOLHGsCT6XgTueNQgxMfN9z0WOmdqIPsIE=;
	b=r++8AxdN0oARJsSvGaDzSIKPUGQia2zIW8JEN36Q7+u+5c0n54c2pH6Y/JLPRU/J9ZsS
	 FFsYXNL4sRek61thJzyO8W34dc3sero4c7VVppuOGJKzmd4uBdPTy9BsGMr/x3rekt1uk
	 G9x/kodNd2R6fX6nnR53mqakHMj9QSJpw7pJOUygwfSuLinXrfWbKtPGP3eR/m/tkg5LP
	 tFPBbr2kX7L4Ow5cEir339Y5shMgXqH5sw8yuFWTxI0DGo+UbZxjlsBntT++QuxZA++Bz
	 DY1R0MPSiyp8y4IbMmFN1jQUHeNOyCj5NhhSw8J6YNgRrM9UcXfjTENTHfz3QZXW3bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pS8KIHNO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NcO6QXhP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99330606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99330606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pS8KIHNO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NcO6QXhP
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GbGA3759044
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVlqWYb0itOLHGsCT6XgTueNQgxMfN9z0WOmdqIPsIE=; b=pS8KIHNOrymvcij6
	7BxHEPv474G6idlFeiJguPzbiWdeWevglg2akgyFgSOgkSnrFU2DV5/9A/9MeyOO
	8aANDwJPHQFxW8NxZYPqT3wxI5JhlUkkln68A4UKvjFRN0LFg1e7nXROcppvpJUi
	+y2/sf1tJM1ZXK6LXlyzSJvb4l7nMF+SJWxidG462XCebgWUMdUiNigPTjJuPs+F
	DYVV/fLqT3OVH6PMuZVSq02o+IXjSsDvWpUN0LS/MdV4c6+fgtUmhrWUOmZK+rP1
	MAOFzZgdvd4KagLPFPuq6KNLHYOfNkUDJBSuD+dbEmvZlyP7OWo3StiqX5ta3YtU
	Xphqnw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6rsq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:49:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso5328534a91.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795772950; x=1796377750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVlqWYb0itOLHGsCT6XgTueNQgxMfN9z0WOmdqIPsIE=;
        b=NcO6QXhPWxpE0zVrUZjLDKBWSKqps7cl050uA/gobhQmzwCoGtzBi3cE9Ty5LG/WFO
         U+x+lDvg2qfjXigUUDpQUg2WTId71LANVhSRnezPS6KmxE0E3PU1P1u7bIrkjlBMzEJq
         Fw4C6U3Uduj0xRiQfGad25WkX1aD0ZV6s6ymqmcaS25Fjh+sbsdWZJa/dVJLMGoZdVyp
         nEQXSGY1Iid3DB2sZHhilQrFwVXsF3qJUV5UpAisvm4liBM11ACH15IlHnuY0sujOtGP
         TTuqmZViUrLPy98eZMZE+Clyt9WO+80w/zXNqvsFrwsdD80x9JpYJRGic+MXNXDKjBKT
         c9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772950; x=1796377750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVlqWYb0itOLHGsCT6XgTueNQgxMfN9z0WOmdqIPsIE=;
        b=xFJ+xAr1LUqu8bb8myAdB5eacvKd+cXokxdtJU7ub0EWWQQXN+hTFP8BCBPrYEBpDm
         VnXHbP4CFDedCymdR6+CixkmHQfcuFfetqAYQ45DbRcGqaSq3ViyH3nmPKlSyfZL7uHU
         YgcZeDxObjRWj0uPVnPFrZWcoFvllkwb1RlMnFEi9xP5vG64B6K+KgdLw74AWRJnMc/h
         569hxQr5WnFnSzTqf05pZnYx2cGCoEEheIoiYDlN5BSdZFZCOC4QhX5tnj5GpWghovL4
         MN0wJ39ZZ58s3Q1WKP8KHhxyPi+9kbblphULn/UwqPL0kFz9hofKNxNQQYaeRr8ZCKn8
         yPbQ==
X-Forwarded-Encrypted: i=1; AL+hErGcYi93u6J938PTtrqVXaFxR2YnvH4Wt0RWWpzcbc396a0CiB4SPPUVMJB+/w6wDyBYfA+79M8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Gv+eoEnJoChnyicLjECVmhnu3IwfhNmYeK23qzLU1A0R3wGnU
	P4j4Wm0DqMdbGVI6sihMzbHoQ9uQRtBHeo2LY7P9vtiayk/z1vUXKegazPQrrSC4+2C0AymD1mm
	a5OglNf13CIico49CLj7WIAzLEs3W2Sf5NplzPi38dR/An79FfFLozSyS+KU=
X-Gm-Gg: AZFdTZfqTQFi47B377Hq7vC8iKXaDVUWaLningUjq8/vmUE4hwrBCdFc71N3TULaK2d
	l+881/ZV6lMqW0X2APT364Hw1JRzvgxnfy4HTpRZnTEJN4ns8KXhtoCNGQmo0cGHLW9p3yyP03/
	Rg4VBrjLUPx+y3IAGNodD+Y9bdqolmAFPkoIhmYRfI4Ai7nvwtlXtIgG2Yt/Fa2IN20yx6m6oDm
	HqxO77gPGERAYem95upVaaiid9Tr2HcsjcW/UpDfx+M0oxnJ8mGiFQZCTK243jf+H3SZ5Tyj8Ak
	hwAS7E9m7ECGCJdOXPEyQP+NoWtSbEx6KUZs3wb0wK8SD2tt2LU8OwMcckDGa2fWYeHjwq1mv7r
	dC5jDogAhXUA5aDfL9TEDNi3FDtpIfPxn7ir9oErbHZ25WU5gLsa9v1i4McT+IswP6KzDm7yXEp
	EaRK1ZyQJuTKLbSxPqtRlijU/oXihiI86jW/1ZpU6tYN+eAHldRQM9dj8Vix3FRXuFiFtgLRFuQ
	/Qs
X-Received: by 2002:a17:90a:d885:b0:3b4:6094:2f9e with SMTP id 98e67ed59e1d1-3b4609433d7mr17785372a91.46.1795772950600;
        Fri, 27 Nov 2026 01:49:10 -0800 (PST)
X-Received: by 2002:a17:90a:d885:b0:3b4:6094:2f9e with SMTP id 98e67ed59e1d1-3b4609433d7mr17785348a91.46.1795772950074;
        Fri, 27 Nov 2026 01:49:10 -0800 (PST)
Received: from [10.149.108.218] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm37851351a91.13.2026.11.27.01.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:49:09 -0800 (PST)
Message-ID: <6172214f-c0aa-4c9a-ade4-83dd663028e5@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:19:05 +0530
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
Subject: Re: [PATCH 2/4] remoteproc: qcom: Fix bounds check in
 qcom_pas_da_to_va()
To: Atul Akella <atul.akella@gmail.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, sibi.sankar@oss.qualcomm.com,
        quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261106184312.100-1-atul.akella@gmail.com>
 <20261106184312.100-3-atul.akella@gmail.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20261106184312.100-3-atul.akella@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: I_oLFwSXo8-JWQZ_UwgO95n5tptIBQRp
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b095217 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=E4ycadI1TCjYcBWHacUA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX0Uq2QNe+usAW
 M0+eME9jd9K//CUSPKyX6Tx1R+BT6elyor9Ex8y7fJK5ym49IbcRimUDAklJUpjZooGu1w8rKzF
 6yQtlkheTW3f+DIRn5F2h5m6seZJ6ZY=
X-Proofpoint-GUID: I_oLFwSXo8-JWQZ_UwgO95n5tptIBQRp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfXxB2YT505NgSG
 WNQtN/231SGZ/jm5qfPyLIumoT+WghLhzD3f3U7x2zA2faFTUMvb37iesoaT3bVFZNKAG+irEda
 vF4AGFWoW9M49C0qnpW9Bqt83BReGRNBTV8lkgUJq0uj8ZyiiYtDwdPvSphezCeUld5jRYrE92o
 KJtKP9v0hZc/Jls594tDVxH1m8apAIgK/6CgyaeqQxQS6DNoxqkKJRWE8dJz8lxCrw0XWp8yfbr
 pvtnu6jYZuJyzfIviT+BTjcTq9ggdrb82f2L34Y8dUql+BMCt1CSKLJOrjgd0a9mh3oqY/f4xoS
 48jBGZRTbn7wFdTnT9pr1YEUvDjYulpzBuiQyq/Pw/p/BcaF1Fr2snuJX9DIhxKfQQeT1NYbEmi
 4Avh7gcrUEUrnbpu4hj5uw1RF9PRtiOvQokgOXsIbDPsF9sSan5aYSTBIDhddtXrnjOYeicXYBU
 GhrYRffhJ9BY9ZvGkyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270038



On 11/7/2026 12:13 AM, Atul Akella wrote:
> offset is calculated as da - pas->mem_reloc and stored in a
> 32 bit signed int, while da and pas->mem_reloc are both u64.
> For a sufficiently small da, the 64bit difference is truncated
> into the 32 bit int, bypassing the offset < 0 underflow check
> with a small positive value. Additionally, offset + len >
> pas->mem_size can itself overflow when offset and len are both
> large, providing a second bypass.
> 
> da and len come from firmware's ELF program headers via
> rproc_da_to_va(), and the result is used by the ELF loader
> to write firmware segments, so a malformed firmware image can
> cause writes outside the carveout.
> 
> Rewrite the bounds check entirely in u64 arithmetic. Reject
> underflow before computing offset (da < pas->mem_reloc).
> Replace the addition based overflow check with a
> subtraction based one (len > pas->mem_size - offset) so no
> intermediate sum can wrap.
> 
> Fixes: b9e718e950c3 ("remoteproc: Introduce Qualcomm ADSP PIL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Atul Akella <atul.akella@gmail.com>
> ---
Reviewed-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>

Thanks,
Gopikrishna
