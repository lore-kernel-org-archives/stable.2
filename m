Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701738;
	b=KVQ3x59v9X+FyFqnN4ZNvquCrrhLdL0G7Csx2f4ujwv5EW6Eq+FI8YYvlDXqIKOvU/0X
	 E+MzW0SyaGpoQSGrsUsTATo0uqjzR9pwjaeWnq/caLV2bGnhem1TajbzgKO2okXGUySlW
	 6Kc4Q/dWtSU0OyZl1ZjLxTP2iNcjDDjvMXJ5Xl9xzduVpGi+ECoENIJyQPCkSeqBUToxz
	 IX/NPe8hunnP+hJjO7xkUU88aHiPZD8j7BYwuAl124aKw3fooCbMWJyNJ0qfFmJGvQMct
	 kiTDeGSZ1/bURsTD+DEiKhAvj4IjSUGVLmMHRqBSRIPeJLOYxzoRk8IM5uctiUCtvyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701738;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=40yTtbdn8VbRGx88pw7+jG7vAuv8d/KNPCAIQ8kDfI0=;
	b=iWQmvpW7sodfpdVTXoxSbICvMJBnubn4WXOy088ipgKGkU+6thQzA75RYce2j3mGkiwM
	 LDulwMuffANI1jhutGe3+WO5UTqdBEZSaBOOR7aOFQaIwpR+I1nzHC3iSmMtux6Y2QsBW
	 8GngeVffFWV5nH4fxpxcVxz+XtmVqyaIgK+CPJlwQ6TzKiC1X/e/E5oRWgkqL+441+BvC
	 60uPbr2K7850OLZR+AxI2YDsW1kk2iPgh4XWkmkk2JxYSFsKt/3JVEiUcQ715TxN3VUpb
	 yhrtmc3f1v8TapV0avkMsbGKXjT13gvR8W7bZ88XR1s8eLWCTz4yNJb+vuDQgkiSpug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16F6083606;
	Tue,  3 Nov 2026 10:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB16F6083606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QZJjt+lqy6k7AA--.2735S2;
	Tue, 03 Nov 2026 18:28:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: phy: microchip_rds_ptp: unregister the PTP clock if init fails
Date: Tue,  3 Nov 2026 10:29:00 +0000
Message-Id: <20261103102900.1340854-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAA3QZJjt+lqy6k7AA--.2735S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1UCryrtrykArWUury5CFg_yoW8XF47pF
	WrZ3sIyr98tr4xXwnrta1UJas8uw17trW3uFWxG3s09ws8GF1kXa90yayUZ34UGr4ruayD
	Xr1UZFy3uF95CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgAA2rpnO5vcAAAsi

mchp_rds_ptp_probe() registers the PTP clock with ptp_clock_register()
and then initializes the hardware with mchp_rds_ptp_init(). The
initialization performs several MDIO writes and can fail, in which case
the function returns an error to the caller without unregistering the
clock that was just registered.

Nothing else releases that clock: the callers abort the PHY probe, and
the clock object allocated by ptp_clock_register(), together with its
character device and sysfs entries, stays around forever.

Unregister the clock on the error path, mirroring what the remove
callbacks of the other PTP capable PHY drivers do.

Fixes: fa51199c5f34 ("net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/phy/microchip_rds_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 2ad95d5c9d86..0db6eeb2660c 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -1318,8 +1318,10 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->phydev = phydev;
 
 	rc = mchp_rds_ptp_init(clock);
-	if (rc < 0)
+	if (rc < 0) {
+		ptp_clock_unregister(clock->ptp_clock);
 		return ERR_PTR(rc);
+	}
 
 	return clock;
 }
-- 
2.34.1

