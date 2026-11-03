Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793722252;
	b=lnp7JNn9LquO5sP33a86oBl8ds4DbDmryUn2MV1YtJJcEcIhWCOpsTbnRGeZ6AtzbsKj
	 dkoJAvFWicftbLQisusqb9MlzxmVGNTVf/+U4WUeRf3Xw0B4fM+i3ZZOahT5xsn7maffd
	 wj68L2fp4adOp4f5ZZ0/DEr5N7ZOHaK2qlVZf7+KHh0fpZK+YUeN3GjcIsr+3CL+T3vt1
	 JgSDt/J7vBfrd5u25b3D1C26ohTd74lr+zNOoW5GU1npVUGdVP3HjlA46DpTflxA9hk2R
	 AJbO/w3wm9XUr7ENCV+K3X4bPElyXQl/DDVqyecdr2eXFojluj5HUhkNc8Isankl+vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722252;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fbT9GnGuFGXtQw9eLq7vIF872Q6n2QC92JQf4Ne1Joc=;
	b=xSFX4RGkIuY0uoWqWMw/Xvd8vxn+OV2Md2UL1s6TfetuigWbmadOciCQMhQrONkl3T4A
	 3n0Ix1HYYN4YBcruUEOW00pJ//9e6y87itxsLe8TqP14Gmb1SfGHUlB/8YdnnElg/yDo+
	 kTFQNs5Zz71+JFw616n1p+juBYYgI1UN1/IzXpiBDsi1D7F1O4fOM1CFaENOMHnO8gWPY
	 HLzFXabZj7QubBeqK+c+RGDz6in9GntTZkYx6PqahkrmQtLQwNwfViRhFl49hlLHdPDPv
	 zlu8HV+1QVWWPq5aXn5kZk5ktVnKig6966Pik5hk8LSWEqsNtSW5hMmmGQeYgFviUuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiOV4eQX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE4606D80D;
	Tue,  3 Nov 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiOV4eQX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793722251;
	b=Cul+oHocV/AYsxcmgwdpSGsFDE41mLGQufZ/xaavSqRzV4NZdWcOd7+xaDi0uVywxkUU
	 UuA/qEXNHraL7UYZLm8KAbkfgR/YKRLORj86K0ySb4HheMQFeWxzwueoxUoEoe9SpDPSv
	 iKQplvd2u2d68cnjydRawvkBk6P3pQ++WoOyyMl2/wYXchi3Pwrf6F0EKzQZX2uxLcgUT
	 9r3Sesxcz0rOujktqn5wdeZYTFEKQoEt0LIVg5T2pUyx3C+YQdzrFoiZzE2O5I3iCEh6g
	 ruzKc5gbufFjXuaPfP3Zq1tZdth6wjzGgE2zOdIrBGrUBaY1VtQN2gIQe/s4b7EpmfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722251;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fbT9GnGuFGXtQw9eLq7vIF872Q6n2QC92JQf4Ne1Joc=;
	b=WYnj3/DX8Wq9Qu0LB2qNuqMCaBrLkk6WcjU7Yvp5Uj7aoSx5EIru7qziwSrE/3ZUtfxx
	 Si31GuRspqDmL+hKmeRS8VZb4+rFw9Nr9Py3AobVoNLdeoniX28teLQy1KnuRnPsAWeHJ
	 NMwMVMIZKfzRdjnjKhbD6m1+cSC9rOQ3nnSLwvNsXwbgl70sK80IODAS7S4R88r/XhrH9
	 nyOK3GbP4kmgrRMk8fRJPZpMx+Xt0Gq+kd3TDZNAMouQ0K+4iyiGCYtTX1J6iE4hJSeti
	 y/Rcil1WtFw3cMzJ02wI4peRiPvQ4bv1n5tQ0V6liEE+aoTkGI9FTv087nA6xKu5sYA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0F3B61F00A17;
	Tue,  3 Nov 2026 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722251;
	bh=fbT9GnGuFGXtQw9eLq7vIF872Q6n2QC92JQf4Ne1Joc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XiOV4eQXWFg6qfgwugUS5811At3XHJru0UWcVHuIVLGZJmip5AdIdS80p2KmubPnk
	 s5SpGuutOU4isAaWTMspmnQ9VkyHwyTKY43fpgOuPSJFqsl2RP3PasqkUJASEAviLv
	 +1AMRVpgLZhk/LuMQw9pZF1ZbTScpVHkz7PgU1fXANBziwg++UnElwKsiLpAkmmLdI
	 IApO7bFbm7cuXeeEioWaMO5eGQPXYsUBLl8h6FunL3ISU0+yrNfsmbGMmdoWc7Oqy1
	 Hqa3RZ7Qokn4XIUowv5ouKJ6ATZWpymzyH4Vrdx3UzAaivTHuXletiB3kWP4D0YiTJ
	 Y0i4tKOn2UoWw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8DC5946A03;
	Tue,  3 Nov 2026 16:10:50 +0000 (UTC)
From: =?utf-8?q?Stanis=C5=82aw_Titenko_via_B4_Relay?= <devnull+kernel.resetko.pl@kernel.org>
Date: Tue, 03 Nov 2026 17:10:21 +0100
Subject: [PATCH v2 2/2] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Lenovo
 ThinkPad T14 Gen 2a
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-ucsi-lenovo-t14g2a-v2-2-e85c659b56a2@resetko.pl>
References: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
In-Reply-To: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>, 
 Daniel Dev <daniel.dev@noex.uk>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793722249; l=2188;
 i=kernel@resetko.pl; s=20261031; h=from:subject:message-id;
 bh=jjGiVB1nMAe7D4TjN2PjVOhC/GWz1UPlwi3CJzOvb4k=;
 b=asEjd+7x9CJ1PCslYbBSMhWJ/Z1ERXVGhdud4cn4QiHV1jTD3NvQ5WwoWmg5QK7K608JJdqhy
 phaq7auHn8VBTZvqnAn4h/9HXCRTmkdQFU2DR/0O1efWQbfyMyPxwvJ
X-Developer-Key: i=kernel@resetko.pl; a=ed25519;
 pk=xMhqzbyPNWfeOgdmzSHsSlr5qjH779F5SD6BBHXixlY=
X-Endpoint-Received: by B4 Relay for kernel@resetko.pl/20261031 with
 auth_id=1372
X-Original-From: =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>
Reply-To: kernel@resetko.pl
Content-Transfer-Encoding: 8bit

From: Stanisław Titenko <kernel@resetko.pl>

The Lenovo ThinkPad T14 Gen 2a exposes a functional UCSI ACPI PPM but
the firmware leaves the VERSION field of the UCSI mailbox at zero.

ucsi_register() rejects a zero version with -ENODEV, leaving the
system without registered USB Type-C connectors. Without an OPM, the
embedded controller does not complete DisplayPort Alternate Mode setup
when a USB-C dock or monitor that supplies power is connected after
boot, so the display stays dark while USB and charging work.

Use the zero version quirk for the ThinkPad T14 Gen 2a, matching the
two board names of this model (20XK and 20XL).

Tested on a ThinkPad T14 Gen 2a (20XK) with BIOS 1.33 (R1MET63W):
both Type-C connectors register, and plugging and replugging a USB-C
monitor with an integrated hub and power delivery brings up
DisplayPort Alternate Mode each time.

Reported-by: Daniel Dev <daniel.dev@noex.uk>
Closes: https://lore.kernel.org/linux-usb/b1Wn_eFvTFShGbd970WWl4CWhge_6P2x7Wb6rab3QHNlE4OJ4p__O-QN3B6I-308ftr5oV5Zr7vywA0vdvmtNw6E0YJnVM2ek_5DcFnkXB0=@noex.uk/
Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: stable@vger.kernel.org
Assisted-by: pi:claude-opus-5-5
Signed-off-by: Stanisław Titenko <kernel@resetko.pl>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 47ba0e15b8ba..d752fc7b61ec 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -196,6 +196,22 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 		},
 		.driver_data = (void *)&ucsi_zero_version_ops,
 	},
+	{
+		/* Lenovo ThinkPad T14 Gen 2a */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20XK"),
+		},
+		.driver_data = (void *)&ucsi_zero_version_ops,
+	},
+	{
+		/* Lenovo ThinkPad T14 Gen 2a */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20XL"),
+		},
+		.driver_data = (void *)&ucsi_zero_version_ops,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),

-- 
2.56.0


