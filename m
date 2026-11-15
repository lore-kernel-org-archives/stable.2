Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729786;
	b=vJcScS5FwG5JQZXSD0Kd7xJusdb3tzSMuKpG1okOJg4wyJW+GMuB/juaM/8vwKn5OkVB
	 obDld2R4hU+V0zSaG2pE8l/1oP/G4OtApHVUB0iqYyNkPLwDekNTlaKAqVGWiCU+ubU6s
	 0FBoAgLSnebzs0gLIJiwfxTram41IyUTpaptTWBVB2wbVKHvY6rMynHYTpnNz7w3D6P50
	 Jw6pMN8s87sepaJEfbJTdW3PG6yBz+x/7aec4F7e4q/sIUK7Jr3mnRzwSRYYdbXEpccXI
	 VGKJzexHey+evnIH3mNrIHo2RxDQDjGf8YWh8Q3K1V1f3PkMoOIzgdRXG96DSvnsHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729786;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2cHoKfMTCq8qVifnRs0Z8Ntt3pn0su/nfO0nJQ9487s=;
	b=nqdvBY4m2JaQ1xF1b7QV+xkANklnehoi6Krd4ZcdUK40oVOtF9ehg9MwfUwo+VUDgA5v
	 +YqHVfcxTpkSlYCzrVMa2ip+O0zdjVE4nOUFcXRp9UQMuk1jEQbBGoMK5jCCTJxEFFP1E
	 OZmOz1A7yvCDvTRWSh5uXTz/o2EBHVQPwTx2EB7QyObKkYX8Lqrzptc5HhnvNZ2lTSCRS
	 x3RMTt09Px9k3AG1oHAmFvsD/luHdLw8YVaxCxCekGR0yE+WTcp6R9Q4vT+S4euH/gGC2
	 6mn6rYJXybcaIVoGowF3L8G51xmXQWA9PdSiPU8vKjKeyodJjqnov0Sufd6rnoh4Grg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dGFRbzx3;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F01606A329;
	Sun, 15 Nov 2026 08:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25F01606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dGFRbzx3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2c
	HoKfMTCq8qVifnRs0Z8Ntt3pn0su/nfO0nJQ9487s=; b=dGFRbzx3fNZVhnYwa2
	mdZ982tnEwZzeHvABeQ1FQjbJZeTHWYKl92Yo+9Sv2o8j1g/LIeUNFkGhblbfiZh
	smQZMvkfAZQ0y3SulsA6GlanApw9VU1EV4c8/9eL9fBf3wJnzngR0LzNYpXd8w9C
	6qy/Q8wajVI4z7kJHuVXR8cYY=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wB3fJUmZ_lqQz57HA--.24354S2;
	Sun, 15 Nov 2026 16:02:46 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: at_xdmac: handle empty transfer list in tx_status
Date: Sun, 15 Nov 2026 16:02:45 +0800
Message-ID: <20261115080245.910534-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wB3fJUmZ_lqQz57HA--.24354S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry3Aw1kAw17CF45GrWDXFb_yoW5Gr43pa
	yfG3y5CryktF4ruF1kG3W09ay5ZF4rCayUuayDW3s8uF4Yvr4rW3s7t34jqF98Wrs5XFyv
	yF4Ut3s3CryDGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bU-erUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7Qb7TGr5ZyavCQAA3o

at_xdmac_device_terminate_all() removes every descriptor from
atchan->xfers_list without completing their cookies, so
dma_cookie_status() keeps reporting a terminated cookie as
DMA_IN_PROGRESS. at_xdmac_tx_status() then calls list_first_entry()
on the empty list and uses the list head, which lives inside struct
at_xdmac_chan, as a descriptor: active_xfer and xfer_size are read
from neighbouring channel fields, and if active_xfer happens to be
non-zero the residue loop walks a descs_list made of those fields.

For audio this is a routine path. The generic dmaengine PCM calls
dmaengine_terminate_async() on TRIGGER_STOP and later
dmaengine_tx_status() on the same cookie from
snd_dmaengine_pcm_sync_stop() and on close. What happens depends on
the struct layout. On a 32-bit build active_xfer overlays
sconfig.device_fc, which is normally false, so only a bogus residue
is reported. With CONFIG_DEBUG_SPINLOCK the larger spinlock_t puts
active_xfer on the held lock word and descs_list on the owner_cpu and
owner fields, so the loop follows a pointer that is not a descriptor.

Report a residue of 0 when no descriptor is queued.

Found by LLM-assisted source review. Not tested on hardware; the
layout analysis above is from reading the code only.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/dma/at_xdmac.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ef0dfe9d3..bcfbb41ea 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1553,7 +1553,16 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 	spin_lock_irqsave(&atchan->lock, flags);
 
-	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc, xfer_node);
+	desc = list_first_entry_or_null(&atchan->xfers_list, struct at_xdmac_desc,
+					xfer_node);
+	/*
+	 * The list is empty once the channel has been terminated, while the
+	 * cookie of the terminated transfer is still reported as in progress.
+	 */
+	if (!desc) {
+		dma_set_residue(txstate, 0);
+		goto spin_unlock;
+	}
 
 	/*
 	 * If the transfer has not been started yet, don't need to compute the

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

