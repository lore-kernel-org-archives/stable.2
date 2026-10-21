Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586085;
	b=Qkh2fLNxjP8KXtaTkatYXXVXWSo66cyziLFSafPmw409IMfCUigo82BkQs53joY9v3j3
	 8OudiLexE0a3ILiiwp0mpEekfiX9zdXva3cG4QBBgfk+DAJg0WenQZ+RXPLuGZCKlKXbC
	 XJjI1uJ8bV/Ez0C6SlfQpegikUk6zbFmwD2HGllKp3Ff4p44J8UJ+vU0sGpd8XaodL9F5
	 PNxQMyjoJLcjJNPYGGjAdA4dqJDaozF06w6xpBPn7RKbx2hKWyZu3Gjs+FwAoJ96wa/g+
	 zrONFvgmAJN7cgYWVuvgXWOnQJZawT4wvCNphPPX/G9jmjvqHnz+ijxOn/OYFeTAE3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YQK6CVJp2LKnOa9Ab80qPaliuqBiGmu+2pIqiPQQ6/k=;
	b=VG+BMGX7gkg5eXuYSuG6rXjwd4LUA5zf6jrI6UdEzKjjv4LevNEH3q5lJgbxD/Y+E8/o
	 iLhv035j3eZrkqpVbR55+BRzJx3QzKDUXZ++xoqQOBNYWKRfdWzhJNzdh2X2r9ZnMb/kT
	 arPGFZJFx+y6kp6YyuyhEpYg/BEnsCXEMCf0H9xgaAJPyH0QbGCoOUK6g+NZPDldsiE89
	 tjcH0a3O+HR0SeRNNGApaQ7xWq7QPIs/D0vCLEDkn8Yw2WG4citP9OVcPj4TW5J7Z79HX
	 ByVRq7zkcX44P3ochR7jf7IX6MvGWevkGU+4eYwBmdtlkoB9T2zWXo7FehWSHNcgy2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLniGBo5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D2606A32A;
	Wed, 21 Oct 2026 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLniGBo5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B284C1F000CF;
	Wed, 21 Oct 2026 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586085;
	bh=YQK6CVJp2LKnOa9Ab80qPaliuqBiGmu+2pIqiPQQ6/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLniGBo5Ti6cEUqm06S1v3LjcuiVwZ2xejpGXvox2201Kb5vvWKsDJNS5FWGKGp1o
	 umjU7oqzwqCHaI+sjpw/f7TqzH9yE+RY7Bd3tdc9vXtPvch8joDOc9vkYQJLqK11rQ
	 d4RSEIy+vPtSM1LWWTnY4q5EWQHp0rOUm97RL8iJkXHQncSII3jo966ptjipKwfDzU
	 Qf56ZuQQyPjuFjjVp3ucIvabDJZE6aZKCkQujtR8xKRaIOUGa31UMHbwnEl97ElAWv
	 a57uOBeQycgNJ3DsY5wfWEuH4wqIynV2UWoiaXoM/cmXwgunBlnraz2kAZuDz5Mg/n
	 zV1v2b4qVHhqg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Nate Case <ncase@xes-inc.com>,
	Eddie James <eajames@linux.ibm.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/21] leds: pca955x: Take a reference on the child firmware node
Date: Wed, 21 Oct 2026 12:32:14 +0000
Message-ID: <20261021123406.3163547-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

pca955x_get_pdata() caches each child fwnode in led->fwnode while
iterating over the device's child nodes with
device_for_each_child_node(), which drops its reference on each child
node when advancing to the next iteration or finishing the loop.
Because the LED core stores init_data.fwnode via device_set_node()
without taking an additional reference of its own, dynamically
allocated firmware nodes can be freed before or while the LED class
device uses them.

Acquire a reference with fwnode_handle_get() when caching child in
led->fwnode and register a devm action to release it when the device is
unbound or probe fails.

Fixes: 7c4815929276 ("leds: pca955x: Let the core process the fwnode")
Closes: https://sashiko.dev/#/bug/linux-a78a30d3-e8c1-43eb-af6c-c26279dc21e7
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-pca955x.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 273383351ba0..70043e0e6f08 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -530,12 +530,16 @@ static int pca955x_gpio_direction_output(struct gpio_chip *gc,
 }
 #endif /* CONFIG_LEDS_PCA955X_GPIO */
 
+static void pca955x_fwnode_put(void *data)
+{
+	fwnode_handle_put(data);
+}
+
 static struct pca955x_platform_data *
 pca955x_get_pdata(struct i2c_client *client, const struct pca955x_chipdef *chip)
 {
 	struct pca955x_platform_data *pdata;
 	struct pca955x_led *led;
-	struct fwnode_handle *child;
 	int count;
 
 	count = device_get_child_node_count(&client->dev);
@@ -552,7 +556,7 @@ pca955x_get_pdata(struct i2c_client *client, const struct pca955x_chipdef *chip)
 	if (!pdata->leds)
 		return ERR_PTR(-ENOMEM);
 
-	device_for_each_child_node(&client->dev, child) {
+	device_for_each_child_node_scoped(&client->dev, child) {
 		u32 reg;
 		int res;
 
@@ -561,8 +565,17 @@ pca955x_get_pdata(struct i2c_client *client, const struct pca955x_chipdef *chip)
 			continue;
 
 		led = &pdata->leds[reg];
+		if (led->fwnode)
+			devm_release_action(&client->dev, pca955x_fwnode_put,
+					    led->fwnode);
 		led->type = PCA955X_TYPE_LED;
-		led->fwnode = child;
+		led->fwnode = fwnode_handle_get(child);
+
+		res = devm_add_action_or_reset(&client->dev, pca955x_fwnode_put,
+					       led->fwnode);
+		if (res)
+			return ERR_PTR(res);
+
 		led->default_state = led_init_default_state_get(child);
 
 		fwnode_property_read_u32(child, "type", &led->type);
-- 
2.56.0.218.g1ec904b173-goog

