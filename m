Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686424;
	b=N3vJU58R4zqiufw+akltyFL42PWg1ZHIGNfU613LOtIfzsF2jJyBl/u2QgMCJV15CfEf
	 wsnMYDCGgPbp4CgUaSbs5CHyOggRidkLFUmEDvlxDFyGrB3FuPlANGHY9DDPuK+tcWrH6
	 NWZ21zdn+dHEE7RS2eAXI60JBbl9uKFP2sa0n3OUbY+Q011S9500yKWAjiOU2W4RVAaL7
	 dnHuRXtx2PJUCJJfx64eoUUJANeXKWl40UzYbj2fELNpYfaXIiUCCmJ/Cd/UiO9sm34+A
	 AZjs3QIfx+gbtfnwb3MPD9WZCDbm/jRFcT8a+c0Qn0z0nBt7pOcYWPh8X+EW+D21dUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686424;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=54LAz2yiMw1ZfC35z33LposRAamRb5F8Xp2rr4ddzGw=;
	b=Mm9LCB3Ue9pNfjZ/fl7S/65W2wwHo5aKvgQEbFP1JIhg3H0Gdt+01EX4D67mMA+7hOih
	 9LeNTQ9KEQPB4KLUHG13e74SZahBdeGhgmR+/4gkxfhCHj74t0DFwNqHWd21LX0mntEPT
	 JvKPCE5Iesi8O0QteYzkiVbeVoOYH3BN/WUcvJcOSnbTswcsitGk5CwrirK1gFb1AnVwL
	 i5wht6N1YzwX6rylsSocWHtYAvWwlQ3f8vh2OAA0/NHgXvYOGt+OnucAcmQ944sJbYS9Z
	 eD7IqdIDHY7jw9qo2AR9gnx2r2O2WSiqhPXL/f4IB8qv2IlSovwnzCpHh577V865Ppw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=SbaSGjfj;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41691606A319;
	Thu, 22 Oct 2026 16:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41691606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=SbaSGjfj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1792686421; x=1792945621;
	bh=54LAz2yiMw1ZfC35z33LposRAamRb5F8Xp2rr4ddzGw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SbaSGjfjdiUNo5BWiQKZEx2VunsfJzLFoSWPl8LUClqPiwiOENOXmIvmLIVftfqum
	 VMuneIS1poXWE4MiITDzEIAZ0aIKz9+/njp7b1k2SlkgIyyPIBHO1pHDJYjUEvb9uY
	 4zodON2m9AfjQqhjQPB09RlX0mYOoAHjiSFjTODZTkJkGa73aLhToarXM/d2HA72Hk
	 mMjSufKpzMG9R7A5I3DJ3irM9lg/d/6YgoVkmnCT+4Br3gfjcmZvTEe99/6PvEW5LQ
	 KtO+LPgn0Vt3GC1PtlfPTEQyIgmaTGmIrHwYAvvNOi46wrvp/1TBM0un79XpoUExsA
	 G3AANRJh2w6sg==
Date: Thu, 22 Oct 2026 16:26:57 +0000
To: stable@vger.kernel.org
From: Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>
Cc: linux-acpi@vger.kernel.org, regressions@lists.linux.dev, "Rafael J . Wysocki" <rafael@kernel.org>, Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] 6.18.57: ACPI fixed power button no longer bound, ACPI power-off ignored
Message-ID: <20261022162655.231431-1-fredericmariejoseph@protonmail.com>
Feedback-ID: 23950738:user:proton
X-Pm-Message-ID: 68cd0915601fe67b695201b30ee4d8b7804178c8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Since 6.18.57, a machine whose FADT describes a fixed-hardware power
button (QEMU's q35 machine, so Incus and other QEMU virtual machines)
ignores an ACPI power-off request.

On 6.18.57 (x86_64, CONFIG_ACPI_BUTTON=3Dy, CONFIG_INPUT_EVDEV=3Dy), in an
Incus 7.5.1 virtual machine:

- /proc/bus/input/devices lists no "Power Button";
- /sys/bus/acpi/devices/LNXPWRBN:00 exists, with no driver and no
  physical node;
- /sys/bus/platform/drivers/acpi-button exists and is bound to nothing;
- no platform device exists for LNXPWRBN;
- QEMU's system_powerdown ("incus stop") has no effect in the guest.

6.18.57 took "ACPI: button: Convert the driver to a platform one"
(stable commit 38c79dacc8063ff8a0d75ce2a900fbaff82ad94c, upstream
52d86401963666423cb9a56d117136c846093db0) as a Stable-dep-of
fe80251152fe ("ACPI: button: Fix ACPI GPE handler leak during removal").
The platform driver needs the fixed button objects to be platform
devices, but 6.18.57's acpi_bus_scan_fixed() in drivers/acpi/scan.c
still attaches them on the ACPI bus with device_attach(), where no button
driver is left; and acpi_create_platform_device() would fail on them
anyway, because acpi_dev_get_resources() returns -EINVAL for an object
without a namespace handle.

Mainline handles this (as of 7.1.8): acpi_bus_scan_fixed() calls
acpi_bus_add_fixed_device_object(), which uses acpi_default_enumeration(),
and acpi_create_platform_device() looks up resources only for
ACPI_BUS_TYPE_DEVICE objects. Those two changes, backported to 6.18.57 as
below, restore the Power Button input device, and an ACPI power-off then
shuts the guest down cleanly ("reboot: Power down" within a second of the
request). 6.18.58's ChangeLog has no fix.

I could not identify the mainline commit(s) that introduced
acpi_bus_add_fixed_device_object() and the ACPI_BUS_TYPE_DEVICE check;
picking them for 6.18.y, or reverting 52d864019636 and its dependants
there, would fix it. The diff below is offered for testing and as a
pointer, not for applying as is.

The analysis and the backport were prepared with an AI assistant
(Claude, Anthropic) and checked on the hardware above.

#regzbot introduced: 38c79dacc8063ff8a0d75ce2a900fbaff82ad94c

Thanks,
Frederic MARIE-JOSEPH

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -137,22 +137,26 @@
 =09=09}
 =09}
=20
-=09INIT_LIST_HEAD(&resource_list);
-=09count =3D acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-=09if (count < 0)
-=09=09return NULL;
-=09if (count > 0) {
-=09=09resources =3D kcalloc(count, sizeof(*resources), GFP_KERNEL);
-=09=09if (!resources) {
+=09count =3D 0;
+=09/* A fixed event button has no namespace object, so no resources. */
+=09if (adev->device_type =3D=3D ACPI_BUS_TYPE_DEVICE) {
+=09=09INIT_LIST_HEAD(&resource_list);
+=09=09count =3D acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+=09=09if (count < 0)
+=09=09=09return NULL;
+=09=09if (count > 0) {
+=09=09=09resources =3D kcalloc(count, sizeof(*resources), GFP_KERNEL);
+=09=09=09if (!resources) {
+=09=09=09=09acpi_dev_free_resource_list(&resource_list);
+=09=09=09=09return ERR_PTR(-ENOMEM);
+=09=09=09}
+=09=09=09count =3D 0;
+=09=09=09list_for_each_entry(rentry, &resource_list, node)
+=09=09=09=09acpi_platform_fill_resource(adev, rentry->res,
+=09=09=09=09=09=09=09    &resources[count++]);
+
 =09=09=09acpi_dev_free_resource_list(&resource_list);
-=09=09=09return ERR_PTR(-ENOMEM);
 =09=09}
-=09=09count =3D 0;
-=09=09list_for_each_entry(rentry, &resource_list, node)
-=09=09=09acpi_platform_fill_resource(adev, rentry->res,
-=09=09=09=09=09=09    &resources[count++]);
-
-=09=09acpi_dev_free_resource_list(&resource_list);
 =09}
=20
 =09memset(&pdevinfo, 0, sizeof(pdevinfo));
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2631,33 +2631,22 @@
 }
 EXPORT_SYMBOL_GPL(acpi_bus_register_early_device);
=20
-static void acpi_bus_scan_fixed(void)
+static void acpi_bus_add_fixed_device_object(enum acpi_bus_device_type typ=
e)
 {
-=09if (!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON)) {
-=09=09struct acpi_device *adev =3D NULL;
+=09struct acpi_device *adev =3D NULL;
=20
-=09=09acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_POWER_BUTTON,
-=09=09=09=09       false);
-=09=09if (adev) {
-=09=09=09adev->flags.match_driver =3D true;
-=09=09=09if (device_attach(&adev->dev) >=3D 0)
-=09=09=09=09device_init_wakeup(&adev->dev, true);
-=09=09=09else
-=09=09=09=09dev_dbg(&adev->dev, "No driver\n");
-=09=09}
-=09}
+=09acpi_add_single_object(&adev, NULL, type, false);
+=09if (adev)
+=09=09acpi_default_enumeration(adev);
+}
=20
-=09if (!(acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON)) {
-=09=09struct acpi_device *adev =3D NULL;
+static void acpi_bus_scan_fixed(void)
+{
+=09if (!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON))
+=09=09acpi_bus_add_fixed_device_object(ACPI_BUS_TYPE_POWER_BUTTON);
=20
-=09=09acpi_add_single_object(&adev, NULL, ACPI_BUS_TYPE_SLEEP_BUTTON,
-=09=09=09=09       false);
-=09=09if (adev) {
-=09=09=09adev->flags.match_driver =3D true;
-=09=09=09if (device_attach(&adev->dev) < 0)
-=09=09=09=09dev_dbg(&adev->dev, "No driver\n");
-=09=09}
-=09}
+=09if (!(acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON))
+=09=09acpi_bus_add_fixed_device_object(ACPI_BUS_TYPE_SLEEP_BUTTON);
 }
=20
 static void __init acpi_get_spcr_uart_addr(void)

