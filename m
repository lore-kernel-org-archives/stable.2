Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584925;
	b=jTURgFZAnpHQUAATTW8bXtGEtZ0yGbad70HcZ6SVII0NPrGcASXFi8K2Pt0CCxwBthWM
	 +tSi6svt8nlhDKE6IKdS9j3Hf03aS5Fn6Ts2Nel9cSj5tV0nyNlx3VjtLtYmTxrWn0dyI
	 Vw+bApgeZJRZzIRXIyrWC2mXoC/lBtrKrgsU6VTKD8N0RPKwm8WdlhKsUDVI1fXRCb380
	 Qv75uhE9FGCXuWKC06m73UOoYWcztQkiGvjK00emhOE8qS+TtVOA/jpRAVAExMENIFXEq
	 P3WsORrMlcU0PUYlj3jFi6WlrS+OHklQUIOzz3UrmHnfBDZJYfe7TVojpyt2txkB80g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584925;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CeKuOGKuwAuAMezw1s10+HeI/EWg/OQKaDbbMqvL/ZA=;
	b=B2JW3CIT8TYE8zGlZNh1IU0wVvaCpFYHbLVDJToJ5PBaClk62h4HEx2z+8B1KSnE0nrt
	 m2rKDkPpC1aZKKNkg16tU3DfGZqfJlYpJyBZvqLoaA8xI+w/Q6WimLRurmD97MTX140zv
	 Xpz+XSvx6ga4vbyixN3mWsuAandVbvgn0MYilg2URzWbhqAhMeILuSpICE9zDdvdBWZnx
	 qD+ZI3n5ibGcjWNH7acSQpxHzu+71yBYcTMXx6bFPRvaUrYtIkNM2MxhrOFo0Hup+XwSE
	 VQa9HH/D+K6jOijAX9FDM7354Td+vqHMo7ZAa8FILRSeJ7oe7qwQMq6Vw9Y7nOQfWxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQZsBKi8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFD606A328;
	Wed, 21 Oct 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQZsBKi8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9A71F000C4;
	Wed, 21 Oct 2026 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584924;
	bh=CeKuOGKuwAuAMezw1s10+HeI/EWg/OQKaDbbMqvL/ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQZsBKi8i4v5ejsOMyF3Enj1WGyF5VDdqsvv7brQZsFjq+CDEmQxmNE7K6Hx8ozqn
	 1Aj7zsw/T+rVRO4wPRZQbpJgU1TPonCSCp17k3ak2sGX82Tg4JnKhqdPsA4iFdb833
	 8JDq1Vkda2a82dOVxsQs8a1yyE03GAOlA0TPx5ROKwPVEwzJZE7x9vCqBaChg8C8lz
	 ofAnwwMLiVMgO3djzKJscVTcoUkAMLjF5ehilSBcc/2Lqzt4yZ0tPr6R4zeRAWVQdx
	 YfyOLOeyNnL9P/nJRRacI6w75Hl32kMFgy2I10/wUN78xvTouFoppWO/IAeeljf7wg
	 aw0F12Gl8CMvg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Kai Svahn <kai.svahn@nokia.com>,
	syed khasim <x0khasim@ti.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 14/28] mfd: twl-core: Clear twl_priv pointer on teardown and probe failure
Date: Wed, 21 Oct 2026 12:09:36 +0000
Message-ID: <20261021121245.3111563-14-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

twl_probe() allocates the file-scope twl_priv state with devm_kzalloc()
and checks for a non-NULL twl_priv at entry to reject multiple device
instances.  However, twl_remove() and the early error paths in
twl_probe() never reset twl_priv to NULL, a failure when adding MFD
child devices bypasses twl_remove() by jumping to free instead of fail,
and twl_remove() tears down the IRQ domain and dummy I2C clients before
child devices are unregistered.  After devres frees the underlying
memory on probe failure or unbind, twl_priv remains a dangling pointer,
causing subsequent exported API calls to dereference freed memory and
blocking future probe attempts with -EBUSY.

Unregister DT-populated and MFD child devices at the start of
twl_remove(), ensure mfd_add_devices() failures unwind via fail, and
reset twl_priv to NULL in twl_remove() and on probe error exit.

Fixes: 80a97ccd33be ("mfd: twl-core: Collect global variables behind one private structure (global)")
Closes: https://sashiko.dev/#/bug/linux-73e82f84-94de-4d08-82a4-f22d42a1dedf
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/twl-core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 64b45fe79159..21fc0acb827b 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -689,6 +689,11 @@ static void twl_remove(struct i2c_client *client)
 {
 	unsigned i, num_slaves;
 
+	of_platform_depopulate(&client->dev);
+
+	if (twl_class_is_6030())
+		mfd_remove_devices(&client->dev);
+
 	if (pm_power_off == twl6030_power_off)
 		pm_power_off = NULL;
 
@@ -706,6 +711,7 @@ static void twl_remove(struct i2c_client *client)
 		twl->client = NULL;
 	}
 	twl_priv->ready = false;
+	twl_priv = NULL;
 }
 
 
@@ -880,10 +886,10 @@ twl_probe(struct i2c_client *client)
 			num_cells = ARRAY_SIZE(twl6030_cells);
 		}
 
-		status = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
-					      cells, num_cells, NULL, 0, NULL);
+		status = mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
+					 cells, num_cells, NULL, 0, NULL);
 		if (status < 0)
-			goto free;
+			goto fail;
 
 		if (of_device_is_system_power_controller(node)) {
 			if (!pm_power_off)
@@ -900,8 +906,10 @@ twl_probe(struct i2c_client *client)
 	if (status < 0)
 		twl_remove(client);
 free:
-	if (status < 0)
+	if (status < 0) {
 		platform_device_unregister(pdev);
+		twl_priv = NULL;
+	}
 
 	return status;
 }
-- 
2.56.0.218.g1ec904b173-goog

