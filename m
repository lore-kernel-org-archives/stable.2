Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA553C063E
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381099; cv=pass; b=kTJ2gyK3xgZAUQsuuYb1bVxq6abjqdQ90KsTTgii1myyTejtHrgqd8JB4/k1IBP/m1y3l+4OnuqO1SIVGyxk4kgCPYouJXo1eVslImPKCoCPyJJMguAPrsiyvv5xa/kbJjQxAxZhE/5I1d+xkFNGvyhRDjEzWv+OnW++W8Byt1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381099; c=relaxed/simple;
	bh=NXKI/X2JdsZ4JImi2yN22pzvK3RGm6LVHH3NHot9Mzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8WEmanaVM+hTsxZmOc/Codx8XR+qR9EUKZ3QPi3ixe9VZszpvq6JD/ZERGDNrDnKsqSn3yiEBNwvL+Uuu0asvNK8N6f3kepO7wHO5AzNSp8c80HOseVkOflk2M9Z7jiQyMRRlAwcPlPqnNVC9DuqC22vxb+mU/ygxjWIVYM7hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=neHH2+Gq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0pGKOf6; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="neHH2+Gq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0pGKOf6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9kC9Z1948233
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=; b=neHH2+GqkXm4jA5o
	Hz+Z6gpE0mpPMnGoD1cRYZEBD0zDDrM78UsGS5zMUmjxdSfDa/om//rGGk2AVF00
	KU3lOskymWkC09tz0aJzoH+PM1Mql/CGYpyqFH+Q+87js/mRzQk8mvqdgqLoEp3n
	MD3zB1/mJs4HJXdZNDi/MFnQ4EOffoOnsyDxQZ9EL5DuIRijokgAqVUoPAgdBvza
	9R7ikt4oUbrn9/901ZM6n028Prc+F66flYShREXRYk/BgBdW0ZWJlwIWjoxAw8TP
	NB01WgjrLDRTRMVYPwT1ZOdBIFBCvs4P6Xz1hGYZMv4TX75tQshiz/w7pDV4YZ/7
	/Im4Vg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8rqx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:51:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92045e86763so160909985a.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 02:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782381096; cv=none;
        d=google.com; s=arc-20260327;
        b=O8R2Plr3VPdTbspSQlNzsLibbMvsjwXG2E030IaF0D3YVV0fSzgCCxvM6SB3tDumYs
         xDlLxis1xgkuTZdt5bJlTFzI1hW6WbsquviEgaczE9K0iJr5TwGeL6kCZyEzAwQSerbH
         uxfjUNVlZFDsG+pc8yQHzXnCUtsGK7FPZ+WnI+9Bd26KPd+RSjoCyoHYtH1UDX5jzKxo
         sl0Zg0Ll0sKU4FQh8WYzcZh7LRvy5BrRz/B6psWdRpNncJQxmQKIESQSkCeOZOZxdqBY
         4yZvCJNehEW4yKTJ1dXY4m9TP9B/EIzWV95qA82xXZSYWyrrV7zIp8JRCRd7vm5yIjin
         BVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=;
        fh=Ye5YT8ZtnbyktTd0POW7NTEDreFN/6/vxWix5dKMhm0=;
        b=n346U9uSCdwhf0LDTYtEpDYwS/pt2uhGrxa1MhyNLcnRCyl96pV4yqj7RDwWB64LWz
         phiSBrynTfhXfPjsAQ0E6SNKy3CYoO9V0Rd0DBeaY09RYnyPcfxVzlwOWZlfXQi98hpG
         ezShJ602/G4WB2usn+snsw5E/iTUgP8yIiVtFtR/+P/Hrr3kGCAa4ZTyPuXWosUCA7WJ
         hDxLol/Aala3MLw5hkJfjMAsQ/N8PL6mUrzeRueZIQoqdPkq0GeOYYVE+zNRWLyZBFty
         mUYiIrw0iCofA1OZyZJ7OExn8n3aHdy8zv8QgXLJJLc5sH15eIty0RqQe5R65J3BocEd
         47Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782381096; x=1782985896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=;
        b=K0pGKOf6Nj1hOVU7/vPFIagniMTTMIq0LZm6+/1WyaN26YL9c7BXnJoH+EB89i86yB
         oBy2Xg3cPwG/VWkMkFZsYBjGMVkBHlDrotZOG2BHEs39DWhzShKB5YA+Bvt1bxy7dFqu
         W5IJG+8gIQQBQxI4dfQv9dVDOsLhNK//S/UXTV9Kwh58EkmFWbdpNcVKzC3YiBQLb/Kn
         NzoOCabnMpESVBy9rc/0+4NT6W6fXR4xsGzE5E8aCA1pTLdSx3L1u/U3zSpak9rfXG16
         QlbnK3lmMmH2faJimZC4+dXx/EmidBKgkpiM+sNV8X4Sx3cRopYrTmpfWsXrY1+qE6jP
         iUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381096; x=1782985896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=;
        b=DP2oPnK34VCtAtBV91CRusPfz+AtAL2FLtwgU5WEpuGZgvB+r5++uBhu+peyzaCXap
         zL2w1QVgsyffvqi7hoUwaTFfmDx2Xn6U+ZTvxvsc2G7hinP4j7Du5CstrHBAbENMFEyQ
         SOjGODO9ZBo/E/x5sN3C7W5GNhHGnhrH5eehjcsScPjt9wYORZj5GCJDuSi3U8woKFmG
         yXOSnEcpr/8PIoK8uAgcqS1PKsEplvqln9kuP3pS8I9b44lqUTE+xWFmiDTD0sCloghp
         dN+ODmK84EJnH6oeENlkZHcDobxVjt0BEEjGe0fR1de79NUkqWMzwV05odNtEGcTJgBb
         g2Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+/0J3tEYuj89mC8LbIJfbaHxaU+SIf8ku/aLdTp7ryQDRoRqGbuE8Bhq4PYsnh0TQDMgEggwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvrY/7/D0cJZQ7jD9tXNOA1yc1mgw+cSyEMkgbnamoKM0xp4+J
	4hzs7dLh8R3hkWtZjCejY7pGUbS5WV8Rwyg4HY3qnJtTLuqNi8D5QJ3h3YYGFafcw2Lpws+Ugv6
	As0s8akcnH7XL4BqOzSOnNN9976SrqW96S5UuMs4IJ7YRvQQ4lQQhUJo4TECdInxX9acyNykMpJ
	B1lWOOhiGKvP820615sxaSmoOdYFQFF6Nc2Q==
X-Gm-Gg: AfdE7ckGFzeqUUG9p4vrH0T9Ri+WT/2697JjbmDu6bLsJ52AMp+Btie/trFqHfQyqCr
	8/ng9K8Sxw7XR+P+kckoZvaqj5TfomTzsoNubUXP+ZUx/GEEP3qdmxaPyr+QVIRo5Cbz5Mm2TcM
	HwYA6Q7xICxO0cVc3VQzC/cwsLdX3nP75olN2/lQUMzr/EHgMcIXhDJyl/atPvGscHLQa6DbHja
	O+kjkkmU/MyrxrDy6uy+uUSZxvScrFwz0k9wmigPTluF7ZAnFh51pdqjG1qEoUASDSgwKyyKISt
	Ju4UvRKwv84=
X-Received: by 2002:a05:620a:269a:b0:915:ab5d:6763 with SMTP id af79cd13be357-926039b4cc5mr908910485a.43.1782381096069;
        Thu, 25 Jun 2026 02:51:36 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:915:ab5d:6763 with SMTP id
 af79cd13be357-926039b4cc5mr908908085a.43.1782381095620; Thu, 25 Jun 2026
 02:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
In-Reply-To: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 11:51:24 +0200
X-Gm-Features: AVVi8CfDXACT0qSqvnYo9b7ZgxqbZ1d4WZWiyuwC73lAhja8c1-UXvbxtlfkIMw
Message-ID: <CAFEp6-3AY535E4LzCpH9-8ksiec=qsk+Ayzfti-kAk7p_FxstA@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4MyBTYWx0ZWRfX+6xcMEBHs+dN
 LjQERsmDr6KQyTkj0LkwXjzsluConr+WCK15z+hgP0JtfGx9lsfsXf8g9y9/thrdLrVe3Y3aC1B
 laDgEDLEhDapvs3uAJWLhRsGQFHTUZY=
X-Proofpoint-GUID: RCmF3nc1dzIaT7BohifN5dXeqJBb_4Pd
X-Proofpoint-ORIG-GUID: RCmF3nc1dzIaT7BohifN5dXeqJBb_4Pd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4MyBTYWx0ZWRfX0jfLZqgnet8t
 BpCbqPa0ByQjG5eWrssFOCmZjULFkc+vCHF2O7lMnVVody8DQ15Xlamvm60HsaYX1TwKbkfXthf
 d+7dfncmYzgc/tAcaXNvkSmSABzqiY1zV8mZfK2UaqcsCpBbWEorSIS6YB9v+PvXUQZXir5v4yp
 jvzMeD5MkRVVWK25X2tcwxk1AjA6Mqq7ukpoN87pLPnlayp48abLEs7IqPhCEb3XOak4D+rBh4v
 vZiDTQQpEGNkH1FopidRkAMIYumUCJVbIJF++H+SM/ZbliPRaIPPqConMqEPSAE+3PPL8bzeFUj
 4Mwk6UgVhELtCuAE3ED2wovm9xZ0igjtzesx8qkGZ8MDJG/F6ygfSzxt0dPsHUcmKqxVDVvkovA
 H7l6gtCAAZNsPkouIXBbtAftTvgJG1XxveuN9fSihd+EfQtCrf7E3dAyApz3hKgVvHO06DXIa0s
 sxbQfUrSokPsZIH8AZw==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3cfa28 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=lGg1ZlD2jTvwlhVTGJMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250083

On Thu, Jun 25, 2026 at 11:42=E2=80=AFAM Wenmeng Liu
<wenmeng.liu@oss.qualcomm.com> wrote:
>
> cci_resume() unconditionally calls cci_resume_runtime() regardless of
> the runtime PM state.
>
> If the device is already runtime-suspended before system suspend,
> the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
> As a result, pm_request_autosuspend() does not arm the timer,
> leaving the clock permanently enabled.
>
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 4d64895a9e9e4e0bd5e0ccb5c3cc04b282b1e4d5..bdeda3979c4814b5cdb463734=
b8361da7fffa879 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -492,24 +492,8 @@ static int __maybe_unused cci_resume_runtime(struct =
device *dev)
>         return 0;
>  }
>
> -static int __maybe_unused cci_suspend(struct device *dev)
> -{
> -       if (!pm_runtime_suspended(dev))
> -               return cci_suspend_runtime(dev);
> -
> -       return 0;
> -}
> -
> -static int __maybe_unused cci_resume(struct device *dev)
> -{
> -       cci_resume_runtime(dev);
> -       pm_request_autosuspend(dev);
> -
> -       return 0;
> -}
> -
>  static const struct dev_pm_ops qcom_cci_pm =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(cci_suspend, cci_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_forc=
e_resume)
>         SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
>  };
>
>
> ---
> base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
> change-id: 20260625-cci-3eedf766d43b
>
> Best regards,
> --
> Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>
