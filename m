Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308118;
	b=eGxAj6WuVan/8NcGqdo3e5WPUm+fkT94xoSFNGdJJx9q7FnB00fzdnd3Zq2iV6AS9sHY
	 2CotlE57fWA4bGTIntXqY2f//ngbtslRJOihW2x9721yX0aoyy5JOgwKoLxWfO1uBxdOU
	 3N0rMq/MQyKyG+XdLecKyrxwuiqUxugcmRnWULyKnNS3Mom8G6+tyafau+sqba+uhKah3
	 zddx6gh8nn9ck6D0SvaSSSi7iX18N3NSsRt4wX2xfs/dDUbtR0cRYy93lUeHuPhVsk0ZC
	 fnzksz6QDssCBQHd95pnk9GeHysC8vnHaiXmKgY4UXNfHpiL91kTj3UlughO+kpW/wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308118;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
	b=MDiHKjSqvFLUvjnKWOwHxYzelSkpPN4j5xwWSZk45n8+mVMULozl30xo95nZ/9hYTYwZ
	 vavIy5ZE4K2TjcmcZri/vXAYRoc/aim7oUC0rsmA9rfuEHAQrHuz/dIWWSWm6tQ/eSkNV
	 7vvn1NVFc/TUW7Q2WxiNzTnWItu5GG1sip5owRSV54+DHOj2YdbrqmEWoBFQ2KLofH0pm
	 JIcYXtylJa+BXxOhBvmZV6y/1CvWNqLq8z0zAdhxgPkDHdHzLx4hkfLGY6KYXSJ1yKI3p
	 o9KdkbnHYehfleLazdFhLV2KySsOYQL/crjyyzmfAqN/eYEZD1FBuGMYDQ21Z1fEAdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oe7X6rYC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iGLOvKGP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437A606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6437A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oe7X6rYC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iGLOvKGP
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l7tk3392351
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=; b=Oe7X6rYC7ba/GxLY
	1OYvKjjZ6uf3OAffFNrlbabF2j6cVGaxzg4fn6/E82YNIxSg4iZ1C7APW8DdxE74
	ENiN0wjxqWTlZyELXOx21oPG5L5rh7pROa/FzwVB2r4PJFSq2xaf24BA5eVpoCqd
	n94N7ixOpjlD0E1R6Eu+wPx1tSRWTK3hiGZzlCoAtUKRUdCNFfvXMxxzcYwQPtfs
	SOPfW6xghtNdIDosOPXruQRUcpbAEF7vY8V4G+onFhTXci6VXJc0uVczIg31KFCg
	ZOL6jgxic4Sxf+mbUym3+gb77zBlCMN3xILGCGKR66T0CV+zSTfYRjfSKZTJWotV
	FVc2Ew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg33hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:55:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso2673158a91.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:55:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308116; cv=none;
        d=google.com; s=arc-20260327;
        b=eWMpjUZtVWRZWgd+L+qf5GFZicDPs2/tqehtJ7icmGZ6ccFfo40nEIfuiCjujaUrVg
         lvv6MX23ud82c2USuG3CjMr44n8UFdH2hohFncwAYaKgul0SYSwKdLZE6FX0De+ZFSd+
         JB2EbRVMANbWbH1pWt04LbyQbYFFuEnUoPKi9zkeTsW2lSIIMYGdWGqDUDwfsr9hI0/z
         4qSxNl5tcnPuCWXsz0x8KyGtWMmA9aRjdXYdhLgA515X0b1LIeI/O3ZK1hYO6wJZlusw
         1Ty1GguPRfLfTYiiQ1VOLrejyqtfFj7SjvwH6vtUC9WMRH1/wf9G9nZAO7gLUgTHwvLw
         3rsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
        fh=542ee+Y68t07BCjDGk01OlcRXM1G2wBRBbkDvnrpNls=;
        b=TA67waWIMXkKyy7VFdFyWCdm6l+TB2J6oDEffVpHwV6++92+vosUaf6qWfLt9GLLlg
         Ot4zzfOLX9KgiMX1RnVTm4+xx19ZgK+n20OanXRGi5QD2zl/bFjD/quQhpDuh5ZhktrE
         WmmfAB9LH/+grQtq5cL/t9xKNZfbhhpAQKIjpTSF8sv2+2seao3S4qBM81m5WHrMcGXv
         sL13lW2aATWhqvakjCVs0y0Gn2E6YCpq+ARk7JzxsBCOydOjjBmgMk4q6fCR47gmXD53
         g31TlKnjq3cHNYlBEiKnqyFycf17LMq5s8w/W9wTzYk7/7qGjejSeNu2m5uJ4RiIihnt
         12OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308116; x=1794912916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
        b=iGLOvKGPL228gMU6kednwrmkWHMzhMweiF54OAKArGCKzEyXK/cFBS7wycFEGnvPjc
         APY6t0VFszvzVPgTerB5SjY6zvioZnMy6i0SyscAlXhBa12w4ZJutOHQWN+Zlg70/WWb
         bP23/GBEtwzp31gQU3mclAltD8hxVV7D2LI78UCY4IyTXchVrQnDowoWrQQhhxZbKdN+
         WVGyOZbEbp2Sgq14d4+0nX7vsU8sLADQNcciKFy3lZc8scYRwoVJVkcpMLrw6IcHKILo
         b8sYJVoGAIyDCXVGTKDhVmSsp+peIQrZ+QJQPm1PyANJQc9mzjQboo6bOC2wb1S3kL6q
         2OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308116; x=1794912916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uw+TYYaFouM8/NevocjevDeESMBzwVaeMMcXfxyfB8Y=;
        b=ALZsdNLXE1eRpArPPsb8ebkviRvVwkvxeiJv9FFQipjBb8+kJN2u1SlcL2DDZBpGyk
         TEeuLjkruIcGy9eifdvaNWQgRb2h8XENCvyD6C9UTDClXIRZOfd4MsM5ILHti6990diB
         U7wBqB+qIailGKmRdOuSC34jzJPhRbNJsUMCUJ90l0ayr50ZHUuCQYygLkqU+kxxwZN2
         AdBdTkQSdHMRO+Vmt6FuOWdaNA6tUfsdyEC0DFwOTMC+J1QsZT1Ald7CAJUtKsmZhIrG
         ZqSfu13fpry9MrozaipJqPKU5Tx9FbrLBX9Lpw4A1u5ln/riskVMjFmR730BsCddfB67
         0EzA==
X-Forwarded-Encrypted: i=1; AL+hErFFcWwTs1qHChtBkjsV6lTA7UIaQaMvpc0Gh7ZrtL8ghjchKAMYRxmXGLdv9fGl79Qs27u5DMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LYrhjmHgW/3yJq3HQ5/pEV/ZusMq/kR9HjHPDWEtHIYfFWRCw
	kaYXjLvNvJ4LEDPEeUA9PrXPMkTq6obkb7EltCWBCBhP+1iBPv+ueu6FlUuNtP4NWOl/uQ+9LGq
	AiBnxrU8xxFYkYFiiInPV+Gg+hh3ZdN6jR/CNwD7GCq3DJOo/jmspsG67TIZvzbXAszHF3j8wNs
	+EVDVqivNUEkGI/+ek9zGa7ShKwb+f3ij/Sw==
X-Gm-Gg: AYBFou28E5ZL5eg46+h/XF7bmY172dXndFOcA9fVGSoL7cbOnUZuBDd7uPSUZgJyk9M
	QOyTDaQ+f8I9553eIXc6X7PFyp260gRtQQMdF8Y8tMWxG4iYLBMIZiWgYhziQxXGff/2YNvXUo9
	UxgZaPCIwRF0owDDSBaRwCVHpQI9hQBkCMS2DroavNpmdE5qiJRodkn3X+ng==
X-Received: by 2002:a17:90b:164c:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b166c84952mr2169238a91.10.1794308116381;
        Tue, 10 Nov 2026 02:55:16 -0800 (PST)
X-Received: by 2002:a17:90b:164c:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3b166c84952mr2169224a91.10.1794308115925; Tue, 10 Nov 2026
 02:55:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005131923.291619-1-nils@buechner.me>
In-Reply-To: <20261005131923.291619-1-nils@buechner.me>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:55:03 +0100
X-Gm-Features: AclHuK_HV3ZZmq-KfeYfcuWg-ilNBvuN8Akbycq_to22pxvhsiankk74K8OHQ30
Message-ID: <CAPx+jO8KitFsFdDFfza5WTZGwVzOOtB+Agr=qKESHf=54q10Ow@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: mt8183: Fix silent audio from
 premature sync_state
To: =?UTF-8?Q?Nils_B=C3=BCchner?= <nils@buechner.me>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX3G0cOLulV3lg
 37ztaiHJZunz4WoNLKXB8b3CKu131DkGVw3eB3OCF+g2sA9KQnLIu8ic1XD9XXiJ0O2XMQHjvl7
 Pqqfwzf7BEkabT8JOxYBJ08JYCcPe/BkhsuR1CXLOBC40soLNerqiGLsRJPBGdqkrdxWGggC4D9
 7YgfmdD2shgl5jLDqoIHU2Pm2K5HwnLZmz4KTwFj0cUVySHycC8bMhA8KOm115u0TzIooUS54q6
 VJPDhVzOQxZgML8JV4HM8tWF4SnaLvLVjxYdGYi4MBTYBgUOOmuuP+8GiC46PaKRTZDXlbWeEst
 3gufVYiGyIVJrWuGVBadKbZ5M3XRfKOmXohbqr1mhNzvX6hVOJeXK2LCWLDm7qmhtDi4vHlXsCN
 DAeY3gIGi7uhW33iZV8yZN0Y4cz6L4a8Av20IG1qXNZNQXDIfth6PoMrHRERSWxS5NF31TscRpV
 DhuI0LeP/KNM4bx+MgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX432ratTnezpH
 OohRxqTtzSsoNggnEcfricHnpT2FTrBph0nQ6/PmWL8xpeFfVFrJp7PWhijE/FmFaRQSySLI94i
 pnghZojWfFZvTk4xCTwFjZTDlshIKao=
X-Proofpoint-GUID: cNwE-tkJBBbEm3XHULVdZEEux_f-nD68
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2f815 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=byjLVS86Mrn06biGc8YA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: cNwE-tkJBBbEm3XHULVdZEEux_f-nD68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100043

On Mon, Oct 5, 2026 at 3:19=E2=80=AFPM Nils B=C3=BCchner <nils@buechner.me>=
 wrote:
>
> Commit 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until
> sync_state") made genpd trust that a power domain already on at probe
> time is correctly, fully initialized, and stopped forcing a real
> power-off/power-on cycle for it until the devicetree provider's
> sync_state() callback fires.
>
> On the Juniper board (Acer Chromebook Spin 311, MT8183), the firmware
> leaves the audio power domain in exactly this misleading state: genpd
> reports it as on, so this new behavior never runs the real hardware
> sequencing in scpsys_power_on() that clears the domain's AXI bus
> protection. Register access to the AFE block over APB keeps working
> normally, giving no obvious sign anything is wrong, but the memif DMA
> engine's own bus transactions silently never complete: its current-
> position register stays frozen at the value it was reset to, the
> period-elapsed interrupt is never raised, and ALSA playback fails with
> -EIO. The net effect is silent internal speakers on every boot.
>
> This is the same class of problem already fixed for the MFG/GPU
> domains in commit 818d56ac1d ("pmdomain: mediatek: Fix mt8183 hang on
> boot"), which does not cover the audio domain. Apply the identical,
> already-reviewed fix here: MTK_SCPD_KEEP_DEFAULT_OFF makes genpd start
> the domain in GENPD_STATE_OFF instead of trusting the bootloader's
> "on" state, so the AFE driver's own first pm_runtime resume triggers a
> genuine power-on transition and actually runs the bus-protection
> clear.
>
> Root-caused with a git bisect across released kernel versions on real
> Juniper hardware (audio works on v6.6, fails from v6.16 onward),
> narrowing the regression down to this exact commit, and confirmed
> fixed with speaker-test playback after applying this change.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sy=
nc_state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nils B=C3=BCchner <nils@buechner.me>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mt8183-pm-domains.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdo=
main/mediatek/mt8183-pm-domains.h
> index 5e33b8628..8e29e5117 100644
> --- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
> @@ -22,6 +22,15 @@ static const struct scpsys_domain_data scpsys_domain_d=
ata_mt8183[] =3D {
>                 .pwr_sta2nd_offs =3D 0x0184,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> +               /*
> +                * Depending on firmware, the audio domain may be left
> +                * partially on at boot, with genpd detecting it as on wh=
en
> +                * it isn't fully initialized. Force a real off/on cycle
> +                * instead of trusting that state, same as the MFG domain=
s
> +                * in commit 818d56ac1d ("pmdomain: mediatek: Fix mt8183
> +                * hang on boot").
> +                */
> +               .caps =3D MTK_SCPD_KEEP_DEFAULT_OFF,
>         },
>         [MT8183_POWER_DOMAIN_CONN] =3D {
>                 .name =3D "conn",
> --
> 2.53.0
>
