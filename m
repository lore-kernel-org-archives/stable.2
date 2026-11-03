Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701740;
	b=G9umP4R4yAituW14RyKjO+THjbedLs4Llxp8CnI6RuP6MwyPE0FsGqPZdxl20c+ZYFV3
	 KBLFftiMT1SNL++VvOy7f+1X4QWQQDAyu1fdPb39AX5Tp+xqcgPbBc4zlofBqJNW96CK+
	 O/dEYKuLa1shj/dlKEL2J1UcGEK2YyI+3uSg1nRNx8yuufX10Gcy+ANA+uj0iQ11Yg1bG
	 vRRMyj9q8ZrKw/w+Q3p+0AoZ+Nf3vGS+SsRgDl0e5Uk1wQKhLMOhA141ThYh6H6mrQ/Ro
	 EBrsRunynPTqDFUYIJ8L+DVFpZik+wBjpq/3Z8tKLF0QjNRyEPkoxl7ZpDrTbtsClPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701740;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=+rMQRp29lqH7BqJxA2OZZYuZF6Au1HYKbj5cMX1rxtg=;
	b=0xBnSA2uPqsHqX+MFUUt0+xGs2ToZUE6n34Y4k1gdfAl21k1XOK/TzomhyjWhUOFss1d
	 ukT5z7GGdCudKgL8UAg3DTsIS7W67dB8B9KC7k+zsln8TlB/1BYUdAlq8qEVeEZ5s1SUQ
	 5VGOORFjJvYm0wtZfQwW1YKlElCbPdbMlv+Plnptf8NSrvvRsOxW+36qNk411BUvw8QOj
	 cksAip5tgZTJQ5sOcPcSz/BfpeSUOs/YzODpljhUfZLFrZHPVTCynNSfJKo0XQLuP+hnD
	 wra0zn/wEvV4dXy9QSI9I7kfDs9m8vdgG1CjrzqYBOeLhATTmKiDLWac4Nxkj5s43Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F46075BE2;
	Tue,  3 Nov 2026 10:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806F46075BE2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHkpNft+lqqak7AA--.3162S2;
	Tue, 03 Nov 2026 18:28:47 +0800 (CST)
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
Subject: [PATCH] net: stmmac: release MDIO node if bus data allocation fails
Date: Tue,  3 Nov 2026 10:28:56 +0000
Message-Id: <20261103102856.1340705-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHkpNft+lqqak7AA--.3162S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DuF1kWw43Aw1rtryfXrb_yoW8Gw4fp3
	9rCa9Fyr95Grnrtw4kJw40vFy5CayayrWUGa1Iqanavan8GFyaqr1aqrWjvasrGrWDW3W3
	tr109r47ZF1DAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQAA2rpnOFxAgAAsG

stmmac_mdio_setup() looks up the MDIO device tree node and stores it in
plat->mdio_node before allocating plat->mdio_bus_data. If that allocation
fails, the function returns -ENOMEM without dropping the node reference.

The caller jumps to error_put_phy on this error, which only releases
plat->phy_node and never reaches error_put_mdio, so the reference taken
for the MDIO node is lost. Drop it before returning.

Fixes: 1a981c0586c0 ("net: stmmac: Make MDIO bus reset optional")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ea16d618215..36f31bad11ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -355,8 +355,10 @@ static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
 		plat->mdio_bus_data = devm_kzalloc(dev,
 						   sizeof(*plat->mdio_bus_data),
 						   GFP_KERNEL);
-		if (!plat->mdio_bus_data)
+		if (!plat->mdio_bus_data) {
+			of_node_put(plat->mdio_node);
 			return -ENOMEM;
+		}
 
 		plat->mdio_bus_data->needs_reset = true;
 	}
-- 
2.34.1

