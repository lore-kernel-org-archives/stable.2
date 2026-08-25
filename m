Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968874734EE
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694218; cv=pass; b=uS1Dk82tKPI5SPu6Qjp992fI5n++9AsW1O+azaqctJRnGXzmRsnmSSbs9euHjUYdpZAFcoOchgwLxCDmbjvY3DzMeDeKuTAIE1S7d8uVqjFJGRXmciI0ISeuJi97jGUCXg15PdHW4MMFuKOS01yncmJ8z51C7xxPOaqYnbGfkrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694218; c=relaxed/simple;
	bh=gTQdpnJPXFvK+dH5XFeLn0W2hRaHVNhffzbwns+IEi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrpzeHjgwEdFbPa7N7zEd4PJSiVrYwxgQM89YSQhbF5xZWrCN7U5UBpNlW0TtIdh1J+XEc1Xl29+UAsDWC+DlnEyGv0oMbG15uk9jX4SrmwxcpSwHdqyfowobqa2QM+ipUKYW8QrQm0kOdHQo5ciM1yw6g3K75UQN3RrFmY+AH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2QWoKVv; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2QWoKVv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so266278e87.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787694214; cv=none;
        d=google.com; s=arc-20260327;
        b=N1nuwJzTiWkkNUTfFSE7w9vBN5+z1yziL/uuKxYfB9SD9Jm4fAfOE9BarrgjNISmJu
         CkNg24XU88OFksOpG3ZcpyemvKh3lch+G7G6QyEur9SheKBLzck7ScQRXzGtVuSEaMwo
         TNpmQGT6qFk5MmeNcihyfX5vt0gf7oo79csPvV6C+aLZthJTwEXNaZXozyLbi/Etd8kP
         AseViykF40PW66apfxC/xTY9mK2W/Jv+OVKoKBN/jSQkoX85mXdK4pHIY17bY4vzWEaw
         7UE2cxKuxVl3PEkrII4jQsCuP/3QxyL2dDbt2rt1SeIeOHQb4jA5sDkGmMstnmOZVakh
         EpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTQdpnJPXFvK+dH5XFeLn0W2hRaHVNhffzbwns+IEi4=;
        fh=VgLPwyeDCVTTRKLlirhELngm55knh36zNzj211PQbUo=;
        b=rb2eadnDkO5ekSw35yS/jBWX6YYLp7J9Ir3E32wUe77YqF5TK9p8IkeWwKwESsCDIe
         rTQix6g+tJw31Mo22I5PryKh2xOKRjb4HZXifRm3Xwa0JGJjjQZQDb7+KSjctrViPem6
         OIO6hum4hOo8wK6TKmcZVWRdtYV+b/yQ8UWPz0nWK4mpqmZzCmtl/tYTL93NJIHCHQBd
         e9GD3AgGqIxjlgPuC5ZxVwPHeb/GJUouBpOLR2tKRqv1VrxNYA0qRVfwTCftz/Uk5Is4
         +k3i/Kz1dwUtAUUbzAmeo+rEj+Cdk5ZndAyknaV9d5RwIbveraiKxgSptuEPG1PCJe38
         7hhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787694214; x=1788299014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gTQdpnJPXFvK+dH5XFeLn0W2hRaHVNhffzbwns+IEi4=;
        b=n2QWoKVvd0TQBYBAnRRDMm2kKvP5HYAF022AXy8YxFG6ECuZYa2K1lGjtVbWAfjp21
         YZxHH0HoAYEmFm2p6rCl67atS36Yn6b18Uc2Y9dAfE6x8qRPpDnrhAddN2irtfqsfe+Y
         9GZ1dDmrFzO/86mmbqlqNt1ocOC/Dq9lpYeQ2OJxzo4VySSMeUHQlYbkWdtz58OGrwYB
         cezIy0UCb7I92ZsY2WLdPrThWRBLjEaUV3C5RH55GnQ59C26MuezFRt4U4MTbesPDFfd
         sSRm2/LlOb3GrWVZ/8jy3cdJU0jj6FggNnw2ugyDpa07jvZXBGSQrP06pNE8px2KMDWJ
         oDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694214; x=1788299014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTQdpnJPXFvK+dH5XFeLn0W2hRaHVNhffzbwns+IEi4=;
        b=iSVs0qzIeEwYHSqQWf7fg4zy0xPJh5YzT4sVmjxME9o9UFraZfHVyydGCY7r7Z669X
         XjTm+Q9zEUn5MowomsUdmwgpsJa/VKUY6ogtTQOCss3PVVK/xyA/i9djZg/4SF/cpgEZ
         tUvndnZvmHhpSAHs/NexKiC+d1ueLhmkgAJExlm5n75PcpMw11+9cm47uRRXHJBnkxP6
         MRchKeOQRaZZ1/cedvaWy/xVNom2lvt4OOceH0FZU6VvnHMRy2OZ8QyCz3usA1P+T0I8
         ZbLRoxGKNhyG1de1ov+S0szkQPeynBtf9pFLjIs96t9Z0epl8j/xyfia2szRgrKd9oa/
         no8w==
X-Forwarded-Encrypted: i=1; AHgh+RrQWVridd61q7vUzboj2+CnGFrnX7He89YpF5DTrm/J9HisTnuM1XzhntAE4MaPM+UrpH9cp7s=@vger.kernel.org
X-Gm-Message-State: AFuF++m3qfP2jz5FW9oPw7cWvIrm2gu7oU6xXwVh5sjIsMt5aaWwBvCl
	i5EGL9iIwapHnQMcdSG3+RWgu6aU3eI4iDszRlz7WBGBExUHYPaHCzGVZeivddXxAd+AaCnhH+z
	AEBW2rE9LpM7ZJ/XU1CjI39idoz414OZ0vD8OHXRMlg==
X-Gm-Gg: AR+sD12kVqEgG4MXpXmqgk2S7yPVVN6JjaDUBvo31djHzyieBXLSk/uE10aNChaYt/9
	wgamW2ESxNajx/bN5TZ6qnTDz4uWGLA2mE6BPcYV7fGOOTNfn/SZpTLIX27hoZ2YPq5htvfP25p
	UlBHfM/e+dX5B7xfogg3dweNR7Horrr7k2RC6ZSjDN+Yf2rXFvrIqdYHSv39zQp1AS/y9E41aV3
	6ToVRcR32cl86vfT9yw6GAblesfXzRLpq17a/eeYwvIdUFtlVnerh0096aauEkPnCL8B2AXKy3M
	LEujCO+FHuG4N0WIdRRatiUFOXjDMthTVhhDWQCkpwMbicRzjXMwGW683E1nBsJ4rbSNn9svl0L
	gnfWgECDK3MA=
X-Received: by 2002:a05:651c:31db:b0:3a1:1181:b2e with SMTP id
 38308e7fff4ca-3a1fd67c986mr3121441fa.12.1787694214237; Tue, 25 Aug 2026
 14:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info> <aosGtkE_diwVJJtB@eggarch>
 <20260823174059.46fec036.michal.pecio@gmail.com> <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com> <ao1ovvdPAy6n_F7I@eggarch>
In-Reply-To: <ao1ovvdPAy6n_F7I@eggarch>
From: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Date: Tue, 25 Aug 2026 23:43:22 +0200
X-Gm-Features: AcwNN1XMZ3b0XN7GsnQg8cfRR84V6LJh9PVf6rA8xjQi1iFnVttUPqbLHwxSCcY
Message-ID: <CAPyJwA-QALkCQn8J1+=U-nuE_7WSEPhVcUEKb+MMYMaA_1AVjQ@mail.gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> If you need me to do some further tests or experiments, let me know. I w=
ill
>> be more than happy to play the guinea pig here.
> Was this result after applying the small patch I sent above?

The patch you sent makes the issue go away. I am now running the exact same
scenario for 2 hours, without any crash.

However, I am not sure if this can qualify for a proper fix, since I
do not have any
external hub connected to my motherboard: All my USB devices are directly
plugged into root hubs (and at the moment, there is only a keyboard and a
mouse).

On Tue, Aug 25, 2026 at 12:06=E2=80=AFPM Lovekesh Solanki
<lovekeshsolanki00@gmail.com> wrote:
>
> On Mon, Aug 24, 2026 at 09:37:55PM +0200, Mathieu Fluhr wrote:
> > Yes. As mentioned, I first thought that the emulator itself triggered t=
hat by
> > doing something that the CPU did not like.To be honest, I barely play w=
ith old
> > Android versions anymore, but seeing that I could reproduce it even wit=
h
> > Android 13 or 14 made me suspicious.
> >
> > I _guess_ Google implemented a workaround inside adb for version Androi=
d
> > 15 since using this version, it remains stable for more than 2 hours.
> >
> > But, in the end, the situation is that from a simple user account havin=
g access
> > to some usb plugged in devices (I usually add my user account to the pl=
ugdev
> > group and use some known udev rules to access my Android tests devices)=
,
> > you have a way to crash the complete system.
> >
> > > Opinions seem to vary on whether CPU load must be present or absent.
> >
> > On my side (and I am here only speaking about my TR. I don't know about
> > other Ryzen CPUs), I can't reproduce it under load, and one condition t=
o
> > reproduce it is my CPU going in C2 state.
> > -> I did a 2:30 hour test using several youtube videos playing at the s=
ame
> > time on my desktop, also stressing the emulator with some 3D Mark runs
> > (as mentioned, I first suspected the nvidia driver to be faulty). As lo=
ng as my
> > computer was busy everything went fine. But then I let it stand still f=
or a few
> > minutes, and it just crashed.
> >
> > If you need me to do some further tests or experiments, let me know. I =
will
> > be more than happy to play the guinea pig here.
> Was this result after applying the small patch I sent above?
>
> Regards,
> Lovekesh
