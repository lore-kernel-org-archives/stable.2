Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE538425B
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036676; cv=none; b=IcocoWk3Mp+SnFDGhUwpyk0D3TCtT2Ercak1+AynwIApBqJjWwy0luQyAX8Q+RiuvzN19sW1UlvDCUcosq9p+rjXsOXrkcyDFv6UZIEJLP5xq4fUqsg07w8N0YOLAKIsUJSyZRgIQAyjcj79hA8vOB182xcYwnuLdB6xRz4jYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036676; c=relaxed/simple;
	bh=ThRsgajCuLLz7ale0e/tNKwOYjzS8xUMXExnnZBkfnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NekY+a8l9wLopJu44dOmFUHGBa64YQmXfM2hdkQ2EuV3LgHq8nKc0A98KjQCpoZax1WXZAxYRwVNDJHSwqjCGe/XHWJTTU6xRqQt8Z39KHu4z7shOhXha8Iok5nertuCAJhwZWPShELEHbfKlPZYb9/P46HHww+VwgCWSuA4BOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DyEexKNb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jz0ZNM1I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DyEexKNb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jz0ZNM1I"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I73Sw7173135
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EwT+2J3bGB7Z6ksti2cShfP/
	roINGoif1NSZ5f9uv8Q=; b=DyEexKNbkjtaGslxttBMhkoil9u1z4EZBZ30A8DT
	7xUzf2DSfXbAYjL+ON7E3VzOyJVfxvfMHWjBwE9CS+uXkyqcDbojiAesOm8teIVu
	HyNUMkXY69YQTbM+UwvH8iFpeMNeH4fCqPZEtrgJ6GHUSZgtS3XTRsVy8zBTHxy/
	mT9Z9rrT5G+dUna4RJBMbe0nnpuBF35BoCkegG48PLBQD/xvXsRDOiZT/P9oPqtt
	rjFYkqQZGyDTj4iwSqyOQ7ncm9CQMxfDBDPJxg83c1FMDUuikHho8/mjROhRim66
	kdUAvxQkvSLN7mzfiRPn1f4ImZBEaXyRsHSxEsF41YIG6Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqts22f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:04:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e9a2b95b5so744895185a.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787036673; x=1787641473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EwT+2J3bGB7Z6ksti2cShfP/roINGoif1NSZ5f9uv8Q=;
        b=Jz0ZNM1Iwq9K0oFYgsTD6tlTCF9tLY9GXDSaK3GrOlD43mAIi2EKFFMdqJ7GhJsvPd
         E3oON7bTajC71u1UWCvqpUHS8Q0dcCkmnEwal1ALZ1VVdkJAvX9egGHHUlubtmGe6ENo
         0HetQMQzwW3o3O3wOo4NTR2bLESFum8rCdGNZyN8gofHK/5mcNe1v7QS0hLZxrUpDi4Z
         MNiHQ5Pv88rfDYigwvbE5faC9FzOBJf9DAWi8LtYZpHaOa6T8v0VMdOV9Bgdap1r5Jn5
         kmvBAaVhS5tFWc4bcC2BknRaaS4bJSU5rSHlTm0cxYjQhMYPPa20D6iyJgaL6ADGbi72
         EZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036673; x=1787641473;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwT+2J3bGB7Z6ksti2cShfP/roINGoif1NSZ5f9uv8Q=;
        b=pnkQMHHJBYy0mzlMmx55q1FRRSpyAsP7KaCrJCEHoRgzsYYs852Wc/DvFJ6+SIk/SS
         OdpHtv0/Z6cCdtLMZWbpCaUdgT6rsf1gmWfI67MX2lV2dtpdURhXAU1OY8j7qTa/dECq
         O2a5M9qZdPRu695wfObeU1n+2tUR50ExbxWazUQoGdCjLLUnNOGA0jstajJ+0r9WNzK7
         q2seXVEtA4tcW8cl3MXS+RxVPvjmMnywwQmrQAAw65yNMvx8SlPrK3YeEUVZCJQo+3Tk
         3YdCLD2qUCUCv0/RvfKnHdMEvWIGSsaya2W9BaBRGuR+T0FhooI8XesQAX+GlkSMAzOs
         Eygw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7b6fxs37K7XXsSYtOMp0LAN5eyoBgcW1zUPy/rVFGytf644AqqT66yC89iQ9db3zJD8BrZQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1Acl7NEFVAHbRxJ4wsl0FBYDf1Po+jLfzRSc9adcXuv6CHi1
	eUY7+ETdJ4pRvRwNqsujNrplViK+wrlfuP3VuaDhEBpbjo+tyPSXlQXMmbkI+5o/N/d0ujTJhy0
	oHSypFRVV7GFhbN+rWlP2ylwGnO+E4sMaWzY4ERAsxFULj+R1A+91ssP8fyCtF+HXymnLTkYh
X-Gm-Gg: AR+sD10U/d0i6F5dATYGvT3dVYrF6pDGhaz6rMX8Gx6DK4UEF2pkGcaW8eM5LLZVrvH
	HASffPXLu4tsojwV9KndO8Al1MZMOI5ATNUtAxjTidUoBKWxr+xN8amfh/r5peGb5Mej5foVkt4
	wtVvPU3UMWqDkMNvoYpBrHAhmsZJ8d2xeGGEGiDAuvY9x2ohlll1Sh2qeaD2AOkgrpMEjHd/kbb
	BzgIOOZPuiIXyyETqIHZhtNHflhs2x91mvqDVCt2UIoGqZX9YlNPFw10fIzvYC2xwcUOnQpA6fL
	f5zLIKJRwYe006fYgQEoq4OyHiw+6cYQTM2orGfAftIDxxpJsISg8IMuCIbcmPOxVygxoEr9Iw1
	LBucpTTdUJhPwjBujK+sSKiH0Zx4+JRHpkqmmXGmq2f7Gjr/tFIO0NfeQNDdtW6L1KYRtsdL/dw
	7ZEJ4GYFNxTrhI
X-Received: by 2002:a05:620a:1d04:b0:92e:e7e0:ea45 with SMTP id af79cd13be357-936d2345575mr3266878285a.47.1787036673092;
        Tue, 18 Aug 2026 00:04:33 -0700 (PDT)
X-Received: by 2002:a05:620a:1d04:b0:92e:e7e0:ea45 with SMTP id af79cd13be357-936d2345575mr3266874385a.47.1787036672695;
        Tue, 18 Aug 2026 00:04:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46d00b86esm978056e87.63.2026.08.18.00.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:04:31 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:04:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] media: venus: Fix iova allocation from restrict
 region
Message-ID: <hzu33hharafxhfdnr5tr23ti2tmtjhls3iwbvmtfllwcv232m5@nvxemt5ijf4n>
References: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
 <20260812-reserve_iova_in_driver-v1-2-ed62f801275c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-reserve_iova_in_driver-v1-2-ed62f801275c@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1MSBTYWx0ZWRfX/QkyFAeRP8JE
 uu9oI4cPLIOwyrhjxPz5y5262/L6FLGOE5bIQzs2MuMu3C2DtccRMnjiT8uSIdWwWleYGInFc8x
 vhJNbfP4YW72Otj7igLLba558ItkLn0=
X-Proofpoint-ORIG-GUID: ZqM4DVSQEtGMe0rprcU6wkcjEdzjsWBJ
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a840401 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=4BULcDCo1EIeXDFKsSoA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ZqM4DVSQEtGMe0rprcU6wkcjEdzjsWBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1MSBTYWx0ZWRfX//GyHysyzPVT
 kOh7UYNnUnb/GH+vbPHfko2Y32uW8UYsnT0POqKKEEAKCkVW4KuCW7lFM5s5900MApA9n8tjBR5
 OHeJm24hwSbLWpzs3eoqDlm6b/oG9rj0oRQ0qQcFLDvCvxpP3rlB1osBzbbF1mi31dZKC4m8UFq
 qCfQkJivrUOdEifo2ZCHIpCUD9M9hIQUvpISVHaItqatQ5Stp8LmLKNu/DgUdOp+JZdMjW7/AHH
 jjNM7Joc4hg8QfXyDegfBXTM/qakbX+2U7ECaxw3qXl7bHJ/Io9TTGJ9GMCVqj0ntsvyd3DjB9y
 rVPjvrqVRK//M1SaA1jMuxd/UAjTNipjeKRE4UYE13d/mOEbgEW3wA/mBITtZXTV2MZa53ylQzB
 /1e9VM4GNDteSkmoePwOoUNJASGc5imQCDhLj94hJ30qWlwJzZtEtZkpad9yLs7xiilGwSl3V4/
 oU855l8o+4c1bgxirpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180051

On Wed, Aug 12, 2026 at 04:25:59PM +0530, Vishnu Reddy wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+

Does this split apply to all generations of Venus? We support MSM8916,
for example. There has been work to enable MSM8974.

-- 
With best wishes
Dmitry
