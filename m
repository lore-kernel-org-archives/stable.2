Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584918;
	b=jCj79Cs0WZemE5L2zB03DFGx/q1vU+c7R8uVwdvxDvY/cM3FI+Uqr4Qgajpldf9Ur5ih
	 lc9FHLJqt35d9WKD3hIgz9HEIwP+9umoKfRyhurbbRaFb30IDAovPn3nif+dUma/AYr8l
	 +eaLPmtY+blNPJ8lwcu8hlM9VxMh/gW+BQnSy+UosH21XzF3E6UQd+2Ff2ZlWU9b+Czmr
	 t/ypcWCNM7hN1P19DXY7YhiLjVQVCL2zRKzjDsvNwpmefRRLl7hw8bzMKDm558JkyqGGp
	 4+Kdb+KbewL8OjwQbtXHhU0DqyjBdDb+ijd08DiWX49OzITeMbtcxPqR7UsTWrywPeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OQAQy8H2ZPsToCNPH++qnZ5B9B/4u/szFzQb7JQ/mYg=;
	b=dIixMrfMA/Hp6fJ/HMncSM9KIC9x9076ZDzyem5KlaOV4v2acVkeVH/Iq7JFbPfqPLYd
	 ZfwFOnUoXEXiu/m+TgFtq5A+80wfhjWDO1NKPSUnNRmyv6DWmPDuMxJC/SPhKIDoWGIrr
	 EzztBV3zCMLtM7ptLSKoET8wAf0yJO2xdqc52ikgp9GoZK+pqe1h3QzJuqrKYtglHUirL
	 HlPTZkFI2MVJoaaOLrPPhjIzvTJCo7Psqkv9qZiEahNCeJ3+fivk6TYeib9GgDvSRBRzk
	 xFcwDB665lmY8nLSbyJEXFPcVgy3JkbcMNTlkC/muE6eB4VSdQpnLK61q0NuSnZdNOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZDR7JY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0360A262C;
	Wed, 21 Oct 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZDR7JY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91F91F000C4;
	Wed, 21 Oct 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584918;
	bh=OQAQy8H2ZPsToCNPH++qnZ5B9B/4u/szFzQb7JQ/mYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZDR7JY+OhK6f4i/zOPpfIjtvfXVwAc4jgsQlJ7z+JH/6jjgG6L0RgOkR+D24f/qn
	 mdhGL69BRm5Cxlsf5ejg3O0FlVBs5W4+DhCRH5qI5MHrLKtMMWdURTgJaSaV5CffPO
	 /l3KrgReoHUyJ1MC/I0WvX3M02/c6UsU/rEaXDq0X+TWud0ZLxRCP+GprqDTH4clbz
	 DloZ23wEBEdpnGhh/jW4n31H0F+K+0X5ci/0TduvwEIztm3A74dx3jIWeW1ICJd5ka
	 1E29x+E5jcLjYVJmh/8SnbGfQTBnyI9saJJ4HBb1xLMfmlk8s/UedgK+bJtto4q/fy
	 MMndK4CPaMebw==
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
Subject: [PATCH 13/28] mfd: twl-core: Clear pm_power_off callback in twl_remove()
Date: Wed, 21 Oct 2026 12:09:35 +0000
Message-ID: <20261021121245.3111563-13-lee@kernel.org>
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
2.56.0.218.g1ec904b173-goog

