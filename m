Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.43.8.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077514;
	b=pgDsUs5lw2gz22mKiKmRP3TyaN3aphbB9sJfKkojvhl3Oxh58ZX/PBibB3Nydwojq4Ma
	 5u/+thUaJ3HEtPyGvwDYBvD3huEnnWNS5PlL55s6A/yAF3OsrlWm8DUItCwD2xAUzoRC+
	 qWWmSLUt3XU/dSF+FY0FCDorCGGXMfN4sRbwQgYM0F97Ypp2MpqKievUM91WkdOqXCFjy
	 meKvVnEqYY6Aj0fLQY1m5biXs2YhcKnO+pm3a+n39uGF8+mpd34+erU5mZzuwftGN6+RD
	 YRUP7sgrSKOnJXRhSpxbmdVnKUn+7bKkH0z3PffNJfduOAaBdp0pPduJ/XVACmYkvXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077514;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Spam;
	bh=4qnkKXVLfR9dHrecU4cjyuI/0rJgMrWvUcQTGWejsbw=;
	b=TJjLcsLR1KrJWcCjNGt25Go/9OrLMq/1x06ZU335YVSERTbZxM8gsWBPsrCJdUeNPytf
	 B9I2kF/znHyZBX4gkcERwCzNOktwamGxQx8oFzh2BjgCYhLXneuZq99dY2R2qEEre8cER
	 kkAyi9xXSPFOfL2f7DEEsVjEwQgMtpqU5vF1mwC1bXICKVEQDYStbuRIkuMx3sqLqhr4D
	 kzFOz1EAZrtSbIZC3MI92QsWVhSXl7F5rOLzDIhknzGqdhzom7JvZlqHHDKUUhiQDgo99
	 WQZzn14sUrs3CgQsG3Wnja3rPW0KjkqjYT05qR/i+tgpStx2zSUkfeSQQXvcGnqOvkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=altlinux.org;
	spf=pass smtp.mailfrom=altlinux.org;
	arc=none smtp.remote-ip=193.43.8.18
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B6606A32F;
	Thu, 19 Nov 2026 08:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C59B6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from workstation (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: petrykinpa)
	by air.basealt.ru (Postfix) with ESMTPSA id DB5F6233C0;
	Thu, 19 Nov 2026 11:38:22 +0300 (MSK)
From: silverducks@altlinux.org
To: linux-gpio@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org,
	silverducks <silverducks@altlinux.org>
Subject: [PATCH] gpiolib: acpi: Add ignore_wake quirk for Gigabyte B650 GAMING X AX
Date: Thu, 19 Nov 2026 11:38:13 +0300
Message-ID: <20261119083813.390337-1-silverducks@altlinux.org>
X-Mailer: git-send-email 2.50.1
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
X-Spam: Yes

From: silverducks <silverducks@altlinux.org>

The firmware's _AEI table on the Gigabyte B650 GAMING X AX declares AMD
GPIO pin 3 as GpioInt(Edge, ActiveLow, ExclusiveAndWake). gpiolib-acpi
requests it as "ACPI:Event" and amd_gpio_irq_set_wake() arms the hardware
S3 wake bit for that pin. The firmware then sends the signal a few seconds
after entering S3, so the machine resumes on it's own six to ten seconds
after suspend.

Pin 3 is the only wake signal the OS can see for the whole GPP7 PCIe
domain, and GPP7 has no _PRW, so ignoring this wake flag is the only way to
keep S3 reliable on this board. Wake from USB keyboards/mouse and
Wake-on-LAN through that domain is lost as a consequence, but I figure S3
not working at all is worse. The power button still wakes the machine as
normal

Quirk tested on upstream kernel v7.4-rc2.  Also tested on stable kernel
6.12, which is the version where the issue was originally diagnosed.

Signed-off-by: silverducks <silverducks@altlinux.org>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 3f89a87601c1..5455784e67c2 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -465,6 +465,23 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "GTCH7503:00@10",
 		},
 	},
+	{
+		/*
+		 * Spurious wake from S3: the firmware _AEI table declares AMD GPIO
+		 * pin 3 (GPP7 group) as Edge/ActiveLow ExclusiveAndWake, so gpiolib-acpi
+		 * requests it as ACPI:Event and amd_gpio_irq_set_wake() arms the
+		 * hardware S0i3/S3 wake bit. The firmware asserts this signal during
+		 * S3 entry regardless of the PCI wake sources configured by the OS,
+		 * waking the machine a few seconds after suspend.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gigabyte Technology Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "B650 GAMING X AX"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "AMDI0030:00@3",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.50.1

