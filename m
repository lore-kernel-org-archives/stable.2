Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0047DD4B
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905750; cv=none; b=a5OR50fTqlybBHijPz7ZkajKMrqBf/UtNc56P+KtpHZ7Mx5qMJ/KMQZwschg1gy9jy9743Dj1Skm/WpTDPPc5w3TQsOwAtg02ecdC9484m3x6DOnDvTdrTpMBjVbd+uMTIRuZqey0puhERyG7ZBzySefF0jgTBKLPltUM41V1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905750; c=relaxed/simple;
	bh=hOpFGYO9HkGSh9BXqulckeQAdS16sxy8NIMsp1FlW+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyDXRFsH3JSMjYzGK6NLA7b/NEKrQelOhXdgOzj6jy/h/JPU0vU1/UM2j6+RbFReZ+b5kyi3pHRMAzLOE93ZSX5hT9+UuCVGgGhUNwBT9w92OOOKuHhLJIRjK97axQHAC17Vz/3Zxi5HtVRG9j/H1u6lIp+Qt7JiLljNjrNtQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvcifFMp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XSqMmBWK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvcifFMp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XSqMmBWK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8iLj683268
	for <stable@vger.kernel.org>; Wed, 1 Jul 2026 11:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fkuArwX3HTlRI2MmPQcqM4DBytZZqydkRSJiGkAnDt4=; b=XvcifFMp5onnzU5V
	d/UFBCw4gg/lpJKmlaAWt8cRkCWPdPpcngQnhYgYzWqxvbXW4J+SNMjLb+MsmDJy
	djnlC9mQXbuxA0uat5oo983eh4zoW442GfzvSn5BwT54oxWxUbbad0HLmoisdzKL
	R1Tn/5y5uo5cd9nhl/UHueQdGW4r+f7vMoz95ChIKoH7BjjmjzDAM3Gmb0lpvziK
	cWhKO21LoVoSf5pLoOp0aBGScaxVwFaeJF4u8qyiYBtSUZ7Fb7R/sMShYO7gKeDo
	9zkkvn2NOVeKKYo+e64XUG/+jJlsF8wyb+WCc3U9a+4KMSme3Tbo+wZSdRsVF2OL
	cml/wg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqm0m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Jul 2026 11:35:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38096521198so968095a91.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782905747; x=1783510547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkuArwX3HTlRI2MmPQcqM4DBytZZqydkRSJiGkAnDt4=;
        b=XSqMmBWKEL2RqkVobk2c+wdKd8+Azolu1b3uFUxKmgul/J5L7wkRRr19nhLv7EUk2n
         SbecxKXrExOjPimKDiYXii1B+4miyA30+McDcMtX0QDjKukhFle3k8LYjy+HQftKuEnw
         dWsEXxgXSS3EGCMfSgD/3KMApVjemv7aKZgHXnNmmLI7OjmOmaZ4fWTPDoLjydmgGI34
         RnSbMmZsgKKJJ/z5bHuuXwTXboLQWUrbN+71HBH4hcUyPPtBHyCH5Oma5SCL3vhKa6hZ
         X+D3xDDOQJQw1nauGmxS2lTerX1/IPYhgCeb4Kb8xlILIvrsV0KzUVWrlpx+/HJW0Ib/
         cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905747; x=1783510547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkuArwX3HTlRI2MmPQcqM4DBytZZqydkRSJiGkAnDt4=;
        b=BU4nxpeHNvQKw8v3DNDqYB5T05OYGz0JmDaNcQ7QMwraMZ2NDbw/Ub1YZVUuH88ny4
         Ja0FzkZebEpGP9BtyRoEboaukz7UlffYR1NvE5Z/UwEfV7Bvh1Y5gybJ8uHjlu7uLy7A
         PcFwxKnUnJFtPNPWkW3y5SD0DzKtNUejgE3BoLcoLbgXbbJ03R764rOyrPYWlq7hL3gT
         +xazmzYiwiB1jBz3MKnPI+rBGYJEPXBMvBBGMDuvqLvmUh9gl+ALHd4YiNpcjZDOhhpR
         1wTQABv43b5MNBXrLDcuLJekU+Tv0XtklOxC+TxK8TKJyqPNvb73KkzBm2j7+B/4VPDF
         QM/g==
X-Forwarded-Encrypted: i=1; AHgh+RrWxIjPkssm8+9rwetcmY+mP0fOikrN3ntbUkd5MbbCyowcUpwgwk2QTe005A9zbb/i7CyvsMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNNln9NICIujFFdntvFgoA2azx3k4Lx5ZoRMVFoUErgTu8A4W
	9jAmebiuUhORgEFu77Pla9kmkaWPMqFMZJwldKbnL88JOaxsmcneD+N1ir5vos1ek7yJd/4jsKM
	sRrrCDTcjMWPiEAx8Z9P7n/5Lx+vtGSYdW3hjd4l50KEQbkqn1K8S8WzrD4g=
X-Gm-Gg: AfdE7cnZVfNXvdD+vhgsRdwnzASnoSNNF7Vw0jxv0ygRpF1luizsEm/I56j4xbZWFbV
	ZUR4AZYaP6vAa75HCsQN6YM0NLmxcW2C598LCmIlaUP0I0BGQX6qv3aKcekzdMpdySan8s0EPtx
	9OSbuiPvMSHFgkzjAyjhoB35WO8zv6Z3Nkk7ZK6fg6qWz52rYNIvQSRpYxcUENRSYuCmSfLQbHm
	PMSz27fBFINOY2287ivzEs6QtZEhqmQP/GbVjH6M6NS8mchrzmFfZGer1tmswk/vXDYLMQ1DBOF
	Ga+SzA0+AL8RHMg2w4cO18N+EkdY+k/wUAvBcGT84reHIlhNMkiAEhNlPIg/9rgc/3GplyDZgFO
	SajxlUPGr4GLYUlQtlPh+04t+RMTU5Jza18qShk+/zQ==
X-Received: by 2002:a17:90b:4ace:b0:37f:9ce1:cdad with SMTP id 98e67ed59e1d1-380aa1d944fmr1315972a91.27.1782905746523;
        Wed, 01 Jul 2026 04:35:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4ace:b0:37f:9ce1:cdad with SMTP id 98e67ed59e1d1-380aa1d944fmr1315941a91.27.1782905746045;
        Wed, 01 Jul 2026 04:35:46 -0700 (PDT)
Received: from [10.206.103.168] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d47dd4sm1725623a91.1.2026.07.01.04.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:35:45 -0700 (PDT)
Message-ID: <8798249b-631f-410e-8b1a-fb1c35545134@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 17:05:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
To: Eddie Lin <eddie.lin@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3RGk7s187GIUQYDDiG_Ez9jX-7RjxSyG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyMiBTYWx0ZWRfX/mRQgzBhDJBc
 NXIlFK0HgT//dtN7oeyzj3HwkVZ6QHMr4IiEx+hbn1t6ZCQ5C4yq8cjgnWAam6OwRWuqQGBGm6i
 L5xytcul/bBFatvU+6hO3H2iP3lAxTcv1FV2nCteYh/zz+m1Fn4MQEDXJJo6aI8HUo8BPfxe7D4
 CyGbEY1S9TX30EhZAe3Ji5/v4CwZUqwx9slqGwfeG5HG5NZmdgzqHGbIIyE1CRaLY3yNgTxL6TL
 8RamFkmQpU1IItbLGa7gR6a9zwvLNZjft9uQ6958yTccA2l2Ke7KtX9Ixy4oIgLDyrjw6c/Ap2z
 NotAUOpqO92aeyykI4ozhD/hXNu6pJhghxgcvRPRDLbAdRDxSq08BOOmlcz11oBTucgfPFVo6I8
 5NnxGZTpVTUfu34MRKxVjW4bCOB3GDnKvtMXdxDMIqVFg6QLveGUo/jdcRlGJ+9VCn5qpZwguuS
 os87+q6tTYy/djIB5Dw==
X-Proofpoint-GUID: 3RGk7s187GIUQYDDiG_Ez9jX-7RjxSyG
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44fb93 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-sgLQT9tILotkD796yYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyMiBTYWx0ZWRfXxFGWBFh9Ebhu
 N4PKHk0pXXpoc974IB03fmOTnVr4Twgg09iyqqOqeMimW1ce+E/o9P3RyFkU5VYmvSQtsrLnjUg
 nHdtQ3jpfgcoVcCVF5I5bVh8qnwfmBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010122

On 17-06-2026 16:39, Eddie Lin wrote:
> The 'ctx_idr' is initialized but never destroyed when
> the channel context is freed, leading to a memory leak.
> Add idr_destroy() to properly clean up the IDR resources.
> 
> Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
> ---
> This patch fixes a memory leak in the FastRPC driver by destroying the
> IDR associated with the channel context during cleanup.
Looks to be duplicate information. Please remove this.> ---
> Changes in v2:
> - Added Fixes tag.
> - Added Cc: stable@vger.kernel.org.
> - Removed duplicate description from cover letter.
> - Link to v1: https://patch.msgid.link/20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com
> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a9b2ae44c06f..7727850e9240 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
>  
>  	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
>  
> +	idr_destroy(&cctx->ctx_idr);
>  	kfree(cctx);
>  }
>  
> 
> ---
> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
> 
> Best regards,
> --  
> Eddie Lin <eddie.lin@oss.qualcomm.com>
> 

