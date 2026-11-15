Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776816;
	b=lBKp5WvNi66kobqJpFcEIuK/2SqjH8TYdQ0xj/EAdaz/rAwzOwvtO5A3QN6cFJ0/jNeU
	 cfv30j81LaD97T8wmd6MlnR3ri9zf+DkEjTivMkUDiUlXhJgXJYdTBwZ6z9wSvB/bJQYe
	 Y1bYgUV9uhkWMYB8GqBYIZwtUBf5b4TlW3h6Ar2Ekp3TfgtROyG1D4BVai6KBmRkY6uxP
	 0C8+zzcGPoQeVwiNaIkjMT1XHVTjdcGXoJK14kYgOLI2y198Bhmjkj+OFUX94mU4InUj5
	 BDr7YGICPrMC1DMPumIv77E7QRfA4vAiAb1gazxxXW2vSPxLr+2NCICl4kGmzBJoSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776816;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Hy5B50aWYdVKoabUEPf9kAEQZD5oIZknlEXK2QY/HkU=;
	b=ZDHbRj1J0EHT+y+cTv+57/Lh2O/3F6INj53bT1Nv7nqMxh4XLglclM9Nhon2Qspxo34x
	 UvsaiR5cvcakqkaVCNt7rUjVRiC2BaxttU3exr1iAghcv97KwYu/0li5MF+jHMI+47TTp
	 9XcgW/VHsDZ6D90MXep2iFpPEjtkzoZVjKOXy5g6LBYNTwc1ka75PBdmcmqXA6mqwRdCj
	 FO8SNjnk0MMQtQi4IH72VLH4xnfOT1aWsVni40r4Ps7QBN5y+iCuUxhntug199OJ6Meso
	 MB/GdF2AjQRO64nowA9QL20DchEiwUXuutvocDBNzRoMinO2Z02WbSSLFFvgjUocq+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pihjmq93;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1082606A32C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1082606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pihjmq93
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2efa9addec5so2120375ad.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794776815; x=1795381615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hy5B50aWYdVKoabUEPf9kAEQZD5oIZknlEXK2QY/HkU=;
        b=Py60AUa4V7Soii2pl9VfAdJf3/MSKKK8XmKuIA8gGdNwDl3E39llIMMYjGKOli7+xo
         b2eT2wRKlSPMiuTF9ZE7jNJkNlhoZbwfwWuuzbp2oCn6G9reN4IIdXnYcoRAH5RxFxQm
         NT1KzhK9TKPA7XMarLVGWQx/0O7nT/6uHWN28/0uq2DprkH01FbPCXMOjuYSR5Y47Ibk
         2iEShMJG9rdKG2JYJOrS77fHjMZb+dUsFURu2lA5Oq7mqhcIycKoz+OhffEdCsXdLd0m
         Jp5Odp+wEKvR9uL82MCBuyp/uOQQUhBYbMMmG+mY8EJWSTnPnwA7VI+W0TLeF5esGPgM
         1www==
X-Forwarded-Encrypted: i=1; AL+hErEKrPHMJadPAV8APGHUHoGI9ZULlGvyGpYPJjaKu0ZWgX4ZvUaAv/LOgrcrUwb/KH9dQqLZyEk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LVsm+C9/QcjFGJNR3P1InScKa0mG2amKHbITF6JhlUWRmqD1r
	yMr8ID3/KNIaIWdH0c+D6+A5fWxUimno8btFJX+UUykGDgSDupFK5dp90iRy8CTGBjiXOIumzT9
	6czNtW/+pcKn0+j5dC/t3uE6/39I3CysIJbOAZoO6AG9m+h/8FpKdhZ5WsaaDK5o3VxWI4ADcfL
	Ca374IUd/wr44AAV1bt3k1MWe4aIOAf5ZfY1uoC4LOcRezXZ3F+/lO2oKDnJhmSnI1mXJMiwzrg
	x7b3f67P8ZGAkBG9Q==
X-Gm-Gg: AYBFou11K3gEXCaivZSwSrVbzsY0Ev2f8acueTeY5aK9JyyNxyaQepd/9etHVVmoSum
	zFt+bm5iNYYGoWvUk0wPaNVB0hRRNE4AC5YT1bS7E/AlOEX5dvvz9WwYoK89/m7Zqv/uqch1A3V
	SIRUW13jOtHuD5Q+cz68QYufAyXHN5UiJPwanCGM0AsN0197LWJuxTXDBdpKxKsCANvsz1HgQU2
	O5Yq8qw9UI++lxUc+PbQJZW7KNAAIFDn/Y1w9Df/MYFN3yMFWbMKdJuqEu9xFA5LX0zMIKy9Ex7
	l6cfIZ+rUgSP6TEo/fJcmZTq2S/2y8YGEx236ARbTGhmS8EC3zKV4zHEIOMXulppLjKKj1FzMC+
	8aIdO7nbQQouz5W+4aBdjPnjwC51JKVBosRpBsIuScs7OvBkXtLelix/9X9uf184Tni5eZyw2kM
	prdD4lWQSVF11LUsB+7sxkNU9aGxjyv472d+5yhFg=
X-Received: by 2002:a17:90b:4410:b0:3ad:818f:3da2 with SMTP id 98e67ed59e1d1-3b1b0b9a342mr6916753a91.63.1794776815187;
        Sun, 15 Nov 2026 13:06:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1d1d744e2sm2126211a91.1.2026.11.15.13.06.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Nov 2026 13:06:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so3646454eec.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794776813; x=1795381613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hy5B50aWYdVKoabUEPf9kAEQZD5oIZknlEXK2QY/HkU=;
        b=Pihjmq93+ydLw/QwqloP/87X/p2H2h8JbkfGEB7Zz37C4ErTSkKAtgkme/dLgDvNIH
         ETlniro1qPFH0xV3XKu8HichpOYLw3AfnBItaPu1Q5nr8RUaF60oMgMHcNDcMVuddW0D
         RIFKayaOlH7VCZvhe7RHhoP+yQ/FGeg+y4Zg0=
X-Forwarded-Encrypted: i=1; AL+hErGBmFYvmRsxxJcrL0e0nPYlXbZkQEWA1u5kIJ7hU+RD6TGqa8uiuPmdd9no9tNNSiSnTDboMHI=@vger.kernel.org
X-Received: by 2002:a05:7300:e9ce:10b0:368:7c2d:a612 with SMTP id 5a478bee46e88-37966c4738fmr8998724eec.10.1794776813212;
        Sun, 15 Nov 2026 13:06:53 -0800 (PST)
X-Received: by 2002:a05:7300:e9ce:10b0:368:7c2d:a612 with SMTP id 5a478bee46e88-37966c4738fmr8998706eec.10.1794776812568;
        Sun, 15 Nov 2026 13:06:52 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm28693790eec.9.2026.11.15.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:06:51 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Angus Ainslie <angus@akkea.ca>,
	Kalle Valo <kvalo@kernel.org>,
	kernel@puri.sm,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: use ISO3166 country code fallback on 43752
Date: Sun, 15 Nov 2026 22:06:46 +0100
Message-ID: <20261115210646.889090-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018-brcmfmac-country-code-v1-1-54d7cbcce035@puri.sm>
References: <20261018-brcmfmac-country-code-v1-1-54d7cbcce035@puri.sm>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sun, 18 Oct 2026 08:52:43 +0200, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm> wrote:
> Without this, the interface stays confined to the country set by
> ccode iovar default value, which is usually 0 (global).
>
> Tested by verifying that enabling the fallback makes channel 13 APs
> visible in scans while in Poland without having to manually change
> the ccode variable.
>
> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 1 +
>  1 file changed, 1 insertion(+)

The subject does not indicate that this should go in the wireless tree
so wireless-next is assumed. The Fixes: and stable Cc: suggest this should
go in wireless tree and it does not apply to wireless-next tree. Please
clarify and send a v2 with [PATCH wireless] in the subject.

Regards,
Arend
