Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399594;
	b=EiFOihbIZAWtldyeYedwAB3QNcdMXPBsFuB8qakGmufWzMDh34uj9JY+wr3h4BE1hJKT
	 sGfHHepP4otutudoSMjeGbtTspLFphenOMZxWQn3mziC114e2O2QMpQ/o+8G1VxI5gxMT
	 D17rqFYk2UGGqauAYSbMwbTY6NCLI1XoWqOk+R3RZa3OzG1M+XDfwULW4WLULHvm73/9p
	 OIcyciTujDWr0lFv0KqUfGZ0pjVMx0i7TI4t0HDX6a9+2/Qo0ROmOH0WUQAYn+i8SLMiZ
	 y1u4nP/HDoaWq/9UalNv2PD8AmoS9ueUM1k+Bx57rgjx8yxkqB3C+yzXQ8pUOkp5oXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399594;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=j0AhxUhrLJVyiS9LamjeO4ZOqBJa+SlV8QCjSr0r9B0=;
	b=dkdCkhlhrhdYs6SFqgu+goVFmTxwhRJnDrd+WnthLmGNd7eB511jukXCPxeNkwe1hOlw
	 J/rG/+p6FHuYkezi++VoF+knpqbAwPC9P/z/BwXLD5+xMi+7djYY2rNVLJguQKGHKXbg5
	 S9Qh4/uw0pT0DWCn/OYd770uw1pMFsAEGS0TB4QY/rBUEU7buTVfxgRsGUpQ4M/EliD66
	 Rxmc332M9UtrrVzxdPUaJYW2jg8AIfXVsxNtaJgqOcCGA1d3JrmfLe0H5ozK8l+LM/XtH
	 8sDZDW2k8yx4ZM72ob6ZcCuTag4FhJgwdzleNhn9xoyFB2dpFY70Kck48wPpFg7QsvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ArEkJ5LM;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF41606A31C;
	Wed, 11 Nov 2026 12:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF41606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ArEkJ5LM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794399595; x=1825935595;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1tVgXZ21bFyIt+s7SyM9x+EraDmYzYOS+XlHSPdxZEA=;
  b=ArEkJ5LM6gqZOxxmK5RuTymBn6OGJ+bSFOtkrDlqRlnia+73n8p0oTf5
   QSOcZRNQLKuNEKNzS4CBinQJdvBnpt0Z+Sk3n2uQ9gDuk1hVkcQyBoBci
   UoDONmuUadHLSd84ho7rwzLKeCbRDPZ9gUjYLaSAdrOLLuVyTSzv2+++i
   Aa9TscSxvd7di4p+usfZr1HJGB+fMlmPzXDtbUdYxpVO4M87ejqaMiHtN
   gP6MFJLlf0gSVG+wnluUN70sAo6YFwm8ReJl+rm2jwMvanIyUfYqHbp/G
   wFXiN4lS1szw9RqexSgxS7RxpO1q1p8wGf9+/pMfOQgayrQhLZr/2WsOV
   g==;
X-CSE-ConnectionGUID: XoWtpXSwTveqogSbeiY66g==
X-CSE-MsgGUID: BfX6eRG9Th6K3HTWoeEm0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3063047"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3063047"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:19:54 -0800
X-CSE-ConnectionGUID: Ifc0LpwsRyyx1b+wTxLq4A==
X-CSE-MsgGUID: pN8Sh8OsTh2OdbZPbgkcrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8383013"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:19:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Nov 2026 14:19:46 +0200 (EET)
To: Moad Tarrih <tarrihmoad@proton.me>
cc: Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
    Hans de Goede <hansg@kernel.org>, Antheas Kapenekakis <lkml@antheas.dev>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sercan GOKMEN <gokmensercan@gmail.com>, Burak Goncu <burakgon12@gmail.com>, 
    Denis Benato <benato.denis96@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: asus-wmi: Ignore unusable kbd backlight
 WMI device on ROG Strix G814FP
In-Reply-To: <20261110-asus-wmi-kbd-readback-v3-1-646adf2b8629@proton.me>
Message-ID: <358b5f4f-d7ed-2e5c-81a0-f5640e3e12c0@linux.intel.com>
References: <20261110-asus-wmi-kbd-readback-v3-1-646adf2b8629@proton.me>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Nov 2026, Moad Tarrih via B4 Relay wrote:

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
> keyboard backlight is actually driven by hid-asus.

> asus-wmi saves the 0
> as the current level on every read, and the brightness keys step from
> the saved level. So after any read, for example by the desktop or by
> systemd-backlight, the brightness-up key sets the keyboard to the
> lowest level instead of one step higher.

This seems just unnecessary fluff. LLMs tends to overword changelogs, 
please be mindful with that when reviewing the output you got from LLM.

> Add a kbd_led_no_wmi quirk that makes asus-wmi treat the keyboard
> backlight WMI device as absent, and set it for this board, matched on
> the DMI board name. asus-wmi then keeps the LED registered for hid-asus
> and no longer reads from or writes to the WMI device.
> 
> With its own quirk entry, the board no longer gets
> wmi_backlight_set_devstate from the default quirk_asus_unknown. That
> flag makes asus-wmi write DEVS(0x00050012, 2) at probe, but this
> firmware rejects both DSTS and DEVS on 0x00050012 as unsupported
> methods, so the write never did anything here.

I think this paragraph too just makes changelog longer for no reason.

> As a side effect, the kbd_rgb_mode and kbd_rgb_mode_index attributes are
> no longer created on this board, they never worked here since the firmware
> rejects those writes as well.
> 
> This patch was written with the help of an AI coding assistant (Claude
> Code, Claude Opus 5.5). I reviewed it and tested it on my affected laptop.

Notes on how a patch was prepared belong under --- line.

> Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kbd led handlers")
> Suggested-by: Antheas Kapenekakis <lkml@antheas.dev>
> Suggested-by: Denis Benato <denis.benato@linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Moad Tarrih <tarrihmoad@proton.me>
> Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
> Tested on an ASUS ROG Strix G18 (board G814FP, BIOS G814FP.317,
> keyboard 0b05:19b6) on 7.2.14, built as DKMS modules. The keyboard
> backlight is still registered and driven by hid-asus, the attribute
> reads back the level that was set, the brightness keys step from the
> real level, and the level survives suspend/resume and reboots. v3
> was retested the same way, and the screen backlight
> (nvidia_wmi_ec_backlight) still works without
> wmi_backlight_set_devstate.
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
> Changes in v3:
> - Drop the comment on kbd_led_no_wmi (Antheas).
> - Don't set wmi_backlight_set_devstate for this board: the firmware
>   rejects both DSTS and DEVS on 0x00050012, so the write did nothing
>   (Antheas).
> - Add Antheas's Reviewed-by.
> - Link to v2: https://patch.msgid.link/20261109-asus-wmi-kbd-readback-v2-1-c048fc53d8ee@proton.me
> 
> Changes in v2:
> - Add a quirk that makes asus-wmi skip the keyboard backlight WMI
>   device on this board instead of detecting rejected writes at
>   runtime (Antheas), so no more WMI writes that are known to fail
>   are issued (Denis).
> - Link to v1: https://patch.msgid.link/20261108-asus-wmi-kbd-readback-v1-1-bf38f6400ade@proton.me
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
>  drivers/platform/x86/asus-wmi.c    |  3 ++-
>  drivers/platform/x86/asus-wmi.h    |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 3b0f3346dc60..9b2a4b829885 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -93,6 +93,10 @@ static struct quirk_entry quirk_asus_unknown = {
>  	.wmi_backlight_set_devstate = true,
>  };
>  
> +static struct quirk_entry quirk_asus_g814fp = {
> +	.kbd_led_no_wmi = true,
> +};
> +
>  static struct quirk_entry quirk_asus_q500a = {
>  	.filter_i8042_e1_extended_codes = true,
>  	.wmi_backlight_set_devstate = true,
> @@ -167,6 +171,15 @@ static int dmi_matched(const struct dmi_system_id *dmi)
>  }
>  
>  static const struct dmi_system_id asus_quirks[] = {
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG Strix G18 G814FP",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "G814FP"),
> +		},
> +		.driver_data = &quirk_asus_g814fp,
> +	},
>  	{
>  		.callback = dmi_matched,
>  		.ident = "ASUSTeK COMPUTER INC. Q500A",
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index b33ebdb21aa2..51fea21ff247 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2165,7 +2165,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  	asus->kbd_led.brightness_set_blocking = kbd_led_set;
>  	asus->kbd_led.brightness_get = kbd_led_get;
>  	asus->kbd_led.max_brightness = ASUS_EV_MAX_BRIGHTNESS;
> -	asus->kbd_led_avail = !kbd_led_read(asus, &led_val, NULL);
> +	asus->kbd_led_avail = !asus->driver->quirks->kbd_led_no_wmi &&
> +			      !kbd_led_read(asus, &led_val, NULL);
>  	INIT_WORK(&asus->kbd_led_work, kbd_led_update_all);
>  
>  	if (asus->kbd_led_avail) {
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index b45f81b38a47..e53c6b3fc619 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -41,6 +41,7 @@ struct quirk_entry {
>  	bool wmi_force_als_set;
>  	bool wmi_ignore_fan;
>  	bool filter_i8042_e1_extended_codes;
> +	bool kbd_led_no_wmi;
>  	int key_wlan_event;
>  	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
>  	int wapf;
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

-- 
 i.

