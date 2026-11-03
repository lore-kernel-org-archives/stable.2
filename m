Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694541;
	b=mAuR2lGUIbjP9N9L6R1C978pt/56j1LHSzPzfvR1KOhZWcky7moGmWolVxOmL8KfDZpg
	 /4UzjbYdJI3M+ckMH4NiGMb3mkcS8Nv8b87vzjH7ZdRWcU6IYAKGP9niQPUXM3BrJryAj
	 +NvqmeRwhi5BUuqhx2dX4Cn8doXndPv52nFuNA+0y4tIdvpDX95FBR8qp5oBzN3bFcfRk
	 a89h0czTQYu61gzfLUJ4rvJW9z/5Hfmv+JlMuhCQmCMkC/0aiCiT8x7mec6uXypNOP4T+
	 eT1rJmYV+MrmqL4EAYL6SLG6RT/vGDyOQpIYBoI+1VY6qabZO4Fq4mG+ZSQimtJnf/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694541;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=YttGKzudkUcow4dr9QM5c4I7tk6lSvtxkia5p+Lt/ag=;
	b=oDPqLW9WMBuptSQy6a/3NvY1VLTxnY28ygvMhr2DqCC7GE24y17EFyFLq70cjpfsWU/x
	 gneRPw16c+TklKQBM5hj9bbQm4nuoNzqzxmVS7mholoqQmEL/ANsX+HeiMb7+cnKSxosw
	 zQlqIwj9n/evTquBUVdsoAnkdptl7koqv52pV8gu2pjNi6ECD1JUXvPIP/0fxw1jz+326
	 zzkkOf0+RDjEIMencpzYlJXV43KBybnOAseCBCFvonrTweki9gQ6P3H8yg3z0Mqv6N73U
	 gE52OEbYA/Ut8BpVD35ch6A7VqgdXXQ10DfOxo9F42F4d4gThdg7+JWOK5L3cDw2CWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C6606A332;
	Tue,  3 Nov 2026 08:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC9C6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnN5hIm+lqv3E6AA--.47768S2;
	Tue, 03 Nov 2026 16:28:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: wsa+renesas@sang-engineering.com,
	peda@lysator.liu.se
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: mux: demux-pinctrl: Release pinctrl handles on deactivation
Date: Tue,  3 Nov 2026 08:29:05 +0000
Message-Id: <20261103082905.1167633-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnN5hIm+lqv3E6AA--.47768S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8Aw15KFWrtFWkWFWUXFb_yoW5Cw13pr
	4fCry3ZrWqqr4aqFZxJr4DZFy3ua1fJF1xGasrt3yFg3ZxX34rA34rKr45Zr4DCFZ5tF15
	t3Wqy34Uur4DAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXID
	7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYAA2rpWtn0nQACsp

Each master activation calls devm_pinctrl_get() against the parent I2C
controller device. Switching or removing the demux only releases the
adapter reference, so the pinctrl reference and its devres entry persist
until the parent controller is removed. Repeated switches accumulate
these entries. Activation failures after obtaining the handle retain it
too.

Use pinctrl_get() and keep the handle with the active channel. Release
it when activation fails or the channel is deactivated, before dropping
the parent adapter reference and reverting the device-tree changeset.
Keep the no-pinctrl case working by storing NULL when get returns
-ENODEV.

Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 2403c0bf7c43..1d61a0c6e1f2 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -22,6 +22,7 @@
 struct i2c_demux_pinctrl_chan {
 	struct device_node *parent_np;
 	struct i2c_adapter *parent_adap;
+	struct pinctrl *pinctrl;
 	struct of_changeset chgset;
 };
 
@@ -69,12 +70,13 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 
 	/*
 	 * Check if there are pinctrl states at all. Note: we can't use
-	 * devm_pinctrl_get_select() because we need to distinguish between
-	 * the -ENODEV from devm_pinctrl_get() and pinctrl_lookup_state().
+	 * pinctrl_get_select() because we need to distinguish between
+	 * the -ENODEV from pinctrl_get() and pinctrl_lookup_state().
 	 */
-	p = devm_pinctrl_get(adap->dev.parent);
+	p = pinctrl_get(adap->dev.parent);
 	if (IS_ERR(p)) {
 		ret = PTR_ERR(p);
+		p = NULL;
 		/* continue if just no pinctrl states (e.g. i2c-gpio), otherwise exit */
 		if (ret != -ENODEV)
 			goto err_with_put;
@@ -92,6 +94,7 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	}
 
 	priv->chan[new_chan].parent_adap = adap;
+	priv->chan[new_chan].pinctrl = p;
 	priv->cur_chan = new_chan;
 
 	/* Now fill out current adapter structure. cur_chan must be up to date */
@@ -118,6 +121,9 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 	return 0;
 
  err_with_put:
+	if (p)
+		pinctrl_put(p);
+	priv->chan[new_chan].pinctrl = NULL;
 	i2c_put_adapter(adap);
  err_with_revert:
 	of_changeset_revert(&priv->chan[new_chan].chgset);
@@ -135,6 +141,10 @@ static int i2c_demux_deactivate_master(struct i2c_demux_pinctrl_priv *priv)
 		return 0;
 
 	i2c_del_adapter(&priv->cur_adap);
+	if (priv->chan[cur].pinctrl) {
+		pinctrl_put(priv->chan[cur].pinctrl);
+		priv->chan[cur].pinctrl = NULL;
+	}
 	i2c_put_adapter(priv->chan[cur].parent_adap);
 
 	ret = of_changeset_revert(&priv->chan[cur].chgset);
-- 
2.34.1

