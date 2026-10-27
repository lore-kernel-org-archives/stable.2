Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097451;
	b=hEbui3L1bY0dI9KALmEJnSrhvG/PzReAzV76+ZS6Yb8+STIaEhYH3EbS8Hz95YdYruX0
	 CzKeWGc6ViYK4RWY1SOvh6CafPS52XVXBPiDy9iBDMQZIC2HYc/hdcr3MsIe+fPSyk5ZM
	 tXeD2WShnwW6+2Q5/MvtWAG+SpetNzrBdniuVKp/jeVEetAamz9HONvucVyfl10WZFE/J
	 3uPS1tTl03lBhHcXNIaAEKgKJS8JuZMQYPRzjelZ5z4/d5K8smmz8Oe05rRpLOBOyLO2X
	 f/K2aaU4jmBL8m018l9CnPzYaDYWvyI7VCATBMwPCH5D8/4wz0/nPeYcwH1Kl3Y7FIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2dTor8V/omKMQXmW5Bbk3/qL+/7DkafmttfX0otPwNw=;
	b=XeG4rRABXnLZRPlypHS1tLtTDYluupE9Q9QLE7ZMcUVHNYZ+Z0Z3hcriJtrcHiCrwLu/
	 dNfRG26rIvgocRtwgEKhLXpzZn78QeeBSNvJ/j7Wbi12+lLfErIwbctVEOUBYALhdsQYi
	 wE3+mCvC9eAA3gZiOtWQc9Oqm+zkGRqVd8l34VYaswGwrkrE/gRF8aCQdPIf0aDQFYciT
	 5oT3YIv/xe/GnvpVumIRL5z89gfaEuFR7zwN0vxxXnQpHOcNPxrR6VI6p1hn49nfbQhDs
	 j0uHiNwlyihiqPept7gS1mvCZ9yeZWTYhakZmOPHqIG8Qw+2zHmhwYfKqoXLKvPBVYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ce007NVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F605606A324;
	Tue, 27 Oct 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ce007NVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D331F01825;
	Tue, 27 Oct 2026 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097450;
	bh=2dTor8V/omKMQXmW5Bbk3/qL+/7DkafmttfX0otPwNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ce007NVO/CrGn5egoZtMeumiwhXe2H3zkLYvEaEobzBN+6gv7IFv2eVUI7qqtvFne
	 ekSVExxGcrL9cb/LBzLeV2Ts04wzKXYDnu81IKnN3EXO9Zx+Dl5U8UnuuTnIxvt5lI
	 QXVOfYd9QGKtlqNNAQSF+a+FLJ7sfK1y4tEIPS9cwXct/igTLG22FHljhjJvsYViGq
	 8lfw9wGqeRqZdmbgQtIrZVZ5u/AeeTc4zWPehoxaHHqvXCaWZ0v/Oxc5iCkwzC/gsV
	 FOXj1Nt5gD1iyMB1Y5MaQnl5hlZf/AMUFRFsUmqUfTT4TU9a9DDVwKVN2NM3tCYGCz
	 yKeBTgumC3e+Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Kai Svahn <kai.svahn@nokia.com>,
	syed khasim <x0khasim@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 13/27] mfd: twl-core: Clear twl_priv pointer on teardown and probe failure
Date: Tue, 27 Oct 2026 09:30:42 +0000
Message-ID: <20261027093306.2812695-14-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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
2.56.0.307.g5fe7bd680c-goog

