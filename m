Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303684749C9
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316699; cv=pass; b=ZHURv0315cg2a7nBVQp5Z5IQ8DCYzbmK8sH6mblAGLy9q+AUjwfKtVTxWh4td+Mpu13CGy6X7yQhG+agALqjR9eMYGlmVKX3CFKL1pJ9BByS/Tn0IYsnnUN7w3fWiVlOz40RqUD3K+eGuDTJruPFrItboEK9BhInKqAI3PcdOBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316699; c=relaxed/simple;
	bh=fZbb9v4e2sk6/OnDmZnaaF3vmjmxv3DVkekcYhG8d5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU8kFqESJnw6pPQJiUsKl3a5L0Owdnbbg+3NyZSG/hj3Uv0VY4aT9Sd0P84ILAZssJ3qSk5AUi8zjfxKKLGuccyC1vLlLZwn9P6pjz/qCJlTUUj0qqk0yY2P5mPB7dY6Xg2X1DDmD7uPnVbo5U+ldKTBByInzBepy7dzACt89qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TxAtR3li; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ewc3U80T; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TxAtR3li";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ewc3U80T"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCoaFj2355254
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OX8Kh+7PnOwt46WAC1QaJaLq8pinJzLn9zW07ubaMoo=; b=TxAtR3liTbaL0Hia
	95Zbr6NdFTGIDe0fK4fJUWbNOREu4ldJzKYTmbmTnonEPZPZ6q4KfcBNrDt8oNT7
	n/bjMWYHFdX59oyQcs+066+e5LwMt5YN6JA8DBPw0EMiFip1ZreMkSZTPFBxP2V8
	GOmM/KXtQxDTx/cW9eXcHRumPmf1Yr8Cqh0Jo42AFwulfZUN4ttBDSOv1Vl1aqau
	7ukVDIhC2B+ZJtUyBRDpjUpcMoMjm58gfL1sEykw+OTkiZzi2V1RL9pcZmdNguR+
	/blkOopN4tSlxuZ9iZiPMS7Jdw3+HgwyDEokHWkhV88BEsLEGvlCAsY6RZteo+it
	S4VsBA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdn9nhv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:51:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so16238065ad.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 05:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787316696; cv=none;
        d=google.com; s=arc-20260327;
        b=YNrLsQtly5D+zFlFLj+OJ4s9vgG8nKp9SN3VzWXWQ88VHus8G0iwggRM+EMOQFuXR5
         VmBcMgw1XYtNOBdh2V4moVBZhWID5HEnjAQ9Eey1xaH8DEmK5ho7xKNktHLmfvn1Pfry
         v3mjuj9BJC3yoXZ41+k36/Xvgimb7NTo1sOi0h7MXLqJLTfNJ9YRtJG2s8aEXdZQKLH3
         QlzfxJtz0vZF/cthmfgD1F9xkxfB/VQHiO/Medu8QnB2xT5vecLYqxKQ6Lk5GYazKLHg
         my+iECzn9WMxCaGY/0uR0jVLRCUqBAt3U9Sid0RsE/cw0ci/g9DC1XUOcUeNxBbI11Ex
         YNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OX8Kh+7PnOwt46WAC1QaJaLq8pinJzLn9zW07ubaMoo=;
        fh=KzB4g9ykABfKEocS5BlBpOzjWtBr4UjfB/VIVDK65hg=;
        b=EIhnhz7ayHAwSzUTbrdQJsjywcQaEzS6r2i3vzrN0b66OOM73vn12jowwXoKsp6xBT
         z0OEmRW6lUA8r81HWN3qZrEWB8lPyvBEl4j61UfDqZjZZ1Ka5RnnbdcU8OXVvt/ta1x6
         5WTo0O4ZPkimj7iL55Sd7O3KC6ssKuWGgDoNShJZFRQggHLKFu0awWWbJDWAL13PpOBX
         T/P1Qlmx61dRelqBA5NelD3vuLp4kA4O3uOrlK/XrTH+/GWwRz3ka5tSadsMlvz+3/jD
         an5Cb46Vyp8ZMhIVn8H+RAlVG26hjks/Hxw2YX54Et+vxC9wjJda66nFg/PId3J8Pbfs
         VZzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787316696; x=1787921496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OX8Kh+7PnOwt46WAC1QaJaLq8pinJzLn9zW07ubaMoo=;
        b=Ewc3U80TW2Qt3ljglCcLUza3h/Pk6+orf5SabxZxUUtydWaNiqWQ9YIq4pUlUpZjlb
         EqFWGsqAKU8/PbNh1a34O0fajpbFtjTTiiYV1hP6+OT70HIRr7LrHgCHXL59kpTkSZ5v
         4A34IaSvThoLAEzlD3w6HyfVZzC3gIe9YpgKtOXN79NKmxHMihvDslWvgv+rMPp62jFm
         c1iffH6o2JbaGhqCwegJ6nj4KV3MfI0W5em/enmZBln5oIgcmFcowxuWzpWtDKYc6LXk
         NRzOpPTCcVyXMqW80Wos/ll0C2DRmbppSw51qtMe6ipwxqaQWnK+KMLyKK+DF/I6y+52
         eJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316696; x=1787921496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OX8Kh+7PnOwt46WAC1QaJaLq8pinJzLn9zW07ubaMoo=;
        b=fnZlZanM/SOLdvoPeLKxUE34Md76z/Or8xKYNHlGQRaS5tjV+F0nd9Y/EgN5MtlE+c
         Z29tCl2queaJPTNowqJMU5blEZSIKDMbioiO59ziCMgKXA8AEXYZcTUZ+XljpIKDDfJT
         eV229AnMihZmaMJsMgMuxgjQmX2krdRi6UMbO/R501WU53OyDAI8GAAzV8F2bX+39IH2
         QU5iCiMl3/WDHhSIvndLPWuNAAEhKrqB4ZYccj9ioTIS3J7G5mf71sLir0hJa4XlQDhI
         slyYyyG8jVDYmifgNQ3Mma4uFjQsKgTIdJwRMZh4hWO8tOACfr0CFbAnzXfJlMI0OcHf
         Iggw==
X-Forwarded-Encrypted: i=1; AHgh+RpkC32kuiSg5sW0a6kvQQztooCu7K2R2DP8mD7sr8QQEkgBOXMBDw7qEGBP7j5JlEw1c+yUlzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LqQ8D2IDGfMw2d4f/wJyPgRzvNrEUM/C5aFagPPRoEP102fF
	t9FkU9V9L5g0uaxiLYfxBtefQQ7CzDmaJAEpueZM6M4dMVL3JbXeLKCCbvu05SrvV+J4XIPODtE
	Z0x5QRs7Lfbrm53eZFx9WhLQ2amANIADYOGAy9hDcKedInxmGPKZzYGbDqV5Zq6RM60dH8/bGds
	o7fu0zYacf5/mkcDk95I5ZuZtr7N7YROoDTQ==
X-Gm-Gg: AR+sD10XlJdl8G5tV24z84/To5aYR1834bA1HMzCUVTS40gxAi4XraB3c3ZS9Nl6gva
	tLp939lEsQP57cgXyqB8n2rbXHAaLRl2lxDKQY8zyfY2iImvlmgrMJNRKubbSsN8lKv18MLrF0o
	L4tHfK215Q31ViiCyJXoEhCjp+EzyEwRatmWl5fBLqdDzSAJ2q1v5ru1WnKQ==
X-Received: by 2002:a05:6a20:d74c:b0:3c3:b57b:645e with SMTP id adf61e73a8af0-3cd2fe23ae8mr13247615637.5.1787316696110;
        Fri, 21 Aug 2026 05:51:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:d74c:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3cd2fe23ae8mr13247497637.5.1787316695591; Fri, 21 Aug 2026
 05:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819-pmdomain-revert-adding-mxc-mmcx-on-eliza-v1-1-0608e7900b9a@oss.qualcomm.com>
In-Reply-To: <20260819-pmdomain-revert-adding-mxc-mmcx-on-eliza-v1-1-0608e7900b9a@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 14:51:24 +0200
X-Gm-Features: AcwNN1VEQ7RIyD8FZDlATdfFkVI8H4V_7PjBAw26wxnRmKQq2VE3dRp_xLlAr3I
Message-ID: <CAPx+jO_WgxJSyW_ZPYLrYaQMJMv6w918CQupeHoPSr7JPxqa8Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "pmdomain: qcom: rpmhpd: Add missing MXC and MMCX
 power domains for Eliza"
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, stable@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NyBTYWx0ZWRfX7eiesXbjfufh
 00y6XeG555MCKus5G4gIf7aGzsSIxwLxbbKGAVB4DLOOLX0yWFnKxUsmgs8nSgWiL1wAA33GbBu
 bXci1GE52Jj02y9GA9pJWv3/MP3boXdvyfA86UU6IioVa6UUtanxQDr1/EvjR0ipfps67EXsfYO
 B8cbCFbJXDE+qNxjLpNeZkRkhxW+tJSIJQfgB3Nqi48G+QHWn5g/cl7780lBQJt8O+K3dTYGMhd
 az38kioO9Zm2ngI+ljTjAjc2nRSGwDuRIaooeKFXmsUU6rorV4ocsxK3Y+nIKDY/rKUHPoxrafA
 m1A9HdwBf/4PM/R1ndXvX1sLS0NjWHk2r/vsqZAcpRxXV73FQnUgsPgZ9x5PdJJkvT3TG8zb9k+
 luVLlfQ6qoUeS4OguTP6nN9ixOpBLv2Kx8nKjSOgxz6xDK8VZ650BgO2OSGuHWKo/Vz/wYHpxfj
 dtP84dX0oxwdwmCd0kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NyBTYWx0ZWRfXxuxB/S3XK+bd
 v7GBPzd+ABKz1VRjR92sXhCmozt4ug45HQVdi3/Nu6ilYimhSMg3Qtjv7EY+uXiegXxAsYohGc0
 VB0lLWk625uD7FGwpU/RVnF/g3sytHg=
X-Proofpoint-ORIG-GUID: gtRsPfHi2QzC3OYiFCGKCz7i_YPd2tWD
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a8849d9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=Xfj96N0bkABj-llejB0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gtRsPfHi2QzC3OYiFCGKCz7i_YPd2tWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210097

On Wed, Aug 19, 2026 at 7:55=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> This reverts commit b48a0a0a76ccecec60f0568e2af4d89994b08bec, which
> wrongfully added the MXC and MMCX power domains on Eliza.
>
> Even though they are indeed available in cmd-db, which has been the sourc=
e
> of information for adding these two, at hardware level they are not
> actually wired up. Therefore they need to be dropped.
>
> Fixes: b48a0a0a76cc ("pmdomain: qcom: rpmhpd: Add missing MXC and MMCX po=
wer domains for Eliza")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhp=
d.c
> index 96e4bd2f5a14..90743275942d 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -241,13 +241,9 @@ static struct rpmhpd *eliza_rpmhpds[] =3D {
>         [RPMHPD_GFX] =3D &gfx,
>         [RPMHPD_LCX] =3D &lcx,
>         [RPMHPD_LMX] =3D &lmx,
> -       [RPMHPD_MMCX] =3D &mmcx,
> -       [RPMHPD_MMCX_AO] =3D &mmcx_ao,
>         [RPMHPD_MSS] =3D &mss,
>         [RPMHPD_MX] =3D &mx,
>         [RPMHPD_MX_AO] =3D &mx_ao,
> -       [RPMHPD_MXC] =3D &mxc,
> -       [RPMHPD_MXC_AO] =3D &mxc_ao,
>         [RPMHPD_NSP] =3D &nsp,
>  };
>
>
> ---
> base-commit: 5453bc3279e9f8578ac3e534d476240e40c879e1
> change-id: 20260819-pmdomain-revert-adding-mxc-mmcx-on-eliza-647d25519f0c
>
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
>
