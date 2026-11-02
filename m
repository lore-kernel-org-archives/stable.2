Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616776;
	b=V5ybwqmNA162hLzR0WYp+ZWkQYJwh3bd7SREKI+7k49rXbKVa3FvA+yhP6Dq85Zc2daQ
	 f83XP72sF1/sjW72kVIdL9CHESqFmhD3P5kDErt5+K6yBVI9M6ncse8BaUtc6gS2eWwB9
	 dw6NMz53276/1XWqaBpWup3BuDAmSKVaEtZdfSHpB6WilLP+pTU9irAwRLMbOkv1hkApd
	 xwwxx7ogVXiUYXvmnOiOlkbMfc+LsAJb1UPwOZ4zJF1GNQldi67/QzOU1r0moMtLt/Hr/
	 BMpm84+f4W1jAt4Xn4cHnMq8q/XzwcTGWvCyfoXygTkbI3K3WFWAFvr2iATk7+e7AGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616776;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=I7uCsh5ftkEjNGPZNb5ZypA6L2HoXpnCMZ01D5n2GJE=;
	b=gmlsamHvMXSsqm6ZTqvvqz61f9P2Phx7rgIpuSzdFnU+qE5wyqhj4Yah0WAjHL3d3F8g
	 6PVLPeYM22A16W09L94RYZz+9xkMyDlxq3XWHDGvIUOk1UI/vKGI9MCVAfgEFXFMtWxV5
	 0zRDccoPBamI9p5ky9FCMQxAzG82KtUpaG3A+O5ToPWHJtEcGl6+A3Y634T7JTspMzpg1
	 8Y/+lYlNhm/WBfwS6yExejbOK2nc8y5Ifcy0L/5psgkfzXQsZjtKJzVGQzg2HeqlYHNmC
	 eWzV13GK8X/uNg4PTnQdsRXPV32QmpFaGfHwAikl2F3UsJVkwgNGJDesmo9d1WYcBVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=adh17Qym;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BB606A337;
	Mon,  2 Nov 2026 10:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A5BB606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=adh17Qym
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I7
	uCsh5ftkEjNGPZNb5ZypA6L2HoXpnCMZ01D5n2GJE=; b=adh17QymMSigTNJ6E3
	0UayBt6iLYSvbiMOhE1lhRnm9PtLSXWo9hzY/uLvpvX2jG/e7HF81bXmSetjwXd7
	cUPlYGunT/nKaiVLMTWaU5lstI5aBpavjxYIx+HJDs8rsnpatdLBvO62StIdXrCy
	q1yQipr1RnODDY38XnnQ0q8gU=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHTpdWa+hqVQKEEA--.44730S4;
	Mon, 02 Nov 2026 18:52:11 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] power: supply: max17040: fail probe when requesting the alert IRQ fails
Date: Mon,  2 Nov 2026 18:52:06 +0800
Message-Id: <20261102105206.1587-3-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20261102105206.1587-1-m13940358460@163.com>
References: <20261102105206.1587-1-m13940358460@163.com>
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
X-CM-TRANSID:_____wBHTpdWa+hqVQKEEA--.44730S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW5WFyxury3Xry3Zw15twb_yoW8GrWxpa
	95GF90kryUXrW8Ca4DJa1UAryrGayvvFyakrZ7C390va13AF4Dtas8KrW3KFWUKF95Zan2
	qr4ft3Wru3ZxG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUkku7UUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC4BvFAGroa1vqkwAA31

MAX17048 and MAX17049 use the SOC alert interrupt instead of polling when
an IRQ is provided. If max17040_enable_alert_irq() fails, the probe
function currently clears client->irq and continues successfully.

The suspend and resume callbacks then see no IRQ and try to operate on
the polling work, which was never initialized for these variants.

Return the IRQ setup error from probe so the device is not registered in
this incomplete state. The devm cleanup handlers release the resources
already acquired by probe.

Fixes: ee2d433cb473 ("power: supply: max17040: Support soc alert")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index f415876..6f97051 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -562,11 +562,9 @@ static int max17040_probe(struct i2c_client *client)
 
 	if (enable_irq) {
 		ret = max17040_enable_alert_irq(chip);
-		if (ret) {
-			client->irq = 0;
-			dev_warn(&client->dev,
-				 "Failed to get IRQ err %d\n", ret);
-		}
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to get IRQ\n");
 	}
 
 	return 0;

