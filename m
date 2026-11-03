Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701758;
	b=ZqpvTBh3xYQBeSM98MOOpT0pI5QYXACtx3rNwDLLimFE9sw+1AUT8AKa57DdhM2vkYWp
	 RriQd+QfXzwCT5CD3472kkQ5yz5icDLCsRD9c3dLATrMQRFY89++zmyp8tWDpM+2OIjOL
	 x1IovrdxMjlBt7oiKTXKsJHUApwEi8UMvK/JlCMJqDgwTfuOucapeVNo28Jx5B8yL3W+y
	 ugGakuFndOdEGYI0eT2yXJG73FxWj48RjII8qVtnKW4HD7nJ9XxBxWMvaAc2uPBUKFvcu
	 ar6RJy7z8JaG58YywZfV+KyLz3PYt2cEeWOopTWxLya6hRHhTs1DUE9zCAO7cXSDgvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701758;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=XnVUOlkYR8zo0VkJWoSV5NbLPA4v4KJWJQ3QpBwthkQ=;
	b=AwGIHouqZjnVz/YP60oWKTF8woi8Boe/F1/iCLhcHEZfagHJcIdHypBSWwZFRglDmP4A
	 fB1s08rdYXaOM78gmxpHQ+DaLC8vMeoqSZ2yVh0AUuvLhmgXAWNPQYXrJMFAxCVuNp6HL
	 I79urS8qSrEeGUCDl/06/u5axhYhh+9/lQG2YAEnFTaIbbko+Eftdm+fAbBJBBRKoSMLn
	 oRJY/WypWpkMeabkEj3Uj0fgXBh/ARGYwMo+l5Su/8QZxMNRuzmWxdRepeWKT6csmjoOx
	 fcq+ZSjGDK3ICLYLyBeTyRKzgRA8eSMJrxkc9QIK5xYIKsGBKZAq8eS26xsegkHlRqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568D6078F28;
	Tue,  3 Nov 2026 10:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9568D6078F28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnt5hxt+lqU6o7AA--.2763S2;
	Tue, 03 Nov 2026 18:29:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] net: stmmac: drop the runtime PM reference on probe failure
Date: Tue,  3 Nov 2026 10:29:14 +0000
Message-Id: <20261103102914.1341121-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACnt5hxt+lqU6o7AA--.2763S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryDJr17Wr1xGr4UJrWrKrg_yoW8uFWxpr
	48Zay09ry7Xr1Iga1DAr4qvFy5GrWSy393CrykG34Sga1rCryaqFySqFWjv3ZFkFZ5ZF13
	tw4UAw17Za1vy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F
	1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VUUJUUUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMAA2rpnIByNwACsB

__stmmac_dvr_probe() takes a runtime PM reference with
pm_runtime_get_noresume() and enables runtime PM before registering the
MDIO bus.  The reference is only dropped on the success path, so a
failure of the MDIO, PCS, phylink, devlink or netdev registration leaves
the usage counter elevated.  The device is never bound in that case, so
stmmac_dvr_remove() never runs to release it.

Drop the reference and disable runtime PM again on the common error path.
Only disable runtime PM if this driver enabled it, because PCI devices
already have it enabled by the PCI core.

Fixes: 5ec55823438e ("net: stmmac: add clocks management for gmac driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 049d85b3e25f..eebf1975f40f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7974,6 +7974,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	struct net_device *ndev = NULL;
 	struct stmmac_priv *priv;
 	int i, ret = 0;
+	bool pm_enabled = false;
 	u8 rxq;
 
 	if (!plat_dat->dma_cfg || !plat_dat->dma_cfg->pbl) {
@@ -8223,8 +8224,10 @@ static int __stmmac_dvr_probe(struct device *device,
 
 	pm_runtime_get_noresume(device);
 	pm_runtime_set_active(device);
-	if (!pm_runtime_enabled(device))
+	if (!pm_runtime_enabled(device)) {
 		pm_runtime_enable(device);
+		pm_enabled = true;
+	}
 
 	ret = stmmac_mdio_register(ndev);
 	if (ret < 0) {
@@ -8278,6 +8281,9 @@ static int __stmmac_dvr_probe(struct device *device,
 error_pcs_setup:
 	stmmac_mdio_unregister(ndev);
 error_mdio_register:
+	if (pm_enabled)
+		pm_runtime_disable(device);
+	pm_runtime_put_noidle(device);
 	stmmac_napi_del(ndev);
 error_hw_init:
 	destroy_workqueue(priv->wq);
-- 
2.34.1

