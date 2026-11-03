Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700333;
	b=Ls3vBXyDc7C1MQl5q2feJpPZszibe9OU06GdYu3HAZUYiIpMn8OsrlRdV8x+0fQ/fSiq
	 MR4ao8AvpvPtTkKi09Anr25Jho1rCBicu1iSJmpcyx8nEigLdN/J2fz6EUcF3x6onBNGC
	 A9BO7IN8vodtt5G8PV8MBRWnH205+Wtaunklazx62ZF2e/USwerriC+BIhfd5kzWYYn3J
	 zxjlLDRffF9pf/kZ2Irj8oCfJ1Q9KsXgaopYx2HWySIXH8rxZmWu8iqjj3UkFqhjUKnIV
	 T6AgVHt9ahmdXEKgFylQ/gy1KyFSNWZxpQQqCn7jLlQ2Z6aXqky9OGXserSrzF68rhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700333;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=QOV6iXIR9HWxd6BHvNJPwEHxe6mebIHW4m8dslcwXZk=;
	b=22yGud0z5bitoEdJ85/zvzhsilT/fCjNCw19n0HLWWfbTztORYZZdkZktp3vjbDsSRDq
	 GUdcdhmEMGkQ0Z8NQU103HF3aYBLwFe25kbkcj0N8Y9ZGkvAa0A4P36XtjNwmBciBh64v
	 TBk9L2VN2oN7VQtP71vEHZSXvVOspNpk2iWgvNK83fkZpooga05wzncmGajcX0/fmCqk1
	 bKs9xKNGU5T5WvPmMBn+mbwY1FUHbLdvccXt9/rgAJMGcvhZOEDrhCNXPrqU4BB/efLxK
	 xUMyJiOdRumKIw0FnZPU7wByssZlpjhDZidmM6xWtLIacU2cilMbQqun/3bcLQWwrNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B286082BC1;
	Tue,  3 Nov 2026 10:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B286082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABHWJnkselqi3s7AA--.2886S2;
	Tue, 03 Nov 2026 18:05:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: hns3: destroy the page pool if RX buffer allocation fails
Date: Tue,  3 Nov 2026 10:05:33 +0000
Message-Id: <20261103100533.1310018-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowABHWJnkselqi3s7AA--.2886S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUCF17Xw1UXw47XF47Jwb_yoW8XryDpF
	4YgayUAFZxZr1xGan7Ga1qkry5Za1ftrW8W34rZ3WfZws0kFWFqF98Xr1rJr1DGFZ7WF1a
	qrs5Z3s7WFn8Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQAA2rpnIRi6wAAsT

hns3_alloc_ring_memory() creates the page pool and then fills the RX
ring with buffers from it. If filling the ring fails, the error path
only frees the descriptors and the descriptor callbacks, so the page
pool created a moment earlier is leaked.

The page pool is normally destroyed by hns3_fini_ring(), but
hns3_init_all_ring() only cleans up the rings that were set up before
the failing one, so the pool of the failing ring is never released.

Destroy the page pool on the buffer allocation failure path too.

Fixes: 93188e9642c3 ("net: hns3: support skb's frag page recycling based on page pool")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 47788be64be6..fe339ddc6379 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5073,6 +5073,10 @@ static int hns3_alloc_ring_memory(struct hns3_enet_ring *ring)
 
 out_with_desc:
 	hns3_free_desc(ring);
+	if (ring->page_pool) {
+		page_pool_destroy(ring->page_pool);
+		ring->page_pool = NULL;
+	}
 out_with_desc_cb:
 	devm_kfree(ring_to_dev(ring), ring->desc_cb);
 	ring->desc_cb = NULL;
-- 
2.34.1

