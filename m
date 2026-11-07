Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049212;
	b=MJ/FLRPDWsTwa5eNZxdOEL/X0Grn7tfMFcNDG/XwYw4CGJ4wsQhjMhMP7Vc4Gnv2ysWD
	 qKQ+axXZturo/D6lwcEbBXfJBhepktVBwyNTeAGwpzf49yaR6j8CznMheVqoVRuewMJMA
	 wQZZ32JAwA9wKXYXl6DTgduqXotkbUG753zZlDuay7PLc1ridAMvjtQxmia4t7NiXGuVk
	 nzXraFgrDyRitedWWCaB4wJXH3LvJi6IeNR61k/iyWPXA2JaVlsx8Jc3nGY/2wo/AHSrB
	 Eip3g65uVcWeXbDCCsxhfXNL09p8PK0ljORdSdyIBUBq+686WCMUOO+7CrUJDBfX5pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TOjsJgiA5okj8AmeTG0z3t+SYI/4o5zKp4BfLu1UA2w=;
	b=g5gwmvuZRn5sqpEsSiU0ZbXZeY74wDkQLIqUJ6LkuvS/CtVmqrgyb3i4qLdQ6KDnce/K
	 kalrkn2l2cnLF80uhasv/PpQ016MSevLwK7lUiA6vK6bjWa8K1EzVmN0XaJLiQDZxuK0P
	 yLKJ4ufk+bHdjQcLHhhoIPEcTvTlKQ/EUp5WU5/jisZdv0p9UXjg4K8OYgywQpJOHhqhZ
	 kbJUZuwIrFlfj62UPTMgsE5NIwF/CV/3DP6pTxlLz0lQaDT+QBcsXVC54TZuUR+tCskIT
	 dRvNJvg3RdrmXnXLqWYf+AkyQHzxpIUzEMw1dNhXzv7MF39YZPcCx7CamUQu0Xw299g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhXpB0Y1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E89606D804
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhXpB0Y1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDF71F00907;
	Sat,  7 Nov 2026 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049212;
	bh=TOjsJgiA5okj8AmeTG0z3t+SYI/4o5zKp4BfLu1UA2w=;
	h=From:To:Cc:Subject:Date;
	b=fhXpB0Y1QD4z4BrSzXmiC7h0C0MzqhJh9y9vzSkSz4fZDzOEjhvHEDl8fCOyOHniz
	 D3mznGhmEEvNsqSZyASxSrWYRc4sdQgfIC8BhiyZXYScAEHVLkkEwjCGSCjWYXs0PY
	 W+qq+EU7Z8Cml9yOhhd2HTRS4Zm5kFx9Hh9amjl0ifvv9Kp2+YhDGZOPd0NqW8rvkH
	 yuDzhEvxCVsgg10VQdm30Q7qJfNUObt7Q6nraljeElSF4GgwzSOW+rFq5POwlNAIgC
	 WQi+ZFxBA0vUk7opaMCXws7Xxjg32prnaymEMR+xFHfooz1uLWhdSJboc8w/lkGTFm
	 +LEqaJHneKcKQ==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: twl-core: Unregister the auxiliary platform device on unbind" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:10 -0500
Message-ID: <20261107060010-failed-5.15-3c5c55d979dd@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3c5c55d979ddcb0765ce531bc7ba173c87c8712a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060010-failed-5.15-3c5c55d979dd@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




