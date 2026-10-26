Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008143;
	b=hDvPN7h7EKRGoguugxd9RXAoi0mGU8QQT3oZ4cx1cTxVNaBrOHj4n26sJMzxPEx9DbRn
	 CjXKKdG4ckKW1dqI4XO4fYVyJKV1EiO4s6DEUvcLlJXePGgzuHKquSfmU96OBrxeQEPUr
	 OxYDVgriolLPh+IL+hoG+CiE142q+V1OjTQZnncjNvGIh+Hkn1qGQ+juy4L8crGaqdEeM
	 iHQiWO77wY21oqsEnqU5l9+BETcTaYimrpNj21QeXpPts7dpjR1VRnns/SFaOMhPpGnaL
	 w9EFHvyOIbfPSGgvD9oeBULqlVeV9bdm/t95ZlWzQOS5qDg8Jhchc79AlHKq82cwNNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008143;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Yo4J66E1A52hv1FpviVs1U4slnxqRGnURqACyQE31qo=;
	b=m6v7rVTjQ/VO4PRUzc28nn3fdnScnR4fmq6UyWPPZoD8sZhBiwmBImCFea1p684skwC0
	 5l/dGsdPrvh6Ea9mfNPth5O453ymaUfmCYib7/5QOVdXU82UxctddzYqBl/cYE/sbS9dc
	 uovatLVxHU4p1yserBvvXbOOZBjioo47sZOXhjeNKJsETfhJ9XSWsW9waZvjQdHRA9GSq
	 htf7l05h1IU2wcXx/YZZzSMYyWUySRIAfhvNmQxSyPpn/JlqF/taaDag22FX6Yw13XCDu
	 YKanRXgXMC9jKAHy/F93AXbfqbAtBuWMA1QQHwoyIGRWWpUQFKfFxCxaaUTLVasmGvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7PtfVAo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=egoBADJ5;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FF606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04FF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7PtfVAo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=egoBADJ5
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4afgI2222806
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yo4J66E1A52hv1FpviVs1U4slnxqRGnURqACyQE31qo=; b=o7PtfVAoxAtxieXR
	qRcE9ZdSLenSgiIBM0TRYc2MvEukOTH9Z9A7NiC15tPKoUryXat4v3SuvZObO1MA
	9AQ7gR/UwJkyZmGX/5PatiGk2jL2lYjWri/GDgm7FqSiNVI6DVp+FKNkz4Uab9m7
	Is9ISRdBmQyMwCVHrtF6ctgXt2LW0rq0h5F/yvNJrZ5ZUfW/Elg9cNW7uIhIouPP
	s/A03M6SO660JMWH9rGl6TXjODBfe6B+62xJD3B+UfC3FVfoXXOETml8lfRZufM9
	z3n6CVU2wGlwQvfyoij8mzLrZyIm0ObEH82IcdH1Ugzox2nc3N1K3IcW2RTvt1QH
	FxKY4Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9hp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:49:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53657d237ddso3469521cf.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793008141; x=1793612941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yo4J66E1A52hv1FpviVs1U4slnxqRGnURqACyQE31qo=;
        b=egoBADJ5StUpbkhy6BafSyQxOe3H4jRPiKcC757G/T7izxLvwxXuZ3FLUpjoVBtVz/
         T4KwdNtQqSRCXLO1v4gHy+FB2W513f+Pm1Q917BGQuXfhxsbR5J4pkH9swCD6kps91T9
         t5vU34jv66iQY59qDhUXE4BY58jE7ARbxlPITjDydsqhjfbVEAMuldqKXFxtx3lNr8hM
         wuoYcJFGVmcs7AMjXHtF0bic5YcNHnRsE+/aDgB2ST/Fhmy2Sjkl8nSZ65DRuWH1fWWj
         4IXR+MZchXpZd93klFxnnk/3P6gIs3GPk0+rIpxLo3RqnYgvQvG37uUXZuGH0QqFvMIv
         iQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008141; x=1793612941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yo4J66E1A52hv1FpviVs1U4slnxqRGnURqACyQE31qo=;
        b=mRnYNnreGPBGBVWw3p9DPbH7BnGZtlYZNn/8ukiLamzlwdHwqLGwOeCS3T6cDLn/wZ
         tkFaab/k3OOTkP2OEV9KziPOOOlZ6Usz1n0+e96IFMFJhIa9aY1hVuWgSdn6sU88cPmi
         ctIdoFbBlU0/N/g1rLEvQVW/MVWFZHfYZ1vpQ7ZosUVK0ukWsmarBljtbW0kU/2NsK+R
         KVHlc+1n33spvIWOcye5elm9Kfq99nBY5HvHc57H5EvUp6tyaphScRbtP1WCBGotvcKF
         EcvSsiHIT/+8USRxr4br01U5NlNkKp+w3O+Wxvhq4VQWaALjpb77RfTlt9jBCTixSBFe
         nitA==
X-Forwarded-Encrypted: i=1; AKwUvBzqz+7uoVf1R0AiceXZWjsHQTWMI2qZJRHkMPKA0Ex9R2m5QqAT4lrPScRqyPiZw2WijZ6LuEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIx9Nzo89aQSQYjBQ7AKHenGZcguAfKAESkSb8d1NW7O4GOnOFk
	IXFQgyfi9X2seEwrJiPzWPY8H+3d4FBsSMAYR+gWHXoQntfM1xVx7J0043Kw+NreYd5p6UdHjym
	jIDWEZoU7zNMZ3OALxhVVA2oVwb2xxU3KKB5DF5k2q9kUF53nm3OBBAlXzdY=
X-Gm-Gg: AYBFou2Oj4bfcfZ4pBW2THDkMvGGdAW7cTyVPx+uh1wKe95wPWwNnHyN3XQRKDHgir9
	edBbfVZ/aZmkglW/1EiWVLwx3qTuzcFsK7HL+jhooYRcdxmlEJm7SHms7s4AFiGXToQxeXbPvbi
	sBOYMrwtNm6i2giplNWtAWUDzD2AKM9xo0nyPk0wx+PcCWUA0WsHnteKRtgZogPqoxbEV+srsdA
	PCJ8EH/nd6jFXx+0swwBz3i/62qi0zN0DpLrDRT7LbQE/il5kOpUobL/a/S2JNDq87jxoFlinum
	eeJmZIJAtAoUquVyp08I1Rot365Vkqc/geJ9gGJPC/9mcZ9/07vm5sEBcW5WxeTQxJBC4TNFcRY
	ISQcE//EyS+PaLWIFz+D3sQ==
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id af79cd13be357-940ef8f51fdmr891897685a.3.1793008141053;
        Mon, 26 Oct 2026 02:49:01 -0700 (PDT)
X-Received: by 2002:a05:620a:8a87:b0:93e:571e:94f0 with SMTP id af79cd13be357-940ef8f51fdmr891896285a.3.1793008140702;
        Mon, 26 Oct 2026 02:49:00 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4459924bdsm3349750a12.37.2026.10.26.02.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:48:59 -0700 (PDT)
Message-ID: <4fa0a55e-4446-43e5-aec4-beb6108b9686@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:48:55 +0100
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
Subject: Re: [PATCH 4/8] drm/msm/devfreq: Record idle_time at GPU idle onset
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
 <20261024-assorted-fixes-oct-v1-4-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-4-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cHs_T-ETMYpiVEn5RlpoyjD7Dqbf86l4
X-Proofpoint-GUID: cHs_T-ETMYpiVEn5RlpoyjD7Dqbf86l4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX9Ttd/fhXQ5/3
 WS4UTJP2TBWb0Jdz8sDgO96TWgTiQdg05wF+xhHT9sQwoXdL/2pAIXELV87SPOTxloO0QvBslYK
 nQsppr3V4+PjH3rtka3hKSstqz+AmFHZrVzbE5FvMckY/WUCZHtVEn0TOFOmHdhJPJNcugtS43v
 sFNkRrLs+MDADjM7UocX6nvdguYtCFvN1XsNyeWRNggtFt3xMf0lsoVe5R45i1AFxKq0kDNXioX
 GDPS2fNO5eFg/FoNB2YeXhjq13s5S1U3nGNTrqlXPHmvW2g5wGiO4fHlHQCp670hu3xd32/LmWQ
 reVQW4EYZpR5JPTXIuMtoGg+jZ1MshorrXEudFV7/xa0LR7dapnibQ+t+x3wCSgpYv705lyhcJ+
 XFToH6azZYpkoGvDQtrvQvNxucmQPcWnCHfUTB1nlL6TS2Q0BpUxxkG0pE03esY1AzpdPAKcadV
 BFigTE68ArKJiRcMn3w==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf220d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=TPaDMEC0OJE0i2k_fPcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX7uw6isE2nkPZ
 4m0GxzKW64cKeAcezziToRtUsyQkRCuJubuX1blI8OwrRDYNMxHukl0s55rVFPz+B7Nb0XARVJs
 d/1VFW6T1Pkr19lwDw/MOXR558eELPs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260038

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Setting df->idle_time in msm_devfreq_idle_work() means a cancelled
> idle_work leaves a stale timestamp, causing idle_time to accumulate
> across idle cycles and potentially trigger a spurious devfreq boost.
> 
> Move the assignment to msm_devfreq_idle() so the timestamp always
> reflects the actual GPU idle onset.
> 
> Fixes: 658f4c829688 ("drm/msm/devfreq: Add 1ms delay before clamping freq")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
