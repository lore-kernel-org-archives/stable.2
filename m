Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701740;
	b=UvW1sG57daIeqDhImQcRXmebUuq51D2wrWxNheOTR8GT5DyMU08yJ81ULJ+TpM2j3j6y
	 2pKeBJnFnimnhxmsHPyK2S01W6QT30QBGjAGDRqrnO9BZvcwOwdebqHWa98jkLj/W1Gkl
	 fr2hjXu0MRhpbVxxkiheAllccMh3C3a15mF1dafE334PTM7AQuPrOc4ra7u1slYP21/R0
	 EMK0HciU6OgXHMwC27FJidNGfBWyRKN6zf80jecEoSEpC4roDZDtx7c1i7uwVD86INccr
	 Xp+45yFNwL4xk9Joeya90UgAJLPU1TJimc5L3b2go+945b2Om48p1SZgMRrYgfOAETg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701740;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=+3TkzEALxErJPK8XFmnDMPVnxKpmTHTOz1zwyHiO5yU=;
	b=2XdtRyax77yBGn50PT/LtJ4wvBBi0vItxX+heSgQRgYqeDOHS6252M7JLwzUh6ZH+no4
	 +eG8H2OT+7op3qwltQ500uvLMaw9MkP0WtxItRSRLDFimbfCUkV43N/395vHsVAPhj39h
	 doBp/QG91rBkyNE5rle6HdI9W0K27Awrydr3SkVD/ypop5HrPgbUiEfL3GiaQGOynSbqM
	 wBB7lst/YidUbCB9dqMRAaAXXJCQvlTb+qFk68HWQgmP1l5zNthRFy+h0f3nwjRUdwN0C
	 SdToOIMwQskoBSiGVcTCoGrBeiTCLwzgsQROmA/JzIV4a7KqC3Y8TK9dAIQtCxdZwKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DF6075BCE;
	Tue,  3 Nov 2026 10:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 032DF6075BCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHE5Rlt+lq26k7AA--.2803S2;
	Tue, 03 Nov 2026 18:28:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wcn36xx: drop the SMSM state references on probe error
Date: Tue,  3 Nov 2026 10:29:02 +0000
Message-Id: <20261103102902.1340936-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAHE5Rlt+lq26k7AA--.2803S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF45Xr1rtFWfAryUtr45trb_yoW8KFykpr
	Z7K3yFkryj9rWIqr4xKF4DZF93ua10yr92grZ2k39IvFs8ZFn5tr1qqFyUZr1jvFZ2qa1U
	Ar47AF4DXasIywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1
	YsjUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYAA2rpnO5vcgABsv

wcn36xx_platform_get_resources() acquires two SMSM state handles with
qcom_smem_state_get(). Each successful call returns a reference that the
caller has to release with qcom_smem_state_put(), which is only done by
wcn36xx_remove() for a device that probed successfully.

Several error paths in between return without dropping the references
already taken: failing to get the "tx-rings-empty" handle leaks the
"tx-enable" one, and failing to look up the qcom,mmio phandle or to map
one of the mmio regions leaks both of them. A probe that fails after the
first successful acquisition therefore leaks the SMSM state references
for good.

Make these paths unwind through the existing label chain and put the
handles there.

Fixes: f303a9311065 ("wcn36xx: Transition driver to SMD client")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index ad8a4bd910d2..0c4f5b5b8dda 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1502,13 +1502,15 @@ static int wcn36xx_platform_get_resources(struct wcn36xx *wcn,
 			"tx-rings-empty", &wcn->tx_rings_empty_state_bit);
 	if (IS_ERR(wcn->tx_rings_empty_state)) {
 		wcn36xx_err("failed to get tx-rings-empty state\n");
-		return PTR_ERR(wcn->tx_rings_empty_state);
+		ret = PTR_ERR(wcn->tx_rings_empty_state);
+		goto put_tx_enable_state;
 	}
 
 	mmio_node = of_parse_phandle(pdev->dev.parent->of_node, "qcom,mmio", 0);
 	if (!mmio_node) {
 		wcn36xx_err("failed to acquire qcom,mmio reference\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_tx_rings_empty_state;
 	}
 
 	wcn->is_pronto = !!of_device_is_compatible(mmio_node, "qcom,pronto");
@@ -1552,6 +1554,10 @@ static int wcn36xx_platform_get_resources(struct wcn36xx *wcn,
 	iounmap(wcn->ccu_base);
 put_mmio_node:
 	of_node_put(mmio_node);
+put_tx_rings_empty_state:
+	qcom_smem_state_put(wcn->tx_rings_empty_state);
+put_tx_enable_state:
+	qcom_smem_state_put(wcn->tx_enable_state);
 	return ret;
 }
 
-- 
2.34.1

