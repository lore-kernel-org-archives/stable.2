Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0AA3D9035
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167494; cv=none; b=Ss5ibZ1J1hkoqo7g4SExpeff/tv/uv/M4hfQNAPzO0eOPMplB0KJHxLsJMEsnP2Kb52/T3IX6DpqB1ROQWAYv1oRiOy682A/A75DCMAA67yMelisKOgYqgUFb+rYzIbC2XFfPfIJILZ42mLti6nQpEvvFkw/x7MAYAqU+e5Y/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167494; c=relaxed/simple;
	bh=wACfMGJ18cylwFY5eH2Nn2T6G6UKm6Fbj9mzSfm1oSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCSra79+z2ib3cmC5yIMl0nXYDM6wawKet7XSWXstu5FDvPFn+SHJJwJGHTDKaTdGUfap/SBkSV+SMNMFG2VNBC+OZTDfBTviOYOrMg6ZfoB0ptR8dsajN+3owB9ox9yx/WI9Nwq/dLo4O+W+omhpp2QpUtoguUYcBLs7x37xFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3AV5lWM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b5Ru+1dK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3AV5lWM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b5Ru+1dK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xIta2460282
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 09:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nOBwJphAd4cD2oSNE9q8Kd3iMs48r1qUtnTODQfgbqg=; b=j3AV5lWMlFbf9yBb
	kfH8H9fSkW5REqUOSF4Ve2qmLG0N4cSJSm1cGni1wylf/yAJo6ZO8g+qAiHMTvMV
	uHO7avN4YkLHUr6/y4hjGhpUiqpxG3dsgCx35fkSqCDgvEu/kk2I9FCvAluiHqIU
	639QDhdnXce+NTq+bpUoiVTbgq/Py1k/jft2dXt5U+CW/5QG1sDuXxEJvstLYdkV
	Jic6At52RCVj1R6lqoiwF33ZpWNNc7Pj3iVQ0bax8Z0RHjXsaMaD8XNlLn2F3XIb
	ccNBrgxdBWfWGNv2imTKFygKzrjgqCHdvzqjP2sN+J5h9OaYAdyfWFLLUBDYAtu8
	aRQWBg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556rewc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 09:11:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1c1cc5206so3076998a12.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788167491; x=1788772291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nOBwJphAd4cD2oSNE9q8Kd3iMs48r1qUtnTODQfgbqg=;
        b=b5Ru+1dK/8w/RjVYZcjr6reriuorzb4tCnAbCQ0k82xl42YCkxCMUKKsqAJKj10++B
         H2uUzp6iyf1TtF7z5ARC19eEL2p+e2iynJxc8QAZXWy1rlCll5+RHCrgBYZ6Kss6q7+a
         Elu24KjYazLvuA2U6P0jG09S3uoAByJgghEAZpoSxydpKZQUk7zTDfo0NWH9J0GeEBkk
         2AeKN9PVU/AKlwZR+7mvxbbWTOrVIUe+bYcbqunldCn8eH4zlrHoQRNrco+riTjU9l10
         oaOtkwliBIm6M0/nPBa4J2e2t0y9nQXEQsaZWm3gyUkxSq8J8DjpIfu49SQiTRLAf4w1
         Lwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788167491; x=1788772291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nOBwJphAd4cD2oSNE9q8Kd3iMs48r1qUtnTODQfgbqg=;
        b=S0ceZuVnAxbzr5HrLv28aixY1SAgX6Y2MLgYLD9IOWwWkix8XNgcKClxQut4HMAqNL
         0ArWOMM+2hYogUBGTceED6oW4oSl/1FvhUaFZi8t/Qs3r9QKGufz/mciTZUKnIsIt0Vm
         LhJD5LEgKQHYjC7dLLjA/C5BxXumHIt6wbU0BsOP3ctlrUm5QJgmCo0H5CnTDoTcUZ4p
         T5O6W7K4l4+csQR+cM4oPf/tpvugDx3P2zVwQ+8fLanRADNJRTSmcNM4Xq1cepbFztNj
         MiaeeACuO7JC82OoJyFYQ2RnU39L9zXHuV1MVFZnPbKH+bOXWBBmfal/oV9AJFbgTdD0
         L0kw==
X-Forwarded-Encrypted: i=1; AKwUvByvwQnmf8E+dpjE04RvwUpyEEU/SClRGPaikG2lLUwFNMXWunzGXQuARPAe84LNsfBnsBSOD/8=@vger.kernel.org
X-Gm-Message-State: AFuF++mvBEzuQWxl7pLP2+s9LWBj+ShKINE+bKVTFGhSvvv6AxrgZxTX
	M8TM0XaO9i08JVPm2280goXsxQICvZnRN8ptiDdnScWByNVFrevQAIibjAtIp19rpSyiSC0UFFf
	BdEk0LuYY1Jw95zJYE1A8lgvC2XIZ397kof3iQ0bI+soqmrjZRxHUm9RcKzLsetKIRao=
X-Gm-Gg: AR+sD13vgxXzrNVbpbFV5weDCnBKuMMF7rPGMoa5rkAxZCPNGjRCrVNB3TTbtkVc5/Y
	Fub7wt6exEb8oBHaWpyZPrpRHy+BR1Ccr5HJ1/XO5QgWzj/OdZhIyFMFlmsJifUoDm64JQs4vWs
	0qK7ZdCvDkuY7YwdAe9xTPDXemlG7BxwwodF/6sgzE8n9gft/W/46b8CFlNAFeoHIXtS9Cmr6+N
	zyrwqtfmXy2hlipFBQJ5U/7iO01J+prnHDVPwVkdHDvmMV7CKyvq70FwyGwM6PAHsqagXswi/qG
	R6uduWl70deiq9kgJ7vz/VVDu2F4FLq5ivRrYLVI/6Tb3TYd7clqdVgWfoyp2aR8UQzK6UK8V0s
	YV+Xy/bSyK8WIUXikxxR7mglUcbBou6VAvw==
X-Received: by 2002:a17:902:ef4e:b0:2d8:d4cd:dc93 with SMTP id d9443c01a7336-2d8d4cddf80mr261831915ad.22.1788167491477;
        Mon, 31 Aug 2026 02:11:31 -0700 (PDT)
X-Received: by 2002:a17:902:ef4e:b0:2d8:d4cd:dc93 with SMTP id d9443c01a7336-2d8d4cddf80mr261831065ad.22.1788167491015;
        Mon, 31 Aug 2026 02:11:31 -0700 (PDT)
Received: from [10.217.218.20] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm32564294eec.7.2026.08.31.02.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 02:11:30 -0700 (PDT)
Message-ID: <06f17ae1-6d42-4a56-88b3-9f5568f6c9e6@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 14:41:19 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] i2c: at91: release DMA channels on remove and probe
 error
To: Shengzhuo Wei <me@cherr.cc>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Wolfram Sang <wsa@kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Yao Yuan <yao.yuan@freescale.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
 <20260827-i2c-dma-channel-leak-v1-1-271d4adc03a0@cherr.cc>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-1-271d4adc03a0@cherr.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3OCBTYWx0ZWRfX5KZ5vBEarFM9
 bke4Fsndgrdts10qaWWG5k+4sZEVhXfLMCgcLz64QH9eqBeSwE5KkpYpY6gpMjttuCR7GAUhEg6
 YnbjCaPwATlNCTf7vEsXT7IVpnJPnmc=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a954544 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AkmRZ_q-vRwkFVX3bY4A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: BmpCirg58-GRtssr5FPECzkFy9N2Q_Yo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3OCBTYWx0ZWRfXyYDn82Ere7Eh
 EGEIhVNp2mbn5bRAuTWl+AuhLAC3deWJaRI1wSCjX6gybTH5CP0aAbVkUa1tADyQlfjRulLydDk
 Mu031O0FqT4JxSoJgq39Fp7wVlOXblM6iC2ubQ+HUNOCvpQ1yCPsFgVDcFFqPn1ID58MuzLsOHi
 OxKuoZp3M079RYEhj7wATdRXRL/7K1pWlktoxEYHhvqTg/1sVUDoVpDIHu5Lgsxngw2g6BVS0LO
 l2oPACE6hS47xgGPhH7hqDGtYgBdHXlLgBoBRj3B5oMYHox3oCZCca+eN9wpNDJz6j0i04hhJcZ
 TKKlwi+zDhBikL60TD4nVrsns4LebV4AH8md+sQQy7iifelqXDbC9mkECyjsPDnFPxv4/KuMrNk
 uXuv0ZyU5diwERSgYXsr4kjKbEm+UzU5879KEfIrNQwhL8Z7hs9Pg7IcWZN8qy8BQQOpVC9fiTe
 9zUEya4PC5JnkM+Ln/g==
X-Proofpoint-GUID: BmpCirg58-GRtssr5FPECzkFy9N2Q_Yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310078



On 8/27/2026 9:13 PM, Shengzhuo Wei wrote:
> at91_twi_configure_dma() requests exclusive tx/rx DMA channels, but
> nothing ever releases them on driver detach, and the probe error path
> after the channels are acquired (i2c_add_numbered_adapter() failure)
> returns without releasing them either, because the remove callback is
> not invoked after a failed probe.
> 
> Move the release into a helper, call it from the existing
> configure-failure path, the adapter-registration failure path, and
> at91_twi_remove().
> 
> Fixes: 60937b2cdbf9 ("i2c: at91: add dma support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---
Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
