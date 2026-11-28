Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864111;
	b=Vz0M7TFIqix9IEFRcgaWBpc9OodtXZOhW0CCaR30bo0YruUmU+PxO0IuKMZP7uUFnjeQ
	 SoHrGVYhGswu34ZjprTPKXCvxWGk/sMweE4Y7fzhnvlS/v25y895+YvjiE1HKTfWX1vc1
	 zRRZFrqEk6iafsD70Dw8VnPSBE2bWJFj1Q9rBaKqvmEcQVbhv6VnlfC190hG+2QAgEA+I
	 Sm4Hdj390i+Xv43LmfKJWu7mNRgU+Xz1PxqdSY2WRxp1Dm4Qzd+RyxFtjzVhyvOyfoNq8
	 QwreQxyjh+Ch3Xs+CroSotM8QbjOGnXdu1pDI4BHRQBTD2C8M11Pkeh0x6Im+/2NsSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864111;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gxe6Vf9z5cm1CQlIWPFagALfbnbQ8SzQPVE2V7uRDVI=;
	b=RFETL4YYrgL+ViQIM7j80jb3q/93Ck2ygObAxbibAw0v+r6QZCtGX4mxHLPHBWiNUygK
	 iJYAZgIJzpYhhoqo7HVKdzicz6HOwp43MLHXArrmZcJDkSutSetiE8E7/K/SLNyEy9fA/
	 rucSPWmKUzpMVAh4dIXubmV0qwli1ab2vL6uMq4oyB8eLPEV4jXRoiciAxfQDEdK+IU8J
	 1yQPw0ywOIMS9Jb7HXUtGqpbttGm34somBmlJ3psDC0L8PH/OblMa+G7Xn9Ij3A9wGFjE
	 fYzoKYwyoSmgesxMf0VFWM8lY9iyt0q9saAQIfVL5RQ0ofEDOBYMLdMSHYusrWl3rzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=LnHim0XK;
	arc=none smtp.remote-ip=51.250.60.162
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B07606A31C;
	Sat, 28 Nov 2026 11:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B07606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=LnHim0XK
Received: from mail-nwsmtp-smtp-production-main-62 (mail-nwsmtp-smtp-production-main-62.yp-c.yandex.net)
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 14D75C0116;
	Sat, 28 Nov 2026 14:08:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-62 with ESMTPSA id C8iTWRpIjOs0-uBle5vIo;
	Sat, 28 Nov 2026 14:08:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795864100; bh=Gxe6Vf9z5cm1CQlIWPFagALfbnbQ8SzQPVE2V7uRDVI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LnHim0XK3rgPD7M2NXjJOY138EKMr77oYtple0aLbO8Cl61aUP5p0FcC/n/i9tMz+
	 vkq4c8+84qE+Ss+6MblH7p89wmAO0FiW7ynJkdm8AxodSYlY0TqB5DMkR/uggdEkQI
	 W58XNXVX6vgS/oVlLdTwzzlxKg9qjwno7t71vr1A=
Authentication-Results: mail-nwsmtp-smtp-production-main-62; dkim=pass header.i=@yandex.ru
From: Rostislav Maksimenko <Maildeltachat1@yandex.ru>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rostislav Maksimenko <Maildeltachat1@yandex.ru>
Subject: [PATCH] Input: i8042 - add reset quirk for NEC VersaPro PC-VK22TGSCN
Date: Sat, 28 Nov 2026 14:08:10 +0300
Message-ID: <20261128110810.3347-1-Maildeltachat1@yandex.ru>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the NEC VersaPro PC-VK22TGSCN the internal keyboard and the Elantech
touchpad intermittently fail to work at boot. atkbd reports:

  atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
  atkbd serio0: Failed to enable keyboard on isa0060/serio0

and the AUX port is never registered, so the touchpad does not appear at
all. Both devices work in BIOS and in GRUB, and i8042 status reads are
fine (no "Can't read CTR" / "Reset failed"), so the EC-emulated PS/2
interface simply does not accept commands until it is reset.

The failure is frequent: 22 of the last 47 boots in my journal show it,
and in all 22 the AUX port is missing as well. Rebooting usually fixes
it, which matches the EC not being ready when i8042 initializes.

Booting with "i8042.reset" fixes both devices: the last 13 boots with
that parameter show no failure and a working AUX port, with no side
effects observed. Add a DMI quirk for the model I can test. Other
VersaPro models from the same era likely need the same quirk, but I have
no unit to confirm that.

Note that DMI_SYS_VENDOR "NEC" is already used in other kernel quirk
tables (drivers/acpi/battery.c), it was only missing from
i8042_dmi_quirk_table.

Cc: stable@vger.kernel.org
Signed-off-by: Rostislav Maksimenko <Maildeltachat1@yandex.ru>
---
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 1b1c5d4..3014376 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -962,6 +962,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
+	{
+		/* NEC VersaPro PC-VK22TGSCN */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PC-VK22TGSCN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
 	{
 		/* Medion MAM 2070 */
 		.matches = {
-- 
2.47.3

