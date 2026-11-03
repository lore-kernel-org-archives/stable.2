Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701731;
	b=qxbbQiOga3qiJLfhoAotsSd75d1uIyqRDIpKREvuZ0EH1On10DYyfpzfP0DaUIUfZdzW
	 HJOjlYNxctN+ojVJBUQSmfL+LmzII4fQwb0FE8TR65L/FX2x59qPXaW122sWaoD7MuXBM
	 pKb/qYGeO6ZChNPQbIKdCdY9GjqE9+ZGjyw4ykGXs2DvcX3ZHt3sO+u1xHNJgGAXDuWi9
	 g1rSoD/UYPlm73K0/3HYP7bc1vNwn4JyA53rPGThrVJFX9uBZbBsb9+jQWIOvMhv5pyE3
	 Fq+N5Hdl8M9EyA7gwsniuhxHDrauwOjXBnSoXpXmf5h4x6dkiSdNROv+jNz7U/Y2y9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701731;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=WZe/cJSWqnrm7Mkn1udaI2hF9uB4SYoqxNBqVm8ues4=;
	b=bDPbnvrdysxbpIXgU8X68QvUvHhHXkgV0hLfo8T9/tMI1KYntcbhdzWEZ/Zl577We0Wm
	 8KeV46MAWjZBuOGKpNG2I8OfMUl1Miwm/TDWeXDbyxrJ4dKBIBMJ+eed4SPNvaYc0Uwx1
	 /OaFQW/JHAozm6A+kf1eD0NlMg9g6HtOfuRQRGmZMshtabYjdPENG2CIX0UjB2E65RNj6
	 2JyownvMjauYkg67T/BTwbEZ8Ctxiy1C9kBeAipH5F0u/yNSRzdzBX9oMZBMjs0SwUG5M
	 iJWIWc+foIiUFa0JCqMdKhhYT3xmQ0qf6yzDRXE+DRmBtaBzMtDYor6Uyww7Bo8P7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2B6082BF2;
	Tue,  3 Nov 2026 10:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79A2B6082BF2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHkpNbt+lqgak7AA--.3160S2;
	Tue, 03 Nov 2026 18:28:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: lan743x: disconnect the PHY when PTP setup fails
Date: Tue,  3 Nov 2026 10:28:52 +0000
Message-Id: <20261103102852.1340530-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHkpNbt+lqgak7AA--.3160S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4xZw4rZF15Kry8trW5KFg_yoW8XFW5pa
	yUXFWDur1UAr17XaykG3WkKr15Ka97tr9rKF4DK3yrWry5Xr1xWw4xC3y3ZFyUJrZ5ZwsF
	qr9ru347AFnxCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
	BIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEAA2rpnOFw8gABsz

lan743x_netdev_open() connects the PHY before opening PTP, but if
lan743x_ptp_open() fails it jumps to close_mac, which skips
lan743x_phylink_disconnect(). The reference taken by
phylink_connect_phy() is then never released, and the PHY stays
attached to the phylink instance.

Add a close_phylink label in front of the phylink disconnect, as the
pre-phylink conversion code did with close_phy, and use it on the
lan743x_ptp_open() failure path.

Fixes: a5f199a8d8a0 ("net: lan743x: Migrate phylib to phylink")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 82d3ec20ba25..390aec639c71 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3331,7 +3331,7 @@ static int lan743x_netdev_open(struct net_device *netdev)
 
 	ret = lan743x_ptp_open(adapter);
 	if (ret)
-		goto close_mac;
+		goto close_phylink;
 
 	lan743x_rfe_open(adapter);
 
@@ -3374,6 +3374,8 @@ static int lan743x_netdev_open(struct net_device *netdev)
 			lan743x_rx_close(&adapter->rx[index]);
 	}
 	lan743x_ptp_close(adapter);
+
+close_phylink:
 	if (adapter->phylink)
 		lan743x_phylink_disconnect(adapter);
 
-- 
2.34.1

