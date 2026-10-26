Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008344;
	b=EGwxNC14cSLf0qGVko/hf/+crzYhQ2LLhlCPI5CsuWFWEYHo1yP8ByRuNFstjeE6qOC3
	 oWnDKkWjEdPWAY9Bag4DVzgquf/DJji4v2wsPaA0idoYDq4W4PzZLrNr1S1aWaIjJq4y0
	 URB7Pf8L3mK1kpsVI7setUThjma5m5aT7w5lfy53SujgL18VF1VZQ4U+0NNnY9IQcigcD
	 esw6qrAYF2y0bOnm1rcK3l8gQjPGjAP1z5cCrMEhNgVhWffBH2gEmreSLYefVdf2FGX0U
	 p5mT26IbFl9vzKRuWzikK84S9QdohLsaYyoML4tOjlPZcgDcC/1JQf0lORvjOZAGPWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008344;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8r16PTsuyAmiAzOPbSM4Ko6zLElad0hZf/dV0vVWn1g=;
	b=ccmsayMpKvVKsrVuDITQ/hiT50xTfS5gcJz/mO1N5gx4o46UZMLkd05EkFo5onrFCjW8
	 rkXc2T+NJ6Ck4OKZMoYjtNLyrF686agtOWYer5Vzx+poNZTybTTVGpt0COA489kEM7UbY
	 F+EzYQg1cnIQq0OEv/4A4TGlGE1+852YxhiFdxwFJMtvTXcYq4si/8ohXW/9GxBAqV8JL
	 lBa7fXE51QqTtb/cdquLEd0SLXBy/xViQsFVq9fxjPncwyz4Cu2hwJOjx1ejJ2UyfEjQy
	 XVKQjHzYyVBxO44h5pge7quxnlnbkHP8rkC5AQkyBb3OgGb5ple2N510jH3kczDdhkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UOt3gzwq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T+rnB1Mi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E4606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UOt3gzwq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T+rnB1Mi
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b2WI2806372
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8r16PTsuyAmiAzOPbSM4Ko6zLElad0hZf/dV0vVWn1g=; b=UOt3gzwqp5/X1jCI
	Io2LU+WTnhExq2YTUf2cjNzlQFHgtPXtw0/sJHWKWz6RnPrQ0I+xV1yoNqveIqMg
	eqmdoSjdoYV77ppTP0pCOOzNqaRrBhW9eiMjEquyUMO0tZ3mq66gl9lPYAO8mvN8
	XOmrHt9Hnr4Dwm3in1T9WD7G2Ep8yJ+eGBVMYr2Qyy/d5q99uMHywf+LRApJahI2
	W855lwZAxdOFCO+H4g4nhmU6KfKzo472WhR1v6NkYOcu0HERoAcrpAs3fphfXsIG
	CiCxxagEL+r9h4H8f6mSMDxlOE3xXbXjPxgxzAr6aM9IjCAE8KLG9AFHS8D4AOyK
	THpY4g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xnv0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:52:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53635fe2335so2912451cf.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793008341; x=1793613141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8r16PTsuyAmiAzOPbSM4Ko6zLElad0hZf/dV0vVWn1g=;
        b=T+rnB1MioOQWl+T7nmlOci7ECBw8ne1XGD5uohDVbb4vZ98NtsJb2jHcCQeKUMrb3q
         QJpAgYkNy8/tp12x9/Qja3cYBQNM4UEidD6BT0Kji641pzEh7gG/750iv7XtOESfu3o7
         oHQdvkbjF8NzjQq3NhAQsAf6QMwjJXHG/zEAIcHASdVe6B1DPLY8q0tlJJPZPx+CvXRV
         M+L9VTfq8tFK7oyTpDsBz0coO36My0aYP4GHNU3tHJsbLCYLURicisl4GoU0GFuPcGEo
         Bud+1Obb8vSsAexzV7h6SmgGKj4Y6zYZu0Qco9lFACOqQV6Sg5JYa9pWfCS0zfPKGms5
         kM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008341; x=1793613141;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8r16PTsuyAmiAzOPbSM4Ko6zLElad0hZf/dV0vVWn1g=;
        b=ZMqJevLwYX4rCrmLxRlJBw66PgrtsP9X06M1NyX6IFnjBcs6iJgiaRQsztduA1uWfK
         O92nTSs8XUqhcX4UkRC4eV+FlZAYmDAcajdCmOzvbapd2phxG8mwy8cGFLuZ1n+9fALi
         jMaSR3eurWe433gwSTESUET4Ia4zU+STj/5d8f58/wEcNLHw7sRGqGGsW2NfIwN+ZrqO
         qegHzYtXxuoJgwHpYySC3mymwbwReKsvcLhACfOtqGcV2C5i9PbLfM6PitqOTA/hfuVS
         Kj0aW8l+64vH8Gz+T7D2j8+8/uB/8+bJGGL4kO9Cg490NnMm6q5U/M9PVEYscdgPpZDc
         /dMQ==
X-Forwarded-Encrypted: i=1; AKwUvBx59iXfKSGuClChb0x2GIa1YwndaWEH8MOAT2djdly5sMNtVsvWjrCQJU+2YLwaRsaQm4akwUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWQppy0+PVHLUgdGrRmxEKxmti6x9fAHTfaWWTlqV+CWn8qPb4
	GaN+n5f0U2pxUy2/YPfxzq6otl1KuA9/j4AuRepjKJwlC2jqU/5sAaRRTEdkMstUv0E4ZKbKoBn
	ZLR2hhocewOf3nFYaJvR8sKSqF0bCo8wMNtI/7zdSPhzD7JqOcz1URIY2Vzw=
X-Gm-Gg: AYBFou0+Hl5nz239HwyZRKyGyNksbABa0c8fPjesZxIHgjgZekeG0cb9NqqXILQR9LP
	IyRAPb5WKB7m6+K3xRnKQGFM2l1dtQExivpC9OEOEK77K8b+dy6yDYvHgjgWbFx4ap/wFRYTEkU
	/NrPudO3zCuXwenwBHHQIieUCTtpvoQFjNNDjgFnjxN/7wdhixKQNkwsqi2SF8OXg5xqwRjKqdO
	9JUNrpKttmwPNSQEXdT/Qp+4KJo6W0LXjxL/Vyzq26SlQzqGHsl9PxTeIBBgGT/q9bdnMmgcOXQ
	2A8kP+aQ1YpPHV53k4NV3ncQaTRCPIdFMtA29Dx4CiKpUzUUsm4l0muBZs3dtpCnXPQXEtN9tz2
	b774ebdaXqNzeu7f/Rtaxfg==
X-Received: by 2002:a05:622a:6804:10b0:535:f9db:3b86 with SMTP id d75a77b69052e-5383b504b5cmr93393421cf.3.1793008341257;
        Mon, 26 Oct 2026 02:52:21 -0700 (PDT)
X-Received: by 2002:a05:622a:6804:10b0:535:f9db:3b86 with SMTP id d75a77b69052e-5383b504b5cmr93393211cf.3.1793008340839;
        Mon, 26 Oct 2026 02:52:20 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7984e9sm296717366b.74.2026.10.26.02.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:52:20 -0700 (PDT)
Message-ID: <5d732b4e-4558-41d3-8c89-a2218c93d108@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:52:16 +0100
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
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Fix stale boot up BW vote
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
 <20261024-assorted-fixes-oct-v1-3-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-3-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PQUvkamGK3V_i0THNa3eYCWvTih5fQoI
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adf22d6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1Jnm8Am4PKJ2EhgLYOkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX3DJsxJE3CBiv
 bN6NADRnG9o1QPa8jWW5l5CKesaDQrk8NUFuc2WIXGdg7NbzblwGwWR8nXCl1SWCI68ahL0c3/T
 NvZOZ5dCCqQoocyvkyEpANqHxl0WXvI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXzgiQzKrX7vJ3
 mN5VssFJ9fVIh7amQ2tMmDotUiGHhqgLw6yYnPP3MbsWvlMYEJIgs09ROea2Z0bfq6lWc30MR2p
 A9/nWB4L6hh0T10HFdrD+USwc+qzxR5EpdqOconjpTAry7ZyABKza2pgsURzCcFiwJF1vNzIgwu
 c1j1RmsabQ+Qg4uBGN7raFWXWsAAKxDW8epYXSQrrRuOGAAQ7rwf1hjt/tXeolauOrEQeeFp85S
 DvedJNX9JcapxXt2pk/fA7hHQruWjX8S5VKlMRaZ+EX77bFWSebNuFdfn1anvbSRWWNkQELdxYb
 9jh4y59TppVlfbcYj/mT3adXcGemtJfzEPSdKLxJmGlss5u9Rn8QSPAFh8lfYa/bIhk0bC2ljhx
 brqSmCnxOSySbSnTgu6/N3krYVbnEFV3rXOz1KI9wYVV37tKHrQagmzDPBo+2zQVsPcBa1rBX9m
 49dYVzCyZERlS6EHEFw==
X-Proofpoint-ORIG-GUID: PQUvkamGK3V_i0THNa3eYCWvTih5fQoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> An initial bus bandwidth is voted during boot to bring up the GMU. In GPUs
> where the GMU drives bandwidth scaling, this boot-time BW vote is
> redundant and can be removed.
> 
> Fixes: 7047e655a567 ("drm/msm: adreno: find bandwidth index of OPP and set it along freq index")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
