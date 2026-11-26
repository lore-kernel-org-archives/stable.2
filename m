Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795711894;
	b=n8/ZiSYIDNPyzGFbdFaegzpM+E4xx2iDvcJayVEf/Hg2SrXfbsaG5J/1m0gqjvUxmes2
	 dwdnKUkg2FUE9feZdubD4s2FxA3P1c+nCtX0NHb1lUrABaF/fACluBOpND61cwQJf537a
	 XEqaSG+vRpHfxgkr42AlvYa4stMfy7bblVfWcyGJTzTcXhWnH/OoxbwW30D3W7ajZfh1b
	 ZXRRa56O3gS7cJD3ISSLPHXNR1gC3yBVX68Kj5rdKduIdGA2l22WynXTu7Wa9ZEcTXfJP
	 L3jU771VEv7nMgir2X0Vj4AVM0F1AWftlb6CpuyzD+e0Hl/+PL0cQudESFyf/WBtsPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711894;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
	b=3QEhXOAp2wiuZj5jMKQ+hQjHzQBTETKWzYSQ/4RvL0DKYMm3X3M3v2di+1fGo8ncIEEx
	 ZKj2bInB19r9wfY6TIz+gDvZlM1zjuxf/btaZCX5wsfIiobixP5VFV4m6L+CwX+xK6Wqi
	 0uYFZBTuQZ2dubMjOLz5VB9SgCecKL3mUWYhJG7ipiUzIQFGzghzT5ZvyzN/DUSsVRuzj
	 W1RZ18dkp1G4hSrPJvj81j9Wnng3P75+4C6gXVkilIcrN4PgNPJpm/9FFSMcGYTCcaFoz
	 PufB2+JNWIEnZ8ynJaJv7QrcMnQH2npvJSbh4J3OGRShkDjsiOgyGfKg1HRFprUhhqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LN8w68kC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MM8HQdIp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB3606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEBB3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LN8w68kC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MM8HQdIp
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQGbw21595607
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=; b=LN8w68kCprRpgF05
	kJDoNtvjfd4aAUxe9bIeSOxX88cccqH0S0YCVlika7aERAmDsO8j3AmIdt3eEbqV
	e+OKwkZNPHQ579sxl6c5y+7iQypvPsXf9R25964wlGy2noNoKhzruXSdor7sDVcJ
	JNnx38dYK3oc89yFYC9jnumXhtRoccPim6YC2Tnj03L3WXmr0IYMM+wStPc1L7ey
	suNC8+bvVwvs9qvsyyT1ddQzK5ux3eFleUZ37cmeuguxY0d358hTse4amoa8Kt2x
	NqsubbxpPW172KRqtootduOnp2JoCEewC+LbdOLwW8OQ2CrI3V3v1G35OOGqtf52
	X27YgQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf901nq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b4139b7abcso6284122a91.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795711892; cv=none;
        d=google.com; s=arc-20260327;
        b=KQhD0GgyomeNUCOtkOd5V+UJ3alHOuYPfG9Xcqpj36sYz7cnHWowiCb0LuWlu3ZAkT
         WLAYPJ7HCz9e9o18eFnbdJj6yBZdJzIzOJTId1fSD4RQnRlO6eDA/hQ/cgpnHj7XPnCi
         YLEOmBIdv8HxsAbiQ5V40YgNsxaE5mETXYyvr39PoWu6N9M1mDlcqCmMXEf0TnHq2gcw
         Ql6BBOZHZa7noGCImNTULwEEp3JZ3sdEetMzTfFA9W7jwWBKW3uOwYoxZK0iSF89F3MV
         gZCfLqkn1bMdOZxjO+d3K74Ew346pqDsmxsg0so9SchtbDYHLXJdHFkow7gud/J42dwg
         Pj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
        fh=7JiRyJjys1tgtGdA0AgLtexbGIZn9isguVNS7aNVJ7k=;
        b=aQOaCIEfqAMlTA6IIrSQq40Ah/CHIuRMmfRMv8F4SXv999kKfAajGM/g6BgbSKN3+p
         8kTtnV5sEmWXgmoq/m4aHYg9ZR/KuMzTNvtf8sgN5kCADtNjlQhamBC44lNWTFwCrQEh
         y8E+liPt7rbibbzN36Zy5x7Ywo0kvhEAqClDaNADb43XcQByE8Mqhf/P1pIGT25uZ0W5
         npDfJrO5Gg5voIf3aUOqj92+KFsEtm/nyAuHTKetB75emjQfFaGU8N/b6pMjmeZJaz4W
         zqKFQNKXwOJH1u174zjLGenBdiBL7uABvdjwpEJm+LVaAsnyP54vTyRFeSIe35qak1Mk
         /11g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795711892; x=1796316692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
        b=MM8HQdIpqb5+ZCZcU8fme6VsNf+G6M2cQWwR97jYknUCZ/jYarYxJbTsnvExhZEy2y
         //dneQmJ8a6yAOcvgaXsCfLRO0HA8rnf5xUZsZcpYdnU7xi7ysCJkFGl7opOoGBVnCsT
         HYPSEpCJ1w5QuXbpQBbF6Tf1cR/VdAPhTtBhmK/S+wTJXhHrhoiKN4Jy6hp6Tob8VxJh
         4NJeWkZsbDs/o0ij7oq8WdbBZsNG+D1nq0d95KuD7RldjJGpOEjrrmtunE5H2FIPw/x5
         /Py1Yf6IIZjUYruRA+M2v8bslYgEEW5jlHL/jTJXbNq7LQ7xIZxGxNN+kI6iPc4wRvE/
         AWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711892; x=1796316692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
        b=CrkSg0AVacrgqXxakeEL6Y3R7gyN5bK3NMjWRvCvaKAeZPa80R2nffMCf694bqjuw8
         CvVu/27RCAMzgIL2BVyZiI34Bp8I4mERiI2DxkbLuvlLugY4ych1UiGafDzGQw4ZAQPW
         rFoqTXZvB16h0NTD9tITXTHBACnZgCCGky+j9/v25KFH3Ra/gWNmPDHcdw48Zn2guv0z
         KeVWqrvif1oMMUKuyCXr4dv+PpXbpnj/AiCtRyMDEVuo3/UPQBYjZUCTYIZxxlbmaf6d
         R3vUzKf8ohcwANpHsd9Gb7ZKGZOsuMpIkY5Ee+aXIFmpD6aQRo7HIZ6UvETplEeKqPmS
         HAzg==
X-Forwarded-Encrypted: i=1; AL+hErE1hHrNPWpgN+JD317p6MjVzA0J/soLy1Vu8M0+0VhlYXpy1TzC1Q1EXNc8Ji1xrKHS02aUkr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/F4pxuacFuY6PSUdOaIzeDV1OJGo/kuMz9eFqo5j5vxQqc1Xv5
	cPkepG2giuPnf9sxuY4WrUbrkPzRV9Dxm8sKO1+2N4IKRfUbPAC9J4EatdRn8h89vsZ8rclcZEu
	Y/jDRVkx/hwKWXgUAnqZ24/+5LAWcA3kWycx9ImN+/Qdu6Wu8OY752Ype/H1z6nrAXiDEI5lo93
	8Ettt9mvllpmfjQCffWdROjs06Ucnu88bDpw==
X-Gm-Gg: AZFdTZdrjYsGfI1ZjWnI9LuSjBh/RrWC/KAylUOi/DgVPkS+bpV1GC+XdasgBQoBouh
	73LiD3VdDNFOHisqp0UXbEJLcvjAVs5ddu9Di0fPOrpWcrMxO8a9n4jakJChDkDvufww86IWwYk
	iswPlliBMBI/TfTEHiatOvNF319YXuGTWCnc2piCwTDLudF3jYNCTBko7Mrw==
X-Received: by 2002:a17:90b:50:b0:3b0:b35e:b373 with SMTP id 98e67ed59e1d1-3b41c7c2378mr21122799a91.4.1795711892219;
        Thu, 26 Nov 2026 08:51:32 -0800 (PST)
X-Received: by 2002:a17:90b:50:b0:3b0:b35e:b373 with SMTP id
 98e67ed59e1d1-3b41c7c2378mr21122785a91.4.1795711891756; Thu, 26 Nov 2026
 08:51:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com>
In-Reply-To: <20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 17:51:18 +0100
X-Gm-Features: Aa3M54o4VHeMYCpg2TuAN6_-LjxGTu6SJHr08jR0_SBLE_JPiTPSxML96L7j05o
Message-ID: <CAPx+jO_V7f69HU+8r7thJW6xvUc75zsaWamHc9+L1Wsh8vyU6Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: reset and restore SDMMC state on system resume
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@nabladev.com>, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 9s-di1V_0F7RgbAiLOlXt_zAvLqPwiYn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2NiBTYWx0ZWRfX9cQ+BAYzlPft
 QMK0m2xgc5TbnuzdTsafBo9bvhJJ5Ca4azkZ3WLB27weKWwU4yfbOWJ6d4D8hTLiKKs3kAX4/O7
 0jKX4wXW8XmfLLSE8TN1TwEoq3dFaTxtqSAMH29yNc2hpCBQcMToaOTbMfh74oMoraQLBFW6WIg
 LRHzxWiekd6fbUbYVfd+e+z5HakmkK5iKLlpt1jp/EuyfTtC5GgXmrNW00yEECiDcJ2dsR93zLw
 /EmdQDeh+L+jMB0xEyaIlMUqVGKaBiYHzekjzIydc5/vwhev/8eE+Lbg+Ros1KGwA+KPZlJpNAi
 geKC+nQL2wEzxShPs1UX2LLjNqftxCBb265c52+owJpwI0CXlIt8mo1QdXPGNJsPe5Hm+D96Wup
 soCYnkp5ByF67HjBeJilLEIHkRlxhriHwSedQhHIAua39gCbWFS1lICcCqN2ry12AEATd4UVQSL
 pi4IxJnk6JMa4qa34Yw==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b086395 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8
 a=ecHELK-FIlHdQtvxNqoA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2NiBTYWx0ZWRfX3E+E8JrGwXzk
 Dy6YNAiUh/B5iP6tgxnxtDUsVPGiKx+Ma4sAENRuvuqqcqsAR0qBU5tbtZ8T5QvqT3HuAP3vK9v
 gS1/DcUUMxoe0xm82HrjpEwjnKgKVoA=
X-Proofpoint-GUID: 9s-di1V_0F7RgbAiLOlXt_zAvLqPwiYn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260066

On Fri, Nov 13, 2026 at 5:36=E2=80=AFPM Christophe Kerello
<christophe.kerello@foss.st.com> wrote:
>
> On standby exit, the bootrom may reuse the SDMMC instance used as boot
> device, leaving the IP in a state not known by Linux.
>
> STM32 variants do not set pwrreg_nopower, so MMCICLOCK, MMCIDATACTRL and
> MMCIPOWER are neither saved nor restored by mmci_save()/mmci_restore():
> their content is expected to be retained by the hardware.
>
> Add a reset_on_resume variant flag. When set, and if the card is powered
> off and a reset line is available, reset the IP on system resume and
> restore the cached MMCICLOCK, MMCIDATACTRL and MMCIPOWER values.
>
> This is done from a .resume_noirq callback, so that mmci_irq() cannot run
> on a state left by the bootrom once device interrupts are re-enabled. It
> also runs before pm_runtime_force_resume(), which does not resume the
> device if it was already runtime suspended before system suspend. The
> clock is therefore enabled locally for the duration of the sequence.
> Clock and reset errors are reported to the PM core.
>
> Enable the flag for all STM32 SDMMC variants.
>
> Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 58 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/mmc/host/mmci.h |  4 ++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 5ecb4d0bdaa5..f5affe4fe1b2 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -278,6 +278,7 @@ static struct variant_data variant_stm32_sdmmc =3D {
>         .busy_detect            =3D true,
>         .busy_detect_flag       =3D MCI_STM32_BUSYD0,
>         .busy_detect_mask       =3D MCI_STM32_BUSYD0ENDMASK,
> +       .reset_on_resume        =3D true,
>         .init                   =3D sdmmc_variant_init,
>  };
>
> @@ -307,6 +308,7 @@ static struct variant_data variant_stm32_sdmmcv2 =3D =
{
>         .busy_detect            =3D true,
>         .busy_detect_flag       =3D MCI_STM32_BUSYD0,
>         .busy_detect_mask       =3D MCI_STM32_BUSYD0ENDMASK,
> +       .reset_on_resume        =3D true,
>         .init                   =3D sdmmc_variant_init,
>  };
>
> @@ -336,6 +338,7 @@ static struct variant_data variant_stm32_sdmmcv3 =3D =
{
>         .busy_detect            =3D true,
>         .busy_detect_flag       =3D MCI_STM32_BUSYD0,
>         .busy_detect_mask       =3D MCI_STM32_BUSYD0ENDMASK,
> +       .reset_on_resume        =3D true,
>         .init                   =3D sdmmc_variant_init,
>  };
>
> @@ -2586,8 +2589,63 @@ static int mmci_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> +static int mmci_reset_on_resume(struct mmci_host *host)
> +{
> +       struct device *dev =3D mmc_dev(host->mmc);
> +       unsigned long flags;
> +       int ret;
> +
> +       if (!host->variant->reset_on_resume || !host->rst ||
> +           host->mmc->ios.power_mode !=3D MMC_POWER_OFF)
> +               return 0;
> +
> +       ret =3D clk_prepare_enable(host->clk);
> +       if (ret) {
> +               dev_err(dev, "failed to enable clock: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D reset_control_assert(host->rst);
> +       if (ret) {
> +               dev_err(dev, "failed to assert reset: %d\n", ret);
> +               goto out;
> +       }
> +
> +       udelay(2);
> +
> +       ret =3D reset_control_deassert(host->rst);
> +       if (ret) {
> +               dev_err(dev, "failed to deassert reset: %d\n", ret);
> +               goto out;
> +       }
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       writel(host->clk_reg, host->base + MMCICLOCK);
> +       writel(host->datactrl_reg, host->base + MMCIDATACTRL);
> +       writel(host->pwr_reg, host->base + MMCIPOWER);
> +       mmci_reg_delay(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +out:
> +       clk_disable_unprepare(host->clk);
> +
> +       return ret;
> +}
> +
> +static int mmci_resume_noirq(struct device *dev)
> +{
> +       struct amba_device *adev =3D to_amba_device(dev);
> +       struct mmc_host *mmc =3D amba_get_drvdata(adev);
> +
> +       if (!mmc)
> +               return 0;
> +
> +       return mmci_reset_on_resume(mmc_priv(mmc));
> +}
> +
>  static const struct dev_pm_ops mmci_dev_pm_ops =3D {
>         SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_re=
sume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, mmci_resume_noirq)
>         RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
>  };
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 4d3647f9ec06..3a053e40d113 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -334,6 +334,9 @@ enum mmci_busy_state {
>   * @supports_sdio_irq: allow SD I/O card to interrupt the host
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>   * @dma_flow_controller: use peripheral as flow controller for DMA.
> + * @reset_on_resume: on system resume, if the card is powered off, reset=
 the
> + *                  IP and restore MMCICLOCK, MMCIDATACTRL and MMCIPOWER=
, as
> + *                  the IP may have been used by a bootloader or the boo=
trom.
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -382,6 +385,7 @@ struct variant_data {
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
>         bool                    dma_flow_controller;
> +       bool                    reset_on_resume;
>         void (*init)(struct mmci_host *host);
>  };
>
>
> ---
> base-commit: d2616724e01132376c78872b8324f38659af9f28
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git nex=
t
> change-id: 20261113-fix-resume-reset-9bb5714fd505
>
> Best regards,
> --
> Christophe Kerello <christophe.kerello@foss.st.com>
>
