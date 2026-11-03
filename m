Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699201;
	b=aTUnl4dcXATUx2PPV8MBcMC25dMtX0HiepmX0NwP4pH64Oiyk93UEd5FBOGnAuEFqmPX
	 ygccaJSNtp3QIsavk0QOmvgjIjy4Ui1mJ8y0e1xNYbs+qs7/XfHkRQCFy06M9S9d8CZn2
	 rV3Q422fuu9UokooRkuHpyA0QDAyhOLMwdP1iWS5tuP/OAGD1TrMq/mjCo6TQkdaWDsqS
	 Wk8o7UztukgH7TeYl+gUCWcPIst6TeGVK1JMMf+vocumd7p0wtRcPE7An4AT2V75H5GST
	 kFbNsnBb+wowRjWILVvLDt/eQJphzAFGK1S/5C//V7XxOygnn1JeDldcEz1Qb788E8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699201;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=y0bvXf1h7Wz+f0YJZfiRLxuceLa0NyfzQU1Grzqc+gw=;
	b=wfqo6w7VOirXSDJFXLoXXiXkxajQ1+rYM5vOxhSW4BZ7XzwkBf+TEDqVuqntfqhqTn18
	 NVYc9Llafo/dARv1GpXdJUvkVXWqX8mof72HZzJaO2vg3R4FdCXsSVCwvFAT1NHCzIvTQ
	 9XjsNQ1wE5j/sYAAIGL5q4kDtyrtd7R835tOFOC6Z2Z54fJiuHy73u87R6rv2xskGIS3K
	 nbKimekbZa1RrbWVI78kTVlYSqJMgkibyjoWfaWx7VnytGmCJl9ydqAuXQNq0Dmwy0apS
	 2xAU2drJ85hvpqo6GKL/UsK9s0jBtAMkN234UJzQVIJaMqsb1f+TCW6DmMVQP1MSGXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E4606EEAA;
	Tue,  3 Nov 2026 09:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 330E4606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH15h7relqEVA7AA--.5157S2;
	Tue, 03 Nov 2026 17:46:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] mfd: adp5520: Release the subdevices when the client is removed
Date: Tue,  3 Nov 2026 09:46:44 +0000
Message-Id: <20261103094644.1289853-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADH15h7relqEVA7AA--.5157S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1DJw45Jr1rZr4DWF15Arb_yoW8ZrW7pF
	47Wa43Crs8XF12kw47Zr1rCFyrAa1SyrWUCFn3Gw4a9F45CryftFyIqFWjyF13CF1fCa12
	yw1rtFWUAFW8CF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	Uua0PUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEAA2rpnOFPRQAAs6

adp5520_probe() registers up to four platform devices (keys, GPIO, LED
and backlight) as children of the I2C client, but the driver no longer
has a remove callback.  The callback was dropped when the driver was
made explicitly non-modular, on the assumption that a built-in driver is
never removed.  That assumption does not hold when the I2C adapter the
client sits on goes away: the driver core still calls the driver's
remove callback, and without one the child platform devices are never
unregistered.  They stay registered, keep a reference on the I2C client
device and leak the memory they were allocated from.

adp5520_remove_subdevs() already exists and is used by the probe error
path, but it is not reachable on the removal path.  Add a remove
callback that unregisters the subdevices and drops the interrupt, in the
same order as the probe error path.

Fixes: 6b09274bacc7 ("mfd: adp5520: Make it explicitly non-modular")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mfd/adp5520.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index bd6f4965ebc8..6b53b00efe52 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -305,6 +305,16 @@ static int adp5520_probe(struct i2c_client *client)
 	return ret;
 }
 
+static void adp5520_remove(struct i2c_client *client)
+{
+	struct adp5520_chip *chip = i2c_get_clientdata(client);
+
+	adp5520_remove_subdevs(chip);
+
+	if (chip->irq)
+		free_irq(chip->irq, chip);
+}
+
 static int adp5520_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -341,6 +351,7 @@ static struct i2c_driver adp5520_driver = {
 		.suppress_bind_attrs	= true,
 	},
 	.probe		= adp5520_probe,
+	.remove		= adp5520_remove,
 	.id_table	= adp5520_id,
 };
 builtin_i2c_driver(adp5520_driver);
-- 
2.34.1

