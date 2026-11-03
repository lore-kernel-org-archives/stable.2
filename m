Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700328;
	b=1ZisnUwZ5HDkoHGdIbzQLn4kzSdpm0WkwdUw08hL4/B7n3i2D+3ukBQaj+ekFSe68/3I
	 QGPZhecbSSG/oKejN3g2Rvfiz2J41JuQ4W3Pd1yh3vJhBcW0PvY+mscig8UHeFMBxF19L
	 AFIDHIsRGsfpO6M/LsMDButIBeTZNckXVWmhbyrYaTPcWzCZ4Ox4dpL+1iLM5gMo9zXeT
	 zKPdACR9cybAT4J3qqNSCyDQAh1TPEjrrLjH46Hna0i9X4mM1Sqx4B6DNjSumSWYXo+XT
	 8NBef2KCztiSks+LI3nHSzD6rZ4XCdwAbnQMHykrh4WeguOl1t1wj8mmlBeoBMpmB2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700328;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=jO6QjtoHNwv/01CHn5EGRcF1ukiG+oe3dc+KhpeQIMc=;
	b=IpG3H7JCqFvyAQC19Vo0Nf5+emtZ+TGyK1vXcJ+VcqcpWYoyjvPmT0KFHKgJcrxjrqBp
	 eYzXSFoBECW+0Q6fKw874YdImL4fpVJ7mrRfpCvLQQGhtzYi91H6I6L/m92DhpPJOfr/G
	 5WOldBoWTmlqVIvJWQvLxa+M5Qw4Sf7hiYNfYe0VcgcconXXZgUB9Fq4RHTplkzGTfX9W
	 ZMyY9hq8Bjcu5rTxAo6/CVJ4FhNou0prZqjz1tMkt3pAkgihkHtml477dKB6tw47pmpiQ
	 6awV7BXLqqfHi8i6q6GSTxCsuzUc3lpW9GuPCLNdxczlMoG3BkuaVlohyF+5K8qZB1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263C606A32D;
	Tue,  3 Nov 2026 10:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B263C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QZLgselqaXs7AA--.2498S2;
	Tue, 03 Nov 2026 18:05:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: loop: release netdev reference on registration failure
Date: Tue,  3 Nov 2026 10:05:29 +0000
Message-Id: <20261103100529.1309887-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAA3QZLgselqaXs7AA--.2498S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4kZr1xuFykCFyDCFWrAFb_yoWDuFb_C3
	WfZF97Wr1DGa1jkrW8tr4SvryYkFyUuF4fXwsaqFZxWw4UXr98JFyDZa15ArnrW3y8AF98
	A3WUur45W3y5ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMAA2rpnIRi3wAAsg

dsa_loop_drv_probe() takes a reference on the CPU net_device with
dev_get_by_name() before calling dsa_register_switch(). The matching
dev_put() is only done in dsa_loop_drv_remove(), which the driver core
does not call after a failed probe, so every failed registration leaks
the reference.

Drop the reference when dsa_register_switch() fails.

Fixes: 98cd1552ea27 ("net: dsa: Mock-up driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/dsa/dsa_loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 0e35e9841b9b..fd02327b5a56 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -390,6 +390,8 @@ static int dsa_loop_drv_probe(struct mdio_device *mdiodev)
 	if (!ret)
 		dev_info(&mdiodev->dev, "%s: 0x%0x\n",
 			 pdata->name, pdata->enabled_ports);
+	else
+		dev_put(ps->netdev);
 
 	return ret;
 }
-- 
2.34.1

