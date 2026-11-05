Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868894;
	b=je0O0+1oPJt9FNstpwlpCJdGTc2dMFW9CGOluKjfgeuDx0Q5o0H3Y3eRoJJKU5TnTG6Z
	 RkmwcaihjY5hwR2IYokDyLRpM4o3vBUV/oVv6lR/AhuggoV0CVr367dtCEB94u/p6dwcN
	 wIYgNHeH1N4A1B0vj1QmzzVVR8f8ZcZBPoKY3q5x7xfl4l3eQUC3LqtYC55tiqn90Ht5P
	 gHxumglPhiTELf60p1lXabeQWpz7Fn24WC7IH3nBJSEV4HDP/+7kJcuDABBLLkkQwFSMc
	 oiE6kRj8KMPKfPw/yvVcF/bCZN+jyjMbK7t0j+lLxKTH/+ZHXUhvV3dfXtlCwW/6JwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868894;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kO+uPMdDpz8W5t/f37PmqHD6B/Gio3Vy2iMQmXxJUgI=;
	b=kXpQ1ss4On49iEITjlthomZi0uewXlqU7Y0G2bTcCecipHYvoxXJFO5PfYQmIo+nyhuv
	 IlxHKz/T5Zb9DY1LTwIxYFAzbMOY7hue18iU+0jP+qSgdAXSPQKagqc6BX0D7CJteMHyb
	 RjPnb6JO8EpBpKWXjIuDTIjRZdbXDjo9XlgPd6R2IRBi8TnjCqRVgdtnJEFyV5b0DhJsJ
	 3gZ36BzIXYNInOGi6aRZisZwYjf9g4lWBD57etrUrkyRxaNnyXlccOH5WenUdqZ4OCArE
	 mg8UX+1cQt8LaE64IuPK58Wb5OXErMAmM7PR9u9zC8XF3lPzyQlcMGygIdGg6aP7t9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjN1lQM2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fJS3lh07;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89778606A33A
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89778606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjN1lQM2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fJS3lh07
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UKOu3223814
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kO+uPMdDpz8W5t/f37PmqHD6
	B/Gio3Vy2iMQmXxJUgI=; b=QjN1lQM2lBm74tGA6J8kZzfAbK58hzzqHrUuUJES
	zoJacckMYEzHW4ZtwZEl4s0Nq55KdU8lOEiBIOyqPgVoDGsQY9dRCJsXhshVhsQb
	g8Ix21CdLKg+ebKq6KCoA65a7BOqy5QFdK00RG9BpFWYziliPuRK8aI+0gBGNUQT
	LRitOMu1tqg1JRbSA3pCpXrftXbHpCGwg781gWafpKEznqoWmHwYsOxUBXmwhnFE
	s7FRPQqcd7KcGywUrgyV5uWQIhI81cxvR2yvmwhXKslYzNbNeR8KjDyV7SZpiPNi
	1rgGdyorUHmNtw33+ri7J9PxyEzaLm9qeLAcuXcTd8EQ3w==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43h6hp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:54:53 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf08dc2fc8so379608137.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793868893; x=1794473693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kO+uPMdDpz8W5t/f37PmqHD6B/Gio3Vy2iMQmXxJUgI=;
        b=fJS3lh07mwOOdRIf5arM/QvbuGRl5vPJsdmldR/nODTH9CgeuUds6Pw8LSsv0pxp8P
         R7RrhRHUF3MCGDUsN6hl0Z2Qde5ycl9HtxMSciOH/xehUbJRAllwYJodab1xDEr+7BCD
         qTnuxZJx9Tjk6k5TF374hvjw9uZjWU+OsrAb0pbK/oz9As93le60BCoLaIo+9g1HPUFk
         utN4OH5bMtuDHqhqg8Gs+Nj7lnI1cVOkSd4+PUkPDrLNRlzwiIBH1QzUPpgFP816R129
         ZHAqHTskGRQv55DYpCuue45pNhmTIeOxbv8lqHd7msJo5smlBMEWZitxzQiwz0iIjzCm
         OK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868893; x=1794473693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kO+uPMdDpz8W5t/f37PmqHD6B/Gio3Vy2iMQmXxJUgI=;
        b=bZbdApA8qtqF0s96Nd05F+OKgfquyLdEV97UlTilMjaR+Uh2X3SVC14/ROMkpsQfVK
         ept8oHvjpFnBIXPOIG1plrL/0m9JTwWTeqX6Y+/o/f8fZEjnuVLDlu4h/4IBRQmOqhdj
         Sc+oCzpwJSsBCzjiJNq6gJEdTADNK3K0xGIiG1mlA/BGf9O6UwfGJEmeoSIxSD1bBM3m
         +w2uQQ+tGVzrTkQQbaLEjXZs8EjVqUhvoCpCxyGlJhJHZxq8v+YZWCFIMv2HqDgc1YmT
         LQKPt04i7vzc/6htwN6QbhakwIQqPhp86WNYGf1OIqfVlV68/gQoT1EGif43MLVUkELb
         eMOA==
X-Forwarded-Encrypted: i=1; AKwUvBxuZhYCyj/X6Y6qTFiIlCV/91tjVBDNsa40Sm2G1u7cdEya9rPIsidUyEJ8OVZlKXs9t29RsJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YSlYmL6HxbEOLAqVX3BX+JpJTwORLpAJkqJBFhwgGl6ar5SFO
	3rs+vrGCYZVjalprHTt6xHO+Tfe1ka+SO+O0pmGeIwf8HuuVo3gfRNyGOyCLG2rvOkb8LyY0wOR
	lsyvQH7I/3A0qVI30wEJ2GLCv1iBznbutKj9kAr+ku6S7OhmqMpJ1R9ywABo=
X-Gm-Gg: AYBFou0CRkf0u+lQk16nTpamgauJYybQ0el7T+6Uy0yNW9x5ROU3rXyZB8AKhfrcaUY
	t+ZV+kbhAYjywc0TLFRCKtxwdp4MkbsHys4Bd9Kj/2qhlSvHbGVcpAVgY+AyLEJ/gKy4eZy3c19
	8gU8jBtJ4+LC4Q15HzKf/K1JtkTuSvpy/ryhyedNYA+QcxhIjurZw84hUvPvoDxO42LDo+T07UM
	nYiOJ3uGoVE+Cdn1dwAd80y5IPwSbASx7BQNZvp1at4z1/h9L09veDhIVRrJngXW1JHnrVwW38H
	SCK1RzEYTZ6S9q/BitYEccsxnfndq+YSnEo5DhMEuJbFuU5if2gw0q4ES/MAwGQh0ecgIMEvAMz
	DoaXSmZSqSw/XyZazwuxUIl5sAwFb17/Hzv+c/MMiBmgPgF3vHZJM3a+m0iiNFdc=
X-Received: by 2002:a05:6102:5811:b0:7c5:4da3:aefd with SMTP id ada2fe7eead31-7d072c25cf0mr8060512137.15.1793868892542;
        Thu, 05 Nov 2026 00:54:52 -0800 (PST)
X-Received: by 2002:a05:6102:5811:b0:7c5:4da3:aefd with SMTP id ada2fe7eead31-7d072c25cf0mr8060491137.15.1793868891889;
        Thu, 05 Nov 2026 00:54:51 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552afcsm8675487f8f.41.2026.11.05.00.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:54:50 -0800 (PST)
Date: Thu, 5 Nov 2026 10:54:49 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Haotian Zhang <vulab@iscas.ac.cn>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: Fix probe race with possible ERR_PTR
 dereference
Message-ID: <znleorpqv6fey4tlkwzemxhqwxy7jz5lb4xoy5jhbfxqovjtpc@ueapczda74lp>
References: <20261104151550.215604-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104151550.215604-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: o4S-q3lf_lOVvDAxE8e1csySEyBy6Zpb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX9jDwrLBpKoQs
 m6QVG9VuWG0NNo0IbzkOmsytp8tco4DD9KB97kt6P8I3U516vkZW0Cu2KXEys1Bv3gal2+GhgWU
 zIeVXo2kq4yd4n9ZbVaQ1EbX55wcfuE6ZX6Xme9kmY42OJaqX1BPxUeHus9iq86frnuS/RaNmUq
 uDzHOh9rh8KQAF6ch88wBkZ6/2G01j8T8UKloa8KGTFDBW+TU1HNoRvFlFhVezdopjJjq04/yVl
 rt+NmSpzm2nvCM5kaSGW0f+7DS9YsMX0QeOe5ERBtHwpEvceA5jsCvyinYJ8NvYUo7AwcmhK6oY
 ZNeJLOhUuKFzKyeOVuW7fOv6IYMDmRauxE6yIVtOedqxqRhnNSJq3985Bjq9UKl3SQ4GAK+ngAS
 LbZXVjsXHBr5ai+2w7/9fdf0AH0gTgJwe57+wZ3dQpckbOm6W+a1S3BFBzvfwI1Wnim2xPADDQH
 GgonKOMuFVmGHXqqjVw==
X-Proofpoint-GUID: o4S-q3lf_lOVvDAxE8e1csySEyBy6Zpb
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec445d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VtB4zeJ1tuDDAJRGO14A:9
 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX78idlNYY+nKv
 cuqYOQGjCTiRSldsmPIscyN+0YUVQ4I8s0/Ej3dXzMzspZmwyQIP9DmgS0TXjQAp99WYOXFoXdg
 jdJ3J1LZoycaFvqsIlCD6K5soMyBJvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050035

On 26-11-04 16:15:51, Krzysztof Kozlowski wrote:
> cmd_db_dev_probe() stores the result of devm_memremap() directly in the
> global "cmd_db_header" variable and only afterwards validates it, which
> opens a very short window where a concurrent thread could access and
> dereference stored ERR_PTR.
> 
> Theoretical (not reproduced) race condition could look like:
> 
>   CPU 0                               CPU 1
>   -----                               -----
>   cmd_db_dev_probe()
>     cmd_db_header = devm_memremap();
>     // holds ERR_PTR
>                                       cmd_db_ready()
>                                         if (cmd_db_header == NULL)
>                                           // false, proceeds
>                                         cmd_db_magic_matches(cmd_db_header);
>                                           // oops on ERR_PTR
>     if (IS_ERR(cmd_db_header))
>       cmd_db_header = NULL;
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-1e6d9e1c-b97d-447c-9cbc-d874a0609918
> Fixes: 0da7824734d8 ("soc: qcom: cmd-db: Use devm_memremap() to fix memory leak in cmd_db_dev_probe")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
