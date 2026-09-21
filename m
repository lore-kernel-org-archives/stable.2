Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76B3C585B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991761; cv=none; b=VsUTdzNM1MXEjqwtImR+qEt7osRj7Evl7KXH6rr2zqEQJEmFhufp1QhZjCl2IPCHNVTMRGqozQSKsDD98fHHWPbfwY27ZX/jvUESH8WlJSc1Bmu5L2hdtmTlHKL/jgVN9tm8gCP7/o3/Dyg0ktV/c9Y/6V/hVjGBIxW1NWHzOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991761; c=relaxed/simple;
	bh=QM33p/EnGBtZK0CqjaAx0N/SNwLOCdwqPt4LLx0Q4pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRsFmbSjnt2gYGOoUY5Y24LHhlysKqQHgOt8mlxJYxN2x8Ay0hQaT5FaQx4thd0c3Lyy++sVpgdzRA6IDion0a48PWVuEoxMDKMZla/wVgKei6SSZxvdQVIinF8+XVfXoNih6xCsXv+ZdvJ2d8qVi3TkzMSv5BuZsThxijmdFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZvYpOW3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lr3pTnBg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZvYpOW3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lr3pTnBg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAe1pP1563503
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pCz5R9OTLvUBi0/Cp+vZu+bb
	lXkEmBIy3X7lCeXp+H8=; b=IZvYpOW3b3TUXtoEnOlI72w2mkb6PBMcLXeDSIep
	fBUu4Tj57G9+cvNXcyN7cc1YNgY6IIwp1iHR9zDGrTe7eHREbE5SA9UxFq2ewtsE
	qBOjHCOtwIYh79nYKgl1MgWH7ufkbpaJLEVshw8thvsHobuMyVEvhpCScIx9tU4A
	9m6VX1ZWBcEus83jhCpw7fNJAgY7uDRbsIbD4emcZdWyXlMO5chuDoWefE6XaFBj
	8JkYU4il+uYP83r0jtxpcc33WYAVWOujGjFkijWb17wAnOFbf5vOa88SHmuAlwni
	TK0OruYlK5W+tOeK/oHyWi+hpFbJF/o16Srjwdh8henXSQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw151f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:55:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so458530985a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789991758; x=1790596558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pCz5R9OTLvUBi0/Cp+vZu+bblXkEmBIy3X7lCeXp+H8=;
        b=Lr3pTnBgsMnG3VytlMGVjgifCNQqwEBvJ7Z0ovDfgXjY5dcYCTu3bK1TNfB1aeToCf
         VVUYz5dZncyUk2Wz2kd+0zaHDR5nOF7Xl+TyABixVXGmH5p6FrWcbSst7ACKkYuiNojm
         cgu6mVUO+Gj8/QZmgtLfYiN4TLdtYb9IwDabwNTmnqbLYyN5Opuz9Uqq5w8PLQ44pqF+
         aMo70WKoC3m3AQHoaLHt53xHrrvUd08kYElf0+R5jiPxHzWugGreHvIB1DIOj3F2zavU
         gb5qaimVL6WXVGuQoht/FOzfHmbb/Ce9c5n60hzb+MJ0wBvcouX0PE1GxHN6XqIJfBb/
         cojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991758; x=1790596558;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pCz5R9OTLvUBi0/Cp+vZu+bblXkEmBIy3X7lCeXp+H8=;
        b=LGBlFCaHyPjLk8rCdhijtD3EtbOL+ESozgnscGaSHk0dOA4VWU60Nt+8pI0KYXxluY
         vWmjmjoG5oL/FjZXPU3JGmSsO7NS760rSkw+R0l8bb0m+Y8uTtZo/pMY0lA9X2/CP8Kt
         igQGZLzTiHeGhWi6im6BKBm5rzdAL5o88jfN31L1CG+3fuWBl5LgzEzNbMSSEeNtBZ7+
         clkquWMTIJDRrr3Ogqb44OWB2O8uXyvCQtcByldHiHlGJpbgTiD+QFeoIVCaoW6fECqc
         PxK0MRRRFthZCfWAxauD7ddhz4EQiy247IXixJKfkU7tFmck8eTk5lPaKqnkARvcakX5
         d0JA==
X-Forwarded-Encrypted: i=1; AKwUvBzIBm62D8/oLmgHmY5HYt/yOZLPHlMtRGF+BY9uisscGvFq9GFNlpzjv7KXxhVYdAZicysRIDo=@vger.kernel.org
X-Gm-Message-State: AFuF++lyEewY+aanDVYlOF+A+A/RS+V4nu5d2FrwiAfYEkTM0gn9OjW5
	ynRu7LCX6IAireQTrl0YtpRtuLB7z91zb2+bJFGZ5mLipup0+15U35Px4Vkx8YS7IiQjJmoBcXP
	9VZW5yZABD/36nCpb5ozwyiQ0M312vsl5gHPRkl3BQVFyAxGt9MVoFEZIBm4=
X-Gm-Gg: AYBFou22/UB23ax0HBXjJ/desufcHgKxXzhnN6aWXzhy5oTAzx4Pps/J6nNlYxa4mqb
	HP9u/d/lOJ8dA1UhBNul1eEphMd1LGewp4Dd5npImeru8f9GLltAMkHuW6KoOfElqfzSHVSt/Mc
	f28FBY5wZMnytAtpl2/XZaqrYQxNPylnc7s6vgfuhhptMKipO5MLX/ppcLQZ2IZpOJGsEtTQ/5x
	P3vG07INBsmscQeGzC6B9NstZDk2+ljul9F35XdUdY1FSxLd5J/MYYNvrHo4/rKDXVNftJLaYCh
	LcF82yHKOtxwEN3R97Nl7m0R9cgj6PpmwSK3xxxhQLl41qfOuFRTu/htKnizkR6rZ4vJ4UdVY3b
	v/NzMtZdqAfRHwhA=
X-Received: by 2002:a05:620a:17ac:b0:939:b482:d474 with SMTP id af79cd13be357-93c15e77468mr17505885a.35.1789991757990;
        Mon, 21 Sep 2026 04:55:57 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:939:b482:d474 with SMTP id af79cd13be357-93c15e77468mr17489985a.35.1789991755512;
        Mon, 21 Sep 2026 04:55:55 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245645cbsm32971631f8f.20.2026.09.21.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:55:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:55:52 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE
 clock to GCC
Message-ID: <xac3umbsecmny7sul6zonikbuc7v2wgdoox2suvbpydzpqjdmp@ga4g3umtvjit>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3MiBTYWx0ZWRfXwMjZEQp5j5Kx
 ZrRUdP22HafXanTsVMoxY2thsgRK3jmU+pLZiTHAIlnkN6tyBAFRpK1ywCaGMIMAYTinhhXwZCa
 m9+/f4EZxGoDOPx2q3b7zXtUc+6HZpbvhKKvGHoB4U98+xKv17e/T+LqW9qTMzQUWaKXCoG6QWP
 Fpl8WWkqV69h/pxmuHsuT5Ip+kaRwqrEpdoQNUvNQ+MyGXgG0zV0eaCsX9IwGtfPvCgxHqZSScB
 aZNenkg6lyk+k6X3xeHIHT9mQ4p8hCf9L2fW5QRwrWAX/71pwFlnmHlpp0rzg7NJwn1b7gckv8i
 oE1gdTwlS/dxiZ+1f2GjmchRV56H/aWMKVo4m6YEG6rCMNMI24LanBKfIUUhADP1U52E6hEhfCC
 jbmfsEWDmuiTonLXStWaEmAFBIDnBNW2KxLG1yv4e1R8FVhFbtJB1s/JTHlRG8rVslMMjcZQvY9
 apeTg32Q1YgevScBTig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3MiBTYWx0ZWRfX3CygZO9fgaTr
 hK+L8SMuUJA2X755tWlxx1mm4mCo+MkmwvQ4rWZyblN1iOd0NgDyk8J+oFluv6lXEezdws3qKVR
 GLTGK6164VRgapEGZ/h6Xe4hps5r8gY=
X-Proofpoint-ORIG-GUID: dNdnTLaABuCx9qgeuxufwlFbB3qGfNm8
X-Proofpoint-GUID: dNdnTLaABuCx9qgeuxufwlFbB3qGfNm8
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab11b4e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=h3Rc7G0Mu9zKJFVqRbgA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210172

On 26-09-21 11:49:37, Kathiravan Thirumoorthy wrote:
> Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock can
> propagate to the USB controller.
> 
> Cc: stable@vger.kernel.org
> Fixes: a98bfb31f676 ("arm64: dts: qcom: ipq9574: Add USB related nodes")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
