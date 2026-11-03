Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702553;
	b=1rCKwIzbYRamg5a6SlXXjMOu2Uz4bfhHMeAc7cqMy8P5SCKuaRlXaZxRZCB7FeXkOiyW
	 AEj/Iw5/8MIvh0Vy3Vw07XMiyofyjiSsGP9MBOxySmiVw8pevY2xlvWQMdEO4ldhr0B4L
	 k+zkP1T0t2EMxJdQY6MeY899vQkEQcS8ncDsWwlkZXxOE3I5wg1lRXmoAWbhGA9+D8StF
	 WISn4nlD1uWZ9xMvwf5T8hje/8avABxxd3/v1IKBBmYz8AAWULkLSOaSb4bEMv6/TCJHB
	 etR3te8Bv8lzsZuxFdG85XNjNzzq7cmVczfCmMMk6OMKTRgW2ONHW5aBk/bj8sgyAhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702553;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=IuUPyX5DkjIiNUGNtfTKC8Y0w02sjpL7UMhcVSXVgoA=;
	b=HZ9k31LZl5NDCTUwKSiEsc0o7a09VyXpobCxxekWqDyo5yTNZODVL2/EMSfzgxxfyoMq
	 TMxSRPV3r8GJbIzo0DF5ksOPckVVrnkwwWsRRScCIW/qjKmJ63re6bhcRIu+FGnzrUv9K
	 x5TNKPn3AnBp73k+cQnSljRZAfPwCP2sFHmJlkqkPXw59yFFZzK5+SutFngo8fJN03qAH
	 DKJ2KqoIygSG3KTocF9JF7ofFyNfSAhTSVixAsjQ9FgOC5C3ZqoMT9235nu2yO3syIQxR
	 PTL5G6+RMtMLT0m9oQQOArTIElvaWJBydoG/kSfdRNiEbG3KkHnigO5KOg2tSGrwgGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A6606EE8E;
	Tue,  3 Nov 2026 10:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4A6606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnOJmVuulqi8g7AA--.3225S2;
	Tue, 03 Nov 2026 18:42:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvmem: u-boot-env: release the MTD device reference
Date: Tue,  3 Nov 2026 10:42:38 +0000
Message-Id: <20261103104238.1373700-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnOJmVuulqi8g7AA--.3225S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJry7uw48GrWDur48trW3GFg_yoW8ZFyfpF
	4DCFy5CrZxGFW7Ww47Jr45Za4Fvw4Sq3y7GFykGa4Fg3WFyr93JFWktFyYqryYyF95Cw4Y
	yrW3tFWUC3yUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	yj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bwfOcUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEAA2rpnO54wwAAsP

u_boot_env_probe() obtains the MTD device backing the environment with
of_get_mtd_device_by_node(), which takes a reference on the MTD device
and pins its owner module.  The reference is kept in priv->mtd for the
lifetime of the driver, but it is never dropped: there is no remove
callback and no devres action, so unbinding the driver or unloading the
module leaves the MTD device permanently referenced.  The reference is
also leaked when devm_nvmem_register() or u_boot_env_parse() fails
after the lookup.

Register a devres action that calls put_mtd_device() so the reference is
dropped when the device goes away, including the probe failure paths.

Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvmem/u-boot-env.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 467b288918db..5a62f3e0acc8 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -42,6 +42,11 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
+static void u_boot_env_put_mtd(void *mtd)
+{
+	put_mtd_device(mtd);
+}
+
 static int u_boot_env_probe(struct platform_device *pdev)
 {
 	struct nvmem_config config = {
@@ -51,6 +56,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
+	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -65,6 +71,10 @@ static int u_boot_env_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mtd);
 	}
 
+	err = devm_add_action_or_reset(dev, u_boot_env_put_mtd, priv->mtd);
+	if (err)
+		return err;
+
 	config.dev = dev;
 	config.priv = priv;
 	config.size = priv->mtd->size;
-- 
2.34.1

