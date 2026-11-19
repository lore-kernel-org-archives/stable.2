Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.43.8.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091370;
	b=G6+UiVjP9mrUVMID9U5lRJE6IKSD1r7JAkvdJwyCk0ZW1G6bmatGl7fZNNQVSP2wNZr9
	 j8m2ZHZMzEdV6r1+RMxcQAz4BEgJTz0p/BcbBAUCXPyeG2YVRORTtVI/sg0yo+DvZNr2I
	 6m0rys/ZXyUdB1kwWOovnMtps4cSeGc/Yj8ddC3K02TTQntikSI+m26x1TBHegvdoJ6F1
	 RrS7wtPheOViV+z7A2R3z2b9CvhgwCbRyCfJaKoj6YBiDk3WRrnmMq/B9XU1k/Pm+03d+
	 jpAcO0/jG3wIRUX6X4owgFjLmVHNo52zm5gyLxaHGhCIzq0ui1af1w/5HnHR2OmneTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091370;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:X-Spam;
	bh=KhyBQp96lxPOQN3cfVmdJP+yO+6DJ8NKvRDidFMGL2g=;
	b=mu2e8fei8hka5x8uBG7cA9fxKNgrm7w77QPdjqbXZ9RxZvvr0QH8EdV6EqQYjsMTLMkr
	 9NpXvNWF4Sr1hwKMcOjTXhOGdGlbSscmrjEKXoBdn394QsUp2nGeB3p3kR7pT0sr9f/JH
	 A296FQnAq3X+O7nUjEfDpvWKOYaKlrE/LoIr4NCj+oW2P3lohpKltIkpVAI9UpmM+DekX
	 FoM6o4s+yO22tAK+snmmB/FnkkWghFB3ZHi0/cf8eH9Jfuu/o4e250pEK+GD3ytOLuqHJ
	 lUe609RZcj6FmlxlT10FXy8rk8Rml76Msh52HYJDSDkgDnN2J/pqxjEC7WfdMpjWjvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=altlinux.org;
	spf=pass smtp.mailfrom=altlinux.org;
	arc=none smtp.remote-ip=193.43.8.18
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129A606A32F;
	Thu, 19 Nov 2026 12:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F129A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from workstation (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: petrykinpa)
	by air.basealt.ru (Postfix) with ESMTPSA id 2491D233AE;
	Thu, 19 Nov 2026 15:29:23 +0300 (MSK)
From: silverducks@altlinux.org
To: linux-gpio@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org,
	Pavel Petrykin <silverducks@altlinux.org>
Subject: [PATCH v2] gpiolib: acpi: Add ignore_wake quirk for Gigabyte B650 GAMING X AX
Date: Thu, 19 Nov 2026 15:28:45 +0300
Message-ID: <20261119122844.445945-2-silverducks@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119083813.390337-1-silverducks@altlinux.org>
References: <20261119083813.390337-1-silverducks@altlinux.org>
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

From: Pavel Petrykin <silverducks@altlinux.org>

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
normal.

Signed-off-by: Pavel Petrykin <silverducks@altlinux.org>
---
v2 - Put real name in signoff; Moved testing information to comment.

Quirk tested on upstream kernel v7.4-rc2.  Also tested on stable kernel
v6.12, which is the version where the issue was originally diagnosed.

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

