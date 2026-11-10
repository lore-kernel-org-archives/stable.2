Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284086;
	b=3dqdgAHGVE7mE7K6jwihJVcykknUubme3Zzs8s9oG1ZWDXYDr6N3fjL84PeHNLFl1irf
	 FwpFSgVTdAuP1HXzkkpnAVpoDSr5cPnYaWikyBpCnuI4pMrV3XicX8dbhYZQk293gLYC+
	 Cmn5rFTIrQL82pfNHDQpFu2usIubuC8UtgeFyZDZoVjL/tzA5+TF5bEuwmUUlMjHAheIy
	 2haILLue8PccQ/+tFDiv9+13j55ZQHxcfpfQXGMreFIdvutfAYKjET6IboZ14uTF26SfK
	 xjQgNW8BYN7kp6Sn4OTIaI3WhHh05rYyBp8WGahJS+HjdAbMkPdrIYEi9dZDWTDkmgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=U3qlC+dXK+CpAmoGXqDZjbSPLC+XRHEjZb4i4RRbB8w=;
	b=J24QRX81cgP07UQ3YwJWoPsKDls1WQA3gPPQm35GmKWU3wCoSe5dQyFSBKlmUe3KC8kX
	 OIYD++Cjm5/oh+hCdrJg4ZesPcs6YZIekJhLrh9xhVJ6GrXqeO2z2WPda2n8UdrKbnTCP
	 ZwllkE8LD/VF0AmYxUMCx40PCpyRlsV/0aSF2bfE2M7pHx5QRpN7DeGhvFt5kNOgMbujh
	 bNt3SxrbVG5U27G8AyY7aGd+NZSARUHYpMnvduC5p9b+IFB3zTJLrQEBuiqtMtb50rY2s
	 qpOeAzMxh7kPfXSRLRDClVY7zJkqMoxX6dObZSzvRalxECOSniaSMxHT8u1MKRUt59A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwD0zJSj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chivNziG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCB606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECCB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwD0zJSj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chivNziG
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA49uvU2294736
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3qlC+dXK+CpAmoGXqDZjbSPLC+XRHEjZb4i4RRbB8w=; b=AwD0zJSjZ2kNkWJN
	ccpRP8CVoDMEniLAHBxGHAmBLezgXrJ5C8Q5JRnrHagwgwnFSXcCv5U8J3RgpC0B
	bX5g0KkkqqSyJRTvxU20DRDK+KDb54uvDkbNkJ1+vvunYK7LQiNrWXpUBZ9MiCw4
	ZHfada8u6hl1SQUvF1AxcbmKEORYo/yJYKYKR9B684WSYI5oc4xWz2Iw76SJ0Pw5
	bANkRf/bNp0N4uNNrhIbGuEveq2ElJKcF7TQzoa0EMzaO7EddzQMASOSzRiYvI64
	PP/Ef0TjHeP6drxR8kZcGM0kOc5GTLXjqWcdQ45k7ds8cLGBNX2IExW1TAL1GqcH
	dJ7qQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5uhe2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:14:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed283cb5b9so9048715ad.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794284085; x=1794888885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3qlC+dXK+CpAmoGXqDZjbSPLC+XRHEjZb4i4RRbB8w=;
        b=chivNziGbxn6PquaCRLyWZbOAlBCLG2v0xT0uaMfjHTUwqr5woaxxyFshK1i6Q3hVq
         6vxo1lOqt475B9ytHwkBReRiPYbwZMjw01zVcw5VUMSuOcCzeUIUxwX4lNj+TZLKmY4S
         pTQIzhbI+9Vvt52rPpWpodqZgNn4RT0Q/fduKL2gGb4nR/BSeYtd5j041hiX3m1proTC
         uwIW89zvlH2bFaDA6I34b1mtp/N44G58S5EvDuefxaahNTjYeqCi9YtwsC1Rx6CIX+Rh
         42gngj1oM3p5HLNTkTQUc3ITYrXhegl3p7gK3RqBKSoA4on/gmxHmixV6MEH0OwHa7U9
         6yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284085; x=1794888885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3qlC+dXK+CpAmoGXqDZjbSPLC+XRHEjZb4i4RRbB8w=;
        b=Mm5q7ufw0T3xMlAeUv7GImdJU4IP6ic/fA3B2dql6id1pndONPZ/g6jT0ce3l3InM+
         OZt3wQl4KcY75ZlITTT+DdDsveRM/F4ZX9GxM0qA1Rkh99xaKYZsXLdG6FSiw5GAjLxH
         1FMXNpEp6joGw0aVxuPSVMkT23d2kXkDNlUKmxNY96IAHUGwoJVkMzlnM3DL+e0bSkEX
         2MouUYceKUz4noH2D7GWy/JYDV/1way/wkxQLhTff/OWEDQRKhoHzhLjvRCDd3xgP4gb
         PXUPryyST57z1gPynOFg7DRMYqsGlTHedKyXc1laSzoDXZx9UvFUE0emoHw6SdzTT/1b
         QwIQ==
X-Forwarded-Encrypted: i=1; AL+hErEGpWiQ0F6UOsL99dwTvwYQtOv7xSxV8jy07gJKsJ6qGwFbXMkkbIcvTtxnxhaGScOhToLF+CY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZH/ti7mG0IQNn7ebhSloB/aMs/VgRF3bw6tp28kmtvgMwuZce
	SVHYUvSNMsAUaNdkvElM8XraWwAT8L1+/KsQz+X9kTkS9AgA8wlFuJay0NYIwuKPPiqiWi42chA
	Ijw1yj2F6lqSZo1sUmhnIe0+n3QseezhH3c5BjkCuJ8ZilU9ZJxuKRcemhik=
X-Gm-Gg: AYBFou0LujqzVD4sh609tg7iWs1Xmcq3DVDYl6h/6AxtpyMbsOcdjOw5Bmi9Fq0bp/R
	+FdCNiPSlFSKaUlNakXyYosw4fiSvW8qd/Grhnb1gw3xDlTJg/WFQbJzOXgTvnJkofrkAvDzaFh
	Ddz08Rs4oC7nWg7wWHGDdBN78BLAqGtks1vKu/bwRBHclNy3AWXcgMnnaSmOraLI1uZ7FhVWPgP
	1IXEOwCbGS/lWonZEnZbfGeOVa3Hpr8SDQ6HghecVIrx+YQpZoiVn/sZCZYQX7FqtpmymHL7OO1
	HX33engaiDm7yRL+xaPwvlIzphAmjs0kF/LjJFU6A2aFrFG/WT3nZjcv4FfZ6gSsiNGnvThmIr6
	gVbD8I7OtxHM2CHnYsFUkfRQZLcQHbd+BKBQdhWRPdVN9W8ZNV0DbPs3nXdxppDRIg6ymNSwsz7
	g0
X-Received: by 2002:a17:903:1850:b0:2ea:10e9:7db6 with SMTP id d9443c01a7336-2edb6e6d449mr12044985ad.3.1794284084676;
        Mon, 09 Nov 2026 20:14:44 -0800 (PST)
X-Received: by 2002:a17:903:1850:b0:2ea:10e9:7db6 with SMTP id d9443c01a7336-2edb6e6d449mr12044695ad.3.1794284084156;
        Mon, 09 Nov 2026 20:14:44 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4d838sm4208715ad.12.2026.11.09.20.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 20:14:43 -0800 (PST)
Message-ID: <7c80e1ac-e4ed-40cb-b562-cc2a27e6bc3f@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:14:37 +0800
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
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Robert Meijers <linux@robert.meijers.dev>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumag@kernel.org,
        marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
        robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
        stable@vger.kernel.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
 <vr7xot6mfkdjou3wy2ni33ctban7goaqsr3xuw73przuefaupp@6lexppuvjypx>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <vr7xot6mfkdjou3wy2ni33ctban7goaqsr3xuw73przuefaupp@6lexppuvjypx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX99nriKAHr44m
 hw2H9ZUFtJPsrG2192+c2bvf92bqpRZudfYD2Qf3IYjUBJv5zz3at8b3ESukYXzjqFZ3AxoBFwF
 So4vGIDTeJYJWgOcWc4/truCr41aRpw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfXwCZEQ5ctIQW9
 u94MgYMwo8IjCGZVfNm1fxWi5sHTkkRntCRyQR6goZ2w5a7DMLX5NQJE2bmFmEEcG5UPsPG+yJZ
 OLHJgpx/b0ZSVAHSR/ww3GgjK9VIEJeBy8SbJ4Tff27HuOV5vL3UhgpFhZsFQL1JDsA11cewry9
 Acl4a2scYvimYBbfI6Xiw/+4cF+p7gKo4U/lgzTr/EL4En7jS5sk5a6USj3GG54I8gHcMntuXs9
 UTzy+JTwXB0Ac6ioc6jVs4Itroh+OiwRtVH9hm9rRNDWPVuZ5/h5ZLFHpPCHooqEHxegjknUT3W
 kAcXJWJJF60c7nUu5FMvORCI1dpQCIFf3hJ5EF1gEHlZ5Zyc87D9AQIVMFCB0hRVF9rfzdll7rD
 3oADdCuaLhgUVqTzXrPq+LZrcP33AMAdSnxed8wBjlW6RM4SbUGsI4O77s7os6NFXHo1CY7Qhse
 WDyUa6F8MRAxKR091CA==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af29a35 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=m0oZJYypAzi8eX9yTqQA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: kML0-VFz8yYjI8vM8U20FFqxv0oxnoO_
X-Proofpoint-GUID: kML0-VFz8yYjI8vM8U20FFqxv0oxnoO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100016



On 11/9/2026 3:25 AM, Dmitry Baryshkov wrote:
> On Tue, Oct 27, 2026 at 10:04:54PM +0100, Robert Meijers wrote:
>> Hi,
>>
>> ((Sorry, re-sending because the first was rejected for not being plain
>> text))
>> (First up this is the first time I'm participating on a mailing list,
>> so sorry in advance if I'm doing something wrong).
>>
>>> Add support for Multi-stream transport for MSM chipsets that allow > a
>>> single instance of DP controller to send multiple streams. > >
>> This series has been validated on sa8775p ride platform using multiple > MST
>> dongles and also daisy chain method on both DP0 and DP1 upto 1080P. > > With
>> 4x4K monitors, due to lack of layer mixers that combination will > not >
>> work but this can be supported as well after some rework on the DPU > side.
>>>> In addition, SST was re-validated with all these changes to ensure >
>> there > were no regressions.
>> I have applied this patch series onto a near mainline 7.3 tree for the
>> Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
>> applied I don't have working audio, over USB-C to my (DisplayPort)
>> monitor, anymore. If I disable MST support on the monitor audio works
>> again. Debugging (using AI) reveals that the DP0 Jack is not reported as
>> connected anymore when connected to the monitor, with these patches
>> applied and MST enabled on the monitor. As shown, for example, by
>> amixer:
>>
>> $ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
>> numid=208,iface=CARD,name='DP0 Jack'
>> ; type=BOOLEAN,access=r-------,values=1
>> : values=off
>>
>> With MST on the monitor disabled this outputs "values=on". The same is
>> also reflected by "pactl list cards" and "pactl list sinks" where
>> HDMI/DisplayPort is reported as "not available" with MST enabled (and
>> "available" when disabling MST).
>>
>> (Again, suggested by AI) I also checked the ELD, which in both
>> cases (MST on and off on the monitor) is identical, including audio
>> information (like "speakers [0x1] FL/FR"). (Also, audio works both using
>> an AMD and an Intel based laptop, in which case I can also choose
>> whether to use "HDMI" or "HDMI 2" to switch audio output between two
>> monitors, in daisy chain).
>>
>> So my foremost question is: should audio be supported in case of MST,
>> after applying these patches? Or is this possibly out of scope?
> 
> I'd say, it was out of scope for now.
> 
>> For clarity I would also like to note that without these patches
>> applied audio over DP does work as well, irrespective of MST being
>> on or off on the monitor (obviously always running as SST because of
>> missing kernel support). Which would make me believe that no audio
>> support in the same setup might be considered a regression?
> 
> Technically you are right, it is a regression in your case.
> 
> Yongxing, how difficult would it be to support audio over the MST?
> 
I don't think it should be too difficult. It would mainly involve 
programming some audio-related registers for each MST stream. But I 
haven't actually tried it yet.
>>
>> Note that I do understand that me running a forked kernel on a
>> (by upstream) unsupported device might also lead to issues or require
>> changes for the fork. And that if audio does work with MST then this is
>> something the maintainers of the fork should, most likely, fix. But
>> from the cover letter and commit messages it is unclear to me whether
>> audio support should work and/or has been tested when MST is in use.
>>
>> Kind regards,
>> Robert
>>
> 

