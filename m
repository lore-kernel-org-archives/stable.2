Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703363;
	b=lqX/2SP9IXEVQDl/uSX3e2Igef4Utntv6R6oJIV6di2CghdzYcWcuNFt8Go5F1dmiyD2
	 /Yr6nflWiQSSUtLe+mxwSSsHLR6YqzS9xg2twS7LkmTQYs6t69sMKPZ6Yuzgk9xPJyIey
	 cQ60pUySHsP+vYWMHxJ56F+egHEUIuxq+JCKf12sPZRk7ffBFLwwGmIqCjQPdtdKkyD9D
	 7B1uA0HbzN/a0uRWtudwj7Gw/5gj13HrsgVWSSWizeHMhav5AVKxSfK7GulDw7c3pDQI7
	 lbmhiOYiRaU7HNeHFsEQrFYl8dpypkut0vHcZbRuwp1Fnx/oMZzTmjfQNWTbiC3lc5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703363;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=MfuUnO7MQsPJpDHuR7JnzHeMALwBfgM6IuedB8NN/Fc=;
	b=EPp5peRjK7r5oaEZ+Yr4huuHiyDUMxIXs3FFqiLYVb58Vrur6ju8clGnwXeWv6roXo+Y
	 g0uzvt0D+zdqpHQKruQnvbpIQly/KCfcr/wdtvfBdkYqSAmSi+hl0U699IrcLdIqsEMAA
	 TJpc10DByBpnJqjdrPkobHJamC5PR32/bTfFXMU/vLWsrcl3w+/eR5vB4DdH2z+JvrWSO
	 A2/CtbwPvHKmrv5cA26hw03bLVtzvbLaY+zdiUUsXrDl7K6vFjtao9UTlogNH8vdEzCcM
	 muQsNlSfrsGQw6sUo8CGzma+GcdlYA9q3+hkhwt8VUW+8s4eoYpgxsWixOJUTZvVFlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE181606EE80
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE181606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0JHAvelqq+I7AA--.6804S2;
	Tue, 03 Nov 2026 18:56:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: vulab@iscas.ac.cn
Cc: stable@vger.kernel.org
Subject: [PATCH] rtc: m41t80: use devm for the square wave clock provider
Date: Tue,  3 Nov 2026 10:56:09 +0000
Message-Id: <20261103105609.1394826-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADH0JHAvelqq+I7AA--.6804S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4UJF4rKF47Aw4Uur1DAwb_yoW5WrWrpa
	93uFy5CF1aqr4xWr4vka13AFnIkw1xtF45Aa4xGws2vr15GFW8tayjyasYvFsIqrWruw47
	Jr4UtFWruF48ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	XVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0x
	ZFpf9x07bFeOXUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEAA2rpnISISwAAsc

m41t80_sqw_register_clk() registers the square wave clock with
clk_register() and publishes it with of_clk_add_provider(), but neither is
ever torn down again: m41t80_remove() only unregisters the watchdog.

The provider therefore keeps a reference to the device node and points at
m41t80->sqw, which lives in devm-allocated driver data that is freed when
the device is unbound. Resolving the clock afterwards dereferences freed
memory.

Switch to devm_clk_hw_register() and devm_of_clk_add_hw_provider() so that
the clock and its provider are released with the device. The function no
longer returns a struct clk pointer, so make it return an int instead.

Fixes: 1373e77b4f10 ("rtc: m41t80: add clock provider support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/rtc/rtc-m41t80.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 1385cb43864b..c20b8734cb66 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -563,13 +563,12 @@ static const struct clk_ops m41t80_sqw_ops = {
 	.set_rate = m41t80_sqw_set_rate,
 };
 
-static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
+static int m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 {
 	struct i2c_client *client = m41t80->client;
 	struct device_node *node = client->dev.of_node;
 	struct device_node *fixed_clock;
 	struct clk_init_data init = {};
-	struct clk *clk;
 	int ret;
 
 	fixed_clock = of_get_child_by_name(node, "clock");
@@ -580,17 +579,17 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 		 * registered automatically when being referenced.
 		 */
 		of_node_put(fixed_clock);
-		return NULL;
+		return 0;
 	}
 
 	/* First disable the clock */
 	ret = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
 	if (ret < 0)
-		return ERR_PTR(ret);
+		return ret;
 	ret = i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON,
 					ret & ~(M41T80_ALMON_SQWE));
 	if (ret < 0)
-		return ERR_PTR(ret);
+		return ret;
 
 	init.name = "m41t80-sqw";
 	init.ops = &m41t80_sqw_ops;
@@ -604,11 +603,12 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 	of_property_read_string(node, "clock-output-names", &init.name);
 
 	/* register the clock */
-	clk = clk_register(&client->dev, &m41t80->sqw);
-	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	ret = devm_clk_hw_register(&client->dev, &m41t80->sqw);
+	if (ret)
+		return ret;
 
-	return clk;
+	return devm_of_clk_add_hw_provider(&client->dev, of_clk_hw_simple_get,
+					   &m41t80->sqw);
 }
 #endif
 
-- 
2.34.1

