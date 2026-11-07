Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046039;
	b=Q7UUbJX9FnyEbCTuDpOgSfeQb1745qAlW5lISszpNHAQwnTLq0RO5Nl39dA/gT9jPW+8
	 A+Tih8H4T4iKLYeOhu70+o9Y0ioRzbYjvuplYxUCShy/ZyY9bWp03Ap1u5xWTUTuEoGej
	 Qhgzn/cqx3H27hFyAxnVqfbeJ1GLgtf20JkqOj++54FK6XXh4Qln0eQpifss9zt9hOepA
	 3EPwpmAq/zaoGluRYOH9v4Q8VmUeOQuuU/zbxEOxL9Tws91uJ19eUWqPPUVFBjiDgq0Tv
	 dAO5CvTLBQc3399h5EnvUa7PsVvw9EpoT8ayr9FuYpG3ChW8OjlVh0qlPu5I4/vEE8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046039;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R+9NZeooEvynt9I3MjWu9uwQfqWcft4/9G+7GeKeU3M=;
	b=F6oNvGrT6mSawDpNf4dWCwINyKxYivee/B0vay61R2OfTqrs5GFxIrjTC8ZaF2tAhQKE
	 OqKUT0c4YCoMsJsF26EN7ms6TwMp2Lqh+Hu/SDcdXBvma5z+wZCAd47hSiMParBBojc0x
	 M1igOUlXFBap+G0E7JsApqCRQb2IEcbfIzPK5ioj0433saZbOVjbzIeCkR5pFkfUPmsMO
	 s1Btckq4w+jhjdm0rpc2XX85I5zPRe8G+psgmBCOwPLPos9Qq2OWezcoA3fiHy6qfxu1h
	 sBSRYXcvbCNuL8HbwjIdCQvpaZnTiukhteWDbewpc2ISyPqAPusTIHjsjMfA/nQESLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clF5Lryp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D478606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clF5Lryp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7810D1F008A1;
	Sat,  7 Nov 2026 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046039;
	bh=R+9NZeooEvynt9I3MjWu9uwQfqWcft4/9G+7GeKeU3M=;
	h=From:To:Cc:Subject:Date;
	b=clF5Lrypwrlmry2pfMI600A/JGzf2eDCiwXGScdFqe/tRHQyEdbCN/H+QNmvQzrYF
	 1kWxqLfUA1QP01tpSK5/oH9Z3RD/qZNNhE39XRQCdb6K90Be+6Y1HJe+gPvw5umjnM
	 A/SnCEOukEjJ7+cEQYrGLdCW1pGPMngjBm2JQxY+XIraJdlHObx1KTCvV7Rt2YlTIW
	 +atVuAcuUO+oCKD2MnNgoCtOKcTwu/WbAo1+cd2M5MsOO6APvZHJrrYrqODswXw+1O
	 JFGykM3mCm6ytX+mnoQwoQzbeNlzhW+NuZn9uMa+jcp7N4suuSHx2OC7pXBsmKLJev
	 KcwxyO93vl8Vw==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: twl-core: Unregister the auxiliary platform device on unbind" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:17 -0500
Message-ID: <20261107050717-failed-6.18-3c5c55d979dd@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3c5c55d979ddcb0765ce531bc7ba173c87c8712a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050717-failed-6.18-3c5c55d979dd@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




