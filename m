Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06EB477285
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511789; cv=none; b=hOy4PosTqUhHN5hZanz/e/Ji65dN4HqajVQftK2310ac2dMKGQgblfDGLR33WSrTWKXxbWCumm13VkmU/roy4tmKaHnECO7NLJ02W0A14KIxqTMf+rglJaqBUGPbWbuUIF/qx8atkjumDXC4ImIXGJrUZ8S1S1eBVi/F+PlNzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511789; c=relaxed/simple;
	bh=NKKatqC2Re9eTa1xhiTQLVOdbcOfrB6iOyjGbHs3BmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIqpWY1T8lfW1D2nH2vkYJgR02DxDgsCPxWAg/fRHb533a3jBQ+KwAH1McIFoOCULKHGNDdu/8phgwicNeUNWvU0X9HRaZ1OhZxgBkuhmhQ42nS9LClR2WKd1YyLy++5uxmOoPvBfN4a4MWq6YFHwGL/kA/VzDVdeHMbGi6l/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-4693691fde7so223076fac.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511786; x=1790116586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQxcNZFJRBnNKYE5HTxR/5YC6FQVB68aqhBIuL0+JAU=;
        b=RJDAZaOyKaLWOr/2iK6XLRIoWWNOJVBuZRHzKRzzHKHxVwFRjegVXeJc3PqZxJht1C
         U2B4UtlYdAbr/MhzwEfHZEDDhTh9FBd924QMpYIF3fsEEr8ewOAcPALRhMNMXump/nNU
         p3mwuBebaQFR00SEimSTQ3k4bMU3F2hfRFRmel1FY+lnW9DKJrtrcviipxoJalbaKrNd
         gZHUkm3E0G1pVUoWtcyr7fKjKKx5D4Uz3iShjLAoi11whBSgxF+M51tAFAzcWidHaqbA
         7mA6+pLLL2vA/OXmbfsa3FePaBuA2L5EELdrkh6ushiR+lEUyiRdwHuHGqWAGZusT1oF
         HZ2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwTAk/1pOgYQLu6DogQxWXReJsEOdLT49HLJwNccIN76vwCtrPrWEbWi9X0//3/vm5TiVmtU3E=@vger.kernel.org
X-Gm-Message-State: AFuF++kxNw+WkVedO7j2n7+vLz0OlO1ZTiMojKuGjmsSzwc956casoSc
	vISha2inN5lHgIoNWn7uCbCnCz1nhfe2DxAv/R5UNPpQK4Qx71YUHd4pGvUjnQ==
X-Gm-Gg: AYBFou0cbK6fWXxSkJ+gw0zN7hwgmVdKx3Y4b5qAKj28PcNvnHF5VW5IuvOzQgcoXpq
	JqK9NUkNvJ15sPPZHjPFx9MRNSHf/39VMYSiXICj0dx91IG/KiKO18QIZj6XxDB/rejzOnaUv4n
	ZIYI7wxwGRTGcq/6QCvEicb5pJE04FNnKiTNVwmt3D2ryJD3u0OWYDwDiKljRYeHOC+VsJZPpz+
	nosgGVikyVcWJCXPHRdM/PRiTsSHIbEXGv8lWWwxIeIxWuaxUlztYVmucyCqIce6YONdp14Hu5G
	fjeubpDVbqX/L38VSqujajAbFijHPdtX6WayRWV+S3vLl2zYegrXhaAHxBQUWEbk2xAHbtgEMCO
	seAO6PP6GdkXtslEIqsfT7VL7dxy5+2wRkSobhklOqJEMX1ItPWkwFps0yY2seMlFf4aQs2m5RN
	ASDcMRT/s9SgDQXrVNEwBYmzmjV2zW3tidbxjjgDb0IGMPYDWVvcVFs4cxNzgzIN8xThIL7sS7f
	BK2WQoPsA8exxpnVULF9ZVJ8VPMGMSoRScMCEkpU1zHcnMotjd7z9I2RNBbMGGgg/gvJx8mgdsN
	t70By6t3aFXgD3L/qqu1BuAcZE6YIZgZZ9UG8vN0LITjij8=
X-Received: by 2002:a05:6870:d90e:b0:475:e235:908 with SMTP id 586e51a60fabf-48478694562mr191326fac.38.1789511785666;
        Tue, 15 Sep 2026 15:36:25 -0700 (PDT)
Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com. [74.125.231.166])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48429a9213fsm1109820fac.3.2026.09.15.15.36.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 15:36:25 -0700 (PDT)
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-805cc8b4231so155786a34.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:36:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByVeRt+qhaOwDD7rTyHPHOdExlwqiHLU6ylg5eJZ7LgjWRTr9XW7G4SzcPfexgmcxbxj6tWDJk=@vger.kernel.org
X-Received: by 2002:a05:6830:2b0a:b0:7e9:e709:44f6 with SMTP id
 46e09a7af769-80b2c5a740fmr490576a34.12.1789511784339; Tue, 15 Sep 2026
 15:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-brcmfmac-4way-handshake-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net>
In-Reply-To: <20260915-brcmfmac-4way-handshake-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 15 Sep 2026 18:35:48 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_YwUiMGp824d_xSFu_tveO8fhg8iFkbF4yt+p3ZavgGA@mail.gmail.com>
X-Gm-Features: AcwNN1W2qt9nnEEFJwdUZ2bbqC9KmYt-CX0tJb1UVyZt85fT9jD1BRVwzLovmLE
Message-ID: <CAEg-Je_YwUiMGp824d_xSFu_tveO8fhg8iFkbF4yt+p3ZavgGA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: cfg80211: Report port_authorized for
 4-way HS offload
To: Janne Grunau <j@jannau.net>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Hante Meuleman <meuleman@broadcom.com>, 
	Kalle Valo <kvalo@kernel.org>, Pieter-Paul Giesberts <pieterpg@broadcom.com>, 
	Jason Huang <jason.huang2@infineon.com>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Arend van Spriel <arend@broadcom.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:17=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:
>
> Since commit 416386060 ("Mark authorization completed on driver
> indication during 4-way HS offload") [0] wpa_supplicant expects
> NL80211_CMD_PORT_AUTHORIZED to complete the authentication when the
> driver supports 4-way handshake offload.
> This was apparently never tested with the upstream brcmfmac driver as it
> does not report this. This broke authentication on Apple silicon devices
> (BRCM4378, BRMC4387, BRMC4388) and other devices when wpa_supplicant
> 2.11 was released [1]. This was initially dealt with by reverting the
> commit in Fedora [2] and other Linux distributions.
> Instead of carrying the revert over to wpa_supplicant 2.12 add the
> expected NL80211_CMD_PORT_AUTHORIZED when the connection is established.
>
> The "Fixes:" tag is not fully accurate as this has only became an issue
> after userspace changes years after the change. Since the change is
> expected to be required in all active stable branches for wpa_supplicant
> 2.11 / 2.12 compatibility it is helpful even though
> BRCMF_PROFILE_FWSUP_SAE did not exists then.
>
> Link: https://github.com/zephyrproject-rtos/hostap/commit/41638606054a098=
67fe3f9a2b5523aa4678cbfa5 [0]
> Link: https://lists.infradead.org/pipermail/hostap/2024-August/042893.htm=
l [1]
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2302577 [2]
> Link: https://lore.kernel.org/linux-wireless/20260911065656.1269623-5-Jas=
on.Huang2@infineon.com/ [3]
> Cc: stable@vger.kernel.org
> Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WP=
A/WPA2-PSK")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - rebased on wireless-next with "brcmfmac: add FT/OKC roaming offload
>   support" applied
> - updated commit message
> - Link to v1: https://lore.kernel.org/r/20260912-brcmfmac-4way-handshake-=
offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 20 ++++++++++++++=
++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>

Looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
