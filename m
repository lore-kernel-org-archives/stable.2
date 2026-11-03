Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700332;
	b=hFKjrcSUjvLXQ/+lSB79+DGZANQT7a5Wh8pFi50ri8cuhvdtTXQB3yx5MLnuBrFxbxj7
	 7vybdLYMGGpZUD0XrBerUJnXQ/qlXjxy0PihTOsiV8Io7UMTtJFqAyUcJoe6Ji+I1Nzvh
	 RJz4Mo0EZ3kYKig8FZ1UM5HvEZuX+Uhyex/hIXepwFWcXvNOpJW4JAYKa9tSXjXjSwDG4
	 EjRzt3MZbAPnEA0TcXfymo0cMFXsROhXgv2uoLdk+KAsuphNhJYkwXJP2nsaBPwjgjXD+
	 ZGK6qsXK4KtmzvJIyZFrnBHeBCQrsrs6rRZ0ZJBt6qZgRSW4Uqn6E70a7ZFJfpgX0eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700332;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=sRbk87T9rxWEhDMNcgmmhJRNN8Ks9wCYvg7KwsBX3Lg=;
	b=eRzUhZItIyD5CAnLS/rYKCEaEr3YDcE/m2Uk5CHHVO06+ML6tOv+VDitOQPeofOHwk6o
	 nQMmu91kHaR/fChpOBc7PtukLInTffWJxgPs3I4ulD7qgyJzcqu9Lj4PT4YG5YfKaniXv
	 qTqCOTF0P3BmUlxVVGY8r1zAvie5JcK2oB0ZVUOEY7yK9DaOSl7c0KpOUw8YJXgx5gBaK
	 OS3u9Vt2AlBvI202RQQeHdYi0gnpBiJchgqAcBc2aflJn+4OGY/Ym9rq0MAOGEQOaMLtJ
	 Na23wT2mC0AGFiLbpqr9lnINi1TO/Au5O/aIxtdy/LwL7+eIoBk88wCUAS+C7fbo8gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CC606FAE8;
	Tue,  3 Nov 2026 10:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4CC606FAE8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3wZLiselqeXs7AA--.2808S2;
	Tue, 03 Nov 2026 18:05:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: microchip: drop the parent MDIO bus reference
Date: Tue,  3 Nov 2026 10:05:31 +0000
Message-Id: <20261103100531.1309946-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAC3wZLiselqeXs7AA--.2808S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1UAFW7Wr1UKr4xJF43ZFb_yoW8CF4kpa
	yDuFyYvr4UGFy7ua1kZwnrZFyYgrsayr43GrWFk392gr95GryjkFyxta47ZFW5Kw4rC342
	vFs8tFyUCryDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0ob
	IYCTnIWIevJa73UjIFyTuYvjfU7nmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAAA2rpnOFgVQABsF

ksz_mdio_register() obtains the parent MDIO bus with of_mdio_find_bus(),
which takes a reference on the embedded struct device, and stores it in
dev->parent_mdio_bus for the side MDIO accessors.  Nothing ever drops
that reference, so it is leaked on the probe error paths and when the
switch device is torn down.

Register a devres action to put the device when the DSA switch device
is released.  The child MDIO bus is unregistered before the action
runs, so the parent bus stays valid for the whole lifetime of the
switch.

Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/dsa/microchip/ksz_common.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 767c8fe8e819..ddd821fa0d3e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2392,6 +2392,17 @@ int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
 	return 0;
 }
 
+/**
+ * ksz_mdio_put_parent_bus - Drop the reference on a parent MDIO bus
+ * @data: mii_bus obtained from of_mdio_find_bus()
+ */
+static void ksz_mdio_put_parent_bus(void *data)
+{
+	struct mii_bus *bus = data;
+
+	put_device(&bus->dev);
+}
+
 /**
  * ksz_mdio_register - Register and configure the MDIO bus for the KSZ device.
  * @dev: Pointer to the KSZ device structure.
@@ -2431,6 +2442,12 @@ int ksz_mdio_register(struct ksz_device *dev)
 			goto put_mdio_node;
 		}
 
+		ret = devm_add_action_or_reset(ds->dev,
+					       ksz_mdio_put_parent_bus,
+					       parent_bus);
+		if (ret)
+			goto put_mdio_node;
+
 		dev->parent_mdio_bus = parent_bus;
 	}
 
-- 
2.34.1

