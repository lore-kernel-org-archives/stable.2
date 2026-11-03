Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700327;
	b=cm9qfHJO1tPC6t9C8o/rtAuvNRoOAOxtRMkCwWFQkxUKv7zQOO0bluxunwl71wVaL16s
	 wGupsqQUVokjB2DleNEk1DXf+cy1SnsFktltMUO4hGueFFPjlHSZ5KVs4GyzqYn0/92tH
	 0mDZfV5JDGLU3y4/pxNFUZ9ZUzrCAaRI+xb5GRg7/aQtpnliECUD26LEi2lgsMMRSPQ4N
	 eFOF2gMjC+GbcEFlOTiNNthbIvsJVwxozzccsxOcUxE2ruw8KwMKvRysAnWhEVOXKZZ41
	 7kREpuvQYu1klOnbxIbLlKogy/znS7kaepZnpXIt2MLeDvG4D+RDZw3Qb+q8mAOu8bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700327;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=1hy2B0Zu7GhzWyKHcTjvBdxlkZN8R27zax2cpYW8l4Y=;
	b=G54D/8vtuQNph9EK0KUklCRUlTrXNwQeqmbe8OBpV82q6JT8s0Tojxx9BkXMzeRW9DPg
	 8GU88ZKaOVl4YlAcUTqPxTe5nggFdFlvv45aGvihsFx5XJ+rjOT6p9ODE7Ybduj15y1fp
	 8HMDAHvvZeh5qh9a1ZvXwxYWFLGvve52qob2LNkIWkLFEtUVJyB1VQ9ZDBsIsVIDhQ7MJ
	 7J0a4bFPSAr8aQbvdJ88Rg4bn6ZpYjAKoEvrQnhFjmm+TyUjlYE6DbZULVzaL+CfvCfwU
	 2dukxQw/TQYoSwQBV8wKXtWitKWJ+xH7VAAXUwWZaACFe3GbqPsY5JYSa1Ejq7kKL0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC4606D838;
	Tue,  3 Nov 2026 10:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BFC4606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnN5jgselqZns7AA--.48851S2;
	Tue, 03 Nov 2026 18:05:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] can: sja1000: fix netdev leak for non-contiguous channels
Date: Tue,  3 Nov 2026 10:05:28 +0000
Message-Id: <20261103100528.1309863-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAAnN5jgselqZns7AA--.48851S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw45KrW8Cw1rWF48Cw1UGFg_yoW8GF1kpF
	WDtF90vrykJF1Fqan5Xw1kCa45Ja97G3y7K3yYv348Zws8AFyxCr1rGay0gFyqqF4fuFWY
	qF1YkrWjgas5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUMGQ
	DUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnIBh6AAAsO

pcan_add_channels() stores a registered net_device at card->channel[i],
where i is the hardware channel index, but only increments
card->chan_count by one. When a lower channel is absent or fails to
register and a higher one succeeds, chan_count no longer covers the
used slot. pcan_free_channels() then iterates only up to chan_count and
leaks the net_device of the higher channel; the LED timer and the
interrupt handler also skip it.

Record the highest used channel index plus one in chan_count so that
every iterator covers all channel slots.

Fixes: 2b61972b7421 ("can: sja1000: add support for PEAK-System PCMCIA card")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/can/sja1000/peak_pcmcia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index c3c2aa21da47..bba51dd808f8 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -574,7 +574,7 @@ static int pcan_add_channels(struct pcan_pccard *card)
 		}
 
 		card->channel[i].netdev = netdev;
-		card->chan_count++;
+		card->chan_count = i + 1;
 
 		/* set corresponding led on in the new ccr */
 		ccr &= ~PCC_CCR_LED_OFF_CHAN(i);
-- 
2.34.1

