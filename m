Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287356;
	b=KTJ01KOd/RKFxWKn8E/GEtYA+21y1EYtthpTM5F6TJ9RiuRJNuoK0fa/jPEwfdYVJwto
	 pynTyRXd/kmY4nxa8Vbnq3dla8M+MLUuEf7wNCrqXQ4keeK38rrAP1JAf/WxHpQ7kCUd9
	 HJv6x/Qw2C4mGqJ1xBC8n4R287TfRH8/R8xanLsjGcfyj7KsLFVjyMVmIYMbfINSbm5DX
	 8TccUQMuekNfTFtCJekSxNKHZTU3hdFxV9Z/KWzH8qeij/CH49hQrq11lE5EzOxNYvC3o
	 ud19GZ9en+fffFTGsGryYPHKAtAcDW5DOP9QgtYzAoQ9PJjuIfH4+rRnIpt6Y1Ula5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=enesq/UKeCnx/XvxGfuNAHXR5IZUIO60cQotEHifdas=;
	b=GdSxdk9MOyjGIGnp5lh4Qg5wcm2N2CvEN/98A0G/98eBLyHKfBNJQfvK9IcBMqdmcA1T
	 O7CSzxLnvEGpsCja6JAGbXhwP4FAjb/yU6k3IqHCowjwQjLosKWSfojkhMJ53XYjwiUUt
	 vZJubyHn67VVQPIA58FN45pU/tSYVPbpVYJJvcxnqejeS27JZW8LVyfILeAyiqVZAcw1U
	 p/BLU9lUMtI6eWsG1/SKPKFEfaNxHf4JRl76gTQ6bIeHHG8SMlJTEd3I6A+qVXGZdnJNs
	 ZMxfG5ZBDrYC2PGf2hsiZ5TxYWzpHrHB76EXYGbV9VfNih8EKJA1Pz7QuTIop5fdOJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeqwOsoW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21060A2619;
	Tue, 10 Nov 2026 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeqwOsoW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3124C1F008BE;
	Tue, 10 Nov 2026 05:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287356;
	bh=enesq/UKeCnx/XvxGfuNAHXR5IZUIO60cQotEHifdas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeqwOsoW2uzm3BI0lIMh5DG2zvWmjPZMh2QyBKfhoIJO5Vi7kE/RWns+s1rRMfxbS
	 h9ShebFTKG5OELdze8CmBD0B30KHP+VoF0wPqu82oHgAgyZ6IOMFV5Ft6agGPH6XTf
	 br/Mjwh+fSCnHOrUCIVJEcEaFrionGcn66rdFk8jwKp4C6Jb5zwu0b0FGycHSKz6YL
	 hb7+02ZKSny03+YyfZWt8gDnjw3asYfoJnQ0GKnLxgVvEUVxXI8rUDYFW51galdk4o
	 w0rb3VJUVjfGTA/jT+zrItW2sgM/6JTHbnziNPPrFvrMPvRP8+U25sMKmWnMdohjGS
	 HZO7S1/5G6sQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	linux-media@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kate Hsuan <hpa@redhat.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] platform: int3472: discrete: Support multiple HIDs per GPIO map entry
Date: Tue, 10 Nov 2026 00:09:12 -0500
Message-ID: <20261110050908.407088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050619-failed-6.18-844982d3b993@kernel.org>
References: <20261107050619-failed-6.18-844982d3b993@kernel.org>
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

From: Tarang Raval <tarang.raval@siliconsignals.io>

[ Upstream commit edd0dd59aca038b7f32cf893170928d4a3b2297e ]

Each int3472_gpio_map entry currently maps exactly one ACPI HID to a
GPIO quirk. As more sensors needing the same quirk are identified, this
means adding a full duplicate table entry per HID, differing only in
the HID string, which does not scale.

Change int3472_gpio_map::hid to a NULL-terminated hids array so a
single entry can match any number of ACPI HIDs, letting new HIDs be
added to the relevant array instead of duplicating quirk entries.

Cc: linux-media@vger.kernel.org
Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
Tested-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Kate Hsuan <hpa@redhat.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Keep the consolidated vana mapping for SONY471A and TBE20A0, which
were not previously listed, so the subsequent handshake-delay fix applies
unchanged. Perform the HID scan in the existing GPIO mapping routine
instead of introducing a separate matching helper.

Stable-dep-of: 844982d3b993 ("platform/x86: int3472: Increase handshake GPIO delay to 200 ms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 45 ++++++++++++++++---
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 96c33ba80002f..a4c24f1cd0a4d 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -123,10 +123,31 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 	return desc;
 }
 
+/*
+ * Other vana-supply users (e.g. ST, Toshiba, Sony sensors) can be added to
+ * this array instead of adding new quirk table entries.
+ */
+static const char * const power_enable_hids_vana[] = {
+	"SONY471A", /* imx471 on Lenovo X9-14 and X9-15 */
+	"TBE20A0", /* imx471 on Lenovo X1 Carbon G14 */
+	NULL
+};
+
+static const char * const power_enable_hids_vdd[] = {
+	"INT33F0", /* mt9m114 */
+	NULL
+};
+
+static const char * const power_enable_hids_enable[] = {
+	"INT347E", /* ov7251 */
+	NULL
+};
+
 /**
  * struct int3472_gpio_map - Map GPIOs to whatever is expected by the
  * sensor driver (as in DT bindings)
- * @hid: The ACPI HID of the device without the instance number e.g. INT347E
+ * @hids: NULL-terminated array of ACPI HIDs of the devices without the
+ * instance number e.g. INT347E
  * @type_from: The GPIO type from ACPI ?SDT
  * @type_to: The assigned GPIO type, typically same as @type_from
  * @enable_time_us: Enable time in usec for GPIOs mapped to regulators
@@ -135,7 +156,7 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
  * GPIO_ACTIVE_HIGH otherwise
  */
 struct int3472_gpio_map {
-	const char *hid;
+	const char * const *hids;
 	u8 type_from;
 	u8 type_to;
 	bool polarity_low;
@@ -145,25 +166,32 @@ struct int3472_gpio_map {
 
 static const struct int3472_gpio_map int3472_gpio_map[] = {
 	{	/* mt9m114 designs declare a powerdown pin which controls the regulators */
-		.hid = "INT33F0",
+		.hids = power_enable_hids_vdd,
 		.type_from = INT3472_GPIO_TYPE_POWERDOWN,
 		.type_to = INT3472_GPIO_TYPE_POWER_ENABLE,
 		.con_id = "vdd",
 		.enable_time_us = GPIO_REGULATOR_ENABLE_TIME,
 	},
 	{	/* ov7251 driver / DT-bindings expect "enable" as con_id for reset */
-		.hid = "INT347E",
+		.hids = power_enable_hids_enable,
 		.type_from = INT3472_GPIO_TYPE_RESET,
 		.type_to = INT3472_GPIO_TYPE_RESET,
 		.con_id = "enable",
 	},
 	{	/* ov08x40's handshake pin needs a 45 ms delay on some HP laptops */
-		.hid = "OVTI08F4",
+		.hids = (const char * const[]) { "OVTI08F4", NULL },
 		.type_from = INT3472_GPIO_TYPE_HANDSHAKE,
 		.type_to = INT3472_GPIO_TYPE_HANDSHAKE,
 		.con_id = "dvdd",
 		.enable_time_us = 45 * USEC_PER_MSEC,
 	},
+	{	/* Sensors which expect "vana" as con_id for power enable */
+		.hids = power_enable_hids_vana,
+		.type_from = INT3472_GPIO_TYPE_POWER_ENABLE,
+		.type_to = INT3472_GPIO_TYPE_POWER_ENABLE,
+		.con_id = "vana",
+		.enable_time_us = GPIO_REGULATOR_ENABLE_TIME,
+	},
 };
 
 static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3472, u8 *type,
@@ -171,6 +199,7 @@ static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3
 					    unsigned int *enable_time_us)
 {
 	struct acpi_device *adev = int3472->sensor;
+	const char * const *hids;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(int3472_gpio_map); i++) {
@@ -182,7 +211,11 @@ static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3
 		if (*type != int3472_gpio_map[i].type_from)
 			continue;
 
-		if (!acpi_dev_hid_uid_match(adev, int3472_gpio_map[i].hid, NULL))
+		for (hids = int3472_gpio_map[i].hids; *hids; hids++) {
+			if (acpi_dev_hid_uid_match(adev, *hids, NULL))
+				break;
+		}
+		if (!*hids)
 			continue;
 
 		dev_dbg(int3472->dev, "mapping type 0x%02x pin to 0x%02x %s\n",
-- 
2.53.0

