Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B873EFD1F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525636; cv=pass; b=gy1KCPQRCeFw7L/6456QA2FcogwQnU/6v2paHxBiXUEaTymPqihLVbyRdP90gv26UqbhibtPGuj9D1ftNhBSHlb5uCuCZNaI9UbCTW1RI1Ig47eI4Cz+8rACc54KFJNidNgSt4bfDO1WP6hQofhLuHK7Ezkggym3eviaiadeocs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525636; c=relaxed/simple;
	bh=tlSwqxAiw604cpb1dgd/H8C/UkaGdvxpywU0LdEuBW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ue7/0n4Z7t3h3nm/0CGxOkNZ7tyiKTAm3/DsbxeuVdN3ACdiUUzsQdsfmOQE3UYICqQGfmFTukMs5n00DLs2I5mD34hXBnYFpwrYVm+DDRN9oBeML72TMQm4ZQ2X07dLmsaGXxLjsDmeXtYP8uv29iWOOP3uAUM+mjZbGHNxCyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a+XeAnzc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dKyAuMJx; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+XeAnzc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKyAuMJx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684AIEdC3442515
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 12:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j0+GeMl6zOe/BFRxRXazQ5C0aLdugDFg6DqX1FNOkk0=; b=a+XeAnzcyW2zl6jE
	UY3r8ydj+u+BsEl/DKXlOKXvLl/iAfayC+PwBPzqTLuYa5rmvdHqY293PJK9tWWd
	Glyf15PS/3SszWklDQ3g+ELtYfYXfUVk3dZZfPAzo0oMfPHz92AHb52eDEpjBApn
	LkSLbb7k1ZZIJm4/21qWDRB0L9ZarRTzsJ5m2NDSNbrC4GuYFQOlVmSZ5UdDtyyu
	3uxC7uR4ICIKvU3kWlmQXAVmjJm0vPKaE7P0naEJ8qhUMoc2aF9rUUG4B0lgLfPp
	xzwBwJJk7QmMeDCqU75FBLiEsPqWUdwG7cjnm8kKMXHpWsIKjQfXp0/fDTM52aDs
	Iz6whg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp781ngk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 12:40:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930edb4362dso151314885a.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 05:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788525632; cv=none;
        d=google.com; s=arc-20260327;
        b=s9/4Obw77/1QH2Cd/1exYw69Ty/rKfnUj/IO+TAH+FTRatJL4rHT5nL8UoS0XARbM5
         HcpSeYLEeaIhSJ8k/tAe/2gtievv3uvpo5mKb/DhPURzLIdqwszIMs9aAxP5qq5/ey+r
         SmmfHdheIM9oHcL5m2xGB4zMVIeab8uOSV4PWQTU4IejR64Zzfv5hNWM6z4BzTiiHKhl
         XQieHCRtDk4EJOvRG/AgzGMBP5mV+UIEP+oZI1biveGHUMsezv4t2zzUy1KITJvQp2yl
         zlejp78DT9bqvukObN1onXRYQnLclh8HoWs1Eapm8LvlMys8Px/4zdGqIlJTz/il2V7J
         SUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j0+GeMl6zOe/BFRxRXazQ5C0aLdugDFg6DqX1FNOkk0=;
        fh=GY4TMTUXNfaITax4u60LqUUHLo/iTYpG3t6m8ovl92A=;
        b=sIqsY8G8399O8u+YzQC/ou/MoTE6+vjmgybNcv/KvP5UoVTk367w8jl2kzn5be/RKl
         7w59Vk1BdT/9jFBnJu8TlMLF/U524qrPCydlRjL0DkeGXtlg2Ito8y0Zj370bjrSROTn
         3dN9/r60hKDIHPcqBK0WPYhHditJRh1eCjTfXUKcSIC0UIfd9OfXNGBvhcix73iRQO09
         602HSxcAT48m4tYDVke0WSoqV3QvgqMw1ok9zD0mUgW0thDpgu8YBj6Gxf/oco46BGXY
         Uc9ezjjcCYre2zuW9e2vQNadh4f9KgV6tAA5djpyqGSsgQJSf/cVBCcCK+epq3rwm8RJ
         TxYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788525632; x=1789130432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j0+GeMl6zOe/BFRxRXazQ5C0aLdugDFg6DqX1FNOkk0=;
        b=dKyAuMJxvGnZTckVi7wt1XPguEvs/jlQTUmMTZ6rs7Cuk86PucQjB4UgsCCNZVw7dJ
         AK0SMwgNmk7WKUHsB9fu08EctCT8l2pUhBMnTkZUF6sLvDDh+BVXGw7v+t6GZAnuEJn6
         5ClOxSdMy1BkoGftPxm+7PK63d8ug4RJeng7WWX1CphB77VTCNi28d6RZHfx4Kr0RfRP
         7/zGCvWThqjpTJRHxvyEiO9ffIYsX7ifx1Otv5+pQmruCXjXiM7fqRrE7dH9Ddn3dmtr
         b7E/WImqBXC3ZB1FseWZ8zteWLCe+Jfcl5ReiF2ztnmOHG4pGU/wJnFKfvJX+vGHjEgM
         Eo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525632; x=1789130432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0+GeMl6zOe/BFRxRXazQ5C0aLdugDFg6DqX1FNOkk0=;
        b=c/ssDDN55JdSIvYZMjKuAdGeJItlHgEL6gSpfHz3Q+RlkqJ7xxcMr7q2uQFRrW2JuR
         8H7IUBqoZaVXPo7FllQxyHxsxdElfzCqutJq8BkPWQeqQLXLd8xZ/loZdwJArKgHTpgj
         2d48u4vS4Gwe5Ws9Cx1S59Te6v3EngYafBu82UzCurawKo9ZawQzFY7mzM2A0x0fgQtK
         mFrf+bprB0+IoySv7hFviNyWbR6iMO+dIEhwGrZRQUvrxjYppJIdQWUtWERDl/vaZJhp
         HWv7tqI90XfRhfgP3kp/B5OlyzQwiICuWYl8Nete8J6WhZpXCYIpgF6ZBrznwyFd1Kwc
         +Izg==
X-Forwarded-Encrypted: i=1; AKwUvByG3MUf7H6B1FF4ke0KuVdX5m/1ybPRGwAuc8+CWbttVnhneo22cIlYCKmb2eEujfwfLWuTZsU=@vger.kernel.org
X-Gm-Message-State: AFuF++mDRAOYZ6ihw5QZw/6nQE0o6abHi0Gok6a2dJ33uHeMftU/JCvZ
	U6cOhvgcDDWVdayHG/ZIIb+dl1jfkM3Jm5KgTchgC+u0e4i8H8HoKPdidthAGpR1Q0dZsxLgsz1
	hylk8PZeCyGxMyxZVWdcHns8b1267ius5+7chI7hvNuXdywT3SUglsNrvCRd5xr+qZgNUdGZg2j
	3zqooeJmTUmiuW2MOSYJyPHaT62blWKFMoeg==
X-Gm-Gg: AYBFou3YoiIVL27jukrLJLmCOUbsRxAcdDLlySZ3gt4C4QOAWyWmz0KLu2YOwm+/tQ+
	ZIeIxjClN5SUByaAcJUYmoXN1gZlJVdt11M4eYfGEjurerBFP14IW+YbM2qMQr096GJ1nstlEch
	AeyMhjbqy8T/M58D576bn5mlR1SBnMitmqPxczVHu+09Gj36yJwSd3PAGMspX9itms2qcu/iQS5
	B9ihB8DuqgASzCPkrjYGsemxBOu/HeHFwc2Vc3miCllAEddbAkWT5kgBl8Bnkeec9ePrhro9VqE
X-Received: by 2002:a05:620a:690a:b0:936:dc16:206b with SMTP id af79cd13be357-9398043f64fmr553873385a.26.1788525632377;
        Fri, 04 Sep 2026 05:40:32 -0700 (PDT)
X-Received: by 2002:a05:620a:690a:b0:936:dc16:206b with SMTP id
 af79cd13be357-9398043f64fmr553866185a.26.1788525631793; Fri, 04 Sep 2026
 05:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v15-0-68b7916e7a3f@linaro.org>
 <20260904-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v15-1-68b7916e7a3f@linaro.org>
In-Reply-To: <20260904-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v15-1-68b7916e7a3f@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 14:40:20 +0200
X-Gm-Features: AcwNN1UPiDdyGKcq8V93lMRdj7jZ5WTUE_ubspKx3Qn_j0cuDTBr-ZQNMU5Z3Uo
Message-ID: <CAFEp6-0NyozWY7DVoFbNNuDkVY3nmHsvys5=84mM7OVH6cHfGA@mail.gmail.com>
Subject: Re: [PATCH v15 1/4] phy: core: Fix use-after-free in phy_get paths
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felipe Balbi <balbi@ti.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExNCBTYWx0ZWRfXxGBzqcSCoD5P
 S9M9tiq2AxRNtpAphSPYUbQ2qvcR94XhkYWoOWEPCIZq37aH3CUdqBNru1rGsb4yEmfQJcVpKJC
 14DZUBT8WY1kWLDvBL3WTTSnOo4iGgk=
X-Proofpoint-ORIG-GUID: 3PXM-4b3-kRl6xIewZz7a7Fy7qfGTv9o
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9abc41 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uuK-gh7oNHpeqQh_G3oA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3PXM-4b3-kRl6xIewZz7a7Fy7qfGTv9o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExNCBTYWx0ZWRfX/6g2PtF784xw
 dxh+paekcjdvHCtOrAw4iJw50g8NHaWITgKC+iGdpH5M2CvxV7bTGI8LRaJapqmwc9EbiWQ2bWI
 rv7SbSkxXd3poPl4mc0MsRlgE7yft+irIwooNVE53vQvqw82TDSvq2nj+cIpmJi3PRlbaSrc5o7
 TcexGS0kFUg55D+KLENtLu06656MW18T2w+PlYWh0z3MU7dNUJufOHWXBXVoKFSKIF6KGYNgKZ1
 7pAVC7QzXukylHX7vIa2wpRF4EPyx0gohQAdvUdG8U+DlLBV5JPumzM15+EC0Jr6zVkY0m/Be/N
 qSBhGAy9jq2MVgsRTdEt+1yXTHFTM5EzGPF0hg8ts3leBJk8X05FbMD7Jttozd1ymdpmIIse/x0
 LuJtd6S/lABjdQA8M5Rcw/FpBD3fva9Fqe1cdOGZxjldXh5XzYShJ00MxxkTh3DMy/YhkkderpK
 N8v9/78Te7RpADEXF4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040114

On Fri, Sep 4, 2026 at 1:53=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Sashiko asked during a patch review if the existing usage pattern had a
> race condition; specifically in of_phy_get() if it was possible between
> returning from _of_phy_get() and running try_module_get() that a module
> might be unbound leading to use-after-free.
>
> Looking at the code this appears to be so, there is no linkage between th=
e
> phy and module under a synchronisation primitive.
>
> Using the phy_provider_mutex in phy_get() will ensure there is a link bet=
ween
> the returned phy pointer and the module_get() bumping the module referenc=
e
> count.
>
> Amend phy_get(), of_phy_get() and devm_of_phy_get_by_index() to fix the
> same usage pattern.
>
> phy_provider_unregister() must take the phy_provider_mutex so amending
> phy_get()/of_phy_get() to take that same mutex guarantees there is no
> use-after-free.
>
> Fixes: ff764963479a1 ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/phy/phy-core.c | 45 ++++++++++++++++++++++++++++++--------------=
-
>  1 file changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 21aaf2f76e53e..89addd732bff3 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -124,13 +124,13 @@ static struct phy *phy_find(struct device *dev, con=
st char *con_id)
>         const char *dev_id =3D dev_name(dev);
>         struct phy_lookup *p, *pl =3D NULL;
>
> -       mutex_lock(&phy_provider_mutex);
> +       lockdep_assert_held(&phy_provider_mutex);
> +
>         list_for_each_entry(p, &phys, node)
>                 if (!strcmp(p->dev_id, dev_id) && !strcmp(p->con_id, con_=
id)) {
>                         pl =3D p;
>                         break;
>                 }
> -       mutex_unlock(&phy_provider_mutex);
>
>         return pl ? pl->phy : ERR_PTR(-ENODEV);
>  }
> @@ -624,6 +624,8 @@ static struct phy *_of_phy_get(struct device_node *np=
, int index)
>         struct phy *phy =3D NULL;
>         struct of_phandle_args args;
>
> +       lockdep_assert_held(&phy_provider_mutex);
> +
>         ret =3D of_parse_phandle_with_args(np, "phys", "#phy-cells",
>                 index, &args);
>         if (ret)
> @@ -635,11 +637,10 @@ static struct phy *_of_phy_get(struct device_node *=
np, int index)
>                 goto out_put_node;
>         }
>
> -       mutex_lock(&phy_provider_mutex);
>         phy_provider =3D of_phy_provider_lookup(args.np);
>         if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner))=
 {
>                 phy =3D ERR_PTR(-EPROBE_DEFER);
> -               goto out_unlock;
> +               goto out_put_node;
>         }
>
>         if (!of_device_is_available(args.np)) {
> @@ -653,8 +654,6 @@ static struct phy *_of_phy_get(struct device_node *np=
, int index)
>  out_put_module:
>         module_put(phy_provider->owner);
>
> -out_unlock:
> -       mutex_unlock(&phy_provider_mutex);
>  out_put_node:
>         of_node_put(args.np);
>
> @@ -678,15 +677,21 @@ struct phy *of_phy_get(struct device_node *np, cons=
t char *con_id)
>         if (con_id)
>                 index =3D of_property_match_string(np, "phy-names", con_i=
d);
>
> +       mutex_lock(&phy_provider_mutex);
> +
>         phy =3D _of_phy_get(np, index);
>         if (IS_ERR(phy))
> -               return phy;
> +               goto out_unlock;
>
> -       if (!try_module_get(phy->ops->owner))
> -               return ERR_PTR(-EPROBE_DEFER);
> +       if (!try_module_get(phy->ops->owner)) {
> +               phy =3D ERR_PTR(-EPROBE_DEFER);
> +               goto out_unlock;
> +       }
>
>         get_device(&phy->dev);
>
> +out_unlock:
> +       mutex_unlock(&phy_provider_mutex);
>         return phy;
>  }
>  EXPORT_SYMBOL_GPL(of_phy_get);
> @@ -786,6 +791,7 @@ struct phy *phy_get(struct device *dev, const char *s=
tring)
>         struct phy *phy;
>         struct device_link *link;
>
> +       mutex_lock(&phy_provider_mutex);
>         if (dev->of_node) {
>                 if (string)
>                         index =3D of_property_match_string(dev->of_node, =
"phy-names",
> @@ -796,15 +802,18 @@ struct phy *phy_get(struct device *dev, const char =
*string)
>         } else {
>                 if (string =3D=3D NULL) {
>                         dev_WARN(dev, "missing string\n");
> -                       return ERR_PTR(-EINVAL);
> +                       phy =3D ERR_PTR(-EINVAL);
> +                       goto out_unlock;
>                 }
>                 phy =3D phy_find(dev, string);
>         }
>         if (IS_ERR(phy))
> -               return phy;
> +               goto out_unlock;
>
> -       if (!try_module_get(phy->ops->owner))
> -               return ERR_PTR(-EPROBE_DEFER);
> +       if (!try_module_get(phy->ops->owner)) {
> +               phy =3D ERR_PTR(-EPROBE_DEFER);
> +               goto out_unlock;
> +       }
>
>         get_device(&phy->dev);
>
> @@ -813,6 +822,8 @@ struct phy *phy_get(struct device *dev, const char *s=
tring)
>                 dev_dbg(dev, "failed to create device link to %s\n",
>                         dev_name(phy->dev.parent));
>
> +out_unlock:
> +       mutex_unlock(&phy_provider_mutex);
>         return phy;
>  }
>  EXPORT_SYMBOL_GPL(phy_get);
> @@ -961,15 +972,17 @@ struct phy *devm_of_phy_get_by_index(struct device =
*dev, struct device_node *np,
>         if (!ptr)
>                 return ERR_PTR(-ENOMEM);
>
> +       mutex_lock(&phy_provider_mutex);
>         phy =3D _of_phy_get(np, index);
>         if (IS_ERR(phy)) {
>                 devres_free(ptr);
> -               return phy;
> +               goto out_unlock;
>         }
>
>         if (!try_module_get(phy->ops->owner)) {
>                 devres_free(ptr);
> -               return ERR_PTR(-EPROBE_DEFER);
> +               phy =3D ERR_PTR(-EPROBE_DEFER);
> +               goto out_unlock;
>         }
>
>         get_device(&phy->dev);
> @@ -982,6 +995,8 @@ struct phy *devm_of_phy_get_by_index(struct device *d=
ev, struct device_node *np,
>                 dev_dbg(dev, "failed to create device link to %s\n",
>                         dev_name(phy->dev.parent));
>
> +out_unlock:
> +       mutex_unlock(&phy_provider_mutex);
>         return phy;
>  }
>  EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
>
> --
> 2.55.0
>
