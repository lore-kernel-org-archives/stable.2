Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793630174;
	b=er48QD/dzKcFln3H81oSj4pq4J8PUZNTv4mqUK3qI15ljt1bxPViNwf19GgDC9TlHgTE
	 bhrnTH5BTsxuqlDVk6toHnXoAv850u7dnhqJGJeW3XPVgiH3aa06hEm64Jy39pEJqm3HX
	 /qq3PBzKaO3aLDSHF+vc1eXElWEW5duUoi1A/28A3xU6hPPQFSusAYAzWY+rgCybCvvpQ
	 vu5/nK5kxaw79kUJibZURe+pfGMjKFjJHyqzt0ma03E3+DfpgT6cgxsA+K+YG3BiEIxmj
	 6Qx31/r5PCtxvpQ/Dj4U65kA8SDovbWApu5f0rRicJtL/JeTREbiZaOYhNQvtRAsI2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630174;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=;
	b=pWbzBXUjqcHtiwm0VAvUHEPIlFxmOe7HY8gcnjjGTbKcuHJhX2R3lEBxY8Uda9BUrgtD
	 BWmecDAFjvlvBWagvozN7QCCdPm3qkDvilcnXmwmUkkP6vGz5694ALfpMwTjODvOQ9J+/
	 AS4KydD6Q/MZy6D0k4q8BxGBbVfY60m3Mkix0cIcyEkhEEPdfauvXDVHTqNBp7ttm2aHW
	 Gw0h188wO0NfWiDi7q2WQgiRtmrQ7wBu0YGTbGuODAb/dkKwNWY3YBlJvYmddxf+DST+a
	 ilgfbl9aOoNGuRH3AtRdsfRwMVKE0V1uFhF9pEwl0xFbcgNkKXwsDUugPtILEb1bfLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CBINMe3c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aj9Ad3pJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319F60771D7
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8319F60771D7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CBINMe3c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aj9Ad3pJ
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp9B64033827
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 14:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=; b=CB
	INMe3c8uOlrNhX43LITRHcaOovKgxvtVbS7dRMICt5u23ota/C8ZxYfEkwYxDnYI
	2TgQ57dHXJC551g3ztgC4ef8fg3rd8+XToZTnEo6c/qkpB5TZZ9H2ads0AxsDOWY
	C5Ye0MkR5C0zLWq++rCBZtHtiVaHFjzFHzYtT2bFufGCmKA6r51vpdrti1fcZku/
	BT6WZYrTQhXLPF91UWkr4nUhozHyev9oLnwfzZhfwK92cbjaax/hWw2Ymd1kYObY
	+L9SnK46FX8ReHr10BpRlPukwh31cT8M9k122winWjUhaOo2E4QvO47ORblhlsr6
	5zMVEL9VF/2ZrM9KseGg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe9jng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:36:12 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-8210034ccc0so3841859a34.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:36:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793630172; cv=none;
        d=google.com; s=arc-20260327;
        b=f6YymLiNxi3YURnWH2g/2G+mwgA3PZw4dVxk21StRA3aKQy3d3mIOsNrVE2ddT6K8V
         jfFT/9N7vdTp0MPOEU8Scx7xN5nHVfyrjoTf80isZ7+BATKJPIgbRm1k67Z5jYL8mjGr
         Z6cqXzRqpQID5dQGbIEjGy/JrPULsxZO8qW0gyTFPtuRo/X+FqBviNGh/wc6nmfs5G/d
         1ETHVqKxK2vplnEmJVRR6y05R59Wwu4D/kUyzVLJdZcmQ0NYfsinpgdAXcGhn+L/6mbx
         sWNJ36g/kSAOrH8Tv5JtFAIPoGn+u11JIcz8lJjr3IeWDFlET2XOzXv1jbAA5Bz9lEjo
         rWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=;
        fh=yaJup3vxCb9uD96ntDJJZbqyooEElrlBbayF4BMOcnY=;
        b=jdLnKB0w+c5MlE/uB4CUDOlWunqmxtKR2DTgq1cCYPdaa6QechNjVdfEZxZ/Ykc0Mj
         Yt56xEmu1NoLMCC3JnKqZuUZfRjIw7pFQF391TBXd8KsmlWtyTSyaqH9El0rQCOKHkWO
         WXzac73M+qsr6+H0i2FEXJWmwxCgDRzoxyEPmed1aLDzwYbFvC4GnJi//3soOfmCaMQ2
         QOha7T4nT52NqbpsjT33kin373dGN1SyXf37GnlXy8Wr2VzjTmUl9ZilRQcfvqZhrtAt
         +v+eHO+TunKmKJxG8CNNhRzxrlDMQZKtq31G4roKTzrsWnyt7Tj4W4u7j4k/aSEMjsjj
         w82g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793630172; x=1794234972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=;
        b=aj9Ad3pJXzLi2HdQ7kYTw+tnZ9KJKn2uOvDUYLPUJ6wiqMwaM/kTUU8NJN/U3H+6gd
         Aq/MbUO5teVuzJur2PXIfPfeCK7K5uOyGpGM5Z/RS1fY08NKdk9+pviYdVyLC5XDV0F6
         XXtemBzegQiClIEDoVbqWuwVRGcGq4n3v3IigrL4RX/X4/DJxVDy28AlvveSwWP5yQi8
         59DwnNIsVEc5GdmXLfzrp3eBZ5LqjQTr3wp4U5LOyfro40T88tW3AbQ/dTXjwT2UFkHN
         ttR3JlbX0dlc3zr63oHLDsBuj2X4MrIb5QghoTOMa2xfkjfuRfg/ZHEsUsSe65ZPpn0A
         tJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630172; x=1794234972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dfJM6ExctLDjBcZ2yvJdTGWYguXRDvt1VCNcyGbkmA=;
        b=eq9nGjWlPV8eiAGM0svdkYzaeExZTQZgunPXvHVp9g1YHvrekeT0yeMsqKJ7HS3MS2
         +VeL5ABgC7TnTkr/uMMxf5kk9F/FFkvJ3hNKZ3kAcUz2TDEhWuqttc/JIh3NTMDGMqZF
         5HQlSpRceYsH7gVpxPUJvZhFwoCMW8BLjfN2pUG5tDSll0M/iy/CAO5B8QC9oY7C6RCl
         4M7m2suPEtlVKvYTXzwxtG6y52bfi4jqLsbn4JPA67H9shBHENGlGy9km6t/+UlBTjp7
         GM8IeiwiUChRW0oOlQSI0owFhtOAPEr8BpvJWsEks6JOM6yZ8R1QWuvUmAH3abvj30Oi
         Rd+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxukEzAQCurGmdJEWA7EmaDPs+gWiwS7DS5/xHnOuqIqxwhIj65SPYW65WSmufVAOB3M3iozh0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLjERWrykLa2RCzPQiAUx7J2I6TvZSLdXbl4aRLmplGPUUmIRU
	z2gLEz3lNcRnAWTonRpBqRn8HkGHp2btDnA1YI/s3efuBjNY28K0VT2PglmhsDXoSL8fMqGXkad
	7KEem+56xRb8v/5lJruuOncy0z/m0KiyJOT3YNx+mJSbi80Yw4pZwdayqkAcjl03Dzwwlvj6eNr
	tEv3pHZ5Wbx6o6fNRlKNghx5AbUYIoLtWSBCzLDzqGesc4
X-Gm-Gg: AYBFou0LQPZQKbxHkZ4MZGKofyOG+/q+stkwh6YnWIv9GjPFd3qtWUJ788bs5k7LdA/
	xgvzEMCeJwUwxC+04u5AXyisEKZLZVSWW09NHShLC4T1ncpRbyp8XeQhfIXzz8SLVaRqrriIBTv
	JNwHLrn4FwiGx6JkiCTqDhhubCaJrnaxbRWLvHGkG16V5qpwd5dWioPZExUQ==
X-Received: by 2002:a05:6871:2b26:b0:4a6:f484:e880 with SMTP id 586e51a60fabf-4a906c77708mr6209100fac.0.1793630171629;
        Mon, 02 Nov 2026 06:36:11 -0800 (PST)
X-Received: by 2002:a05:6871:2b26:b0:4a6:f484:e880 with SMTP id
 586e51a60fabf-4a906c77708mr6209058fac.0.1793630171045; Mon, 02 Nov 2026
 06:36:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com> <20261101180508.66598-2-nicoangelodelacruz@gmail.com>
In-Reply-To: <20261101180508.66598-2-nicoangelodelacruz@gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 06:35:59 -0800
X-Gm-Features: AclHuK9gfrDGQ5PLQCt-XA9GyuDskdynBG1Pwp73OvlDTnKYRXDLZaDVIm7EHOk
Message-ID: <CACSVV03TBrktnuhphsTPxJPKrvtiAtngYGx4yGo7hL-Q6TCybQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm: serialize devcoredump reads of the crash state
To: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae89fdc cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=gB-Dnt9bVocfTiBQhWAA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX4GTMPau3FkL8
 l2PGJYfwQyaR5G56fE8lo39xeHJ7NAyzkAS7v8hL9ip7CynVlctFEpgmmiq6r8ZG1TUOHg4oJvP
 VOY++5sc3ZY4BVzHYtWSRXx69N25ajF06ydFMPpQDOD5/jJOtRPg/yxslCqX1j1jeB8fIB+cGCx
 OK/wF+HSX5ElH7K1t7pYJPaCT4cn57G0DDXNvVI1eod7FoP0ZXajImLHHokgp5tEaqYuu5RUDwJ
 mOiGdB0/0OjP+w6XoF24hKUuCLdtRlkCPgx5m+BGN7kHOMZlVUNroWTb1kwTS9sJa5V6Flu+S3y
 G91D0DCjwg+YnVLr8hZo1/XZfmAE2wKXEklXfRvgdtfnSok0qe36O99c0T2FfIQ/IVUvWLLTWlP
 hYWl2MDQJ/KT9Z+MTQyMSuUJSXIw5PIvTETVaQ5xEjyjZWsniQTkk0dfTweW+v3AhrzJPEig6tT
 sTUK6F2Z5EgoLwGmxGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX2GbcQNfgwbpk
 e1OyaOuOE+8kRXK9r10njI5PXRWQFajtTC8WGqlb32hWfXt0RBhWa2L7cuQ6I1uoQuUypmfZ0EH
 PPBkfA4UClsFVSquayfx/PdZgW1Y0Xo=
X-Proofpoint-ORIG-GUID: 1kqBPDFTKgG4ORGoMZEj3pAgKv0YWZQy
X-Proofpoint-GUID: 1kqBPDFTKgG4ORGoMZEj3pAgKv0YWZQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020058

On Sun, Nov 1, 2026 at 10:05=E2=80=AFAM Nico Angelo Dela Cruz
<nicoangelodelacruz@gmail.com> wrote:
>
> adreno_show_object() converts each captured buffer to ascii85 the
> first time the crash state is shown, in place: it checks *encoded,
> replaces *ptr with the encoded copy and kvfree()s the raw buffer.
> msm_gpu_devcoredump_read() only takes gpu->lock around the reference
> get, and every read() of the devcoredump renders the whole state
> again, so two processes reading the same devcoredump at once can both
> see *encoded =3D=3D false and both free the same buffer, or print a
> buffer the other one just freed:
>
>   WARNING: mm/slub.c:6733 at free_large_kmalloc+0xb0/0xf8
>    kvfree+0x44/0x60
>    adreno_show_object+0x190/0x240
>    adreno_show+0x1d0/0x438
>    a6xx_show+0x68/0xbd0
>    msm_gpu_devcoredump_read+0x144/0x1f8
>    devcd_data_read+0x34/0x48
>   page dumped because: Not a kmalloc allocation
>
> The dump also changes length between reads, so a reader can get a
> short copy that ends at a page boundary.
>
> Seen on an Adreno 830 with IGT's msm_recovery reading the devcoredump
> while a udev helper copied it out: 16 such warnings in one boot, none
> with this patch.

Probably also something that igt should cover..

> Add a mutex to struct msm_gpu and hold it while the state is
> rendered. Only one crash state exists at a time, so a per-GPU lock is
> enough. gpu->lock isn't used because a devcoredump reader would then
> hold up recovery and fault capture for as long as it takes to render
> the dump. The new lock is taken after msm_gpu_crashstate_get() and
> dropped before msm_gpu_crashstate_put(), so it never nests with
> gpu->lock, and it is taken interruptibly so a reader waiting behind
> a slow render can be killed.

You could have a 2nd state snapshot live with the debugfs path, fwiw.
Note that I'm working on some IFPC fixes in that area[1], originally
part of the a8xx state snapshot support.

BR,
-R

[1] https://patchwork.freedesktop.org/series/177370/

> Fixes: 1df4289d5b23 ("drm/msm: Optimize adreno_show_object()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 10 ++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h |  8 ++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index fded78fdb..428dc9666 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -191,11 +191,18 @@ static ssize_t msm_gpu_devcoredump_read(char *buffe=
r, loff_t offset,
>         struct drm_print_iterator iter;
>         struct drm_printer p;
>         struct msm_gpu_state *state;
> +       int ret;
>
>         state =3D msm_gpu_crashstate_get(gpu);
>         if (!state)
>                 return 0;
>
> +       ret =3D mutex_lock_interruptible(&gpu->crashstate_show_lock);
> +       if (ret) {
> +               msm_gpu_crashstate_put(gpu);
> +               return ret;
> +       }
> +
>         iter.data =3D buffer;
>         iter.offset =3D 0;
>         iter.start =3D offset;
> @@ -214,6 +221,8 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer,=
 loff_t offset,
>
>         gpu->funcs->show(gpu, state, &p);
>
> +       mutex_unlock(&gpu->crashstate_show_lock);
> +
>         msm_gpu_crashstate_put(gpu);
>
>         return count - iter.remain;
> @@ -914,6 +923,7 @@ int msm_gpu_init(struct drm_device *drm, struct platf=
orm_device *pdev,
>         gpu->funcs =3D funcs;
>         gpu->name =3D name;
>         INIT_WORK(&gpu->crashstate_free_work, msm_gpu_crashstate_free_wor=
ker);
> +       mutex_init(&gpu->crashstate_show_lock);
>
>         gpu->worker =3D kthread_run_worker(0, "gpu-worker");
>         if (IS_ERR(gpu->worker)) {
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index db9e11e7f..9b683973b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -264,6 +264,14 @@ struct msm_gpu {
>          */
>         struct work_struct crashstate_free_work;
>
> +       /**
> +        * @crashstate_show_lock: serializes rendering of @crashstate for=
 the
> +        * devcoredump.  The show functions convert captured buffers to a=
scii85
> +        * in place on first use (see adreno_show_object()), so concurren=
t
> +        * readers of the same dump must not render it at the same time.
> +        */
> +       struct mutex crashstate_show_lock;
> +
>         /**
>          * @recovery_in_progress: true while recover_worker() holds @lock=
, so
>          * that fault capture and GMU waits don't wait on a fault devcore=
dump
> --
> 2.53.0
>
