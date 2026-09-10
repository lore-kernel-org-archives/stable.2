Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82E40F73D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027469; cv=pass; b=HAJ33YG4P6HDE7KI/zsbXke8rrxueSN9cZz7mOZuRLZJYj8agZ/C0mfgn+Y6FVMCW9/L+Jk/uQyK/KbhB09/vAiQLXhtjM3x+uHhD7bD83suHR8c4t+GRKex5eC9yJlsO91gAiT/rNHHid+4oQOqHuaL3XmTLmqdFmQ/Up/ImB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027469; c=relaxed/simple;
	bh=n2cIAllNT0nJjeJo4jRL99c9rKBr+TN+8nn6Te2jgdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIodJJXzcdQ1xcS4+CawLgPdFAelMY56SdUOHxpF7Mp12iPs8C3Y7SyCEBwuhKxBEkgDO+ap7mVwroZDid5fCR2KcOqTSQHny3D5EGZcS+P9Jv3NlOhQSECysklSH7y4ui+xTADa06Zqq9EqWHu/9VWp5hRQZkG0umMLLxaERT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bG+GLMjQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iE0p+so6; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bG+GLMjQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iE0p+so6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GpBo3655280
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aVp2PxzSnF7Gv7LzU63KU8e1fXCgBNRP5Ip5W98UZ/I=; b=bG+GLMjQI0EG20Hy
	Tov2ZyBuFIc9E3tY1Pv/8/9ZNF+VOsf9hC6x9i7VzXMpqnLAmwpiUc6L7l6Zs1Oi
	x0yObXVDkt7gg+zCGeWa30cBk3HhN85gpyrAIppbEP8Jou7Eb0yWC8X7fHcErZMn
	r8lVqfgdnjUN+Uk7NNpG9V4XQTuIYx0CTodGSr6hFzagLxqIavdlNc+Z1YQLuwnb
	ZrRzZZNP4rF0+cfAEeQV58PTROM3De6R9nK1pZ8TjAHHxYmPSbRKInStQznQM4sg
	B2zrksKN7CU03Btos/pwAxw0HTji65tNaBKSQeGrEiaVZQkNNFd4fqqwVnjYisJM
	9EyOQg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydtrsn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:04:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939a6937513so572148285a.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789027463; cv=none;
        d=google.com; s=arc-20260327;
        b=i5tGmXZ2DWdC4hBFYN2gVNsya0C5noB0in2NUIcUGFDoYvkauHdC+KenBvca+sls5Q
         k6ZoO06hQDHkCMzUXJnZKx7bTXqJWGQrHmWyz2RTJqx2GMWpLaIcmJOx+DblfWT9nyq6
         qba6lJZTrp9GqJVP1IP3Jf0Z9NozpWY3MTshFjzaX/JJHOMI7f2bzI4TCvmLJjsl/b+x
         Mxft/PC8vOGO7bEqze4nuVW69N/DeEB0dQbmY2trylbOn3xgg/CFhakT+uf3MAzDDBi4
         IBz/owwEDRVovwm4JD9qD7pMR1zMCAQQxrxGccDzWqOYvsXmUukEbBQefKs/Tdt9QUHN
         lZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVp2PxzSnF7Gv7LzU63KU8e1fXCgBNRP5Ip5W98UZ/I=;
        fh=oP5+c1bWL7fwNtLtGBIBnsQqMDsjZvQZBWUoorrNbdI=;
        b=ZRl2v0PwzVH25X9NDsYsg7Tn3fRc8lJLF/7RphhcA+O4Gm0f+7AIdoYYvlG8YIHvMg
         v4x5ES94Gk7WhPEgq3/q1+r4yCxtSSdhY9zJ7qXZVngb1TevxLRrNjs95dUm8DPpFwRW
         E1qVidxtc30wK34bUjnkUORLdq0G++2eY9UYUI3meqGasls6hV+P71NUabfCgmjmasUq
         dLunJXQzV3sI6eSjZsm1DQE1wjhPswkkpdaWAHAIv+ma1kL8groBDpCx10PwbeZNh+fM
         H8sCxfT9v/32YicITkDGivPO//I3NttDVU+T4C8TwmBU6ohyByduK1AVDPGquH4eDtOM
         MgrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789027463; x=1789632263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aVp2PxzSnF7Gv7LzU63KU8e1fXCgBNRP5Ip5W98UZ/I=;
        b=iE0p+so6wiIQg0R8Q6dZ5GXpgRnsdE9jrkLUlWbXPGsHtky7EwCjRnJIySDxGgiOvl
         2PCg5cfssqs150iZlErXEtWKr9e2OjaTDWx84/jdenkAx1W5NvHaHJQDaypX5rKrkXYw
         rVirDIfSvyY8l735STRiHVwRhkjvOhEQ08fIuAyN+WUBr7goU0wUL3J0f0Bn6qVc6hjy
         HK1+x8Lc8vSBEWRedqSV5GsSznSqORdaBCdBXB75OPv2ZDXl3ifXlGqBmsoCeelx+g/b
         EOAdv0t1vFzoqlpE9LGhQHPnANEepo5XzTzE+Szgo3SyycOLr7j271O+9FJJkAv2AiLc
         AjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027463; x=1789632263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVp2PxzSnF7Gv7LzU63KU8e1fXCgBNRP5Ip5W98UZ/I=;
        b=eYcPv2v3YMDPeAfoIinFTsNUfzql+QqWsoCUWrfJ+aElALCOrqPq0sIJWhC4Dn6/6X
         sFiYe4XKnsPFgqOf9PH80JMVyzk39ZtezcQx2tQ+J0GA/cNpYrUyt/Ea3f7ML4DY89v5
         b8YDctiWm8gv4nJPXIzTNSWFjpBQRivIL3R97bpUIaY8fchob6IBviL2Q12RwY4w9DgX
         yGUCSM4UnDTqLa+ehylRYkA62C0975YxlH89HJ8ONBmX1tk26dGbmr65ULOx0YCR+2+R
         VPO3UXrCJmz+1ycgKnm7T5AOAIfVRZg6N5zMjrvXbFZAFXqF5y1UAHBCjACuSWCQnXWH
         PZ5Q==
X-Forwarded-Encrypted: i=1; AKwUvByUHRS4k1WCNToQTvSLqG83ukfx4Ciq/ci0ZVySH1Y2zwE2xzykAsIyJ0wcu/cST3Z390hATs4=@vger.kernel.org
X-Gm-Message-State: AFuF++ms4LXkGFYetzGx2KRbUF0RjmtruSoKdddbnYJ5b6BvSjUyDPKf
	K14WKv0ydRc7e/9N6ACgMBJBg344vxycfZwZSComQrzJrPXuh9MufJp1Jzp7bhO4wG4gqMC+QV4
	MapLY0orhTo7c21xUJQGb6z4iIZyxIo/Zerb3nwWf+fgM+uUDmttigFvd68jkC3awhf4tR+AmHS
	wpBK1mKC68VOfA9y1DrQGWxmDmSU/01kbsRQ==
X-Gm-Gg: AYBFou1bZAmG+StaJNf9eHdPt0Ss6ccecv8H5laUtI1PK0U6vQU1NqfAZpqqil4va5x
	CzmVmifG6D74rnQOSb91M96KSYVMkh43g7ToaGBKvS6EQikYxTRPM4d5Q9T8ff+Mu2apy9BEzdK
	cz3mZ9NwhVMv2Xba6VJjZf2yVKQrVHKqi80J1aiBqnifCYBayKsKe9NA/P1RlKTCFRhfW95lSA1
	OjGmN8OjfQrvemiE0YM/xD1A0j4Q7uy8r3tZ15gp/6h72wrxSUjzHjVLDSzJSfUAgHG+enosoO+
X-Received: by 2002:a05:620a:1599:b0:914:e3dd:17ea with SMTP id af79cd13be357-93980370680mr3042395585a.12.1789027463093;
        Thu, 10 Sep 2026 01:04:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1599:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-93980370680mr3042393285a.12.1789027462644; Thu, 10 Sep 2026
 01:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910020907.3353-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260910020907.3353-1-fanwu01@zju.edu.cn>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 10:04:11 +0200
X-Gm-Features: AcwNN1XDyuOipdnNBvvPi8Yo7bvNwffrtxCGR79cxsQpnJD-rHw3MyeoNLhKK6w
Message-ID: <CAFEp6-1Mza3_1BQOORT9KsYF1ExOnMeDY9rb2gSvQmzeMn2vAQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: wcn36xx: Fix potential use-after-free in TX ack
 timer teardown
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Song Li <songl@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa26488 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OIB5ShivEfEboS5j5kIA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: dj9OmZ0-0yxfPbt7jZPNAfuJAA7wQDIO
X-Proofpoint-ORIG-GUID: dj9OmZ0-0yxfPbt7jZPNAfuJAA7wQDIO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4OCBTYWx0ZWRfX+OfY7YOeb8Io
 tJnKE4SFLbVe4TS88Fn8WEuLZBVZNQvCVV42J9p4HzpoFZecKyoC68ewDNmMdAWuoLQMNzK4tTW
 V+1DX7SHgkw6aNFxxVq1zaMU3MsVeyA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4OCBTYWx0ZWRfX25ShWdCe/P1v
 1drwMvCBbhcAQ9CTfA3HMbGmZq7DDR0CFgQ3x2Z5PLufYxtEpCeodFaTfCwSykLVowsMFlfniGX
 6K9sbVcb6LhsVw95ji8sz2594BYgsmMNraaNI/1vOR0HVQYi7cIkMXedCDF5xn7sAT4XsdwD8+o
 xHcu/MIa6O0IesibC9v1VRhQYrzU2OZaqGiTaO4J8ywmkGTyEITersZVHhW3rWf2bt72uA4zNbZ
 dIpGncKGwSvwSMVnuhDbS8aJ0O3P0QFExFZtpMkn6XpoQuc5tdbAWKpii7+3qIbyI9yW62YSRsL
 uET/2lVsEcVoDhdK8T7IoaDB0/6JGcVzb9qUULyVL8Zkv/QQd8S8kYzay2HIx/53xsp8b1SIAcu
 XqRV+/FRvxE/26bmD4i/KXz8atYxXPInVFEeIAGIrXSpiR/gVDyCtNkYuymEkQsPYAPeiCxnRx9
 BEqeyM8gCYzhhfXZLHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100088

On Thu, Sep 10, 2026 at 4:10=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> wcn36xx_dxe_deinit() tears down the TX ack timer with timer_delete(),
> which only dequeues the timer and does not wait for a callback that is
> already executing; the preceding free_irq() calls synchronize the
> interrupt handlers only. The callback, wcn36xx_dxe_tx_timer(), can
> therefore be running past the teardown and use the wcn freed along
> with the ieee80211_hw in wcn36xx_remove(): it takes wcn->dxe_lock,
> reads wcn->tx_ack_skb and passes wcn->hw to
> ieee80211_tx_status_irqsafe().
>
> Fix this by using timer_shutdown_sync(), which waits for a running
> callback and also prevents the timer from being rearmed again. The
> timer is set up again by wcn36xx_dxe_init() on the next start, so the
> start/stop cycle is unaffected.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: fdf21cc37149 ("wcn36xx: Add TX ack support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wireless/ath/wcn36xx/dxe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireles=
s/ath/wcn36xx/dxe.c
> index 44020ec26..801f1218e 100644
> --- a/drivers/net/wireless/ath/wcn36xx/dxe.c
> +++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
> @@ -1055,7 +1055,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
>
>         free_irq(wcn->tx_irq, wcn);
>         free_irq(wcn->rx_irq, wcn);
> -       timer_delete(&wcn->tx_ack_timer);
> +       timer_shutdown_sync(&wcn->tx_ack_timer);
>
>         if (wcn->tx_ack_skb) {
>                 ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);
>
