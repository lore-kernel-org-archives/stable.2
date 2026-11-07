Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046665;
	b=2LFIvwsfRz/k88xLmrwIxTJBc/NlEn4wD++S5qLjhctMo+tY+fH/acTANjE+QP5+QcFc
	 AKV6asESO7JZcKHPvDzJ/8jsqyqcj2Uwz8bWb55QrH4yOhdlzLccMjO3VzHXFWJesMqIM
	 /o5BCCX1SSQg4xSVBpnhwDc5+y10DCq2gayG89vFLomCoNYonu3twpS+8Rdf71d/R3vQ3
	 1elvS07sGuJrhjMSIqPCBz2bH5PUKxMn0bgF7vnDCaaIfUDUa/kyRaWgL24VDMTI7cKnY
	 PFntCl+FF61CE4fj00jPQmTmClNB0oMBGS9oGZn96frwK40WJgSfsouBGtzZVVl4HFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U4lQBFYRYl5bUtH+KlylPnteANJA3NUOjrY5WvK4zuw=;
	b=KJN4WsPJVGZnpBVk4drdplMFGjHqtxiucPVj7xkIU55iO2JqNGhWK7OOLkbTGRyNYTMI
	 mFb/p682m7zAYv4s8iEr9LM0gf89hi4IWnJZ4mCpB1ZzpmOm8pZNPylYLcOQw9shIzF7I
	 jJCLtnhWYvG+My/LfrinrG7Rky2Ow+gAHcTzP2J+3eC0rasp+vy5EfkeJqwRlQhxpl5YU
	 ea5HgAc3Vy2uApQoE+gh2TkqCL8q5O2yTJ3ikJhte0r4ICQpN21TumZSNWoo6wtm8JQuK
	 K8AR/RduDaj9s4iaMhaTyeaZQGcqemRHrzf0rJ4gJ/oMAXN0SKgw1c1u/6Lnv3//dxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iScpiTd6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6D606D807
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iScpiTd6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310DF1F008A1;
	Sat,  7 Nov 2026 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046664;
	bh=U4lQBFYRYl5bUtH+KlylPnteANJA3NUOjrY5WvK4zuw=;
	h=From:To:Cc:Subject:Date;
	b=iScpiTd6Yb/ZQKdcw5l35WL5qGeGFsIHWiyi08Lmd/AzTbt2mLCxPZ9oYSG0iRjHr
	 D0/ygCPmGJcgFMbI1wcj+DlxFDpLJARUB9+fMlxmxnX0aCpeaGRAkt+78w8idGPJIp
	 5z2khx08WWmemr9xtzTGZN5H72R41GmqNvcKk5rBwSLCc0ebUViK18cVmWy+guMUxX
	 EoXa7EUP6I5oiOZJtJB7Cx6lz7mKMIQmdGVp5w8Xf0KQqibJojdBjCJOaVCEbz+/1O
	 Avga0bYa/QBA2rAgNpm4pU1PVE7DeJIE2b6kRMtPwBSimfXCU5sPlr30elUUc44jFg
	 AnnZ08M85O3PQ==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: twl-core: Unregister the auxiliary platform device on unbind" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:43 -0500
Message-ID: <20261107051743-failed-6.12-3c5c55d979dd@kernel.org>
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
git cherry-pick -x 3c5c55d979ddcb0765ce531bc7ba173c87c8712a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051743-failed-6.12-3c5c55d979dd@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3c5c55d979ddcb0765ce531bc7ba173c87c8712a Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 13 Sep 2026 16:50:12 -0400
Subject: [PATCH] mfd: twl-core: Unregister the auxiliary platform device on
 unbind

twl_probe() registers a standalone platform device named "twl", but keeps
its pointer only in a local variable. Probe errors unregister the device,
while successful probe leaves no way for twl_remove() to release it. The
platform device therefore remains registered after the I2C driver unbinds.

Register a managed action on the I2C device immediately after adding the
platform device. This unregisters it on probe failure and driver unbind,
and also handles failure to register the action itself. Remove the manual
error-path unregister to avoid releasing the device twice.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: defa6be1c821 ("mfd: Fix compile for twl-core.c by removing cpu_is_omap usage")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260913205013.54777-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/twl-core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index b7d749208131b..7fbce76efd305 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -719,6 +719,11 @@ static const struct mfd_cell twl6032_cells[] = {
 	{ .name = "twl6032-clk" },
 };
 
+static void twl_unregister_device(void *data)
+{
+	platform_device_unregister(data);
+}
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client)
@@ -754,17 +759,22 @@ twl_probe(struct i2c_client *client)
 		return status;
 	}
 
+	status = devm_add_action_or_reset(&client->dev, twl_unregister_device,
+					  pdev);
+	if (status)
+		return status;
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
-		goto free;
+		goto out;
 	}
 
 	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
 				GFP_KERNEL);
 	if (!twl_priv) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	if ((id->driver_data) & TWL6030_CLASS) {
@@ -784,7 +794,7 @@ twl_probe(struct i2c_client *client)
 					 GFP_KERNEL);
 	if (!twl_priv->twl_modules) {
 		status = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	for (i = 0; i < num_slaves; i++) {
@@ -880,7 +890,7 @@ twl_probe(struct i2c_client *client)
 		status = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 					      cells, num_cells, NULL, 0, NULL);
 		if (status < 0)
-			goto free;
+			goto out;
 
 		if (of_device_is_system_power_controller(node)) {
 			if (!pm_power_off)
@@ -896,10 +906,7 @@ twl_probe(struct i2c_client *client)
 fail:
 	if (status < 0)
 		twl_remove(client);
-free:
-	if (status < 0)
-		platform_device_unregister(pdev);
-
+out:
 	return status;
 }
 
-- 
2.53.0




