Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478868;
	b=IdQjGCSEg9oiMfWLJWTs1r/AmPU4KrILGVnVFR/BQe+8xFoAw31/fftKlDsIiyrM07W7
	 kwcnOGuQF1TaptgDydfyFv5+TOyrwt+iZyPZz7+o2s+FC5PnZgQYfiVJIXTB2OPedTlwu
	 E+JPps9xAGyrT1icekQO6cu0S8rHrfeLNSBvkfgwxnMoWsXkT8Cu9Nt1eq+ZwAPAXkkMN
	 42cvvOLt6jOnYtLGnaeXEo9s5oyopMeuEZ3PG31NHi4zsM+Y8SrSlSRIodoV+vjq0PNhG
	 WVvGguEKQQl1ZjkghCPZEMHxT6MBa1zRDqHSar82q3QRwYp+QA2FP3NhSUTZAQFHT5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478868;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID;
	bh=Bd80MeNM9pTxoWBwGXjsknndsrAkhTF783e+5nYvx28=;
	b=pj/eZWqwwFfDRa9rX8u8E4/JrWqn2cQdWBzXVYenuzPqHVlxMXEKzUAVHj6i5MFEnHli
	 5XpKZcb07k0eDBSB9yOnPwwC4kS+LZczjd3k9SwD2OFL1lV1+/TpzhAqfeaO9N/YcNbcz
	 LCnNdz4MKzp28Fa3dTGJbaoPB9pRF+zoU921Y/04nEtJSDo6omKUnVaxX0XsGS+FmyFiE
	 ZhCHtfkiQMbS/GozHVJNRum4SB7++fMpD0Nb3dPd7wbpRkmicRtNTwgNdb00SyPWiykKh
	 sVbPpd6McNFyDOnRQW2CypWEkbMvnWhLOXKrnlN8Dmbm9vnaJXs1msWjLajPVItU1bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Dpohe1Kq;
	arc=none smtp.remote-ip=91.218.175.73
Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9F606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C9F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Dpohe1Kq
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Bd80MeNM9pTxoWBwGXjsknndsrAkhTF783e+5nYvx28=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794478865; v=1; x=1795083665;
 b=Dpohe1KqNJ+Q6KzplHoBcMd6A4Oe5YEaiqEtbSCYa0dXH+kmo/W//CyXqTEePnZFPr/ZcWDF
 tgSD/YudXICtqbKF3v8NvWnSafcQ586C1hx3VdzGKLd6f6V0XM+AmLbYWukhCX5H3EkH1+WipA1
 NOAwgOHNoT1fbjWaQfEYD6C4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc48a1a792d15d12;
	Thu, 12 Nov 2026 10:21:05 +0000
X-Mizu-Trace-ID: cc48a1a792d15d12
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 11:20:56 +0100
From: Denis Benato <denis.benato@linux.dev>
To: tarrihmoad@proton.me
Cc: Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sercan GOKMEN <gokmensercan@gmail.com>,
	Burak Goncu <burakgon12@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Message-ID: <04c46822-9baa-4152-8193-d8aa9d757b4e@linux.dev>
In-Reply-To: <20261111-asus-wmi-kbd-readback-v4-1-79df1567476d@proton.me>
References: <20261111-asus-wmi-kbd-readback-v4-1-79df1567476d@proton.me>
Subject: Re: [PATCH v4] platform/x86: asus-wmi: Ignore unusable kbd
 backlight WMI device on ROG Strix G814FP
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <04c46822-9baa-4152-8193-d8aa9d757b4e@linux.dev>

12 nov 2026 00:36:34 Moad Tarrih via B4 Relay <devnull+tarrihmoad.proton.me=
@kernel.org>:

> From: Moad Tarrih <tarrihmoad@proton.me>
>
> On the ASUS ROG Strix G18 G814FP, writing a level to the keyboard
> backlight brightness in sysfs works, but reading it back always gives
> 0, and the read makes the Fn brightness keys misbehave.
>

With "works" do you mean the write report success but does nothing or that =
it is actually changing the brightness?

I assumed the #1 but from this message it's unclear (to me, and I assume fo=
r others as well).

See below.

> The firmware reports the keyboard backlight WMI device as present
> without implementing it, and the backlight is actually driven by
> hid-asus. DSTS(0x00050021) always returns 0x50000, which is level 0

Always returns level zero with the presence bit set.


> regardless of what the actual level is, and every DEVS(0x00050021)
> write is rejected as an unsupported method.
>
> Add a kbd_led_no_wmi quirk that makes asus-wmi treat the keyboard
> backlight WMI device as absent, and set it for this board, matched on
> the DMI board name. asus-wmi then keeps the LED registered for hid-asus
> and no longer reads from or writes to the WMI device.
>
> As a side effect, the kbd_rgb_mode and kbd_rgb_mode_index attributes are
> no longer created on this board, they never worked here since the firmwar=
e
> rejects those writes as well.

Isn't this a contraddiction to what is written above? That writes actually =
succeeds?

>
> Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kb=
d led handlers")
> Suggested-by: Antheas Kapenekakis <lkml@antheas.dev>
> Suggested-by: Denis Benato <denis.benato@linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Moad Tarrih <tarrihmoad@proton.me>
> Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
> Tested on an ASUS ROG Strix G18 (board G814FP, BIOS G814FP.317) on
> 7.2.14: the brightness attribute reads back the level that was set, the
> Fn keys step from it, and this survives suspend and reboot. W=3D1 and
> checkpatch --strict are clean. v4 only changes the commit message.
>
> Sercan GOKMEN's B9406CAA patch also adds a field to struct quirk_entry
> and a DMI entry, so whichever lands second may need a trivial rebase.
>
> AI assistance: Claude Code (Claude Opus 5.5) was used to trace the
> asus-wmi code, write the patch and draft the commit message. I reviewed
> it and tested it on the hardware.
> ---
> Changes in v4:
> - Trim the commit message and move the AI assistance note below the
> =C2=A0 --- line (Ilpo).
> - Link to v3: https://patch.msgid.link/20261110-asus-wmi-kbd-readback-v3-=
1-646adf2b8629@proton.me
>
> Changes in v3:
> - Drop the comment on kbd_led_no_wmi (Antheas).
> - Don't set wmi_backlight_set_devstate for this board: the firmware
> =C2=A0 rejects both DSTS and DEVS on 0x00050012, so the write did nothing
> =C2=A0 (Antheas).
> - Add Antheas's Reviewed-by.
> - Link to v2: https://patch.msgid.link/20261109-asus-wmi-kbd-readback-v2-=
1-c048fc53d8ee@proton.me
>
> Changes in v2:
> - Add a quirk that makes asus-wmi skip the keyboard backlight WMI
> =C2=A0 device on this board instead of detecting rejected writes at
> =C2=A0 runtime (Antheas), so no more WMI writes that are known to fail
> =C2=A0 are issued (Denis).
> - Link to v1: https://patch.msgid.link/20261108-asus-wmi-kbd-readback-v1-=
1-bf38f6400ade@proton.me
> ---
> drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
> drivers/platform/x86/asus-wmi.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> drivers/platform/x86/asus-wmi.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> 3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/as=
us-nb-wmi.c
> index 3b0f3346dc60..9b2a4b829885 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -93,6 +93,10 @@ static struct quirk_entry quirk_asus_unknown =3D {
> =C2=A0=C2=A0=C2=A0 .wmi_backlight_set_devstate =3D true,
> };
>
> +static struct quirk_entry quirk_asus_g814fp =3D {
> +=C2=A0=C2=A0 .kbd_led_no_wmi =3D true,
> +};
> +
> static struct quirk_entry quirk_asus_q500a =3D {
> =C2=A0=C2=A0=C2=A0 .filter_i8042_e1_extended_codes =3D true,
> =C2=A0=C2=A0=C2=A0 .wmi_backlight_set_devstate =3D true,
> @@ -167,6 +171,15 @@ static int dmi_matched(const struct dmi_system_id *d=
mi)
> }
>
> static const struct dmi_system_id asus_quirks[] =3D {
> +=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .callback =3D dmi_matched,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ident =3D "ASUS ROG Strix G18 G814=
FP",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_MATCH(D=
MI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_MATCH(D=
MI_BOARD_NAME, "G814FP"),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D &quirk_asus_g814fp=
,
> +=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .callback =3D dmi_matched,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ident =3D "ASUSTeK COMPUTER I=
NC. Q500A",
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index b33ebdb21aa2..51fea21ff247 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2165,7 +2165,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
> =C2=A0=C2=A0=C2=A0 asus->kbd_led.brightness_set_blocking =3D kbd_led_set;
> =C2=A0=C2=A0=C2=A0 asus->kbd_led.brightness_get =3D kbd_led_get;
> =C2=A0=C2=A0=C2=A0 asus->kbd_led.max_brightness =3D ASUS_EV_MAX_BRIGHTNES=
S;
> -=C2=A0=C2=A0 asus->kbd_led_avail =3D !kbd_led_read(asus, &led_val, NULL)=
;
> +=C2=A0=C2=A0 asus->kbd_led_avail =3D !asus->driver->quirks->kbd_led_no_w=
mi &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 !kbd_led_read(asus, &led_val, NULL);
> =C2=A0=C2=A0=C2=A0 INIT_WORK(&asus->kbd_led_work, kbd_led_update_all);
>
> =C2=A0=C2=A0=C2=A0 if (asus->kbd_led_avail) {
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-=
wmi.h
> index b45f81b38a47..e53c6b3fc619 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -41,6 +41,7 @@ struct quirk_entry {
> =C2=A0=C2=A0=C2=A0 bool wmi_force_als_set;
> =C2=A0=C2=A0=C2=A0 bool wmi_ignore_fan;
> =C2=A0=C2=A0=C2=A0 bool filter_i8042_e1_extended_codes;
> +=C2=A0=C2=A0 bool kbd_led_no_wmi;
> =C2=A0=C2=A0=C2=A0 int key_wlan_event;
> =C2=A0=C2=A0=C2=A0 enum asus_wmi_tablet_switch_mode tablet_switch_mode;
> =C2=A0=C2=A0=C2=A0 int wapf;
>
> ---
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> change-id: 20261108-asus-wmi-kbd-readback-236245e82de8
>
> Best regards,
> --=C2=A0
> Moad Tarrih <tarrihmoad@proton.me>

