Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791159;
	b=s+umupWTUpc5n3ocTOX1cnePWAKFxGKZG2c5TNtYGlxKRZnrfPqsoQ3tGtkkXoVsykka
	 SfkLMosUjoCVMUqx1oN+9+tuPJ2lwgxBtk1jjJemfTk2/gvcWvrggB3zNR7C0aaI08nIn
	 g57Ri0Ewkr5R3PNvdUKcAjXcduGmNAP4s/YY1+PEemXWsa9yaoticZQSh0mJY+m3VIHMs
	 J1pecyLZof0EylKBAM0ZFH2RTemDILHQvHVqCVCPy1gwW6qSbpVy7cLlb8UG8Ah3xdsoJ
	 wbABwRzwPpT6hcr9YjOLA3wVYXyqy/6+o8PmL4vT+0lqj4W1YMyfxBDE0CcdjbPnoAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b5/LXc/PV1p41Z52dor0O1yla1SUxwvD4thgwYAExNU=;
	b=pwL0fv5NcvHlES7rkoOSfoRYHlKuhS2JPwRruPUO2EpnOjeZbFWQHJXcJTynL+zOucNx
	 FtMNlBUmnAfV862anjC1M8DWRtTT2R0SR/uuMYcKejS8KYZEvf5RN0NusC9HPLIRw/Syj
	 iM8TjPc7Bjz4M8TfEQ9WQ6VKMBz9DC2ou7EeWXYEfXjv6b06at0RQd/eo4HMg+W+vSZ0t
	 tmaBCrRDrebVmjhCz/GwYa1TFIdVnzXWW8sOQQSeHFWcRjZvNFEDGvndA0y6+VEekAKYp
	 64mOw5dHA2IyuB8TAKH0YJiypWY1jBVjbaAZKFNbD+bWQPjR+N4vr5eKWghGq4Tdn5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEvitNEh;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B61606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B61606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEvitNEh
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a9be758734so5179889f8f.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791157; x=1796395957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5/LXc/PV1p41Z52dor0O1yla1SUxwvD4thgwYAExNU=;
        b=zEvitNEhQnnkiFfqCrFSmJe+hMVBkZHMIbQ5+wsYaBcP4NLZ8235SkJx4KWb4zRgBE
         Evucn/5SOg8iMaEsllXq8vuYyz5PyaDLKgYdYdtvv3nFi/U0muzua4n0zVnwLzuWb6Kd
         ntEjM7TioiNmYpGx33RLXlkzd4VcEMUICJKt/yxZr0douR0fJSAQkiEOgIPuLHzV+3dA
         T5n20yuKRVEFok4okMDbnQYmIdTCsIKDRM36AS7o2UkeiiIv+/OyRyT+HafxNOHNldNk
         e8Zq/RzwshKW2MJdL8QRcLmqXs3VR+9emZfnU8/XvzzfPyjZKfAHuslC6kupR9RqU0Ub
         lbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791157; x=1796395957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5/LXc/PV1p41Z52dor0O1yla1SUxwvD4thgwYAExNU=;
        b=b6XPOJw6uaizlkt3Yvgyynbf7oUya0OFwC6bjfU+0YoiAKF2JmMBk/gAaN9MvHFB6Y
         ZIg/beKianQZvqVuHIAkyFlszT2UOs5cUSsOcbxYN4R8WWLjLal3hCbLf54x1+SmGyR7
         pRmFS9hvaUj+99j+vQye8KuuULo+w7xQNNkdOBiylDDcRjXZb+SUcl7LPtF3zYqG80fa
         jIS2m4DWgmU34Nttl199BUlOyET3y0WX2r2OV97ixu802m54tJyIVmnrPxAkHTjVz4Cv
         CQ9O5y0378yJGzPY11a5LX9pAM0lvnvop+xGNYASW27GahiI0wJHnWBEMM70LwbXP+Bk
         f5tQ==
X-Forwarded-Encrypted: i=1; AL+hErHVA8Kl55T15ydPuKyMBIKt7dacI/QdNnymqwdMRtZM68zHS3ARksknVf+9zSo+o2nhoaMIjvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z820hbWC7L3vwRtQtdqtTyRP/NA6uP0mYZLAFzN8P4apEaMzhUD
	mAxqsBn9efVGkJDAZpxicgPNOkrpCy3V5xzmLlI5+iyI4+psFqDeP3H4
X-Gm-Gg: AZFdTZeUWgC6Jbu55wJCrItFA0vhD0pGpSy6Izr2S0LjKvXOv4qGEsNYfuE9OyYURwM
	Xkxzj9gXHEIN6rlw8UGbAbdzoeVJOPcLvjACQrvoTNqg/sBM2M2O12d4AMQEKbVtqyza9McORN3
	VHacRrPM+I9dMm0Vu8EfB8x3UoRjDMgbUA80lPawkg3fEyHKeIRml5Qep0ivg9fPaoadTAzisOa
	SeBdLaFSMq/1YL4sFpDi7wjdT1y3CY8hHW/f3bWYPENL2eV9oMcf2Mp8FxVy/+WMG7WnxQd6t3D
	Vf9q3O/tsDu2c7HYfglEG/q72erhje8hYTbfg7ef0pW7Hbx8RAe0jZEOouvDNcRbKYIoZmc5QV9
	A/Tzw6HX4SXS4dGlqnq+n0Yi+UHgTaKwboFKxmflLoKnj820YbEH3KfDWsrzOtKFqik1y2jLCLy
	W3OHNdOqi4KcakQR1ICDOw1rTqNKlyuGAC5n4qmI2U9f2nSo4XnbINzxNFfnfJtThO95RuU6TyX
	cVC2vocZTf4lhR9G4VGM67md2rtx0rfqW84EFz+inrWdniFg+5oyomTIVD0JN8d7DgXIMq7jES9
	T+2k92TWqlcjlDNx9bLw3r14cOv8962Kg2UndPAWYnk50L3MoYAaDd0MBDHR4MDPFppydmOnex0
	ogffgq30ph5hqWdX9xsw6EGxy
X-Received: by 2002:a05:6000:4916:b0:4a5:e50:ea5e with SMTP id ffacd0b85a97d-4abaf64bdfbmr40825861f8f.9.1795791156957;
        Fri, 27 Nov 2026 06:52:36 -0800 (PST)
Received: from emanueleg-nb (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm54475280f8f.55.2026.11.27.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:52:36 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Reichel <sre@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] power: reset: tdx-ec-poweroff: fix return value on command failure
Date: Fri, 27 Nov 2026 15:52:12 +0100
Message-ID: <20261127145216.2058830-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

When the power-off or restart command cannot be sent to the embedded
controller, the handlers return NOTIFY_BAD. NOTIFY_BAD includes
NOTIFY_STOP_MASK, so the sys-off notifier chain stops and lower priority
handlers are never called. The system then halts instead of powering off
or restarting.

Fix this by returning NOTIFY_DONE in the error path too, so the next
handler can take over.

A failed write does not guarantee that the EC did not receive the
command. To avoid running the next handler while the EC may still be
acting on it, wait EC_CMD_TIMEOUT_MS unconditionally.

Fixes: 18672fe12367 ("power: reset: add Toradex Embedded Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/power/reset/tdx-ec-poweroff.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/tdx-ec-poweroff.c b/drivers/power/reset/tdx-ec-poweroff.c
index b4f1c87f5651..5d025a724392 100644
--- a/drivers/power/reset/tdx-ec-poweroff.c
+++ b/drivers/power/reset/tdx-ec-poweroff.c
@@ -79,14 +79,13 @@ static int tdx_ec_power_off(struct sys_off_data *data)
 
 	err = tdx_ec_cmd(regmap, EC_CMD_POWEROFF);
 
-	if (err) {
+	if (err)
 		dev_err(data->dev, "Failed to send power off command\n");
-	} else {
-		mdelay(EC_CMD_TIMEOUT_MS);
-		WARN_ONCE(1, "Unable to power off system\n");
-	}
 
-	return err ? NOTIFY_BAD : NOTIFY_DONE;
+	mdelay(EC_CMD_TIMEOUT_MS);
+	WARN_ONCE(!err, "Unable to power off system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int tdx_ec_restart(struct sys_off_data *data)
@@ -96,14 +95,13 @@ static int tdx_ec_restart(struct sys_off_data *data)
 
 	err = tdx_ec_cmd(regmap, EC_CMD_RESET);
 
-	if (err) {
+	if (err)
 		dev_err(data->dev, "Failed to send restart command\n");
-	} else {
-		mdelay(EC_CMD_TIMEOUT_MS);
-		WARN_ONCE(1, "Unable to restart system\n");
-	}
 
-	return err ? NOTIFY_BAD : NOTIFY_DONE;
+	mdelay(EC_CMD_TIMEOUT_MS);
+	WARN_ONCE(!err, "Unable to restart system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int tdx_ec_register_power_off_restart(struct device *dev, struct regmap *regmap)
-- 
2.53.0

