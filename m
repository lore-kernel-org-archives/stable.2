Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024B41441C
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189137; cv=none; b=nfb3KGQqMcyRm+5WprQemtJAltm0PInONMolgSOVFKToeD0fWDtOCzuhc+gzWR8yO/sDfFZ0HOUDW9KGOsxgszAnJwGtWbjBg2ULeBIG23L/91WXxe/AdS9Dd1d59/uI44bXK4wWdbP7Gs6SsNMHJR/awhHniv0yzGVWEYE/FOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189137; c=relaxed/simple;
	bh=nvNnLjE/d1Qmm+m3sMt3041G93z8fEvRmrRp8AFTuEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BguQsnq+95GY0IdP05QZvG3yXYw2gCE6nEXYlvSn+JgraW4eOalONMJSgKfX0V5ZtzVMVaoaDBbiGO/huyeLbX5kBq8s2AfjohnO84FRlcj4kLklzEUCVUQTQE41/GvHo6eYMhTHm+eru9nWHogb2ppH1Y8pnZyoG8Pn59txtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJXOke6I; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJXOke6I"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e5059fbso427049e0c.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790189125; x=1790793925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BOfeQ15b3E2+kaWVk7ZQ6pHBUpc05XcoB8FmwWmuDUo=;
        b=oJXOke6It21Apnsw7bHMRlYyLhcKdXBdGDXgj7hfvAya8ZFFO/TS0Our0vtQBqQmRZ
         MLAosUp9FISNDFVi0zU4EnbkN93K4FZqs1IvhmcWISpZCcHiwFW8ET9tWdt+U/dDAykr
         O9y0lc6bqSL2gw4n1mvVQFLFWh7FSBgZuEK0623xAd9VqsgEImepJE49gz5f7PvcrUBq
         EfqUCqzfydv7QU5eo7Bez+Xws9Qnj8W/2+NXF7dr3dRabjDTn7rAo/iyWwsPTg1O5c32
         A+gzHHqsCSo2UVXFLvMRPh7wCeiQyOsO2COKYPkNqr1bLimtj3wUi/BCn54G0fO57lan
         mKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790189125; x=1790793925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BOfeQ15b3E2+kaWVk7ZQ6pHBUpc05XcoB8FmwWmuDUo=;
        b=cCyp77lfPFMzqNmov8dxdIsItydYdBhqhinhdRJQwf6cAnt8/qQsrL3B9dnq6JLuYA
         xIqZ/jLCx2nvjH+7hvy7/r3FBthm4THe23tTHYF3dJb+VqyxzzQE8/x7WQFCEwkhUi+c
         dZZMay29f7GBMDVIEkLcUAA8B7wd3nMEHLPLAiejbyrS7rnORyFD2wqTzQ6qN71ThtjN
         m4pe60Ns8jh2DgbVoupUJvn9KxpTkctbmJJLpx9is5hziQN6JLZkRoPhcYSn9YLiOVcl
         lPMrO4YtYThpg3oZrvjDnT8gK9T/LhzG2ed8lQ2CB4QhJnh48Pb672wfUC2dWifdMXjB
         /ZIw==
X-Forwarded-Encrypted: i=1; AKwUvBy3mx9PeB1lTe+YE72HU7fA5ajZeMXYgpzjIqCYdlAIsd+cDEpyOFjA5mHnS0IOd5qKzSXe4v0=@vger.kernel.org
X-Gm-Message-State: AFuF++ndgqtqMG5u48MzmHl00GuwPUvHZFtjaabxOdJ5e66dUcYJ4sF6
	/QFriIYDRbcgVT+VngCYPnXfNWCsgYkZsXu6PKus2lUsrOwSeL+mZ1rS
X-Gm-Gg: AYBFou0O5LyY15byH2k/YaWgqjxBWYDokMChQSWDmU3zeY2uctpzGtuqvJogcivDlVP
	QA1K0h31gJt5mg9NydvIfdED8YgyDhuTlwG31eO7zS0ugmoT8JM2J6ni3r1FYxH1t8Ep9X5/Ll+
	XrB3KI6sBSh9cz6edlsg9FWH0w54LnI+TjTQLA5Js4HHtGKg0IvCtx3UJgdrbldbmsk1UqJ9Uaf
	/yXgYwZy6iP2StYQ+l2l/Cu4CLN2uRdnE5iqHK/xpXNVFPwZZJZGOfnekvxCgyKK7LEWXfjNHz3
	2UfhX5jcTZAVYYTe5srqGvRoHqN1BzeHWNLoyYXEjHMhnnyqVWFOVWLTB3e5OinZdYsZ5DJnFVo
	I9xXZh0gIuGln/UOBpTfCnsbJG7U9W+wMxmEHCgNBHUPxTOkE66NtD1xZdLOLwXPaicKGqybIlN
	PkbnCquxxqiXCfoF64BN877Tb0yHzj3dYgSzBbgJT/ZNSaYE6QkwoEWuCIfqNPS4DIjcb7hfkPD
	scE/nkE91PT8KLvFOWxtxUOLaT4XS4ANucg3+VOpifcTQupogCAMtNKz2mfEyt9spav3czimoIm
	CK3JIclfFqkTvTq4Moz8Twcg/U1SVYeetmNaLoNERCKjhDTSR/4ij5l2
X-Received: by 2002:a05:6102:41a9:b0:7a8:3fba:361a with SMTP id ada2fe7eead31-7af1f3f6a52mr75793137.37.1790189125139;
        Wed, 23 Sep 2026 11:45:25 -0700 (PDT)
Received: from ututo.. ([2803:9810:87dd:de10:d33a:69d6:aa79:a5ec])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f0582b6bsm4303825e0c.18.2026.09.23.11.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:45:24 -0700 (PDT)
From: Lucas Costa <2000.costalucas@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-spi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lucas Costa <2000.costalucas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()
Date: Wed, 23 Sep 2026 15:44:50 -0300
Message-ID: <20260923184450.135601-1-2000.costalucas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_compatible_node() returns a device_node with its reference count
incremented, but the function bcm2835_spi_setup() uses the ret value
in the loop to check a condition and never releases it.

Store the returned node and drop it with of_node_put() before breaking
out of the loop.

Fixes: e19c1272c80a ("spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent")
Cc: stable@vger.kernel.org
Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8f8715809c7c..8909757c94e3 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1226,6 +1226,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
+	struct device_node *np;
 	static const char * const pinctrl_compats[] = {
 		"brcm,bcm2835-gpio",
 		"brcm,bcm2711-gpio",
@@ -1297,8 +1298,11 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pinctrl_compats); i++) {
-		if (of_find_compatible_node(NULL, NULL, pinctrl_compats[i]))
+		np = of_find_compatible_node(NULL, NULL, pinctrl_compats[i]);
+		if (np) {
+			of_node_put(np);
 			break;
+		}
 	}
 
 	if (i == ARRAY_SIZE(pinctrl_compats))
-- 
2.43.0

