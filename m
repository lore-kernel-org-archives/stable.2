Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425434B1B0
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964608; cv=none; b=tSRkDWNLgX3GTKOiy8/xP48uRuLWpMmDvjP0Rcv7M0qU0pa4+ge2vMQUjap23dJWpb2Y1b7F+FifsSmr6pFA1KNHs4YE53cWKKSG7VUcAH9T1S2qddITrKn5V1CVFFxOUCrnS0CrXhHrHV61mGla+X0p8ym4bhBOlaylJZM46cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964608; c=relaxed/simple;
	bh=F4ZVqw8wpZpObxfVIRZm94l19R619ImSd65/k7nnKkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcZBJnZbb8BuN1ifoVFBk/zZ5kmHh83rukWWOY9vgn0BrCMnf7DyQp7q6+QneC5gUNHvESCdHNL5dXA/qXIKRdSAfI/pt256QTBVmlaRipYMprcAia4A7bk638ZGhbM7xHdAjDwn18aub0Vp982Bm68610v17GQf3UFQqSFk/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxvElt0P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z1qu35I4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxvElt0P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z1qu35I4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KH9X3067566
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 03:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ovteoajCMGXH3GIr0qzJfxb/mOrkQymP//Bqyef78LE=; b=LxvElt0PClbHvIT6
	I6Oe6j/6I8KscN9uBlnZSAE0UEWZXdUOTcDsM3IrrEjmzv+ufaITyiDTJPdMP4B4
	jiI611AEMKx685j67G2/WbUzKe8GqZRdmOFh57Ld8mlv7Wq0vpDZDEoAp/Uz/IjN
	FXKUn0wjTDxNMLVJFtM4LQEXuEf+3k58IZy1zD/g9rm/5q1io68uTvyciptzurKh
	4GcPhP4MMOR2FD6Y3R7x5SXctiS9aLdIVipAFUS6/uO2fe+BW743wBbI2q1hxX4E
	kWTl7on5YkG3tRyf4ergEAOBG4XAYea8o9Mgqmeup1+J0I9OsmbKYw8MDmQPwRvW
	OTSNaw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510akqu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 03:56:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fe5d16d15so2386681a91.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 20:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782964606; x=1783569406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovteoajCMGXH3GIr0qzJfxb/mOrkQymP//Bqyef78LE=;
        b=Z1qu35I4TPOXNWSRx/ecNfMPSds1n5+XKj1w8YjDo0R5wLNxdgdoQfI1hHPP2EtFnt
         T/y9o8a8p90ODmM7a6yOSwexPp8iHrzBqBfgMgjMTErSKmzNbq/CMsIZDBYA5zPTxFi7
         Cc80gSJ66gO2bBNFP/WwCTWBsM0NgMP32g7FPg64KD1xH2mCShuvfAAYJBXh/ChLGhfS
         vZWfMZ0hkJfQNbdiMayg7dR78KQ4IAev1ysp64EbX/TlxvHGQN/KAqUiC2GP5QFMCiQn
         THkVxyc4DDNAUFx2tWwYsZmc94jbDRkc4g2x8RYA14etTzGYeMMh6kMMYbY9/QhRId6P
         kGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782964606; x=1783569406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovteoajCMGXH3GIr0qzJfxb/mOrkQymP//Bqyef78LE=;
        b=DbUO8YYQKtzviTq/3hQ03mqca2vCcIKyONruzvz4iX6fsPRn340zK89QkIhXjWyxgX
         ysvcJANzgWgH3xaja2L1t4d5aL/BVQCPbnqQIgBaIb6Nu1HAiby8TNSCQU1XcQSy4NWF
         MmSqh6WCAdzGmmFIQpio0kLYQWdrZYsyVXHhRDYZleNVEPVPQCSp8J7sR+/MyLoNeuiV
         K3AoctFp/h1sM3oHOBtVofgivzSvcEBmpqrXFxf7o1WdqX0BtLBwEQZ9bhOK59pcPww/
         RYq0zOKLRb5pW8inFtSJmF483sojPC2ZeUlQstewLcvvAh9czbkMtkumJHyICN5HG+Kq
         fm2g==
X-Forwarded-Encrypted: i=1; AHgh+Rqqig4PnEffNMJGXKEejz7W5fc2gLajf8VdxV8C5aPBMT9DcMSa/qSd4+CdwxXlZ6g1u4bL/Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWi44wUBc8OS+6YNCg+2Tozqev5OqNUXGuv6LOYkJaMKswsfna
	+LMvidu4DgVhrO3iMT+FAYc+n2hnRH9AxpFtKnDgeiY6jxREko2egkfW9W5r3TT/ryW0x3uKaKS
	wrK93yaUgdrA6N4CAzqCYqxgbXDTj9s8fHzdlfj/PoYYk42mfDQJ+O442C8k=
X-Gm-Gg: AfdE7cmGs9rcVb5FLZ+PANXrBnhG3lBx9jnpMImsXmADteyXA3Wj6qXWS8XfXh6KRe/
	j+6/4qDmAlbFuv2WrLFtKSN99HCkLwSIhLOsM9HEr0D5O8ZvnAr01JUeVFOaP8fNB6hHkN5i5qL
	1WLgLWz9qZX30J2BGc7wDXmrVv0nCho7V24SgPUUieq+L+FMqNRWbgiDbOpaYSE3DlbGO9Q7hZ8
	GBSfKsrZ4hk/qmfeiSRcTQE+WbE04FuENXbuSeVwFqaJ8Et/XcIuOfIOXTOZCFDdh7HZGvUSrvY
	DT9h0FYy6NlFtVcyEKgdnoQSVHqEZHhu068W2zVm4KOF88kwMHHTxF92VCq0h9CiEtp44EbyfYL
	GXUE8AYUxbjXd6dQa5tGXE2/Da4ZAhn+wjt7gXG41
X-Received: by 2002:a17:90b:2f8d:b0:36d:8e6f:8d9e with SMTP id 98e67ed59e1d1-380ba941590mr3202611a91.20.1782964605841;
        Wed, 01 Jul 2026 20:56:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8d:b0:36d:8e6f:8d9e with SMTP id 98e67ed59e1d1-380ba941590mr3202598a91.20.1782964605403;
        Wed, 01 Jul 2026 20:56:45 -0700 (PDT)
Received: from [10.204.78.220] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd221bsm3901449eec.22.2026.07.01.20.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 20:56:44 -0700 (PDT)
Message-ID: <e0312267-5ea3-4ec1-9154-2f5c0546d60d@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 09:26:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
To: Eddie Lin <eddie.lin@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 576_lIKa98iXjFe_u7NXI-J5ZtFbIDbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzNSBTYWx0ZWRfX+GlZa9+u7y2f
 iVsKAW6KSE1thWzoG3XyMOKB4+GUF55WrfTG7v9wN3d+CImSZ9Q2k9hIPGloVjgNNKR2Y6UUItd
 S5Y/LNwwzy4tl6zVPVGi11XPOQEsVZ3MFVnv0eamm6su4lwA8RWAftpKpuk5Dr1WYgUxkGm8Nki
 JUfPYT2Uui1Nguh/mK1hSWlJ0mhP0M+STxyXN5K/kY0JOSL198U/Nii8Dbo3Y6SYPeSo4xtb0km
 NH+HqdH81InSUgZQbDHpqW96raPlpZnA0XZOKwOyXQw9n7yTxm1bG0ZVL+Ty9Fm5uw/99JaW3V2
 2Qg6/Zh71PH09oJHRy08yWRu9avkKknESUjD0B+a83sYEmkHQvMsvFgOJSgnPbWqqRI2SuGF9zs
 UVKQgHHNgkcwDiKLBkBRBS9UGi2bmZujH5Izo1dmdUNwDtunB7MyK+h0LEx3N7iX0aWcUPjt8Yi
 gQj6yr2/Bn7RJEEd0XQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzNSBTYWx0ZWRfX9aofndk5UMUV
 OZw/He9ipsVCViFuwFi3F8EKVvxI0N9GYG3vSVcNoY7RCHPrzaxKDllDRrpjgG5hnzkZnDRwkg2
 I5nfcp6BVuWaXzgXtrH+9LBXHOHMq8I=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a45e17e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-sgLQT9tILotkD796yYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 576_lIKa98iXjFe_u7NXI-J5ZtFbIDbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020035

On 02-07-2026 07:51, Eddie Lin wrote:
> The 'ctx_idr' is initialized but never destroyed when
> the channel context is freed, leading to a memory leak.
> Add idr_destroy() to properly clean up the IDR resources.
> 
> Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
> ---
> Changes in v3:
> - Remove duplicate description from cover letter.
> - Link to v2: https://patch.msgid.link/20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com
> 
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
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> ---
> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
> 
> Best regards,
> --  
> Eddie Lin <eddie.lin@oss.qualcomm.com>
> 

