Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866305;
	b=BdpU0QebDuiMps25THJABG/b8WomktyDYrd75WIxr1AzQeLgU/5Xq3JCfpuMEZSyen4C
	 Pw4Xkcv06xoR4D5JStGCs84H9opvI2BO0dlYSxgBLaTDPNp9RnDzkEzsj7te6CtHpY+ZC
	 vOjIl4YmYiNB0FAv94lbZP0s6iha7n3ACCPRz4TYL5Jg2RB8ztmBC6HCZkInrqzdC59yk
	 i9JFTpGs78NkrN9uMbHuLGH0T2km2C73IlUpw6H3sIHxImpcIIeJVlFDojoyyYHryUFIj
	 taICmVFePNroJ7v/UPp1BA4xcAun331LrbFETgzvWzB4hd377fmyTrjG9MZqW7MYarQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866305;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
	b=Phbvq2BorycRUMjm1Y0btqhDFQPBAqNdVY62SOWL/L63ROYccytdLxZj8olREEldCANc
	 0Ybgo1mA46NZQ32gkXZMaayblXrqPbumE7pNWucNnlwjjr/jQBAJVE2aeKP/RBuqbHNnZ
	 +Cd5ayAy3NZvHdGc0Z5eMSKTXnO7Q2Wh7rU8AXEDzNRkpYmQTys5X0uaGNX2V/CDncwOq
	 86ATgiOWq9ys6FMPmL2BYj2bNM72pgX6TKrZLgG/2Gq/Smp1fk/XF+F8iUDFpHoSuy0Dm
	 NqTap0sS4XtugtwG7qUdGuKNc3sBLXX7sGjP7gB4JWxzUqa/iP91VOnbK8DG9vvfL8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8LwHb4Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJfYmTmE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52498606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52498606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8LwHb4Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJfYmTmE
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56U8F34169642
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=; b=a8LwHb4ZHdGn4MsJ
	20ov9kOlvbDvIQg0LABhso9DtRcQp9puWNQq18Ru1K6N0sJEiArvwPTGJaFrRozj
	khU8WPF049wZiIAsEJj/hAIT39GPXKalNdUrp1/EeOsaj9peDHIVkEVprYWY9drA
	l3z+XTvUcKqSsq3x8upVQPSQtbooBJta092cmY47+kBicyWl1KAOMtAxSAiW7Bl5
	PwoWNjVqm4tUPYx4yPpBf4Wlkwe6J5dEOFBf8Yy6BfF3T5W5sYlNcFvm7P6Ke2Sr
	5DvkxPkb2gVR1XA1seH38HhLXvDcReeBJq0r/hRYFWt1iTHaz/3Idcf8mNomwj8U
	SoYuZw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd8dum-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:11:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91e751af52bso3723946d6.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866303; x=1794471103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
        b=cJfYmTmEF0pCxy+r41jz/0v/qRBS587sP+w9/rlgJlfc6L3MwP5XdKeRFbZvUO/LDE
         ThdRVHeFJeaC2TkDd9r+Ws0abl6ivqFMD6vrCxvx64/YWGmXez/THI6YtUL2YXmdP3kt
         BpmVbWnYafyMWlsWuDcgxBWn2xjCehowwNEuNnQUMcuTAzXtEQTTgO5z8uNqdTj8cYko
         eIed/SYJFHHE+WParcaxxwVNUCOEXJZ7PybxOvdhwCgaQNr1SKXVJoIhgYOIPePRO++h
         tRNwmQb7dZkeAhnKqEV5dN8Xo37nxsHTkLaQwjg0M1w5yQb37lA1M8+a/hTHYKAdTb/7
         riIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866303; x=1794471103;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
        b=XebvdRwOJ81fkHfvbL27dBuPgTZG8Hlg9ui+LKT0gnRdYI/a2r8M13JQphqYBgP8bs
         Lkg7klKzY0cegsgpcHI3/3dBaJz4gMgIHSwXZsRjwBvxIzYSTyqUocTofBScbpPbh6ur
         DAf3Qc1TSRwTQfAjWr7xyjodtxQII2JnhCXBt8XLjTdyPbnJQPB/i95TegainfwuHE7V
         MN0+s21o51jZMCnE9xd+FnAZyMjYH/Wh3BNhAyXxLSocYLGtoH5qcN4ZD17hzBYHPsX2
         0LfAOxKPwvCvgCkI7JDqoGPO2IL+V9r/GKWenOjM6Cjtz1T5NgDc0J9ra9HdIXYb62fx
         QNcQ==
X-Gm-Message-State: APuU4Z/atFCgXdgogLf7qoHKLKobGtXzy2NU70afxK4lPpEf3au9lZKJ
	Wzcf/nMRrx3ZZTRxXzpWzTBo8rEYuyRPjZpMd/HUsntf2QZZhxmC+bqOZgqgqROAfCXuiVFgNiE
	WwqC0ir7EVqupnfz89MXMcU/UM8ADZPiSgtpf2uirFGL4E2HFM1s/Gp+394E=
X-Gm-Gg: AYBFou0QyTIhM43e169NLf/eZ8Ua2bFyTgIn5D1TnNoOIgPAj/doJA6Y7W1rXv9RQ3W
	OCmaWihAVP7AFLc/8E7vzBVbuWMMtqnj/JAZxR428i7QthXtuA8pLP/7h4R/Kmbinxr+8AfDEV5
	Yy9NyIUGf12igc9O8vMl+OBnI4r0oLzEfQdxz7hL4JmwW9EEsadgtfxH7XUiZg6cW41RcWPUx9C
	YJFrLdvPUGqdPZQ9JxiZrdMC8sZ10XTIQSkRIRz8a/X7mEx6xv1bsZP6ourRp2JUORX24PH6xSP
	Tm6MI+rpoxh8QQo3icMV5p8+ppv377HzWMdv2FIU5208LZyJ4tSfmQJOwU/XKJQ7rnszNf2umAB
	FS4Z8ZXgavBXbA51351FPWO4i+xym1Rq7uZnsTYUcag+GldclxyuT8P9nMBWNPA+WtNDr
X-Received: by 2002:a05:6214:20ac:b0:91c:7831:f4af with SMTP id 6a1803df08f44-91ca4b63f0dmr405783006d6.4.1793866303180;
        Thu, 05 Nov 2026 00:11:43 -0800 (PST)
X-Received: by 2002:a05:6214:20ac:b0:91c:7831:f4af with SMTP id 6a1803df08f44-91ca4b63f0dmr405782466d6.4.1793866302702;
        Thu, 05 Nov 2026 00:11:42 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e4a49fasm146003566b.82.2026.11.05.00.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:11:41 -0800 (PST)
Message-ID: <cd587c31-9e78-4957-aa41-53d568547654@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:11:39 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] backlight: qcom-wled: Cancel delayed work on probe
 failure
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-4-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-4-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec3a40 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bK3wT2hOXHs123jOQ6gA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: NgyAwcumrzYHmUSY6sqq7yiWAFIO_tjT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX65VWg2a9MCT1
 0WU50Ttcz2LGcEYc4xUr0Vbl6nyREL89TYa0c/R3Jo4x9pvvo8S/GpkyhMmwrJYu788xBioLAVu
 Il7xusAP3NqKQXEoFjMoERB+D0Tz2mo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX1PEmi+VmN1Z0
 epGld+aZFMEUZVrn+1/LDh5/ovtd6C150E0Qzu0NQE04ZP9kaD9U62nsEAXksg3R5j4nQJCtY3G
 K3TtZX9glnMHgqzEdurwmGQJ8iHpFB77ihoHuNK7Hs+jdZmpxvNcMHXoSufA3PRsDHPGSGKg23R
 ze268+8qmWVEBbM64vAZG1fkEFV/CJtCXoouayOqPPN1gd/9oAv3BgHOZAfp3/GZsLvtEs1zq6o
 eLbonCvfwN/i+ksFzWvj0aqQxqS4bSywlBmniRO3eZ6OKhaQvqdBHTg6MrWcK1E76f3oYoW/+Qu
 dyT1gs9lQqMPghV0YdESVsf7aJa1WpNN/U4vQehuxKFItObbM5knFbZ6C3BPHsLcOU9Jjpcr07W
 wJxS//KTXDiSkElKE7O3cc4lclp67RoGLkecp4nye0Cxx2+oOool3+njl3XsKa0vfq0/fK32ug4
 glgpJ/dkmZ+cTnD6O3A==
X-Proofpoint-ORIG-GUID: NgyAwcumrzYHmUSY6sqq7yiWAFIO_tjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032

On 11/4/26 7:39 PM, Lee Jones wrote:
> If a short interrupt fires after wled_configure_short_irq() has
> registered the interrupt handler, wled_short_irq_handler() calls
> wled_module_enable(), which schedules wled->ovp_work.
> 
> If wled_probe() subsequently fails during
> devm_backlight_device_register(), devres frees the wled structure while
> wled->ovp_work remains pending, leading to a use-after-free when
> wled_ovp_work() executes.
> 
> Configure the OVP interrupt first, then initialise wled->ovp_work via
> devm_delayed_work_autocancel() before requesting the short interrupt.
> This ensures that on teardown devres frees the short interrupt first,
> cancels any pending wled->ovp_work while wled->ovp_irq is still valid,
> and finally frees the OVP interrupt and wled structure.
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-ca2e48a2-f511-44b8-a7d4-866f360bf107
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
