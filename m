Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6853F7865
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644585; cv=none; b=RHuDOsLlCtdOn7nUwC31IFgW22rqx0d1If7ir89QPS5455bhem5J8xgR3sy9/LURFgaYUUwFVscR4w/AlTYqaxz+rbCoi7IDp0xPBbsxJGTL0eOgfBgySa3A4gRxvxQ44ELV+2Rf6+7S2TKghnKJxwFhg9DTp4Hl3ADQu2yRtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644585; c=relaxed/simple;
	bh=2Hw8LPmeCs3pRRVbNneSU7fu8qBZLNMruN5d88NoZEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I/aGUta6ly7bDfwe24+iYGErnLxEiap4DMHVtKDPr/VIyDPiSQFBrQ4tlc/Ial7LvVgc5FaTuqdtnlu5ErwDUdj0RBcTHeN0o2bMeqnZ9HDx9mQR5qGCG+xO1zu8q6DKy3hEDBFKJ21qhAW+NfM5+ca65zmwxClPDNpJcRCOFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpGvQKv7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpGvQKv7"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so250489a12.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644581; x=1785249381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMT648ai00+XnGVVa+iznQI+riy4WK01QoUhmpZLpkI=;
        b=IpGvQKv7PtnaWeXT3OlDnZa3tc815XhT3IxHfgUCI+BLysu/jh0hnKqCfttCUxLAdV
         QR0Tt2ykrCEh5Wq+w/OUAk4hk5+TYJ9T5EmfAl+/tNylG7g0WnucuGq4B6Y2H1vWsErI
         PfUx3W7sXtvjeRtHB1f+dJSDR2AG3ryncGiMB8qFLEt3iPwVpDyK+wDJhgrr+URpV7UA
         zwjnyDy0BJvb1SM4sosCbKRwQ9T1/XU8L8VuScLBwuxkVckUFdVYXZYq5hiRcCTMiHmw
         jY+FzHqE96T258EOmJ6aM/9t/VO4XVeET6F/RQiwQcDNhbVnDt9kHYkiHsXA06VuUyhw
         x/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644581; x=1785249381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMT648ai00+XnGVVa+iznQI+riy4WK01QoUhmpZLpkI=;
        b=Zx0CvBTYpGbWZmYcaUlgzIAOcOmhuhq/cda7mFVNMhcrMudmfSr7IVGK9EdrnSmqLE
         PQZ1imsjxtAiRvc1vn9nwCrA+ikgxz3e/O3jy/vry9JaH4qzZ6LRHsu/amblthzbJ8JR
         AbYb7TXbMi+fwWNSV1Dzz0ka17ponsuspdkctjbPu+4oIBSsIFBJcWEX6tHbeROibRtN
         R9PdCJ3RI5wsy1tqUb8ovRfdu9+BYKgxx//mvsuNwPHf4bABxbJayR9eHv1tmOgzDYVY
         bNKeXX1Y7G5qa5K8mxbeeTN4DoBOMrD1gz4W5ej37ZeYuuHfZ+gJZ4HLa+sbLqQiE068
         jO0A==
X-Forwarded-Encrypted: i=1; AHgh+RqiCicA6ovBqXghPnynFNYOuxIzML0dlj4ei2/2Yhgn8aSfhCogoT89EU9bP4OLpkYIFcC3hbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjNGGefvH8jr3OB9ymt7dIaySHxDo4DQloru7fJNRZLAUFfDT
	pp1tCK4RdloxHWsxyIxYS4Gs5GxCxZqlM5tZkMK6jn+s9m9OPin6nPI=
X-Gm-Gg: AfdE7clUF+BsfoxizUzpZLwxdQHOg+qM3OQE84kOvjPGMJg7Ldomxe69pgTYtY7lI1q
	c7fv8in2oDzhGDVjzerKFO0v+yKQgHCT2PgZ5nT8h0m8NMvSF/8Sbt8Tah/t7QTsbzC86sirQ4E
	14DoFFfIorf6iMELeb1XiXCTU3KR2uSnc6whsR9+P5QlplGtRgj3LdqbGWA8/51QjxOHwOMKo2p
	ekQRZz4eTHrOJtqCGF7F882TP2sMMMXe0i2lN0Bfs75TLTDUr/6eXdE7vmprjB4FCXZ5Ap9gGFl
	h8WrWVmOBZx6nnpCod6wUIpMwcvX35iKWV7pAhMOiU/vVg57r0eAgZ+2fAlY54I4To+4TMt2FqM
	oQKqgih4fMcsBh7RbNlPFTePRRuhPeOlOxZf/yS1gbN13AgqNCAXpcjm5fJh0mdYWI5CuQGYY0r
	c5UtcEe6mP3xRkOH8z7t8GHA+EV+dJuPqEuPuGe4eAwfrTL9aWuzg/Csg5Rloed5qQ19Z9/2JFl
	lOX3OqlJnQev1BBaptzSBG7599dikqvdMJoRWII
X-Received: by 2002:a05:6a20:cc0b:b0:3c3:6b6e:8ba0 with SMTP id adf61e73a8af0-3c3ad66a4ccmr20423394637.11.1784644580980;
        Tue, 21 Jul 2026 07:36:20 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517aad770sm5955114a12.2.2026.07.21.07.36.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 07:36:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Xin Ji <xji@analogixsemi.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/bridge: anx7625: stop IRQ work before teardown
Date: Tue, 21 Jul 2026 23:35:59 +0900
Message-Id: <20260721143559.27322-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HPD interrupt remains active until devres releases it after the
driver's remove callback returns. Its handler queues work that accesses
the Type-C port and DRM bridge, but remove unregisters those objects
before destroying the workqueue. An interrupt can therefore race with
teardown and queue work that accesses released objects.

Disable the interrupt first to synchronize with the handler, then destroy
the workqueue to drain work queued before the interrupt was disabled. This
ensures that no HPD work remains before unregistering its consumers.

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index fffcd6154..d6071839f 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2973,13 +2973,15 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 {
 	struct anx7625_data *platform = i2c_get_clientdata(client);
 
+	if (platform->pdata.intp_irq) {
+		disable_irq(platform->pdata.intp_irq);
+		destroy_workqueue(platform->workqueue);
+	}
+
 	anx7625_typec_unregister(platform);
 
 	drm_bridge_remove(&platform->bridge);
 
-	if (platform->pdata.intp_irq)
-		destroy_workqueue(platform->workqueue);
-
 	if (platform->hdcp_workqueue) {
 		cancel_delayed_work(&platform->hdcp_work);
 		destroy_workqueue(platform->hdcp_workqueue);
-- 
2.47.1
