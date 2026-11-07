Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050221;
	b=HPafLO3A0j2F5Jkg2Y/r7Nx0kfzjPrIJgxhLo8uB0h5kC+itY3oNjTK7Cppt490CYYAg
	 5cDZSOhowDemjm6Qfu9vuPE7kdBU5LXmq5wd3J0R+XoLq/YNss3d58dTIKTWhOTeLlnYC
	 5Q6qT80td3zZUSdq/HgOVT3LoknJPF+Hzm9KezctWwscWGU+hBxpzmo+0GRC77b6LYutC
	 z+FfVW6DEDQuZjvWjMq6db/duVvLyhCHfwCQLhKCwBhljcjAyGl8vbv2HyhaHeE+Hribb
	 rHk6jdgeeE2kcDltpy2C6/uUSuGbzl6MqEhUe1yK6tU8bNhAeZhqAm9MAc+pAPoXwIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JxskVw087vNtcWSNYIUUGHu+33tlDpRVzHBj7D9H4YQ=;
	b=JKfl3Y2dN/hPsyuUT3pfoGyLWDOARn5ZckdbXIMY8Erli31OhE9lVnrjFIUBh3/GvuzJ
	 37Kw2m2yeuHLLvFrCpjyTf/Hnd68Jkzr/eK8zqucCTsciskK9rzDaSwuPM7bn04E/tG2f
	 vMTvkoq0ssD9S6M3kaRjkekHdE+HHM+EyA4s8ImVOy9eihOImg4oanFk5P29ouqGriZLt
	 OfxNTksYDo/I1jR0FDJmnzxE7clvm9SUcFcOW6YgaPvPTwQWiggCnaTR/0xWk/rTWkQwa
	 lpSP/ZE1/i6ya3sE5NLsvAc5zL24x6nctfkG9PNfR1gQAJAjQCqbPGEbmSC9g2IwRsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsF6dhL3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsF6dhL3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917BF1F0089F;
	Sat,  7 Nov 2026 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050221;
	bh=JxskVw087vNtcWSNYIUUGHu+33tlDpRVzHBj7D9H4YQ=;
	h=From:To:Cc:Subject:Date;
	b=FsF6dhL3jtkBzDoXoSz7zZyNSuqYJCZCbG/cGg/9oFH/b9CYSeZ2+25KQL/H4GtHo
	 EXnPhDiDjTkdiYRorcFy7pTSbi8dH894DbxdEpypOSm7DveaV/WlP8fbPNgDTH3mbG
	 Gde+9qGpOajTG/M3XKyyDeDi3CKMD8JtZ4EvTpe6wLWRkrfanN/yoAuOnf90H0vQD2
	 iZeR59u0zGeXdYa/0d1rFPpQCvFP4RvOdhJLpcBSCTAKkBuMCA5HaK0uxIErqVe2Mi
	 SO5MGw/uLIbHnbp7o0yjs41TS34b4F2ijVz1GdGnBJtYKb47fq8yMLB8EETMF1W3VL
	 dHii6cIbFhGKw==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: twl-core: Unregister the auxiliary platform device on unbind" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:59 -0500
Message-ID: <20261107061659-failed-5.10-3c5c55d979dd@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3c5c55d979ddcb0765ce531bc7ba173c87c8712a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061659-failed-5.10-3c5c55d979dd@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




