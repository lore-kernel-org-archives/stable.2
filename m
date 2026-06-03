Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73686352038
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481732; cv=pass; b=tC/khI58JvxoziixrtBBy1SP3VhZLEdy5ZFQYOTl5V6b1pmUy3Xh+9e+Ew/viArEjzqUrqIev37167GpO/4/5rEiFV4inJ2uNssVcAGw0w9FT+oMuE9LHXl4FueVkOw7y3+dV3067IvhxXbVGN0jEt1zS9i61v3LRKh2nf929ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481732; c=relaxed/simple;
	bh=lzTW61F7FVXYw60jP6Wfpf1RzHEao+jpP6vnuLDj1Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu7G50NXN7SNFsCLcVFXPjYsSnwkgbgiLXvww4XCxcPjJ2azHgfOcIxARuCsKmNwc6F/lDHztJJd3KD09S5mEnZf4xOz9vylD6k6pTpuJkD8zLaBgV2A2KJ8lJGXeUbHXDKNjtktBly5XpD1lqAVnxMDsz2+IlYbpF7Afz8/zcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MpFPzKKz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hRSsVvGJ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpFPzKKz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hRSsVvGJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6539vRVT2368039
	for <stable@vger.kernel.org>; Wed, 3 Jun 2026 10:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=; b=MpFPzKKzt+MaSdEO
	wRr6hsr77rQQQjcUU4dDxlAAo0B7obT5CxiZ4wO0Xl5V9tlU/5J65c/PJXaicNCI
	nYYDlCmrQ5KTqnZALPv4QvOhpT0qECxQ5JiOTQkfexerrqFeO9EKpUqQTzbxCM99
	r1axIFFcYeIBYLXJxpcNfkn0pvt5rGQzfR2d68Cw/vdNLZ+GGOu2r0lu2TewtY89
	7jegl/ERFNHAF2636p+zAWafNnBoKKKxegxfNH94CXskEylj6eNcOyKLO28WgCq/
	+rQkSJ/8NAF5fP5RdyMDLIDuLbauIkdIRnrF6Fh6fk+yNLWRn4nJjmjltHHrsDfk
	B8vHbw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj3gg2cf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:15:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9157d38ab37so218799185a.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 03:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481730; cv=none;
        d=google.com; s=arc-20240605;
        b=O7XL03mgLYpqTYd0CadSLSQo+at2UsOP7/rZ8BWJr/8bWwksqMnZMnFhLdb6hE4C76
         dsZwcez9iwyq3hotuxE6kHSSiszHn7+QcULtKvGzkpDtAGqZfhSVuefYe2aankd9Tr2T
         WG31wH+eBnU5r7YuTar6O5IVCQ6CburCtVA56wZ3diVDXN/fABdXJBS/FF3VfWaTwRGN
         r//uYQbklAf+HVFAbhwmoWog7iOHrDqtzu2knyOEW88NSQpqtiL388V3VhuZiJ5Xb1hX
         +3QNZuWHA5n5UbRsF7D+ZchKxfkAvRNCsyORvxV8yt+NZAZ4tjXHaNL7of0MfqH0Eg41
         nWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=;
        fh=PL5bZQtpOW22m70UodbSUf7PY6b7OZ35faYef+9Ge+4=;
        b=j3YC0nljk37pwavasCGDovnhphE43HeR3rD/bndeMRLu6PRVyt6J5C6JpBa5SqUOQR
         m53uLIw38IUozrdH2IAY0MLrQvFz7lC3s0XHxRBXlWzfpg9/AnnnOH786uw5A1nKRu6Q
         SwoiBAijOX86fSm2RwpQC1YsnrPXL5iREu12IT+vqCeOrVKc04GfJ80qbEgPy/tY3ECM
         yV2ZHF28h3gFM9r1Qgm40T/S4jytifWKuZnFqni3nX3Qy0p0BufFbOEh/zFZUTjTXGVw
         h5k19Hiugii2tuSWbFqAbgyfHKcKtKc1f45+ZKv2QJUvth3fBoTHwzkgz7qyR89uEIRp
         /KJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481730; x=1781086530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=;
        b=hRSsVvGJVahcSC0Hqx9em2H8j403YbU/ufp3mbe2NX5nGyf+tFJ7G5jHDF+bnBMki1
         IsfSdsY7ax1Ui/6hQhJ4msJjj/PKDkikUrle/CC/Vlj3EmZaQVSdE5+OffQxjtcqQ3is
         ZLQZ/dU6AfxrSZLfdNM31/C+aLah8P2PO6Kwh2WN7OxaZSBLZsGvnQ31BqfG8Bfi6YY9
         cYl4eomNf6Ac9U+A9PszfzdWYfQCrgTaHNefK8bpMjBYDHUW9XmN6pf2rUDKyXpzvT3e
         /zHFUKE2Q4ZpHoSnBaGjj+ljoNWDlDioVTMspiG25L4OwiiAf/WUZTcSSI9mmWwSK4gg
         ItaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481730; x=1781086530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1wg/7kWgNR7muYHxsUG9a2q2VRHHh9+CGyvHpauJHDg=;
        b=UjwCyioaF/5zTMgTiQk3NZJLGLhGk+PjbFzJOwFoR1OT3nxUu87PbIuD/2yN0XxHBs
         t+TClALWASlzfbNnVZwX+qE2N/yJANk0PbgQUDwXKy0eMwebIXMTDB2lQSvqUNiIPZTB
         jewxlF4HHAtGjvBVeiA52o8VdCrlAolPyCtusjIQ0udxuZh9FTOnT6SZmSwu2jHie4DZ
         Sg9qiQ0xXazXhPEsUYMnQYTt9QrAF6gjICy1EDjDWFu8jOcV6mwb3kytnC6RA6tZc4T0
         gFriWPodLGX9srHO67fHgRiHlyZDXSRRUH70+8+fAEnVuV/I+qJibmakf1W4S7OiCmLU
         WEkA==
X-Forwarded-Encrypted: i=1; AFNElJ/Nyft6vb8iAvlPXYrq4Sl9IETXBQtncmJepDy6imfqW5ai3zgOHY2UBnA9BnuCSoarQn1KrFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAA81r9ABvQ3/r9AmexCZY9qbWgNxAM74Gf4Bq2W8h6tw71fK
	3cGnBHaXiwJLz1LAtz01Bmc5/vJ0ZXHjkUCPcLge6jq9pfDXLXMFEqZRuRfKCrPCjmi+HJxdnlE
	5Gl+rQmY8l9i9oME3gJqgUM8FQ0vjGoM8VfpIa4v9sKxdcjynocqrMclMf+AoR5LmyALnkb9J2Q
	zYzmPv2A54pAAynbi4KUgDzLmCrxQBCdwPIA==
X-Gm-Gg: Acq92OELv/mIDlwcdJuLEATw6QATbi5Vtit3qDLeYOYrblseM27e65XJG/6kBBsIitm
	ge63DHGIgctUGvjqNueU5+K2eSNUfFnuiPEdRfJgb/XEaBrSD3/vFnF/EDOndtcwNKVgmo0nJfv
	EaI5p3l8aD/ksD0D32OH+GQkWwC2QDtF46+AJR6woOuB5Rbs7oIJydkAr9Wyo3wGwhLH3ao0ZXh
	fdXWzPRFblENnIJ
X-Received: by 2002:a05:620a:a0da:10b0:915:8f08:5fa7 with SMTP id af79cd13be357-9158f086487mr166584085a.52.1780481729763;
        Wed, 03 Jun 2026 03:15:29 -0700 (PDT)
X-Received: by 2002:a05:620a:a0da:10b0:915:8f08:5fa7 with SMTP id
 af79cd13be357-9158f086487mr166581085a.52.1780481729302; Wed, 03 Jun 2026
 03:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
In-Reply-To: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:17 +0200
X-Gm-Features: AVHnY4KtGB2TT-BqNW-Fcf-Dph8doazFYHWPd16dxkZfhVyve8a1Cpv5v5zMIwA
Message-ID: <CAPx+jO_LeGn-bKpfHwp1gkeb8czb7nEQgdcoUeHc1Dj6BgvFOQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent devices
 of wakeup source
To: Kendall Willis <k-willis@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com, sebin.francis@ti.com, devarsht@ti.com,
        vigneshr@ti.com, vishalm@ti.com, vitor.soares@toradex.com,
        ivitro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX8RMCRoK8FLcY
 YeRjcg87VuTmAwADbo+AvqpH0J42FT91DbIZOIFOl2ml2NcfpEiwRBbdpNL+5vfyRc7xTxqdu9s
 Y0GQ85rTdwcq1hiUjRxKH1vfnDxJVTa22CtjoZ68cMz8DS1zv+DCXACEBWtxIUMBgWESW1O0KID
 SXYDTY5D8af72wHBf56XebpHIN7k6Yf1wMgTMzruxO7/fVZ914PwFPqKNrCjBw226QSK8jekfXW
 BnpluNNL6+SkzE7HvGJDVlJxNMdK7e5cm4VoW6HyXMvqGMtq7sT2Z9L1sEfu6OFXcRdV7qJEMU+
 XVr/2iZVpW/nz83ZdpWfE41f7nDYFU8YTkYhjJKKV9EscWWJ3X8Lho+k1W+Uc2wKKOJDYR1qGNy
 zxtjo3gKNEk84fI+1GtlxxwNV8anM/aSg6idjXqloqtQEn92kTCOyPmjUkPgN/3MQ44NHllsnmG
 mHdQZ1Z8mpPnLGnmJhg==
X-Proofpoint-GUID: AbT2FYCPK8o54dY4UE5Ci1pE1Jk1k_nR
X-Proofpoint-ORIG-GUID: AbT2FYCPK8o54dY4UE5Ci1pE1Jk1k_nR
X-Authority-Analysis: v=2.4 cv=UvhT8ewB c=1 sm=1 tr=0 ts=6a1ffec2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=m8ToADvmAAAA:8 a=VlitpaJNd95OzUvVioQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030097

On Thu, May 7, 2026 at 5:16=E2=80=AFAM Kendall Willis <k-willis@ti.com> wro=
te:
>
> Set wakeup constraint for any device in a wakeup path. All parent devices
> of a wakeup device should not be turned off during suspend. This ensures
> the wakeup device is kept on while the system is suspended.
>
> Cc: stable@vger.kernel.org
> Fixes: 9d8aa0dd3be4 ("pmdomain: ti_sci: add wakeup constraint management"=
)
> Reported-by: Vitor Soares <vitor.soares@toradex.com>
> Closes: https://lore.kernel.org/linux-pm/c0fe43a2339c802e9ce5900092cd530a=
2ba17a6b.camel@gmail.com/
> Signed-off-by: Kendall Willis <k-willis@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/t=
i/ti_sci_pm_domains.c
> index 18d33bc35dee1b3bf6107af1e414db377d515199..949e4115f930b93b18216fde4=
6131b5c8931c9aa 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -86,7 +86,7 @@ static inline void ti_sci_pd_set_wkup_constraint(struct=
 device *dev)
>         const struct ti_sci_handle *ti_sci =3D pd->parent->ti_sci;
>         int ret;
>
> -       if (device_may_wakeup(dev)) {
> +       if (device_may_wakeup(dev) || device_wakeup_path(dev)) {
>                 /*
>                  * If device can wakeup using IO daisy chain wakeups,
>                  * we do not want to set a constraint.
>
> ---
> base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
> change-id: 20260506-wkup-constraint-9b0261b04df1
>
> Best regards,
> --
> Kendall Willis <k-willis@ti.com>
