Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC943CFF6F;
	Mon,  8 Jun 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931457; cv=none; b=osbT9pZ5e9q9Hjs92qTCCZlX2rG4tsQGiDCllZelypb6utI09WmJx8rp4XOnne8BxzU5z0pE+5j2MK22pJ2iypR11UFwyx80O4YoSBdmdHe7/ylh7tWqcgt84wHAekFR7v1jHVC2C4tGdwczoN0XF3UuhM8LRY/K6kbb6DIFA5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931457; c=relaxed/simple;
	bh=Yxkset3JUnaRKoM/mrn1HFFVhAOtEWIzYVfs1dJhIzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyIfhvB+fIh9uSp667bJnOzjXutlMofhaNrdrN3eAJSPLAtdHzx7/snYeZsGcjhhvIPDQf7hpKn/ggRJYxd89vKwTrgpfDbXGR/h63tbFDBn42WpksNaF/4/UWx2EqcRQt/7aZ4Tba5zV0/0Rp4/QbsI1z41UQZJi0hZ5bRsC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C6o7QfAA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C6o7QfAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780931454;
	bh=Yxkset3JUnaRKoM/mrn1HFFVhAOtEWIzYVfs1dJhIzE=;
	h=From:To:Cc:Subject:Date:From;
	b=C6o7QfAAeDis4ucsR1DAtnR3GCEGmPpdiHs2RfPpEaj7Aul9TwJuuWsUcTjO6+VQF
	 cXDTi4wAHXj30ZjrTBsJR/pb6UyDc44FyRO0VRoaIfx+GjGlb9XRPIabRKympBFr2v
	 ltWl3dZWK+LIQpUiFcEomrq+E4MQ8ik+vY076cmX03gS2IMIJSCEbSW5sRjZ7QC3y+
	 KORnCsLXHzPVOFF60jDZELzDFpPYZHyOYBBqzp/BwcPW3w+IPlIQyAUSc+U5UP40bq
	 +CPRi/AImp/DlZIIdqVinXD+ewCDQ0qPuH3Sp9AnE0xJ/5OkqtCPbY6GqOCq7FAGVI
	 gzbn8cEoLVgfg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4967517E00C2;
	Mon,  8 Jun 2026 17:10:54 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: gregkh@linuxfoundation.org,
	saravanak@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	stable@vger.kernel.org,
	Sashiko Bot <sashiko-bot@kernel.org>
Subject: [PATCH] spmi: Fix potential use-after-free by grabbing of_node reference
Date: Mon,  8 Jun 2026 17:10:45 +0200
Message-ID: <20260608151045.60069-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As noticed by Sashiko during a review run of an unrelated patch,
in of_spmi_register_devices(), for_each_available_child_of_node()
is used to loop through children, and to also assign a node to a
newly created SPMI child device.

Problem is that the refcount is dropped at every iteration so, in
the specific case of DT overlays, a use-after-free may occur when
an overlay is dynamically unloaded!

To resolve this, increase the of_node refcount when assigning (in
function of_spmi_register_devices) and release the reference in
spmi_device_remove().

Fixes: bc32bbd04011 ("spmi: Set fwnode for spmi devices")
Cc: stable@vger.kernel.org
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260608100949.36309-1-angelogioacchino.delregno@collabora.com?part=2
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 05915176f21e..b4f30e7e9372 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -97,6 +97,9 @@ EXPORT_SYMBOL_GPL(spmi_device_add);
  */
 void spmi_device_remove(struct spmi_device *sdev)
 {
+	if (IS_ENABLED(CONFIG_OF))
+		of_node_put(sdev->dev.of_node);
+
 	device_unregister(&sdev->dev);
 }
 EXPORT_SYMBOL_GPL(spmi_device_remove);
@@ -592,13 +595,14 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		if (!sdev)
 			continue;
 
-		device_set_node(&sdev->dev, of_fwnode_handle(node));
+		device_set_node(&sdev->dev, of_fwnode_handle(of_node_get(node)));
 		sdev->usid = (u8)reg[0];
 
 		err = spmi_device_add(sdev);
 		if (err) {
 			dev_err(&sdev->dev,
 				"failure adding device. status %pe\n", ERR_PTR(err));
+			of_node_put(node);
 			spmi_device_put(sdev);
 		}
 	}
-- 
2.54.0

