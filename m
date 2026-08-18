Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B314453A28
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049636; cv=none; b=f8476qDS1HyXLeq31eGgyPxSG54UTiIxdCaSszY0T6wgw65dJzOlXuZMgkBMR3UfwkZT76DP1Q5ZYd3/74MxW2W+9yawq6pptmbIpF8+rDtaLAmC1k6xy3Z4OxWNZn134NJzf6F/8dQ6ESZ1cPB1uRcotXiI+QGajYrdOEycdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049636; c=relaxed/simple;
	bh=JfVZGKTRKN6UKtfQwoLir8mHm6Rec0fxnWe518wunG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4wX6k1z0DRCW+cRF4DB7HW2qaRy1/CmBoVGoiLPv6n9dSSjb5+oTRI0nAqk/oSWcapwHNcUc1L1+tZ9erFTUYqcX46bDBLNndFRQ4d7SgVx/rW6/WTDWJ34fMWBBN0TbHHBvUSosDImL/LJvK5jX4F3JR8bPO66olfazmD+UYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JzBOM1zw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QO5JLabw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JzBOM1zw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QO5JLabw"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABUYp1544793
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AnH+0QXrWlD6vyCJWXlr8r1LgxYaD69L2S6S9TrvEN8=; b=JzBOM1zwrfzILJEl
	xiCIDFHgpfHTv2BBYBURZs8BkOGG+iRDla0mPTLH4XPTybkmJtVPRk22Ep2+RIVa
	Ujc0ktiaFRJGLa/LOVFaCsZdWjTmUUnjSug93/xufxgJKS6StaR1eIMHs9qCVIpQ
	LbD6jUCEGRdgtFP4SrCe9UtW+IJY2vXGVr2XQ2XwZI/d5VoUnyrFPVj18M/MVJ9w
	l0AxGI0AdLDcASENkRVPK9u0foU/mKrCp18n614L+2oDF6gNv5WJJGx/UCwfIMFO
	dnmP3+VoMd1tlalk0Yllb2/PLzkOd6chGtZY2IyMGhGDgV9addMzlsmeabFZV8Wm
	VnsU4Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn26tb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:40:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930bd2bfc45so123071485a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787049633; x=1787654433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnH+0QXrWlD6vyCJWXlr8r1LgxYaD69L2S6S9TrvEN8=;
        b=QO5JLabwaHz2EkMl5tF6CyxRwEx8bC17DUBJDCtIysJm07XOm27yeMD8zf/ssdu+yw
         QMnrAA3ar1epbwwYgzFon/zbW/8Y8zYpMWJlVISDIegLzA7H563hH4KIKMyjoFKd9SAj
         ITX6rQep4y6qUiwuPNjrT0w9e2BUqMGHrLbNsDtlj2FJpiZHkIWcoPmr1XG2gj670weH
         xkDvvxbb5SLHlJQlFxCsZUBgHWNUe0ndbm7UnkGOzzNWSe42m38EQ+cRL4Zj6YwI5Sh+
         Mbj+i1oMYGIWYpu5eewMCaC9hTcjFJ9vzaCryCcGDnE+nE2WzFMwOoeX+O1vKQzSdLYY
         sWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049633; x=1787654433;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnH+0QXrWlD6vyCJWXlr8r1LgxYaD69L2S6S9TrvEN8=;
        b=KQGFqAerbQkihYjrTBPu+zKA0P6wZnGYE6lFC6PBdBpjpLxl77MHEOYH4mO1n8X5XH
         cYRsptXbQmW2RxxfoPi+83DGJzq9lAEwNjnfgA0xk9bOMn7H94M228jX7yNYqmuGB1fA
         t+nQFulpKtZox267Wq4py9bWFCSwgaGibNoPfEzCfCXwmxGkLMpuIP5C4QPcfteJlPVZ
         pDsYwojM2xU4b0idCvsXK02FxlMIuv8c6oVB8oANiUQvUQhhhdRAMrebkN2bLEwRmC22
         DWnELSEeMS2KWRZZG3rTdREr8YiudEQYTVoGMry8VGZiqWSH5rCIEYwK562xjrofW8MY
         invw==
X-Gm-Message-State: AOJu0Yy6/GRPXQsiP9ZWmhOsNAziVtp5ygQ455l7oha9XJWERM+ht0ko
	HSQFB8askjTlN1LvuKGlsxmnDnDmLNwjWGYibUZxMGbErq0FEjibn69ZHBHfNYvOoCvg5l0jM3i
	O1MKdyKxe34upjLXRBy5YQTJjipTbTtP9zXXbvBJiVhFaLJelE0MkfyBcgMo=
X-Gm-Gg: AR+sD124b8C+xWMb2ZO1ldD3HpWv+Ezykp8vffUZYlQWmRm2gmKk2q0D4JONtS9bIve
	qD5IoQPRhbayJzvK7YOvvBFlVsbxBIrXPE8U3fZBslCaVwQgawGXilkO3DTkksBbNnjEh8e2f5l
	BzwqBXDlinGSwwIrwwmsH8Ki/7pvpmhrylpYqZc9vFMbfB6B96MFoEVRNYXoHGQtXUyiMbXiaf4
	eXDPLs8D8KPh5iUqpGivzx5XeaMaV1vIz0iCvLs4z5Ha6TyruFgPcxuWQB8t7rvhTGtpe8EzmBf
	8ptiLvED11HqCCUWYt3wifKzikD4/Zd/jobOx8BejKyQ3uT+kWKbYUV7HdhZe+DMLCnMjWdpFVT
	1Uyz7Gao8612u4fVAwZX4r/P+
X-Received: by 2002:a05:620a:1a04:b0:92e:6485:f640 with SMTP id af79cd13be357-936d261aab1mr2297578485a.4.1787049633295;
        Tue, 18 Aug 2026 03:40:33 -0700 (PDT)
X-Received: by 2002:a05:620a:1a04:b0:92e:6485:f640 with SMTP id af79cd13be357-936d261aab1mr2297575285a.4.1787049632914;
        Tue, 18 Aug 2026 03:40:32 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d85886bcsm1765658a12.16.2026.08.18.03.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 03:40:31 -0700 (PDT)
Message-ID: <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 12:40:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
To: Guangshuo Li <lgs201920130244@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260808131624.2854412-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260808131624.2854412-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RplkYODTodrL2ZIbkBEQoo93KZMzCfeM
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a8436a2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Sp1j9OMB0jjwDDl5ZD4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: RplkYODTodrL2ZIbkBEQoo93KZMzCfeM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfX37I7bKP+hbwR
 w5sn6ZbyR8NhfswXvF7Ei+IygW1hxxNOZSoFpA+jFJy550Rx1ICQ02V46Gmn+eM0DhdXcLPoUpT
 Ke4r5JE0X1OzufxjhhNM1iGlEhJ+uJ9D2S9I6SI5+Ouspew0Tw7DQxevrj67Qc6sD7hj14cPVM6
 +RY8F1/fhP27rwx8hz98Owi5ssjbH3RkmjSZa8cj5gAOwaF7i7gb+5qaaYafF2QbVHDMK0PTYhM
 3oPogbzAA9vBC4Maf1SLHVDLKdvA2yPew9B8jDEkj6pIV9wikbTkU0VrLEruIAwoN4JIVERtAzx
 CnaMT9tAV232rw/V3V1+b1Yi44ZMozp9kXe3lowj8RTwCr9YWd0fDHu0mA7zhGkWGH9UVfoTlHs
 N6DIFo2N9UIWrrZzMafhiTtnbQN3K0ianwwsTfAi4NU1tn+NybS8kUrPPRPd3fcYvhcKnQQu5dX
 KRiIp3TD/aqIubq49Ug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfX3yFS3h81UJpi
 1/ayguSnTz0xlPSdlktyTMhsqtoQk3yedY7WUfsk1toDK16Snlm8Oc80FSpFivo8Fj95klrb3z8
 eckA/zFo7IGaREB4O2lRfiuoqARfKR0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180078

On 8/8/26 3:16 PM, Guangshuo Li wrote:
> adreno_gpu_init() calls pm_runtime_use_autosuspend(), but
> adreno_gpu_cleanup() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to
> adreno_gpu_cleanup().
> 
> This issue was found by manual code inspection.
> 
> Fixes: eeb754746b14 ("drm/msm/gpu: use pm-runtime")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

I think we can use devm_pm_runtime_enable() instead, which will take
care of cleaning up both the autosuspend and runpm halves

Konrad
