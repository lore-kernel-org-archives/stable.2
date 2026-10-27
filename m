Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097444;
	b=xI8IqJogeK5kCXHgXw8vlCiZ3Bgj/NvLbsJBG5fiRWOmmXqW0SYPiDp0axfb0FAe7tX4
	 FZXxPbNqYxc9Ld1gMV9uLxWl8B30Bxet0qvgEVIzC7nQmGiRD+mg+MyI28cxc3J5DkH6w
	 wQ79BLgBarUXd3SEHZfOqE5iZJC7EpVCrmFLcpNsP1vKg3ik7+Su3b7rGip1sBWo4qpLR
	 WWqzZXa3Dyjn54I9j7BnIgosoxJurPzwjJXM19UIULkNHzrqep3aixHcigBc00F9KI5hz
	 lOG9WgK8AWPBZ74GE0ay8SwRjDzeTOXoHNzlkT2kpRpzg6W5hSbw/JzwaiL/grSfTew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097444;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0+hs+cdGW/yq2YKQMQNFvWfQnrQePF0emoEPtgfBsX0=;
	b=mT+ZWzixKeEoDMGFcXNMvibAaurvEjmEaAo4NojeveP7DTpbxnUrIk6F6CvFHGIuAuCk
	 HeCIz7UHQxyle1pKXH7CC/bHQj9hDPNS5fytxbIYuzht04UmA2qtzNqPeoTGlnpvDWwhs
	 5WM+/j9EPXqw+h5kbUUwY2X32T7GXZSLD81iwfLY7ZPa/avHH6k0E0jNqOToq8j9ZN9Bv
	 pNPhyVpd6SgmqqCZNjSFbw/O2VEZE7HhY6hLqaM0561rnlE/n1qlxyrgV6ciTk98H7Jpm
	 h3t9pPsiN9J/HjokUR0dNNReXHjqigwpQAR6c9VHOqxa5sm5Bl2pMj1TddlwqwlQBpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adEdJzos;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3C606A31B;
	Tue, 27 Oct 2026 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adEdJzos
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5601F01829;
	Tue, 27 Oct 2026 10:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097444;
	bh=0+hs+cdGW/yq2YKQMQNFvWfQnrQePF0emoEPtgfBsX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=adEdJzosPEqPheUCwRQScxouFfVNMC8UGXq7ARPrG9Z4sdzRK4ybBvbv8EQSP2Z+E
	 8wHoDmm4YUtYRAmyrUj39QvzABrBtOlnVKx33GP6bmPeVlzIyP3LqJi8QiFF6IKGuZ
	 i55r7S3LZvp/TB7grQXPWfBOnt8VRPj/DmJ7E/Sr9PUII+FbBFyv9W3XrDq01scEzM
	 vg+azIeuWHD5yDXXiLsEwwbAzpnu/nSSRTNNyUo5WJqewvDJYQgEn7m/kj8bwNILbA
	 YuQEk4jdylAqrJXdV/ah+PcQicK5IXGVANEgfSv0T+kY7SfUvDDFFwEmOAhBLdsWNW
	 359EyNBYvyk7Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Kai Svahn <kai.svahn@nokia.com>,
	syed khasim <x0khasim@ti.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 12/27] mfd: twl-core: Clear pm_power_off callback in twl_remove()
Date: Tue, 27 Oct 2026 09:30:41 +0000
Message-ID: <20261027093306.2812695-13-lee@kernel.org>
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

When a TWL6030-class device is configured as the system power
controller, twl_probe() registers twl6030_power_off() as the global
pm_power_off callback.  However, twl_remove() does not clear
pm_power_off when tearing down the device on late probe failure or
driver unbind, leaving a dangling callback that dereferences the freed
twl_priv context during system shutdown.

Reset pm_power_off to NULL in twl_remove() when it points to
twl6030_power_off().

Fixes: ca9414a1d087 ("mfd: twl-core: Add power off implementation for twl603x")
Closes: https://sashiko.dev/#/bug/linux-f5847f26-c868-416a-b926-3fc3da57802d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/twl-core.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index c024a28b057e..64b45fe79159 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -672,10 +672,26 @@ static void clocks_init(struct device *dev)
 /*----------------------------------------------------------------------*/
 
 
+static void twl6030_power_off(void)
+{
+	int err;
+	u8 val;
+
+	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val, TWL6030_PHOENIX_DEV_ON);
+	if (err)
+		return;
+
+	val |= TWL6030_APP_DEVOFF | TWL6030_CON_DEVOFF | TWL6030_MOD_DEVOFF;
+	twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val, TWL6030_PHOENIX_DEV_ON);
+}
+
 static void twl_remove(struct i2c_client *client)
 {
 	unsigned i, num_slaves;
 
+	if (pm_power_off == twl6030_power_off)
+		pm_power_off = NULL;
+
 	if (twl_class_is_4030())
 		twl4030_exit_irq();
 	else
@@ -692,19 +708,6 @@ static void twl_remove(struct i2c_client *client)
 	twl_priv->ready = false;
 }
 
-static void twl6030_power_off(void)
-{
-	int err;
-	u8 val;
-
-	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val, TWL6030_PHOENIX_DEV_ON);
-	if (err)
-		return;
-
-	val |= TWL6030_APP_DEVOFF | TWL6030_CON_DEVOFF | TWL6030_MOD_DEVOFF;
-	twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val, TWL6030_PHOENIX_DEV_ON);
-}
-
 
 static struct of_dev_auxdata twl_auxdata_lookup[] = {
 	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
-- 
2.56.0.307.g5fe7bd680c-goog

