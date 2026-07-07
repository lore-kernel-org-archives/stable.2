Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4C31A057
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413843; cv=none; b=TVKfP2wEHbzCIz/EipcU++2peNBiDlYJ/Y53AtxT1Jr5A370nuK1U9yOr+zQwGedlxA1gvapBGa1MadYwo+5LcgGr1/Dvmjer3m5sdhnBA1EMIKQ8WQ9JYdEwbmmBZrWtxd4XT7VSM52n+qJ6JXbLw4xukXS5OLSjYYX3IIqL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413843; c=relaxed/simple;
	bh=Qe1dRzWqI3cx6EMPI8lx793HjTWT5V2KRYKzifP/06w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Inrt+1cNA0gaHYp3StpDdXGKDRCkimpQ+wvBaUqgvg9Mvr5zXAIQ6dsntfwiUS8Cqk1ez7JsLoq4fawLQIoYCzt0gR77QP5gbRN5CcEl1w3HqKcqfjjC1+1bQAbbDPmEVjCUzH9r2rzvIPN63et0xzkzXuvU+7v3/t0ZRAFeg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwLXoNlv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hvIZT+6M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwLXoNlv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hvIZT+6M"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678Dpvq3208928
	for <stable@vger.kernel.org>; Tue, 7 Jul 2026 08:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YXUXWqaoASgKGldEh6YTJBIIvyXgmngAzgY5m49GYxI=; b=fwLXoNlvsEbFTZkm
	RvnyGzub7C8Wyt0NN5UD1GXo4GNhsmel+G0p9Ixb0XTbHEKvM4p5qaYeqBIcknPA
	L91RJUpBHvgIoNyQQ5cVqNk5ZHfqj6mTFzYcvWYrh9PyPXHYcufY+u0en+EysBcL
	BJAQYqWEbdXMlvKM3I4gYNFUC8fU6Y3qReza5mC3qFiivBI7AheDMKhVvbheynpZ
	RENZ9WYIMTxihU0RuMqOgaRiF4BJ9D43X002hL1sZd8Pe+IF9Mis6NxOhEC5kQYq
	iV623yjxiQSC7F63SGzlMip0sJGM0sG+WUuwBcDkro3o3yjZ1nMlokwfsqfztC8Z
	3Fevrg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj8fxu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Jul 2026 08:44:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e8e40a8216so13662486d6.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783413841; x=1784018641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YXUXWqaoASgKGldEh6YTJBIIvyXgmngAzgY5m49GYxI=;
        b=hvIZT+6MlKx9smZyE05uM6IUm9fHQuxcRn/F6U0W7t68cdJa2s7wLTrz+Qpl6XfEDh
         m5M+by55HOwoMVHH/l/5gs6/2tuW3WuMJ4/nR317x4MKCuBZT2JA1tWF30JaKgfVE2DY
         mBFGAJ5+09InhcJuVLFlmoM9vPiV6npcVpkzvXngjerB6C7ALA62Y3l1C5DD1XLiqnvM
         fDjcoyBtp1W2neZS5l0gApovx5X+q71qPkNkAkBSsWYIAp8UZdebCePne051FzMkMclT
         kXuJcKvLV3ooAgdD8s6pIaypuBzJ3O/UOj6KXYEZtWlP1MY9RehVkOc8RgyP1lWqN+BM
         pehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783413841; x=1784018641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXUXWqaoASgKGldEh6YTJBIIvyXgmngAzgY5m49GYxI=;
        b=rqpwb9fhxBCKn3RUUYYuwVPyKIqoRqJyoHWpg/rshCKnbCrk9AZFSA16XKVH0KmqFc
         As7+i5dW/gkPp0l3NeRVzmOxrkWSgbn/fYFnB4EsKqCJmdTEdQAreSJ5varClREx9oc4
         F6p44+Nm7fk1XY04rlKJ6rJk9vqPMMESdwIeRHZz7KQ9jZ4oQXXW8tGAGy5jIQmZEdXq
         uF0rigdXnHJGORzJM/lttMXV9a6cuvbxMooFtUFA4ktWee6IQ/ImX6x4PXwELfGFYUAU
         QWcirZHHdq3ZdcFX4Klusu7myPkt27ycr21UsTZ0SJwlJ/dg4YTjNpfth8XVERilX1Mt
         16+g==
X-Forwarded-Encrypted: i=1; AHgh+Rp2w4M/aV5dEBH4+SyqMSj4J1SG8eZ6nj6dv4kBA7uxLnQtUBI9fx4zkwDT8/516vVTgS2Oh1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzmYLEgzS2ba2YNC0yrhT+RaYkNtIUKmzgXK+yuuJnipamZk4v
	xR39R6+YjN5xr/veQSgc/6pGSIpCivoXOVAQ0C1MEtgHsVwg92sMlQ1HaoJ3TJj/wARoN1IF63S
	JBw9kA/REBqa4csbkQnEpGahmstwzC/30+Z08xJeh04Oykh6pulOw2DnIsT0=
X-Gm-Gg: AfdE7cm2BC7m+3syl1V2dEy7FFiPH/aZ7txP4Srexz/7kstDsLVU0ZpongqqQ/YFl8R
	6/NV2cA2iiJuznIFjK1HwjaOMTKZCM1PeSBr3Pk5VR3WQQOixHMJitWOfxUT0sz2oyyRxlm6gO4
	Hw04x43j+t2LD02Fscm8hnXTuuxnf8TVWQOWSX1JMgTkv9zlkIo5IWe/PGbN2qxgAL0gVaUvDyV
	h3IEvqjDQxTymec8jRo/FJNiOg5kFaBeh/jktnpqftIVBZv7c9vMXCQuSATfYLnZEJYLiYRk2f6
	V+A+IeMRqUcxpOpgExgvh9H4m/9AvmLcx9ftwQEJEvTuGB6UyggWZNP1O73c367QyVBaXOd48dA
	be3JsYTZukvrikCfNK3hpcfxWZtj32chyHT4=
X-Received: by 2002:ad4:5c82:0:b0:8f2:fba:7f36 with SMTP id 6a1803df08f44-8f749b6b74dmr138770206d6.4.1783413840954;
        Tue, 07 Jul 2026 01:44:00 -0700 (PDT)
X-Received: by 2002:ad4:5c82:0:b0:8f2:fba:7f36 with SMTP id 6a1803df08f44-8f749b6b74dmr138770026d6.4.1783413840554;
        Tue, 07 Jul 2026 01:44:00 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd89b1sm5363449a12.1.2026.07.07.01.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:43:59 -0700 (PDT)
Message-ID: <ad7edaf4-caf5-4655-b489-de4b8bee6426@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:43:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] phy: qcom-qusb2: sort out register layouts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Baruch Siach <baruch@tkos.co.il>, Dmitry Baryshkov <lumag@kernel.org>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cbc51 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=BeWwBsZv0zths8DhLt8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: kHx03ptuaQCjzzVrn6XdZ0_85tjzw6GV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX8RZRAqRGSrVa
 A2Oq+4SIpXUWiU/hQo/Os5TY6Gb6kfomoUSMWlhXtdaS5DVkl0MFv6oJ+5CNTQmuMZMi3IAt5KS
 tK4jB75jmc28z6iFdTkwqqk6FAnzgyblX2M2hhNnW/yN+9NpXEFbT7/IJlN/LcpR2nfxwfcOaYn
 HjRIiO3XyyYA8PwKWHGn0267cu/kqdZXXEE2SkfG/Z6KIehz5OUTBksagXH+yVVnNHCEb1WpzXz
 FMhmn6J4REOEqzH73KMPjkk6PyKpcQFrotdXAmRdTdzqshg0a/OTP2lPpkhXuWvgHGmnCQYQQP4
 /dEqAES5WDIGNM4Zy+XF8TNoQfn10gHJ2VoZ+UPudcXt2dxxQ/9JxEY+6XmAAqXO6Qqj1lA0iQt
 HDZIH0/Hwk3a5tcQnJ2S6dUYsQ2pIS2PRftWkRna57BrwCl2YliMbuiwj4FuHjyzMOz6W0beznA
 DgYFIlK5GjIob6RAiiA==
X-Proofpoint-ORIG-GUID: kHx03ptuaQCjzzVrn6XdZ0_85tjzw6GV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX1SfGXVQ/ZMsh
 nUocQULWHB8LjbmEjEd18oQFi5hOYkf3impAJn0uzavyxtnUHkqhFxX0lFGDFLQNFFGXVjAcWxR
 vSdtt8c4/HHFO5uCofn1R+5dVpCLRCs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

On 7/6/26 3:53 PM, Dmitry Baryshkov wrote:
> IPQ6018 and MSM8996 use the same register layout, however for historical
> reasons ipq6018_regs_layout ended up correctly definig TEST1 register at
> 0x98 (because platforms using that layout didn't use autoresume), while
> msm8996_regs_layout used TEST_CTRL offset (0xb8) for the TEST1 layout
> entry. Fix handling of the autoresume register and definitions of those
> regs layouts.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Reworked the series to enable autoresume on Talos
> - Moved autoresume description to the regs layout, it is a property of
>   the regs rather than a platform.

I think the new approach is sloppier

Konrad
