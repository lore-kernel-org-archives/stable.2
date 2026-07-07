Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC833420862;
	Tue,  7 Jul 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419510; cv=none; b=IvR9ZQNpsSrpqIfWyGTHus9aqD+pxbV66WOcfvY85cCtYhmqRakmnvAWZ367e52FPki0nv0kwPrxIy9ayv1w+4exzXZxlnSjTTIrA4eTVuEdFbqMg/gQCcWEmHtl1mHrVtDhwZo+KEqPYditTS2/LS0rzQ7qp/nERQouOrPF1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419510; c=relaxed/simple;
	bh=426IUqbQPLKj9VRYgxpNF6pGXpR8ZibYrAnRz8aXy4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY4UR9yKcrgClilJW/MGAXWRDnaRmcghQ+FqJdl3Lco1XlNkIIliNKyx6n+fG+vIjo7UHeNC6fnvIXeRBORoIfgzHik/g1yeKUWfYnaJK7yJAizpmko2eR3xURZIWQ+oRQGVZv+Nt5jBrUZ2NS1BVorFv/trz+bfyeUAFg59y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bzASyTsv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bzASyTsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783419507;
	bh=426IUqbQPLKj9VRYgxpNF6pGXpR8ZibYrAnRz8aXy4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzASyTsvTET0k5kCn0yXc1+guR1PIczhQhLg4dWBdgE/qWxivAoLWyQlqdlMc/Mmn
	 n8LTC7PXM9wqVeZE+1eShE8IwEbtbSeA3KfuVhSSslnChM11VNo3J/4hozM957bxC2
	 4J1FkY6u9fsCwP9WGsdJvF6SjdsXqDCupezaChUDH9VwoygoNkez5V8/aLci1BmYe/
	 ZtNs7bOEqVuzc/5XTeChb+fBKFxU0/Pvq4H/et3T5wXisEY5T0IqxZb6FyvduHXaRT
	 Nwzs1URUPJe2R3u4LDIP+PiqduoV0/JLCCEAYtBilF2e9cQWl5rOx389ZOaEUNQLfi
	 OgbcqYYBEvf+w==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4915817E0C88;
	Tue, 07 Jul 2026 12:18:26 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org,
	sboyd@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	stable@vger.kernel.org,
	Sashiko Bot <sashiko-bot@kernel.org>
Subject: [PATCH v11 01/12] spmi: Fix potential use-after-free by grabbing of_node reference
Date: Tue,  7 Jul 2026 12:18:10 +0200
Message-ID: <20260707101821.173319-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707101821.173319-1-angelogioacchino.delregno@collabora.com>
References: <20260707101821.173319-1-angelogioacchino.delregno@collabora.com>
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
index 57b7c0cb4240..293e1adddcd7 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -24,6 +24,9 @@ static void spmi_dev_release(struct device *dev)
 {
 	struct spmi_device *sdev = to_spmi_device(dev);
 
+	if (IS_ENABLED(CONFIG_OF))
+		of_node_put(dev->of_node);
+
 	kfree(sdev);
 }
 
@@ -517,13 +520,14 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		if (!sdev)
 			continue;
 
-		device_set_node(&sdev->dev, of_fwnode_handle(node));
+		device_set_node(&sdev->dev, of_fwnode_handle(of_node_get(node)));
 		sdev->usid = (u8)reg[0];
 
 		err = spmi_device_add(sdev);
 		if (err) {
 			dev_err(&sdev->dev,
 				"failure adding device. status %d\n", err);
+			of_node_put(node);
 			spmi_device_put(sdev);
 		}
 	}
-- 
2.54.0

