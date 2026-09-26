Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92F34A794
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436240; cv=pass; b=XZci9Q9ShMH3TPe/SsRj9lc8fyu58y9C1I6x6jdDuUqiFOowiuXZcJ27r+qTdqhBuXCqbLi7hYHKNvrhxfpwrxqDH/C1P8xwYnGHX2053lLsIVFepFdQOlXUKCPCjilukMAQElxfM+pgY7XKNXx4jLPOMg4q+HrhoH+S3wRyu88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436240; c=relaxed/simple;
	bh=ecMAlZsbu2E/3TSAdvLiw+iTvs6e2RkSHx6GibJf5lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlG/jXUL8thAXgqN4tbYHraU1ck0oPHsseJ9vwQXlFuV5oB9aPH680TK0DFVJOCxwoUSEj5e0D/YIN9Md1qr+NoP+ITJYFFDGLTCcpCCltCUcT5rfP2KpstWRUd5Emw2TDyRj2pmXTz0BmM/apT6da6JVvmn/3JP88ZazzoAT2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ju/jyXMr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MVcofSoN; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ju/jyXMr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MVcofSoN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QDpQnT3931853
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=; b=ju
	/jyXMrgh6sOhp5pfzYpboLpZbwQkSeNZqeqFUWFTMAzlCejoUEMOb0agvTJVaKr8
	7xZSKhZS0iKaPsHuaJFnVH1MgOtt+T4a7GsAa8vi/qyARbtF9fqmjAfCecmWg1bx
	1H1r6SxQSyvYEFf7g+asXn7RTxhZ+TFUIHVNLnXtYY1vSM1cUWcI121E0ItEhMQd
	XtlSuVoRCGEL1qYxDZT5vUONEeK8uura4F1qnf/wvEVTpQE3TSmPxLi36ab3ZQzB
	p4YiXAZ9YMHzowRdBDhyOESQWuPImBQkVFqoYqr8amc9cTElcqgBBcuxLmjIhwHW
	geqzr7CAeMDLP/QsTX/g==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5cgh8k3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:23:57 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-46a5954cdfcso2102047fac.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 08:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790436236; cv=none;
        d=google.com; s=arc-20260327;
        b=A6zDXWGziHJRaNd64XJjNLTpwd+DQBol8xWpN47uqoqA3dPM1y2iGrNkj8cidgBTib
         q8tVS11psgbPD9tF+uCs/pYwXiuwneWusXGFsFVqa79cultU6Ml2SE6y48EbFuWQUakc
         lRjNYGDAWv8+65p33LzWXfjIS6+HiO82XUtu1AWRWhfC1FdIgUOQzQ9eB9wdejj7tNVS
         xxi4vPHCymrVh6upMniJjBo6PNVitXkPp9hIcgd3UL6Lp93bibFkJ/O3vAEvrk2HGian
         OfSaMW0HaOIHKast5f/NBgM1w7oYb1SzTX7s6c8zcHOeu0GfVqIQkF981xy1o/bc1pO/
         k5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=;
        fh=zWXzlLKf4rF2RxURKs7wxX8K2EWKzHATwls2zriUa1k=;
        b=eY3k5co5pDlz0Vc6FSKqWFc06SwS97IHX+1lRj5b3zQoACAxkF1hI3uWMJfQdKTm9Q
         V52KL97NxobsUueMteihvweZv9/GV/dqEuhoUXdA5zeAIivdHEezd2QRmUCWyA/IiyEp
         Dqxoyh/+hRYSlqFGa/QedaCQFlMbxF0HXLOLrXOWNZ4EnGWo4koz/8y2M84agq652ry4
         Of4Png7+VSvdbJvnmWRcGJQG3curXRf8tBXWq5WAYpnuXBKwiIm3XoNdcz+WeQ3whp+V
         l9QOEF8bBOAbWxRVlX5cAZmX4hDo8SuzEIZwRAujih5NsDgFAFOTdWCSSGWBthaIFwFZ
         dtCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790436236; x=1791041036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=;
        b=MVcofSoNZEb2AGzjkvdqlTN4Wm64GdB9AwPg5zWx1csxad5xv9V+AeSkzHcqz3oYcf
         Uc1TSjigckmxvPHB/n71tQCdnBvAIQD91VXjNxDLoNQMYdCMF1LZAJ4sic6WwIEB1r/2
         oO2N54f3yPkuzFhxNPL0h9IuTeLXoVow5CCJw7PXwExx5K444FGRExb9eh83tIYcz7e4
         SDpQ60f00FFSGkzHgkb3CqayyeWIEPjy+IsWlFfwIjAfKxpu+LkbqMpsOHh+iceChKBR
         5rLd2Su4Fk9UBDMz6a7mQdt2rpKm+WDlwgFKXno2RU819eD7tHZxtK/53iTfvGb2eRW/
         ccBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790436236; x=1791041036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kwRYD0lg3ABAu3cXBo8DfhKih+wg0SWi0GfEDlQ7sK0=;
        b=JdGn3viHsgoqVIGKRMY0j3GOLhai8ho4yaazo0IdhRZuFBTfKr+oruImkuXdcZxHB2
         Rd16pYzHJZMn6eYm3NlV2BPTfGl/0Y/5p9PYQqhydXefA9yUkzNgH3rnaGPJBUi7QE4v
         QMQ2zvbxi+a0Y/+V2XH6B9m0ZKh2T8vybVQj8UeXhsMajV0jQ34xSWTSE1ca5yCdlyNb
         0llasKyMqGlVIc5KlKPElCcBpKjSda7ScdLzfeyUKVEAabCM+GyZxtX8Xd1heZDooY0W
         5sqeomUJedPV5LczKmcr+QbckC3wDcQT34q/b+s57xyUHr+/G449wYi6YcxmSHouuh6t
         Fp8g==
X-Forwarded-Encrypted: i=1; AKwUvBzgJ4pXm3rBJ7hGfE3FWl6eutDZOoEbISZo8ewExRK1gjbi7/QrMndCByjoR7GCI1Dv8ywiDWM=@vger.kernel.org
X-Gm-Message-State: AFuF++kC25ERQBnhrmo9qx9KEVoGfmBpLDw4kJrHmvSLAX/FelhuVEx5
	dAfitBtqLlzfpVEQMIv1YmTmWzIBHNEFE56EEhgNOJfnUZZk3Dx9fmdsd55Obeq/KB48qTizDXQ
	X9wMiYpxsoxcX+7wkABb8duF2smWq2wIVRqAT7Yxw7R5N+WODVjhfcGweZUffl91AQVZ6D7BBSJ
	uHV3Apom1zheBsL4O0L1TQsXoHd46CpD9tRw==
X-Gm-Gg: AYBFou06CyvicORc71X3nyTYZXwfrSEFCPAMA7SeMrSISj5rCf1uSTlVt1pVNFWKo/S
	s504lLjk6/AeUhzc/w+icWjEqnY9n9WwzBICaWaK+sPZEo/FkWXeTERaYbWqsC2YyHaO2nKT0+V
	PwLf1ChIcOHwn8Ub+Gj7+TqCoTtU4bBtzDlyGW/2FKw7jtzpAvMYfFduqO
X-Received: by 2002:a05:6870:8125:b0:48f:e107:9094 with SMTP id 586e51a60fabf-491ec0cb354mr8222535fac.58.1790436236657;
        Sat, 26 Sep 2026 08:23:56 -0700 (PDT)
X-Received: by 2002:a05:6870:8125:b0:48f:e107:9094 with SMTP id
 586e51a60fabf-491ec0cb354mr8222516fac.58.1790436236156; Sat, 26 Sep 2026
 08:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916175738.2089950-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916175738.2089950-1-vulab@iscas.ac.cn>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 08:23:43 -0700
X-Gm-Features: AclHuK-MO8yQtGnXizwPI78LElvu7aVM2e5_m4tfC0oKEkl4LViWX4O6Arj8prg
Message-ID: <CACSVV01+7xbVKDS1SOJOpuAw4WojvxRa25fUVZZT6o7hVcNOXw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumag@kernel.org,
        marijn.suijten@somainline.org, sean@poorly.run, simona@ffwll.ch,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA2MSBTYWx0ZWRfX4Jdi5Igl37I9
 NJ1qZstqhshDE+TfvG4IeRBZ/4W/EiVLC4szsHCOesbAHfWt/IwzqvxWDKsr07jgsMhtay5ESPH
 ePuLMHWif5rzUPUWToiyvIFaVk4rO9f05wGuvRGrxNAkN4nyOWjgP1jeqCzsJnWSjWIFlTBaQX+
 qJGVzus0cws5gNtdDr2duL3NmvTZYlhcrKP/u0aPqu/STAjV1c79UFo7P/jQnyB7YxsjBzeuag4
 qOPtADkGnaLlDnXFbGBNnm1t04TyEbfe91d+RiQYKompiWo6ESfhIGvLO3fO+loY40B+gH2Bevc
 PnOXMxep2R93tST6hz0NKJFZIu1rREieHbVxBQiZ5DaPtPMCgqGF+Qp4KNAAmS0eg0D/aGguIbZ
 8iRYYbRmpd/SfciUpIiPH88xjnAYQ4wu56f06/F/u9YfL2+3cBpCyF/zaC9b7+bhGAWANNEj4h0
 aem/JruOtyMC47gI1dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA2MSBTYWx0ZWRfX0gs6OqPYowGf
 42JtS6v2IEJTBR3jV7nLvelZAkQp8lYgv64IzP8Hmo/7Ayq1rMrAFpaovjbAIOXEklYFvyTmsnZ
 zb57ER55IfIcfDR3BWNvTxmzFexISkk=
X-Proofpoint-GUID: NCS-wWmIfhN6NBjI5z8W3dpPdm8c55Wc
X-Authority-Analysis: v=2.4 cv=QvLLTlyd c=1 sm=1 tr=0 ts=6ab7e38d cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TGumlaujzOIqipXuJGIA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: NCS-wWmIfhN6NBjI5z8W3dpPdm8c55Wc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260061

On Wed, Sep 16, 2026 at 10:58=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> dsi_tx_buf_alloc_6g() takes a reference to the kms VM with
> drm_gpuvm_get() and stores it in msm_host->vm.  If
> msm_gem_kernel_new() fails, the function returns early without
> dropping that reference.  Since msm_host->tx_gem_obj is cleared on
> the error path, msm_dsi_tx_buf_free() will never see a non-NULL
> tx_gem_obj and thus never calls drm_gpuvm_put(), leaking the VM
> reference.
>
> Drop the VM reference and clear msm_host->vm on the error path.
>
> Fixes: 5e05be782645 ("drm/msm/dsi: free TX buffer in unbind")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi=
/dsi_host.c
> index 982abaaac00d..29e0de0e0c22 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1250,6 +1250,8 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_ho=
st, int size)
>
>         if (IS_ERR(data)) {
>                 msm_host->tx_gem_obj =3D NULL;
> +               drm_gpuvm_put(msm_host->vm);
> +               msm_host->vm =3D NULL;
>                 return PTR_ERR(data);
>         }
>
> --
> 2.34.1
>
