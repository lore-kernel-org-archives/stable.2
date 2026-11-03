Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702559;
	b=IIZnVDzMKpIOiCXjq+RL/+1F0TkdPYWG9ehuIQZ8i2eIV/Gxao3iBWnlE3fqbE7RpgFQ
	 KCtT6o9Im9GMHkKyd4PGOylZkDQGcNH47z0ToKc8uTrNnBL0d6c02L568/IhQdWCWUajH
	 CsuFxscDlKktGPOn0OmMA4lwSouDKCliKzYDUFZ5mudu68SozqfnznEFM5FuK2uJbN4ML
	 C/Mnsfpcnceq/DP4rsC5F3ONryMbDvOIUE3U6+5v0sxjl+9bEW6jeb5wrXLTdGFzpFhB1
	 e5C9hHZHccE72yGJ/CfCtRAwDykL9fIuhxIesNynkctNJW7TvAnZSDDbL/J0HoIkXmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702559;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bqVilavbTh4eGvTGTY7GnYQ82UFi4+tBe3zCydD0c7M=;
	b=ltewQHpKCpBvzs6OsIIqGLd7pWjIOF5NXOFEM/uEOOdsi40YTP4SY0t9fkrf98Z2kP4g
	 A14uGaXUlgrLG7W4pIwpMKBECuR0L0o6k5Vc/NEcMFQaMETOTjWJI5WSEuZStL5gF2JZ4
	 Y8ZvOnOIYOc9Ao87in7aVW+GL9VXo61vzAXZHiRRrgMqwJMn4uDnxFSlkKrXKaWu/doc4
	 /MrBeOK5Wi5aeecUHlf+97G0ja4BOOwsWgaUb4Yn9+LrgqNAKVawMifZAqujLJrYL616G
	 OXoUjUdp5EzQUXE36KdinmNr0dV92RwWfHD9psdsPy373vV85YgZFsXJ+dz0tsvp2MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DD606BF92;
	Tue,  3 Nov 2026 10:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD8DD606BF92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHkpOZuulqssg7AA--.3284S2;
	Tue, 03 Nov 2026 18:42:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: nuvoton: fix USB PHY clock reference leak
Date: Tue,  3 Nov 2026 10:42:42 +0000
Message-Id: <20261103104242.1373863-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHkpOZuulqssg7AA--.3284S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47GryrAr48tFyktF4fXwb_yoW8Xr4rpF
	WDGFyYyFyDKr40k3yDJw18u3ZYkw47trWrKrWkCas3Z3WrX3y7G3ySyry09F48trWkCw4U
	Kw4kZa48AFW5u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIB7qgAAsW

ma35_usb_phy_probe() acquires the PHY clock with of_clk_get(), which
takes a reference that must be released with clk_put().  The probe
error paths after that call return without releasing the reference,
and the driver has neither a .remove callback nor a devres-managed
clock, so the reference is also leaked when the device is unbound.

Acquire the clock with devm_clk_get() so that it is released
automatically on probe failure and on device removal.

Fixes: b48baf69db97 ("phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/phy/nuvoton/phy-ma35d1-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/nuvoton/phy-ma35d1-usb2.c b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
index 9a459b700ed4..c725e336e4f4 100644
--- a/drivers/phy/nuvoton/phy-ma35d1-usb2.c
+++ b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
@@ -105,7 +105,7 @@ static int ma35_usb_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->sysreg),
 				     "Failed to get SYS registers\n");
 
-	p_phy->clk = of_clk_get(pdev->dev.of_node, 0);
+	p_phy->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p_phy->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(p_phy->clk),
 				     "failed to find usb_phy clock\n");
-- 
2.34.1

