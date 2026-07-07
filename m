Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC13264FC;
	Tue,  7 Jul 2026 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413469; cv=none; b=hc95Xtr4tGEHzoU5BwgN0dJttTokKqFc2R8pYKPNnvFdhmNcH96c79Opke/ar4CnccAnA2Nn5GuqfpygKaTYv2se0Z2cvv9XyJAXUMucrZ7H5H6xZrzu764fEg/Ka9yjwBVIwonfTOnBvYJ/yd7h+5qltXC2gJn5vb7Zg7Rw0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413469; c=relaxed/simple;
	bh=iaQLoHq0emKn/Ux2pZvoEbzv+i4CXFCtM/rTzwYOxmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEBHu2hwUUbayhiq1QRKcN3y9rAttB1AbhdwzcVJhcsQPEqpLiWYdfX98y90U2V6/HBAqD0y8ehhk6mfUmVESG77kJXx52b32zorjw45xUCu0odJpaWef8YMDLfIEn7bcaMZkGeO2tJEt3GEwhenDjhKl8GAPZ5LwlVgkJHniSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AsKnv6ix; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AsKnv6ix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783413460;
	bh=iaQLoHq0emKn/Ux2pZvoEbzv+i4CXFCtM/rTzwYOxmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsKnv6ixZLW/q5z/ejz1gYG7QBKu8tm158Hy/NjJYSr491pKy1mtvKx61es5bhqyd
	 q5fky8VcFsYbuZ9uS1MaTtBSgAY5mj6KLks0Me8mLhdB5NupV+N6yUJ9XTZM3n7Nv6
	 +VcWuCyfdwdq+tIc+JHaGMMH+O46RzICa6YNMnomlgDgOrqFp94fLTeEL5W07weUI9
	 gbnqbqp2gNsFsX+AF2VG9WvQc6wlO9C8IsXlsB9ZNmjv0hhWLRoAaqc8di13H3fL/K
	 HJlHZF+eY/tBcFVWe4yK/twJTaqOdOyXhtmJihwmSklo6xDeb/f27+e63OVD5K1AtB
	 gzvOGCzgdta8Q==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E62B17E05E8;
	Tue, 07 Jul 2026 10:37:39 +0200 (CEST)
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
Subject: [PATCH v10 01/11] spmi: Fix potential use-after-free by grabbing of_node reference
Date: Tue,  7 Jul 2026 10:37:20 +0200
Message-ID: <20260707083730.33977-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707083730.33977-1-angelogioacchino.delregno@collabora.com>
References: <20260707083730.33977-1-angelogioacchino.delregno@collabora.com>
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
index 57b7c0cb4240..6e701aff6045 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -86,6 +86,9 @@ EXPORT_SYMBOL_GPL(spmi_device_add);
  */
 void spmi_device_remove(struct spmi_device *sdev)
 {
+	if (IS_ENABLED(CONFIG_OF))
+		of_node_put(sdev->dev.of_node);
+
 	device_unregister(&sdev->dev);
 }
 EXPORT_SYMBOL_GPL(spmi_device_remove);
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

