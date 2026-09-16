Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258B3905EB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524249; cv=none; b=oKoA/TDPjLge0bAxsE2Y4C6PvuYTyW7CmlY/CksFIoJ7D10VVpaUU0dSVZycOtxirO06RPcfCPk0qRuEsokIeLCPmZTwkwUIng80mH1G5i2vukCJkz6ZGrLIxpQnKUik0ybxDsUoYNS1Jvw7/F0DZOiD55PaobB8DwTi+a+Tnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524249; c=relaxed/simple;
	bh=VYcIVUSYQLV4sjwuoeaRc5KM8Pt0LayXAdVTM+vIopM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsbGN4UrKRmUs3bdDaycNTw80IYoXgCRYlVIobjAvb8cl28BO3PNyIWw66KnRchQ/j+IDxV41Vx9PGPb2IPyn78OVv7RpiOhHLN8go6HDSb6R0QWuS0BxmwTZKfcRMJDPFts2QBaR/K/p6HPQTsPbr2jaPTOOCgmTphq6e/hwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dju/W7Mf; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dju/W7Mf"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85a4329731cso262933b3a.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789524237; x=1790129037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GY32qtKDHLqp705JJ4dXs20ZzYr5H1bBKfaTF23PTKo=;
        b=Dju/W7Mf62vk/L0wvQpBefMZzv8TJPaWkwY41Y0SYjiTKxxy6Yapehzh8+/y8sqWG8
         OA8CgXwV1AyPokG+fr3xKR5UwjDGbpBQiHs/6EflRLtqGwZfZC3XOaX9DzDg7bx2ttjk
         h55wAjKixZn4si8w/AiRtV+gQjNjYI5ZUds0WszsFz5ZHmwlta2yuNpbt9Y88yGpfprv
         Ybq/qCUucgt9HnYo4I2ENvhNVN5QQClwGpHIm0mRgJLAQOB9VRgAsyR7DstHQ5hLcuRV
         XcbmLBQpkfPQ+Je6C7fYAzwma8oOumjjTq02EqvdZokI6UffpXmlke1ibT+C8QrnrPjb
         1rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524237; x=1790129037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GY32qtKDHLqp705JJ4dXs20ZzYr5H1bBKfaTF23PTKo=;
        b=YlujfZqXfD+9oCFbuvTU+I8y0Ghv9jDNA6I+hrvB7BMCV18zstNuYi061NLH9WYdei
         17QqviVrnZ4BMaYLHfcvx4UrOtjFntTF6LagMg8EnKDVsPaowkF/vSwPvnzYpD10q9Zi
         /swn3sXeVNxH1updo3UXLhCseFvNlGdk5/1W5JMtRy8zlx7ZjzHVHN0urJbR/gaZFOZJ
         Q1OO0Enfzs8W9e+RBvTR56e1NqUu6d6kByCZcqCQpEHLl6NqfOA4H3JwARykMy1AZpJg
         u33Wby8wcqebI6ybtCyEXoUncwl8KFCXcRmeO+gfyvL+X6OHW0rRGB4gexJ5tfdXpyVD
         r3CQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmEPAeEADFB6Ebt1FkyBAOPuoC/7dPD0uyacmfdexv0g3hPzzF6C4MsvDuF5whdr9zFJpjt3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mu+w2Rh5Wop0977EiwpQ9eJGNOp5A1ydIU6Yaq7/C/y8MKxhZc
	UUxsi8JN/D1GBDXVSJkvFtiXwgMND/bGbcGT6epkmj26CfqYZFKmHYAZ
X-Gm-Gg: AYBFou2sg0vSblv0BohjDx6dQIWHXMkvE4/xUCqr+yx0DYBGyVOLsSxQoZ+hdV/c99d
	MCUW5Fz73xOdf8z8fDbySgYOXqorft2PVlS7Ting+Lq89oA7A5BHrRNY514WS2Lb5O8dULPVI1M
	0vZPFWSLtYc/OoJEumBGoBydumSUnxmPnBGHmvN7hg+3hox1u2MMXaOJOktqFoAWjkczBkJyMKd
	wsypeL+FBevcVCeRVW8UWqXv2wo2lfJa0zW6zizA2f4Kq6wyhH0fWeorHAKO4z6j7uDF4F2eENK
	ObNPUfw+qkh/FKn8HQBXP/NXwfntQSzjLQ2B+VQF7lOTiQrrkgDTbIiU4de1hwvhrfbhmYk4zyU
	Qb2FgJmkYPblqqzIPgdx8KKO+N5Bs6xJWW6cI8B2odElaCMCrQzSN7XUR8w7d3jpBAvJE6qDNd7
	cI/LrZhzLw+vKlpvah72ULcrUyNV+VDAMDolMUNsVsj64qS60K6pkN1g==
X-Received: by 2002:a05:6a00:1a8c:b0:857:7317:cff5 with SMTP id d2e1a72fcca58-8723a4942bemr1132881b3a.22.1789524236922;
        Tue, 15 Sep 2026 19:03:56 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872024e4369sm385031b3a.58.2026.09.15.19.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:03:56 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: mv88e6xxx: fix netdev reference leak on remove
Date: Wed, 16 Sep 2026 10:03:40 +0800
Message-ID: <20260916020340.2580417-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv88e6xxx_probe() uses the referenced network device provided through
platform data, but the remove path does not drop the corresponding
reference.

The probe failure path correctly calls dev_put() for pdata->netdev.
However, after a successful probe, mv88e6xxx_remove() tears down the
switch resources without releasing this reference, leaving the network
device reference count unbalanced after driver removal.

Call dev_put() in mv88e6xxx_remove() after the switch resources have
been torn down.

This issue was found by manual code inspection.

Fixes: 877b7cb0b6f2 ("net: dsa: mv88e6xxx: Add minimal platform_data support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513..e4394af2a3a2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7464,6 +7464,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 
 static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 {
+	struct dsa_mv88e6xxx_pdata *pdata = mdiodev->dev.platform_data;
 	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
 	struct mv88e6xxx_chip *chip;
 
@@ -7486,6 +7487,9 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 		mv88e6xxx_irq_poll_free(chip);
 
 	mv88e6xxx_phy_destroy(chip);
+
+	if (pdata)
+		dev_put(pdata->netdev);
 }
 
 static void mv88e6xxx_shutdown(struct mdio_device *mdiodev)
-- 
2.43.0

