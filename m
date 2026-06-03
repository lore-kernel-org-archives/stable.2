Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9B34846A
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481738; cv=pass; b=ERcXmi1evokdREIEGxfCq5/WwjFI4qZKhNKkRyS9ybe0AbRBabx7h1WDpLf/TuApvDoL20A/dLyNIsrQ7yYigMh/bqczG9yDvj/I/I3mex3Erb9rmsB//gLM3yBOuiMA6E/pJ45+3m0c8GRWfjByWH07pVMVvQsjM2iAtu7pjZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481738; c=relaxed/simple;
	bh=ImyaRmLghxFwQsTJnShE9IsVAyUjBEQQdEnQ0b9Byos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cux8LO6DIEroN2FMUt31ceZxAp4PLwqVYp0YJ5eEORV3uTE0GRatnv7+pDsDb9KFvYqw7H7F2nnWYGgRS9AoQzigXzlM+haqVP4MUpTIpar8EGP8YDp+VPUwO0sHc/CGBx3jXPmzjcu5SHf9tCqTHoQCymqjfr5imIrLNJfhSl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RV/ZBQBW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EatizQkV; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RV/ZBQBW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EatizQkV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65395r1D780730
	for <stable@vger.kernel.org>; Wed, 3 Jun 2026 10:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=; b=RV/ZBQBW1Gz7WB7g
	C36gOhNhdL+lLAmqQlpap6noJbbxHcrt5EIxi83XQdvwRajDeMt1YFcY+H3mGLXT
	9XatmhW6r/yTEhIszMkIGbMkNaO+fyhhVMzwIGL7bcpZ9ReeDX5jEpLuRbcstKSQ
	YhnhXEg7Vp0lJ0rPhBLgdWq78t4NPOsw/LugKMhQPSnThw01mcIgA9my3R2A/CFD
	SMxSsEToum0RhiBvscPxkFsFs1FxqjfwWOQrc5lvshnJbrHXt0WtI8psq0P5nZyX
	LEs1LzosAOE89oi/Bezr5wGe+ccK2iGDRjqfsqOH5hQOImzaSe/nMOk3SRXe02I+
	vbBXAg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb0a1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:15:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ccd719a2f2so84536666d6.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 03:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481735; cv=none;
        d=google.com; s=arc-20240605;
        b=GSn61ejsSxv9VwwT8gvp9d8bjd+OuoF0qW4Wck7klsGNCjLMNIQYJmGUNUDi8Z5Hsm
         RjivcRghxUIyD9UTGqzC0cqvxGmldp3e0y0VOxWjA2bjE3TyoO2JxvRpptYBZo1ra8ne
         GbwxMWk0nKam467WV3hBf5SQg57RcThRVEYL6DM7p8VDpJ+r2mNP+EYmkn/ePVcXY19m
         bkPko8gK1hmQ5XOWoAP/PKcfuVbe9+NIGZ55yqbdCCgBLGQNMM16DudExysGLWiXnStt
         P3+bzC7BWCEzF0Qck8pQ7bfOeu4fhIfpiUQgr+LTbXXWHPKVEdUVG+CPDgPkB/d9EgAQ
         jqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        fh=G0zm8UR6/Z170PX2+HqmRsZoZhpOsQV8OIBQimR9K8E=;
        b=G8T3vA9S3IXgTF6MJTT8bbQ94FZR7YOdPkernWMqXB3ZgZ/nRRaen46FdJjHBZrX7A
         jaG1q/Sra/SYq0x6KF1xBqanAwK4BJTqVEieIy/ByFMOdU0HXL1sLFeSvk4p3t3W64sM
         m1Juc2imE8Su5EuSXNhsE64oR0D9JzrXhT45uWsL/cGrRLExiATsoILmf/7IV5ClaUkt
         fjwqHmmQ+68di1d4ppL0BS3gIfFuFhqvbpwCy2SPwVb+rpRg52rbn2r24FyNaQiKhq0T
         8TNrg4bSjH06UAlfh9b019PyshXBKu35Wa74ysS11GALBMv8y6L9ZyWXbmeA/SYh7FzG
         lUZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481735; x=1781086535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        b=EatizQkVu7YoBqs4qPwuLBDMEpEcTxnuqziYKDt0bPh9McXDPanapbct+i5amdkN3F
         Jajg9ZgkfC1/+jaUiPBGfN6wi6ZRDxc28EKDs9Erk02sliQ3TkNYnj7U7vizOnqwEO/C
         YL+eKxv0jnupOirDhq3mpKzt7RP7ts656r0cFVfxymb9MP41VbGf3AYdNhieLGJXf/ze
         2xt13struA3s6xht/UE42oQzJerwyunWlc0ifNJ92XwPKl20aQ5CEi/YveJoz9H6LDTW
         MuDA1GKISMtvP/l6g9fsxaGNmZ0xSQtsPgWMp1+c/FBoZyfq1TPeGfZiov1KEMegbzp0
         3nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481735; x=1781086535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
        b=W0lC491BhYl3NwwbOLuLOronQMRvVnnKLpmPDUhmofZLSfn6AhyuBq4RCTvMu5oO26
         3k/Ly9s2Q+rFYj6JkbIy0deGro8vgZIIvRDeip8HX9Gxb1F7nApkEG4gEExieuGUSiI3
         kplmZnGF3zy60lcmrgKjOmbk8+EiLkDo7EzNil0yinyDoEdcfzbXw0Am3AUZB+LNQ7Z6
         GWGXZguInzK9nRMD5tHrlZFUPVOZ78C9+qjRRuxBH8w+DxEPNjHrpIu78AUwVqGERf2g
         gB3BNPvZdOI7yXAuf/AhP7587kqj7XNS40jKVUyjuh4cFlHZ5JbHGTNF2znDUcHWjqlT
         EWSA==
X-Forwarded-Encrypted: i=1; AFNElJ/RcQEic3WHdugDW/APXkxti+NwKzeEuJpP2TTDXwX/cX8xo/E0/plZUasHK6EIJzS3MlfoXFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4h3CcvoVrYLhs8V8lim5mGM9yRzK5muUOY8VJbDIojlHfxtX
	itP7Zg0ApPUQapUkk5L4PkynT5vkIDDE2Xb0Y1JYzjj4p30tr41tEo8q3ANAlEr4c5s66xsgOvN
	vuNfjAOokZ/zj2XRf6kbMTwvT06YrHk3cfaOsyIWZ/0G0Ww6EJJJmxBYCwX80ZQaKRGgwIa53Ov
	NsVdVGZOvKuY0hMNMSJjYOB7FSvjezCNDlzg==
X-Gm-Gg: Acq92OGFKLEWgTOPmf0pGJR3pacL+7V06hm8Nppk8JH+9GycIgqQt+App7+MCiamdcr
	ZgyqWrMmkfomh90dOyDzeANcwlswC1gLRTnV19njCog275d67duOchpe6GT+avyabaoXT2/V0p5
	5H/HfIggBXZwg0/LGt3mmZLZVqZgd+Zu5E+cLbmRvJ8umC1ZqM4C9Sqj6esF6SEh4mfpBNfrw/C
	4B4j96NhfsdsOuX
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id 6a1803df08f44-8cecdc03682mr27951966d6.9.1780481734749;
        Wed, 03 Jun 2026 03:15:34 -0700 (PDT)
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id
 6a1803df08f44-8cecdc03682mr27951226d6.9.1780481734358; Wed, 03 Jun 2026
 03:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com> <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:23 +0200
X-Gm-Features: AVHnY4J4K5UzPNs1yW8q3X0LoIQq3c8UfPuD4kHDjf5PzjApCRf1PSF1rlsmtoU
Message-ID: <CAPx+jO9iJBx6Yifap55NOhn5YZk8Bbwpnk+aeH+0PgYuMxke1Q@mail.gmail.com>
Subject: Re: [PATCH 04/23] pmdomain: imx: fix OF node refcount
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: p6R7PnpQBeqcbUN_naoTW1kIyrgg4rjY
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a1ffec7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: p6R7PnpQBeqcbUN_naoTW1kIyrgg4rjY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX8kz7fzv4DgaY
 cWDr5BZ7l09VTPax+KT24vcVPAEb6NAi0TwLL4rvNTjF8zJeSZIJh74Kj0tOs73QDUiyRmndQmt
 iwoxTmVNQrzcqP6zK/hywDlFFyGCLu6BvQQitWyOBf9+AtwS12CJIKKybb9OTrwW6JUIpnKcf30
 R/9oN9rtmGiKLSnfmrz4CkBE/Ti2jd/LJzKxhqhKfuyrsqh/yy0/qVYOhNi+1SzFw7jSXwQh/Kp
 HcCXjCxcSVeME+PBXGB24we+Cg/t40Em+lYwNuhJ0Fh+PnNkFNMIhY3F3PyxnhQ4vUHplhfonSX
 6nqYCEszZysL7jQmHusWRAw6m5UUDM1Ec44XCdWi/3H3WX5GhsXEaoZTNE1Fm7y27UQ5BJxBxgB
 /8FUMIUcv7oiXwbE+5T/ZAKeXNQ5kpGnYznb58LnNTEcCHh/MAGpmp/SGtlf0yUTzrE0u14GFtl
 LYsXVi7k+AEHWsVJJdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030097

On Thu, May 21, 2026 at 10:36=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> for_each_child_of_node_scoped() decrements the reference count of the
> nod after each iteration. Assigning it without incrementing the refcount
> to a dynamically allocated platform device will result in a double put
> in platform_device_release(). Add the missing call to of_node_get().
>
> Cc: stable@vger.kernel.org
> Fixes: 3e4d109ee8fc ("pmdomain: imx: gpc: Simplify with scoped for each O=
F child loop")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index de695f1944ab31de3d37ce8000d0c577579d64f9..42e50c9b4fb9ffb96a20a462d=
4eb5168942a893c 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       pd_pdev->dev.of_node =3D np;
> +                       pd_pdev->dev.of_node =3D of_node_get(np);
>                         pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
>
>                         ret =3D platform_device_add(pd_pdev);
>
> --
> 2.47.3
