Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD1509EEB
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897631; cv=none; b=fpKOpQ8ZWSbNevVvwMKv9dQsP8Ulxfn8skWy6FdBAI0EHPM2UeiPrMVuraexFAmuMZ1apxAbNVtCLc5UnPfX7m/ro3C+tlgGylQkZeaQE/cdO0KaWZGiOBId9QigfoI0jcnqHI+lgeJ8ogUHAVzX7gjHeequpW98kDc5e+koSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897631; c=relaxed/simple;
	bh=SfWpeFzCfZozqPI/2/wU1hDyTChbBaE3Rj9y+bvoxtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oen7kR2jB/9R9YrlPu9KQsf3ubcG00X1e7bkfQIC7+lZz3mO9SqTNuVRgRyPZLCgGg0IWV56tJHETesTJvCgmi8iKR+9RWW8y4aYQle2e1AQ4IPulJffuXLDJh/h71IotuoKohCDrAgcW1maKvwUwAoqQ+hDjKaAEIINw6NAjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=MIe56UBz; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="MIe56UBz"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 90C783EDE0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:11:27 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id 42BC83EDE8
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:11:26 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 52E971FE56B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:11:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1791897085;
	bh=GFxruj0xCB1yX+UeCSnWfNV4l7j5hl0LNpvDVDUvRhw=;
	h=Received:From:Subject:To;
	b=MIe56UBzaue88SVph4SsogJWg0qfbZ1WV5hz1SbyiLC/2SdOjR5BzztmKqT142WZj
	 Han5EezJx7wppUYxjR3fy7jA3Wc9+LeH+mSDKqEvn+Uu+3FwYYWz+FPOG5fyG9KJhm
	 VIQ3HCjKnizvcDcFA7JhmzFTMZWRTe4BivPcpceFg1gyqub5Sfv87h3sC1PHmEyF6j
	 LJitHp2UGzDV9pSl5y65KowO9EF4pM2oVMzK0OUK/fiL0uSMgtNRPOC8PbwuH+0Kke
	 ZXD1K5+khfZ4JaURkoBnU/JZa+93j07oBrwMXkUODv1Mf9TlJWbgwFjck9aaJva0/T
	 sB9GGGoCtlAJQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-88a627ce016so878082b3a.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:11:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBya1BDWA3J8JB+sqSE2HXMQtgN0O0UXk/B/pUuYzLggDsso//bhC13FZeHqkJCVdDf2a4KwA3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrn4/DBjHgdO5oIYo0hMYfViuNRHSa65QWQWSvmcHgf6Pln8Q5
	viV2R7XFSxH9DjFtFwLNlDgRAeEdOEDiSGR+NXrP795ujTxpkdJPoXllI1bTmNyOCEqf/IF/v1S
	TZpHTR4PpkTaKmiFLndSq28gJdVXpmfk=
X-Received: by 2002:a05:6a00:ae08:b0:899:53a9:1dd9 with SMTP id
 d2e1a72fcca58-89953a92059mr5947779b3a.57.1791897083544; Tue, 13 Oct 2026
 06:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828104159.62399-1-yaseen@ghoul.dev>
 <20260828104159.62399-2-yaseen@ghoul.dev>
 <fe51a4ac-540f-4d14-ba76-b69b0eb17164@leemhuis.info>
In-Reply-To: <fe51a4ac-540f-4d14-ba76-b69b0eb17164@leemhuis.info>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 13 Oct 2026 15:11:11 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEdQ+EEjfzHM_DAtoygsch=BXR8VWd1yHeKA-BaS=hCUA@mail.gmail.com>
X-Gm-Features: AclHuK_mw5GeLN7q83Xqf5zxH9ioGqWL36THrQLkusDyW9WMlfQFfIL5e5xGjBY
Message-ID: 
 <CAGwozwEdQ+EEjfzHM_DAtoygsch=BXR8VWd1yHeKA-BaS=hCUA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: usbhid: skip interrupt IN polling for devices
 with no input reports
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Ahmed Yaseen <yaseen@ghoul.dev>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>,
	Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>,
	regressions@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <179189708558.3242464.2513955997126156346@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 13 Oct 2026 at 14:55, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 8/28/26 12:42, Ahmed Yaseen wrote:
> > usbhid starts polling a device's interrupt IN endpoint on open
> > (usbhid_open() -> hid_start_in()). If the report descriptor declares no
> > input reports there is nothing to read there, so the poll is useless,
> > and on some composite devices it is also harmful.
> >
> > The ASUS ROG N-Key keyboards expose a second, input-less interface used
> > only for RGB control via feature reports. Opening its hidraw node (any
> > hidraw reader does, including SDL/Steam Input or a plain cat) starts the
> > pointless IN poll and keypress reports on the keyboard interface get
> > dropped for as long as the node stays open: a lost key-down drops a
> > letter, a lost key-up leaves the key stuck. usbmon shows the dropped
> > reports never reach the URB layer.
> >
> > The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
> > asus: early return for ROG devices") is what exposes it on these
> > devices by keeping the input-less interface alive instead of ejecting
> > it, so its hidraw node can be opened and the poll started.
>
> Hmmm, what's the status here? Ahmed, is this still needed, or was this
> fixed in some other way? From the the outside it looks a lot like this
> regression fix feel through the cracks, but would be good to get into
> 7.4-rc1 to finally fix the dropped keypress reports.

Hi Thorsen,
there haven't been widespread issues with stuck keys on Asus recently,
except one regression with the fan key that merged recently.

This fix targets hid core, so merging it could cause regressions on
other devices.

Denis can comment on whether he fixed the regression that primarily
lies in the software he maintains separately. I am not sure SDL causes
this issue

Best,
Antheas

> Ciao, Thorsten
> > Skip the poll in usbhid_open() when the device has no input reports.
> > Feature reports and hidraw output keep working over the control and OUT
> > endpoints, so the interface is otherwise unaffected.
> >
> > Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
> > Link: https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog-strix-16-2025-with-cachyos-during-gaming/30823
> > Link: https://github.com/ublue-os/bazzite/issues/4590
> > Cc: stable@vger.kernel.org
> > Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
> > Tested-by: GameBurrow <gameburrow@pm.me>
> > Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
> > Reviewed-by: Denis Benato <denis.benato@linux.dev>
> > ---
> >  drivers/hid/usbhid/hid-core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > index 96b0181cf819..d7cf2b56e117 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -688,7 +688,14 @@ static int usbhid_open(struct hid_device *hid)
> >
> >       set_bit(HID_OPENED, &usbhid->iofl);
> >
> > -     if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
> > +     /*
> > +      * ALWAYS_POLL devices are already polled from usbhid_start(), and a
> > +      * device with no input reports has nothing to send on the interrupt
> > +      * IN endpoint. In some cases polling is harmful: on the ASUS ROG
> > +      * N-Key keyboards it makes the sibling interface drop keypresses.
> > +      */
> > +     if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
> > +         list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
> >               res = 0;
> >               goto Done;
> >       }
> >
> > base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
>
>

