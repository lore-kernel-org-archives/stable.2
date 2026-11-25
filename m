Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645275;
	b=4450d4JQ8+Xsiv54sq1FDToWeGMA2VBPjsGKQkstdOEa08WNw0lX8UPOnNGDpH+2X3Fk
	 XD+bA2gL9t36mgzGz1eh1T8jRYXWPJrkxzkJQv2lhU7EVrFu/LtopVIVCPjtNkMNIZGje
	 KpJTgszhWUT1B516s8fKhIuEKxSTxtAZMVfxrjDwzPtqLq/GuK6LsghRRpa5I0ljvTYll
	 JTuxwrIkr6Ngjl16XXgCQcLtCKwYX7reSKoW/CBKiZpaaERREI9CkPExXn4DBBIPlGPPC
	 M7Zl3/7AGy0dU0fv/D3lRIE5MgAOscMW0ZJb4b9ELNjo4IsMg5hlNI9L3RM3OK6YdEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645275;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=11TDe3gS9pRX0XRL1VMGKFlVGcY2lBYMb+DakDAFDDY=;
	b=S40XHr3rvvgH+trhORQzkRyIBkiVfl8RjbsxaTgeiWCtOlYA2l84jAe2uGGHubsQhZ2P
	 flP2f8l9i2MH8EkyvfWboIUeIFpxDw4vNK7BiPqLx/xpjHgUfaUqxxXFHtYxqv19Zpjjg
	 SzOJgEFVIBEhnaCHBToR6/zcDFTYaVnkDFbv9VBDXWjrWBxRlYjL1hfXwCfHinTJtumqF
	 cJUvzAtPJdWcy3rMIYBSboTl37VM7PdF/oLysZ2mf0etX4SWBY6yNbzfH5GQmJfDKHtf/
	 neU2XY4CuucRK1VL6MG3zjFaMQo9Qpur/YEfP0X2VCLD//AAb9B9t/2u7iTNpLQhkkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IN+WP60s;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C61606A321;
	Wed, 25 Nov 2026 22:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C61606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IN+WP60s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795645275; x=1827181275;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Sp9nuAmHBRpQpIajIScS71fCF/afPcXY+L+/0tVamVI=;
  b=IN+WP60s1LO4aMcSGSh2zAtabXJm0av8/eE2od72NjhcnKiluxPqbP+t
   /zHHbOAmpQLMuLpt6brTwzijVzx/idR71fYwm3u5+kWpJp0SPYflCLtbl
   NtFcp2GOdIWoYAdxa0bKvgmoEun4URvUXrK11wC7u5tDrloP52uGGrsXv
   jjdtKu3isVSm7AK09iV0LBeFI1QF/FOZuJAjnFT3FjuSlTF/Fn+C5fofN
   eNc71y7EgQ4QIf+wEkqV9LZIVv4/HALJUasHkDJHu63cddvB5uthu0q1W
   0msidQW27mlLeFXQ+akzYa4+zbJ6fyaeaxC1LFI7cUBHUv0LTDARafG94
   Q==;
X-CSE-ConnectionGUID: rHyG03erTbWfKjWnGzOnOg==
X-CSE-MsgGUID: PRZ4uxisTzW+ycyPZKepRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4555964"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4555964"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:21:14 -0800
X-CSE-ConnectionGUID: ia7PWoQDQsqVwihGocCofg==
X-CSE-MsgGUID: OuM3TZL+SbuGiE531UNmZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12314873"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:21:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Nov 2026 00:21:05 +0200 (EET)
To: Bartu Alev <bartualev@gmail.com>
cc: Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
    Hans de Goede <hansg@kernel.org>, Antheas Kapenekakis <lkml@antheas.dev>, 
    Benjamin Tissoires <bentiss@kernel.org>, Alex Bogusta <alex@bogusta.com>, 
    Denis Benato <benato.denis96@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] platform/asus: asus-wmi: clamp keyboard brightness
 hotkey updates
In-Reply-To: <20261121-b4-asus-kbd-fixes-v2-1-52cda07d233f@gmail.com>
Message-ID: <2ed99bdc-21f6-6dab-8a19-25d7d5061fae@linux.intel.com>
References: <20261121-b4-asus-kbd-fixes-v2-0-52cda07d233f@gmail.com> <20261121-b4-asus-kbd-fixes-v2-1-52cda07d233f@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1409852672-1795645265=:1189"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1409852672-1795645265=:1189
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 21 Nov 2026, Bartu Alev wrote:

> The NOTIFY_KBD_BRTUP/DWN/TOGGLE handlers pass led_value =C2=B1 1 into
> kbd_led_set_by_kbd(), which stores the value into asus->kbd_led_wk
> without clamping it. Pressing brightness-down at level 0 drives the
> cached level negative (-1, -2, ...); kbd_led_update_all() then drops
> every hardware update on its "value >=3D 0" check while
> led_classdev_notify_brightness_hw_changed() hands the wrapped negative
> to userspace, so brightness_hw_changed reports 4294967294+ or ENODATA
> and the brightness-up key appears dead until the counter climbs back
> to 0. Pressing brightness-up at maximum reports 4, above
> max_brightness.
>=20
> Compute the level as int and clamp it in kbd_led_set_by_kbd(): the
> stepping must happen in a signed type, because enum led_brightness is
> an unsigned type in practice and 0 - 1 passed through it wraps to a
> value that clamps to full brightness instead of staying off.
>=20
> Also clear kbd_led_notify when snapshotting it in
> kbd_led_update_all() instead of after updating the hardware, so a
> keypress queued while the worker runs is not swallowed by the late
> clear.
>=20
> This addresses the same bug as Alex Bogusta's earlier patch
> (reviewed by Denis Benato) [1], while also closing the kbd_led_notify
> race in kbd_led_update_all()."

Yeah, and that's why you should have made a separate patch for the other=20
thing. Don't mix logically separate changes into a single change.

=2E..Also, Alex's patch is already applied.

--=20
 i.

> [1] https://lore.kernel.org/r/20261016015117.32174-1-alex@bogusta.com/
>=20
> Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kb=
d led handlers")
> Cc: stable@vger.kernel.org
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Cc: Alex Bogusta <alex@bogusta.com>
> Cc: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Bartu Alev <bartualev@gmail.com>
> ---
>  drivers/platform/asus/asus-wmi.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/platform/asus/asus-wmi.c b/drivers/platform/asus/asu=
s-wmi.c
> index b33ebdb21aa2..f1a94bcdb0c0 100644
> --- a/drivers/platform/asus/asus-wmi.c
> +++ b/drivers/platform/asus/asus-wmi.c
> @@ -1784,6 +1784,7 @@ static void kbd_led_update_all(struct work_struct *=
work)
>  =09=09registered =3D asus->kbd_led_registered;
>  =09=09value =3D asus->kbd_led_wk;
>  =09=09notify =3D asus->kbd_led_notify;
> +=09=09asus->kbd_led_notify =3D false;
>  =09}
> =20
>  =09if (!registered) {
> @@ -1806,11 +1807,8 @@ static void kbd_led_update_all(struct work_struct =
*work)
> =20
>  =09if (value >=3D 0)
>  =09=09do_kbd_led_set(&asus->kbd_led, value);
> -=09if (notify) {
> -=09=09scoped_guard(spinlock_irqsave, &asus_ref.lock)
> -=09=09=09asus->kbd_led_notify =3D false;
> +=09if (notify)
>  =09=09led_classdev_notify_brightness_hw_changed(&asus->kbd_led, value);
> -=09}
>  }
> =20
>  /*
> @@ -1958,10 +1956,16 @@ static int kbd_led_set(struct led_classdev *led_c=
dev, enum led_brightness value)
>  =09return 0;
>  }
> =20
> -static void kbd_led_set_by_kbd(struct asus_wmi *asus, enum led_brightnes=
s value)
> +static void kbd_led_set_by_kbd(struct asus_wmi *asus, int value)
>  {
> +=09/*
> +=09 * The hotkey callers step the level by one, which must happen in
> +=09 * a signed type: enum led_brightness is an unsigned type in
> +=09 * practice, so -1 passed through it wraps to a value that clamps
> +=09 * to ASUS_EV_MAX_BRIGHTNESS instead of staying off.
> +=09 */
>  =09scoped_guard(spinlock_irqsave, &asus_ref.lock) {
> -=09=09asus->kbd_led_wk =3D value;
> +=09=09asus->kbd_led_wk =3D clamp_val(value, 0, ASUS_EV_MAX_BRIGHTNESS);
>  =09=09asus->kbd_led_notify =3D true;
>  =09}
>  =09queue_work(asus->led_workqueue, &asus->kbd_led_work);
> @@ -4677,7 +4681,7 @@ static int asus_wmi_get_event_code(union acpi_objec=
t *obj)
> =20
>  static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
>  {
> -=09enum led_brightness led_value;
> +=09int led_value;
>  =09unsigned int key_value =3D 1;
>  =09bool autorelease =3D 1;
> =20
>=20
>=20
--8323328-1409852672-1795645265=:1189--
