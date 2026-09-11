Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69547F3BB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141246; cv=pass; b=ZpTWYhg0J6skoxSXJ6uKhY3WobR9HaP4rtet4DHh9vArrtUPBOrUVGcH8q4KKLjoYHA2ycvt8IpELhIS55wnfsTEjwizGgSQHql4YGgmRQ+Nmo/rafmQm7ERAk/vlpaM7pcbxqSNNVzW3uDgTDz2wmEDQhlAPHuAi3RXkV0Ewxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141246; c=relaxed/simple;
	bh=vgyKC5wP5vZQX2PheX+c9+cU97I65EruQX6t6jcv46o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYh8u8zuvOGUuWCbGXhhnmYkEpRV4nV2Qr/AfG2I+10lsC68QoUvN73qKLOI4t6JMqSfU0HMSndRRx0DA3jajHUCfYtm23a3JXiNKpu81zwBdj8yIiXVNRJfi2uUDBvXREZKoQJ5CbzT/VuBbpLrD04oGexEft8SFkI0rxbGlC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IB1oiVth; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dCvu0A6Q; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IB1oiVth";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCvu0A6Q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BFA7g5658303
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=; b=IB1oiVthkc017Lr3
	F10TgPdkwyu9HwHfYLXWwlIM0RrPBOwAGhU9jYJ2fn0O8qlgQCeyqKzqtpFU8ok2
	ntwaN0rOSpLIbOywNILDKxqbzfeOl8hc+pQo96+i+8TobMIi7P60u/wM41oY1JIz
	7E1ewMOQB05eyPCLEVf72fMmiYq6PWk3FpI4Ri2OHqMiSbWK49ADqiwRL98PyWiR
	15rHeugTn3bw0tpq+muCMl4usWNgbCA83IqqvOPbZ5K0Q8PXOpyXM/wBGC9m6qJ2
	Vv18YGc5T3lKmmmsJW+wuVnc0efVRqiDA8nErV41ZVhqVBbHEvyMzXY9IPzgKvfM
	mS++rQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm22r4cn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:40:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc44d708055so1612923a12.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141242; cv=none;
        d=google.com; s=arc-20260327;
        b=fXP4VgnF3AfziQusyyvJwZPqIX3DhY5krpbNNTyMVHaIhPZYSUR3JMSAJAQRy5oJq5
         kNksk0A9PMhXpBrbz2kVsXBYhtoZR2Ef3goQ2OBze7JIR62189joVYT8GVWSJSgCT2Ye
         k3d7RmX6ifB/vyK+TVk5MY/bBNyHTfwJLTNuvgFxAYPL4WwszQ6MwVV7A7PUECL0Cskd
         uNFa69xm26FBF4dC25L8IH+Gbh8AC0loKWP1ABfkkwgOydmbJKyh0w/FXNdrx97R28Fs
         IbmnZLvteeP+Mp47Y022ooaT9Upo5A2l6j5vBv+vYxywTRPz4knkZagmtHldeQe/DiZc
         JwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=;
        fh=0D4UVr/nXMI9pMXHc1Eq5c8dnj4jMUhs4UCLtqmeTvA=;
        b=bH7vx9nTdPkHQFg7EO3ZwDR7H4Oo/UYckwTXuoxLD/vdAu67MXuB7+QviK6KQMuNBv
         Bb6vDCUcwTHjTkZ9VVNi1WhuxuBWP+J7dOi8CpiQeDJUmpa4mL9WHiVV5KNGcrN4O/pb
         CzYnG/6Lo7xZyKCKHl9WQefqJe436zV7librvLgkCN6IT9F12tTLnQCJTwJ7BW/AYzEO
         py9o1Pa4G1q2Prv9FA9kzbl+UVroWhEod3hK7RRJ2WNOHY8ewbvHs1cXNpP8k4atnEJb
         l2HhTW//BgiuEuN3wNd3H3F8j9JMS7m/Dv9LAeaxX3riMkRfZsUyJVQr37fgHiXtDoOT
         DYOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141242; x=1789746042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=;
        b=dCvu0A6QmVJywxjnT+45ZxK4yycGg0/qP1N/VBGCqE5SPQATirAqj88os/89lAQu+N
         T9BPFB+vApynr0ZHsSfAkXc4n10GoOpKSChYTRPPP77MfSGaQegsqln6qSr8a6mHAB5V
         9xAvXXOieJPpYjFf2cVCvrzu7nr1+bBm8Exqhc3w3do1fr2tLgXK0nXU1AlnCLMB2YlY
         OFvXIMFmAbV1HxqbHzKQ+xp128aohzYaKJ0fR+4FcQLrKyPkV7rElh4r0xiM9aOcEIyP
         V55dyrKUA2xJYtKBMbMK3WEmz42rd5RC922k+PSTZmwGBmQHuehDb/Pra5QJBFagCdnI
         xfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141242; x=1789746042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cg1WYUrNGGFtVONVnKPa1Xj6heNwOWL+7lG2ZgsnoxQ=;
        b=XQ78gF29XZpBTcMdeZ+iweB4ad45ocv3RtNTTN3Cr1jK39cRQjd7/kZzujKZe4E54G
         D9HCobkROWr7p0XcRCY2Vh4QoHijmll6QP7QRuCZIV279JJJLPr0Uad+IBmFBHNNiEM3
         w4BbPlGWQV3B1ZeG1+7knEGoJRVrqrQAnoLPb27SStMpKIBYYWpHa32FJrYCgRklKuxg
         ERpMO9EHspPUk04ITIfSA6IviEdxdbCMai+8Sp/Iht+slBFj6Wg4yWrWB8G0I6hjeM10
         qligFyD8rip9oKDiEPfeBj/grR41QhPhe67oPsH8q64CEVmAY0VL+Uyf5Vlj5hqIGE7O
         nk+w==
X-Forwarded-Encrypted: i=1; AKwUvBwfu2muhtqSk230yXPzkxfFdZMtMTZzDw5g3YE0KtEcSE81xzXHHyXKb0+3+EXLH2mfEAIJQ/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++m6dOXi24HUN04Kfz7SkfPQPKYdGfB3jhjbWJ0EBl0E/rxlKgUi
	wibPzk+H4Myug4FeiLyWCAlhPJ9h1iYdo9tVrvjN49GsEuEXQFYozmxbRC/anAOKo+MuT5vRBAm
	edO5rpSpH9J+1jP8W9yoBWSRObvCo0/2IAgGNkP2EImfiDOF7NfrHwhyJNtdtHvOBe7UKVBF/yG
	6QiNcHuL351l91pxz4JNqMOQ7kJgpS/jOxAQ==
X-Gm-Gg: AYBFou0frS6oE2raOvu+aUkg4/acd6t+Rzsjek+L5QY1Ox6z14dM55e2nfAPpwKnhOP
	u+6GrJssHOt2TX8Va4+H52e7YDFm86Jaj07iVIHygW5v747U/la1l+9kbYIk8BAGUFwK5QhcCAr
	CngkK35+RvQKKvooT/GI+JXlSp+PJeVgAR1syt9CVYRR7JqUz5qYEjgYj7YQ==
X-Received: by 2002:a05:6a21:6f88:b0:3cc:3d08:da39 with SMTP id adf61e73a8af0-3daed20b6e1mr9948478637.0.1789141242505;
        Fri, 11 Sep 2026 08:40:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f88:b0:3cc:3d08:da39 with SMTP id
 adf61e73a8af0-3daed20b6e1mr9948399637.0.1789141242111; Fri, 11 Sep 2026
 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902140926.3576781-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260902140926.3576781-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:40:30 +0200
X-Gm-Features: AcwNN1UTv7W64Xm4jZLjYkdUFI8rRmcEfot7t-_MQS7eHd04yw0TvNJhM_aZyck
Message-ID: <CAPx+jO9y6t7vqWqpVZpt37N_71b3rL1m-=RF2RDgtB4vkvS4Dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: initialize IRQ-thread mutex before
 requesting interrupt
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX1FgV9j17VLM8
 i0xNI1l6KX8AxXZKhblg6IqudeaBlcJR4fgj+b+nik40TUeGJGHiIUxZWPyhtAOXPEx4g6o2ali
 gcEogigjeA6BEE30HK5b6+TsMaNC5HzeZgqQ/3gtkBf+BMRIgCq0e2eu4bphRYug3/Qbceo6oTE
 Zppr0gDynQStGkrQyAZDy+WPqwuNvbSQrm0kLajMyhW8O4U1/pZR2+6KarOBuyx0EXo4F1YB7+Q
 0HTLYqGXku7lghMWFgB07ui/o3H1zRgUUUua9DUUNfoavMsvZjnC7/oirKc3qtn3VUZ39d3Vy4u
 MEpA8//C3j2tCCW9K0jJ1rtx1RG3pEgedxNujeynPMn3fqPFtO064G88QgoayeDJLY9wnwVPWGI
 D9zChFNv9Mf033OWUQJC197beKGkj76W6HUbTF29NO4YjjxJaBEeVsVEIlc5Yz6nGAdIhbjpXXF
 PBaP/uO65FebSJ06z/w==
X-Authority-Analysis: v=2.4 cv=LPDz05W9 c=1 sm=1 tr=0 ts=6aa420fb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=E6_GXre4Z2_RQDsjcpAA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: m5llOe0kTE7TlXx-aG3rsbugXziMReCk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX66as9sIPfz0m
 RIESWEIbUVU8ySr6LiuOHpA8kjEczHZE+5xPYQEJDaHLe46gKEeZEbIyTiIq+1j2+PgLIv/k4Q1
 azwgO+p6k0sUZHSSECFF8UdXrJQLDbI=
X-Proofpoint-GUID: m5llOe0kTE7TlXx-aG3rsbugXziMReCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218

On Wed, Sep 2, 2026 at 4:09=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> w=
rote:
>
> The threaded IRQ handler can run before devm_request_threaded_irq()
> returns, but thread_lock was initialized afterwards. Initialize it before
> requesting either interrupt.
>
> Fixes: 8047310ee984 ("mmc: sh_mmcif: fix a race, causing an Oops on SMP")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sh_mmcif.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7706d01b1..8bd9cdeda 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1461,6 +1461,7 @@ static int sh_mmcif_probe(struct platform_device *p=
dev)
>         host->pd =3D pdev;
>
>         spin_lock_init(&host->lock);
> +       mutex_init(&host->thread_lock);
>
>         mmc->ops =3D &sh_mmcif_ops;
>         sh_mmcif_init_ocr(host);
> @@ -1515,8 +1516,6 @@ static int sh_mmcif_probe(struct platform_device *p=
dev)
>                         goto err_clk;
>         }
>
> -       mutex_init(&host->thread_lock);
> -
>         ret =3D mmc_add_host(mmc);
>         if (ret < 0)
>                 goto err_clk;
> --
> 2.34.1
>
