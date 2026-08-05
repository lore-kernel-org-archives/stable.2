Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005B3DDDA3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912517; cv=pass; b=TKRIIsdXVq/zaEO9i90/CCYP7/amYA02j9VrNr9+aFKHtbl8wcClCVpwyjBuijw104FBpfVWveYo69aF8/Ch9w7GAbg93kieierz57F6zndGU4LMkwJoJ+7FVwIfNR9fM9fhn4kt4T7tVZM797r31R3OhZDN7+PA+wpzlEuGofA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912517; c=relaxed/simple;
	bh=zX9W4WlSLffcK18o88Do8oN5udTcUrmnH3VmfZ2omYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccPVYh05eFM1tvXGcgRzlJ9+A6ZV+5Zpo8mgX6k5il04qqMclXszdDI4r/EMTSk2hqr1PR1AyjMtdorQOP5dgFgavkVwMPH1YjSnF5xeEXpNO9NHaI+chDC/YHh5q4YpH7MZDsM3dJN48IagVaFQ9ZWvMAJ4UFsTgyJcj+JO/Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8+f4yQY; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8+f4yQY"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ee50eb2db4so516650a34.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 23:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785912512; cv=none;
        d=google.com; s=arc-20260327;
        b=Dsxs1NwmCPLM84yhcVubHYaYcaUMpQa8l7DaKbTnOlcQGhOTvUJ/OEQvDqaPeykvX1
         9HgsLy6bQv+Xp/3DUXuw4BNYj2QK7y7SxN6amdk8c0H5/wFB7xri3yJn72NTF2FSMFve
         11Ouxlc1lEDHxd6D07X7T2sTyUEf8Vd0I9Q2XHIK8zW/uI0qMakACaeDfwnHSET4/m46
         1GC1rxo48ZPndq0reAcGdz7UCa9L0NkkFCNGQo4VC2sM5ywMZb6ES8N2H2BhDBwWzApp
         UA/ZqFNrYahO94zO54UkmwePDaMBiQMh1VFhLoiIwRatJIzY1h+O6ddFB+kJ5WBH8b4Z
         Bkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Xv6Lh9Vxa7VZjoa3LMQUcV3QtVtWuQt/nGnygeIYR4=;
        fh=ZwpE3SiG4TkZq2ngbgDRRf6BSaSz2YuI5ZSKM6XvQUU=;
        b=qQiRaWV14SUIGfJpCcqVgn9QhHsUKMe56gT0X4PSQiyOO3WWILhckhobVIIVAkeUDY
         8fgCOZmva0NR3pGxX/s+QBYVy7sKEWVwzuWIGvbhenMFsxeWoIzggwZ+pKCUz74/7M8w
         8AQW5iz6ZjEXjCvEOP2Aqfx7t17b3hW6KTcaPB/C0/f37syMiKI4wzNsOcGUvPQMO+Hb
         wFF8vQq52u4b5FjqhAgVzVA7zoRmvF4ysnLOmkIop8wNq/yec0HhAEVgsnjGEnnxBi4R
         plNq6L0IWd5nE6Mm1U3JZx5zy56dVhGpTTSg8qZpo4bkvCyLMxfqSEUnfYsXXZEF7e33
         /xIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785912512; x=1786517312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Xv6Lh9Vxa7VZjoa3LMQUcV3QtVtWuQt/nGnygeIYR4=;
        b=q8+f4yQYNOVGCOuJYnVDIQaH/7HQZACPtQm+liespzmBCm+MDCxyGgbv49EcsdCoNu
         OzsiDfxTw/fub6y3Unn6bPzysaKnEdvLmrae9J/an1wsAJVYfrrCowJ41R7fHrmh979h
         NE7057qCQZnzkzUe8A9CmDa8NlZ2ngsrJGw9AGhmQbX3dNeYKbh6GEXUYZWAajKGqM8F
         7qVF1XGaFMsG/HhjmRG5X0H3tVyV82PJ32Vxt/MoqaHGTpScw8CfQJxJV4J9Sqde672W
         hsI5yu6U1z6vGiC94RpN7E+Qauu68zFCaGinfLGbFYzxm08cmZg9CdgsB8C7BJZtaA77
         6S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785912512; x=1786517312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Xv6Lh9Vxa7VZjoa3LMQUcV3QtVtWuQt/nGnygeIYR4=;
        b=rnLbRkuQlJ/E0qMwciVkgZnEWSzqNzrvZ9gSVEIwdxuhIWLwRrK8wx9+1zhh4YGhqx
         3W6F/HrZnW2WIeYNQQfMPuoltfzfgvh/MvwSmRyzpyG18rFaGqSxYDQfp2uDE7aB8e7/
         3NoNmP4PBXe1yOkmgwqoE9f4NDRGvHR3SdlKm3IdlyYDfCbakVQWGlDUt7T5TipwXyf7
         pzcnOrVN6mnQ754oDxYgvNEMOZulnPbN4wFw7Y5Lx2DHQzUYvV9PG7DSaJNEZiTMECfD
         EuidUkSTriFS7rV+nx1LPqBNZwYd7Pp458gQ+ecvQhm1g/bNiTuHVi23XmoN9AwYD8BC
         ZhEw==
X-Forwarded-Encrypted: i=1; AHgh+RrxdzQjz3jh9b+h8732YKykjzgEvsYwha32Cv35pX3yx/9xiA7SVoVhvFPUiOZ6jYdc9IMon+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbP7Sn/rwphEtlyigvzZz2NlZaZlSajL4RQta1muJNKooi4EkO
	p7FUSYPKGh8tVjLzzYNYvQ5Da90NsGi42V9HwDwL99D5mU2Xcz3LX7rj0lQv2DEX5KKyTPI28ka
	9/H9GlLwKCLtG8LLXvmXMCAgzk41U5Vs=
X-Gm-Gg: AR+sD10Oc1i/g7ywBlmT+z4cavUR8jZqvRujBx2pFF5AiWYZwTvSExbDJFARRTqmTPH
	bMrk2QcpcumZj0sjdQVm+WLs82mesD4vdUzNS7pMckFwCESG1Kd588F/3KtPaPyeUCQLhpEK5iQ
	4DJMGpwe/7QDU9tnFABBqU2r+NtR9gkkfVaUn8ybdSNOdnaoWz5Cff0WR5/Xct/xrk8hoyxszMT
	IKgJereLoImq+qslICx8fY31oDW05r0gLK4WGGuj0PiTmLkDNUtuCzROBA4vOsOU2o5WokMNbAb
	PFBCzv1UmBfQ31UnP5W4U0jqttMBudFczNBBGpmqei+aWp6yMNwpeOvJxJnsSZea/VQbKECABFJ
	1AA==
X-Received: by 2002:a05:6820:3095:b0:6ac:a5a3:460f with SMTP id
 006d021491bc7-6ae96f1111dmr2536229eaf.25.1785912512358; Tue, 04 Aug 2026
 23:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720150207.1963786-1-charles.daoust@gmail.com> <20260805075429.08416607.michal.pecio@gmail.com>
In-Reply-To: <20260805075429.08416607.michal.pecio@gmail.com>
From: "Charles D'Aoust" <charles.daoust@gmail.com>
Date: Wed, 5 Aug 2026 02:48:21 -0400
X-Gm-Features: AUfX_myCbyWaGmHoIJb8Tebqi3WNBU8TWiYaZdPYl_JynhHI19QT4zP5Jqfjl3Y
Message-ID: <CAAhWKQRBrK0Bu_wEPV6chU=p6Y=kXix9H2Ys2k=M+PxbAL3Wqg@mail.gmail.com>
Subject: Re: [PATCH] usb: core: add USB_QUIRK_CONFIG_DESC_READ_255 for Razer
 BlackShark V3 Pro
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It was indeed AI assisted. It's hard to tell if this is sloppy QA,
obviously, but initially I thought it was an actual lockdown in the
firmware to prevent non-Razer software from accessing the device.
Turns out you're probably right.
---
Charles D=E2=80=99Aoust

On Wed, Aug 5, 2026 at 1:54=E2=80=AFAM Michal Pecio <michal.pecio@gmail.com=
> wrote:
>
> On Mon, 20 Jul 2026 11:01:26 -0400, Charles Daoust wrote:
> > From: Charles D'Aoust <charles.daoust@gmail.com>
> >
> > The Razer BlackShark V3 Pro wireless headset dongle (1532:0577)
> > fingerprints its host during the first enumeration after power-on: if
> > the first GET_DESCRIPTOR(CONFIGURATION) request asks for 255 bytes, as
> > Windows does, the dongle enables its vendor HID command channel; if it
> > sees the 9-byte header-only read that Linux issues, it disables that
> > channel for the rest of the power session.  Audio still works in that
> > state, but battery reporting and all vendor commands are silently
> > ignored, and nothing short of removing power recovers the device:
> > resets, re-enumerations and byte-exact replays of complete Windows
> > control sessions were all verified not to help.
> >
> > Both read lengths are spec-compliant (the device truncates the reply
> > to wLength); the firmware was evidently only validated against the
> > larger request.
>
> Hmm, so is it fingerprinting of the host or sloppy QA? ;)
> Out of curiosity, was this patch AI-generated?
>
> >  The kernel already accommodates this class of
> > firmware assumption during enumeration: hub_port_init() reads the
> > device descriptor with a 64-byte request because that is what Windows
> > does and what many devices expect.
> >
> > Add USB_QUIRK_CONFIG_DESC_READ_255, which makes usb_get_configuration()
> > request 255 bytes for the initial configuration descriptor read rather
> > than USB_DT_CONFIG_SIZE, apply it to 1532:0577, and expose it as
> > runtime quirk letter 'r'.  Devices without the quirk are unaffected.
> >
> > The trigger was isolated by single-variable bisection on otherwise
> > unmodified kernels: with only the widened initial read, the dongle's
> > vendor channel comes up enabled on a cold plug with no interface
> > drivers bound (bare enumeration only); without it, it never does.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Charles D'Aoust <charles.daoust@gmail.com>
>
> But anyway, FYI an equivalent quirk is now sitting in Greg KH's queue
> of fixes for (presumably) the 7.2 release.
>
> I suspect that Greg would accept one more patch to enable the quirk
> by default on your device ID.
>
> Regards,
> Michal
