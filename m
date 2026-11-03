Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701729;
	b=dnK2lztzHk1/EeuyfqoxfR2RnZK8BY5sqAC2diCm8x1qZsQkaYHpYymEt3+PWY2u2Ad0
	 UZJgj/nL2XqJnuRJrzRBE+nAZhY85ZEGNu/cOkBjxBk1Ft/kHDuA9fANL8Mx9ahDVYTXS
	 duTBV2qFA2VzbfGkgrr/LIjImwudURu8LGzZtTY2BMyMVh4Gd4Y1GReUTXxg4LHzxomqL
	 n0lFCd8+onGWrfI7NL3oSZIyZbLkoP4SOaTcv51Pzi3fG4kZFAYh8DcJqHKK5cYMSIWTJ
	 UllxQCf5N+Sje6oGwyW0YzUdKyd+9AiWaQvm13sJo7WO8WttSyknfLUc/QebQJqcohw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701729;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=1nWpelF9/VGZh/vb7Tz46GHWSc2AwSVyy7M1a5xC1/I=;
	b=vYRab8On/bOch9V/JQwdbHZrzT90Vtz9rOX6kkkc5N2qDP/infslGNhPcgpX2q9IL2I1
	 SrZmzSaatPqnr6Vs8uYBtuxWJnjm+9a0f2IslFvaMnA/bBVK8EfEtJyN/dhtMfOSt1ud0
	 /D8cXp7q5MPewGdSaLcoT4O2jxh4JXZ2ge2sF2oKqqY4qYoRH7CELORIxIjWckxzU6zfb
	 gPYmxbVR1hIqy8KKwQdKv96O+Rpj/7dMf/td9X/rYm13alAImF9vLo2fj5qZLK6pnenJ3
	 e88ieOXbPTaOrck37mV78rh4mIKXpnzbPVbqb/xg0Q207967714C8MMkCOb/KUnppWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8D6071534;
	Tue,  3 Nov 2026 10:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD8D6071534
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADn9ZZbt+lqeak7AA--.2751S2;
	Tue, 03 Nov 2026 18:28:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: ethernet: sunplus: spl2sw: release the port node in probe
Date: Tue,  3 Nov 2026 10:28:52 +0000
Message-Id: <20261103102852.1340500-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADn9ZZbt+lqeak7AA--.2751S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyUGFy7uw4rKFykur17KFg_yoW8Cr18pa
	yUGayY9ryqyF4xAa4xtw18AFyYk3WDKrWF9a1Iyw4ru390yr17Ar4DWFyjvrWrCFWkKF45
	tr1UAFykZFs8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6J
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIAA2rpnOFw8QAAsy

spl2sw_get_eth_child_node() returns a device node reference obtained
from for_each_child_of_node(), so the caller must drop it with
of_node_put(). spl2sw_probe() never does, leaking one reference per
port on both the success and the error paths.

Drop the reference once the node is no longer needed and on the early
continue paths.

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 5e0e4c9ecbb0..551d36ea0579 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -427,6 +427,7 @@ static int spl2sw_probe(struct platform_device *pdev)
 		if (of_get_phy_mode(port_np, &phy_mode)) {
 			dev_err(&pdev->dev, "Failed to get phy-mode property of port@%d!\n",
 				i);
+			of_node_put(port_np);
 			continue;
 		}
 
@@ -435,17 +436,20 @@ static int spl2sw_probe(struct platform_device *pdev)
 		if (!phy_np) {
 			dev_err(&pdev->dev, "Failed to get phy-handle property of port@%d!\n",
 				i);
+			of_node_put(port_np);
 			continue;
 		}
 
 		/* Get mac-address from nvmem. */
 		ret = spl2sw_nvmem_get_mac_address(&pdev->dev, port_np, mac_addr);
 		if (ret == -EPROBE_DEFER) {
+			of_node_put(port_np);
 			goto out_unregister_dev;
 		} else if (ret) {
 			dev_info(&pdev->dev, "Generate a random mac address!\n");
 			eth_random_addr(mac_addr);
 		}
+		of_node_put(port_np);
 
 		/* Initialize the net device. */
 		ret = spl2sw_init_netdev(pdev, mac_addr, &ndev);
-- 
2.34.1

