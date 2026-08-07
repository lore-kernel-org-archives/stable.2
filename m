Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84441364942
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093312; cv=none; b=XqOtariHikn+EhoDl5ocr6/Wgl5e3gDhECtP3RtKnhfEJSM3Rj6HpHLpYJJoWBLWogwZ8PkFrSB8djJAP0hYH4ZqdK8as48uvKIDZpx1yOkYVMik5G0V057uAKbMSWSMsE1SHNZr3s2U09tElmU79HgSLo4FkW6kF7GABOpN6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093312; c=relaxed/simple;
	bh=T2iUroCXlHi4fsuFredMnF0BlejS7IOAmvSaP/SLWlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJMlUgTNDkVSdb9HsISirftPtrAde5gxunnqG+fBsc6UHY20fRq+GpR2VwPpzhDROCFuIy3YGL7qTdQmva8seEBga0MkYs61DNhegHcJrg9JYhQblcNSLwRTU3HDGEwDHxdXMKm3TLzQbKW/QSNU+XjuM1lp9Igv0j8Qx8+APoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z1WX/Nqy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F8rPTcPc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1WX/Nqy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F8rPTcPc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777wmGQ3519182
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 09:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YED0O9yc/XP1k6tppCTUtPZg
	+CU7mFNMCOh1afWNMdM=; b=Z1WX/NqyPUNs9S5BzAdWymCxHW5lVFk03F4u+nnn
	l5l3bhyB3r6AY0rJUFB4Xv/FWuHjZ9cnpzagSe+7Rn4DrBibB3/YUlu9/p1A2nAK
	f/Xjv/761SbT10bgx6OOUwNfv8ny2P3ZN5VAyUejpIxZeprWFZAvbsgxwJZsVtZc
	4qDbH5slj17RgRPGVULbtZ6WdEIlq2fnaiNwBx6kc19+vglVFJz12q2p9JE7AsvB
	C1zHpI6NR9a4mjZIpF0Wrq4NxD7dGSFBmNBWC6c5DvryU2HgbCOiSPIBKR+D7auq
	d0y5svOQPc8ecZOfFNK8ptB8Zi8x1tPtrSE7Wv3YCpJVgg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6s36g2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:01:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e9489f62bfso31970796d6.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786093306; x=1786698106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YED0O9yc/XP1k6tppCTUtPZg+CU7mFNMCOh1afWNMdM=;
        b=F8rPTcPckuCKH4fwG4VnIQC96MN5P4qsNozS+d4XcTOG0ulCCyR+1u7+hwPOBmQXbv
         EVG9RGy3Ci2Oxm2OLielGD5T9N7HS74tSZvfqiEnFdpvzjKU+7PXBr6nlT+CeFChFOyg
         3rnRg6xuRg6ubjfrLUJXmLa/XShywcE2iShra45sRbKFIFyzBHJF7GebvEYX5fXQ7C9A
         fUGy/+3pJKrza2fKmj22TkHBfuCBbJH/VuFuRvfc6v0ajgZT1iSwGY2JQXQumiOaT6yT
         m58dXcZIYx6v+l1rg38UULo6FHmQDBv5dmhXysTI3bkX+JDI2OPLrKAdonYa6IDD+bcx
         e9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786093306; x=1786698106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YED0O9yc/XP1k6tppCTUtPZg+CU7mFNMCOh1afWNMdM=;
        b=npuAiwIhyMd5Df2jMffaWSDpVm8LCQpcs2vmjvEYy/4c5oGhexSz4uwDjy28Y3MJ8A
         rE3E0qQ+PFSmkWOKSkb5L1tFxDUSGP7cnxLJHOJKVFwEqRRQ1JIfiDpDNTzF+TRyBzE+
         xpkzhO2cKHSSXhom1bj0U6hLREFhW9MXJY7im+/3BRy/blxFZft9IwIMhtoZXanwYqDc
         PKt5EwsPylvkZyeYgeCJ+8uaHOUpRnX6SBnDE6ltRp4TFHWsGUVh78bq+pKqDxdwT15y
         suorljMNKCK6JMIKKtbSH6J/nlpz5y+PvTbg/HFXINyxtawr2aFXlMJNsi50Vvz8fvKu
         uHUg==
X-Forwarded-Encrypted: i=1; AHgh+RrMqUB+Eos39Kr0W6kO5q9BhET/GpQsXfoBIGDiM6EHtdQLUVynKR2D1wx8F21ejNUpdRCZpu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRkWDJPgZ4QJjizpvnqoqhUyoyRwx+eE2AIJf8Pzv4o08zBSt
	IQVxEY5bAzsdViz+1dgRBTG0T56KgeDThlOQEgEioPopFFb5uejXiwrbjh6K3jvjrYIK3r7XpxC
	9XDcuTE0TLzQQGedFcCX2T12n2bUntWMSNVCu3pIypKSeuAf7cUVbiRygV4I=
X-Gm-Gg: AR+sD10lkxbOP1SEOU8iF2fLoVQfdb6wUO4GZif6v8kETDtNw3I0nGM4BCcFVCW5Mar
	gE96zYmbnHTdgtGvb0rB5GJ/kBPU9JU3vNi/Bz2S3PBnR4AXlmzqf3KSJR5upfU2/Zgvrmk3GcM
	+i44Z3PKbzvZuwpd4/tEJ5QQtRDKSbrxuxTQ+72KXWlWoUqlv4jch7oK7+QjUUycMtm8M4bYFoR
	6aAOlEltljlEC8/5+vdxxZCKRggekpZYwll8/GcQbf4SEOtzDpLIRk3TruRITSlbfzCvekHdNLz
	kNRf01Bvx8xr+W17/XNiN+d0FiIiI02zYA6/fgcEfKvdTfzagTprNu9XVetVu1WEVPkxGXP3Tlb
	BU9uAVRDaX3M1Ej/ztESFU2tNxi7J/eoh6lEI3oDsW1Ph6U1pr44cpNmLoIQxk//cc+AQ92Wc1o
	MTOAImRmL3qzemBQ==
X-Received: by 2002:a05:622a:60c:b0:51a:896c:9ab0 with SMTP id d75a77b69052e-52ce5fd70c0mr216394141cf.10.1786093305684;
        Fri, 07 Aug 2026 02:01:45 -0700 (PDT)
X-Received: by 2002:a05:622a:60c:b0:51a:896c:9ab0 with SMTP id d75a77b69052e-52ce5fd70c0mr216393441cf.10.1786093305168;
        Fri, 07 Aug 2026 02:01:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fdda80e00sm2320681fa.9.2026.08.07.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:01:43 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:01:41 +0300
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
Subject: Re: [PATCH 02/22] dt-bindings: media: qcom,sm8550-iris: Allow IOVA
 reservation memory-region
Message-ID: <ghcgm37edokrrf2dvy5jbajlszcndaomt5h7fvbdbm55qrguqg@npf2vriye3j4>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-2-3996f67e33f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-iris_iova_600mb_fix-v1-2-3996f67e33f9@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfX956m+GQLwtTw
 iILns7rcTyBstUpFOWrOlxTwoWGGkOXQ2zSNDfki8ijGroXARdWR0s5/yq+E7ym/eoHHfS1z3Ds
 ML/G+g3AxcLKAILj8SiylTmH98CCMPM=
X-Proofpoint-ORIG-GUID: RHsBf9UyOt6DUL3I3tU8ajQHBMUm9uis
X-Proofpoint-GUID: RHsBf9UyOt6DUL3I3tU8ajQHBMUm9uis
X-Authority-Analysis: v=2.4 cv=B+eJFutM c=1 sm=1 tr=0 ts=6a759efa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=t9ty7G3lAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0XZovuSqt_3v8KxE6RoA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfX1GG9bJhkG8Pu
 T7BZaYfLw6QFQVbcmjoLAo37Fgr+lYsqGim5AYPZ5LZrTFcp3XrLHE+x1S2A4isigEBnTCnqYjO
 YixIO1MKGe7Xn8bUSD+CA6rvTqSSDPCTKS2kIVq4WytwOWQqs3w7Ncb/yEJWN14ESnA2IgI30zA
 rRTqAyVNUC8buESC7SaAnsvCXg1oBXXuD8l3qKsYuoTae8l2o5Met5CQu6oWcv+2KtR965oythI
 vWAAlsAzuWonD8lFeK4s1ZGAeIEe+F6Lnlq3LChAsWZqJFDO7Er5MdvNVlLRjrKQPg+2ISVYeoc
 wziE4giHl+BRQueu/ZTsGuVnddpQh6xiNeCWNfYrOFNFe0QLH+zt2/PAfR+HYiprGiNFu5PEuQ6
 ENlpQavfsPCANxV2ITv9YCKHQt5NE2yqQmA6+A25G/ADW/eQaO8kmh41mh1LvxFicctnmOoQEis
 VOuWUGHNZhob6CnUNSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070067

On Fri, Aug 07, 2026 at 01:54:46PM +0530, Vikash Garodia wrote:
> From: Daniel J Blueman <daniel@quora.org>
> 
> Non-pixel stream IDs should not allocate IOVA space from the 0 to 600MB
> restricted region, as this region is reserved exclusively for secure
> non-pixel.
> 
> In addition to the firmware-loaded codec carveout, Iris platforms need
> to declare an IOMMU IOVA reservation (a reserved-memory node with
> iommu-addresses) to keep DMA away from restricted IOVA range.
> 
> Permit a second memory-region phandle for this purpose, and describe
> the meaning of each entry so the ordering is unambiguous.
> 
> Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> index 0400ca1bff05dcef6b742c3fbf77e38adca9f280..7dff7293fd5c834b0ea617ece87ffbf0d40e821a 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> @@ -84,7 +84,10 @@ properties:
>    dma-coherent: true
>  
>    memory-region:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: Firmware-loaded codec carveout
> +      - description: IOMMU IOVA reservation region

And how does it work if there is no firmware carveout?

-- 
With best wishes
Dmitry
