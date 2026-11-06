Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966831;
	b=PVtziReK/U+/KsKMQUMLnf3TIZxbb4hlFAPUTIj5dNsnA5fkunq0Om5l/SYy2Dv+2nls
	 NbBiVgzwXzGPb4m5DXsekJJcHYbQ6ZgQlH/q5e/rUQ7icRxHBJq0x2FDqqlO933/rc+Wb
	 pxhgrdZ3ycOBT5rledpHcI5hc66ivEPL5Xy21jo815mcyEsWzm86OBcU57D1ZqbhUG5oh
	 6f0RtvYVOqVA4Wc/3wcP/TDInKCzZaBNVAfg0uYdg+Qu5JrogFPBMP3LjMrXCd5ROSh2u
	 rC5IhxZrDIYdwKHxmKYiYqj+a5ZPlifSw+OUdyoyNj6+u+ouiChEDpqAnCmvjZxYenQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966831;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Content-Transfer-Encoding:
	 From:Mime-Version:Subject:Date:Message-Id:References:Cc:In-Reply-To:
	 To:X-Mailer;
	bh=/UbyUKw9omZVMKFc8o2t5RKh2+gHKfyA/9nJyAlqI4Q=;
	b=MZqm6bFdCQTXuE4ZIkC27F360BSFhh1SvHUv17nWGg2jZw70HHoaA5DjujnISSRNESjt
	 dbyuodK7XRsBGyn2NAUeLa34AAZA3dg8/2EQIf6do4udV6SLoeFOTJfUST/Tn2imm7qrK
	 qNePD8SBHMkHrHOoCE2BJPauYPS0wqiUlPFj+zq/gzizeEyWtxGChPiBlWC+XZR4Uneyx
	 fEP9/7IHZdWPrB68AnxcPHLtYWskT7d+SbZvDnymwQrrPIl6rMJiai4EZv4j5izztjSj4
	 B00rt3KTP2aEgEGiJTLqck3nWhc6WXSJrC2fbJbtji7VlzKayJqs24enPSDVDlTA8jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qP0gWheo;
	arc=none smtp.remote-ip=95.215.58.80
Received: from mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853C606D806
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9853C606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qP0gWheo
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/KEvK7dVaRMP9BRN0ZLePkyoaFXMxcTu+6guCCq8Id0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793966828; v=1; x=1794571628;
 b=qP0gWheoGyWdYFfsKjXv/7Pk3nruqG3GTvwvickazzxd6yb5ebgRpNGCxAxubttan2CxxdTT
 4MDQT6pS0vy2HVCfGSRjjMhpzspiGy99jVO+CtBTGSQ3Qnp/29SzNot/K83mnurfPQE0lg0ppaV
 Rz/Xu3xpxXdGahZ3Pilimsu0=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 27daf28be36fd430;
	Fri, 06 Nov 2026 12:07:08 +0000
X-Mizu-Trace-ID: 27daf28be36fd430
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] wifi: brcmfmac: keep ARP and ND offload off on the BCM4364
Date: Fri, 6 Nov 2026 17:36:54 +0530
Message-Id: <1B9F864C-77C2-47D7-8E8C-E9F066C5D267@linux.dev>
References: <20261104151620.70671-1-dev@deq.rocks>
Cc: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, Andre Eikmeyer <dev@deq.rocks>,
 Yossef Osman <Yossef.Osman@proton.me>, stable@vger.kernel.org
In-Reply-To: <20261104151620.70671-1-dev@deq.rocks>
To: Andre Eikmeyer <dev@deq.rocks>
X-Mailer: iPad Mail (24B119)



> On 4 Nov 2026, at 8:46=E2=80=AFPM, Andre Eikmeyer <dev@deq.rocks> wrote:
>=20
> =EF=BB=BFbrcmfmac enables the firmware's ARP and IPv6 ND offload (ndoe) wh=
enever
> the interface is up and not promiscuous. On the Apple firmware for the
> BCM4364, ndoe makes IPv6 downloads collapse. IPv6 downloads topped out
> at 55 Mbit/s on a MacBookPro15,1 with the BCM4364/3 and on the
> MacBookPro16,1 with the later revision. The BCM4377 is not affected.
>=20
> macOS enables ND offload for associated sleep only. A trace under
> macOS 26.6.1 on a MacBookPro16,2 shows nd_hostip_clear, ndoe=3D1 and the
> IPv6 addresses before sleep and ndoe cleared again on wake, see the
> first report below. Keep them off on the BCM4364.
>=20
> Closes: https://github.com/t2linux/kernel/issues/34
> Closes: https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/issues/227
> Tested-by: Yossef Osman <Yossef.Osman@proton.me>
> Tested-by: Aditya Garg <aditya.garg@linux.dev>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

The bug is present even in 6.18 LTS

Cc: stable@vger.kernel.org
> ---
> The KaiT2en community runs this patch with its kernels, no regression
> was reported.
>=20
> .../net/wireless/broadcom/brcm80211/brcmfmac/core.c    | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/dri=
vers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index 92ec269f43b..6eae7135aeb 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -13,6 +13,7 @@
> #include <net/addrconf.h>
> #include <net/ieee80211_radiotap.h>
> #include <net/ipv6.h>
> +#include <brcm_hw_ids.h>
> #include <brcmu_utils.h>
> #include <brcmu_wifi.h>
>=20
> @@ -103,6 +104,15 @@ void brcmf_configure_arp_nd_offload(struct brcmf_if *=
ifp, bool enable)
>        return;
>    }
>=20
> +    /* With ND offload on while awake, the Apple firmware for the BCM4364=

> +     * makes IPv6 downloads drop to low rates. macOS runs ARP and ND
> +     * offload only in sleep, keep both off on this chip.
> +     */
> +    if (enable && ifp->drvr->bus_if->chip =3D=3D BRCM_CC_4364_CHIP_ID) {
> +        brcmf_dbg(TRACE, "Skip ARP/ND offload enable on BCM4364\n");
> +        enable =3D false;
> +    }
> +
>    if (enable)
>        mode =3D BRCMF_ARP_OL_AGENT | BRCMF_ARP_OL_PEER_AUTO_REPLY;
>    else
>=20
> base-commit: 991a73f4909f1348ffb4b38765cdb522a775e4c2
