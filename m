Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793938868;
	b=PKpD2s7QHW8sK5cZO9eaaYSu0Fqnchdc80sskpWVUvuYijylEG67NYRsAVj36yyct4d/
	 rLXDGNVV/RhYq15RgMU0ogKRFOhD63nQw5Wu9ma/z0ogHWz299mTXGF9TXnTMysP8LP5t
	 CCUO6d1OkcGt53fOJNOuB0GhuV29iyN2MiRFI3GuUcYpYEoT82y+jG5cfbfHFUX+flWFg
	 dzPAUvehISQSUt1ALrYNDnzNLjSaTJNUQjrjGHOzp6CDZMnvSHH4NyX7FESIv2rnUCt/Q
	 R5QKEOQh3jUW5MnGr6UWFEOG8F1uMDVQDVbWi0BPb6omvIJt45SEZdncvgfbIUWU3SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pyk0JyzHqvdED76UIlZA3sBSTWknVGCiaav7/S7ONxo=;
	b=CrfTAITHltldOnABHGHNmEHyciV5ACCe7a8sDP9dSCFp9n5d48oNQEEh8rx8lXA9BpPf
	 xTtQpOrfVznZa0ACj9eyTlAQvjje5lBA3NnMqi9oYIzos4gMmeHSExA18Mp2RNUK2mDvz
	 NYG7yBt1/r/BfRQfccQfT40DVz2zYGxnV3p/LV0/wADl6xr2lNqRZ8FR+5bZ1JNVSLus0
	 tP4Fg5EwkiJ/Rz6cWFjH2QPsYdmzE9hNC+IaM73LA15O1V62yWpXbFx6iNqCkojNevdEG
	 1m7TXHHSnC5xTZDi2mnxq8KP05/rMWhsu+B5tv/VNKWcc6PkgHtEODljPL3tJcMxybw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YnlWxpL2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442D606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7442D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YnlWxpL2
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4550d8ab15so27647966b.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793938867; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHH1ITmG7E25Y2oKemzGRMQHiZan8xyT7+wg/IspJGb+eiekCVpj0oG1Rd3sIkCPOT
         gIQS819wtOwia1NpxQr7e9ZAV9HL0AnvIAXrRW//lnyKcwlCxbgA/QgPBeclC9dZbBLp
         aXNrmNbmAH0Zx0hh+xTUaiundirBirNi0eO451UC6/xnHgXYGdu476RwO4LshyPY41Pd
         yugdE8LdcWJgK9MtRdrAI7YpmITD9aS+RVx6fzauMzGamEnnPactBu1uLrs2eAVViv/W
         Z84OA0oz/yWa2DGcsrhLrzuMVUTkFn4r8NFiEIaICbaB1uCqd1V1HbG1JGmo0C9IrtOM
         68ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pyk0JyzHqvdED76UIlZA3sBSTWknVGCiaav7/S7ONxo=;
        fh=h9KVWaNy2ImW5vwM0UVNwccVQDRdUCsjvh+rWPfaTKg=;
        b=sJ3AmC2yx3dIJrsekZFKiqdnAdy46TjyJEYBoAt4dv+/D4uo+cepL3+iTEm9MXE1eD
         2XfYJPseWeNpWfe5s04xy5X53wn4xKKTAKJDMK5iijfZSXxkd0yBnl7z1dI0I/4jDXba
         /TpfMa/SLhcx3p1xD3+f6C2JDzfTcXLN1ka5heulCKPZKLjGgZyr9qGVoHc/Xj4TNtzu
         d4c5uiHSNEQ9uSip32mlZm8SFCxtn71iMB5MCCCDLway0sTdgsZKM0puUx+ewC6PYDA8
         JAUR/ctdbtKfGfFS5rGAcCbLBu0SC8BuXqvlwOa6UrE0LftvfxrlUvEjysM+mbdqv5Xi
         Fhhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938867; x=1794543667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pyk0JyzHqvdED76UIlZA3sBSTWknVGCiaav7/S7ONxo=;
        b=YnlWxpL248IM1QX1TnZR+FIrlXFq2+tGnFgx7TPfaW/SYgkO89VWQH+wzBvFgtz6KH
         dOVI0XZeuZwUiXD4wgMPvIA/OOJNwuLpzz1Xh7cW15ZMYNPcTOF0W3fgRY36cq1UcbK2
         5AJ3vbWeGRDJApUtGB91lmUuB5pglWBQvpZHf8tviaKsdPYmVWhmHOY1zcoJdUc9b+BL
         SIdGtP5finsoEVQ7bY98KExdx343DkpYzwgskNnTXqEwpQcC4EASgU+TaLGhzQVF1JgH
         yL6Ww152bW4sZh9jYUOqJS3+UszNQEW9okibTO+8Y57cRARM4pC8Sv+dXUaWJNaGhYHk
         1fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938867; x=1794543667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pyk0JyzHqvdED76UIlZA3sBSTWknVGCiaav7/S7ONxo=;
        b=khqOeypeGooy5r9j2uotCvzShCunaiEC2a5p+OWyyu086A3ZBL3FaUtwsVH2N2Vaim
         gMsqN+YNsK1YqbDKBZ0MdAuh53YDt8xX1PhE6shQP9WEqXpNtqzzF+qAXNg4u+NMAj6g
         6kgzf1gKbhziRxBCgJrj70Uel68Q8FTgljdMPJRSTsBVmV/DKv7Y4K9d6pX/UzsmzbeO
         GfIJUFhmFdwiK39iAe4uUnQzETd0zb6/RgEicnrFGxR/EqEziHE0m8/067fa9LLq4owu
         xlJj8PDaLTDtjFkc4/Qz/R+0TEhG3FPTMBPAszchzvWZu0T2+me2SjSZRHiybCPK20vp
         eu2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx1EyoHTOb4igMHCBHiLXXf8wUggouWMAFTwRyiYsoI9V3Dvim9Jr6HQZuJz3mIju+NtOX8bw8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pS+VB+/3tBgNGAzWy6wKmup0DlGcdPyCxFiehcnFRKD4UPBkg
	Vgww6FeuM+yI7DLXfoxt1G3gTymScOrSSofreHW2Unj/Gepqpm9qHndmZ3f0thkM/B69sbA+FQk
	YPkcIyZTtXodEZBVxmgn3i8IDBvlla4Q=
X-Gm-Gg: AYBFou0opKrVLT7cEPYUacia2I/2sVCxOvUkOF8ASVj2S5Z2ngRmBdcEGrGHXnicKyC
	ODiADK2CmpA8xgeV2my4f98fGetOnOZdn6L/cmhxOUiqC9r1Ju/sTKiMdn7vuiiWh9XjAZWWkWc
	jaxor0Oqxp429CKxQss5X2kgoz1y43zLnEvtO7tpkog4J1RBYGxTASOCtrw6kNl/Bxbs2uMYx2N
	YZMHMUyj13i/TFeZ5UarfliIpbbqyToL8X8GKLAvKh/uA9Xwnsmtz3wus+Sfuf4aSzgoqgBzW0j
	Grw6VTvQvRj/68TfFm1S9nMqJEWYJDnCVeGq7x3Uansk9dTmShcBnd11i0AM5lJYepyzm7+DVqQ
	597o9zFGz/NbwaTrDo6drBS7AIPGomJrx0PB6B6NUcwkbXPy/i5teOnRlFn8z1HFHf/Sebw==
X-Received: by 2002:a17:907:fd17:b0:c25:afb6:2d91 with SMTP id
 a640c23a62f3a-c4d344a88eamr102409066b.2.1793938866528; Thu, 05 Nov 2026
 20:21:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110447-widen-reunite-2c7b@gregkh> <20261105025023.1204346-1-sashal@kernel.org>
 <CAOQ4uxghyqkUkabY5-rcwUrUq190Mvh36zgQBJ6EwYsnAiDtrA@mail.gmail.com> <2026-11-05-1-daily-reply-0005-ovl-readdir-parent@kernel.org>
In-Reply-To: <2026-11-05-1-daily-reply-0005-ovl-readdir-parent@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 6 Nov 2026 05:20:55 +0100
X-Gm-Features: AclHuK9Hq1fD_0MN6-pxvC_6BQ213xgSspenFJurRdo5MObuRmKcdiEgnd1XAm0
Message-ID: <CAOQ4uxhY4Y1ZzbvK6boZR2w=9M_4wJ1cJrOwwgWUm_MKXGuKSA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] ovl: hold a reference on the parent in readdir
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:39=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> > I had already asked Greg to take my 6.18 backport to 6.12..6.1:
> >
> > It'd be a shame to have different backports when we can use the same
> > version to all.
>
> Agreed, but your 6.18 series does not apply to 6.12, 6.6 or 6.1 as sent:
> patches 1 and 3 fail on all three, and patch 2 only applies with reduced
> context on 6.12 and 6.6 and fails on 6.1.

Right. my bad.

>
> Could you send per-tree backports for 6.12, 6.6 and 6.1? I am not applyin=
g my
> 6.12 version.

Done for all the series.

We may have sent some duplicate patches, but I assume my version
which matches (logically) the 6.18 queued series is preferred.

Sorry for the mixup.

Thanks,
Amir.
