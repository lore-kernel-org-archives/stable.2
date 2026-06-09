Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52C33F5B0
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014560; cv=none; b=UytUfplBzJN786appPyZjch+h2DlSi+PpxPLBg7O36aeHtCWjxjWdqVz3vOdxnYVxCS5MGHYgYncLFW5ASC7bjtYtD8xfxI5XXhAuiMWQnubgqW2vgbIPR/Eqqm/2SPZ/d0NVAJR2PbpEdXdYsGvq3tTiiXGKteFEOaZSPmKEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014560; c=relaxed/simple;
	bh=9CIJb88IKWbWT6IEhObvHO6UhRZhTYKH7PhKE6eSb3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msVF4WlO7CvugCtAnKv+xDeHdZ61JGVH1ZEVuj0OgrD5smQ5sZVgB4U/Ns+IMmdjvajVJS4fE522q17JT64Pa/aI+BZ6/gItF8pti4icGXd+EH95FR9B4p25zkn3ixLXeg6dBrM2EZz/xKy/P+uzw/dpYR25995l+0xuDJek3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDlsObfR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDlsObfR"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7f015f87fddso27308377b3.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014557; x=1781619357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1hcL5eJx6MWJvlu7fWXmuLzT2QrGx87Ta518j+s/Zc=;
        b=CDlsObfRA6zeJVPR80IO2VEbnyTpPoQjQ7aA0T+iMmbWqJSzex/G/klZorHDEzj78n
         cV2CSea2JYpgTxXYpwzPIQcvCXmM85NaIIrjygGtVKOEEgrNhSNZNAx6+lpZkBHsy865
         Hslu1f9AiMIptd4if0cOgWqTF5uVRZXCbTJtKh7QiLugzQ89Nnop7mPRoDOYmB91O2dE
         I7O4ru34uXJIXoMRh4EI2jLmmcXT+qcBTICoXVwkxbXCn7iYGEk0m7kwE2tHdogr/j+z
         MTr7Zx4jvQHPr0/4y5qB6TxXhKMNULQhlfwn0dozxeQXsvS2U5PaQx8VnQ87TNZxJfUw
         w85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014557; x=1781619357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1hcL5eJx6MWJvlu7fWXmuLzT2QrGx87Ta518j+s/Zc=;
        b=JgP6KccQiCj6u38NMrwS6F0QfDaBT136B064SkROihN67FQ4l72G5Vfz1We0UxV019
         V7Ua5f3IyOqbLzDHpQL3xWML6QU0/g3zCec3cdgdiv78qocrjjCaJ5IClHXPo9xHWl0W
         n7X/52Ze3M3hBtnYY9rG8dYTkP7jtKkgxBJi+dTPT5dYtke0qGqXLCMto/Xfm3D4tWFO
         o9fnYPW71G8B0zM6wMqUzFFn8tf/Qu0oLN5GRZnUB4UjR0IdyHYXSRXVtutc7RYFjX/Q
         AXstoMht5zqIqZqwPxPwZFCMbol59gjmJ+lV4BIH43oRW7U9a1ZIlT8SJ8I6JFvpl1Zo
         8gEA==
X-Forwarded-Encrypted: i=1; AFNElJ8GRraJO+hyBCy17Wl3sfSvr53D8AdPF3wqGha04ZICM8MtevynJ/CQDR4saa+IzrZMA2hr5QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLS4g1NSszKNKlNKFCx8sioUA24FcqN7FEq6qhWORw5aZVLDF
	AXG+R1qvOMaQuTPKiBoZCvIapvdJEsDOdWzRUmrHPKXTC6NXyntnCbKyXmnm8Q==
X-Gm-Gg: Acq92OHLCtLAyhWwqA/HASFTGiB93CGaxpdQ+a/yPoGGsBVJD3TG6h/qS6fnkrubTPY
	AXznkqfNvICDXihnO18fS1wJ/fKCHovV3MxyiyiNKWUpO2U/N0/cwvmVsqjUsKBGfEcdhpZTskj
	FkvfozWQD8CNKVJ7ycALqxGCRdmG3sWu+kTs3SplgnW7ZfJTaJRmbdSBl1Zqo8dD3OtRObdxK3D
	hdfdCIXWlnIIATBUPPstF84+Hl8umUPixvvoDlyZsbK/Yhmz9vFwYDMaFKodFQihurwJZVKm7fh
	pccGR+YWxqDO7YiRAGpLGZ82sIbCd91s1aCYkdNXpVr1xc0fLttje+wk012cwgB8X7n1eRPAEqU
	klM7DgxaIpY4UH5Fjx6Q+L5owXKIGTXQsjvreROACN8NwEDFIzeqdJ1eOqE43iTKCMyCfjX0SKp
	5U7K8x2JqSe+zaYedF8HlA
X-Received: by 2002:a05:690c:c641:b0:7ef:9fd9:db07 with SMTP id 00721157ae682-7ef9fd9ec08mr72816327b3.12.1781014556604;
        Tue, 09 Jun 2026 07:15:56 -0700 (PDT)
Received: from geday ([2804:7f2:800b:dd29::dead:c001])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2148cc98sm96519887b3.13.2026.06.09.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:15:55 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:15:51 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Denis Batishchev <ii343hbka@gmail.com>
Cc: tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable micmute LED on HP EliteBook
 6 G1a
Message-ID: <aiggF41W3LlKDts4@geday>
References: <20260604131518.45993-1-ii343hbka@gmail.com>
 <20260609135607.3960625-1-ii343hbka@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609135607.3960625-1-ii343hbka@gmail.com>

Hi Denis,

On Tue, Jun 09, 2026 at 03:56:07PM +0200, Denis Batishchev wrote:
> The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
> Without a quirk no fixup is selected and the mic-mute LED stays off.
> It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
> already-supported 14" variant (SSID 103c:8dfb), so add it.

What is your exact variant of this hardware? Also please refrain from
sending V2 in response to V1: it makes patches harder to track.

> 
> Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
> v2: reword commit message as was required by Takashi Iwai
> 
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 78a865709635..8eebf91595d3 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7274,6 +7274,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),

The description string of the quirk seems copy-pasted. Are you sure
you have the 14" variant?

Thanks,
Geraldo Nascimento

>  	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
> -- 
> 2.53.0
> 
> 
