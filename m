Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207693;
	b=aR46h0sg8ycbdOD3tZl78OLhmJ2bEIubeIuTPkAZkOvJOxjlyty9exX5Q8UyVsIuq7y5
	 F73YaQGpOtazltLOTvbnHDqde5b9yBQfvTeBitHZg2F5JfoXn+ijULDdf6HqpQ3YQ7sl1
	 ObXDS5x+NeG5tdpzoEMwqF19SsxtwccxTjnDBKGFdXO0yD0zBuDzXeBDzioiCvh4NCtaa
	 Ew2RDP6o3jPTRYSWubrueoySNo0KSpTQx4Yh3F9ZTuC+ib4vJsYQyhMOfgecEM4TYK3NN
	 mAa2sly/9Hll+etepRwSnZc5yNlMoLN01ma9rfoUeef/FcG2YBSZI3GcaBQ6F/BUPsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207693;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
	b=PySIF14IlFPime+MYL0mdOrRVIhZU9ZW9azwvhu59U8MG4L9P4RcTgjIztQ3yeLWnI89
	 OMJLbIoTTEkeh1fXF+Jn8aXCJpsWcpXGEyW4qUV725H3gvCbwfRKGkv9V6MzF8Qk43g2c
	 J0Eqt0IiOTxO0Cuea5T8ZGt9eDjYYuo+8o8iTCN4u5IzX2wOams14sI27Q78q0tRRqKZE
	 K6X8NSs8R76FI6skDb8VQPI6puHv0m2EjCh8RnMaprDpeaudsHFX6ReFK3jfWT9Ne648T
	 3ui2OafW4dKZ0PK9sTHzpVorMQV7U1uywaJxYwzEy4tts19eWoGtxzVoa38paBS941A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="iRx/cHJz";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NarLSL3f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB39606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FB39606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iRx/cHJz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NarLSL3f
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA2FW2543159
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=; b=iRx/cHJzTqSXbnd1
	EW3bP32/wrfXEOSOuU77enf5hCUcTggU6ya/hrvzNSMUgjsuC6lXdTTgyhqlHwz2
	FWkwmhdMjw8VVKcjIEbzYxbPy8oanDTRhKZ2EGuSlvEHXm2Sev6VDKwfEcFiU0PQ
	7Yf/Jj+GOjTb26gUfTRKcg5bJ3iV7J9qkgE+X15PswAU5aSMqiqCPR3I77Zt0Gb/
	A4RTIe3B1dyoeNLI38LPq5QkwzYLzeQ8DMbZNwEYBnVjlWDsYSHtOhCDPg2MmO5J
	pixrbkq45iRF/3qnKtySL2l03ZHCv3QXtl80Je9mG/g2uwATw3lPF+BtbiKiy7rd
	nuHwGQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehrkad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:14:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so791294a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207692; cv=none;
        d=google.com; s=arc-20260327;
        b=mdXmN5PCR1Ar/1s8hFhMMzTCe/X5DZhWuya3MFq002AZ8o2JgpKT+d9VQInUMfeO5L
         eMibmOBZz0iA+NbWy1pWMzNhKHyZ+lgC6hGqaqEh0HP/223dIO1IoqVt92ng+E0WJD4B
         tTuMo5RuE/lvbH23lAHYORzjXOtup31FwZC7Ba3py5IRxC2G7hXQDdC/EF6MCGcu93gi
         t/kFIbi48sZInhZctgo1IcWz3AetGOBFUDcZBKiUGS4sB3bV8/VShTOkG1uvdFMDQtHe
         tatu23BmCjI19IRzELcchg9xPBMsmz5FTmx+asIWK4sTcKemBfvNINiQ4bgSQJnMaUtT
         I9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        fh=3AjPEaKdtxr/cxq5dSCj/Uf1mux2PpiDpcdbUBDo1/c=;
        b=FL54FdhDCWPT74JEJnfs+M0SKnXutdCTSiUuQAfhOqalH3uiPWtzDedYJ/sExry6yl
         HRD170rNnhirqQyxY7e7ZM39ta7xqIzjNfm6He2gdN54YHeFBKBh/9zLG9hh96LqLTIE
         cjmHgUZgmkMhg7xO4/oeu83r4eqlbsUUbAa41xXhpDBGH9Jk+Q8NgOeQnR7CfasExWt3
         NgIpXYU0F70ZnL9/LiIOqUPTx7O4crxiNf7ILu1KoeGsVvcU/S8kmSchwIl9xxsj+xCC
         Jmpr2ZNYC4bj5BNU2ePKg8Gdp7eTCAepac/cgI+1ZhGG5bWbLu/IchzNZE+D5sfn+tEO
         6dOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207692; x=1793812492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        b=NarLSL3fQSwvAx099tbHHoxIxEBj2QGMim9VohsnJNYB6ULicVUZxBD18+xAk70wY7
         +W4f54noecwrkJhWzeoVeC24EQcJNnwLYMlTyXOPyzTLSWQ9yCx/ur+VlC45E3K4JhBh
         bLbA83a5c+nTMfmFoPkF+WNy0bJte42r+iO94eIt55JcbUxzN4Ns9FFyurSQql1rHBBr
         0ogbdvqumyWsNUK64zGv6bcX+eyUMx6kwcpVDuLtWQ/F10yTatXj4LdMXoYLzvA5LbXz
         TOSsoo7sQQRbYrlG1H68l5Z8BbZqupsyujqrSen/7aYZd2pJeI7Qn/E/ztqSVX53pxeU
         qrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207692; x=1793812492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yS6+yqmCO/Z+9Hwxo+UG43eJfa5XgYXkK/nQJzs6W+o=;
        b=DbQRRtCAInWUGJUPdHwZSR24C7+0RS4vQmrUuBYEqyru5FgKumO4kHZ3DwiMEjbWZE
         pG2Rr2//K3N+tFshfARKpYNkc3F+IrIoqzpfTuS9Hwj+B0joLRcEEk0/GiUdSNDAuswZ
         0Pwf7iHqA9Mln8X8gPI7Q2zw6OUgG399P1Dkhn9rShLqEW0dzR3R9oa8kIGbl09RVtvp
         td8ruvc3rUc2Bp1yDoC5W1pAHcbU0pw6NX+tA7B2WBwmPnE4H9Vyi5Lj2urS9qvUjE+t
         bpKNsHUho/4d2LsG68jQOrRW6AM4LqkFiVgIvu9JyoW09mZW7qTLaq7OLfxhl91r+COR
         6e+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwho50zpgzUsRjnvqFypjnNLkgOTfhxKC7FZDCg0qcaOWD7mSV/5sY76e0bmf6IoeNLGsWmd2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgMFGQMtmjnpQPf6aa+kCghqfsrQ6zjnMm5NaE5ElH0lKTa0jG
	IgD9a9h3u2L41mr7gdBprf1sXewmtffB1XhPTLL0mlGH4s+BCbcjb4YtMepYCEJWai/bDtOYp2S
	gSVZT/IYO9XxrsH9OBTBhuzJVVoWC9CXB3bmVY8tDsysBpE2j70/ombtugLlStiSE82vXMSnUjN
	n35CQZ1BFFJLBQjaSrWVzQhGYdja+RsVP5kGX+Q/gQnA==
X-Gm-Gg: AYBFou3eKBglBz/vUrMEILPq5bD8bb/SoVLU4NZPECizh/ZiKZUmczV2YyzpvhROSz9
	r7BGKyFmPkkU448PFKKXxtWuwewp5oKlQFymaXxwHdX992azvkXQ/Z210hw/8I68ufpcoV+ZaYX
	12WM97MX7Vs4tMYilXXxH2sN3Ox/+4Pqx2iOZH3OLB87qLkdGlCxUygOnD2Q==
X-Received: by 2002:a05:6a21:4995:b0:3e1:a4ac:2d5b with SMTP id adf61e73a8af0-3e9023a615emr1998166637.41.1793207691786;
        Wed, 28 Oct 2026 10:14:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:4995:b0:3e1:a4ac:2d5b with SMTP id
 adf61e73a8af0-3e9023a615emr1998158637.41.1793207691380; Wed, 28 Oct 2026
 10:14:51 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:14:36 +0100
X-Gm-Features: AclHuK_ZWeAQi2Xa-B21F76suzhqXwNnsAdO0BsvOyeyMH6jBWqA5XunpZY6OxY
Message-ID: <CAPx+jO-9DXrH+b5Y_TMmiyydLTkCQcNZKrHEy39OK8iYkZ3JOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: synchronize clock timer before disabling fclk
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulfh@kernel.org>,
        linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: n0GHkAgO8A8eBysQKxRf3VvTrobB5JXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX6UxLS2/HVtSR
 EIZmAfnZoV4l6fIxzMbSCZpSNxgoPumMKBjbuX9RI52dK1lnY3STgUANQb/MNHcTzC3HEZlTdIb
 uG5INqheCm4wE3hoF6hni6XrViQ9lTS5KWmYpOweRGvN3w/dKoK0CU1OZ0hL8XRuVSIAlotYaDh
 vPntMB9G2S47Y47S3w09yhcHTSqlH68CbEekFwhWsbeAZm4K9HSoZO9bKsfTdDqB37hjTMSNTj+
 ONIN6WKP/RfNr8LSGYBZ5DU87jVd/EO/aUzMLcRY4Jz173vXlWllTlDReZ3dn6eNgTyq1TyaCGI
 NherkCL4HBkUduShlH1rl/r5iZfVn6XSRI9BdfdOs57STOX8fBgkoMBSwqwnRpwjyLMh//5qZbn
 T035WwdmK84vSOnQFhPcMSdaCBPyl3dWgaWL85dShQ7r/yYGDu6VWh0gr8cIoLQXpmMEZtkKnMg
 OrAA6VSHAZg4RvmWVjw==
X-Proofpoint-GUID: n0GHkAgO8A8eBysQKxRf3VvTrobB5JXI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX15ve3LKA7oGR
 3Rz3BmEiO+Wp0ndzd4BPziYcHM4q99j/YyFAQpE6x8hC7wcLgqSexWKlwEZiHozwQTeZOGlrVwz
 WpzJfJMYFTK9h0hw/IU+4VLa5GNTQMA=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae22d8c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=ywtp7fW4YtRplKC3Ii8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Tue, Sep 29, 2026 at 2:45=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> mmc_omap_select_slot() removes clk_timer with timer_delete() before
> switching slots and changing the functional clock state.  timer_delete()
> only removes a pending timer and does not wait for a callback that is
> already running.
>
> If mmc_omap_clk_timer() is already running, it can therefore call
> mmc_omap_fclk_enable() while the request or slot-switch path changes the
> same clock state.  During host removal, the same window can overlap the
> final clock shutdown.
>
> Use timer_delete_sync() so the callback has completed before slot switchi=
ng
> or changing the functional clock state.  Keep the timer restartable for
> normal request handling.
>
> Fixes: 0807a9b5739a ("MMC: OMAP: Lazy clock shutdown")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 527b89a5e..02d288e4e 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot=
 *slot, int claimed)
>         host->mmc =3D slot->mmc;
>         spin_unlock_irqrestore(&host->slot_lock, flags);
>  no_claim:
> -       timer_delete(&host->clk_timer);
> +       timer_delete_sync(&host->clk_timer);
>         if (host->current_slot !=3D slot || !claimed)
>                 mmc_omap_fclk_offdelay(host->current_slot);
>
> @@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slo=
t *slot, int clk_enabled)
>                 /* Keeps clock running for at least 8 cycles on valid fre=
q */
>                 mod_timer(&host->clk_timer, jiffies  + HZ/10);
>         else {
> -               timer_delete(&host->clk_timer);
> +               timer_delete_sync(&host->clk_timer);
>                 mmc_omap_fclk_offdelay(slot);
>                 mmc_omap_fclk_enable(host, 0);
>         }
> --
> 2.34.1
