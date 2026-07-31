Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78F489880
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534042; cv=none; b=cPuNTvNJlTorhkq+z4tZ8fPjfAljepqI+Dh2NM+W/h3rnXykLMyJUw57RL/T6mdVNgoJprB1pJhCw83Vv0N1QvZpIWv82nLSRnh2Dkd2kK7EsaBGUk8KmBF/s2mgEWtXVStKqp5v8BGtyTgl6JZpuOej9IZZGAcQwk4aY5quLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534042; c=relaxed/simple;
	bh=5AnADSN3lppxGtS870PlE0Wne3G+gQ1QIaz+dLYLPkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8ofpwyLg7k/B5t7GnZDuIw/G+uIzLM9sgdYDl85f6RqtRVAIwYtzNeJ9Uffq6OmeHoCyaMVsuk9psczcNQEC2gG2IWnXHJnsnlqErd0pkb+DKV1Z2KI8Lf41/5EzPicLrxaZffSdyVTZRkeM8MJ8tWYjAwufIcyV/ZqleV2aco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O2Hgka2/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SjYDUTuz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O2Hgka2/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SjYDUTuz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VKMQTc1382229
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 21:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TfF+pTYN4bzorxHULetkdmAKLRCNK78Wfl5RM7zPhDE=; b=O2Hgka2/DcvXYP0n
	TSi7DyP8IpzrQUFXfM19bqtEuhyZml6nY85pJ962DyOL3SfwFSouVR1bNjxgq4dX
	FNi6K+hbjcN8mauUKjJxA+EImpnLYFKuQNQH4WYkc+GQK1vcGH7Pa2gHFxAy3dWK
	QIkv565zqAwxxJ4MAxsgwcrnsgg88I0s/1tymdDvKNseir/0kkPW7DmMXIIoeakn
	jrs/lf+26Nz2ng8gxk7o91enaEqBI46I9pajN52FgbxqN08wzQ3jmFskrzKFxObQ
	1VPBUuEQxVytg7jQOauCpy7e6qUBRf1IH9FnnW+nq0OScd6iTUO2if25umoz4ijC
	zSDyeA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u2jqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 21:40:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84842381150so2717621b3a.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785534040; x=1786138840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TfF+pTYN4bzorxHULetkdmAKLRCNK78Wfl5RM7zPhDE=;
        b=SjYDUTuzUqJsb4B2+fsyfJvDgY4K8wjNp2qgKyPXOJXAxfOuRsdqqovse2AMkC+Lg9
         51a+0/+TGSVmKD/Hpj+yAM/4G/RnZ9ZOBRnc+J81OOmUv/2ZmGJ+VE39dns42FTjEjOk
         x3FOaJ7QknNig3PZFE8HrbzOb9EqGu9O/zygKgjhvaCRUpGDMlnDLxCcK3l8x5/CdSLf
         Za5fpCd+kg4Xq77rH2a66mHjrIVFrGYA2mg4ZaymvJ09bhsc73cihWOFcQNKrfcvHgF+
         wan4pCgvh4DxCuVp2hRwJ2ZGYIorQMzqiPMhhYCzzNzRjuCap5r0vZebxrA/7ftl+1Ga
         IQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534040; x=1786138840;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TfF+pTYN4bzorxHULetkdmAKLRCNK78Wfl5RM7zPhDE=;
        b=Pn34D7UHAaJPa9DSORnfq0sUOov7VdEwI1RwDIBkQGkHRJ7wO5vcumC/Qb1rlm4m41
         XuF/7n+UxzYrKjdMQDQIQAIhfsvNA8m6Fy66LLpfNecODzz0crGRqkRUMAyFgjvU9fPF
         2v/p9mmgycK254DQasfXbSH0r9K0PgMbmxMPDzXlYGMiJnYrSlgNCCJCiXI8rPCHQhPE
         s9WJ6/NOXq/gyTSDlsFPL53aXTlwYgWq5CGgevKSYE9CzZMqRkyh+GUy+1XphjZhhDAY
         dCQwaORG8qdE4jinnb+gt/ADcgz74XNSBGZx3NwXt2/B74kpi4wAUUWfaQdh/DRcMFQi
         M7eA==
X-Forwarded-Encrypted: i=1; AHgh+Rq21P1qxIZx2B2RxYN34TuUj0/ZiPHf5zNMgKJs89yJPJk7ZVrfxEmEMkBa5gYimmme5SLm+1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOlVqqsVulWWGB3UvdYVEHfMdfP242l1GPYlSB2GOeZSXI5KM
	uRXLx9vHIrPlYJlRg3+EsVcNNJn9BX2oNIRbH2fLEdSWOJ5EZHmPjMTRkTrL7gHkb5utGH/GajQ
	ByX/LIWDTag4vmcL4pBVr1lrDZvpMeQcmuhmxeuBfsPseMsgtyoiqft5pYcRrO5Coc+I=
X-Gm-Gg: AR+sD10NT3QdxcFOwfxms7cL9xY5Fi+8ngJVm/V2L8PwMZ6FSHnDnZBOi6FeCDKVkk4
	2GV8NSYTuMDbryVr6XjkihF6r8BWoz69S5C07JTJTgiHyA+o8cACgraertln9u2cFZd/cxAvXg5
	UJ4G17pTzb+cRyhqEjFqldAfCBOozIXuxbTtuMLGRZvyPFiUAs7zQsyYn9qB6HErAHXzVLZve/B
	y4xxse1dsvrD/vlTKp9942Ck3sYE755BDXVrM/lWzJ0XSYvTvvFK+XNbsw78zcaVSRYISzQPbnK
	aY5Sbj+/x6SjS/pcxVh9VeXbFkI9Yi0wKRuR3c2wsvKbw3FE28JWRArSZvZSW7mA0oFwxeA/6q5
	QO8Ojtjz9TwjWZP7o5ZeGFeGkHmmrxpFYXxo+l4P+S5gfRgw8c/0fOWmt/S0=
X-Received: by 2002:a05:6a21:7489:b0:3c3:7019:64ad with SMTP id adf61e73a8af0-3c92a8be664mr1143647637.66.1785534039859;
        Fri, 31 Jul 2026 14:40:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:7489:b0:3c3:7019:64ad with SMTP id adf61e73a8af0-3c92a8be664mr1143630637.66.1785534039429;
        Fri, 31 Jul 2026 14:40:39 -0700 (PDT)
Received: from [192.168.1.9] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e47dsm13643035eec.3.2026.07.31.14.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 14:40:38 -0700 (PDT)
Message-ID: <041f72ea-7dfc-4d50-ac0d-e0556f037a27@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 14:40:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix possible memory leak in
 ath11k_dp_srng_setup()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260727105532.118164-1-nihaal@cse.iitm.ac.in>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260727105532.118164-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6d1658 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=FZ0-UiQHMHqYDEnaofEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2NCBTYWx0ZWRfX4dzETfts6xfM
 sNa4mz6jiE3l/dN1jxe3vwsOW6M4CJMNxHGXKjk4MgbAGlHof/TB2AyLauI78h7cS4PZPXRpC52
 ZDuE8wVZ2ADuNQEDoPGFIR6r6UV3S7b07/ccjM6XbgELtkjJTF1RX4tBFU3Whgjy9f9IiElrZ+j
 kJhOtKxz/aRFTzyaWpxbj7KFcNpfW8AIM3R+/2VwSQT22dDhP/uTxm2iJ74e9KzmnHdOuK4kFA7
 iL6grrzE1YcA/pc80qOeMEZZo/Oi+uC6t0QEhq7LedtkW/kaCFwhqG0V2SYomSSHrfzCIGo9qyc
 dYpkk1JF1Vs9yVCTU3afGQF5K3lQMKtugPTXPULnt9rdjI5+xMjH/AUURaDfUUM9EDs1hFRsc1L
 xQEqus/f6JETVgfmc201v+dB2VlXsNDUxoz6RdY4klNp/SbXPYeL8iuouQ8gf4xlPgB9Hljr5Oi
 R8JU8Qs6HtmxQ0qH7Eg==
X-Proofpoint-GUID: iWONeKntMRBuLhshz4UyxJyyv4D0oooZ
X-Proofpoint-ORIG-GUID: iWONeKntMRBuLhshz4UyxJyyv4D0oooZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2NCBTYWx0ZWRfX/e6f6HSPWRYE
 vd0rgkUvceP8GnNFI+hvcvjbmzLsQmpTOeQFHtphdJGZX4BGebFgxS5EKoSb4W0mbnyRxlP+FmW
 iQAlPXOS/aLt5eNBUn+krGknsSlBE4k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310164

On 7/27/2026 3:55 AM, Abdun Nihaal wrote:
> In ath11k_dp_srng_setup(), the memory allocated for
> ring->vaddr_unaligned is not freed when ath11k_hal_srng_setup() fails.
> Fix that by calling ath11k_dp_srng_cleanup() in that error path.

Did you find this on your own? Just want to make sure you are aware of:
https://docs.kernel.org/process/coding-assistants.html

FWIW my coding agent says this patch is correct but incomplete. There is a 2nd
leak, at the switch (type) default: case which returns -EINVAL without cleanup.

Care to incorporate a fix for that in a v2?
For that part you can add Assisted-by: Claude:claude-sonnet-4-6

/jeff
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/net/wireless/ath/ath11k/dp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
> index f389b97acbdd..c3a16da1cba7 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -324,6 +324,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
>  
>  	ret = ath11k_hal_srng_setup(ab, type, ring_num, mac_id, &params);
>  	if (ret < 0) {
> +		ath11k_dp_srng_cleanup(ab, ring);
>  		ath11k_warn(ab, "failed to setup srng: %d ring_id %d\n",
>  			    ret, ring_num);
>  		return ret;

