Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699732;
	b=v1mTrxu5JMt/RuyY9NOl6Mr25f8B1rlXKV+e95VfSqopRwY9fkZncDR19xqQjfLqaw0f
	 cR+mqnKZjBXOmo04fC5NyU25QIVJFUXlxCXUe3dUGGizpC0BB8xJWed13fSZ2vUMBI3O6
	 k69vGMgF2hasV5S1GV4hmyzknZTDYRfjbdyvOhB7+hVJzuHo2Wt0YG6KM1bHOisnLwFL8
	 eE2vlDc7DXC0Ufkpl3RwHUsCwqgYfK+3ubsJdyMEemWvgZ4GBVCeeHes4ugqU80O3vgBZ
	 proSd91tg/RhfxWYTUFWsRIpjBeLEHpOXyPlkN+dsFpBhb7Ys/E1AIe3dUbeoxXITRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699732;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lXjhq80fJFnA95T4d1bBkkRW6z+GaA4781tkMP0d2VA=;
	b=g7Onk+LPY3+vEuHqWdQdInvSxPE2brxLAcf/smtBJumWC2wPckAotCJpdwiQI4eTKQ4t
	 WcvhyPGePadIM+eEJK4b5V5kPmQ/9LIyR1NFrSRjigcHq908sfDiRg10IP316OBCmZ4s5
	 8zjNGXkjOMBaRFpsoGx+ACHQcWVX0jnCsDCSKBhFL4Eh15oknbisw96aobyPvlGesJpv7
	 vXWj5lvWaFPx+VB82FXtQSDzdWPdy9bJT0oglKiZjmrG7MeVY9+M0kA+4/UOnrswKI8jx
	 tAm4OmA0P5jTr6UXdkiJs0ZMRG37loBWh7w93NI9ibhfAIeS+zAaN9+M3OqJ+lWAuNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=glhrtAHh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ty7n23cr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532860A5BE3
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B532860A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=glhrtAHh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ty7n23cr
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A382ATt4002670
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 09:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lXjhq80fJFnA95T4d1bBkkRW
	6z+GaA4781tkMP0d2VA=; b=glhrtAHhzZLRW+IrXafw84382U0f16rTqbiYh4Vi
	7+Sf/7CsEBqESU6eeIHRCPw/ONkAz8mYPo4gx2DCW9rLkzxiYRROihFQlNpEMffc
	hUAYscpA/6kXrZ7stvW5lVYHR0sd0IUbt8WX8gaqyth3dB9IHiwy1Z0syKzU0IvN
	EmoICur/+6RJGX9LhsXhlDM8QT67Yuqkhaw7arPd/H1iQ5JltRZMgABJoos+hNJ8
	WGWW1ZqNP2iZHZND0eS5t+IYKVi70TIGkH9dulJcS+5wdwaaBmpi+y6+qB24A4C4
	/r3iNfBwUI3DEEh4jV1CWr4YmpNZGy8lnQ0ahSOiNb5TXQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07ek4by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:55:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-990c957f129so444744241.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793699730; x=1794304530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lXjhq80fJFnA95T4d1bBkkRW6z+GaA4781tkMP0d2VA=;
        b=Ty7n23cr7OYmfDt+wk+54hQv28oea+opR1DYhddK155zuu9PX/BylhjCEKxfDOIYjR
         g5Ia1gxe/vFsIDf3epARfppXirgRu686Jc+GG845sU4yW1WUA76qHw1sMKv4JfFvWZ50
         5S7gx4oNzEa/jaC98UJN45AgzY3yp3j0LOIJlpN/alTBOOBK9gf+ruqI27HVLzV3LxY9
         YZhoEQRDsZWwup5RTeBPelfvmI8fgCF0e5XfFmhL12zi52UUuiFZBSItEvAkY4f3Qt+U
         wVcwYwbrIDMdXVJvu72wslJfeMIDSnYoKdzh1rXTMWiIorld6WLS2xUPI/nI20h79+dQ
         HAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699730; x=1794304530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXjhq80fJFnA95T4d1bBkkRW6z+GaA4781tkMP0d2VA=;
        b=oT9rr0629/SmkR1A+InORiWG+fOzhglAUeRieODllfq5km8r/KgU8rzUpx2ebBkroc
         qURWpsHCq+R5UR1LZHemiCkHvHXqC1/s4eTzcbcrS/zcvDde2RiIQ7hAO5m9MIwp9Uyh
         AKox/WCnOmItvUIn5iSGzKH1pXqRH2p8eXMb2Yw3a+jjwb0kjHUwYzkrm9LljKCSwhyP
         nuS0OoXvxgV8ImgyzJRZGpMjPa+kNF6qGXLGaWaB4OvoZbjtti466NK5FquFXAj+Y8e2
         OS/85sedT6d9e+/vwjUztnwQLhBo7GDvK2UUY5Hrwd12URXf4Me2QuyooIXIbL84yD91
         CWOA==
X-Forwarded-Encrypted: i=1; AKwUvBzoX7vCScJl/hO7sDSFcCauBxEmsmX6FN7uuKkwIkXKYJqYjHds2h96vCcII8NwaKQn4RgLUhI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Kmd7kYCRKhswNvBQE04w3jTvKUAZSitfdDqwrF3GfbPktHWgB
	u0c0bFXCCwyKKjd1Jvps7h+tjC6AnDEONe8k+0UaahLMVvyDWAUD7MDCD/kCdm9puVstMKYaVYM
	PntKsJGHg0/8FTpLxS+S0eYT1Zak00jBSau4BAAf7bqXDQxGTl8w0rgYQdgw=
X-Gm-Gg: AYBFou3o0lv/O+Lc9seyVECAtf0hv7GhOkaF31R521VcftUu3OLc0DUMEU+s1ewTOTL
	DJ4QBKydCIovZ05FnTCZhQY4Mxw0Jls9y6gKaR0dsn/9B/aN4Yjp8MA3BhsKogBTX0GgOtUyxnE
	/+qYEEhnwYqGSXkyA8la8PGkaRE6yR/1tOyrHOQeegzlViTR5BdBV95uUdGT22YvhJ1CofShdP2
	G46cCPo2PxpSL2kFQmGOMHEhObIDGa1KPwVlhszOa60csFnGD+v6qxSUDniDqRxDfpcUeempeJl
	6DB0yFm1gtTq6dXsl6LLjn8fImOSQoMac1AYMXX6c9c8cmGmx8PFz5KV3HDNn7CCCgSG7cQ5Qi/
	F0kfiLT/CwHvdED4o3rZ+mnYk7ejB6oaLIihJTaWkSJka31mReYu/1sZTzjoEaBU=
X-Received: by 2002:a05:6102:4b0d:b0:7a9:e680:efd5 with SMTP id ada2fe7eead31-7d0542ccbc4mr4873275137.28.1793699729810;
        Tue, 03 Nov 2026 01:55:29 -0800 (PST)
X-Received: by 2002:a05:6102:4b0d:b0:7a9:e680:efd5 with SMTP id ada2fe7eead31-7d0542ccbc4mr4873269137.28.1793699729142;
        Tue, 03 Nov 2026 01:55:29 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71baa1b3sm23166849f8f.56.2026.11.03.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:55:28 -0800 (PST)
Date: Tue, 3 Nov 2026 11:55:26 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/4] clk: qcom: clk-alpha-pll: fix Zonda L value
 rounding
Message-ID: <k3pobjkp4kzshfftvszrzc2jfdezsd7hauzzbhi72gfmyisyji@a67eggd7tvxk>
References: <20261027-nords_dprx-v3-0-5d98b2c6c263@oss.qualcomm.com>
 <20261027-nords_dprx-v3-1-5d98b2c6c263@oss.qualcomm.com>
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
In-Reply-To: <20261027-nords_dprx-v3-1-5d98b2c6c263@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfX/YGe6j0d300n
 aq2OqasXo/cXagPN+LYXbuAKyw8Keum54Fa/cFGwUT8D1A4m/g8GtnoiKo81LczyuSXFSE5MIBt
 demtMIik8QMUsMgiW8F33NRjhbdx9Ql3uMeduIRbebfPKooiK1uT09iuuUwmPMGkDvOyBq6hWL0
 7fRP76iQntdjbpzQCV4LN8wDP17KWhH8gMFnAy5HZ7bNkvvMPbk7X+TxvY7Su0IKXcUKASWkHPZ
 1u7luH3O3xcUUAFL3k3tViILAY6LBb4ESPXFvSiVehr5aJppvKmI4pmIsFmzWt6MjyS8MEOp57s
 xCwR3G+jK0u86flr+lmq7r4/3jvCxSDPSGrEGok/C71KuOv4AUyMjYy7TtBwvJJk8FopiB4JHr1
 /HjbhOxd+vI1rEHSb6ZTzzWSJ/HFZFiJaL3vFelGZU+eXwh56KnyalX4cY2JlZDX9H0yqpxiihw
 Vpms0N8GZHnfcCrC8Ew==
X-Proofpoint-ORIG-GUID: ckjvRndoD5NHorBUIp9fYJCV-R5NI3q9
X-Proofpoint-GUID: ckjvRndoD5NHorBUIp9fYJCV-R5NI3q9
X-Authority-Analysis: v=2.4 cv=B/wsQ+tM c=1 sm=1 tr=0 ts=6ae9af93 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aa2JovKfeZIn8VmDcRQA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfX2G8A4VLBULyI
 1IGgfNrms5bbbdJb2ZT853vldu5CGIhw2N7/xLuSJne5lZj/iEC1WBh+c9bM+n/M9WGWxlzToWR
 /WIa0qGV2cMjczkOGAVRXX5SztXo9WU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030039

On 26-10-27 23:38:26, Taniya Das wrote:
> zonda_pll_adjust_l_val() obtains the integer quotient of the requested
> rate and parent rate in quotient, but writes the requested rate to L_VAL
> when the fractional alpha value requires rounding.  This programs a
> nonsensical integer divider.  For example, a 1.2 GHz rate with a 19.2 MHz
> parent requires L = 63, but programs L = 1200000001.
> 
> Use quotient when calculating the rounded L value.
> 
> A GPT-assisted review reported this issue.
> 
> Fixes: a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()")
> Cc: stable@vger.kernel.org
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Link: https://lore.kernel.org/9dc66fa5-47a9-417b-b8ff-b3a61ea75678@oss.qualcomm.com
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
