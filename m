Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A03DCDBF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981059; cv=none; b=f68qBp5RraWbFhN1vK5EFfS5eT+EinDj11cayZikkl7EyukTVBtA6n+/+zzFwmpCX4X80Z04uTttSyDefa8VLP1TzLspz+MOeWFJccWTKSrIAk+/bPQzLQnWMl2qx3tAKoDzLUHxiP9FfzhXfNmn8tQo0Q8FCLzligDOCKBMHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981059; c=relaxed/simple;
	bh=RJIg6DVyFl/JbgK4vyZA949yfWm7M6w93iBPf750RVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHaIbhse6thU3UHjT15VyVkFEMRjhKyuephQdC8RQV/d9x7oxJHBu2kFpzP9AVFpt/e5ACn+b0AOB6MOxUn6Gg/sxG3lF5uxO/+JLnV+YtegIFqRKs5knxSxGN7nNplzFODbVrM4ET2Wh9y/ToblVqboPaQB7zNcF5O3VIMy/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j8l4uNRM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LuByu4iD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j8l4uNRM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LuByu4iD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ECJVO72088418
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AWpozBC6RRpfvAz58EjgzoWVeN1iKmTtutWA3C0DjGU=; b=j8l4uNRMxMWBSJB9
	u0k86TnyMIuKD1gEV7Lj06vFiyQbzxbRF9IAA/vRUmv7VhcL2Hc0G8UrXvN3qg2O
	KJOXoyL4GOEyhX23sUwrtGbZ/Tta5mXwelAPFk3zPndSSofcAp9ipTfs/pVzyNoe
	lRNAQKKdBYK6MymPFmFsvt/WZZc2i0NQE5nl5O1oQZqlQeyM6ydqTvjElhL4MDIt
	gSiPtEBYktFbShC1ONTkOgo7DMtJyBBMBY+NXOdiKxlKbeH5O5f753Bcc//4KAo1
	SmB3ocTvfJOc6WHXkke8Zmy1yhc1s7NbzxvTIj2hV7+43ucEckp5afE4qdYOaRU4
	0ydDdQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49jtk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:30:57 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e705718bebso124354e0c.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791981055; x=1792585855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWpozBC6RRpfvAz58EjgzoWVeN1iKmTtutWA3C0DjGU=;
        b=LuByu4iDn4I4OHnGWDBd6uyQlCP9Ud+oqg69tNDrk+doS+Hh3l3KfqccdnQDKpHDws
         UXdE3p+CdydBxgMusaRzV2kn1O6zY5lqCecgsaQvYSvFJeTb1QaXGOv8EO5idwxilI8t
         jUQS2ypuaA7oVy42GEBx9S+bj+5Rvr9Hs38omquOda5s7rPopTqNsZ1JAgBmub60rSgr
         SpvJy3jYhkdGaX2IHAzKb/aNAcKnajeZyfgeLopVTMg/Ksfo/9e6Z/OVxl5b8Csr3401
         JpfR5ECOp/DzsF5fRP5E+qNnvDWmC68wWgfYckmDz28hTxTb/Fb98Hajc5lQ1CxA/Nv0
         kqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981055; x=1792585855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AWpozBC6RRpfvAz58EjgzoWVeN1iKmTtutWA3C0DjGU=;
        b=AcMxKOnON/4QBzgqRXEoidRJ7RDeLz7DHJtIRjaVrnGIkjMWmjGCjXYzbehcAjNN8F
         UEvitEAAFnwINQVGpbKXqQxuai9qK55BHOaC61m4WiKj0y8SlY+mJDgCEHprwp0pva6e
         CLssMeJ0bgPZ5JmzbDPGQRPd5bGR1JsIL2WuE8YDhQ707BuTdeYUs+LOoCtiyYiHBDYN
         Cal8Pukj+XUnJLATsTgJUQvxxkqMOZ0g4D7pOjV5KdQymE2CxMReot4XbD2OAFJB2JS8
         JYO7YWKOCODKAGE7nehgljBhYNXQbogWHBfCf3zQJIRyWMv6Z0Ok74/jkmXXktUDYV19
         qGRQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0hScsVUY8rOoad5aMcUi3Op+nUcBYQoaK33OMIdVknRN3IiZWkTZuTi0l8zUnujxT7NZSAFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsOE3bOiCU+OrCRjx2qfx3uQQUMDmVfHeX88QaJDDHXwGlJLRd
	PPt1CU8o0eVre9dEF1Aqxz9GrE+oahuH9CJ1mtL30wZ2Y2CWmkgTmBmdIPoDeIBExV8m1NtOXAG
	yNG6WOYeyCtlDXXtu8aiBWu+XRlTBhQkk2Qy2jdrK4PZvcT1JBbzNKZhzYrQ=
X-Gm-Gg: AYBFou0IaINL/yMNFOnOgv/O6+Wi9OVMAFto4ELRcim+O3KqrkVq9euOLyRGppcfHEc
	/5IENjsRxIbz4pykwIwVT1DS8aV5YJNwxEU/i3+YaRBGGiSX9WwbadVdUjIvuAD9H6LUjVbJRFD
	+ChsRCGFYMnOQEg70A9Vvde562q3hZczoxXGnxCMKj/QISWj8+NS6j/YxQoTo/7gN4fH+b9EJgQ
	lBa+0/0rN7veY73bp+iHLklR3oGWVhqcws3UVuRtsqh0UlPKeRS0FW8CtZH9oakqjGDgf0nHAiO
	uw29ZI+/e5RODmaGJW+8e2KA18iTgJZtfvQRd6rQRwagJxwUijQriKKd7z84npXTdAo7GP2pmdR
	9lWv89jikr545/qnGCc+6Wg==
X-Received: by 2002:a05:6122:464f:20b0:5c9:91ba:5d7a with SMTP id 71dfb90a1353d-5e91f232dbbmr3342799e0c.1.1791981055401;
        Wed, 14 Oct 2026 05:30:55 -0700 (PDT)
X-Received: by 2002:a05:6122:464f:20b0:5c9:91ba:5d7a with SMTP id 71dfb90a1353d-5e91f232dbbmr3342717e0c.1.1791981053779;
        Wed, 14 Oct 2026 05:30:53 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a9fffbsm691074966b.49.2026.10.14.05.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 05:30:52 -0700 (PDT)
Message-ID: <ae03e7a3-75f1-42df-b0e6-0e64358be647@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:30:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Birk Skyum <birk.skyum@pm.me>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260929041444.9837-1-daniel@quora.org>
 <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
 <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
 <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
 <20261009145800.rc-reply-0004@kernel.org>
 <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
 <4acb0eee-f7ae-4817-9848-d72cf486bc06@oss.qualcomm.com>
 <e8f862fe-f86c-4522-9ef9-70fd754529af@leemhuis.info>
 <179197985641.52689.14222546983549320957@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179197985641.52689.14222546983549320957@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf7601 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ISgNb0KN0Rerl7bivZwA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX3yRQ9EaEuIiB
 iBtgjErghSc1Fr1zMT32QcfBNY9sKt7wtz/93k2Al8ClzwcmDwwbTbEzDbPvjgn70BLiDy86D0Z
 4Vn8MGU5Q6I8PV9yXQZi8ZTdtZ9Fp1vxH1PovTpI0FlJ6z72mLCven/RnrJnK6yPR7J5UJZTApt
 HWUOeSc89jrQt7Pmqe4hGfj0X5krFDttLwFcPBEufu1xxNppLuXx/RrucPMOQxLgR38Y3xI/3J2
 R0AsUou8S0d+Eb2tNoEG5X9PHcrh/O45MTC3pdBLcBvVlBw/erVWwmeJvSCTQ4yRpAsh/rrhiFK
 Ug3BMMeIFFFmdjxTalaTJwBpilt8A24JQV3dHPJAwjPNXP/ogptco+o9iY8X9KJrmNQzS3WuWVy
 dZTh78+tSejKRaOcLneKPsKGgagGHqjfF1/Q3WR1+xE1dyz7AQ8Y+oiZgvA1KpgQcAJ7t0nH23U
 5cBE8TO6V9Xd8qfoHCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX8ezxz27nLXt/
 sXU/DoXgZaQACo7W64NDPpa5VjgCHteZNu4m1dikEYN7gHrvaJCr9yXsDDkpdAd957WYBfQ2hfA
 Ah01rNR3LfbfZv0jRsGCsQXLhhw3urg=
X-Proofpoint-GUID: oRKT4QA7jYO2V8PVrlPT5y_z4TEU3wn1
X-Proofpoint-ORIG-GUID: oRKT4QA7jYO2V8PVrlPT5y_z4TEU3wn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140049

On 10/14/26 2:11 PM, Birk Skyum wrote:
> On 10/14/26 07:08, Thorsten Leemhuis wrote:
>> That's how it is sometimes, but then it's likely best to go back to the
>> know old state by reverting the culprit -- or is that a bad idea for
>> some reason?
> 
> Hi Thorsten,
> 
> One correction first. My report was from 7.2.9, and I had not booted
> mainline when I sent it. I have now, on the Yoga Slim 7x with v7.3-rc7
> (a distribution config, no patches), and the keyboard and touchpad are
> dead at the disk passphrase prompt.
> 
>   geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -5
> 
> Same kernel with only i2c-qcom-geni.ko swapped, one boot each.
> 
>   v7.3-rc7                          keyboard dead
>   v7.3-rc7, cb97bf3d4f91 reverted   keyboard works
>   v7.3-rc7 with Daniel's patch      keyboard works
> 
> The touchpad binds whenever the keyboard does. The I2C serial engine
> clocks read 32 MHz on plain rc7 and with Daniel's patch, and 19.2 MHz
> with the revert. In all three boots the touchscreen and the three PS8830
> retimers on the other four buses work, and only b80000 fails.

Since the discussion still hasn't settled, please go ahead with a
last-minute revert for 7.3 so that we don't get an utterly broken
release.

Konrad
