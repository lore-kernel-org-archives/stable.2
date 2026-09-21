Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6982493D3A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992210; cv=none; b=A6MimBNPi5g6YQ12jD364lvVTKvIjx9CuWnDMdFEun8fSstsh4lMWjx3yZnBx76ugzb3IV8GXmvajYY2+JtMoyvrmq82BS9GDr2wIa673cohSFDwhYeUZcYu18v4tMOiwpohXq5Tg8SKwulBhDh2WY0G2sNfbK3JQhglNSf6Hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992210; c=relaxed/simple;
	bh=scRw+GVm6s7wVCc9nPzG2SgvvrPpNiJqmfTKziigzDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWE8vizW5Rt58agxI48MCQNUYM1KWebG+0bWnZfiqJxskD/jYMpf+MsB52WvL5O1NO3yYTlSpD2NKkCDdYedVskwnf/deX5oYlbhfdpY2T1wEef/PUDvMfIUsqhahhWv07rASN6+9CaI72nwxnyNp8baKWIxvEk8vgF2LBlmp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OGkLbO9g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKFxn0dZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGkLbO9g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKFxn0dZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeOVY838159
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LuUiIezO2nuT5fNMnrZdAnpP
	J1LY+LflVe+Qi9hbePE=; b=OGkLbO9gyndnffTpRHHgHLpbV5cjhfg+nKcTfTa+
	iQ5TftiIuo05x8opyACoMOENJxGBZ/3Xk88+FzDvmm5oK8oui4RXMS6xxGDx37Dz
	sUSufxNELrGaLW9WSwkuS9TDsT390CgC+l5qp0uE8z1BOamsnqPO7HL6VvJhmKIo
	OKmCidjWsNcIB7NGKksHTC85XUCAn3f585XpVoMgBmJGCMt522w4dhqqOtcLE4+w
	Eu9fK6MhdJKLYdc+9NAlZE5ePTgcob+OyfP8eT0FITrgXsXfSIz/vTpzCGGHGJgU
	4ycX/kPYsDs4H6MltVlwYzqEPf5VzlSgKklrRqRI/QgRSg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hpsf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:26 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-790e3ca4c85so644397137.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992206; x=1790597006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuUiIezO2nuT5fNMnrZdAnpPJ1LY+LflVe+Qi9hbePE=;
        b=GKFxn0dZNTejF/A1JgrOKgXwo7ZStSE09ahu/Ml4Dc4Vn5gZh5E1izNBZNd4VyrG1z
         B9ocngMyfBqkONzW9At+ZbW1h6/aAZs5o7ZSp1hp93BL00DdBESCs1oLCkDAbZ9hZAMK
         pQKs83UJNFSPeoVIcW+IDg6T4ivYXw55EjwpcWarLj0V3lXTcPMmW02/WbuhzqbVP4aq
         +DFoF/uzpoyCCwlTSHnWkDi2RExJ0XSxNRBj0t5L5l67MS3ZaNVEbEsG4/WsLNEIC+jM
         43Ub+qim96jiy02QApVEy+mJqg+YTZj88DYNyKf+4hl9SB995r0xejyxAAfsjKBa+6n2
         aXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992206; x=1790597006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuUiIezO2nuT5fNMnrZdAnpPJ1LY+LflVe+Qi9hbePE=;
        b=AmGGQMe6y7AtEOrdrgHoVZEoB/fzHhyo7PX+WpcFi+YKe/4eyEo8oauNEVyZvxG1wt
         O7CGnUsD4KJCWTI+Z5in6WAGvuWR+kopi0mN1vSWHY41rkTH+9DU36ePhJ1acMoROG3s
         vrWh6LrzvbWOZIel2xVcvEcJztdpoVQCSv1e8C/+DA7oWWFVRg5BdlYL92fqqPNHedZI
         PZyeBRfC4sBxAx1a5o4Pgk32ZBSiHTV16Mb5uYykaZqdDP2h3D7Ev1hsC4y4XJkQ+KR8
         tnJVfcy21/YjgLlFvMBolGzKlYsB8xvb75VpXlxQkHl7ktZ4hnZZHrXaev7Ix0fHukuF
         Ay3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwjMPiidwnYMApxEF03u1CesgHz5fv4fs7wfoALHrlXtEdKgrdIAnbWkA/s8l9bxpbq0+IGyJg=@vger.kernel.org
X-Gm-Message-State: AFuF++l4vFcJt/61+7k58NeMenPWzOwuhOanGUp2sbVpPoaDC8+pYCZZ
	dR/wSEiSCU/szKOxiQWaenSUw8I+zWlvADK1YPnJEo3PyudGB6YfA++K02i03iMokxcQUs72oQl
	lAQ/42W55rrRdApK+37CXgk+b7YP09NLGtTii68T5TUxwoxtyqWp4CEfTums=
X-Gm-Gg: AYBFou2Mt3wCYUHbEM13IJmhdMAn76UYPGNa8oxKNsdvRxxolDBYvggCDYQh5D1PxSw
	XXfNlLoeFYcldPAONm4xgkEvM7rBOSu7o1zDQSToZba4lWnRA/MQ6+fEN3F6OAxf34Eci/ZvxVZ
	cQNqNDQCEWn4gyu2PQYWSUy5js/p1D2+lgVmR3rYq1ufBU+U5NAdX5LA1tE3d4DGmM0F794Oj6G
	vrJ9cDjGpvz4/221PiI7EGMgkQtVIKdccMJiEQWj3KgsRM+0t/0I/m0NVdldd8PctN82LPO/Epw
	eWqYyU9n/STMGoyc2wJmZwIxeB+odZPoHdYVU+BU5eNzDpUSZr0O1Li4uSVT5UxDvLjPn0G+mmQ
	QhQDhcI7rBvTDFA==
X-Received: by 2002:a05:6102:3e87:b0:7a7:bbf2:182e with SMTP id ada2fe7eead31-7a7bbf21e16mr1506169137.9.1789992206083;
        Mon, 21 Sep 2026 05:03:26 -0700 (PDT)
X-Received: by 2002:a05:6102:3e87:b0:7a7:bbf2:182e with SMTP id ada2fe7eead31-7a7bbf21e16mr1506089137.9.1789992205486;
        Mon, 21 Sep 2026 05:03:25 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0735c9sm222876985e9.6.2026.09.21.05.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:03:24 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:03:22 +0300
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
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/11] clk: qcom: ipq5332: add 24MHz rate for USB UTMI
 clock
Message-ID: <mfzlmrhupyqxj3pj2h7rhqigek2gptimcpcvtn2sk7zfzhj34a@od22z2qpdynv>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-2-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-2-d242e3d49648@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab11d0e cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JaUoqYncsU2g2DIqJJIA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: AAGNU-bmm0qbaV5HE25t-hXagW42ftFt
X-Proofpoint-ORIG-GUID: AAGNU-bmm0qbaV5HE25t-hXagW42ftFt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX7SEi4F4JM8q9
 D+1jDVh1apozBL1u6e6uWNchd5MKFap3iuvVMiAxZGavdSkObPH4/k1ALhTxaNYEGR/J5z12o8B
 srS4/5yGttAjnaW2xzYxNO3ZLp6ev30=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX4GLq8ksJ1MRf
 bnFcNVx5PdwkB3Ul30y+DHYvW4uUGzM0YV8Ewfi5JtFn0oBMIXyAG6nirYCwd4LR0QqkEvBx9Yc
 kjvLNaGg8YqTSIull6wtgrRwRRMhbTXxZzWk69sVkrJ3wmoMCkSPQWd89HbzUyodehxslZLVs1r
 INDv15P5Dj4Pb3FXPuxGfj3ciMGSVsbuRfhuXegP5EozkJTxqt/IchwqmEpK2ZrOvaudZv+k8aR
 yhyUNCQ2NRDi3MeT4zMCDzmshf6dnU5O4FJL5TEXiM4WUR+K6nbUXdKLvAsWavPh/0JoTWwxr6i
 M5c5NTPyjr647YtkN5IYOORp1/F6MMRvWDow3wk1l0axFcoSRfPDRDCwF3VT1rTVDruumL6SDAN
 Ke9KrWihFut32c/skAnlqgjMDRPQ43//Se1k0olDU2+ClJ7eCmCXavkkSKtMXmFTllfWugnKIOP
 v8vBDiL+dtgDsmZcXGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210174

On 26-09-21 11:49:35, Kathiravan Thirumoorthy wrote:
> The USB UTMI reference clock must operate at 24 MHz, as recommended
> by the hardware team, for reliable USB operation.
> 
> Validation showed that USB 3.2 hub enumeration with USB 2.0 devices
> fails when the UTMI reference clock is not configured to the required
> 24 MHz rate. Configuring the UTMI reference clock to 24 MHz to resolve
> the enumeration failure and ensure successful device detection.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
