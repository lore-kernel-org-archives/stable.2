Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E03D9DC0
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007026; cv=none; b=mz+g0vGiHTY77VaATbGA0TAUtFq03LlDwZUqSmIRzBBAt7ePfZte8VBUdNuq3OvCe3eYeak9na5T7gw8p3jHYYYwtO6yLjSTaopKDjVfx5FFqwmdJSEmcLuJ65c6aUSy3GvSlgbgEPfTQpwVIdLQyIcxR4DwpTOJYTE2hxHfg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007026; c=relaxed/simple;
	bh=EWDTwXvRttdGqjm53SP6oTvMdDNGhbgW8cLYWUaOS7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjyd2gDNhMyYguxZog7QcMgwOYLzFsZ2I05GM9p5JecHUC/eeYQ3UXYMzh5S18McBOaYlEBxCEi+HoEOGf+7IAelRN6I9Cu8G5Kz8ziEJZ/1j91betwN9ARhsO/UpZWBbW3SXc+K1uI3SQWZB9IE7BcFxc6wFedHsDTm8A5PNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fG6RCGs4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ipUBaFhR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fG6RCGs4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ipUBaFhR"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67676gxr3701689
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 09:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/Ocsajyb+BH3bNhjiOtbMDRW
	gAopJzyGGM3KXBbWDT4=; b=fG6RCGs4XStcoElGtiaM0FrFJ6GduWb1SKc8ksQd
	gUEDYyKfvK5WxXhEjAg71x8iPZu1wHlqnNlrEp2MYH/7liMkny/0zchkpW99MDKj
	RT7dlLhVeGYEWCHAx6HZaNe11W01MHyez2IlqwgBycCkdJjeRp7nzYzPdTYb9ur7
	OAYjve/8dX7qmcAJdmfdMIA/tkRK7cq3wGxL/pICm6RA//rVwQ+gUJFTm45JhbFx
	cfBCjpLMXQhKGjdESgQalVp7oWHgxHVFRcfKH4GgPZJhW82UrKTp9qAeUrQIorQd
	6qVZ51+epb2vGvZKqfvmucWjq9JOBuLduEeRffjLgcV6OQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f5bawd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 09:03:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso32347981cf.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786007023; x=1786611823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Ocsajyb+BH3bNhjiOtbMDRWgAopJzyGGM3KXBbWDT4=;
        b=ipUBaFhRcXvwmoTdwPMnvANiXH04UB92HcJYVLajwgxel1eB4nNT/bjMAmqudwWG0B
         dx8QEzLkMMME9PiB3p6MuqK197RdJrvQPI/5LVY/HVGrTN8WCxk8TBb1EKqGAC3ROrlX
         24dL7p95ovHglaXy5lvMHiVeY/XEdldAVd7dp49Lkt4oZA+ydlEFOHz4vx8ZcbfIwUcU
         abSdTBnY8MqsQ5oa2tcpdFexsDSR+qAT6fRoObrDTd3ezLwdwBMqQXfmGTYcSwrluRW8
         HqxVH16Ke7lDxWyx7oQMdBV6TgQj2eZDzFJpx/OQJmRRzBFdCYRvugGyensf8wICm1X7
         yO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007023; x=1786611823;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Ocsajyb+BH3bNhjiOtbMDRWgAopJzyGGM3KXBbWDT4=;
        b=bHRrzP+adyHITonLMSO8zAp7WUHvxd1pnhGOAzjtUwzgVfQ4tShOZUnQIM7gJejWmm
         GWCT3tXYWUUOU6z8y0G+CFhSVmc91zXcBkIlI6iWXgW8bNjQ0IZ0tKSmlPA3EYnICtyh
         pIKyrf3Fb73Kz830ieHfvuWfQ/eZVjgnnzVnduje0zcPZDZCxJVgufbgK+6OQmVagKDV
         FinfQAu+6qn26pWJ3xwPuTzCm1bsCLORoRwFX/YXBmjUBGO1h/1OvDSGwYCd+Em2ji4h
         ohEgxxMKDV6tOerC9y1jZkLAgFqDoTpeb94/1Q00W96ntreUa67hpCSvxB2qTvRXd/cQ
         ltlA==
X-Forwarded-Encrypted: i=1; AHgh+Rqkhm6Ic1LvBJdHSidhKiKvotPwBTitGMBaxLiUX9I3JLB0AS/yNSBoywLuF4w1FuVFpfGGSu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QD+Nq/vq2BgUUX4u/txf+qETC0S37mNl10wiCRsWR7mNPbWn
	C7oOKZ5hOuN7BLbr2qSesDyCt8Anmf8fTN0pGdxB+9k3I35bXYHIJkaWar2cXWniys+6ZHwnOrv
	Zuol8Ra44Y2KazUHvmVawBjG64FXZR2+gOwE/4uKO/SsTqXYvLk36Qj1viJw=
X-Gm-Gg: AR+sD11AK8cS547FCivKJT+qDtonjOqEZJm3Yy246/t9PcYTw56o65CMCUBtzLxVzv/
	LTe3QnK+7b1KqM+IIwzm6S7Q9Chgj15tMTIQmqB9i2F6kgzuvrbmmRmH/xK7CNj6cgnCjRlc1OL
	x46Nj6n42H2CAD877aYoZz/rmE57MtEhkiTiR5FHxX3AaI3BA6toWF/9EHx+EItaI6hobQdbGT0
	R54dB18EqxlKLO58QxI8x/FKSYJ5E34P5AW5XXAQndaaVQMkKEYSggjUz2PpT4zsmAt/Eq5Dbti
	ZllnXyuCKVrFdwVexvPwUuva3OfrMCh3cKnbSAI+Pb23I66R9wS2iL8AiAj3E5zd9WZSmQa5W3/
	lKj3hxlDWl4jpJKFVutCPH0auQNX010Ofa42htc+pS9ehRePDSwJ9UeYfepNDZdRLE6pFKny9Uo
	4gWvhYl51xPTKzQA==
X-Received: by 2002:ac8:5d16:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52ce6180b12mr106596481cf.28.1786007023250;
        Thu, 06 Aug 2026 02:03:43 -0700 (PDT)
X-Received: by 2002:ac8:5d16:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52ce6180b12mr106596141cf.28.1786007022812;
        Thu, 06 Aug 2026 02:03:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f62af826sm614988e87.41.2026.08.06.02.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:03:41 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:03:39 +0300
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
Subject: Re: [PATCH v2 05/12] media: iris: Route buffers to the matching
 context bank device
Message-ID: <y7idhuok7ndyo43imqg6vo46ybrjkbqjwifufxxjmijsayb56m@6q2u6sxhsiyw>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-5-da52b5228dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-vpu_iommu_iova_handling-v2-5-da52b5228dbd@oss.qualcomm.com>
X-Proofpoint-GUID: Vef8FlwIkcqa9RyXpmyfhXDwEgXsfL6r
X-Proofpoint-ORIG-GUID: Vef8FlwIkcqa9RyXpmyfhXDwEgXsfL6r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3MCBTYWx0ZWRfX7DkUJ1ZCrDn8
 Q9tC6j6U9pOMy7jEZa4MQmEE8WBdFOCwHsYIbdiN6zbk5jRrU6rA9nVbMo5xoT82D2Xhv0lFcwt
 T2q5JfIoSodwkR6N758vVxsgyzzPmcY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3MCBTYWx0ZWRfX+R8lfMS2rTei
 Y32OSKjUs+TnZKiSvuqGNsQPHmN1qDbIPFnNwkrLyCEwGPM66xLP1Chpt2Tmw0cFn54SAf2pSVb
 ZcD9hak23i3ny/yjgmb7rWfh8cQGyRxo7kwb88QkWAesmjnug9VI5Y9X9V7BzNFsOYeXAlSAD+X
 d2rnXpIjLnV0qhPHVLXJ70SBkgzyDW2jD/P/k78fOZah9jzsfwOt4zcF+eltm0eLffmQn3c9mZM
 wl3T9osv2Bs5DXZuPbvaYtpBZCpL+cDs1hZwReVAYd58OP2LSufT7oGMyhLs54YReeJBEShhDKJ
 2Pv8ckqmC9oALpXo3MW+QFIk3cVSlietiLokzq8oofq3d8j+RoGzwc1uNkMo9Qc5Koks9s9qxIp
 Hc0SAimtw1WOKFf1tX2NCSKxj4KNGPugyS4vsrVq2xbTUAEjB+9IsTne3pVrMw3k69RgfpSy9Xu
 z0Zd6K70oQOfpJRn+dQ==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a744df0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=_nATiDK3T8zfJof2TlYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060070

On Fri, Jul 31, 2026 at 11:52:20PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> is restricted to use 0-600MB of IOVA space, while the pixel stream can
> address the full range. With a context bank device per stream, every
> allocation has to be made against the device whose IOMMU domain can
> address it: allocating a non-pixel buffer against the pixel device, or
> against the parent, places it in a domain that carries no restriction and
> the VPU faults when it later accesses that address.
> 
> Add iris_get_cb_dev(), which maps a buffer type to the owning context
> bank device. Bitstream and internal buffers (BIN, ARP, COMV, LINE,
> NON_COMV, PERSIST) belong to the non-pixel device, and uncompressed
> buffers (DPB, PARTIAL, SCRATCH_1, SCRATCH_2, VPSS) to the pixel device.
> BUF_INPUT and BUF_OUTPUT depend on direction and are resolved from
> inst->domain: for a decoder the input is non-pixel and the output pixel,
> and the other way round for an encoder.
> 
> Use it for internal buffer alloc and free, for the vb2 queue devices, and
> for the HFI queue and SFR allocations, which are non-pixel.
> 
> Fall back to core->dev whenever the relevant context bank device is
> absent, so platforms still describing "iommus" on the parent iris node
> behave exactly as before and can be converted one at a time.
> 
> Backports are intended since the first DTS of 8550 binding schema.
> 
> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")

Drop both lines.

> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Tested-by: Daniel J Blueman <daniel@quora.org>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_buffer.c    |  8 ++---
>  drivers/media/platform/qcom/iris/iris_core.h      |  4 +++
>  drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++++----
>  drivers/media/platform/qcom/iris/iris_resources.c | 41 +++++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_resources.h |  1 +
>  drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +--
>  6 files changed, 61 insertions(+), 13 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
