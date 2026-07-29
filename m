Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF94D90B7;
	Wed, 29 Jul 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338599; cv=none; b=CxxTQN6g8Iu97T+jFcuD+ecAMC3Nvhec2UAL2VnKV0RNqCX7wyRaIKxxuZoSaUdBPnp/119uuNe54Uf2lOrcvl2EOJspgw6ktqwRF7zYwj7UHCYetq/J9odgCbRGik85j3qKwjzTD0grxdMoM7HvVDjXf7nc9p9oZJLoxDJ9zRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338599; c=relaxed/simple;
	bh=obc3cONwMuXm0CahGbeMX6PQND5qwEnkJKs3olgUTuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic9wODGnkNbBCVxy8Ao+aeV+UuOj8XEtDd8MLLc8V2dizarpgr3GRJhJiLaux9IBTVKyQKr8CIAXBnRcDIoIaZHXKhLwjYRmsBomhlQhYwv65wZJqlCwXnaQ+qQm+3EMrpUOYyRcPA4pnnTLFhOUyNitJ0zKpkzbnaisNyl+pYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=QPc8IUJc; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=oymYrjvj; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="QPc8IUJc";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="oymYrjvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338596; bh=obc3cONwMuXm0CahGbeMX6PQND5qwEnkJKs3olgUTuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPc8IUJc8yu7d8j/f0g4RMsaTmWsQ9ntU/FccwF5qu2iFKgPOWsk0Ccw+6IJHuBBu
	 cz8LJh7mZdcgpU1adMegvLVauzy7j/c9qFU7847L5krm9b+qoxLKbBWU3cFpDWXzWP
	 7tE1FxJI+kKB8qdi1C2KeGuQ9mY3MFrGavxA/CgN2mciAI+t3sVJu7QIsnpbyB4lBZ
	 8FWSsMRmZn3aQ5te61BEbbt26WsJN9LkrI/QW1mcxmazA0LrZnEf7yZtg6I6czckw0
	 C6+zLsWszBZJxRCUx/Yq5KmAOVqRQIi+1IManTqfR7oBwyaiuvuHnhBpjhy+Do1xDr
	 2t/lsXfKvTUfg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 2CDC042554; Wed, 29 Jul 2026 16:23:16 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338593; bh=obc3cONwMuXm0CahGbeMX6PQND5qwEnkJKs3olgUTuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oymYrjvjwpfZc8j38jey6VTLx1oHJBJuyXrsn/ewxqka+GR5OpFMdiE4GmyO2iG8i
	 0xMyZ5kDVFLfTvNA21oU3fvIoJlCoqfGdg7mzZNrHVNDeYzdEC8/5lmtqYKG4IwtcW
	 RU4g43fnm4ABhXDRl1/qilly4p5F1A3N0OW4u1R931IQSTTla8w+0z4ksM83h/TPCZ
	 8VSjOAiZzU2+l0x2GEZQt6PWRK7dMNzFSZsfhCfuTWTnc9kx5OaFMTCZtYDgdfzfgo
	 CRTqzL+wAtr4Z/j7M+WmW4McvQJJ2Hp1NxD7yxVUsD4UXmxqxIjtw3PEILbPCvvdlV
	 2vholJ1pRhACA==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id AA67542528;
	Wed, 29 Jul 2026 16:23:13 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/15] media: meson-ir-tx: Ensure rc_free_device() is called on unbind
Date: Wed, 29 Jul 2026 16:22:46 +0100
Message-ID: <b7d2de03f7573fc0854a6b4c686e0b9dc6b60b4a.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rc_dev devm managed.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index e7bb107e6a84..abb107d19e8c 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -345,7 +345,7 @@ static int meson_irtx_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "irq request failed\n");
 
-	rc = rc_allocate_device(RC_DRIVER_IR_RAW_TX);
+	rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW_TX);
 	if (!rc)
 		return -ENOMEM;
 
@@ -358,10 +358,8 @@ static int meson_irtx_probe(struct platform_device *pdev)
 	rc->s_tx_duty_cycle = meson_irtx_set_duty_cycle;
 
 	ret = devm_rc_register_device(dev, rc);
-	if (ret < 0) {
-		rc_free_device(rc);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "rc_dev registration failed\n");
-	}
 
 	return 0;
 }
-- 
2.55.0

