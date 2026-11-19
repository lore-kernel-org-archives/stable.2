Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121491;
	b=G09V1mIT8o+MN4aDk8dV+dOmy/pBHrj0KEeu0uPjp+tlaXdDDf6FWOGkLAtFChWcypXF
	 IEWWWrLYAufF/wBv2jkZ+qwt1SsgmtoFVeb0hKDLJ4kxaGINIud9YREW52K3mYc4LRfMT
	 iop/mQR5RUs9wvKACeWaGS/AfUwwt9jg985OuENOpQMp8dwN5JxW+qXX5U9kQAyePiYxw
	 MZZUOc2wkqCHpxIDQYtoszkETbPWfvd0b/6xMvytcB7hGQ9eNH8l9kl7MQrK6FxRzvk8Z
	 qFi8qz9jyKdkBen9nr3DjkxHFPD/7ePQiABGJxzD0Qdd0R5EPACSqjd5nf2ohi50jxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zpt4Bof52dDo4blFPTUKDmBeQ0aUkck9+bykbp/3xPs=;
	b=QOktsEqg30sL6w2x1Lqv2GhQox0slYs1HSB6+kwGJ0dUEfI5s7NKLZebALKkw+A8HFeL
	 KqZ4WticX037fZ91MvVkHfLFCO4x1Cv5CKqKM56iwIxt6ZgT6o8JAOgQqo/TqpOUwLl/l
	 9ho1ecEGOFrx1n3/UuZTBimnnwiddXIGjIASx0wplP+PA7NYSU2JhtZWT2nhFRRne1raH
	 cCd2a0V4hyj2/6aTkhuqxB+mSI6TA0wNgR5CcawMvWqmv1I0vSniBfuBiPy0vXC66tk1w
	 FohG584ATJF3diFsfOwlCKPnRyxhnAonqPGc0UxUPc3aHALS49HJ5LKaPs7d5s0I0wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJ3DMmBj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A769606A90E;
	Thu, 19 Nov 2026 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJ3DMmBj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E71F000C6;
	Thu, 19 Nov 2026 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121491;
	bh=zpt4Bof52dDo4blFPTUKDmBeQ0aUkck9+bykbp/3xPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJ3DMmBjeORKp0RAZud/HkCH9x9w7U7vz3qIWPuHa0lFtbh4NxpsOkoHUMx7UdsJ2
	 O4MOJTSxHS7EOmZljF0ppCeib4Pw3jyPf0EBnQLp/sfg1xzw/WIxjs5X/F3mmNEcDn
	 u3hd4lWs7HjYDB1P9s2pGBTpMSmUHhbVPtOUc1TqM73xL5Cd3/XlvKhdOHGMl/uyjD
	 5XNPNi3x55UVIN2LnX9yrE48Kl/hIEx5bk7KpyOeml4gMJqUvrqUd6lH4ehlqQzhF+
	 Yymqmjm3oCKWKTzYVt4mb4/vGJEEH2LNWL9kpkzyYW9+HSaJmxxOnR95mlwoem5xcu
	 ZXjTTT/OHgPnw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 10/12] pinctrl: single: Free pinconf settings array in pcs_dt_free_map()
Date: Thu, 19 Nov 2026 20:49:06 +0000
Message-ID: <20261119205013.2563811-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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

pcs_parse_pinconf() allocates a per-map settings array and attaches it
to map[i].data.configs.configs, while pcs_dt_node_to_map() allocates
*map itself, both via devm_kcalloc() on pcs->dev.

When a consumer device unbinds and re-probes, pcs_dt_free_map() only
frees map and leaks the settings array on pcs->dev.  Moreover, because
pcs_probe() registers the pinctrl device with devres before pinctrl
hogs or consumers call pcs_dt_node_to_map(), devres teardown on
pcs->dev unbind frees *map and settings before
devm_pinctrl_dev_release() invokes pcs_dt_free_map().

Allocate *map and settings with unmanaged kcalloc() and free both with
kfree() in pcs_dt_free_map().

Fixes: 8b8b091bf07f ("pinctrl: Add one-register-per-pin type device tree based pinctrl driver")
Fixes: 9dddb4df90d1 ("pinctrl: single: support generic pinconf")
Closes: https://sashiko.dev/#/bug/linux-fcedec46-4487-4392-a882-3d3bef07e56f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Switch *map and settings to unmanaged kcalloc()/kfree() so devres
   cannot free *map before pcs_dt_free_map() runs

 drivers/pinctrl/pinctrl-single.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 1779ffbc1181..1ba692a7ecac 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -311,10 +311,12 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 static void pcs_dt_free_map(struct pinctrl_dev *pctldev,
 				struct pinctrl_map *map, unsigned num_maps)
 {
-	struct pcs_device *pcs;
+	for (unsigned int i = 0; i < num_maps; i++) {
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			kfree(map[i].data.configs.configs);
+	}
 
-	pcs = pinctrl_dev_get_drvdata(pctldev);
-	devm_kfree(pcs->dev, map);
+	kfree(map);
 }
 
 static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
@@ -964,8 +966,7 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 	func->nconfs = nconfs;
 	conf = &(func->conf[0]);
 	m++;
-	settings = devm_kcalloc(pcs->dev, nconfs, sizeof(unsigned long),
-				GFP_KERNEL);
+	settings = kcalloc(nconfs, sizeof(unsigned long), GFP_KERNEL);
 	if (!settings)
 		return -ENOMEM;
 	s = &settings[0];
@@ -1289,7 +1290,7 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
 	/* create 2 maps. One is for pinmux, and the other is for pinconf. */
-	*map = devm_kcalloc(pcs->dev, 2, sizeof(**map), GFP_KERNEL);
+	*map = kcalloc(2, sizeof(**map), GFP_KERNEL);
 	if (!*map)
 		return -ENOMEM;
 
@@ -1324,7 +1325,7 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 free_pgnames:
 	devm_kfree(pcs->dev, pgnames);
 free_map:
-	devm_kfree(pcs->dev, *map);
+	kfree(*map);
 
 	return ret;
 }
-- 
2.56.1.750.gf70dc682cf-goog

