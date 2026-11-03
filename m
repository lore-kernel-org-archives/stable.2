Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702560;
	b=gUOj0Ns3PKZQacyXNrkjy1s38T7/6ohGCon6TSfNog/mHCW6Dd0gCjxCs6z8l0rwS/2n
	 Zg9ysqzLxjad4i0nA6xKeJkXwihA+Pk7+6ActfKQTqKbo6vWnD/9izR69Bksi6pPJnUMM
	 7kEpQgxdSkOZKtatHihi10jjRzH/M2Rsuv6WvtOViBFU/Z24X++9ND7xGkXXmzvEJJCUy
	 NkLiDGeK5cwjMltUl7jp4v463S0TlduCwYK5p3U3Cwt/atctXCN60c9dr0TH4Bnqh9ztI
	 5OGnFNodgZyUfUWQTe1g3fTZ9coqKhsupBOLgpKdtyeouLfh3wl4ySbSJ8BdGtc3oWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702560;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=dq/RY5R/Na6tlI++Iffy5vOaP29XVU/XmXlYaY8sWUE=;
	b=AxM4zQmS2g3jJjUAW5LYbxOR5FqhfynvcPO3UdtP77CIhI8etkC6S14kfPFFDV7fGbcC
	 e8bjDd+fHUPmUW6Mi90vW9yhqHiqH9ZSHSUC30WM+Qeo/3JcmGP/fTFjRf1TubbzzOXnG
	 0G8Lr3zN7Jr2/LBLTXpRUU8LVqeyeC6bYEW/S9eF0Yb4cTkOVS7ud5hrog/Cs8xnQItLi
	 mvTZRyV1DkvLo4fHeh4GHA2vgOuCq7XpBm8KvYOWY24XMPZb3Ov8KIq5kDf9k3n1Y+u1I
	 UZAO3q+xuP9VnJv2ieqOuGzu3McZ2BhCZeRI91BSgkiYo3nTsaBd0ak5vyi0FIDuqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D860819D2;
	Tue,  3 Nov 2026 10:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD4D860819D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACneZqYuulqrMg7AA--.6046S2;
	Tue, 03 Nov 2026 18:42:32 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: mediatek: hdmi: use devm clock provider registration
Date: Tue,  3 Nov 2026 10:42:41 +0000
Message-Id: <20261103104241.1373838-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACneZqYuulqrMg7AA--.6046S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur48ZFWxuw1DZFy8ZrWkZwb_yoW8XrW3pF
	1UGa4jyF98AF4xGw1DJ3W7XFyYka43JFWSkrW7G3y5Za15CryfX3yayFyF9FsYyFykua12
	vr1qvFWrWFW8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43Mx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_
	Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bOAw3UUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEAA2rpnIR99AAAsW

mtk_hdmi_phy_probe() registers the PLL clock provider with the
deprecated of_clk_add_provider(), which takes a reference on the device
node.  The driver has no .remove callback, so neither the node
reference nor the provider registration is ever released; after the
device is unbound, the global provider list still points at the freed
hdmi_phy and at the unregistered clock.

Register the provider with devm_of_clk_add_hw_provider() and
of_clk_hw_simple_get(), matching the sibling MIPI DSI PHY driver, so
that it is removed when the device is unbound.

Fixes: be28b6507c46 ("drm/mediatek: separate hdmi phy to different file")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/phy/mediatek/phy-mtk-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index 52a7d525ff9b..e7ed1b789b34 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -178,8 +178,8 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
-				   hdmi_phy->pll);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &hdmi_phy->pll_hw);
 }
 
 static const struct of_device_id mtk_hdmi_phy_match[] = {
-- 
2.34.1

