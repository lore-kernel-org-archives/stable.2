Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB673BB113;
	Wed, 30 Sep 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749373; cv=none; b=bH0rbZghmIkKbEPsCvPzsv/6HLSDLALnMtzmK1rNcmMfvMAjzZbhU3svvue8ghIm4Io51q4A6Q2Rs3id1WdOrt8eWNmMyxKsI07KVeu08GWANJeVMUHdFzMWj85u841F+JLimNggx1f/lBQCAwYabRYtn+Tx8IhjtCMCm+Oi7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749373; c=relaxed/simple;
	bh=rtNUZwDU+3thMLtaT2oI+T5OiKsS3YLtKp2NBRhe4uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fh4eeBr5XWv1Q6wbhROY7iUtJTLAA16LF6sZkxzLcQnLsvdFxQKJurq/ObkK8aznoZvMFryWhes2Df2samTmh7ioTlwU6R+g0mHQg4z9ttgAmVTO2ehg9b1NvYH2XBzuI4wDbG4S5SY5KHRtiiRUPWiq+usWgJmg4GPCPcmyu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGeH0kKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGeH0kKD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0924C2BCF4;
	Wed, 30 Sep 2026 06:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790749372;
	bh=rtNUZwDU+3thMLtaT2oI+T5OiKsS3YLtKp2NBRhe4uQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bGeH0kKDlTtTTuLXt3hLKT0R5IZOUQapWAtWvPPGsECfw+k2or+CYOQEfjrJgQ7Jx
	 0XPzagQVBujJFD/ysBjLKziheXirJhz71OQSOMa24XmIr4vVCVxukT+/yDT4xeCPhp
	 IaFZNb9lHywEE+hshdwF1V7bLz1Hef+yzHaEK/N5Y0nLo6vFkmJ4yLVZtslYpt3SM2
	 sOZT2zroUYh4n3rSdOclufgvj2p7qqrscImzW037fB126diNwIUvgYNrhUHXlkIXF4
	 rsqOxznVsIiDdc1suIjo8BZUUE+K0nXnpvTjnjCnb1f+HfKBO4yCta6YiOoz03r/hI
	 AtikSsURca8sQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E90FCA5FB1;
	Wed, 30 Sep 2026 06:22:52 +0000 (UTC)
From: Waqar Gulzar via B4 Relay <devnull+iamwaqargulzar.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 11:22:49 +0500
Subject: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com>
X-B4-Tracking: v=1; b=H4sIALiqvGoC/yXMQQqDMBBA0avIrDsQY7TaqxQXJk7siEQ7URHEu
 zdtl2/x/wmRhCnCIztBaOfIc0jIbxm4VxcGQu6TQStdqaZQaA3S1AVd5gZZ3ijzthL2tb4b73y
 tSgupXYQ8H7/vs/07bnYkt35ncF0fk1cS8nkAAAA=
X-Change-ID: 20260930-b4-elan2514-irq-route-d8274fcf805b
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
 Waqar Gulzar <iamwaqargulzar@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790749371; l=5531;
 i=iamwaqargulzar@gmail.com; s=20260930; h=from:subject:message-id;
 bh=i/kcWiyvC9sOaZJ1/0neMN3dO4OBwcexqs5ODF8WpnE=;
 b=587x1mpxQN0x62TTKWKXtPdtKnrhddDQKiq2/8MFrl7x+g6GrAgLnUMYhz2h4sdOnNmRDDYel
 8PYX7GrgiGMDHCTLbK1KdvQrU2RjE1InqS+UeAijEHn1IxH/SdGfWKW
X-Developer-Key: i=iamwaqargulzar@gmail.com; a=ed25519;
 pk=SaQhB3EnN6qioo4wuu0rBv6REy1Nx9hz3QOh3Qp9xtk=
X-Endpoint-Received: by B4 Relay for iamwaqargulzar@gmail.com/20260930 with
 auth_id=1083
X-Original-From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Reply-To: iamwaqargulzar@gmail.com

From: Waqar Gulzar <iamwaqargulzar@gmail.com>

On the HP OmniBook X Flip 16 the ELAN2514 touchscreen interrupt is a
GPIO pad (GPP_E_18) routed directly to the IO-APIC. The firmware's
touchscreen power resource does

    PTPL._ON:  \_SB.SGRA (TPI2, TPIP)        // TPIP = T0IP = 0
    PTPL._OFF: \_SB.SGRA (TPI2, TPIP ^ 1)

while the device's _INI enables routing with SGRA (GPLI, T0IP ^ 1).
So _ON clears PADCFG0.GPIROUTIOXAPIC and disconnects the pad from the
IO-APIC. Linux evaluates _ON at probe and on every D3->D0 transition
(Windows apparently does not while _STA already reports the resource
on), after which the level-triggered IRQ never deasserts:

  - ~630 interrupts/s while idle, nearly every read returns 0xffff
  - frames shifted by a leading 0xff, "incomplete report (67/7167)"
  - stylus reports arrive at ~25 Hz instead of the native ~268 Hz
  - touch stalls and false stylus proximity

Re-enable the routing through the firmware's own \_SB.SGRA helper from
the power_up hook, which runs at probe and on resume before the HID
reset.

Tested on board 8DA1 (BIOS F.20): idle interrupts drop from ~630/s to
0 after boot and after s2idle resume, and pen and touch behave as on
Windows. Board 8DA0 is the other board ID of this model and is reported
to have the same firmware code, so it is included, but it has not been
tested because I do not have access to one.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142384
Link: https://github.com/testyfishy/hp-omnibook-flip16-touchscreen-fix
Link: https://github.com/iamwaqargulzar/hp-omnibook-x-flip-16-linux-touchscreen-pen-fix
Cc: stable@vger.kernel.org
Signed-off-by: Waqar Gulzar <iamwaqargulzar@gmail.com>
---
The HP OmniBook X Flip 16 firmware disconnects the ELAN2514 touchscreen
interrupt from the IO-APIC in its power resource _ON method, which Linux
runs at probe and resume. This patch re-enables the routing through the
firmware's own helper from i2c-hid-acpi's power_up hook.

Tested on board 8DA1 with BIOS F.20 on Linux 7.2.8, including s2idle
resume. The 8DA0 entry is untested (I do not have that board).

Full analysis, ACPI excerpts, and Windows/Linux traces:
https://github.com/iamwaqargulzar/hp-omnibook-x-flip-16-linux-touchscreen-pen-fix
---
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 9371db200..b6348ee3d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -21,6 +21,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -55,6 +56,60 @@ static void i2c_hid_acpi_restore_sequence(struct i2chid_ops *ops)
 	i2c_hid_acpi_get_descriptor(ihid_acpi->adev);
 }
 
+/*
+ * HP OmniBook X Flip 16 (boards 8DA0/8DA1): the touchscreen power resource
+ * \_SB.PC00.I2C4.PTPL._ON writes the wrong value to the GPIROUTIOXAPIC bit
+ * of the touchscreen interrupt pad, disconnecting it from the IO-APIC. The
+ * level-triggered interrupt then never deasserts, the controller is read
+ * continuously (~630 reads/s while idle) and it cannot deliver pen reports
+ * at its native rate. Windows does not run _ON while the resource already
+ * reports on, so it is not affected. Linux runs _ON at probe and on every
+ * resume, so re-enable the routing with the firmware's own helper before
+ * the HID reset.
+ */
+static const struct dmi_system_id i2c_hid_acpi_irq_route_dmi[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "8DA0"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "8DA1"),
+		},
+	},
+	{ }
+};
+
+static int i2c_hid_acpi_restore_irq_route(struct i2chid_ops *ops)
+{
+	struct i2c_hid_acpi *ihid_acpi = container_of(ops, struct i2c_hid_acpi, ops);
+	union acpi_object args[2];
+	struct acpi_object_list arg_list = { ARRAY_SIZE(args), args };
+	unsigned long long pad;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(NULL, "\\GPLI", NULL, &pad);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	args[0].type = ACPI_TYPE_INTEGER;
+	args[0].integer.value = pad;
+	args[1].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = 1;
+
+	status = acpi_evaluate_object(NULL, "\\_SB.SGRA", &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		acpi_handle_warn(acpi_device_handle(ihid_acpi->adev),
+				 "failed to restore interrupt routing: %s\n",
+				 acpi_format_exception(status));
+
+	/* Never fail probe or resume because of this workaround */
+	return 0;
+}
+
 static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
 {
 	struct i2c_hid_acpi *ihid_acpi = container_of(ops, struct i2c_hid_acpi, ops);
@@ -85,6 +140,9 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 	ihid_acpi->adev = adev;
 	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
 	ihid_acpi->ops.restore_sequence = i2c_hid_acpi_restore_sequence;
+	if (acpi_dev_hid_uid_match(ihid_acpi->adev, "ELAN2514", NULL) &&
+	    dmi_check_system(i2c_hid_acpi_irq_route_dmi))
+		ihid_acpi->ops.power_up = i2c_hid_acpi_restore_irq_route;
 
 	acpi_device_fix_up_power(adev);
 

---
base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
change-id: 20260930-b4-elan2514-irq-route-d8274fcf805b

Best regards,
--  
Waqar Gulzar <iamwaqargulzar@gmail.com>


