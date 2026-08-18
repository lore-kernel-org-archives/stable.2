Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CC2DC331
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093193; cv=none; b=iAMyBS4yhJe+PPfjCmh95emq4pQu9OwZssOFak9QqbpcdOeF2K3w9UpbGscsJ1Kge4a5wlpRIJyu62yKitwFiOEbkdrFRnT46xDesrWtac9lJpmjwYfEIg9ux3MCMjPGh0oeUWgaTvGLjsejieuGvkOsqsoVOLlmC0kX1r9Eggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093193; c=relaxed/simple;
	bh=eFApLOZSBWmnyY2TVhSVebEYE61nBEFosb9Fx01D0uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deRZYUlnzy+DPb9S99RFdBoYUvbCiIRQiDwZNPEuPX3SxTgg+cjfqrV60mL6PIavs9Bepbb5OuPzAlLq9aGJbBF57cmlKOQZSwC4uPazvT/FjtwtdlZbEWw+XwuMRGGh/U9xz0paPIuNkdaRmynBDVSdZhRiBo6CJhD3E7zhYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EDtMXF1+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XLE8iHK5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDtMXF1+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLE8iHK5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ILbZ792428052
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Sh8SfUoyQJ5P7UWeAsnoUQ5a
	U0smLTQMJZkEtwRw2Js=; b=EDtMXF1+boidpuuqs3joyB8fcnHZlpC9Oi79ZT17
	KUdLDog8tdtNCQdcBcXgiyv/ES6Q37OuZXlNeh1+472oKmVNv1nXXM1RvEAyBfn5
	P2ay6xibna5oRUjVFk2nee6K3jLVf9wpnpexUZ1r7Or85LAXbKSgmblTVGb9AH8S
	U0s6kYzwNVhEaCFNke8TLYHG/VwTy/G54ALC62aAv3KmmBp81aWsdG4jY/x//VU/
	YBL5lD3Wv5PqVWotgLdWYfxI4rltkMjpE/eVqNZp4PU3HbQPd9kXKoBo0ctkIHv+
	R6jNMzoHxK8gk/zB0ZhrmeP1/yKy2AI2ef3SPKaCmF4a4Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfn87x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:46:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5fc4c7e9so57433285a.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787093190; x=1787697990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sh8SfUoyQJ5P7UWeAsnoUQ5aU0smLTQMJZkEtwRw2Js=;
        b=XLE8iHK5vsw4CuUYOMBbJDPfRlsY0DmZqiyzPFqF+CwPNi33L56CSshOKd7HuXAmBC
         H4Nfru3Nz23G3gBwlg7TLJmSReGhouIPdjoObZcAc+ilmW5HYoo4vvSimogh/DJUK8XU
         CoPBhKRcOmXvqM07Lc86sTGKqQRJpsav6pc7IzoPwbpzD6jzhYlosp5fs3CfYIjVPH6O
         Txvo5CqhUcWQkhrkGNgt9JtD/2Z1IhEUX9Z9cvAU2v3faf5sUFbP4am+75jafU+H/k+S
         nfzDqv4nOmvnQ5yvngoZpniRXcS6vynTtb+7k+AetF6JKLM1r45M11iaNSCyaW8LgzZe
         Cuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787093190; x=1787697990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sh8SfUoyQJ5P7UWeAsnoUQ5aU0smLTQMJZkEtwRw2Js=;
        b=fBKNsc0xIcR5+eEb9bCgMQp6if1z9BeqCP1WWr1EVbDSzcr8FahgEA/BWYUKf39SOS
         boS2ZqQuXzeqCWIXrp1lTLE2Vcpz+g9YRb4t2MhpNffnNovI0cdjP0abu7hk5BRq5vtT
         gsnJBron50U5HoVeks7Pm2tNBwxDR7P6kU/Y+dS/xyVPJOWqrBeLKq+jmAax/E6uCK3j
         j+dvS5ibERBF0DE2Z0nexeS0KmuNFPZ5dL+L00dDGuLtA7KyU9tZQRg78GT0x0FTb9pH
         +nS3rf01atyO7yH8b/xwbtZQX+huzyKM0wBPgks6f8o9ixemuTXWoOXPqk532O4NmvBY
         MT0A==
X-Forwarded-Encrypted: i=1; AHgh+RqqOv5ltpeZzC39Auz3emFmBMIT6IhyaY7zipfgo3oLvJ5JAFvw1+5eywjhehen7BfEmqt6ZWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQKrE1UPiuwORAS+u+6Mwhbb5U38Vsjg16OKFeI4WaD87+4kx
	2t3n/52DtLWKwtkOmifCUiJgGZeHHrer9LcejqPKHGJB2J4/g/gkR2Ju16LF6Niqwo4jZOIIpJF
	GHmGK+yyYLka0ha9ZMpiSUC60kIizBqvtqCOUmzDgC8ssM1txc1fNxPHTats=
X-Gm-Gg: AR+sD10cdPhMJnIiUrrBYkTCVN8rTG1RIuypYG0LusAfefff0ZqNGnecphA6S7bZ8hZ
	wSSUif8F9UJ7fchBW7YuIKnWMjFI4WI2cWPusM43HkC9oGdWwoOWrVADCSfiV+Y9sgz/eL7nYNh
	kH1RMp4tPDezP2mb0gLq7RvOYpJhHIWfx3UTpKjwLPaoj9rzm5gZ+uf0TL7OZazXWS0hdJrycn3
	BqZKCVjJka1NIfq3OjThA1XjybYivVT8oU+fBZo499aF/t9vUbUqPsiJECsJ7AiKlSUzrxApqEz
	giOR4V4lsfgkv1reUXz6m/pN5vduGiLg4zytkcjffOLchP9B53sakZwP7S1KMWIPstbA77MUMvb
	SF/0xfJJRmBMkIeEuR1F6qTDV6RyN3VmkBoef6PnjJvdcvfIN6SO4+iKzqSKN+Yw8fS2viDNTJ5
	5qCx0xvWHSU230
X-Received: by 2002:a05:620a:8011:b0:936:c6da:13da with SMTP id af79cd13be357-9371e2cf786mr78346285a.4.1787093190557;
        Tue, 18 Aug 2026 15:46:30 -0700 (PDT)
X-Received: by 2002:a05:620a:8011:b0:936:c6da:13da with SMTP id af79cd13be357-9371e2cf786mr78341685a.4.1787093190067;
        Tue, 18 Aug 2026 15:46:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478860c85sm40314e87.35.2026.08.18.15.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:46:28 -0700 (PDT)
Date: Wed, 19 Aug 2026 01:46:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: media: qcom,sc7280-venus: Add
 dma-coherent property
Message-ID: <2eg3aiesmouwzvdc7zbjesumsyiqnmxhc7ytwffzfn54ss67dh@wahz2pmmxssl>
References: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
 <20260818-iris-fixes-dma-pseq-fint-v2-2-8dc8c4b3880e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-iris-fixes-dma-pseq-fint-v2-2-8dc8c4b3880e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QedWeMbv c=1 sm=1 tr=0 ts=6a84e0c7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Z9EQ8daeuvN9kbJAhMIA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yydG7jzOwzonUxUk5sgUsaDWLLwrJefc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE2NyBTYWx0ZWRfX/kH8ShWrq+p5
 4CwHP5qj0yopvyFu5wU+udG0l/GO6O6Xy5045Ba+6gwqt7jpyKIZFwBKJpeYRKLuh+lJcDGkHRy
 DV6V65qWXrui67JkPLLnS3UYMHZcBKM=
X-Proofpoint-GUID: yydG7jzOwzonUxUk5sgUsaDWLLwrJefc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE2NyBTYWx0ZWRfXwb9xNbuGldVh
 ZtNhZM0BK+KizgkusW3Vwo8ZR+4qB6FXybFWIjP79XoJBqzrelD3P5k6TjLEiXbGCOAtkP/y65d
 zNBNvmsTxD4/mtRM0Ko+a5M/ou3H3HnGVO/JRgunIIm/TYPaFAzpOO7CziDCZMdt/emAGtbttOr
 bmkytMSlr6LLyG+sw4XePqPnCU6klSyL2ERwrlz7yxxWZSFFLRvtd63OYFmOMd/moAkzeaJ0dOG
 KvfMNtrsGxKpt1H3q0o5e8MgH/qfF85aYT3Eq10ARVj8An5FSX48Z4cNUmUutX2TDEKlSvFufgr
 nKT4ZrUfVNsSV9/cMzq+r14X5e9jMlDz5+/RjO1kWDHWzr9oSiCnBNWkpVqbCb0l3XIUGXUA6VT
 eCShorMR8Ysr1YIC29jC+LdEIA05R8p5tBS5NqIf50LFcMovDvlAvEZ36qIt1mSckWUXlqol5ZU
 xhgZqJ7teJqB6YvkYRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180167

On Tue, Aug 18, 2026 at 09:24:15PM +0530, Vishnu Reddy wrote:
> The venus video hardware on SC7280 is IO-coherent hardware: even though
> the driver does dma_sync*() calls for the input and output buffers, the

Don't mention the driver wrt. DT bindings. Either the hardware is DMA
coherent or it is not.

> venus node still needs to declare dma-coherent so that the DMA mapping
> layer relies on this hardware level snooping to keep the CPU cache and
> the DMA buffers in sync. This avoids the unnecessary cache clean or
> invalidate operations performed by the dma_sync*() calls, which are not
> required once hardware level snooping is enabled via dma-coherent.
> 
> Add the dma-coherent property to the venus node to describe this
> hardware capability.
> 
> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
> Cc: stable@vger.kernel.org
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> index 9725fcb761dc..cc31f3ba7e7e 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> @@ -42,6 +42,8 @@ properties:
>        - const: vcodec_core
>        - const: vcodec_bus
>  
> +  dma-coherent: true
> +
>    iommus:
>      maxItems: 1
>  
> @@ -85,6 +87,7 @@ properties:
>  
>  required:
>    - compatible
> +  - dma-coherent
>    - power-domain-names
>    - iommus
>  
> @@ -119,6 +122,8 @@ examples:
>                          <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
>          interconnect-names = "cpu-cfg", "video-mem";
>  
> +        dma-coherent;
> +
>          iommus = <&apps_smmu 0x2180 0x20>;
>  
>          memory-region = <&video_mem>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
