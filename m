Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586092;
	b=qmcvgvU6w32HE1KIi+clNakArOjnEx2WAws5CgShrT1inAKScp3NhKC8rzhstfamGNzx
	 sMzRBkeLetpqdFrSA9RYFMuQ3frpwJyxBetkaTjiQ0TU96pNx9Vus616QUTc4+hHPZycQ
	 fmqz97NGyHv2+Mwf2FKMc648xnlQMYcwqzUqDVtQPHxF2/8j3BH9kgDIqNWCx6WljvbOw
	 QY6ZEue8Jp97VbvbehHgG8ttLlNRQ3i/iFNmG7qj8DaLAWSnt7sNJ9CYQNlScg4kHBMn5
	 NUZOGCpAnUgD1SKjH7ITSQU0cB55UppiFHnh6q2JObGQqZF3/l3uFwxB9Ja6zYG8uhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586092;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e/QfgozP2vXxIZvOVOcyEn7HvGO1Srpjw1CtBTPsH2o=;
	b=e61YRJufx619RiuomT83MxvX7Z8jgvbHXj8FCP5nV2mC16ZlDNhSpvulTbC+2hyNRZJb
	 1mnm3o9248zDiqkc5MZRppTGKcEZaAtXRl9HIfGmpbHS9eZWeTDlPGrMi2P48L34YbBeQ
	 4EADE7fxx6yPZoMLBJWJE0kwNzWz35i+rwA3/tWjqXTHsy1ZHFxzM0G+YqPKtatnNRCGl
	 kYfOwBChkXcIekLA5fCLgi4o3iKfwHyocpiVugwBqTo9jACgaUqqQ5CaV/wkyHvUwVry2
	 6hYEPg8x7V+/YPYkBrfMTf696wPBFwmYHTXSGaOb9wvAA2PNbSTc4295tCurT2jSghA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpcLnWUW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0C60A380D;
	Wed, 21 Oct 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZpcLnWUW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3951F000C6;
	Wed, 21 Oct 2026 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586091;
	bh=e/QfgozP2vXxIZvOVOcyEn7HvGO1Srpjw1CtBTPsH2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZpcLnWUWExV+XvJDSGWTeXGBtz9rIL8Njlkm8dfMQOf9x1pqYDQO7dNJhkFYDnZn3
	 +rt32sGZTpqXYIzsoTwiXR/u2/YefW6DyTLhfll0oJJGcxEwx8zaIvcFZGLWpqyYZp
	 cNYlkAmITz4AwZ6jnUQL7CQcRNv311hfaSJ4Nd8sPhREUyn5YeeMIMzAkW15pbxwgR
	 zk1a5s/57JtG3MxpfjAFQ2QT1un29bs8wk/BE+kENVVe85RpunJ9i3nyLgAEMw87It
	 yPgq95+dB/QsHdDiZKQtlETuvoV0B62Cq+TXesXu0mMceC8+/aN0Z81x9M8lTGN3an
	 niGm/pZ0RbkkA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Christian Hitz <christian.hitz@bbv.ch>,
	Dan Murphy <dmurphy@ti.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/21] leds: lp50xx: Guard sub-LED count in lp50xx_probe_dt()
Date: Wed, 21 Oct 2026 12:32:15 +0000
Message-ID: <20261021123406.3163547-7-lee@kernel.org>
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

lp50xx_probe_dt() allocates mc_led_info with LP50XX_LEDS_PER_MODULE (3)
elements and increments num_colors for each sub-LED child node without
checking whether num_colors has already reached LP50XX_LEDS_PER_MODULE.
If a device tree specifies more than three sub-LED child nodes with
valid reg properties, led->mc_cdev.num_colors exceeds the capacity of
the subled_info array, causing out-of-bounds accesses during brightness
and intensity updates.

Return -EINVAL if num_colors reaches LP50XX_LEDS_PER_MODULE when
iterating over sub-LED child nodes.

Fixes: 242b81170fb8 ("leds: lp50xx: Add the LP50XX family of the RGB LED driver")
Closes: https://sashiko.dev/#/bug/linux-a0c116ab-2f34-4f53-a007-d7a42f28677b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-lp50xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 20bfb315bda1..32b0d802d474 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -507,6 +507,14 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 
 		fwnode_for_each_child_node(child, led_node) {
 			int multi_index;
+
+			if (num_colors >= LP50XX_LEDS_PER_MODULE) {
+				fwnode_handle_put(led_node);
+				return dev_err_probe(priv->dev, -EINVAL,
+						     "Too many sub-LEDs (max %d)\n",
+						     LP50XX_LEDS_PER_MODULE);
+			}
+
 			ret = fwnode_property_read_u32(led_node, "color",
 						       &color_id);
 			if (ret) {
-- 
2.56.0.218.g1ec904b173-goog

