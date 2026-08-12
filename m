Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC030F924
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542666; cv=pass; b=DgXh09M3SEnO0zXmby8XHxGHg8Pg1f3++TqClYqLICBTGQvPEsn0z/E3eq2fUXexwvgf0rBoIkJvl2A2HQt6N7qsUKVr4Tb+adqoR6lQkAzEo+VeHkUyjdexFGE55XkgM8Ir/9xE+vyBfkgaGrTOTMagtYQojrgqZyhnsSdJsp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542666; c=relaxed/simple;
	bh=hOWhDc6Fqp7yVb+hb/ELo5AQ6mHpP50RQtdPn6I3HFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFkVZWcVR/+qz8N9RRtcNwWDItUVvg/DSeBx5S5sN+xPwbI0pe7yzNxBpBmK7B7xtWCHAq7zMoAABmKF4+RXvTlD5g+lW5EgX4hNKGg6FDfG0Xv1WArZfFJznm8e2rxX3wGTMTaDh5Rij8YTGPvz+S0n0zMrgCYaSUz+YuNON54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VmvzAV/z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zoyn60cu; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmvzAV/z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zoyn60cu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDboBc3971671
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=; b=VmvzAV/zdNb39Nu4
	ACKmZ7WgdeZxyr7zKWUr39PM7rY1CHc778fkmaJFbleyaQW/549Kurtkky+8i2oi
	irHpy9zLbPRjp4xGAo0O3BeJPaDzxpqRFVfCpJglrLUKHTDgRPMCZdtm0qKwu8P0
	DgKxdIMy6gWlUPt8IQ/JwRMJDWYtNDmR6Pggjd9Wp0XFPDzF5cshLolsoJSdoQCb
	QmLs2nzpMXrnRHJfvC7pey6WGHSgb8KSmfpY4PEr7HdAcb1o1wN8w5f+RY4NsuF3
	P85nCVXlYUjbx4sw4b6I84chDfkFkSuJhioqfX9DjUV/PCTfH4MKaylc5JffV+GX
	+VLxBQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrhwxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:51:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9080b7b2f2bso9604256d6.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 06:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786542662; cv=none;
        d=google.com; s=arc-20260327;
        b=OX+Q9sBywWNkxTOVwNT1RZhm9TCEzz8ZDuX27p0MldO+T0/m+bXSs9XBsAirh6yXzR
         TRXxwrl8sTw1GqYPCepRvroJdisjo/IqWGfB2O3wQde2nIqtrkFqlXBsnEOfFdSUs5ki
         9LZnRdt8CmhDGDBeMd8ZseDbsTyal3er36M47E2ZZWNATnv91/Cyjur9F32AogNdrJfe
         vHAUSV3l66cJJ1uYfgpyxBzVBmhirU6rck+8RlCInLAfg8gYQmID0M5WVBC5VfbP/mSc
         //2ZHvIv1ePV9831+H0Q0N7aU4ZOzHhHD3BEDN4jUZ4aavErpoWQuJ2ZXWpCUwljUAZ/
         kQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=;
        fh=qFeAQbHvBSeCOKStnoFtqC0SCLgECx1EDNb9nC0bW2g=;
        b=Y7u5VSoW6S/T5dXhkzcFSlZZTfpQjeub0Ylx2R40cpZb74DP+ZtEpurdg/49RSpX0+
         BvclcGoBdNnqIMTjSoDrMufcAuPlkJ2HJw+5dwPhiYjAqGxLIzDTYv/iCGbacbq0YBBz
         H0AsC1dBa8NgEB0SvHbos3J/+V3SZJP2M/H6h2+7m9703zYL8PT5W45NffCWXVutTxRq
         F5SQNieAnoJhucw3awLKZw7FM7NMLFdB6I7nTqcVCeZguvtMLS33B9nywR5YHMmh5tpN
         bkWAhkicZuXPg65szRRy7UhwLhtWvUulQQlhMBdFvKyju+ZpLc4GbwAiY8/sMj1I9dIf
         +s7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786542662; x=1787147462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=;
        b=Zoyn60cuxd3Y+S2glqlcx0ebPmiTYKyY30X3gXeBM2KjGoZ/Et3dzYIKQLuRvrw5Hl
         MfxxApDEf64FmWE0hNFWm/oL6bb9CtJkkezmqW7SB885TsblXKfgqTUyAGZVWkJgP8vV
         r9mfEXF8rkKQ4r8iI7D7IJXHEv1tN9ZUxlBcet4u3fnV1kDlIqca2gNBniLAOSnljwSW
         hCT1HH+5PClnw1b/jgEUVP2lx6F8dLTzMVJNdq7Lxipk84VLu3KeTuhSuzeYeD0FmBqX
         Bxo1l3hi/bPBt9fT/UyGC85t5PB7NaNyut6/scxrVQtxh1kSbZtnpewaY1cHBIciX1Cv
         hdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542662; x=1787147462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=;
        b=NFwXVpkFIaUP/44MFlOofNd4DkaCxNNe3Y15Iunow13vb7Fzbt5AEgqFmlsi1ueV0r
         yyL7Ad58UbQkgdoVNe7e5zDDAL93ufZ5RtBEuL/mTjEFSysxhFDBvwDOT7QbRu6kZPMc
         4yyIygjSOP3PW3d/yIXEdoPQu0xv/7mppMNdJEPcWHUQaFYIokAGhxGcLt/xl0j7StEG
         r5RkhXp8HFiKTd6LYZWfO16lgmBIG+LMtZVKqR+bU0tLBkFqpvRCxG1cBG9wK/LDXF7D
         4YH0cPKA+jd1daZxByOJN2cBIIgbsjYcDJumpTp9zLyBYUg57ueDWsWfDm9ojnEtvN5M
         tqdA==
X-Forwarded-Encrypted: i=1; AHgh+RpHzc8a2QwSnlvNR9n8rXyS4/iT9bPudc7C1a3yK1zcy5uHV5+91QDEqpzXF6fY+uKsVry6evk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZNtcMc3jaC+Yvgw8i77p9jk9wCvLszwnLXVYvzRcN6Y9RCAo
	0Ot5uG31ywv2WnxeugX5sXWT05WgK+xlT4vBauAfpduLkRjg2FZnu18YJlzziMBKnp06dl9sKG3
	uS2RZOh7ooWhtMV5srGY8NzuejcIyOvU0yey/kI4H3B4WK+X5gB0JObQqtID9hx9vQnYJpkFZUg
	RK8aCj6KN6Bv85o2IrHuKrUQ8ATCFjEbQnmQ==
X-Gm-Gg: AR+sD11axo2hZ1VnzZkmi/tR5cNCtqSxOEq6nA2KSF5ZBIRTp/kFtsIHCCJGTx4ixwN
	+Yg0Mku1kjn4+Mr0FckAUoG020c0HqRIqkCmw0bWun8dkY4pM6Qvqg/pqlAP9jJtQMZepR7kXtf
	baR7DVsX+jsyg9HGHg2lUNCqEDd9IFWLuc/+t5rc8l0urcAfVFfY/p8/GtCTsADpLpRWtY2IF1B
	miu8ho1nyBBfeSf40FjyyfLHUdGLIpPdvb01RzRrZpGypvJ/48uGK8cOBxNjblB9GIlrQzBxusK
X-Received: by 2002:a05:620a:648b:b0:923:8612:f15 with SMTP id af79cd13be357-936b3ad916cmr450086285a.18.1786542662270;
        Wed, 12 Aug 2026 06:51:02 -0700 (PDT)
X-Received: by 2002:a05:620a:648b:b0:923:8612:f15 with SMTP id
 af79cd13be357-936b3ad916cmr450082885a.18.1786542661921; Wed, 12 Aug 2026
 06:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812094425.3515179-1-lgs201920130244@gmail.com>
In-Reply-To: <20260812094425.3515179-1-lgs201920130244@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:50:50 +0200
X-Gm-Features: AUfX_mx6BU4whCh4J6zK1bhvqjl7XdzdnNX_zuruD8pdUd_6rsfBiSjTp64h08o
Message-ID: <CAFEp6-177whXgFj1uViqg1Gv=68GkqzG_gYqEbV1kX-9UXkSHw@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Wolfram Sang <wsa@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMiBTYWx0ZWRfX0DszLA8/noGk
 xwU+CXpfdpvQ4t6GCSXxRX9jcszd2t+bBMN3yNWvYrqD+tUBQOx5398o1PlmTBt4JxS+wYD3/FU
 actavTdE8G78P2w/2EjiMDqDbK4ZlYP4sEBYePHtG8t99HwHkRiOG2Xreu62i+i0/xbj3Zg2sHp
 YyekceyVN1QMkRXBFj8pprm9b2fIP36/296BfokLefcJKKCjZBIRXj7AhW0ptUDWWQB+3wvqdyA
 1VWWWFC91izNGS7JFtYOEe/BLFwVgoDM2sjwEKqJPAhZMOSMARlZXxLKcuGqj6ekZjO/5wgt2LL
 ruhu/O7ScN5Tc3Bhkh89+dW9Tvo/8mIY9rOzkgJL9i5eGhm9U+1J5KrGFerSS5sWGqkk+8hYDRd
 P6RUyrA0E88d78Uhx1Akc7mxgPLc9IE31H6lzATJzbd9gPx+6mptM/6s+nY/gMUMvZ0u+H5xfe5
 rABbzbHAuSbE9ZP8MRw==
X-Proofpoint-ORIG-GUID: 3A5rIz6bNqFDLzJOMLFSILkbqC_hqd_2
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c7a46 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XDTyClmYPJ3ucqjADi8A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 3A5rIz6bNqFDLzJOMLFSILkbqC_hqd_2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMiBTYWx0ZWRfXzlpWXW8/eIPK
 mxtaG/VK8RvxKKvjb3FmVEaA90II7GFnvTSMjk0DKkknwqaHB4lfkAVNPAybIrEb3I8pTjBJ5Ui
 afNFNk4mKzFfyENVFY4/goRFMLzhilk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120112

On Wed, Aug 12, 2026 at 11:46=E2=80=AFAM Guangshuo Li <lgs201920130244@gmai=
l.com> wrote:
>
> cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
> does not call the matching pm_runtime_dont_use_autosuspend() before
> disabling runtime PM.
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without undoing the autosuspend setting during
> teardown, this reference is not dropped and usage_count remains
> unbalanced.
>
> Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
> state. Its managed cleanup disables autosuspend and runtime PM and
> restores the suspended state on probe failure and driver removal.
> Remove the now redundant manual runtime PM cleanup.
>
> This issue was found by manual code inspection.
>
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index bdeda3979c48..25b6e4e9e3fa 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -595,9 +595,11 @@ static int cci_probe(struct platform_device *pdev)
>                 goto disable_clocks;
>
>         pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> +       ret =3D devm_pm_runtime_set_active_enabled(dev);
> +       if (ret)
> +               goto disable_clocks;
> +
>         pm_runtime_use_autosuspend(dev);
> -       pm_runtime_set_active(dev);
> -       pm_runtime_enable(dev);
>
>         for (i =3D 0; i < cci->data->num_masters; i++) {
>                 if (!cci->master[i].cci)
> @@ -613,8 +615,6 @@ static int cci_probe(struct platform_device *pdev)
>         return 0;
>
>  error_i2c:
> -       pm_runtime_disable(dev);
> -       pm_runtime_dont_use_autosuspend(dev);
>
>         for (--i ; i >=3D 0; i--) {
>                 if (cci->master[i].cci) {
> @@ -640,9 +640,6 @@ static void cci_remove(struct platform_device *pdev)
>                         cci_halt(cci, i);
>                 }
>         }
> -
> -       pm_runtime_disable(&pdev->dev);
> -       pm_runtime_set_suspended(&pdev->dev);
>  }
>
>  static const struct cci_data cci_v1_data =3D {
> --
> 2.43.0
>
