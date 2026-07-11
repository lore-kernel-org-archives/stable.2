Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D442C21E6
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782482; cv=none; b=TXcHw0cVgKQjGYHhRACCoGYWpkB2tecDIJ1bSM7sD6mpibIbz2jwDKrlTnv0fXLjwTtGvDiP+w8NwgudTmKsCmGURJ5ldRy3BkGgMrteK0GMa/MaLPvDI15aWuMu/i/+vU7Ey8iniELIhjfJhqQm3j/cUOr45KWxHpkIL0wTk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782482; c=relaxed/simple;
	bh=iVN6Oa7DczuGg2N9AQ8E0U8qy+G8dhvBhCAjVmI+XN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fc710eLmKcJMQIMQWfofDM6+5TBldSJcSn1qNlqw8ZN/O6+hj6qePTCFyaSA6xEq0QICyjfWJXvlYo1u23+UhobDSmahuYMYkiCxl4091mHvwMCP4Hjed5LVzh49D5fYKdLfNhN262eILDkrtFkCnPBnDLs8tNdd9mlh/OcZnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcZjIyUB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcZjIyUB"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c68aa31so11933541cf.3
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782479; x=1784387279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14qOd7NMSc5W1H4WG9ru/PizsjwiaHIwQhYh9VLIk/c=;
        b=YcZjIyUBAc8MaUivL5skDdhcMTY9UCR1eZy/ATu1JLQjHEvY0Uq/Fg14HNDHJRxbOz
         IRpjk1cKaDSF/7atBApp1HURmXckcjR4AcQciZa+xImb9uA33cz2iW3T5ZQiKNYHEmGu
         +uJRXcN4b1RNpK9WZCAaWgZ/+8WV9rsNrD3oFXmvXP7JeRd7Oph6aUiR0ILcgjXCb0nG
         wHH2w7npfsqLYG4bDXOhdRWlLO8uaGp309NVivuE4pZtcuI7DeudbO4NTFu1fxxAlpZp
         YMV0vMo7P0nOe3fsejSJzjFhVUKTOJk9bNxS9zTTpAZGCcj7dYaBCmo8bSbcRgwCk22J
         EznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782479; x=1784387279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14qOd7NMSc5W1H4WG9ru/PizsjwiaHIwQhYh9VLIk/c=;
        b=MbOgATI0agq6Va1c5In8c97kYTziKEFhsadPyPTjSdlQL/2ZhTqDFfZFR9UwrHkARw
         tYS4SVwi8aJMUADz7IvT34WUzd5S+8Rwdys400VZygpL0CVZAxZUAv/iDhzrm/ZVMXAJ
         RbDkK6KX1ryDmJCmXyE+ST9zi0n+W7L/QnhdIFVf3G1I+YcGR6KaVvVZrAkQOU6UYfdx
         CFn+B6dfKpKpVx8KIvXZMri6Klrvja28BsIJkaK8dT7Fk+BIrUfqbleSbKUJ/YuD2+VW
         x14XUG8j1Qh4H4I1PPWiRZXuSW94K7dIYWG4zziaK6xNYfJoyYFmJ5n7roMeQ5n4xoTs
         MFkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsFyEhE/auoWcchCHKXWc9j5t1PLVvWJO6aHFazA7DLNMP3j6ET06Bszd2Y41AaerX+Re7eUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJoStquhdLQ0BnkMwBplO+Xm50WIL0BF/1TDOQdt23Af6CTwV
	g318sw2Fb4KKaAOVI3A5k7otZ0fDt4kMKd0IGo9NTfaNfhCMHAzLPbEd
X-Gm-Gg: AfdE7cn/kBNVzN7sZlhRjpt2CNVmtz1jrWEpaC3bf4oRNfV7yA3kJS9oOEB+jQj2p6r
	tx393kbBS7SbCQsZ0VdswpxSsV//t7/W/AR+xY4epXnef7XYny85HS06PCE2+pbiIl9/mC973iy
	cetQiCH0LOxNPZ+TvyyRnmtuB1qu8Qwrm2byDmStHi4ashfftHxvDuZkmqAfxLFSOSbTNFia46y
	GrfGmJC/p2EOWHtZ73lfLtPXusXTRsUGSsWxUR4yyZpFTkKLJxe7OETDi8bLHk6BvEFn1npKWVI
	EFa6t6eYBiLaPhTZZrgWXwdq6cNm8RhpwXkDEUSW1ofkjeDdJkiYskpZMNfg2b0lcSuv4EgYKXw
	lvQ9tDAzZOSLgD8svyGpasXCDfVtIqoCpKkq3jWjGzct+xmiUCsYnEWsK7YyZscMVZG+Tti99tc
	yCf2jMELtuOSYNy7iQX5WEC47LPit5KX1kaiCX+bzj10q9EwPalrQRc9WuuKlhRaLuluuzLZ929
	02ttg2Z8g==
X-Received: by 2002:a05:622a:14ca:b0:51a:8c9b:649c with SMTP id d75a77b69052e-51cbf38da9fmr29698741cf.64.1783782478863;
        Sat, 11 Jul 2026 08:07:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf8dsm69025296d6.20.2026.07.11.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:07:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_net: validate device stats reply records before use
Date: Sat, 11 Jul 2026 11:07:54 -0400
Message-ID: <20260711150754.2918392-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

__virtnet_get_hw_stats() walks the device statistics reply buffer with
"for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size))",
using each record's device-supplied hdr->size as the stride without
checking that a full struct virtio_net_stats_reply_hdr remains, that
hdr->size is nonzero and matches the expected size for hdr->type, or that
the record fits within res_size. A backend that returns hdr->size == 0
spins the loop forever; a short or oversized size drives out-of-bounds
reads in virtnet_fill_stats().

Impact: a malicious or compromised virtio-net backend hangs the CPU
running the guest's device-statistics query in an infinite loop
(hdr->size == 0), or drives an out-of-bounds read of the reply buffer.
This matters most for a confidential guest, where the host is outside the
trust boundary.

Validate each record before use: require a full header in the remaining
bytes, a nonzero hdr->size that is at least the header size and matches the
size expected for hdr->type, and that the record fits within res_size; stop
the walk otherwise. Add virtnet_stats_reply_size() for the per-type size.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8c..9cbe40d218cc4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3532,6 +3532,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 	return err;
 }
 
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
@@ -3546,6 +3547,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	bool ok;
 	int ret;
 
+
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
@@ -4927,6 +4929,32 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	}
 }
 
+static int virtnet_stats_reply_size(u8 type)
+{
+	switch (type) {
+	case VIRTIO_NET_STATS_TYPE_REPLY_CVQ:
+		return sizeof(struct virtio_net_stats_cvq);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC:
+		return sizeof(struct virtio_net_stats_rx_basic);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM:
+		return sizeof(struct virtio_net_stats_rx_csum);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO:
+		return sizeof(struct virtio_net_stats_rx_gso);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED:
+		return sizeof(struct virtio_net_stats_rx_speed);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC:
+		return sizeof(struct virtio_net_stats_tx_basic);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM:
+		return sizeof(struct virtio_net_stats_tx_csum);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO:
+		return sizeof(struct virtio_net_stats_tx_gso);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED:
+		return sizeof(struct virtio_net_stats_tx_speed);
+	default:
+		return sizeof(struct virtio_net_stats_reply_hdr);
+	}
+}
+
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 				  struct virtnet_stats_ctx *ctx,
 				  struct virtio_net_ctrl_queue_stats *req,
@@ -4936,7 +4964,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	struct scatterlist sgs_in, sgs_out;
 	void *p;
 	u32 qid;
-	int ok;
+	int hdr_size, ok, remaining;
 
 	sg_init_one(&sgs_out, req, req_size);
 	sg_init_one(&sgs_in, reply, res_size);
@@ -4948,8 +4976,17 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (!ok)
 		return ok;
 
-	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
+	for (p = reply; p - reply < res_size; p += hdr_size) {
+		remaining = res_size - (p - reply);
+		if (remaining < sizeof(*hdr))
+			return -EINVAL;
+
 		hdr = p;
+		hdr_size = le16_to_cpu(hdr->size);
+		if (hdr_size < virtnet_stats_reply_size(hdr->type) ||
+		    hdr_size > remaining)
+			return -EINVAL;
+
 		qid = le16_to_cpu(hdr->vq_index);
 		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
@@ -7305,3 +7342,4 @@ module_exit(virtio_net_driver_exit);
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio network driver");
 MODULE_LICENSE("GPL");
+
-- 
2.53.0

