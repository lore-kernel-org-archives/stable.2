Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F14D5995
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474377; cv=none; b=XhBnPUw8jTF8fweoeQo5O73uLaYvPrmOKPigjIrRc+R9HAcxQWcIm/A9DPFD95F7pkvOHlj+hU1izsYYI05LTm3k2YmjzUOEYO0hhdLT1gXFqFZPagIyKNe7vDdODoJcVlRj7yxboMBMEA+lVKMuawpOvOd4DgS0+MMs/xifzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474377; c=relaxed/simple;
	bh=MZcUM/dJpZ9RFXumChXzGNhuIE+T+u6w9tzzujXG9Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3Gx1+qFYpQ+b/sTmV7c+5VvTZ4GYZASlHJIR3KHD6C9bhYPnO9psDseszNa1JOVUUkIdfODcrb1dQjalGiF8eMpxYAo/n+9DvBF/33G1e9C3AVgEB8VApcqHKbRk+sqgKa0ccyGjVCJOiPAi+NGiNCo975cbV1cXVmpHQaP4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IDdlC7KL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PEcZTuV0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IDdlC7KL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PEcZTuV0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVR9o2801200
	for <stable@vger.kernel.org>; Thu, 8 Oct 2026 15:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SdaWk4J1SUSy1sTSJCUeAg8gl8VQADSdN1XsBILOqy0=; b=IDdlC7KLsT28Pq70
	Cav7C10horl4ykdp9KDt/xN30o1lwfnsXznhVNewT1tfkI7CQ337bR/X+2EKwtwF
	NFfN2sCP+wZD0KA6y7RJwjRHvftZSPu0o2gczo84BTg+AWx2ng2ZiXY1hcThulTt
	o2Y8lp5e1jyDmiIUnVepUR7GTq2+JdltN/bu8Q1mwhNil/Zv/lkPL7XSHFybSq2t
	RpLPLN/c51OsdkuXSFYcb6iucFZV2i0qPaeawj+4HIFlTZPYiSebeQiAOUotbQCV
	iUrth8CRiUGQ7OZphJcLiV/j//H6lRwgcmmKREZ+Syds6hAGERztWtpsbWwTQwn+
	SsGp6w==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3knrv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Oct 2026 15:46:15 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8255327a28fso6098283a34.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791474374; x=1792079174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SdaWk4J1SUSy1sTSJCUeAg8gl8VQADSdN1XsBILOqy0=;
        b=PEcZTuV0aCN9Rew6lYhzERh5x3ZhdP0MW6ywf2dNWcCjlgW/sa+PwN54Yo4JfkLiRa
         Lu7zv2Jm8cb9qp433c9CO1jPg7dzsUIotm+BHV4vIKdftwecB7dgkLv6WkyXHdy8TDvG
         sHKZBs15QxSyZ3V2yyhIvkEZkjjMKIHHLtAdlHBVnGH0vDB4p/NVA1hQ5xg5vl+VudPp
         +Em8h/DjRSmU4KzumvqskxnlZBVZIhcQewzMk/+nJqwH1fvpHMQO3M2ru7qhyy6Z/E99
         dV3SfJW6MPiVYWqULHZOFMnUJM4TS6ery5EpvLjyK+zojFyxnVyTJ+eE1BakUri4SGZO
         FOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474374; x=1792079174;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdaWk4J1SUSy1sTSJCUeAg8gl8VQADSdN1XsBILOqy0=;
        b=tIZN7HijG5/KqQfJ1g0EfcAowbrfW9WQImJoR239foEz8EPkH0YfmW02iiJwMSsBBf
         H7FF/WWFbcqxr2ryT/e1pyJ/nfR2Mh2IWHUoK+yCj9QuVeeYsdpG+/bBlR1IoS1i8D1o
         CQ+xZK0XZGcp7J9Pop5iMuDtE3zOP7HQ2tfn0g7KBt2QYVvQznT1Mr8X1CnauUFbk1A3
         VzJzWdpASwqkhuFveyraLysKyWzuum73nBeeVHYfFtFFHL/cgCtl9aBatBxNWkR5VV2H
         KDE7eP65P5gqVkqIc6+KqmKt6J735KCwDBFHOvxekDzTMZYunSS1U7zDudN3p6KbCkZI
         Cg9g==
X-Gm-Message-State: AFuF++mgxrzxmELm+n3DpatfgJwLa9t947Ga3NvACS2ZsyNEiFNmOZ+K
	W8mUlImGmBeUJqxP/gKmNb5DW5Cq22jj5sjdEBMtZrmlIsPRaBVtBubJ9bvHcVJ0TdNJvmiOX9w
	CPHscxE4diYmxmFMTe59FuU9dbeVvNZu/C1n3mc4WCBzzfmGO3xiP4/CanP8=
X-Gm-Gg: AYBFou2Zc3m9JevVXXxM05fryATnU9rVS2MNUqZjBdZ4ZDu2T9jRyeryudardRXK4af
	rYRhqmhp0oMdDY4cidGZ1t9WWjBJUWYX2BgOr97LJNE3YP4F4K4iPh52u3az/e1QbbRNZlpW9Yc
	plR2EwkxbOkkYvUpMt556nLV7GSaqngtwe8PmC5eY1guPdU0gCx9n+XjIz4dk8Sgbtv+gF2QT8+
	ctehrghvPQ5p3IvfuVblceRBNJNQIO9+4EP4lT0OezNkrvstuf6dyp2OYk/4ur/gqoJwzfuDdjG
	jVFagdeDBC3qlwGOv2D2s+3RgaFq7xzXP7x11mobMl5z8m5WrlpBeo2EuguCdjUP1cVPGtpiyQU
	ljEwA0WPg2LYFY69sPJSOjpVy4BgnrIcaiR13FdTwrtE=
X-Received: by 2002:a05:6830:2b28:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-82acd86affamr8593980a34.2.1791474374530;
        Thu, 08 Oct 2026 08:46:14 -0700 (PDT)
X-Received: by 2002:a05:6830:2b28:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-82acd86affamr8593949a34.2.1791474374041;
        Thu, 08 Oct 2026 08:46:14 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.80.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc3eb1d0sm5702069a34.10.2026.10.08.08.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:46:13 -0700 (PDT)
Message-ID: <6de89bd9-ca0c-439b-9879-00d0cd5cc706@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 21:16:07 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: validate MAC/PHY capability count before
 saving
To: Jiale Yao <yaojiale02@163.com>, Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261003101944.596546-1-yaojiale02@163.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261003101944.596546-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX9XvehRI6xHdM
 TmULOnSdc6UwE/h4TGQj9oinTntUzj1TG8RmisTuoUPwZn1jy5Dyr5omhaM8rY+iZBvMf3z8lH0
 BrqXMv1qU80K/z0dnos9PZlZh5JwX/g=
X-Proofpoint-ORIG-GUID: j-3fuWWYsje8g0oH-49EVqpCxoEPTXLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfXyFYPl/5Hl+NQ
 Pi42t0IaRpAtQGSstkueu7ovjrm+4bIRyjQM6klab7fb0JW571RQgrBmUtB2ObBbSSm/Q8GoldC
 SFpIRcS3XeoUFQi8s7Qa0HahSyQDZmmT1a36KGTY1w2jTepWWYFj226Pz+0a4Gm72OOw6uA7XV9
 YG1OoPnOEQn94wj3DJWI1dc88Chj5jQDs6V+y2y7QmDjPbmsUbw09aWlfT0tCY6VuQvG7qt/bTI
 hjHtSJmX5t0opePbtEdKbEhQneMu7l6cfUMQZy3HoJ02zSpvD7oGyhAu6wCYwhGhPPKEoUE1Uks
 xSlm7si4xNCnzcq6SILp1dMnKHvux5RjzepKJemMHa9tR4MhkUo7VwkQhlN0SDdh+2wcjS91kjV
 5rgAvTOMMfsf4NA9oZXPFpKGLXH2xtjuQ/bRoK9RnX8aV9W1zbIv40Qxvl93PKA4qoR+nS+zNAC
 q19dFmbmndmITEPXQgw==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac7bac7 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=kllYWVK2JqQtNyhMtAlpJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=CgAF95LDYrE-zO_MwBMA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: j-3fuWWYsje8g0oH-49EVqpCxoEPTXLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080062

On 10/3/2026 3:49 PM, Jiale Yao wrote:
> Firmware supplies the hardware mode count and the PHY bitmap for each
> mode in the service-ready-ext event. ath12k_wmi_save_all_mac_phy_info()
> uses those bitmaps to populate svc_ext_info->mac_phy_info, but the
> destination is a fixed array of ATH12K_MAX_MAC_PHY_CAP elements.
> 
> If the total number of advertised PHY entries exceeds that limit, the
> loop writes beyond mac_phy_info and corrupts adjacent memory.
> 
> ath12k_wmi_mac_phy_caps_parse() allocates the source array for
> tot_phy_id entries and rejects excess capability TLVs. However, if the
> event contains fewer capability TLVs than advertised, the remaining
> allocated entries stay zeroed and are saved as invalid PHY information.
> 
> After parsing the MAC/PHY capability TLVs, validate the destination
> capacity and reject an incomplete capability list before saving any
> entries.
> 
> Fixes: 062ade23991e ("wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
