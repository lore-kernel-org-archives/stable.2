Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047031;
	b=K85ztdIb9jTLAanpHo9TNptUdLXG2RcYV1my70v82vhFVGdGawYjRTEtvxouMh/Rq0tw
	 Dg9fVqcHW4PsaYQTRDx3KuBG72mbwvro6hz+V5RnkkZKJksYht0dJVDEHySB1F6gpivIG
	 aV9Bubw58Xh2WERspFA9IfBWcDNIAbqlwxWhV1kyqAhkkaeRdtBDCT10cUvnyPqMmGS75
	 JDKjEBy5WHgon1lKDARfW6Q+k76ep0DwAW9hTv/7E8GW8+OAS3K70IFWULLU5WyyPwaVz
	 I/oshJ7E0F9dR0C4o8XcaQa35UbU0zFqoNcbMokPUtTXhJeHziQAFkXPbex6wg5LdqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AnePKT0V50loDgG92bvbNyNnPDHhFOg2D4KG+Id3YoE=;
	b=bszCL1It2dHz3VMI9E7/7eP/DdMHPALwX8iVGq5xI6Sqdqoh060e2koD+3098THi0My2
	 cUSv2j7TI/8cnzgSkR0+OPOK8PBEI6qxEufZzLyJiDxInOjSiyBXNaJCEANxqXFrHjHOv
	 wo5SMrxcsv5g+WWevFoDuZi4bg+lhODGhA1UWiF4DIKCb5IdHUUOtss1hFbVVLlEjPtp6
	 bDSWV1eRQFOFKtsExP9BTlvr0EYGuUSe0DoskDpGBXfpEI7vOTqXmWYVYX2itfQmjmGPo
	 sLTv+PRFtIrlm+wUm6srys300ASyLgU8QUed5nqJrXzJebsiwSIgMPz1RVOH/nuLZUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0X2+Prd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0X2+Prd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FA41F0089F;
	Sat,  7 Nov 2026 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047031;
	bh=AnePKT0V50loDgG92bvbNyNnPDHhFOg2D4KG+Id3YoE=;
	h=From:To:Cc:Subject:Date;
	b=L0X2+PrdKK1PSw3z5fnJ++N9pW7hSa6bL+HuCS/Xd+vJl9efX8vvxTgZVqUhEvWuf
	 4pn0f+sWkA8fGUka/xBLdBfknaVvGQ0otcD7/UCAGeoJM45xXCt2JYBzfAnwyorgiE
	 bjAJ9AU65IQ0ePM+j64b9e1GmHIRZVDcU2TPhfdHGxHiqhqsRahXjXT10QUASHQJeo
	 8YLpFKn2yNxDxv5bXgdFIO3BD8mbjcEBWS6JVERFSg13TqS3X561XWRKV+8YYNSaJj
	 0ePLFxzaOHpYqqX4s6NvpHt2fRwaIh2XtpK2KtdXqsujlPOOACsotP0oo1OWzC0lI7
	 Z7n5/3qZgdCFQ==
From: Sasha Levin <sashal@kernel.org>
To: andrew@fastmailteam.com,
	tzungbi@kernel.org,
	linux@weissschuh.net,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: cros_charge-control: restore EC state on resume" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:49 -0500
Message-ID: <20261107052349-failed-6.12-1f2a40f954c8@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1f2a40f954c848dff9d8bb6d81e404f9e47f0e81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052349-failed-6.12-1f2a40f954c8@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1f2a40f954c848dff9d8bb6d81e404f9e47f0e81 Mon Sep 17 00:00:00 2001
From: Andrew Pam <andrew@fastmailteam.com>
Date: Mon, 5 Oct 2026 15:34:18 +1100
Subject: [PATCH] power: supply: cros_charge-control: restore EC state on
 resume
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/power/supply/cros_charge-control.c | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 07bcc6a9aeefe..e5841b40563ec 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -13,6 +13,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/types.h>
 
 #define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
@@ -420,6 +421,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	priv->cros_ec = cros_ec;
+	dev_set_drvdata(dev, priv);
 
 	if (priv->cmd_version == 1)
 		priv->psy_ext = &cros_chctl_psy_ext_v1;
@@ -439,6 +441,28 @@ static int cros_chctl_probe(struct platform_device *pdev)
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
 	{ .name = "cros-charge-control" },
 	{ }
@@ -446,7 +470,10 @@ static const struct platform_device_id cros_chctl_id[] = {
 MODULE_DEVICE_TABLE(platform, cros_chctl_id);
 
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




