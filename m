Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794426345;
	b=ErCZDCGgCkGcSKZUO7vOUom4cS6w6HvOXkasfiBscrv4ovhEYAb9buPERDeFTyT58iU9
	 P3LbhLiLBjlNnFvtnbDb+d9BNRtwp7pUURNDKrsaxvHO4QaKqared0QI+z0CMdy8tL2e2
	 FivvzwL/VlYH5EmzMIJsC85EYaizP6lKt0l+txZG+qo7j0IF64fHTRmFIaZ1A+oOEpnZH
	 HvmbEEc3uO0bG8bvB2KUsge21/8fg9zVvHKdTRF7EeEJ9tSGAwoQwsj22A3UOiXD+B8O5
	 GIhJTVik5Us+NGRXYsC+x8e0IMgrz3eRuOAQfg5ixz6JMXtcnQyXfSVgyLXidHQp10w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lILIcv7ALfl3mdwxNQu1XBlIGEZnSF9o3ZCOxCy8fhQ=;
	b=Z/qDIU6KgdBDkJB3w7dLS5CHntDJITf9vFskNdJmyFEEKS7KKYGweLCTuIH9WswQOQDb
	 5aFcKWnfV5u8Orqr5MnOeZgkARg1YUJkL5qXroVLway3uegnSFZLhH9x/xrPc/Ry1yR2j
	 VzVm1yhV/EW6o5bjTc3HcncDAJ1BlPQaygPGVqK9ZOnuSkJZ0ftfoxZz4CM9VI6bLb2kW
	 pndIsv5MEp59hAhluuwEWxPmnLFGU/YzGG+us0+gIfWkyaJko2vfq1y22irjZHZvXONP5
	 zCJGlkhN1yVgL5YIB5SjQM7hDWNUrx8GqP2eXzxSjbt7AL/bgyd9DAcpzhSWjXupvFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2SQADY4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E24606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E24606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2SQADY4
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc603a168fso1382916137.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794426344; cv=none;
        d=google.com; s=arc-20260327;
        b=l6q8RGHxZvdFYCqU0+aLnlQMJYhAIe+lFLR4UpMs7kWUMEota2Eyq7A0Yfj2Y8AuAi
         AGUT5/+uO4f4xEMCTiR7cEHyNufhaf4Wfz7VoztMdcuQfYU7P02BsU7HFfVRrNmQtccU
         Iba4fqGZkT0dj1fYEH97rGEMZH0gkmCKyMCsJ1nlnZE3N3blM9MGL3uU7oyYlsxuGzXk
         dw9mSeEcc2rH/K5juI5FWxxvUzf8jr5w2v6rrDc8Y3LbuaWA67hGIAO9giHgPEMn9+jy
         zuZvvLlOufFIW3U1Q3RJuDIqKnsHiyB8QwfNyEZyaQ8ROAr25+D/dOXSMHHbymZspuGv
         u0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=lILIcv7ALfl3mdwxNQu1XBlIGEZnSF9o3ZCOxCy8fhQ=;
        fh=dbQKvMMySKtuL7Efi3AVdk+dw0v6MC0Z7w9SZ5Bylxs=;
        b=GfxrLfPfuoCJKXziHTB6PNtiE6CvOj0uHIxGUeQqj9NqqKUiLNIbldHKhA6sP/8Su0
         5XSbwo9SY7GkbBsXc86J+UTXG1gltjF8y9XRzHc680aDAiquKnQWVGzu3ROpCvhwEzdI
         rX6BEjmXSVp9u5ZPSaE7tjtYoaDZ/sP5PustFS6gF4i5OTW3O4eGj9mVHn6pSIkG+7Wf
         ANl8tafvtHv3hnXPalorrUW2VGxzYScvzSPMgj4jB0E23kWLNzraD8j3dtTQXQGX16QL
         IPLBz+uvBMVfIQpqqxek9Jf72n9ADwwS6p31P10AVWCMT9fzUE5qDmoVu0VkB373LOLI
         hGUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794426344; x=1795031144; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lILIcv7ALfl3mdwxNQu1XBlIGEZnSF9o3ZCOxCy8fhQ=;
        b=s2SQADY4LOfmdJHfDSvArtdrTeHBAS6GOBpELjwBCpCNvpH6naC/dcKs4byB7lwQih
         lqdEQaMgswjGDNm9o7gStKrqov+X6daowptmi4STP/SO6ZLjO2Xwkeyq6XzIt3wpYfb/
         wX3edTaXNQ9PNhBqJGHuCGjUAV86DVgmu7OZv+X2HmWUAj5RerEMECumzxt+nXodVZLR
         /R0o8YKbe+ZDRwLG4eyQOFITNBoppYUFD5LTuA1U4+NJAuQ7dvpTp7y1IdVZis1JJNRE
         ITSHVzog8tbzHuGtrcQeocPXCbHMkj7nsYn2zuTdzWnUwjW5mjrwVHU56tNwiGpy4Qec
         Hj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426344; x=1795031144;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lILIcv7ALfl3mdwxNQu1XBlIGEZnSF9o3ZCOxCy8fhQ=;
        b=jCrHTOP1v3McqFJbb0wiHxDiVjYTuxZs/p1qxza2tD/CT0uIFfaPr/O+WDSId+4+fx
         ulmcumSULBCpEYI69TIlqU2lSLIU8dvNAtuea7pD4Ml2u9TxE9RYvTFGsIneGAX5XrtE
         apndmZih5Tk0laWDAJd3c5pkxA5URIsygIvAiDndkEpl0ncC1WtOZBuLQGCRnI8s6ZbS
         K32+bPvyFs49/7LIO5IQUa02ZDPfmxsfx1tUik8FX1mOnJ9jIzR6qOJ3pNXMOlDFuMTJ
         0J8kZCTVCDB8/u2lSABoxrG0ViZj/jOB/hpvedBfolTZoiJLVkxXyueAGd94Z5zCJs47
         X12Q==
X-Forwarded-Encrypted: i=1; AL+hErGDNDHZxTw9v6f5hzfFCBqol3kINRq09eVP2ERAiuzcK/qjZVPT7QIgs/YYftsoIQHvNrrUyS4=@vger.kernel.org
X-Gm-Message-State: APuU4Z80WE/zOiD8Y3yOPUMQA+p8xlc5KRnSc1jH4k5sv8KPrmDZD/bD
	1JxLAmBTNphSyQeZCa+lI27xw7P1BY4ml/r7n4TFAvhKXsc+hrFn6DQSU14gsNXBAJVM4/aqSPJ
	wqZIPuWDmVc03KwkiMyhCPPKKyVaUnBc=
X-Gm-Gg: AYBFou3wMZneI1fuQh/MbdZxt5V0hVBBGfCKTgiIqfUkg8XZijDLrpRF+yvgZMwkFBf
	ZrB+FqFxOis3kycrFQQXxsbtovWiR/xKK/KXgepXfPF9fm5xIkeH2aB4GJjRAWbi4jlm22JRmRX
	l/NyVkB28qkxhYu7/wH6bIk+b933U/i8GO0FxQ+BfPL8pFUkRGC0DLAXv2cLM4g0Uo1yGyXpx61
	BAvzbkkOqgOm95DSEsRYvUO30iq6GerIYzeeLf/Y986z/vKD6OPQ4Gvlg25bms9T5Ujue0l7Q5T
	oYP7oZpZBiPorYNxfehgF5hSGua71Uvuwu9MxoEpGOzqYe34YXsqXb2l5awveRYFgXQ9p+6+Pa+
	oazvV/1im9X0a1KFCrsEDCcDDI9NjZJAxJkxs
X-Received: by 2002:a05:6102:a4f:b0:7cc:9d82:ae17 with SMTP id
 ada2fe7eead31-7d4fb2d9f20mr1247064137.11.1794426343023; Wed, 11 Nov 2026
 11:45:43 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 11 Nov 2026 14:45:42 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: enderaoelyther@gmail.com
In-Reply-To: <76bc126fb977cac0f0a124fc80eae9fdb803264d.camel@sipsolutions.net>
References: <20261028141751.6728-1-enderaoelyther@gmail.com>
	 <20261028141751.6728-3-enderaoelyther@gmail.com>	 (sfid-20261028_151822_083722_A5EF7A18)
 <76bc126fb977cac0f0a124fc80eae9fdb803264d.camel@sipsolutions.net>
Date: Wed, 11 Nov 2026 14:45:42 -0500
X-Gm-Features: AclHuK_498F9mVKuehZNiursTJcACe2DxghGvso4T8Fz6hgolPYVL93yCmoCmV8
Message-ID: <CACHPgzw-JeorCAX-b5jjd6d5=L0oYpPdGtstUSaz5sPKZE2HsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: serialize radio removal with
 frame commands
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "John W. Linville" <linville@tuxdriver.com>, Javier Lopez <jlopex@gmail.com>, 
	Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> That, with significant work done under the mutex, seems like too big a
> hammer, can't it really not be done in any other way?

Yes, you are right. The global mutex is way too broad, and I am dropping
that approach entirely.

The underlying problem is per-radio object lifetime, not command
serialization. get_hwsim_data_ref_from_addr() returns a radio pointer
after rhashtable_lookup_fast() has already ended its RCU read-side
protection. A concurrent deletion can then unpublish and free that radio
while a frame, TX-status, or PMSR command is still using the pointer.

I reworked the fix around a per-radio reference count. Address lookups
acquire a reference while holding hwsim_radio_lock, which is already used
when removing a radio from the hash table. Deletion first unpublishes the
radio under hwsim_radio_lock, releases that lock, drops the initial
reference, and waits only for in-flight lookups on that specific radio to
finish before calling ieee80211_unregister_hw().

This keeps the expensive ieee80211_unregister_hw() path outside
hwsim_radio_lock. It introduces no new lock and does not serialize command
handlers or the teardown of unrelated radios.

Since patch 1/2 is already applied, I will send the replacement as a
standalone v2.

Thanks,
Zhao

On Tue, 10 Nov 2026 11:54:21 +0100, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2026-10-28 at 22:17 +0800, Zhao Li wrote:
> > Destroying a radio while a frame, TX status, or PMSR command is in
> > progress can make the command access the radio after it has been freed.
> >
> >  DEFINE_SPINLOCK(hwsim_radio_lock);
> > +static DEFINE_MUTEX(hwsim_radio_mutex);
>
> That, with significant work done under the mutex, seems like too big a
> hammer, can't it really not be done in any other way?
>
> johannes
