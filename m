Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793268694;
	b=qJqZQbpkd2MkO+S5kE2EtqyQMXGHb1yV+LCwf+LiobKsORkcxA11K6NXL48a+M9+us+j
	 rI/hJtA/rl4cFoa2plcamUN7wq076xeb7j4vAgwPO44ubG4BiisavTdPkMYSLMddstkz5
	 C010a+FG48ZJxU0I9awFi+TijoFADmaifG1pjm4LRImQBnUGhfaWbV/fGipzoZcsRYlUx
	 egTWaVCQg4axGovBiZkXzl2+ODcatkPy05U8XAOIePSOexMqtQvoPW0DciGo0AcrQC4wa
	 J+NsZsFJlZYlAmpc5GhPhrMiaZRI2AtqOn/pBgXHx6YHhiPO9lB62U26SOVFEUyxkQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jgkJopx5kExqkUv6b/vCU6btPQBGSF/P3vuAWpTWJb4=;
	b=jX0nJ///LVXjEtg/QCmWC1s2VY73Zf91y77FLuZqrbLGWss7DvuO66XnmbmBOugWqYHQ
	 c+0Q/tLsRDZK4d17uSkwjPKsY5S9j0R5H8AvyBs8HtBBFEuFmofcfcioMueOja/n3eJXV
	 lIi+jwWKEZI7RZPKt2KXFjysAlobK8MlU7tsyS1nlWAlVhLFkCmteQQ6I+/qtY44YXeiO
	 3MkiS4F0aoQ/MeSHLBFJxyzVIhEe1yXvw8AIFPx6oh6qwLB3GscB2Q/OnaWr3R7TpjxZR
	 4KK7O0Emwr5gWIbaSsx6nCDW2bRDYt5dbp3101BP0ZAIrWC0AJNGmAo4qVh0hgAH+lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+uDtHfY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CECA606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CECA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+uDtHfY
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a18fc7a38so3919256eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793268693; cv=none;
        d=google.com; s=arc-20260327;
        b=rbU/petxxH4kj3OvsJ1ezDvTKXMH/3ti+7keD2ODoNiH+7ThiL3jeLIDJzjroVdRpI
         cvrV1Xqx27TDHzjHdMpFCOhTOB0ALw9AqqX3FO4GMj22yQ1UmyRDMFjUHEV1vrY7sIYH
         ivqcJ1TcTFFFvditW+dKzMk3RmgZKNg01dbXo0O6D1OtkjLgtkeoydfIWGZUK4b9eHNy
         hGX8UiMwbsZdxjZ8+d7ZOtZkJht10yKshKA8A7f6/EqbTMYJAToRE7wzXLWkx/m0QLPT
         ou+J2AI9zKequMlijX+proG/pvfJunmsAR/u92vIL920sFbI73hmAjxWqxTmbAv0svc9
         tblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jgkJopx5kExqkUv6b/vCU6btPQBGSF/P3vuAWpTWJb4=;
        fh=3DwsCSTw00cAnRe5ml2Odqxf9KGhcMEf6l5VcS8wT7Y=;
        b=UDyehWGXoM+D0AL2Ukuy69IawGnZBSryDfarC4wRFx/Rv9Fs4zm0/HXbY8O9ktribE
         cqXfnp3q3q3mRhqutuzURq+QhHR/kCBlWNrJGhBxKE6l0PYs8flfdf3WzJ3lojBtm2t2
         ZtgVSswxJTFAYlWB0SDJQWUGipxk5pAlI+i99tXsywViFRtmzAMj8YDgD7OMzSyEJ3KL
         nDAWuIxHdb3pI5MF6h6fWWWuQMLuK2aOwgCu3kIi+5jmN+bF/rh4FymUT/MA+Et32bNK
         XKdmBLzVsqOQmWvTfXuHX7P26QNyZS1i+q5qhRhQttAtPpKhnvE9fGON+y/bAp5Isilf
         Rf2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268693; x=1793873493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jgkJopx5kExqkUv6b/vCU6btPQBGSF/P3vuAWpTWJb4=;
        b=m+uDtHfYNrebraUeNO71Kwkxzuqpdu3zCHQC48XO/a+1chRZiH7mHXPDqLP8HQ2yiH
         Tr0GNTkJJBfuOJDO/AX4VaktcSnRFMWJDv5mItb9Db77+hvYsFIxDorsRWc563PDbMSC
         WFf/XcMi0JTg23ul4cIHTqnY3lIIPwrFyN6/bltmGyVtwoQ6kqzgzklFux4nuOjGKS+i
         tPeerm8onxx4BYHYLafWUxDHX2QG6ZEOT640AX6ke/L3iW4tOH5g27ApyIfQllKU9Y6G
         y8HuQZBr1vP3B3fbPuvMufo+5KSREll/cupagNW82ra5HvG1N466DCf/4msA6IkJseEM
         2HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268693; x=1793873493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgkJopx5kExqkUv6b/vCU6btPQBGSF/P3vuAWpTWJb4=;
        b=DNxoUZNEEcQaWEQQB6PtzAcMPInHWjf2R0sNRiANi/vY0mjaQG5lPzToCofsOrQ8Kl
         FznFLjS3M4fGGhXik/Pl899bJ3slPaQ3yFpw0kIyM87iDIhzDJnnyLQG5HEY9nxMPwCH
         F6A2DAEqMhLpbuKjh02dWdPMxl7TPEOh0+vBJmgdFDBRQYhOh+VyDP2diLJTh8qEkGhN
         66LbsC5GqA2CoiMvFqcnFZegxqZi/upc82jVJDol4IaKjAgeBhSOHumXIlHn7715AXGJ
         aqH76UI91+yLA6dcwNAsVNi5fEvnj29XKX6euPZ+9SFiP+u+NJlwtV5/jgnQq87Fk1hs
         9AWw==
X-Forwarded-Encrypted: i=1; AKwUvBwuur20PzmM0XMwjdWbOSxJKTWesk1PgkmpI3MRQUuXCZxVsBu6r/jKJRfZZza8d54E0r7wjG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjvfRuGwUFNhoovMCsE6feBd9uOCwpKJjB0dH7nbHqyASJcryY
	trvgh2kzA/7uknBAbqhMHTr3QmDsq9jKAJaLTpnJ99i9lQ9RU7NbA+qeCEnTftPDTn56NyfcWKX
	6nySN2PBNj2m/Ro+8C816fsTv8U8J4kw=
X-Gm-Gg: AYBFou3mNaTw4jB1jDMNZfI+HAK2VuFP0R1gkZDClIJ9IjgEEEBh5VUvcTPy9WJQ2A4
	7Wlf9U7Wi8fDdpytryeSuZQMRb1hgGLtajzjTnro/dYuNJMQIVuSBleHRPpMarmt10aR2+sjTSj
	qZ+6Iy1JuWOxYDcCO3DI9Ptmks+21fkPIevGcfbft2xxtj14C4NTpyfL+zdpbfw7DWlWY8O9RCK
	2yeI7aTxOUGwwCqqVZ/LKBvmxxglDzNEbm3em673tJtk35dWar0x+4rGPuVrvKlPNA/7ZjGGSLs
	yb8vrfUrJJiNTRxg/6ceRCF5Cx1j5Nc+7bYAJeCDIe5Q8Vjq7bXSNj6X862wlIwUGfd+ysDtP8P
	oZGFicDppg0EFhzdKt3myenO3DjEcdilBDuF10IsAQuYqHDFvXEChZoUCI/0iJtHcgfs3pQ==
X-Received: by 2002:a05:7301:618b:20b0:366:83dd:46f3 with SMTP id
 5a478bee46e88-36a20434490mr7778201eec.14.1793268693130; Thu, 29 Oct 2026
 03:11:33 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
 <20261029-upstream-speedo-t114-v1-1-81457cc9d94c@tsv-stahl-riesa.de>
In-Reply-To: <20261029-upstream-speedo-t114-v1-1-81457cc9d94c@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 29 Oct 2026 12:11:20 +0200
X-Gm-Features: AclHuK8_mii-vqm8jDLm-mNdMkH2Er6-ZHBho7KaLFga9WcAe3FyT06Xlc5Ki2w
Message-ID: <CAPVz0n3tFvEycAAhjA5ZqoBrx8MsJwDuBssAzLMrFnicSQ+eMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc/tegra: fuse: Fix Tegra114 speedo fuse offsets
To: admin@tsv-stahl-riesa.de
Cc: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 29 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:3=
3 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> tegra_fuse_read_early() takes offsets relative to the start of the fuse
> words at FUSE_BEGIN (0x100). When the fuse driver moved out of
> mach-tegra, the Tegra30 speedo code was converted to such offsets
> (FUSE_SPEEDO_CALIB_0 0x114 became 0x14), and the Tegra124 code uses
> them as well. The Tegra114 code kept the absolute offsets from the
> vendor kernel, so since then it reads the CPU and SoC speedo values and
> the A01 CPU2/3 fuses 0x100 bytes too far.
>
> On a Tegra Note 7 (Tegra114 A02, SKU 5) the fuses at the correct
> offsets 0x2c and 0x34 read 718 and 1156. That gives CPU speedo 1742 and
> SoC speedo 1156, which is exactly what the vendor kernel prints for this
> device. The current code reads 172094 and 0, and so reports SoC process
> 0 instead of 1.
>
> Today only the reported process IDs depend on these values, since the
> Tegra114 core OPPs are selected by the SoC speedo ID and the CPU DVFS
> tables apply to all process IDs. The CPU speedo value is needed,
> however, to compute correct CPU DFLL voltages, which the next patch
> fixes.
>
> Fixes: 783c8f4c8445 ("soc/tegra: Add efuse driver for Tegra")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/soc/tegra/fuse/speedo-tegra114.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra=
/fuse/speedo-tegra114.c
> index 6695702bdb4c..1e6c2b5be759 100644
> --- a/drivers/soc/tegra/fuse/speedo-tegra114.c
> +++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
> @@ -14,6 +14,11 @@
>  #define SOC_PROCESS_CORNERS    2
>  #define CPU_PROCESS_CORNERS    2
>
> +#define FUSE_CPU_SPEEDO_1      0x2c
> +#define FUSE_SOC_SPEEDO_0      0x34
> +#define FUSE_OPT_CPU23_DISABLE 0x16c
> +#define FUSE_OPT_CPU23_REENABLE        0x170
> +
>  enum {
>         THRESHOLD_INDEX_0,
>         THRESHOLD_INDEX_1,
> @@ -63,8 +68,8 @@ static void __init rev_sku_to_speedo_ids(struct tegra_s=
ku_info *sku_info,
>         }
>
>         if (rev =3D=3D TEGRA_REVISION_A01) {
> -               tmp =3D tegra_fuse_read_early(0x270) << 1;
> -               tmp |=3D tegra_fuse_read_early(0x26c);
> +               tmp =3D tegra_fuse_read_early(FUSE_OPT_CPU23_REENABLE) <<=
 1;
> +               tmp |=3D tegra_fuse_read_early(FUSE_OPT_CPU23_DISABLE);
>                 if (!tmp)
>                         sku_info->cpu_speedo_id =3D 0;
>         }
> @@ -84,8 +89,8 @@ void __init tegra114_init_speedo_data(struct tegra_sku_=
info *sku_info)
>
>         rev_sku_to_speedo_ids(sku_info, &threshold);
>
> -       cpu_speedo_val =3D tegra_fuse_read_early(0x12c) + 1024;
> -       soc_speedo_val =3D tegra_fuse_read_early(0x134);
> +       cpu_speedo_val =3D tegra_fuse_read_early(FUSE_CPU_SPEEDO_1) + 102=
4;
> +       soc_speedo_val =3D tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
>
>         for (i =3D 0; i < CPU_PROCESS_CORNERS; i++)
>                 if (cpu_speedo_val < cpu_process_speedos[threshold][i])
>
> --
> 2.56.0

Thanks!

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988)
and ASUS TF701T
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
