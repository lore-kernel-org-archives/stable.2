Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794265833;
	b=bM5IxkUqOYItr0jMN/LAMrvJzv7MB7/BHVksirH3j+JsK3aTqnmqfu229nbYsGQO6Lmp
	 TmxHWI0mrIRMXWh08+h/LeA/V4omff5bMGOY5YKoqaY725O52MDa1RDfXKaEkUTamFYYv
	 U+jaExiqCpWxZa5gtzijjr6TkxAjGW01RadgoArdEcgNjS6DT3j3Tca//gPu825NkDfe2
	 RZ45oCfXXhCcB4WINt2r4EeUwZgUP3EFihQePtqg4ZzbW4dZVJJd3tWF1noW59NpEIpeD
	 33Zxwu7o/CjCDy6wMYtV9KaAfIi/WBhNCd1apLP4WO4wPa5BE5Jt7UY/eQlp3xuFX0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CeN01vbNZQ47eEh9Avoe0zLX5olmSueBg1N4z40LWa8=;
	b=fBotk81pyaiIngsU6g8MLZMIzSh4SyLteENBoqytuhk6PjMS9NDMSaRiOQsBv0DsylUM
	 69ZIKiyBx3I4vgxggpnTG+7irTSN9l/RXK8+NTJ2rsHECWeITfaeJ2jwI1SoDLYh9KUeN
	 nPeC2YjoURyqLwx9rOFmlWEGVXk1NVhDMZahnicbBoLbDYxHUi96mMygVeepBdm6TCkwV
	 4bRnl9QUAfVYSVn7FE1iw7KrzOMBwhYI8KF5FUrznu8CXj26ugKe85XJ1lW3m5+wAfH81
	 5iOjVRbtXwkgPxhEYgMwwT6fMI6oz805ijRQ8VAHOyaSBD/kE4VvktICzxyPzJfaQDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyvQ6R4u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9DC606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9DC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EyvQ6R4u
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fb88ea38cso1738822eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:10:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794265832; cv=none;
        d=google.com; s=arc-20260327;
        b=jCDQuT2Fb3JJh2ZmLcIFUl0LfknAb5ws/3EWQoGZxB0p+zCCqX9FxV9Wy+xEHngJ9f
         fUuo5fl3nC8YQqDDg6MBgdC6pAG0jXPnIsyCh02wqdLS9e9lw7vB3gFpngh3XKyojkCW
         WPMg7jW78xOYvZCBh1Hm3a6VEF1Jy/dLu7qFlRh2CeQKOrS/E0I0AQMXm0/WVYNErrXM
         3lJsa0T1e3so8Y5hJmyjkyGow7N2wqqNij7WktHs7NkHznWE1mYD1eG7IOqlMkkH4Wki
         CoRzLf1t/T6hPRJxkt42O6iprwHVjgLgmMHH3g3PQUS8vteuLSqlQ9Ieb9eXNXP1ovRe
         ab6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeN01vbNZQ47eEh9Avoe0zLX5olmSueBg1N4z40LWa8=;
        fh=WZthPPhyCC5N5MCEL8YyDo4uF8L07Ee1wstY8AHCcQk=;
        b=i158YyResb1P9qVlgX9teoMN/yUyIGq90ZKhrJu88TTd4DgeruCKLhY7lRM/eM+AMJ
         eKlSgFtWKF/9aEdVSdfizJ77K0J5i0LB1Qr3WfIQwhGOnjmi8627wY42FTkygiSUIqYL
         CnIndDt5YIXhsBp5CIZ4ciVHgcI8I2pTbo7uhJGL6SyxEH1rxJwo5OTKXpJprOI7xZOy
         AvHSiL5jmOckWBbOez7hEFwRJQQVrrjrwdKGiU2Eii4gOzZF8hmNiCupS6ye/Jm50l5E
         p7C63NfEpNxuwVBiLIptqECK4CvWiRepwHP42qY3xAadpxx+Frn4JF9oUqqwiEKjgTk4
         8Ylw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794265832; x=1794870632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CeN01vbNZQ47eEh9Avoe0zLX5olmSueBg1N4z40LWa8=;
        b=EyvQ6R4uuyXmviqq7ZVFqZIFzQlkiXqW9tfrgKAUWTUMgV7dMQBh1mEEhVmD4UEPb5
         Goo3/UnI9VUq5+7khqIGuT1ZRYmY6BlIQIp8HLMByVsQWd2cjM9jNCx67yvWhHBixbz7
         DNmzzau0JrGagxIBLKv7MHt92YwMo4fDKtmFeIHo3uJfMpv2FOWMg0pp4TxD40unWdsN
         KxZ6drl1lU+A/h20VoRB4e1EHzmFJ24GJ8LxHoR+2Vi9vpCzTjJH4tPZ4xgkAhZ8IxiB
         3jIbuH9mLBZRUVGxc10Yh40mt/eyFd9ZmXOZorIJfhdL6+ye+vUgiwCcWbouK0AYYo11
         NhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794265832; x=1794870632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeN01vbNZQ47eEh9Avoe0zLX5olmSueBg1N4z40LWa8=;
        b=fDTcxCnZm39g00vDDP0cwRenvoExQHHDNuTT/iSOCiEx72bdAC/MYhPyDFGBRmcOGu
         CVgkqdHfvVpjar7kjwn6hsYDNYtpzi4Yd3BzjHbjTOI6ZN/wPfoJdC9RfUkjrXgV/u6b
         9iYD1TxcVZon+6vDB7OzqGvSQSJCqH3PpqIP5+yfpGHqJM5hMKYWLR49wSG3Z2F6jmbN
         cvAxmTPeYEXqPOSoTbySI3y158QEjrIHrmz5n6iMILfeQMP2wqsM4UhGk1U4ZhihSpxI
         gJEQdmmC01pmXyBUhEbLUmIABpUDq5BiCgATTEpHYLG8vyOgOqSaXducsoxQFn3L7Qva
         ++FQ==
X-Forwarded-Encrypted: i=1; AL+hErHFyCHdejrJuDJVvkMcCdjPopeA0RQC2h7J5Uzmc5HkhMPTqaoWhrSUMM63tt2LTxnFxwnIsYM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7Uxw663qbRrcy1jGUMyOgPQesw51e708HuoQpJa+32bKGboEQ
	UimFL3F26dAs6zDDDt1/9T9R52jtwjFBAuxcU2jJFht8Qbki9an7Peb8QuIklK4dqNUml2QbnvI
	IcXAxOHPW1NxgnVkVmAv+es+KwaZ0WO4=
X-Gm-Gg: AYBFou36rIIjstCw5ZsqIxj6T8Exa9L4/WsoagYh73L5PdHzQHC+kFf8SSC7Hv2oKKf
	ovywQ8HKzxtlzZHYSe11nGJP5H0A5GFml87jq4QlC/P0vdMyNsYnoS3x6S3cgIX+qPFVZ4pJlKd
	tOMdhkF712jSSlOCWc1IyYN4jivhGUb2TKiAxPUIHMTK3CunJZV3Nd5JodLv2MrZL1mTP4fSxOc
	Ogd/JlgBm6Rex3FOBWc2bGwhzjg/tyNMeRSoGugCx441QVCKrux+vCAUoGayDC8p6fHY0WhBus9
	/kb3dyxx9HErh2vorVEpg8rJkXoTz8eUaje9JFjMSDT901GzkJ+ZxAqUJeO9SGQBK58514J8Vtv
	oIA4Bx2gVoqjeiOvA8aSrEkH/aINXvoFtsb6l
X-Received: by 2002:a05:7022:3a0b:b0:14a:a6dc:9cbf with SMTP id
 a92af1059eb24-1b3b603b42cmr1305082c88.4.1794265831769; Mon, 09 Nov 2026
 15:10:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925205226.883724-1-ciro.pedrini@gmail.com> <asR-FLwLfpyT8uOz@archlinux>
In-Reply-To: <asR-FLwLfpyT8uOz@archlinux>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Mon, 9 Nov 2026 20:10:19 -0300
X-Gm-Features: AclHuK8TyNRcPp0b9z7lECemH9V0gwfILnthmI4geEHwNdHTffkXe_9drxx8YF0
Message-ID: <CAPKD0HdhnN6apu1jJpXEG1mAV1=GCA-rjBdt=xQsVX4KknW8mQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add OMEN board 8A17 thermal profile support
To: Krishna Chomal <krishna.chomal108@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Krishna, sorry for my late response.

Unfortunately, I can't right now. I fixed a power usage issue on it
(the performance mode wasn't really using the expected and reported
wattage, perhaps you encountered the same thing?) and it died a few
weeks later.

Guess it was used to running on low energy and decided "enough is enough".

It's at a repair shop now, so if it comes back to life in a few weeks
and you still need the dump, I'll gladly send it over.

El mar, 6 oct 2026 a la(s) 1:52=E2=80=AFa.m., Krishna Chomal
(krishna.chomal108@gmail.com) escribi=C3=B3:
>
> On Fri, Sep 25, 2026 at 05:52:26PM -0300, Ciro Pedrini wrote:
> >The HP OMEN 17-ck1xxx (board 8A17) isn't in omen_thermal_profile_boards,
> >so hp-wmi uses the generic thermal profile query. The firmware only
> >stores that value and never acts on it, so the EC stays in its default
> >mode and the CPU is held at 45 W whatever profile is selected.
> >
> >The board uses the OMEN interface (mode byte at EC 0x95, thermal policy
> >v1) and also needs the timed profile quirk: without it, the EC drops
> >back to the default mode about two minutes after each profile change.
> >
> >Add 8A17 to omen_thermal_profile_boards and
> >omen_timed_thermal_profile_boards.
> >
> >With this, all three profiles work and sustained package power under
> >load goes from 45 W to 56-79 W.
>
> Hi Ciro Pedrini,
>
> I was working a patch[1] involving omen_timed_thermal_profile_boards[]
> and needed some diagostic info. Would you mind attaching the acpidump
> for your board 8A17?
>
> Thanks!
>
> [1]: https://lore.kernel.org/platform-driver-x86/asPy5Q5wNYaMzTqJ@archlin=
ux/#m922ff6cf9a68285d2b0f64e578fd6d2d6fa573f4
>
> >Cc: stable@vger.kernel.org
> >Assisted-by: Claude:claude-opus-5-5
> >Signed-off-by: Ciro Pedrini <ciro.pedrini@gmail.com>
> >---
> >
> >Notes:
> >    Tested on 7.2.7, whose OMEN profile code matches for-next. Without t=
he
> >    timed quirk, EC 0x63 counts down from about 120 after each profile
> >    write, and at zero the EC resets 0x95 to 0x30.
> >
> >    8A13, 8A14, 8A16 and 8A18 appear in the same DSDT. 8A18 is in the OM=
EN
> >    list but not the timed one, so it may have the same two-minute
> >    fallback. I can't test it.
> >
> >    I used an AI assistant (Claude) for the ACPI analysis and to draft t=
his
> >    message. I tested the change on my machine and reviewed everything.
> >
> > drivers/platform/x86/hp/hp-wmi.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/=
hp-wmi.c
> >index 7ab81ce5f..76f489d5d 100644
> >--- a/drivers/platform/x86/hp/hp-wmi.c
> >+++ b/drivers/platform/x86/hp/hp-wmi.c
> >@@ -207,7 +207,7 @@ static const char * const omen_thermal_profile_board=
s[] =3D {
> >       "886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "=
88F6",
> >       "88F7", "88FD", "88FE", "88FF",
> >       "8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "=
89EB",
> >-      "8A15", "8A18", "8A42", "8A43",
> >+      "8A15", "8A17", "8A18", "8A42", "8A43",
> >       "8BAD",
> >       "8E41",
> > };
> >@@ -226,7 +226,7 @@ static const char * const omen_thermal_profile_force=
_v0_boards[] =3D {
> >  * "balanced" when reaching zero.
> >  */
> > static const char * const omen_timed_thermal_profile_boards[] =3D {
> >-      "8A15", "8A42",
> >+      "8A15", "8A17", "8A42",
> >       "8BAD",
> > };
> >
> >
> >base-commit: f475845eaf3d749114a63270bf2efea459e14dd2
> >--
> >2.55.0
> >
