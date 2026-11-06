Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963009;
	b=xAW8l/bTKaOoUh4OlP09qgeZwvLTPY2VmJzoXZhDyEUB7rbcItRXtX9P7Qcvflkw933m
	 0apwVLdkZE+hQKx3/Kmu7AFrVTgomEYjzGkbn24KOal27uISn9FK1kGBRIHNESa5Wg5ci
	 Fzad35y9qKkoJ/9fm/dVUgO+eftc+IaqkkBLU8th22BZdpp1j58NqXiDbYOQrApSWxbkR
	 uW5fsWfwvJvP/Y9nEduLl/lFA+jYQIqhviZ5uyigSZ7EjgK4THXXcOpBaqatoL2LhG852
	 s4CrGKOA9dUCuvZNltvr+R53M4+SZL34h219I723SPHDnBnS//TSQI0Ou7Na/42VxTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963009;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=AHdbfFyudhBfkmISp3WSTdtjxUpB46QM/F12uHoKuu4=;
	b=fJENlfLtnpav0VQilW3o3+lHLoJo9DCoPLPA1xZj75+DxMsi9U86Gc/syaDY4bwzQ4mp
	 gZahIQyGgAomIrYmpEgyAqD9X6kIivSjWCmrQ7QAE3gqJ6NPffOhMUma1s81bcrVPCoEH
	 oX9j6r5IwPSZUn5EvvD+spUoJ/f8J85ZkvZOLPx9ESCsCIdcVdCkCI+R5eeQomPsuYvVe
	 JIc98FMoGMj0kyTUyNd/19hEE6CjtonTDXju8vd1xy0ETW0KMFeO7rq2ifrIo2HmYybOk
	 oYjfolUdOwk162gHzwCgz3U+5Wkn6gvupJIIMBbY25Sd3hIl3tR9/gP9drJw1gpmE/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AC606A326;
	Fri,  6 Nov 2026 11:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 489AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAXI5T6s+1qwIJsAA--.5899S2;
	Fri, 06 Nov 2026 19:03:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	samuel@sholland.org,
	vulab@iscas.ac.cn,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: pinephone-keyboard - fix firmware node reference leak
Date: Fri,  6 Nov 2026 19:03:32 +0800
Message-Id: <20261106110332.422167-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aqwBtYAcIiwSSMmK@google.com>
References: <aqwBtYAcIiwSSMmK@google.com>
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
X-CM-TRANSID:rQCowAAXI5T6s+1qwIJsAA--.5899S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4xtrW8GrW8Wr48Cw1xXwb_yoW5Xryrpr
	W3GF90krWqqFnFgw4vvF1YvFyFyrs3J3yayF17KanY9anYgryftrZ8tFyFqF1UGFWku3yD
	tF4qqan7K3WDZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUz9aBUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkDA2rtkziBDwAAst

of_get_child_by_name() returns a reference which is stored in the
adapter's device but never released, leaking one reference on every
probe.

The adapter device needs its firmware node while it is registered, so keep
the reference for as long as the adapter lives: register the release as a
devres action before the adapter is added, so that it runs after the
adapter has been removed.

While here, use device_set_node() so that dev.fwnode and dev.of_node point
to the same node.

Fixes: 63c5eb157cfd ("Input: pinephone-keyboard - support the proxied I2C bus")
Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Closes: https://lore.kernel.org/all/aqwBtYAcIiwSSMmK@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
 - Keep the firmware node reference for as long as the adapter device is
   registered and release it from a devres action, as suggested.
 - Apologies for the very late reply.

 drivers/input/keyboard/pinephone-keyboard.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index 86f21045c69b..b6a70e8a8a0b 100644
--- a/drivers/input/keyboard/pinephone-keyboard.c
+++ b/drivers/input/keyboard/pinephone-keyboard.c
@@ -317,13 +317,18 @@ static void ppkb_close(struct input_dev *input)
 	ppkb_set_scan(client, false);
 }
 
+static void ppkb_put_fwnode(void *data)
+{
+	fwnode_handle_put(data);
+}
+
 static int ppkb_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	unsigned int phys_rows, phys_cols;
 	struct pinephone_keyboard *ppkb;
 	u8 info[PPKB_MATRIX_SIZE + 1];
-	struct device_node *i2c_bus;
+	struct fwnode_handle *fwnode;
 	int ret;
 	int error;
 
@@ -371,15 +376,20 @@ static int ppkb_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ppkb);
 
-	i2c_bus = of_get_child_by_name(dev->of_node, "i2c");
-	if (i2c_bus) {
+	fwnode = device_get_named_child_node(dev, "i2c");
+	if (fwnode) {
 		ppkb->adapter.owner = THIS_MODULE;
 		ppkb->adapter.algo = &ppkb_adap_algo;
 		ppkb->adapter.algo_data = client;
 		ppkb->adapter.dev.parent = dev;
-		ppkb->adapter.dev.of_node = i2c_bus;
 		strscpy(ppkb->adapter.name, DRV_NAME, sizeof(ppkb->adapter.name));
 
+		error = devm_add_action_or_reset(dev, ppkb_put_fwnode, fwnode);
+		if (error)
+			return error;
+
+		device_set_node(&ppkb->adapter.dev, fwnode);
+
 		error = devm_i2c_add_adapter(dev, &ppkb->adapter);
 		if (error) {
 			dev_err(dev, "Failed to add I2C adapter: %d\n", error);
-- 
2.25.1

