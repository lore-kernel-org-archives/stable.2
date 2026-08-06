Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08D393DF3
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006680; cv=none; b=QSdlv3I0C4hAF4G8KlH8ylHpo/LTK22vX9Mml3HoOUDiIU6CPFbCLQT0QE35FHqMQJ6cG5h01X4VaOIFkURTOeLLjcepL7yei/CUYfLsVAdVLlyLuEW7LNcHKWGKgpQZtLN7BvF/TWGOM2UHSXBi0+DP+lFcy2p2yQU1cwZt8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006680; c=relaxed/simple;
	bh=Fen3/2fyT2nxbdI13z08g7FVfDpoYlq5UkDkITq/4Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHqQKMJW9jU+rXX/ozkOzjLOGI3NVGo2c+p/P6nG7tHjDEXZOF3FDWJO7V7OGlviLqUibiSTjJy4RBRjEEt2El6TK2t+M5Up3GPFnpEIS5+q9lKdHFzEWtqty8Bx/pRxTp3OJQEqyA+oSw9zzyrKI6tY1MbqfG2VuuSJnJh4/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSfCm16V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YTQjWbvi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSfCm16V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YTQjWbvi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6768v0fL1980127
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 08:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PCJUwbsaRK8wt4Wj9xYnHB0Y
	srg8kjvYnURoW+3/53I=; b=fSfCm16VZCzZ2bf0yNVxPw7fUGC+28UxiwmIa0IJ
	dWBz4jBpmhtmXUN8xgX5IKqakbZKFMhcoPmLUmpPF/Sz84gXSxZG/yAZp9BiKEYA
	JlqMEVQcxG5QMcc/cstYOjzBMkThmhV/aQHV3aSWppV1IrmGs+qkLfSJfo43qZFc
	IssRE3U8Fdz8wNb6wI0Z3ZVE0gaXPvHHRI5OcdLUML49YyRWeNf6d8N69G5K3cPj
	HNmocnGVzCfgFuTLTHhpzTwXqItDBQ9rPWyFFApXpN34xwyLNDG8zNeKiumjB0yV
	hO6NdWjze5fM4+8sQFaVqLRCEfavKSBYuSlqZOTMlfMeQA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq73005h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:57:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso35135686d6.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786006677; x=1786611477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PCJUwbsaRK8wt4Wj9xYnHB0Ysrg8kjvYnURoW+3/53I=;
        b=YTQjWbvi9KckHe6ZKqD99AMl00vbi05+UzVlSWqlGgQ5+gxO+XHS67jMh8uES0j0KY
         9PbbiqGktg07iXnbceqhJoy7vrCmX6LsjTfHr180lXNl6HnJjWdiky5xG8ukTpT1Do/6
         /GdVB2uLrYMTjHHPxwLCrRxUK7+XHsneGBUdDOfoals8VhwbPyqX0CDRWYPiFcEVN4UK
         EkPFVqy8uraYY4RZMyKKPqg21mTw0d5+73beCPxnjULBLYZvbegJ0CLRy4EaFpvqaMPl
         kO1RkzJ9iBnU78zDqNmvzkEpIDb2fwtKmuARTEJkehY3pKWv1e9inpaV6jBbL8h1CgtU
         WKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786006677; x=1786611477;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCJUwbsaRK8wt4Wj9xYnHB0Ysrg8kjvYnURoW+3/53I=;
        b=jHfKdLy0Qy7CfQqmD52U9yhCPDWyijBC9FCKsxgeaCK0/p42P4lTg1gmTWX1XeBpUh
         nLy/qrJqem4nAjI9W4JLT9zBdKPI6TUYByRcW9ylI+wcXkdkNePJvBdN8RAw1Xzrhjoa
         c6sel+kQ682PrOWU/KlMjRS9VIHWRUgBmt2DM/s+acYJ0E+uv/VBlD7FhSaqumy6FkfJ
         q92mXvABIcDR/MVJZ1cqjWoilblwQrMIRO3QM5ikR76P/hZAs1g9bU35u88XnUTsVUis
         FmOfay2Hf1Dh5TkeKX7muZbNwL7vGxL11xk2B4TCJfQEjVXNxG2faCMh/XGJ+s9DBSNc
         H2/g==
X-Forwarded-Encrypted: i=1; AHgh+RpsZLjV0EAA/KJXfUtdrCey4Vhu1qh+HF1hB58T4TNpNHg0mKVye70wP7mB25lwyMWCWPEA8Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTw816RW4RArBDcRRKYIKXPSaSwT+EJylzohxQpRILnpWLKs5Q
	7XncJVf7XMAmsNpZ8NLn+nHKbFmr6CLrKxKBAxzwONGUrDatzDSlCq67FgAtKLrIOw+A9fi2i5Z
	KHfT/7LgbqLnoV1+qF7opS2frzy4WLfsmGmbBD46EXGxrTulszsEB6ZtrSng=
X-Gm-Gg: AR+sD11WN05Qk36HBHKGdnp0abC+oeVq3/7GFPGDeLIJkUBJWPx/NX7fU8AMNbMe3T1
	ZrCyK3M+48Pl1SDRtU9Lg6Xb2SK2ovUpAcJGKUh9WKaL8fSBC6TFRIdLjv+01LfI3/5UByTWDtG
	d28Yld/a3+FmVhBtpWFtbAUb5ksn30yFFjDLsjV0oQG259hBxI4SgucAeMlYDSJqtgnKzCZ0k+d
	rqvB9kwArcuzZva/RjaMz3UQBQ4XtrlwEgQxpb1+5peT8F9WWyv+l7AzztFmJLzxBoZ4/9KxIUI
	Qvm+4T9X84lgoWse227SFnHCy3QG4tJOUwkrh8yvTqttOPjf/iV7NMkL8tIXdW+jpDN9uQiGJ9d
	jBxpQGyXMnv6JHabRC+GA0PzCnCkEpWNtblKdKJ8JnA+kSNjSvvp74Uf1LrRBsTMRWv4Env2sR1
	praV/xC9uer/hR1g==
X-Received: by 2002:a05:622a:58c4:b0:51c:1027:34d4 with SMTP id d75a77b69052e-52ce6007ef1mr155713441cf.11.1786006677298;
        Thu, 06 Aug 2026 01:57:57 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:51c:1027:34d4 with SMTP id d75a77b69052e-52ce6007ef1mr155713081cf.11.1786006676781;
        Thu, 06 Aug 2026 01:57:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f6236405sm602068e87.6.2026.08.06.01.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:57:55 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:57:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH v2 04/12] media: iris: Add helper to create a context
 bank device
Message-ID: <o6s5kezlsbe6z53jbsezeixp2wfrmwmvwda67t6chf57jnbm3x@ta5hktzs7mdf>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-4-da52b5228dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-4-da52b5228dbd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2OSBTYWx0ZWRfX/cFsnBOFplm8
 pTUAmLFlb9EZMc7AFXlNJ9OVArS6yB37HwS07rEadTyeIJxDArUQAHXecdiNgP2yOKp6Za86e/Y
 EG71Csibddm9eC0D40kg/QuxCLyJ6zcRWoiq0PaVOTu5Tw3/ymLh+GGDmmVuVMvbXlCKZ7SIUaY
 IZSc3EdeOneklEWkmGRE/KDT6H9oDB1HQ0F1VPE3SKmB5/jVYhGZn1FT6bDbmeKHffriIc47ZwV
 xjxPzqil+SCWEjUUbxmqDynwQc3nQQxU3dalCVaVW9OL0q3DbsiNUblH5IUvGOT56o6lzYKvGjN
 hTj4GO4lFve7lTX5SQYh10Ic1slaceSnW7gxRmPnjoLmwOhOwaKyIyIlOteofiTMdYl20hlkGim
 LSut4P2IrViACHAGa4wy4w0MyV0MNzgYaSO+ZWOWNb4MlmWctUFhiJdH0yJXeep1/2kQKRmKPzD
 txahjs/RpxNxQppfWmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2OSBTYWx0ZWRfX4pqqh1t6Itvy
 2VSUoDy5UIKFJMFEnokacWVOsPMC22ueDmONaSYiLBboPk60PY8TkI8XXHxmQqSOW+nkv2Q62vl
 2piAYWgmFK7twALXe+55ib352YJP5Ew=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a744c96 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=dO4OCG3WZ7AYuUZzn_0A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: DCppWs1KVcNROcITHqaBX-RWMpMou1FP
X-Proofpoint-GUID: DCppWs1KVcNROcITHqaBX-RWMpMou1FP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060069

On Fri, Jul 31, 2026 at 11:52:19PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> is restricted to use 0-600MB of IOVA space, while the pixel stream can
> address the full range. A stream can only be confined to its range if it
> has an IOMMU domain of its own, and the IOMMU core attaches a domain per
> struct device, so each stream needs its own device.
> Add iris_create_cb_dev(), which looks up a named child of the iris node
> and registers it as a platform device parented to the iris core. The
> child's fwnode is handed to platform_device_register_full() so the OF
> core applies that subnode's "iommus" property and the new device gets
> its own IOMMU domain. The DMA mask comes from platform data, and the
> segment size and boundary are capped at 32 bits to match the addressing
> the VPU performs.
> Return NULL when the named child is absent, so callers can treat a
> device tree without context bank subnodes as a supported configuration
> rather than an error.
> Backports are intended since the first DTS of 8550 binding schema.

What does this mean in the commit message?

> 
> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")

How can driver fix the DT?

> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Tested-by: Daniel J Blueman <daniel@quora.org>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_resources.c | 28 +++++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_resources.h |  1 +
>  2 files changed, 29 insertions(+)
> 

-- 
With best wishes
Dmitry
