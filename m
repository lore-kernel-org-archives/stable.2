Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699177;
	b=R+YC9h23Qzwl2MDfNsFGWcxjLwJRjDMj5E0O25psJ6zxPJ46+wj9FTH6neg/cxuEKfBW
	 ShGpuDSRiM8c5FDvqtMo0Q60YKaEl8yNc7ZXOTlnoLvKeqtNtzFfjLw0MGDtZR39FKcYd
	 pyLJSIj34GI7cLLqQXciMsJNQ64s/RoBu0mR8YTFWV09QYAlsS7r/7WaNENjekclGdILW
	 aZvEl64PECwQavjf0tDiPprDdJE68W+RwHqWLwLFFBO7TirWHkscCNL3HnXQ7rTB521zq
	 RoiyHbbqt7DCH/3Rd9uRL9ebyDU6R8Fce/dfzoX0N4MGm5bB/OAAfXki7cFe6B+kG7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699177;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=Qu4mAgw5katdvyP9FpYsDQ+YEP4MXJRlT8noXjfaXBU=;
	b=Jwajks3gTSKCAcoIkQQ2Y8lTU1yyQEVczaoconoOWP2U++Tpmi69uqgz7rPJvnKb4JrX
	 KnjOxp8ZXHGp8vNpeceBdaP7sLXbfzKA7JfsEh/rbua54fZvStuqBfNBwPlw9xgQ9e5yq
	 UvkuoRLP3/h9IjJREYVv2q1q3h0GsCWdT3dO4wEi/Qo/IXV7gPsXd5wXJ9PB9bkVRxA89
	 GJCRK5JllBFnM/SHuiIJAsD3nq7p3bReXqQSkmVcfqbX+tlQEMXnZV/ZoFteTir5wfUBv
	 0cRQMmXK/qsPCrFWEKdnMGg5WWrOJ0gFm3KZyVVgib8GvQQLM+8Rp8zQY2O6Iisb5AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCD606EEAE;
	Tue,  3 Nov 2026 09:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDCD606EEAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpNmrelqIU87AA--.2670S2;
	Tue, 03 Nov 2026 17:46:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: cx231xx: free the rc device if IR client creation fails
Date: Tue,  3 Nov 2026 09:46:23 +0000
Message-Id: <20261103094623.1289509-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAA3QpNmrelqIU87AA--.2670S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary7WrWruFW7ZFWDtrWfuFg_yoW8ArW3p3
	y5tFWYkFWUJr12gw47X3W3uF15Xr1fA395GrW7Jr10qFn8G3WYkas0kFy7ZwnIvFW7AF90
	yr1jqay29w1vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUrv
	38UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgUAA2rpnIRRZAAAsu

cx231xx_ir_init() allocates an rc device and hands it to the
ir-kbd-i2c driver through the I2C board info.  It then ignores the
return value of i2c_new_client_device().

If the client cannot be created, ir-kbd-i2c is never probed and its
remove callback, which owns and frees the rc device, never runs.  The
allocation is therefore leaked.  In addition, the error pointer is left
in dev->ir_i2c_client, which cx231xx_ir_exit() later passes to
i2c_unregister_device().

Check for an error pointer, free the rc device, clear the client pointer
and return the error.

Fixes: 141bb0dc2d0a ("[media] cx231xx: Fix i2c support at cx231xx-input")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/usb/cx231xx/cx231xx-input.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-input.c b/drivers/media/usb/cx231xx/cx231xx-input.c
index 8149702bcf89..1236a04cb2d6 100644
--- a/drivers/media/usb/cx231xx/cx231xx-input.c
+++ b/drivers/media/usb/cx231xx/cx231xx-input.c
@@ -50,6 +50,7 @@ int cx231xx_ir_init(struct cx231xx *dev)
 {
 	struct i2c_board_info info;
 	u8 ir_i2c_bus;
+	int ret;
 
 	dev_dbg(dev->dev, "%s\n", __func__);
 
@@ -90,6 +91,13 @@ int cx231xx_ir_init(struct cx231xx *dev)
 		ir_i2c_bus, info.addr);
 	dev->ir_i2c_client = i2c_new_client_device(
 		cx231xx_get_i2c_adap(dev, ir_i2c_bus), &info);
+	if (IS_ERR(dev->ir_i2c_client)) {
+		ret = PTR_ERR(dev->ir_i2c_client);
+		rc_free_device(dev->init_data.rc_dev);
+		dev->init_data.rc_dev = NULL;
+		dev->ir_i2c_client = NULL;
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.34.1

