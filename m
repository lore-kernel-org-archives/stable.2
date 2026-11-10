Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284092;
	b=s0SMSLw/DApN50jXchPny9Jih/q/ZDlgO1qWEQSsAPBgz5HmBfzP7HqTzsIoxZV8D4Qm
	 Su3DG/XIpzmdYgXJd3oTwG4O+5xH60BuQJSMUhQem+/0ISROjkpZ143oEXewpeO0gnmpk
	 sw2sULWCr667SRSEsX6mle1C3xQaybi0zCUteF1KpBa3bNck0uqHS4m9uM6t0gpLXt0zL
	 XzG8pl4JGk0BxJUWOMzUcBZSYpmobKinrTDrKtzwVC81sK/ohUNRx9+yL3+vA7H4s+WIr
	 t9WWz+iJqGJkGzgg7AQyHBrr8An3PbSrCjLDLSPAc85qgJ+gwMCN11oYkg4zyvb6rbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284092;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OQIhJ9P2aVCPhaAWlXFblplRpy5ISGBvZif7bpHO6/E=;
	b=k+c9UXPNpRPbLjpoCJPXLs4enu7FkzQ/P7uqK8KXabLZMmDQUWHQvRjuwZHGzUwrnjOX
	 7mKHv892SQnHPzwqI7WsUuONDh5a0vrqSIU6SUn4W2v1uuxxscTskf1CNvrDpKeMqwDB5
	 R2I700NWpFqx2LrXlCNAHtkm/NaZAnRaZxwyZdJ8MHlLXrj8zxxadDnO6xRdghB1HcToK
	 f1BMDrcbSHzmhu7a1RJ4B5XA5pFbJPX9MgpIp2iGg3BCXsgXXWVF6a/b9F59BHJul10kg
	 6Z9fJNHnWBa1l56vunGnfkqAaDrzsGchzhgAHIApr98EmTdKMD/b1hVWHK/pSfOrshQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF60muIA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jT99OhqM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA20606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA20606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF60muIA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jT99OhqM
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4A4xQ679599
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OQIhJ9P2aVCPhaAWlXFblplRpy5ISGBvZif7bpHO6/E=; b=bF60muIAYY2AUBiX
	Z054O+oM5cpZ10NEt7uTrlZVJ4KFHnWLK4vZmluDrOhBPLd50fNTLTkvR5EGB5p5
	TOtBoHR9j1WGJXXSSCF4FqgJ24lXnXbCqioSV8+Xiaa39mhfmdHB4dTR+HevInDU
	PjU8RW+X+AaqMS7Y9TxwDSQ7/bQ1xzBTTP/G0581aFHwJuE6hGnLcZBKip41eEMk
	0RHONkWvjJ9ys1RXtvS3t/6JufItHjJIhgp/MTATZAij9bmEpMG4bd1Yolb3LaOu
	+qO3P4yQ0TLMNcAnpEkRAE/qGe9bwPb8jKOpZwY6LMCle8qWCF5rZecg9gMZJ26H
	DOmpYg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv4899u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb91e288d7so1446243a12.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794284091; x=1794888891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQIhJ9P2aVCPhaAWlXFblplRpy5ISGBvZif7bpHO6/E=;
        b=jT99OhqMp3R35w0nNqOm7g4BmqiYtoIV5XaupU/NnU9eFxhpFRvRx3IC+kI/x0BIWi
         ZaheNInucx94qpxbl2rCFStYmlXRv7j7Fu9PxZmxUCBayKYXZygYZ0zzxzo5MtWB3db6
         4StnY8Xx6FFop5FGbJmo6RzAgx+up9pTJHCaQsa67t4m6w+9heTpklxLVj0LGdVAgTI4
         ml5FIdMw6L/hEZ6dtwFVV+Ql1jbjplyq+sdG0TNyD7Rvr4h/WGWa9jxrHzYBLe39xu7n
         pbb+wo9d7nY15Oz51avw3RHzjCW4FYClP5JAh4kvr35FFBEZBJZR2BX2hW05mM4y2APT
         HVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284091; x=1794888891;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQIhJ9P2aVCPhaAWlXFblplRpy5ISGBvZif7bpHO6/E=;
        b=SQ2PpBeVoUmxcxAr7qATLFqnwKBlWIvrpYYg0GZxvbkq7UoPxg9f+BKEqLflIKi7/i
         NJ6szKaCh+PKpd3vkHm7PYqpaVUihvhG1LlfJvJeY3VxZjgMCSEacwb/986aPSy7TMgc
         2czHmFJOVzmUdonC7NUTpvPjGW8A7ysu0t7ikwcBfJoDuN/3y/ia05VbY0Mr03Fo3KFk
         /8zsQk9S8bOVuODOG4FZRR5jVrTp38boMLT2tckbrL15rthj/QF3Yg1L7kh8kj7gP7/j
         dum50D0SsibgpWe/hbdJGID4VQlmPrXsstu4afdfGoG2X1AuWy/kC2BbPF4A7B7Y5QTW
         6tEQ==
X-Forwarded-Encrypted: i=1; AL+hErEDHPIEvFXGvc3sfwn+cbWICY0namzbvellQoQbdxtZWxbIPAR6ACqn2n12fRCrlBR1b5v5Y0A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aViji911BzJcHw3FFcw7diAbogEl/GzTbdzN33m7hW6hC+iD6
	gCd5ZjvYCVt/5l5J7kd9/4oFIgsffYRT+p44nAGl56Uxl5jr1f+C5tp5jaM7pHdGhTEaWOALE4g
	rW0l4Etd3aQmlaWuWYa6B5aAiI4rVryhna599eIZvBMcW3YsI05NPM5SuSjM=
X-Gm-Gg: AYBFou09ItYKBqab9fY5YjM3D1EtyvOLIVq5/TPV7vOGjdYsu95UXJFYHWgv7I1dVNd
	/t+9ke7igk/cU5EY38bYgxaowXLYuVvOfJrm1kg8NAsypvLy2To3HR/lNbzI2QvKvSkBV2JI4SZ
	f8wAWVtGG4Nx0LLaXMsWeyUVk3yIkpvVFh8AD05LX5N9rXBBNDBKxH//BCCdte30Dd00vmZ7fb1
	p7uUxs9gaMYoljQp/loNIpQY8OfVDCpDlaTWhdDYRBHhCp3s7HS9Y0kdARynUsDdbslSeTywTVO
	gJ9TGp0j1oo+RoqzA7dUCph60kBPR96xk3zhn22nnTJNclYBPlTNLFPh7NWF1M57xBPDxtH0hYI
	UolP2WuoPCFaNLDcrmt79E7medtW9BLNhM70bspnSzIwDGKKFwZKkiqns1WcBoAgUANUb4ad2dW
	sh
X-Received: by 2002:a17:902:cf12:b0:2ed:cab:e973 with SMTP id d9443c01a7336-2edb912b6a5mr12936535ad.13.1794284090800;
        Mon, 09 Nov 2026 20:14:50 -0800 (PST)
X-Received: by 2002:a17:902:cf12:b0:2ed:cab:e973 with SMTP id d9443c01a7336-2edb912b6a5mr12936305ad.13.1794284090286;
        Mon, 09 Nov 2026 20:14:50 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4d838sm4208715ad.12.2026.11.09.20.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 20:14:49 -0800 (PST)
Message-ID: <f54522fe-064f-455b-ba13-bf084576c647@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:14:45 +0800
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
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
To: Robert Meijers <linux@robert.meijers.dev>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
        dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lumag@kernel.org, marijn.suijten@somainline.org,
        quic_abhinavk@quicinc.com, robin.clark@oss.qualcomm.com,
        sean@poorly.run, simona@ffwll.ch, stable@vger.kernel.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX/XwR7PDxu274
 Cq0225y6ZKQuHGeAfdHXnjhDa7NTidDdPoIRnj1IOtGtr4NHLenW/0oQVr8FFQnTyet4gx3L6IR
 Irza/U9VsbZJxNKDwbxJ5+l4C/voOR8=
X-Proofpoint-ORIG-GUID: 1bYhkjx_vBx42KvhLPsehLCZ5F3cb4GI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX2FbfvRkvYSDO
 cjdPWPhAOOyO48d6esaJA1f/9VppqmaVpAoRZGKTqfNODRzSJsJ3UQPXiEwIBVn2hvPKYB6izXA
 UA1k+q6LodDC44SPz2IjPtNFMXvzrKU8Nt4sXUZw7R4JYGAmB4xy1lA+UlkwaUi+0C4+z5frDTx
 FmTSo7LgEtLwyHFflV5wvBxyo7o9qHJArBTD5BxnZdor1bBC6Vj0kOGdXvuWyPeKThpZOKacgwF
 ID9hieFbQjtaqU/iEx2AlzzYF5kdCN+2SlRhit8+qBCrQqEnrJ4ZAd8CqeuAxBxvlLFUQ4uJCFL
 olOEXiDarnN6floH2yJ5LHkn4i0SaD1mGNuEjIj/qzTr2XhhaVxve2ilfUT+SVfiO9yxEL5/opU
 pHUeCx2yGty3N8vnXLnJ3gxEn+chOqvMRU63FRsz2GNwDEDfimR3BYtFIhuvJEreLJkWc10mWBB
 UNa7+O73ICoGGn0qVkQ==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af29a3b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=dRm9NI7_ec0In7u_rNMA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 1bYhkjx_vBx42KvhLPsehLCZ5F3cb4GI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100016



On 10/28/2026 5:04 AM, Robert Meijers wrote:
> Hi,
> 
> ((Sorry, re-sending because the first was rejected for not being plain 
> text))
> (First up this is the first time I'm participating on a mailing list,
> so sorry in advance if I'm doing something wrong).
> 
>> Add support for Multi-stream transport for MSM chipsets that allow > a 
>> single instance of DP controller to send multiple streams. > > 
> This series has been validated on sa8775p ride platform using multiple > 
> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P. 
>  > > With 4x4K monitors, due to lack of layer mixers that combination 
> will > not > work but this can be supported as well after some rework on 
> the DPU > side. > > In addition, SST was re-validated with all these 
> changes to ensure > there > were no regressions.
> I have applied this patch series onto a near mainline 7.3 tree for the
> Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
> applied I don't have working audio, over USB-C to my (DisplayPort)
> monitor, anymore. If I disable MST support on the monitor audio works
> again. Debugging (using AI) reveals that the DP0 Jack is not reported as
> connected anymore when connected to the monitor, with these patches
> applied and MST enabled on the monitor. As shown, for example, by
> amixer:
> 
> $ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
> numid=208,iface=CARD,name='DP0 Jack'
> ; type=BOOLEAN,access=r-------,values=1
> : values=off
> 
> With MST on the monitor disabled this outputs "values=on". The same is
> also reflected by "pactl list cards" and "pactl list sinks" where
> HDMI/DisplayPort is reported as "not available" with MST enabled (and
> "available" when disabling MST).
> 
> (Again, suggested by AI) I also checked the ELD, which in both
> cases (MST on and off on the monitor) is identical, including audio
> information (like "speakers [0x1] FL/FR"). (Also, audio works both using
> an AMD and an Intel based laptop, in which case I can also choose
> whether to use "HDMI" or "HDMI 2" to switch audio output between two
> monitors, in daisy chain).
> 
> So my foremost question is: should audio be supported in case of MST,
> after applying these patches? Or is this possibly out of scope?
> 
  Not supported yet. Audio is only wired up on the SST bridge, and the 
MST connectors don't register an audio device at all. Once MST is active 
the SST bridge reports disconnected on purpose, so the jack never comes 
up. Nothing wrong with your tree.
> For clarity I would also like to note that without these patches
> applied audio over DP does work as well, irrespective of MST being
> on or off on the monitor (obviously always running as SST because of
> missing kernel support). Which would make me believe that no audio
> support in the same setup might be considered a regression?
> 
> Note that I do understand that me running a forked kernel on a
> (by upstream) unsupported device might also lead to issues or require
> changes for the fork. And that if audio does work with MST then this is
> something the maintainers of the fork should, most likely, fix. But
> from the cover letter and commit messages it is unclear to me whether
> audio support should work and/or has been tested when MST is in use.
> 
> Kind regards,
> Robert
> 

