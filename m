Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361624;
	b=GEriLOA9bQVP51sq44JOacPnyiLGCymHEpNbsF5/wGFkjS0xJ46HtnDP3qOPKQXrlpTp
	 n3quc/czOY1fjxe6hmSfiUpYgSdrgSTKi6KNAzS7tXFOXhBU8/HKcPM+nPKNQe4c7a5Kj
	 AZdAHMNKzyB5H7vKCZjLbCPOYiVUzDpM0RoOqlTR4KrJvIer2M6XWQSCyVZNymcHYNB/W
	 SNnESjWFDGU2eh+Rk8qAdOPTZeSHqyLh4/UlM6ROBI7QFV99nyFmmmSF0LwLgmKkzMcW1
	 BKwJo+0yeyoT/0G93gxRNgs/3cS2S6JqViSwh4ORKgIVzbSinGnNV0Dxyx2GZ6fDhKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KRbhPtyp0yJ9ixwqPh2cZLbuxuFRo/8DkcVcQ5nRZ4E=;
	b=JO8VUmywQxMedjEPqEutSfDDlIX9euBSfrSzen8i2XmprgdKzSzWcaTCnccZkkqAIP1z
	 vUeYe77xmdRcVax1sRIowITHjFCL+7zIvl3zZbqt9FoTO5HLEMIW1mUDO1EGMEAGsBOqk
	 H1iW3QP6nVQtmV9K7SBA+Zu/m8BJBHw+WG0tq9NtwX8fZaNO0QM49CrPiiIwtWT3uXs9b
	 6ajBCBpMQNl+fYGQkb1exQuONebjveBRdX8H0v6V/Ar2jA/20+Q0UnfDpkVrzdppxvYW8
	 4rnG9w+ZIvHZ9xcprKOipqwRl0LJAnc17/Ptu05wnp6Rtnwa8YCkuuPn5u5uosZnZpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw0Dev7h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EC606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw0Dev7h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A061F0089F;
	Wed, 11 Nov 2026 01:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361624;
	bh=KRbhPtyp0yJ9ixwqPh2cZLbuxuFRo/8DkcVcQ5nRZ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dw0Dev7himSzsWR8QD6lBzZ2eyeO4Arg0Y0FInWsS1gK74I3RLorbisjXD86yXkPw
	 ZLJMkp7MxEAUHfZg56Dj7zdD5WwJnkkf/Q8pOn/Zt91cMlDzWvEcJiQmn2N30G4btv
	 Lhp7tMFZ5N5urG33o3dmTolD32ynJqqwX+JMCTVqdI2EWj+122rqDNKg3Veo+ttY+V
	 pzIWCCJkvWvpLVnzfFs54DUHChq2FjRTPODnhSlB9W95QSOw+Mw97EoOtNAQ5oekxx
	 ondu6q+CAAi7cR5HfNNkPwVAOM6KwGbnSQwpNmN8n9m0kq4Q6kKANjDW/PyWoIJKFx
	 N+Oe2e0i413Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Pam <andrew@fastmailteam.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] power: supply: cros_charge-control: restore EC state on resume
Date: Tue, 10 Nov 2026 20:47:02 -0500
Message-ID: <20261111014546.402229-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052349-failed-6.12-1f2a40f954c8@kernel.org>
References: <20261107052349-failed-6.12-1f2a40f954c8@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andrew Pam <andrew@fastmailteam.com>

[ Upstream commit 1f2a40f954c848dff9d8bb6d81e404f9e47f0e81 ]

The EC resets its charge control configuration when the AP powers off,
so configured sustainer thresholds and charge behaviour are lost across
hibernation.

Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
cros_charge-control: adopt EC charge state on probe"), in the
power-supply tree, made the driver adopt the EC's charge state, but only
at probe, and a resume is not a probe. Sysfs therefore keeps reporting
the configured values while the EC charges the battery to full. On a
Framework Laptop 16 (Ryzen AI 300, charge control command version 3)
with charge_control_end_threshold set to 80, a hibernate and resume
cycle leaves the attribute still reading 80 while the battery charges
past it to 100%.

Add a system sleep resume hook that reprograms the EC from the cached
state. The same EC behaviour and the same fix already exist for another
driver, see commit 2643187ccb86 ("platform/x86: ayaneo-ec: Add suspend
hook").

Reprogramming the EC is only strictly required after hibernation, but it
is cheap and idempotent, so hook every resume path rather than rely on
the EC preserving its state across each kind of sleep transition.

Note that re-reading the state from the EC on resume, by reusing
cros_chctl_init_state() or otherwise, would be wrong even on the command
versions that support GET: the EC has been reset to its defaults by the
time the hook runs, so adopting that state would silently discard the
configuration the user asked for. The driver's cached state is the only
remaining record of it, which is why it is pushed to the EC rather than
refreshed from it.

Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Andrew Pam <andrew@fastmailteam.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20261005043418.243937-1-andrew@fastmailteam.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ sashal: adjusted cros_chctl_probe() context for explicit sysfs registration instead of power-supply extensions ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cros_charge-control.c | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 9b0a7500296b4..2c16ce4cf6b7f 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -14,6 +14,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/types.h>
 
 #define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
@@ -322,6 +323,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	dev_dbg(dev, "Command version: %u\n", (unsigned int)priv->cmd_version);
 
 	priv->cros_ec = cros_ec;
+	dev_set_drvdata(dev, priv);
 	priv->device_attrs[CROS_CHCTL_ATTR_START_THRESHOLD] =
 		(struct device_attribute)__ATTR_RW(charge_control_start_threshold);
 	priv->device_attrs[CROS_CHCTL_ATTR_END_THRESHOLD] =
@@ -352,13 +354,38 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	return devm_battery_hook_register(dev, &priv->battery_hook);
 }
 
+static int cros_chctl_resume(struct device *dev)
+{
+	struct cros_chctl_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * The EC resets its charge control state when the AP powers off, so the
+	 * configuration is lost across hibernation, while the values exposed to
+	 * userspace still describe it. The cached state is the only remaining
+	 * record of that configuration: reprogram the EC from it rather than
+	 * re-reading the EC, which would adopt the reset defaults instead.
+	 */
+	guard(mutex)(&priv->lock);
+	ret = cros_chctl_configure_ec(priv);
+	if (ret)
+		dev_err(dev, "failed to restore charge control state: %d\n", ret);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cros_chctl_pm_ops, NULL, cros_chctl_resume);
+
 static const struct platform_device_id cros_chctl_id[] = {
 	{ "cros-charge-control", 0 },
 	{}
 };
 
 static struct platform_driver cros_chctl_driver = {
-	.driver.name	= "cros-charge-control",
+	.driver = {
+		.name	= "cros-charge-control",
+		.pm	= pm_sleep_ptr(&cros_chctl_pm_ops),
+	},
 	.probe		= cros_chctl_probe,
 	.id_table	= cros_chctl_id,
 };
-- 
2.53.0

