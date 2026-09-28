Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545826158B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612045; cv=pass; b=BX04Eclhvstsc8rPcuFyfOWl7sT2tACV6K7cJku8KL8CmuZ+KxDKnaUjHrCdO8Jph1avLoicrqYbGcE99FDofd1t7d0tiZ1migKk1tSwOGlqk/TSy2Ic5f1gTyb8OIz99q+XeH8Ceqjv1tbq5PFSWoNBuQj63FqSrEOW5IxplgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612045; c=relaxed/simple;
	bh=O2sFKAuF5fVE5ExBFOL5OtEIQbF/L5JdHgY1Jitui3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuw/7rXk9Z/HysE5a+/UtxZ5jdhX4L2hmS0fF5NTK3sUw7B6FgTdXDarnU2dejjrD/AyoCWBXWREjNaPFimdnKkuaP+iLJws6VqbjfR8C5we8IkRudIfTDWzW/nttSbP5KavEF1ABnOTV5odRnK/0MLp7U0a7Gy3bcs5X1IOpqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o19Zj+Wb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XyXfxTar; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o19Zj+Wb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XyXfxTar"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEeTqw941347
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=; b=o19Zj+WboEj2hdUE
	d11OpV//dI27/CZdeE5WhWtVeBRlIPaP9AklCVrSatIyXPIbdgAMOHpGme1MV9ck
	QfemR7xpxU8mZMQgyESMyP61U4wjoinL/kqV/Bwn6iyDE8Mg2nbTaUynK2hpMfJq
	tF9CrhTxa8HpV8I8Gr53sQZbcjuLGm0BF4aLcEA9Yl+GdKClq8nU8bk2lA0+pwL1
	O2YGvlypV1p1pBJRVeN5LnW1M74nXlEQsXEfnYcr04xDYR5H5mS4tf1RGieN0OZH
	j/EU2XUyEJ+987dGZ6S/sbKYRN7lf5AIgA7S4jW9wXn95GbzkeONt/dePyr8LQWd
	h+v0Cg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt12bd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so3124643a91.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612033; cv=none;
        d=google.com; s=arc-20260327;
        b=Etz4DbkkEHJZ6YDFV2QdiT4K9ngn/rzDdrRScl8TI0hbCy4ccsSN1nZPuOTw1sB4Ih
         5vquIWSs/q97XLwdNg619Qu423ICRwS3bevOUoM6JW464gkjEtU1eySrFDsBdFf+VZ/g
         PEM4k6Wu/YbDPVJrwfUu1c09IF/Ejnjlbql1NEjaLSwRE4lPQDFqdNtJgcLvrEb6YHrZ
         DYYzfOM9QDoTbOua7UDboYD2CYmH7uO52FsCV8lG0hl8UtutFgzb9fLfxxT6kutwOd2t
         cNQXwp9AzQtBVEhtg+ytgdXkC6cA67mUd4Z+wqNT761Jw1VltonDESGwJ4k7Q6aXgg8X
         McHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=;
        fh=wiUrf1WLSHFVCQ77Fqc2tjdSr5iwcIueDuJWMWOchm0=;
        b=JuIVkEQ/ftjxj8FPNXTyYX29/K47yu7wn6FeSiYO/SsWn++OrnDZ6SS0aKrFPEYiPE
         06CNXQUeSAUHGdh4nvudEgtfZm5V7jVNT0wRRVYFH/WfreTPMcURwYbifUAvOpxm+0+l
         Tabodk6Pq4qTSHh9CYvkwmVlm/0LTfdh4qcs1REdneJ09dERUuSD7Q50mrnq0J6YeZvZ
         mb76YqfKO4M5hlAmU9mr9wHe+XHVToMQXDAyf7GBz/E8guOI8XF6hZB5FimYnEUtVKxP
         TvZIh1NxJy0FYytUfNq+clYHDs3M5v5qU4wNAHyV7mT+P2F2J35v024Y5vipJdNqxPZc
         lhwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612033; x=1791216833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=;
        b=XyXfxTar+O6Ev4D2uWFEfqgfHKRMu40bvMNJOODprTY9b6kiF2JCXODKI8lr1ydDSa
         IN+8H7hbCNyEZD71ZQYlk+gWkfN/qHqX8ONatYo8yvSBPMIR85UDDW+XCtGAK2WYeQYD
         O1G++0Y2XtC//na9t+IcMzcS6svA8eUDV0a2nexCKl2hSSnw+H6SsF6c+61WEafbHSLK
         MhdbqKrrF1N8xS0U5Sfjg9BCY+jV0knha58A5kyIpj52TuIQwSppwFNRW2xkXvJE7mvn
         Yhw0X0FdvF5BeVDWpmXm3PxlziuwQQSnMP+ztU5ZxwW3vyOMA9M4riwwG295uJuCrbSr
         Fceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612033; x=1791216833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jnfYONFNsW41daTLG7twN5DndyUQVqOidHbzZNq5TCU=;
        b=R62a+EyEH1yhUK54n+D/QTLrNzawho/UoqyhcYfCjdr9tFpJ+gfzDr8oExwkMI9Za5
         WaDtj2YtV5oImD/RjG8QSCJ9eo72RJIvTcwvWK/mAZsxSBmZJlm34Y221xlXKdXQLm/e
         H3cdLzGUMR61goWlRy/09i4cpyI+QXmMk8RXoBn19W6or/Auugxy9f0lp9cHqj6LTDsm
         lh3+GHbZVvY7NwbQHYVmDOKWwsttgE+hDYfC0dUEiP42cuSq1Ya+bCAguOcXXQckzRnS
         552gv8bu54FmNzXba0Ok4lMzC//TcP9S1ZO245wtMdLak2Vw8aLb1EKOEYjWYL5zIDeR
         9bQg==
X-Forwarded-Encrypted: i=1; AKwUvByvyACgLaHYmYYcqglrYY0B/dgOE9kO5F5ts251PGvormzxMnEnL7u7LUTGF1zDU5dsmPQhwxg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsZ12LU0+scjU9E0tvw7kvtEsQpyvwTaveETTg55ZygiCpF1bh
	gj52w+Lz+xKcoDHEhJkqkW0YgB4sv4g6+D3xo2B2trpaUCdeu/YKtNrB3oWZxRS/YiOCtbYkxof
	nAz9ZBLLe4n6TpAgyFSd4bHj+qXZhYpEMNtA3Sd20OrfWLj+2ufQ2WbDzwtDHBHYYjL5IjjVzSy
	p8/DqYJ9i3fmDckGELKnv+q/lnBSZzYLHvfA==
X-Gm-Gg: AYBFou2YvhopBJvbsA1eD782kGFxYgxxJD46d4stBhkDD/3grwtifVvnRDzBRkkbrh7
	VLd0/DrLryZKHrED8kqndMwLUNEUXb5Pgp+6p8MUaygSEb64cZRdkyztX8dthQN0GACR8JAh9fo
	5AseSXu7JPiC6ldMvrQ/IwSXJsUMu1FUGJ7y41UX4qaMhLF4HXxcpCA2B7XA==
X-Received: by 2002:a17:90b:3901:b0:3a0:80d1:28c7 with SMTP id 98e67ed59e1d1-3a098d508f7mr11230394a91.62.1790612032573;
        Mon, 28 Sep 2026 09:13:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3901:b0:3a0:80d1:28c7 with SMTP id
 98e67ed59e1d1-3a098d508f7mr11230361a91.62.1790612031984; Mon, 28 Sep 2026
 09:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915161310.2477406-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915161310.2477406-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:40 +0200
X-Gm-Features: AclHuK_-RQJmDvLec1TfEk7xn7z5cIpkgIWKnhqPUSU3rlslCjBnluxRdv8jcNw
Message-ID: <CAPx+jO9GY+35DSuRB1jTa7C4SQuAaoZTtJirFfykrDM-7bAmeA@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: destroy slot platform devices on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Robert Richter <rric@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jan Glauber <jan.glauber@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX2N/te4sFxdH2
 taFSM70zOfCwmmI+Dn1/iOo0TjXWupGSwD2VEkji6xkr5+tFApmv7qMby0zyGZXYHRVVEij5RLL
 jhaQJm7jjuufnTGrhML2HlwGH4WKl5yNssm07PSweFCmQqFGcNfJADtSRmXhI+cTq+L9v0QWseF
 sL/6th4VDLUqkGJVpQehCCz7EaBJcRwRqfOeqGWEvG7tK9r4daE+xl4+5tdgz4ccPv3sINDRKsY
 7jJAo+DGdPLuByiJ1uEVrdJ/uQviuGo3Yg9ClkgThAP6VOegGZS/UUUUR0GWD53Idas4AmbT9z/
 7vI3al2NUM9paBqjrKjS+Epc4OEJV9QddgywOCCm7beMwCN40HjpZoTrLPjdS7Uxr1b1xiJMa8Y
 amqQEkzOhZbFEUOdvXxF6fTo4F8eFHU9aOo3zzVcP0nqwtW05l0IDWaVeAZn0HRjB10fRiSEmSJ
 xhSO0W3jEeb5DNPLkyw==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba9241 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=OJTvEzr-pr90GyvokQgA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Qt4euU1t1x2L96MjuaoFsjwcBBKLtzBp
X-Proofpoint-GUID: Qt4euU1t1x2L96MjuaoFsjwcBBKLtzBp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX0b4b6kIhlbXQ
 rrXw8sUbhYLSrHdbblWNx/DINuTW8wg8J+a+KYlFxD44DbwZvqDF4d6RH7OWmiTgKGHc/QsZ2t0
 q3riyNMFPLC5PAjLwBbWWbriAh2OmNY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 6:29=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> thunder_mmc_probe() creates host->slot_pdev[i] with
> of_platform_device_create(), while thunder_mmc_remove() does not destroy
> the child platform devices.
>
> The probe failure path removes each MMC slot and destroys its associated
> platform device, but the normal remove path only removes the MMC slot.
> As a result, the child platform devices remain registered after the
> ThunderX MMC controller is removed.
>
> Destroy each slot platform device during removal after cleaning up the
> corresponding MMC slot, matching the probe failure cleanup path. Keep an
> extra device reference around of_platform_device_destroy() as done in
> the existing error path.
>
> This issue was found by manual code inspection.
>
> Fixes: 166bac38c3c56 ("mmc: cavium: Add MMC PCI driver for ThunderX SOCs"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, though by dropping the redundant calls to
get|put_device(), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-thunderx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium=
-thunderx.c
> index 84ff6d82ae3c..c80907aaf51b 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -173,9 +173,15 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
>         u64 dma_cfg;
>         int i;
>
> -       for (i =3D 0; i < CAVIUM_MAX_MMC; i++)
> +       for (i =3D 0; i < CAVIUM_MAX_MMC; i++) {
>                 if (host->slot[i])
>                         cvm_mmc_of_slot_remove(host->slot[i]);
> +               if (host->slot_pdev[i]) {
> +                       get_device(&host->slot_pdev[i]->dev);
> +                       of_platform_device_destroy(&host->slot_pdev[i]->d=
ev, NULL);
> +                       put_device(&host->slot_pdev[i]->dev);
> +               }
> +       }
>
>         dma_cfg =3D readq(host->dma_base + MIO_EMM_DMA_CFG(host));
>         dma_cfg &=3D ~MIO_EMM_DMA_CFG_EN;
> --
> 2.43.0
>
