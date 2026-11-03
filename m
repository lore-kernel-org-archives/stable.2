Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702559;
	b=YW+d65euW9wlSDHvUEzfg5oOZndU2mUMQKmat71TWTFvB7UCkItG10aIw8y59sQlvLY8
	 jeICIYYPR/NIWkQraNvy6ocsI5hKeRhyCS+R2z6cd0gcv/XdkOLo3IyR0aH7/amWlbZkR
	 AB7H4gEHBpgKNAOgfO7U1gtekvExp6yOFuVFbpM7fI+OAp18Lhz2Lm35/J3UG0yxp6Gh3
	 B3XXm0UpDnKfWUz/Aa9qWuD9BlXz32GWaAYWBz16C0rsCK7BVygCnCPxuehtbdvrCYL2n
	 0qe79w39Bq6R5KYFNeByap6k0BQTwwFZfc96VVcjhtHn+kGV1V/lt+OVlofBPzoZ6Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702559;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=tV6ejL3rU0JA4o/fxXSrCXYJNzFJ4reb1/Lg1zThkwQ=;
	b=S87tGIhdH8I+6q3YyCtstOAp1UvJU05+3eojC6OjHMKzUn0FAqPscmOVwbkt07fr0Fmp
	 neWf8kv9LKCeJRdsK0uDfyHoNEHf8BjfZ6mP+YFDyRZ+tXwJmbzej5eH5OE6PnaxDhuc/
	 SB5+cqZyg286WyPEer6/y4bf9GsRWOhuuHbSf+y9NBmqj8GilwBiWnUCGOQAr/Pwq3v8E
	 xxL8VU57qeglNLuhqDfLezr1qoCv7TR10mYSdqmqEsEpXK6XMVGUrsuSoCc7bVZc/vPqz
	 hCWS97llPlrlT3miAtc6ajrF9vhBzUvhtriAo85hQupIDwSzsQWwzHEd1o+emQ5YfyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A66077DB0;
	Tue,  3 Nov 2026 10:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9A66077DB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0JGUuulqhcg7AA--.6656S2;
	Tue, 03 Nov 2026 18:42:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Zhao Qiang <qiang.zhao@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: fsl_ucc_hdlc: release the net device on remove
Date: Tue,  3 Nov 2026 10:42:37 +0000
Message-Id: <20261103104237.1373675-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADH0JGUuulqhcg7AA--.6656S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1rZF48CF4UJr1fKw45Wrg_yoW8Wr1rp3
	y5Ga40kF95Kr17ta1kGr1UuFyUWa18ta4Fka45Zr4furn8AFyUZ3yjgFy8CFW5AFW0gF4Y
	qr97Ka1xWFs8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAAA2rpnO54wAABsM

ucc_hdlc_probe() allocates the net device with alloc_hdlcdev() and
registers it with register_hdlc_device(), but ucc_hdlc_remove() only
tears down the QE resources and frees the private data.  The net device
is never unregistered or freed, so after the platform device is removed
or the module is unloaded it stays registered, keeps its reference to
the module and is left pointing at the freed private data.

Unregister and free the net device in ucc_hdlc_remove(), before the
private data is released, as fsl_qmc_hdlc does.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93f5..f815cac82518 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1267,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.34.1

