Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03545038
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652759; cv=none; b=WiaMJR6RZkAyUbFftE+9/rwka3RfTmvpJlM5NhyTPHkRIraBNS8hLflGHm59WLB+y/M58e0GspMdZ+kHcUmCpd74JP1HoRUSEIfo+sDQyUlUR38z3ZqE8528wZwdLsp85hcf+3wWUTEh4WZZ/mOEuwy4MpNljx2jsXRQ3PaD7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652759; c=relaxed/simple;
	bh=iCxTYMAgBKGRI9N7r9sbTxyZUcsJs73gi/yS3YIpMWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urSPC8scQvAbOK++A/iYKMDGsZJy9ynGenACGZ6mGoJMfgbWEG95gdR3fsaO36yabLT5VIX6gkYPTq2AfzcLUzK4B0WjyXsW3oQ5qf+y/Yv6XASjmzzer9amlEZgZxJL30+84HIydmgW+eJoBtOivdN+wwPMprZwk6aWsSceg+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l1li0Yu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ft/ED+dr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1li0Yu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ft/ED+dr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0jKFh2557906
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nHi9wEzwugK0YkwalEyyK4EvAEkxO86dVF3Pf//TV1A=; b=l1li0Yu1Hzt7OxyW
	NOzHgX4R1rlq+lUVyIQ6wZEjhYdyVGGUrpHPmLYo6fH4/WxD9JMJBfNotR+kXoDf
	PWLuOsGYKl6Q/PfDFrdKWs9D0BROj6OLMK9a98WkJ9EZVAcbPe0xmbe3p0urfXHF
	8dr0qzSzjw+kF3bV6Ot8oWMpZJqvDpTOw8MF2f0z2DWws+rt32PJw0ord210L45N
	AySRSsIw6xXOgi1vsiTi/6dFrD3FOj+apRUNHn/5bQHiziCbz2WGoTggFPnm56SH
	jvEnSXocCjCCmLJbhZAZzrdQ+XbQO1ppOJ+TAlNELPIE5thqmWYg4Lz7+CyFBFL8
	aoMb1w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwn9xad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:32:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so4442670b3a.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790652756; x=1791257556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nHi9wEzwugK0YkwalEyyK4EvAEkxO86dVF3Pf//TV1A=;
        b=Ft/ED+drTjtJ+FOesu3FN8H3IIXizg29qUFwZ8ZoCQdWagk5zKExArVzOHFDJ6YWFT
         m2uJS3kDUs5JJwOfYdDpk6a1rO660YNhN826K0GprguOTSfqpTZqGPcbh2fP2oNX6jgL
         1Qa1zwmnoKuuCBpsWEP/NwMCIa0YR8oUEd389JvUtrSCQ+f0M+OG5W9+eozjQu3czitB
         NM5EGXhADHKU8m52+ZorRjkjk8BZCVzMZC12RFxr9d5NwTpyjWuKqlOI8npJqJuLMbYN
         XpjBSU9uAl70ojP1LozVOTRUWErL37HndvBwBCSN8J66LEt3N3bjw4FJAV0NqXAY+JOz
         xn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790652756; x=1791257556;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHi9wEzwugK0YkwalEyyK4EvAEkxO86dVF3Pf//TV1A=;
        b=Wjr4WFbtpXMUSnatVa4n86fJWa1dOw/5Iafhx9Zyy1WBYdmOghaOXdcETzGRJDFzW8
         rnS1tUUIC4TPQUMMUYT6gvopUa8HC8TkZ/IxAw2dwBF02qtgwur0cAv90F2PyYVjXa/4
         8j1a9vR/8GvUFzbYhJ4rIrKKHsi9b6D3L58G95w+TMNVN9/TgBTw7Lptqe2hbN0xCRTn
         XPADnaEThrBFgCdt4EL3JnjxXNUxCkD3x4k1i8lyu1HVUa1XdDhDP4P6MVM281Zp5qh5
         g5GzEbR7lZhNVvpo0e2jXOhep+1XQGchqMpj0IhPBx+VruEcQIWK2Ell2ulERCuP910q
         Mc7w==
X-Gm-Message-State: AFuF++mvoaa3xK1MwZ5gAxENLDXzduCueJWynpkKlYUTmr1szP5HYImT
	i/nGzIWZsjGD6x4K/uePHkfujKdgzlWNxPtLsSCxkeYR7+l0HOdtmnI9agQmoOhSTbP8kO8t/Az
	IEnj7XMQ+5GgMe8aZG9RY17czi2K3bXQpqj4glEE1tbxoE9P5bQjpuXkbZNLHK/kYKAI=
X-Gm-Gg: AYBFou2ZcpzH0AcNrblTXyKmFIyNpM/rB/ryYErvuiwtqxxSm+esUwkrpeek585McEO
	5GNG2xRr6mklWFz0VWiYuP2WSX0Ak43W9XBovJPR5sg3cP0edow5S+OcoULA1kEdiNgZK5z6t6I
	2OykjI9FyGV6GOBXAubFFS0a7SuPpXFYsEr6SVD3fqwi2/xF500VySxmJqDeGlNyWE9WdlOSpVt
	LZc0uITjcVPKFBlAsf81asp1jIIv/GA8Z0s4MH1nXb74XmBsfOMijytdn88xCdhJIaBi9GAYF89
	QHuFdmISHJXzbJzjTsctVZfKPEjtcZ6FEnJmPuQ3dOrrzQhKD/16E7b6KJwVgkvf7MMy+NHDyBX
	tnQrfwS2EVJbVMFc4spt6GDOxHj3LJ1IMCvYsGqfQ5tkkfZ9E1XWf7uTlH3fHrgBTNSf+egNw
X-Received: by 2002:a05:6a00:178c:b0:881:233c:46d4 with SMTP id d2e1a72fcca58-881233c5c1amr6810575b3a.43.1790652756199;
        Mon, 28 Sep 2026 20:32:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:178c:b0:881:233c:46d4 with SMTP id d2e1a72fcca58-881233c5c1amr6810564b3a.43.1790652755690;
        Mon, 28 Sep 2026 20:32:35 -0700 (PDT)
Received: from [10.133.33.76] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-885e21f541csm49094b3a.43.2026.09.28.20.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 20:32:35 -0700 (PDT)
Message-ID: <bb1831c7-9281-434b-8324-ea93e3d08e33@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:32:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: validate MAC/PHY capability count before
 saving
To: Jiale Yao <yaojiale02@163.com>, Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260925121739.2061979-1-yaojiale02@163.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260925121739.2061979-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GGCeiY5RclFNLmEQ3OQcVmU4MLZUj3Qy
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abb3154 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=mfIliDvppe9fnnH-w74A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMyBTYWx0ZWRfXyMZRS7mG4s4D
 MHur9F2POD6odByCiuzU7Rdr5vzTIHdpFZLHZXoi6ToHewKeL2tCTmwgCXjKQb1bumHtp0cE1fD
 EDxPJ+Rw0wE4We0ukziq+VGbbyDjNoBBEQLY8Lfghuqeat5hgraj8B9rSieXVnQzQL9WhdZBZWi
 Rhr5H+8gYg+JLhdRPF/DJr8bL6Uz92tp3clT+uHrXdIgDxXhZY41efAB03TjCiIIeWL4MhtbqsH
 NrxZWCKG60cwClTalaOOilIimNj/QbavrcnyJklzrVr2yv1jRaw93tPEfjE7TRfy/l+WAU+yawh
 odqrTqLgeFtHz+AbWIgvm3lg0auvbvUv7N1ZIUAZb83ckvOVfqelK8aZye9HAsLRs/SoZhFwswh
 xN82EYBC2PVAjvtMCTh8htj1wM5NlNrd1SQLLIkYELatRpJLIM3+gvpk7PhxyUVtsZqlWo1nB/8
 EyRnElnq3Z9n7ZJa5Dw==
X-Proofpoint-GUID: GGCeiY5RclFNLmEQ3OQcVmU4MLZUj3Qy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMyBTYWx0ZWRfX8Qb4meYYBxRg
 NG0k13AQZI9EncT15c9jLJMoqwza0Crdxsq3aVUP5mNP4+rEK7f3LR3J2EG8lPfotBtWcRFew9y
 MZx1gMkq3en7yEW1w59qXxrfGeHsd+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290013



On 9/25/2026 8:17 PM, Jiale Yao wrote:
> Firmware supplies the hardware mode count and the PHY bitmap for each
> mode in the service-ready event

to be accurate, it is service ready ext event. we do have another event named service ready.

> A mismatch
> between the advertised total and the number of parsed capability TLVs can
> also make the source pointer advance beyond its allocation.

This claim doesn't hold. The source buffer mac_phy_caps is kzalloc'd for tot_phy_id
elements, and the loop's mac_phy_cap++ runs exactly tot_phy_id times total, so the source
pointer reads at most tot_phy_id entries — precisely the allocation bound, never past it.

The n_mac_phy_caps > tot_phy_id case is already rejected at parse time in
ath12k_wmi_mac_phy_caps_parse(). The only mismatch that can actually reach
save_all_mac_phy_info() is n_mac_phy_caps < tot_phy_id, in which case the loop reads
zeroed-but-allocated source entries and populates mac_phy_info with all-zero PHY info — a
correctness bug, not a source-buffer overrun.

> 
> Validate both counts before writing any entries and propagate the error to
> the service-ready parser.
> 
> Fixes: 062ade23991e ("wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index d5160af60e00..59ac17f0d48d 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -5004,7 +5004,7 @@ ath12k_wmi_save_mac_phy_info(struct ath12k_base *ab,
>  					__le32_to_cpu(mac_phy_cap->high_5ghz_chan_freq);
>  }
>  
> -static void
> +static int
>  ath12k_wmi_save_all_mac_phy_info(struct ath12k_base *ab,
>  				 struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext)
>  {
> @@ -5015,6 +5015,20 @@ ath12k_wmi_save_all_mac_phy_info(struct ath12k_base *ab,
>  	u32 hw_mode_id, phy_bit_map;
>  	u8 hw_idx;
>  
> +	if (svc_rdy_ext->tot_phy_id > ARRAY_SIZE(svc_ext_info->mac_phy_info)) {
> +		ath12k_warn(ab, "too many PHY entries %u (max %zu)\n",
> +			    svc_rdy_ext->tot_phy_id,
> +			    ARRAY_SIZE(svc_ext_info->mac_phy_info));
> +		return -EINVAL;
> +	}
> +
> +	if (svc_rdy_ext->n_mac_phy_caps != svc_rdy_ext->tot_phy_id) {

per comment above, should we use '<' instead of '!=' ?

Besides, I think the right place for such check should be in
ath12k_wmi_svc_rdy_ext_parse(), right before ath12k_wmi_save_all_mac_phy_info() and after
mac phy cap parse ?

> +		ath12k_warn(ab, "invalid number of MAC/PHY caps %u, expected %u\n",
> +			    svc_rdy_ext->n_mac_phy_caps,
> +			    svc_rdy_ext->tot_phy_id);
> +		return -EINVAL;
> +	}
> +
>  	mac_phy_info = &svc_ext_info->mac_phy_info[0];
>  	mac_phy_cap = svc_rdy_ext->mac_phy_caps;
>  
> @@ -5044,6 +5058,8 @@ ath12k_wmi_save_all_mac_phy_info(struct ath12k_base *ab,
>  			phy_bit_map >>= 1;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
> @@ -5094,7 +5110,9 @@ static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
>  				return ret;
>  			}
>  
> -			ath12k_wmi_save_all_mac_phy_info(ab, svc_rdy_ext);
> +			ret = ath12k_wmi_save_all_mac_phy_info(ab, svc_rdy_ext);
> +			if (ret)
> +				return ret;
>  
>  			svc_rdy_ext->mac_phy_done = true;
>  		} else if (!svc_rdy_ext->ext_hal_reg_done) {

