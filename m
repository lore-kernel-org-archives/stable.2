Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F33D1CD7
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093438; cv=none; b=TqSN3W34LMzmBSdZdtuqETXXazV/PHs+N1VJ7YNJAzr/OtCiQMs6W6kq2veHKghX30ADMAwrExIuQ8Sz+omdm6b1lUU25vyHT6Hyzj/rjm6A3C0S7HRwpQjqAO0aT95F8IoZ0PLkDO652SicTNk3x6qFw+zBgVXL+Ybr/tQiIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093438; c=relaxed/simple;
	bh=6qpm1hYr5RkqGjInfrEiDCqKYgYPp4MbvxjnH7VHeMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu73QmaBPMh4PWosg84gsV5CbDP/Do6V9v/JQ51wE2PTaFvI20id1QcSyGA9VWUvSAn6SLeKBqc037QgnR2cTCYRERUqpjDCJLz8y6aUtN2fR8fH5gTr+yO3ZI8FdXaSHb67S0W9iIsEFHAUxkRMLrexwK8uo36ow1w1dr3+M+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrebY/ox; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PcDsyxGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrebY/ox";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PcDsyxGK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6778FvLr3477036
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 09:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5Fd0jxP6Kyr1lTjklAhR9bTt
	VEDBHCTLrVECFH+tmXM=; b=VrebY/oxK1ULEBZmWR003ElIvBMt6M2Vr3K1Q/VX
	SPWfMmBODxOD62KjYFBzesL3ZAc2pmitjCrdwjxmHqHmZTW+Ay3/o4py3+uTmVAQ
	CVMHtR1Jr+Rgps/PUkAmjlnRyka9le33EQDvpNeVyWJJpsGDw8LqstTBzUqvMqVi
	wxYuIIOpMdDp+0yQUICv/fFaUG2PjSF3wuYeBhrGoKaOxV9pCx47j4MyBh1xrtiF
	7ZrEWxS4E/NxVNJTYDqrpi2XFPat2nrhmRJ2O7+7nI/HmBUxT0XQX8O7L2T75Kn8
	UCPlQnXZFxGpGCaNFBdmk5j1lNuxL82fQGzXxCAC8QHMhg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hb5tq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:03:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51ebdfceddcso34101831cf.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786093435; x=1786698235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Fd0jxP6Kyr1lTjklAhR9bTtVEDBHCTLrVECFH+tmXM=;
        b=PcDsyxGKGPHZqRq8S4OEjxDf6z6Pm4x7HvCDBbjKUFrfebCLSPb8+C71S+jINf/Os6
         KA+hI+bzL4BUJTH8bCLL9yWdlpFR6IIv07J28rHk3fhfFSE3mr2by4DqQdJjRQU8Xbfv
         v39vjuI93zleUDHFzLjp7IrC5Uvz7/5MANF/ZAHxYvKEeqDK6E+umYxisk8sU/dnwNaL
         c41a5tuTwzQUVJIn/NzDG9uenzq2cK5VewhPiDqmcMP/Ow8rWgYcGS0uy2KLWBKPcWS4
         YYwadkHRROneV0ZlwQOjDMLDGFlIgK+b5CmpFrf2JdkHHeLHkR48Z2apNRQFjxX1z1yT
         eL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786093435; x=1786698235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Fd0jxP6Kyr1lTjklAhR9bTtVEDBHCTLrVECFH+tmXM=;
        b=rC9+QiCfarqQ4R3OXSH5E6qyb2z5Rh40zVTVTZcQHyqUAF/CI7KS3DYjwIb12DVJm1
         MwwydWuSRH3+L/2qkoSszHr+MonLYFPunnrNPeE6Im/9dbH2J6QiEyQqJFv9DfQip1My
         PdvSopQYcxBkFntYl9gXW/KSAAKM+i+TIa7EbkyaLhS4ufoZhftwwprdCzpo6lR62QMz
         6RWJsqO1BiD07QQrIyhCHP+Rk+2Jg+bgP8Rw7pm9e7pYYR28cYzEa0430pqBUuwRn3Sp
         ApVRHY6ZOR3WXWKUtUB19wDLexFi2aQvaVyxvuPqb0nPHBs4dnp5OEyrvxuX4LqziS5s
         ZbZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3rCscAw7LfOkQvn9+GLyDBiAzFguhlM7T1gVo34vfsuRdSbp+PRvNo5Q+LTbjUTUpEDU2pac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9X2MaZ6f2PRQkYGN7kXtTzz2u3seOnPY+7ZqwpayeM3yZWrp
	xu6M4GwfSLd0jvUVsGYnJItw6RCeMm6HoypIJaPRFaVru2EGaZCohE1YUfJrxF4czgVt7t1j6oO
	gi1/qrqZ0MvHWFdsaR0j7BpisdPcGZ8YxYWKvSUt56B/2Y4oxayQ0D4rbNdY=
X-Gm-Gg: AR+sD10JeyMti8LUwUngjD2mhNfy/yl+rFZHwUiLA4lOYu9/Xz40ZqiZCuQjG35auBN
	a+dGBwp+iCWedSp0lKc3yMYG36zcn/DxTTUNlV+dDGnClfF4USTl/GSiVV18tnsfX4+XdK20yT1
	H6dIEOiTECLnAugj2yBzrmaeyGAlm9QQSNtjfkOLE6W6A+urCdwTF/CK5ElDRBKf9i6oOXL1WkE
	NThDNxTqT17ITxK945UGyvSPZBQrIdo5G2qmNqMGy9QiXGsIO/laaaUsuwhAE+W7DlaKCyX1AZg
	dGrxQ7eza9TpJDO0DzHQ865OqnMrcLf4teOHrFptG4PFrXr0B6p57o/1TWAKPTuy4cHW6M1FAbr
	yLr6dZkd/Zfi8IiUt3Lkg0TxEv5I9cXTeei782quTFYfbB4ny0mw9I4l4U13tWy5xMJ0JDGCGkH
	yA480epXwLUjrsSA==
X-Received: by 2002:a05:622a:591:b0:51c:b900:5136 with SMTP id d75a77b69052e-52ce5e1bb5dmr213222051cf.0.1786093435402;
        Fri, 07 Aug 2026 02:03:55 -0700 (PDT)
X-Received: by 2002:a05:622a:591:b0:51c:b900:5136 with SMTP id d75a77b69052e-52ce5e1bb5dmr213221301cf.0.1786093434942;
        Fri, 07 Aug 2026 02:03:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3050cf492sm344135e87.18.2026.08.07.02.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:03:53 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:03:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range
 for Iris
Message-ID: <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
X-Proofpoint-GUID: wVUquBo8ZT3FC2PNZyl2XJJ_iJ3S_aRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfX4iSjNmPGvEtC
 Bw97owInftbqG3+liUTwW3HXXJfvSPPgBrtH9aftmxhpurqutHO1rDftVraNl4FYJfdiEKrK1ZB
 pqeXHiK4Ngzd7+ENcG17omnHRww0vobGza86eFiZrbODdSa16Ug1SSVI5sAp50o+1RERgsVT8yd
 pty5NqH8CFDuiz8j6IIDoBj0SgocYYOJaY4Vy0/LfXtcsp5S1jJMqN9sstvjiiBs0JILIo/ORnQ
 7eLLkvWtPZMs5gRCpBDwSr1mSwRravo6cPhc/bP5+5cbtIkTccHVcxWe0vKDWpBpM5HKkz/vbNP
 e927Y7YduQxRe2E1/8kN+kCrHHgo8gFmqom064kCcCA607o60qK/vp6GAxP6momH5P/iiQhtQbQ
 4m2kerd0KokUQTJK9fjRtMsPKm3RoULrkJuhHFRu5TaRd7Qm1kZTqKgkPb0o+op/Mitb2KQsis0
 V9snKhfd2wuUMPFgBxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfX/L8wOt2wcfSl
 XhE/PFOXg6lxSw+5qUoHnhgoT913Z/1CLZJM4GBVKM+JBjjNeXWhxRWjRGIhk2uNS4/77L965s8
 JoASlaM+TckRyO/Uv5FC4IxakqfBuKo=
X-Proofpoint-ORIG-GUID: wVUquBo8ZT3FC2PNZyl2XJJ_iJ3S_aRv
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a759f7c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=t9ty7G3lAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SZajUbaRgOUCVt53atAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070067

On Fri, Aug 07, 2026 at 01:54:48PM +0530, Vikash Garodia wrote:
> From: Daniel J Blueman <daniel@quora.org>
> 
> On X1-family hamoa platforms, the Iris VPU reserves IOVA addresses
> below 0x25800000 (600MB), primarily for secure non-pixel buffers. DMA
> into that range, from any other stream id would triggers unhandled SMMU
> page faults that cause spontaneous device reboots. This is readily
> reproduced with one or more browser tabs driving multiple concurrent
> video decode streams.
> 
> Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
> and reference it from the Iris node so the IOMMU layer keeps DMA
> allocations above that boundary.
> 
> Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
> Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa.dtsi | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> index 8a96ea1bdb9c4c409b2af997680d8c13fed0643e..87f424765d513c97b06303bceb75ca9f176d2ace 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
> @@ -666,6 +666,17 @@ smem_mem: smem@ffe00000 {
>  			hwlocks = <&tcsr_mutex 3>;
>  			no-map;
>  		};
> +
> +		/*
> +		 * The Iris VPU reserves IOVA below 0x25800000 (600MB),
> +		 * primarily for non-pixel buffers using different Stream IDs.
> +		 * DMA into that range triggers unhandled SMMU faults and
> +		 * spontaneous reboots, so reserve it to keep IOMMU
> +		 * allocations above this boundary.
> +		 */
> +		iris_iova: iris-iova {
> +			iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
> +		};
>  	};
>  
>  	qup_opp_table_100mhz: opp-table-qup100mhz {
> @@ -5439,7 +5450,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			interconnect-names = "cpu-cfg",
>  					     "video-mem";
>  
> -			memory-region = <&video_mem>;
> +			memory-region = <&video_mem>, <&iris_iova>;

I don't like the idea of this series, because it _again_ doesn't tell us
the truth about the hardware. This typicall ends up with bigger problems
later on, when it starts to affect other bits and pieces.

I don't want to NAK it, but I'd strongly ask to reconsider it.

>  
>  			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
>  			reset-names = "bus";
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
