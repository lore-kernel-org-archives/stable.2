Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=88.99.38.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247744;
	b=UBRKAL6CSno2uWg1kGP6FiRyCkUiLd6MefdATU/ulRcVqq69c/CbB/ymZidgeXpH7O2r
	 1AZJ5MQWSQlwqnHAmoAo8dxXe8q6pvdU0ZHccIbXQ8kRs9EveKHsmdNtnyxbSfYirIleP
	 IW+fGOEQ9KlgaJeu3oM+amgJeQPHFV5tfEXOs3U7XkKgRP3CJWZ6yXMJ2/CZmbZl6muNl
	 uIjJKnEa64YRcUsno0lL6vm+p/0OPd4vDkkKZ1gIi9CK326yeQHfl3pSolEkqt5EBfOfp
	 wT2Gi2KzTDLisdWEO8MznRsxKhu51gu05x31pu6aNs34qkj3Gy2AN1YH0AzLzNX3Reg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247744;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Received-SPF:
	 Received:X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-PPP-Message-ID:X-PPP-Vhost:X-Virus-Scanned:
	 X-Virus-Status;
	bh=cwiXIseu1tU968JiDtE3CP1qovA+L9Xqa6a2ybeurAw=;
	b=XqttAy5oAGHTs3XEgqeVt/RQs0Q2fDAR4Ln4BrRyPQN3kHkl3IsyBOs6IBRcOXy0lxhw
	 X8m7jfh3y/fyNA3mZy5gCkp++ukLp6tTU8brNU7jUKpVkSeXUlQCxTRN0Ob9s/2cXPCHl
	 JkPSIyX8LGocbd0fnZ4QhhLe9pKw4I4yxn5k2AE0ZqC0h09F5q3ixvRiEqe8ra7iZNFuq
	 QZOSZbebluTa3EGhynsECLKEf0VGIJDtw0mWSxiffFiQNbVLlgm/vv/CiuQEUIAXjEZpN
	 8IYY3JPCp1fQ2tUBNnQ6UFrK4mOolncXUg8+oDUkg9R/sfXzht0wkx3a9HBFh/P5Y2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=antheas.dev;
	spf=pass smtp.mailfrom=antheas.dev;
	dkim=pass header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b="KS/g+yHu";
	arc=none smtp.remote-ip=88.99.38.195
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB77606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 18:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBB77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=KS/g+yHu
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id B0002BC519
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:08:53 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 90B1BBC471
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:08:52 +0200 (EET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6715F1FDC84
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:08:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1794247731;
	bh=cwiXIseu1tU968JiDtE3CP1qovA+L9Xqa6a2ybeurAw=;
	h=Received:From:Subject:To;
	b=KS/g+yHuVMNivxpmDIUwsuPjguoKLUJknx6UD/vztROK6bmrwVJeD3lDugIPWTCFH
	 fF6kf6fed4kgML954WGDwjbqva3s3dDBitgOEgbEH7OKHVwV0OtrCDiNNDU8Yj9WS7
	 HbesA6DfwWd2Nn+pzvKn0oM5cyDTfI+DlKRjsC12nZpRzrV+wdFLU6hkinck4pLu37
	 O1s6s6nZz+gKwaozeA8weechdl0aeuh/I4kMbeUaven4ZghiKeIpC2WZCPmvNsqyMH
	 YbTO6ltcPgJKgSNmDovvQNlxPWusyjyaEp6jPDNLeSuN1L2AQ9CPc1kTkEB+wXdSLZ
	 jnNBUYZc0K/tQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.51) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f51.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3b155f50c24so668442a91.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:08:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGWNDOC42rZUutAGvKCl+Lbehjr+QDJDpvbLF3dROTqc3EB6i1cKifx8VV9clsqM7HS6TvpR0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I5Hoec1uLYEAZABVHh5fm8JHVe6dQO9vW9mkiSQyNfAkV20Sh
	L/jSIRLJF0q5pqtZISljXXJ+fcZwfiY176PyAS1UCPZEXQj5N+SnpnuuqKbLcngAMXNpIa+Oj3h
	aEKC/gyZPaVITXKeDZ1rGPk5Oz5ZYylw=
X-Received: by 2002:a17:90b:54c3:b0:3ac:c024:b275 with SMTP id
 98e67ed59e1d1-3b166ae44eamr497272a91.9.1794247728146; Mon, 09 Nov 2026
 10:08:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-asus-wmi-kbd-readback-v2-1-c048fc53d8ee@proton.me>
In-Reply-To: <20261109-asus-wmi-kbd-readback-v2-1-c048fc53d8ee@proton.me>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 9 Nov 2026 19:08:37 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHtY9KU7vdsqqmXxnq4=eJtoMzt39DXYXYOVoEfi0gVkw@mail.gmail.com>
X-Gm-Features: AclHuK88t3Crb0NgSMFK1GDnzs_chBsT6_eAPi911nkNap2DTu5Yk6bYt-dwsYw
Message-ID: 
 <CAGwozwHtY9KU7vdsqqmXxnq4=eJtoMzt39DXYXYOVoEfi0gVkw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Ignore unusable kbd backlight
 WMI device on ROG Strix G814FP
To: tarrihmoad@proton.me
Cc: Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Sercan GOKMEN <gokmensercan@gmail.com>,
	Burak Goncu <burakgon12@gmail.com>, Denis Benato <benato.denis96@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <179424773129.131852.6386012814485820211@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 9 Nov 2026 at 09:17, Moad Tarrih via B4 Relay
<devnull+tarrihmoad.proton.me@kernel.org> wrote:
>
> From: Moad Tarrih <tarrihmoad@proton.me>
>
> On the ASUS ROG Strix G18 G814FP, writing a level to the keyboard
> backlight brightness in sysfs works, but reading it back always gives
> 0, and the read makes the Fn brightness keys misbehave.
>
> The firmware reports the keyboard backlight WMI device as present but
> doesn't implement it. DSTS(0x00050021) always returns 0x50000, which
> is level 0 regardless of what the actual level is, and every
> DEVS(0x00050021) write is rejected as an unsupported method. The
> keyboard backlight is actually driven by hid-asus. asus-wmi saves the 0
> as the current level on every read, and the brightness keys step from
> the saved level. So after any read, for example by the desktop or by
> systemd-backlight, the brightness-up key sets the keyboard to the
> lowest level instead of one step higher.
>
> Add a kbd_led_no_wmi quirk that makes asus-wmi treat the keyboard
> backlight WMI device as absent, and set it for this board, matched on
> the DMI board name. asus-wmi then keeps the LED registered for hid-asus
> and no longer reads from or writes to the WMI device. The entry also
> sets wmi_backlight_set_devstate which the board currently gets from
> the default quirk_asus_unknown, so nothing else changes for it.
>
> As a side effect, the kbd_rgb_mode and kbd_rgb_mode_index attributes are
> no longer created on this board, they never worked here since the firmware
> rejects those writes as well.
>
> This patch was written with the help of an AI coding assistant (Claude
> Code, Claude Opus 5.5). I reviewed it and tested it on my affected laptop.
>
> Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kbd led handlers")
> Suggested-by: Antheas Kapenekakis <lkml@antheas.dev>
> Suggested-by: Denis Benato <denis.benato@linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Moad Tarrih <tarrihmoad@proton.me>
> ---
> Tested on an ASUS ROG Strix G18 (board G814FP, BIOS G814FP.317,
> keyboard 0b05:19b6) on 7.2.14, built as DKMS modules. The keyboard
> backlight is still registered and driven by hid-asus, the attribute
> reads back the level that was set, the brightness keys step from the
> real level, and the level survives suspend/resume and reboots.
> Build-tested with W=1 against pdx86 for-next (c339f4010dea): no
> warnings. checkpatch --strict is clean.
>
> The kbd_rgb_mode and kbd_rgb_mode_index attributes are no longer
> created on this board. They never worked here: writes to kbd_rgb_mode
> are rejected by the firmware with -ENODEV, like the brightness writes.
>
> To answer Denis's questions on v1, the bug this patch fixes happens on
> the latest BIOS for this board as of writing, which is version 317.
> I only have the G814FP, so I don't know if other 2025 G814 models
> are affected, the quirk only matches G814FP.
>
> This no longer depends on Sercan GOKMEN's kbd_led_no_readback patch.
> Both patches add a field to struct quirk_entry and a DMI entry, so
> whichever lands second may need a trivial rebase.
>
> AI assistance: Claude Code was used to trace the keyboard backlight
> code in asus-wmi, run the debugfs DSTS/DEVS probes, write the patch and
> draft this message. Testing and final review were done by me on the
> hardware.
> ---
> Changes in v2:
> - Add a quirk that makes asus-wmi skip the keyboard backlight WMI
>   device on this board instead of detecting rejected writes at
>   runtime (Antheas), so no more WMI writes that are known to fail
>   are issued (Denis).
> - Link to v1: https://patch.msgid.link/20261108-asus-wmi-kbd-readback-v1-1-bf38f6400ade@proton.me
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 14 ++++++++++++++
>  drivers/platform/x86/asus-wmi.c    |  3 ++-
>  drivers/platform/x86/asus-wmi.h    |  6 ++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 3b0f3346dc60..fbdb00248be5 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -93,6 +93,11 @@ static struct quirk_entry quirk_asus_unknown = {
>         .wmi_backlight_set_devstate = true,
>  };
>
> +static struct quirk_entry quirk_asus_g814fp = {
> +       .wmi_backlight_set_devstate = true,

Make sure that wmi_backlight_set_devstate is needed

> +       .kbd_led_no_wmi = true,
> +};
> +
>  static struct quirk_entry quirk_asus_q500a = {
>         .filter_i8042_e1_extended_codes = true,
>         .wmi_backlight_set_devstate = true,
> @@ -167,6 +172,15 @@ static int dmi_matched(const struct dmi_system_id *dmi)
>  }
>
>  static const struct dmi_system_id asus_quirks[] = {
> +       {
> +               .callback = dmi_matched,
> +               .ident = "ASUS ROG Strix G18 G814FP",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "G814FP"),
> +               },
> +               .driver_data = &quirk_asus_g814fp,
> +       },
>         {
>                 .callback = dmi_matched,
>                 .ident = "ASUSTeK COMPUTER INC. Q500A",
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index b33ebdb21aa2..51fea21ff247 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2165,7 +2165,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>         asus->kbd_led.brightness_set_blocking = kbd_led_set;
>         asus->kbd_led.brightness_get = kbd_led_get;
>         asus->kbd_led.max_brightness = ASUS_EV_MAX_BRIGHTNESS;
> -       asus->kbd_led_avail = !kbd_led_read(asus, &led_val, NULL);
> +       asus->kbd_led_avail = !asus->driver->quirks->kbd_led_no_wmi &&
> +                             !kbd_led_read(asus, &led_val, NULL);
>         INIT_WORK(&asus->kbd_led_work, kbd_led_update_all);
>
>         if (asus->kbd_led_avail) {
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index b45f81b38a47..9f3769fc82f7 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -41,6 +41,12 @@ struct quirk_entry {
>         bool wmi_force_als_set;
>         bool wmi_ignore_fan;
>         bool filter_i8042_e1_extended_codes;
> +       /*
> +        * The keyboard backlight WMI device reports itself as present, but the
> +        * firmware does not implement it: reads return level 0 and writes are
> +        * rejected. Leave the backlight to hid-asus.
> +        */

See how the other quirks do not have comments? This one should not either

Other than that, it looks fine to me

Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>

Use b4 to automatically carry the tag to v3

Best,
Antheas

> +       bool kbd_led_no_wmi;
>         int key_wlan_event;
>         enum asus_wmi_tablet_switch_mode tablet_switch_mode;
>         int wapf;
>
> ---
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> change-id: 20261108-asus-wmi-kbd-readback-236245e82de8
>
> Best regards,
> --
> Moad Tarrih <tarrihmoad@proton.me>
>
>
>

