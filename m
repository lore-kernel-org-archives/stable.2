Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008055;
	b=LXEA16OpirMTaqXTOt4lQKs+kcTeQrwWTt85VY0eL/Hnp2452/jO/qvG5fdaczz9xr+e
	 h7s2nf2xunWcDMe+5yG/QPFWZPfPf0Mqu63BD0rvRz1rpifsKmXCJlrgIe3oEgKri7QDV
	 irUKWQpwY0IvtQCPfo/3OUvFiS3hZe+BRJnikUDnqafB7FFhcfT+5dFuqMg1RkSkiETci
	 oOUUquyNgTPXd7Ql5mZcciAJUkn9ZeBldwyMhCCaovV0fkZC8kloqlHKJBzHo1N0oB1Ni
	 KsQRg58G16GJPKhDFlegSdvSq5Tmqynat+Um9P3k3NT77gM4NiN+swtMPlgsIi3RjtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008055;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EvvplJFfhyuyl66C9bJB9eiSNKH9CgBX8ofvcWM2oto=;
	b=H5luEEkOEX3CeYciT6wXc8mQSTWifgBrz0AHtXgtkScoqNGy4XbnDFMJ7DuNeudtLIsa
	 X2SARroog4Mnl+4+EzchVtjLM8Zn4VwFnnu01+f8XxORHDmh+50T5czgOvsVxdg5sCYfp
	 nnBLMJxILi+tcssJqs4PAMWlJ0qU2O81xBDMpr++GJEZeT6ZSgCEuqp2smJtcpRsHKDA1
	 ffPPJ/VpUrZSIAFb2u1Bdw/g0oUCvh+hSeD3AjijACOVI8s94oe59FCzlV6260Po4pcHy
	 BJTFiyUXa5zLLfAbVkAM3xzkV5aLh923DrhlH9kyiV0gj582VosKIVCS0e2iVi5vHdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hYNzNYxN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QG+qJitP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5660A2611
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B5660A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hYNzNYxN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QG+qJitP
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aQ6A3300584
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EvvplJFfhyuyl66C9bJB9eiSNKH9CgBX8ofvcWM2oto=; b=hYNzNYxNpZUjWKls
	QvHeOhnNOU2Nm+KKSGOdRsMeYRWFtGso4ZLfC5YrZ9wH6VCKfDVSxMyH0Uk9qE0t
	ggJU0bFUFTVsdpWtipYHDtwTmjtXNeSHCCqnCgrYwSc22hB8u0HXH8FFbW9/A5xv
	qPQh2h36K81i2Bxd2AHk4v1W/RI861Olho2RfSPngTiHfaUsDqWAeCtZBMcKEdTO
	3qM/nZtdagc1K2TlsQmg1eJvC+l2scyn5DUbbCMKzJO+y1rWuKEWHkd6cNblT3vP
	ME9ZRLZHWFuI+Tadro4UdwyrGDD4+H4Sk+s/PZz1SXmRoQTKmpfC9QLeevokoGEl
	1uYiqQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpsssj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:47:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934a8cd3a8bso34745685a.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793008053; x=1793612853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvvplJFfhyuyl66C9bJB9eiSNKH9CgBX8ofvcWM2oto=;
        b=QG+qJitP858grVQ0VUiOw9QWplLb8jhRSl6LWABCfl5vX6ZR67gW7GhGr4WaOothQ6
         7b4//Ul6Vpk0Tb0g626q05ryOBIxcY1xrCgqFppc9qLUacIgZlblbWyxZ/+DBz0coQNc
         FGo+xnOfgg0+b8A+1sPnNIZrIUgzt/pElQi7gs9ISSljJK+bGOW4d4V9w7sRsoM9ZDih
         Pp+neG5eZFCJSDmOZLCOdcY3admYRdD0P5+l8SSCEVwYmXt8gg18h4lGkkw9yTSHUiMJ
         eHf97KaP3RuIokwq7zm5MnkjBFB5bRboCcZmkrUuo//eEh1I66PJoK/9rMPfnTHOTKDw
         Rylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008053; x=1793612853;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvvplJFfhyuyl66C9bJB9eiSNKH9CgBX8ofvcWM2oto=;
        b=jjpwsEoXdxzK9QYWrT2l/t+vKLMcqITXLFDXhpy2NoeKwseNWSGw1J619+uY08K6eg
         Lqg9lkP8U/BwFVz+HzuAqtAuL0I38feQZVIoaFs661x6lYmSrwpt2lqqKXgQNZRY3iJe
         h0KJIDPPpT6LIG/IQzaJ6xxocqIYZ2brJEP1tv0zkKPNe+xe3Ag/lxgJQu7WPMMotBDF
         B1GncozQyAIBwKVIZLbt0W6uYa7TRxJuc9ew+FlnRwxj9NjV6lXPf/bYkCNcA4BsGfTY
         srAkFq2hlt0r4gtl0Lj25suZt19c0ZcmhkIwCHgswdn5kbSyd8VKWa1m0qDKoDUSAqdh
         gcUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdI5JsEfb/V12Ca7g5l9l0Tvnmh3hsAoWTd5pQNYyPN4llol+5I2DjWHuU5wopAU/ZPdlM/3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjyosISqcVpg5MN9mD4Z8P4Lo0HzuhgTaxQbv3D8HmooIb6TP1
	fKDMg/01bMzgPE8a4d0MEl0PTrq+0zpo+EkMVRq8PT60EjxvkXOq4cWZnmfLgso5Cd0+lvQOmVD
	jU9AlSnBrGfSv5Eo31bxQnrUPk9i36gC2FIYlv19GKY2yIjRMR9jVL+t3HnM=
X-Gm-Gg: AYBFou0WWtNtlH+WKu7D1LnfvIEQKyR8lDCAgRnqmSc2PGOTDA+21oDqHwR1uHgvcoy
	G1jdB4zi1/lrjRUg+hUwxbJq+IL10ieZ2UOlwqp4VMJY62R/8CBWg36Kb0fe3/d/AfwzvePV6Bb
	vFxtuA5uHHf9bOgPpJ4IhsYCh/xU00ZL9bNqbTKw/SXIgwEATBFaaRCLROx4Se3AACp4mSF2U0U
	NiLSGdZjanpc1+XigBQooQFA9jae8g1KvKBj7BwZcWEANNmRh6XDQoG0/9fF4cyAKszDtqhmazc
	VFqRZ6uBYMeAgDt9DKafeWJVxvb59pVayiHuAMS1ZwFUtInTAyroTb1yrdOORqgJw3OrjhtfiLr
	SxBcXnJFzA/dXqlj0pcGCcA==
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id af79cd13be357-940ef8ec03dmr1009174085a.3.1793008052870;
        Mon, 26 Oct 2026 02:47:32 -0700 (PDT)
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id af79cd13be357-940ef8ec03dmr1009170885a.3.1793008052401;
        Mon, 26 Oct 2026 02:47:32 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd64f8b6sm295595766b.48.2026.10.26.02.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:47:31 -0700 (PDT)
Message-ID: <48d378b8-ca15-4e80-9c99-d4610f6657fb@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:47:28 +0100
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
Subject: Re: [PATCH 2/8] drm/msm/a6xx: Fix GMU shutdown idle check
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-2-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-2-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX5FzEJuNVtwq6
 C5TXlvxSS0mkByL2G71awhpGiHYK22QnoZ/Qf8TEhXO/mKzPUJqRvofguGZLNkbFeKTbptDNH3o
 jcGXSAmHcRoOytKgoP6sU+ZVm1Q5yZU=
X-Proofpoint-GUID: 6HVynhNLXdnFwD_O-vETpfxqa2vuHm5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX07UnjE8tiD0p
 scVDl/BRgi5m6tVZOvOg0wCM03h8JXzdCnHqwRKLIoFkdnG71/+Ifittu9+jxX5Wz3SaN792OvZ
 +cVAA/7IAJ5+snnU47Xc6LjKVlHjOaNZq/VVKStTORSucrjqjZfhUC/dW4/ygcLxyFI9LX3+EhY
 HPEuHs3AADmOvvAbCinnMwyo9oLotZarFL2xHy9lStqLjei9Y5VM9VSAwLI7J6Bbugz4JJVSjEo
 tWUknd5Zh/k7FOGHG1uZDJB50+c8ltkl15yWCMsWp95RNZ3akf+zNb5tVppvT2ev3KHiKV/yNSc
 s9S9AOfXk1S4OUGzjNx8rAocZUVGFOB+3iWQreU7zZmk8DRIgf5KTU54CV/w8jD4PtjvDu+pzhG
 C1jxYMMlppJhVthsI5a37jJAEnJfiTPynU0Oub2gjReW9Q8EQNnTETUVRTWXWVsjx3fXpzbQ1G1
 1m+NoX5GGnJTWSCTSxQ==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf21b6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=TPaDMEC0OJE0i2k_fPcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 6HVynhNLXdnFwD_O-vETpfxqa2vuHm5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260038

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> GPUBUSYIGNAHB only indicates GPU hardware busy status and does not cover
> the whole GPU subsystem. Use CXGXCPUBUSYIGNAHB instead so GMU shutdown
> waits until CX/GX/CPU busy activity is cleared.
> 
> Also, increase the timeout to 100ms to match the downstream driver.
> 
> Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
