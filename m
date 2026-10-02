Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3383E3DA2;
	Fri,  2 Oct 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966541; cv=none; b=GK/ivuXi2g0cL/z9+qI0ieKx+i0zNxEjXceSZjB2BqQL4ArA/0UqyrzG1om6qadxK0n/ur8aOmcOSuws4VB0YbzQ3D6kg/8vybuAjGdy9j8TyjwobGrusUGwaHNegvTSdHX/kPMxqx5ajrGXM2ejabPvW7Uy+QujulkT+6WgrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966541; c=relaxed/simple;
	bh=7/kXI8VlQDHkKS73wGQBF3BpJ7zfo3zjS50SxDukqBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTmPC5EtZh/hqVhSZXh48Cxbz9ZMjzo7KLqMApmIHACQ7QLl5XfRjiV+x9i5V+tvZkOQT1O3iPLbrFncxN9bICnzpG/of89Vi6TUH4AYqQ6U1MdpISc6lVn2szZCSn3MxPxi2IX/wdu3fKYGz2t0Tm5Kw3lANuZ6/BBPWsBFKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com; spf=none smtp.mailfrom=mail.savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=u9mmo2SY; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="u9mmo2SY"
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CF6133D81846;
	Fri,  2 Oct 2026 14:35:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id XNw1DY720XGY; Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 57ACB3D815B9;
	Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 57ACB3D815B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1790966141; bh=YcBRT6xaEeEq6i9lGilNBTAU0Ym77d0r5Ya/8t7GTfA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=u9mmo2SYRr9TQRFF45quoLPfLOyh2cokGdvW/7L4EOQoAK+w2SIVFv91UjPRQKpc0
	 OyXJA9NNGilRn3XfqYwa4FcAOEjy7kpn7NDvjL1FHn19NsNrUJ3i/BE+6p3ctr3xQP
	 3vqZfv6l+rJgRDSWQKEPX1lQ992182/FVsIWfLOUQmSz9VC6I97teC/BtRfKV3twr2
	 XG7BfpYFfsvBIGP9a3aPfd+ik1LIbRqTxoNqG8jh5uZWcz84mCaxGy0P8BPTyHioFp
	 7G2fvwGkAsHgZ7b+9Hn+t9xpju1qWPNqgpLRpEVv8Mt0Xhvav9i4/joLHaK8Qbvep8
	 PI6/1+oYh7B5A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Xpfks-2BVLL2; Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1E5403D8174B;
	Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
	Alistair Francis <alistair@alistair23.me>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Felix Boucher <felix.boucher@savoirfairelinux.com>,
	Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 3/3] Input: cyttsp5 - only launch the application when in bootloader mode
Date: Fri,  2 Oct 2026 14:35:29 -0400
Message-Id: <20261002183529.166248-4-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The driver unconditionally sends the bootloader LAUNCH_APP command at
startup, assuming the device always comes out of a reset in bootloader
mode. This is not true in general: reset-gpios is optional, so the
device may already be running the application when the driver probes
(for instance after a driver reload or a warm reboot without a
power cycle). The running application does not answer the bootloader
command, so the command times out and probe fails:

  cyttsp5 1-0024: HID output cmd execution timed out
  cyttsp5 1-0024: Error on launch app r=3D-110
  cyttsp5 1-0024: Fail initial startup r=3D-110

The mode the device is running in can be told from the report ID
carried by its HID descriptor: 0xFF for the bootloader and 0xF7 for
the application. Add cyttsp5_get_mode() to read the descriptor and
decode that ID, and only send LAUNCH_APP when the bootloader is
running. The HID descriptor is then read again only after the
application has been launched, as it describes the running mode, and
startup now fails if the application is not running at that point
instead of going on with the bootloader descriptor.

The same problem was previously addressed as part of a larger
series that did not get merged:
https://lore.kernel.org/all/20250110-nekocwd-upstreaming-cyttsp5-v3-0-b33=
659c8effc@gmail.com/

Fixes: 5b0c03e24a06 ("Input: Add driver for Cypress Generation 5 touchscr=
een")
Cc: stable@vger.kernel.org
Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Assisted-by: Copilot:claude-fable-5.1
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 drivers/input/touchscreen/cyttsp5.c | 76 ++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscr=
een/cyttsp5.c
index beeb7d5bcd2c..e88fcc11716e 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -70,6 +70,10 @@
 #define HID_BL_OUTPUT_REPORT_ID			0x40
 #define HID_RESPONSE_REPORT_ID			0xF0
=20
+/* Report ID found in the HID descriptor, identifies the running mode */
+#define HID_DESCRIPTOR_BOOTLOADER_REPORT_ID	0xFF
+#define HID_DESCRIPTOR_APPLICATION_REPORT_ID	0xF7
+
 #define HID_OUTPUT_RESPONSE_REPORT_OFFSET	2
 #define HID_OUTPUT_RESPONSE_CMD_OFFSET		4
 #define HID_OUTPUT_RESPONSE_CMD_MASK		GENMASK(6, 0)
@@ -807,24 +811,74 @@ static int cyttsp5_fill_all_touch(struct cyttsp5 *t=
s)
 	return 0;
 }
=20
+/*
+ * Returns the report ID advertised by the HID descriptor, which tells
+ * whether the bootloader or the application is running, or a negative
+ * error code.
+ */
+static int cyttsp5_get_mode(struct cyttsp5 *ts)
+{
+	const char *mode_str;
+	int mode;
+	int error;
+
+	error =3D cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
+	if (error < 0)
+		return error;
+
+	mode =3D ts->hid_desc.packet_id;
+
+	switch (mode) {
+	case HID_DESCRIPTOR_BOOTLOADER_REPORT_ID:
+		mode_str =3D "bootloader";
+		break;
+	case HID_DESCRIPTOR_APPLICATION_REPORT_ID:
+		mode_str =3D "application";
+		break;
+	default:
+		dev_err(ts->dev, "Unknown mode, report ID 0x%02x\n", mode);
+		return -ENODEV;
+	}
+
+	dev_dbg(ts->dev, "Device is in %s mode\n", mode_str);
+
+	return mode;
+}
+
 static int cyttsp5_startup(struct cyttsp5 *ts)
 {
+	int mode;
 	int error;
=20
+	mode =3D cyttsp5_get_mode(ts);
+	if (mode < 0) {
+		dev_err(ts->dev, "Error on getting mode r=3D%d\n", mode);
+		return mode;
+	}
+
 	/*
-	 * Launch the application as the device starts in bootloader mode
-	 * because of a power-on-reset
+	 * The device starts in bootloader mode after a reset; the
+	 * application then has to be launched explicitly and the HID
+	 * descriptor read again, as it describes the running mode. Skip
+	 * this step when the application is already running.
 	 */
-	error =3D cyttsp5_hid_output_bl_launch_app(ts);
-	if (error < 0) {
-		dev_err(ts->dev, "Error on launch app r=3D%d\n", error);
-		return error;
-	}
+	if (mode =3D=3D HID_DESCRIPTOR_BOOTLOADER_REPORT_ID) {
+		error =3D cyttsp5_hid_output_bl_launch_app(ts);
+		if (error < 0) {
+			dev_err(ts->dev, "Error on launch app r=3D%d\n", error);
+			return error;
+		}
=20
-	error =3D cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
-	if (error < 0) {
-		dev_err(ts->dev, "Error on getting HID descriptor r=3D%d\n", error);
-		return error;
+		mode =3D cyttsp5_get_mode(ts);
+		if (mode < 0) {
+			dev_err(ts->dev, "Error on getting mode r=3D%d\n", mode);
+			return mode;
+		}
+
+		if (mode !=3D HID_DESCRIPTOR_APPLICATION_REPORT_ID) {
+			dev_err(ts->dev, "Application not running after launch\n");
+			return -ENODEV;
+		}
 	}
=20
 	error =3D cyttsp5_fill_all_touch(ts);
--=20
2.34.1

