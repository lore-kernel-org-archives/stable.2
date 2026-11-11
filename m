Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434044;
	b=AyxksrE1+Uu2+FvUM9s6wVgZSAuF2OyLchbpNYMwLf/4LBSqWOLgkRpSPmtbvh/uW9ZM
	 VgDjo1kzqIfbe14IiAY567seHKfc1YxjcstNoylNhZJGZECRieiR90flUaAABEloS7mYd
	 6rhSpuuCcep6gWsoNqtNb7m3ZWYYXYnEQ30mVF/yaOZj1eMCZ0WmfRgLwXMeVSY3CfRk3
	 7Gpk91zOtvtQyRYx6yfJgxrXjEpbq4Ps6n4noMBxKQQSD1sorxmDkRo9sR0UMPaT28t1e
	 1yhebPvNIOB5vjVR35M84cdT2kLNrFgsw2SuDVEq5H14QoambBDs2mIaEx4FsKL9Y9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tuf8c1dlqjfS6dbHyCUO3x+DWJUmuzX7o0coWObKxGQ=;
	b=wflcZTPCIo847szK/z9ER11h5B95n/bkNP0J4mf9oCjfokQ6n+wHNLzt03uPPuS8xKVr
	 8328UC7yTGFnf6AXwJGfwjzj/K3jZEAbX6QDy3UnmhEw/ofbGM82vVyyJ+gB6L/2XFSC0
	 5I6991YNEMb/04zIqeizr5GKIAoB1cnz17fMRbHkASeDwcrR0nkxe3Gy2Xar0csGFdrqy
	 FnFstZidsecyA7S1dA8WXWxHt2+MWN9+9CqPOQvPIFgPa4YZWinWSBQataXsIuX/SiyST
	 zQ5aD5+oQZN8Xrvmb4pQFikaEDl80U2ckpcFLIwBBxVzzDdShryOmZbJ7xhX92wen9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhDBxcV5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACA606A335;
	Wed, 11 Nov 2026 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhDBxcV5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D2B1F00A06;
	Wed, 11 Nov 2026 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434043;
	bh=tuf8c1dlqjfS6dbHyCUO3x+DWJUmuzX7o0coWObKxGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GhDBxcV54Kva1Fq+NJm+2XQQubAC/+TC/eESoUhg68uhbvb599SE9NubrZ1l6ZPCj
	 ILR7HbuWX3ep560jXWlyfTGlIIfE3WCMhKujFeqvzIEarxxMswXuTGjqJoXSQG7uVy
	 e1j+hJl1lDpzWNe/WM1SXcUKD6S+mFbZHeDBVjBeHkFouySnjStY3QBi41Tq0RdVxj
	 Ew5gYAcS72WQ50q/WkRIPmMU0mtZroTt4W1wZOIUXxVtJ61VI/O6XRxwm+Ppmg4bJJ
	 XuPQ0gAypiXPvYPvYncq84vNmikJjuYFWaAPKgTDRbl7fNRk16n5AGoGnT+ZepTAsL
	 KmEh7LA81HONg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] pinctrl: single: Free pinconf settings array in pcs_dt_free_map()
Date: Wed, 11 Nov 2026 21:51:53 +0000
Message-ID: <20261111215256.1982044-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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

pcs_parse_pinconf() allocates a settings array via devm_kcalloc() on the
pin controller device and attaches it to map[1].data.configs.configs.
When the pinctrl core copies the map entries into its internal tables or
tears down a consumer device mapping, it invokes pcs_dt_free_map(),
which only frees the outer map array and leaves the per-map configs
array allocated on pcs->dev until the pin controller itself is unbound.

Free map[i].data.configs.configs for PIN_MAP_TYPE_CONFIGS_GROUP entries
in pcs_dt_free_map().

Fixes: 9dddb4df90d1 ("pinctrl: single: support generic pinconf")
Closes: https://sashiko.dev/#/bug/linux-fcedec46-4487-4392-a882-3d3bef07e56f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/pinctrl-single.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 13e0ae8bb389..fcd86dbf6869 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -311,9 +311,13 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 static void pcs_dt_free_map(struct pinctrl_dev *pctldev,
 				struct pinctrl_map *map, unsigned num_maps)
 {
-	struct pcs_device *pcs;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+
+	for (unsigned int i = 0; i < num_maps; i++) {
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			devm_kfree(pcs->dev, map[i].data.configs.configs);
+	}
 
-	pcs = pinctrl_dev_get_drvdata(pctldev);
 	devm_kfree(pcs->dev, map);
 }
 
-- 
2.56.0.567.gdb80ae8cd5-goog

