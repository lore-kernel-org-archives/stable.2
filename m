Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038846;
	b=RyC7YCo2gnNp0LWFgZ/Ipg5aoqBvEqibz1U6/6I0/6dkg3eg4XBFqwy7wGfWZVc5eo2K
	 FofR4PGSHEW/OxDqTH63Kvw9N4y4yd1IB0qjZ3r0OpbHTd+QWUzkiThP9yY0N62bkBIGL
	 4Jr10T5t473ZXc1sKbAAtNCVOHdpoId/EHtpi3i76qhDiZFA1LMGaYJtPY+S8JQN1gKEp
	 5l/1g/xMbD2swa7TqN+GyHJFz5qWQ8zocqjNzUB4hpKqVJxoLevInHo2O0cURoScuEXak
	 n94rIp9mPoHJZv3jO5FSqwadFkNrhGVGXqDo0Dcl071pQIVwl3jtBb2vzvxLIGdGe4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038846;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=37Q/M3b5464XwrQ37wekA+4vcvzkDiOdS3nwiJzbO3w=;
	b=KEivJZeZQ23WXfFHkvuLg645cewoRc4ruQWOEb+wAaA6m8Zcp9KC8pNSVEtYLvYFipkX
	 z66eKqDBEHZW3ECOtZ8m+D2F9LXRQdOQhJEDSKv5WqvvCm1g9KQkcP4jNQdmOjXE9hxA2
	 teSrkdisdrdH/Fu9mdIhhQ07OIj3sOCyrS0y6To8SOCi2lwSdCGKNVFTyFOQICatU6SBq
	 T03kZumY0o3w7c351/FtwrI/5W26HEj6lKLMtgwcPIt58OCrGiRQvKESHRKZXIX2xC552
	 zuK/fF8Jks1J0lBtHgO2E7LmXOJVKH/tW/NnLnAr1Fqhn7jgkiUQhHP+gpuSyi0tgJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7F606A336;
	Sat,  7 Nov 2026 08:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC7F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXhP443O5qzr5xAA--.13418S3;
	Sat, 07 Nov 2026 16:07:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans de Goede <hansg@kernel.org>
Cc: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/2] platform/surface: aggregator: Fix wrong completion
 list for pending packets
Date: Sat, 07 Nov 2026 08:07:30 +0000
Message-ID: <20261107080730.1-vulab@iscas.ac.cn>
In-Reply-To: <20261107080730.0-vulab@iscas.ac.cn>
References: <20261107080730.0-vulab@iscas.ac.cn>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXhP443O5qzr5xAA--.13418S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUKry7tr1fWFy7ArWkJFb_yoW8ZFW8p3
	y0g3yfCw1kJr17tw48Xw1Uuw47Zws8Xr4Yk3yYv3s0v3s8Xr9Iq3WI9F15uFZ8Cr1kt3y7
	Kr48Gr4Dua18ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUgUKsDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIEA2rucYK7ZwAAsp

ssh_ptl_shutdown() takes the packets it has to cancel out of the queue
and out of the pending set and collects them in two local lists, which
are drained once both locks have been dropped. Packets from the pending
set are moved to complete_p through pending_node, as their queue_node
may still be in use by the queue when a pending packet is re-queued for
retransmission. The move itself, however, targets complete_q.

An entry added that way is linked into complete_q via pending_node,
while the loop that drains complete_q looks the entry up with
queue_node. The two nodes are at different offsets in struct
ssh_packet, so list_for_each_entry() derives a packet pointer that is
shifted by that difference: the state bit is updated at the wrong
offset and the completion and reference-drop run on an object that is
not the packet the list entry belongs to. At the same time complete_p
stays empty and its drain loop never runs.

Move the pending packets to complete_p as intended.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Cc: stable@vger.kernel.org
Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/surface/aggregator/ssh_packet_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 3dd22856570f..a51395942747 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1983,7 +1983,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
 		smp_mb__before_atomic();
 		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
 
-		list_move_tail(&p->pending_node, &complete_q);
+		list_move_tail(&p->pending_node, &complete_p);
 	}
 	atomic_set(&ptl->pending.count, 0);
 	spin_unlock(&ptl->pending.lock);

-- 
2.34.1

