Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F84446E4;
	Tue, 21 Jul 2026 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626595; cv=none; b=XzckiQ5NKkbtOMBM4vZIPj/iCDNr1/dPnPpqBVDu55oAHSEZOr02ErA2M09Y2Ll71tUwAX0BZS4NEGfJ06z4ZRFSwIX6IFa4SPgxV+OVa2JpIKR1wRjoxyYSeyH1AYCAgmz2lga2Tvohia7EaSubP8LgM0ANu0et6yiayMs0bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626595; c=relaxed/simple;
	bh=UjfNXgF3s7L3FTzKJThRG5oNM8jZglNFcKi7mxpewEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pvs7JYpg8P1eEpk89vxkybKcxHp4k4APBUbKWZxTGbP43rRSftFlKQLb3RS1UxQdLirISICN4nSOwFUDo8sA+Dg2q0tsHJTuAjSg1gVPiMP5H3P1XvII8OboValmjhyzZ87hclXlVpnREDTVJ60UaUAELBedV4Tttz3QpWxJsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JwwI4juo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JwwI4juo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784626592;
	bh=UjfNXgF3s7L3FTzKJThRG5oNM8jZglNFcKi7mxpewEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwwI4juou5roxp/z2ALzzKtSkD9s5yP505LwJBEY4To2VYfc+BqIh5TJ8HGY85MEw
	 sSY6H6GTNiL4adCOL9V6XD6yXON/DrcVBLkYovYQMaRH0+aV70mXmYE6cDm40ZcEBm
	 9+MTXGQ/XGgmVZ7UVI2NgF/cIICgml4BTI7AmZP/XBTNmdPWWxaSsD7Y91q7mcrKh+
	 dmr5TIzW4Wte/S2zFahF/f7407pYNHGxAsTxBEiZB57tvFd2zjaC0zrsaTdI8qceBX
	 MrSIuH3fFOZFTWYqoVst0Cju4wRDTxN3LgrzIPkYj2SWtnywrKty8oiVUUM/NF0Vnf
	 tQL6OCh8FQl+w==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F41817E071A;
	Tue, 21 Jul 2026 11:36:31 +0200 (CEST)
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
Subject: [PATCH v13 01/12] spmi: Fix potential use-after-free by grabbing of_node reference
Date: Tue, 21 Jul 2026 11:36:15 +0200
Message-ID: <20260721093626.96264-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
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
 drivers/spmi/spmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 57b7c0cb4240..f6d2f4bddfcd 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -24,6 +24,7 @@ static void spmi_dev_release(struct device *dev)
 {
 	struct spmi_device *sdev = to_spmi_device(dev);
 
+	of_node_put(dev->of_node);
 	kfree(sdev);
 }
 
@@ -517,7 +518,7 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		if (!sdev)
 			continue;
 
-		device_set_node(&sdev->dev, of_fwnode_handle(node));
+		device_set_node(&sdev->dev, of_fwnode_handle(of_node_get(node)));
 		sdev->usid = (u8)reg[0];
 
 		err = spmi_device_add(sdev);
-- 
2.55.0

