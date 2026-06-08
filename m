Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C22EDD78
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939453; cv=none; b=caXdSNPWA4KD+uqk/hpEIF640GE/796KD2lrxCBTFcfKspRNPsfqSNAegYBcO7eghuYMjPgWjn0XH0k4qkUJi/9PeSS9uhGmcYETdWsQtZDO6lEMK+AXcTtC6TKwKhLWRU6mLJnSy90L/3qAKKSjEw5cIE6IV0pMViM5ATjFzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939453; c=relaxed/simple;
	bh=5FFoVBEExNYKZz7vEGVYM7wHnO+IsODRKnWMRDLXEQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6P3PkuZpjn+6rxQQCxFRl9qvsiaI+ODtBGir3MPZKutLMLqmXx8k1a+XjFmwuMasiVmxtjDDP9BTUHxQoflX2Oj/orE0dUElQCu47P4Voi0oNVehgBr0gTFZCCpiu6HOaxwko5nSlMOly188ZBxYexMfLWJBBY1zQWkznlAeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CN8pI+VF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AZYkzQan; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CN8pI+VF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AZYkzQan"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFRkj4041608
	for <stable@vger.kernel.org>; Mon, 8 Jun 2026 17:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hfgCRBrZnDBP1u/s15A1fdefY2DOaGJlkzPOAChYS2s=; b=CN8pI+VFZKtTBZjg
	Cq+3caSimpCLphuXYRweOq0L+SpwoOkTT7DhvHGE61ynYtxsCzKMXMAfZHf8rSVS
	7YjT4j7q0v7Gv4csZy4J9so0EFUXcxiv5dyzb8tIwMmTsSnV/G/3PDerdyGtlB4s
	AzzkigyyPXbk8u3lS70tQl26fqUAWANyZPs7C+1IZ76ZrzQd0wLnncx32C2qJRkP
	RvcaNtTFblLfs5EIZUD0KqF4+vYuibQokVWda1coaocmrMManpwWtKY4b3puIJqM
	EXj1YEFN3l926fUZQWZ2ToODIH4Njjdcydc8NQxsmAhaL52WEb7sKL7jVT/hJ9Le
	7qMdVg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsv9h7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Jun 2026 17:24:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-135916eefa0so15828561c88.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780939450; x=1781544250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfgCRBrZnDBP1u/s15A1fdefY2DOaGJlkzPOAChYS2s=;
        b=AZYkzQanZ9RCdY98KxuFje+QGEP+TyVERHxBS299paoUpMxN+kgAzbT9fevtUoJCKJ
         xSC6BfSbnUlG1kDAEN9hjNmavbSL+ogrVNNCzob1i2omD+x/N1qqApY8b4eatocDLMSz
         bZXk1uZyeIv1VoEEqDcW5doTG4WcBRj9oY7SgyXCmBIEXhj40YR+CQIfpAPk/Ue7FikE
         FR/4UhU/iJuZGq3qP7Nf4x8RxBRR+Y1fyoUqei8dFZ4T16twWe0TWvlgJtJDJEkq6B4v
         c/jJvhjZXPHz+AQdCN7UhzvVuPwBjLcpMnzIQUZvdJzro7F8fyij6Dc2jsgt+bNujsTz
         ok6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939450; x=1781544250;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfgCRBrZnDBP1u/s15A1fdefY2DOaGJlkzPOAChYS2s=;
        b=IklmiE6EHzsC+KjnWBxg77JDMuFFDFE3YhHUPZWO+1OdsdMvrPrKBXjtTBKfQjxEIz
         gW0CfveZeS8PMsNH+WylRoq6RkTFdf5ZFH7roe9CNrtv89dtu9/FeXuk0LpnpWkR2VCq
         UL+3m6IOcer6trti12aovL46NEqKVCI2X4gmMTlhlaqvnNu+5kSyRsLpVOFFB2+Gc/zV
         xQgU+1aEq+Q7xTCMV6lG5Bu+1aJxPwpADHY9OXcJRkZAVmqa0qAXYs/FZ6mThMKXUdMR
         sCsHVar4ZXRhyr/Oo0gcbQ6f1M/hGh5hIbY4BaWWGyX1A15NUkqKtRUO8oriECgfl9LJ
         Iy/A==
X-Forwarded-Encrypted: i=1; AFNElJ+ONZc/XTZh9Ae/i6Z0amwunEJr2DN2eQcydc/mT1Z2qCO3tNQA3Hi4JYU5RjBvjpr1IEuF/UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6wBv/ZQB6KOlyTutQb2PwAK/YgDtMK04WaYXNHC6ZKAkYVrz
	aTBFi7Y4cY0poAeU9oyC1UuBxsmSmuqKmVvLLl+nv8UYni2s295vyVcxx6DKo2Ox+wzv+oox/ws
	uTPmca0h0CShUtWCO/LeCu+lUFSq+W2hGnt7c8UTJ+QmpIUXeivVnU2E1314=
X-Gm-Gg: Acq92OFcSMIaXuAa3mtbv8f6tGafo6sMC4dVWS9HH5SmlFGxPNN/37TvRnkBpQOHmjr
	EQ/A9e1Q46YTF81kc26QsHCMgIj3KcRxAP3kN3pubGslV5OHPZi1NHJOSfda8W3GzL1JUvRtf46
	+QmHKEhq5wlF0rNv/474ztbDS0zjixSf2235gkn4+IHWgybnRZFdnEGGteAcbwxI03hREh7s5mc
	DcCcYb7fHvBpMjMJU89ZWGKM0N7r5S5ssM3HZXO+YjNYw84QcEOZs92NYfd/+OLm8Lj8CTiAVel
	QchSh0NNjY78UI4gZiHDclRdS3CIjBNwa4kijrJNNQSu+HUk2ieGOuj31On7Z/PNiSyE6wFbtqM
	cakKUCDvndW7czhKIFnjc6XT1CFcY6uggZdhh3LVL+8xDdIylF9wUw4hkmXbhYbxJW6VqMI3JWP
	7fRYwch1iGko6vfhrn0Xv5+5m+
X-Received: by 2002:a05:7022:390:b0:137:6bdb:5842 with SMTP id a92af1059eb24-138065bad3dmr7705748c88.0.1780939449757;
        Mon, 08 Jun 2026 10:24:09 -0700 (PDT)
X-Received: by 2002:a05:7022:390:b0:137:6bdb:5842 with SMTP id a92af1059eb24-138065bad3dmr7705716c88.0.1780939448974;
        Mon, 08 Jun 2026 10:24:08 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f53f06c4sm12449060c88.0.2026.06.08.10.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:24:08 -0700 (PDT)
Message-ID: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:24:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in
 ieee80211_register_hw()
To: Dawei Feng <dawei.feng@seu.edu.cn>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
        Zilin Guan <zilin@seu.edu.cn>
References: <20260608145543.3443390-1-dawei.feng@seu.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260608145543.3443390-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VX0BHtAQNEtN4OU2P6tqbw7Np5NHGbEC
X-Proofpoint-ORIG-GUID: VX0BHtAQNEtN4OU2P6tqbw7Np5NHGbEC
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a26faba cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=ceM9LITnlY0sHtZh5UYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NCBTYWx0ZWRfXyCJTu+isGEX2
 O56ckJWjr3guJJQmxPFS4oOvm+j6j3yqD1T/shzxoOhQ5EDbTVq/JNuifqZPe8O/U0H/2yY9fbR
 DpjnQYtKgz27/gJzmE946SiZKyRVkxbLCEm96XBtYV4hbf68NhS0D71TJqhk2M1Lvool1GdYydW
 XQEnxPFN9VYLrv3U4OIVe5W2ZidpEH913QSKIWSvVYqOLmIjXxostdQKFZm5xdly8er+CZZVFiy
 x/Br6qz1UyPZzUgc6gXqKSpiFBL/ZoiLSZna1dt/vnM0Ln0WdZbiDJYWKvHtK8ESiEzMlogEJ00
 R49KyqNKWTG9aiH8b47UhpSW7kwkB+saPbp4KljIBkwOlyzeQ7R2x9R98/xqtHwMBYBkP/T6Cdy
 p7AwLoBmKzEA7jrkGneO4CQSlEz1zXB7QtD3eHbae/xYgw7uxtbaDZZqbe4wY8KLfSIEzdrthf5
 M8PYOAxKhQtZy9WmGqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080164

On 6/8/2026 7:55 AM, Dawei Feng wrote:
> If kmemdup() fails while copying supported band structures, the error
> path jumps to fail_rate. This skips rate_control_deinitialize() and
> leaks the initialized local->rate_ctrl.
> 
> Fix this by redirecting the error path to fail_wiphy_register to
> ensure proper cleanup.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still present in
> v7.1-rc7.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> suitable mac80211 device/driver combination to test with, no runtime
> testing was able to be performed.
> 
> Fixes: 09b4a4faf9d0 ("mac80211: introduce capability flags for VHT EXT NSS support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

why is this SOB here?

> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

this is the posted author of the patch, and this patch hasn't been posted
previously, so it is unclear why there is an additional S-o-b

> ---
>  net/mac80211/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index f47dd58770ad..9306e0af3b5f 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1599,7 +1599,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  		sband = kmemdup(sband, sizeof(*sband), GFP_KERNEL);
>  		if (!sband) {
>  			result = -ENOMEM;
> -			goto fail_rate;
> +			goto fail_wiphy_register;

I'm wondering if it would be more logical to have another label at the same
place, i.e. fail_band, since it is illogical to goto fail_wiphy_register when
you aren't performing the wiphy_register function

>  		}
>  
>  		wiphy_dbg(hw->wiphy, "copying sband (band %d) due to VHT EXT NSS BW flag\n",



