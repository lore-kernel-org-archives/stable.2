Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0551DDEA
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066626; cv=none; b=I3In1wT3/05To/iqRCe/EO3MyX3XTlWwg/yZ3cEGs97xwkT3BapabX+PmMpXZnPTBDPWtBcMrQhbjFTnP/71wIANKqoB3Nubx06zuAl68qWS7HxoLDNCht6iSXMZCZZcamidl0usCf/Zuyz5jfrx0InlcYOa7SxyY3LVrhOvyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066626; c=relaxed/simple;
	bh=RoSelfqR+JFVG/SXKTvafXJAkj900s5jRJkiQxTyBi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kn9FrzMo+Rf98w5hfb3kyf+3k0xXtbskKVJXz6/9XshfiMM1llrOm4Qk2tLlrc3gFLxpcTG1ExP1oLBDjtrAKY8lGkKHnI4UChmhcuqXtrZZylH3eIOM3oeV4IjJORXc7KTKffwTs/eHXiqx/fXT1nQI1qfxF/OQhCOtTQE2AMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M461zxc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vk1YLeFg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M461zxc+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vk1YLeFg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jZ6j2966421
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qeW+7v3cARPoD69ymwyoS4BW4yUp98r1IGfhAo6sxJU=; b=M461zxc+qhaAcn2/
	qklCd5eNp6kJ0EFD36l77Z1Jx6dCSpVVEI8/GLxzB0TxK12HJxxI/Lgi3qiPuzK/
	VmGQoKKqAtcGhDQ4dz03+gSjZxGWNmMSC+n/S785IhPvtuaGQk6YtCCf0zdBZ0EJ
	iqQBZfS7GB1DgXi3UfRIbrqasoSEz2cVBCKQ0bU3580ie1kKHrkSNHWS71Nw4OsG
	rkcLBm/Chln+rD1lrrUHKiM1IiD64bfuIzhPO1qdoAMpakSIZa6K1MtizlN+ezBs
	/DaMhjqRG4IZlEOqFbfutxCLnvMOWDrnmqkCsGdkRgpdSl9yPtySXvd8gwh02Efu
	UbQhvg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wuy0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:17:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e942b1cc86so17105735ad.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792066618; x=1792671418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qeW+7v3cARPoD69ymwyoS4BW4yUp98r1IGfhAo6sxJU=;
        b=Vk1YLeFgDoqDbvsryx5NLjPLZEhALJ1tUZ7IkGP6d+/zq5TzXmKYOfdlZoMtCPk1zA
         +/Tzj5jYNrBL2jyLdih3YVy8mHrrDdFyhmhtWYXoT9C9kIF6qRfh90dc9OaBtxiGwKVB
         FIPO46v15IdlN9AMi9LXkBDVo/XnajaLQ9VK7r/m+dAyhEprT8vqGTFxm2fozQIayA3d
         P7rdzcmDK793S4NDG2fc/+iqnx1CbfZI1vlKW+lXYrdCMDavG/FiHBE0qAp9Jyw01iTp
         GmomHBK5IPogFDUrk+PD04X5Ze9o81Aymql22WCvDalxLqvInD1hlS7o1e+WrAGAflfD
         ZILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066618; x=1792671418;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qeW+7v3cARPoD69ymwyoS4BW4yUp98r1IGfhAo6sxJU=;
        b=z0MOIv6DG/4tm8SGSh0MMvxnhHFMpzm3ZrqQVgO36hwC8QoUEXJTF2YzxStVEvBXTg
         MWSiTGpSQByBdVS9/dbARwFR4T5IoyJNbY2MqhvZGE6EUQdf3vpw/0FeAurIxXxkxV62
         3Inwk9FIAJ0m0vA/rF6gUbSlLO99xxrxWI2emt6tOXQc2LF8Oxzlw6/Ait1P1hIlBMUN
         Pa0FflVh/9OEbP+PdKch+VDeqZuNTIFX+vmCn4SspTMsC0RVK0K39cVANaXpahn3i+V2
         NY3NzufEjEipgeVKZvxibj+jyQJmNvUdlQuV61DnqQFTJwjE2Iyf0miP3guf+vPDKMdU
         OOFA==
X-Forwarded-Encrypted: i=1; AKwUvBycPCdgIgXi/A7SaOIn80gsWvD6DPMrBTPQt0huwXhpW6PvYqb7gY4/9DbNnm+aABBBQ14q3fo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzv0aOlAu4EdazkjoXIAh61GXzyfjpwJdAiwkaQOkU3WtxiPeP
	e/t9uwAqFwrNwSj3U87Eu0NXQ2BYlNKqlRzolkDyUD9JGsKE1A9KyQCmYiizxfnSV/MDCfZalpo
	IBVlQpCaiAfogCqKXgiTARoiPQvvLYtvG8amwiGuJ2qQwUEUseRb+DaV7XFI=
X-Gm-Gg: AYBFou178sts4WHyYRrAjxYMwOC374Uwjh1CUDKpcwJndzS703yTqcwP4QHpNRjfklb
	4ou/vSd3LJnb5YVi2wyC7W2xGY082BOqNnX8ViqpHUPGTFWRBXEmresYn+0Yj9R1PTJxNtIOIJ1
	t4l8y8Z3gGX9nT6uPx9lf7ClLF6brPj69qNOo2nh10joiTiCVliq4RDcXj4WpxvMrS2nYcoE01h
	IDgPt87Ku1vFkpimea2SksYD6TA/Bzh+x3k0vzSkaZhrv50eVEStotOJl//I7VZUbnQqPs+SbL9
	B8s59s2wgASvu7yzovthF340R/nfXA/IfigubnyK2tzc3Co3kYkCCfSAJfduXmx1QKPriMG2Ghj
	x3+LHhk0vPs19Xgf8vBOnpRLJlpRWrQ0w
X-Received: by 2002:a17:902:ce07:b0:2e7:12d5:cc3a with SMTP id d9443c01a7336-2e8429ad199mr147196335ad.36.1792066617735;
        Thu, 15 Oct 2026 05:16:57 -0700 (PDT)
X-Received: by 2002:a17:902:ce07:b0:2e7:12d5:cc3a with SMTP id d9443c01a7336-2e8429ad199mr147195935ad.36.1792066616942;
        Thu, 15 Oct 2026 05:16:56 -0700 (PDT)
Received: from [10.218.10.175] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e94ba30f6asm15395685ad.57.2026.10.15.05.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:16:56 -0700 (PDT)
Message-ID: <52bc42c2-f60b-4249-976d-83d360933ede@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 17:46:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
To: Birk Skyum <birk.skyum@pm.me>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
References: <179173732257.29426.7905170638383807320@pm.me>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <179173732257.29426.7905170638383807320@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfXxrDszisd1Ipi
 wLeq8Sqg/LkS+t22eAY+FXiqjqVn3LFQnC2I9tS5Pk7IBlooaA0Y4OaG+wRv0zy0tfAGEoERnDV
 ha9DjLw1JOsMXdX9DHRGATXcoYDz9g4=
X-Proofpoint-ORIG-GUID: TDwW-ASpcsgvCqo4mIy8d3jfpZOitNz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfXz5SqFmy0n2ab
 qYHiywhcPbiyKkIEZIxusZRs9UwaKW7Ce+Ez88qgq8vT7ZoMIECY8sBX4Tws6xlLEi/SW/QB+Pi
 gs4B3pcGWYvKwsDg1EupQMCQjzjLvH4PLnNF77h8ANQPUDW4upliClJ26LCVQJXgMTAc5jIsIZw
 vfSVvkxABrRJyc6nUKSflbQNBQ7JM/7vtuXxZhp0XxcB1d7cn71v8wJQWEFVpNXLQrOjrqwcdrs
 4NjZb9RSIkIT1Ues4ueaEE3FqOluquF8FGwcrUsOXDVNHTbfVadHsiVx942kqhVa3297f2W8kay
 Ec1SptYrjODtsK9UYPqtUevMtxqfb+twQrcrAxAsTMZabjhAgCRogqPKaiPFT83auo+Op78S9+i
 XXfhX6zG5QuOkPLGlE8K8gHP1BKKActuS/zuJ9oddVcPy425XCE0JNwIbTuZGC/L3PF3Eum5lYk
 FLKV64U75zB/qGNJRdg==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0c43f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=5YmnReTpXDDOs48wh34A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: TDwW-ASpcsgvCqo4mIy8d3jfpZOitNz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150048



On 10/11/2026 10:18 PM, Birk Skyum wrote:
> Hi Viken,
> 
> This change takes away the built-in keyboard and touchpad of the Lenovo
> Yoga Slim 7x (x1e80100). It reached stable as 139efdb3ee6e in 7.2.9,
> and with it the laptop has no keyboard, also at the disk passphrase
> prompt.
> 
> With the change the first transfer on the keyboard's bus fails.
> 
>   geni_i2c b80000.i2c: Bus arbitration lost, clock line undriveable
>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -11
>   i2c_hid_of 1-002c: failed to fetch HID descriptor: -110
> 
> The touchscreen on a80000.i2c keeps working. Both buses are set to
> 400 kHz in the device tree.
> 
> To narrow it down I took a 7.2.8 kernel that works on this laptop and
> replaced only i2c-qcom-geni.ko, built from the same tree. It is a
> distribution build of 7.2.8 whose patches touch neither this driver nor
> qcom-geni-se.
> 
>   7.2.8 driver                                keyboard works
>   7.2.9 driver (its five qcom-geni commits)   keyboard and touchpad dead
>   7.2.9 driver with 139efdb3ee6e reverted     keyboard works
> 
> One thing I can see from the outside. The driver does not set the rate
> of the SE clock. Without the change clk_summary shows the clocks of the
> I2C controllers at 19.2 MHz, so the 19.2 MHz table is used and
> SE_GENI_CLK_SEL is 0. With the change the same clocks read 32 MHz.
> 
>                                       without     with
>   gcc_qupv3_wrap0_s0_clk (b80000)    19200000    32000000
>   gcc_qupv3_wrap1_s0_clk (a80000)    19200000    32000000
> 
> So as far as I can tell these buses now run from the 32 MHz source with
> the 32 MHz table. I have not found why that fails on b80000 and not on
> a80000.
> 
> I have not tested mainline, which carries the change as cb97bf3d4f91.
> The same backport is in 6.18.y (5815329988ac) and 6.12.y
> (f5d0302416aa), which I have not tested either. I can test patches on
> this laptop.
> 
> #regzbot introduced: cb97bf3d4f91
> 
> Thanks,
> Birk
> 

Hi Birk,
 
Thank you for narrowing this down.
 
Could you please test whether increasing the I2C pad drive strength
resolves the failure with the new driver still applied?
 
On the Yoga Slim 7x, the affected b80000.i2c bus uses GPIO0 (SDA) and
GPIO1 (SCL), via the qup_i2c0_data_clk pinctrl state in hamoa.dtsi. It
currently specifies:
 
drive-strength = <2>;
 
Please change this to:
 
drive-strength = <6>;
 
and test with cb97bf3d4f91 present, including a cold boot if possible.
 
We have previously seen the same “Bus arbitration lost, clock line
undriveable” failure on another GENI I²C bus. Increasing the pad drive
strength from 2 mA to 6 mA resolved it there. This test would help
determine whether the 32 MHz clock selection exposes marginal I2C pad
drive strength on this board.
 
Thanks,
Viken
