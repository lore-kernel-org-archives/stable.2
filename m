Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693726;
	b=gBGPRwH3A2WKow18B/4Ywv0p/svBYtl8wlWMow9KoD7Q36wBMvOTjQdeifhsyqjosjPR
	 7TKqGsi4A+xC233X54WE3UZ7tmFP3zslP4MEpV5vbh5CRCM26BPFkD/Om3cGUXZuner6p
	 yJOxABsCh5Om9XwxAkiDucvqJ3ZgyXeHFKTdsPXnMtDBoXYt72pxy4lpgz56mWixnL7Wa
	 7PAI6brqkraE+sO61cmUPgK9n6GrUIdCYSS59x/kMDehuxibUOfqHhdljkD6Y7NMYb1a9
	 jbtoGoC44XwBFc+/JrXtF+XDLxzucADpuott24+z1bWvzsifP6tGLNIrscrYWAlsh3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
	b=3NcofiVvQ8/ne5AMwjP1Zb30gSLX02GrKlMHaQ9lZB+ooOB946NlrpZxaKNjqUHsVEFl
	 LUo21IUw+jwUBYlDi52BxaWcKUjLpPbsiUGpqNq/Jf7s7Bwyvtc2CwOwa1TBaOf8i5wQZ
	 oS60rhSfIIAPL67Th/QXfBM0e70DMX3BGElVJmUaEeXTU2XzuM9NOIKzZZAjAW7SCSyuf
	 VTs75OKE8oAV5O4LQCMlzAjOUYl03DZJTE610c3UE8UUsuQZ4ymmnMcZpJVsHappu7nal
	 FuB2MROjmipivoxkyCTaz3yDSQZtCm+w5vNp8F4dEMJt18yuCzFNf/XP1NMmxIkR1eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l92fzV10;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D7606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 18:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841D7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l92fzV10
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3adc8668936so28463a91.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792693726; x=1793298526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
        b=l92fzV10KlIkb0cr7Ubm74f9+Kq4xHT9XI5iy3Y3+jmKil+EUWHxjrstd9x+6/r587
         QIXkkGMxZgi9vD3oTXgT3fq27Op+NlD6zspidLjmK5RR/r23seKPba5jvTzHFrLC50SM
         1cs5RAnzK5LYj3idkPr+ZtEgEfYhtUP/h4POsvtSYtfIAi37mZjvy8hB2N6smSuWZnI1
         O91VMeruxHSBJNZi+AU75lm6j612fdTR/9PgF+ral/TjdT2IYnZnVaSZKPgkM07c/2Hc
         MfYL9//j5CfVqXWQdJPJauXdg4mI0zV4UUrMBy1yI8QX/XCr3Z3RrHJIxrm3Jl4WinaL
         8kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693726; x=1793298526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8G9f2sj7l3e7G5lnQu4Rk/LClqYHjpBN2zxkfvmpRHA=;
        b=D+OI6TqwMpWsuHZ9IC0LeVlJNbzc03Dhnk9pNzF1daa/0d5PSYd1BmHAmEpucEe0eb
         MI5wh2SUhZOptbp0cS0ZuOmUCY+6ReuRKCR53NPHgMYHXxHKBfGLB2NAFJRVgLZC+oW1
         KXYB4a46MazSacpTtilR81tVe4DWpsrUWBjpU4jGOP+zxYBg7Mwqm3ZUmUgdeBCysXRP
         esdcRXpeK3hbY7fxvsiI4oS7QYtEVrAtmj/wevtiGXKRPHsKhfqcRGLN0xeAxkpyhzkb
         /PcoQ5c2T/tKPUQaWNTH5sC0YPVnIj4CARS+PGyNdWq/Cujy3mcsAC4q/yRmQ+d6DCVA
         Nigg==
X-Forwarded-Encrypted: i=1; AKwUvBxaVryR/pnVlsdQBEcLXVmHOSjA9A8ZtSe5wQRprjDtbeI/McnMl94MZfT+vt0gfM9YW0y6tb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsfIs/TxPyValTSHWahn0BnBKHcXxFS6bpyi9fmDoR1fvaczPR
	ry1e7fTa5IQvXxVG4DuOALxl8q7PVyTHGwA49jEzoa0/74vW+PRf6n1JLfUkJ9J6w83KAw==
X-Gm-Gg: AYBFou2SkjYrCE6LxNFEm136XJjTKl46lwhE21v/iYdJOEA14kQNc8H9IdRMJRg8F+n
	dZLW7jcsWhHfISPsjQvUz4Hh4jTBEtbnKRl5mCe70eAdO6ZDzMHGQlxNGzMczkgXydewyOBdELy
	NPcURsSTu+7vmtgJ/wZqv7zqb67SphlIqbBno2w7vxPiyBpVps/dtEg13p5il1BPdB79oUMBUX9
	baevvm9tCVkLxKy0IYbGokLGKGb8lSCqqx9j5mj+2R5k9MJQBwo7uyz+aXgKGaHdUfUs8QkhVOF
	Nj7IbnxzvRqPn4O0DClrQg7xdombFwp+l2oQbliMRJ0ItD2kVM6o6ROiKmPX5ocA3oKVL1oe5u/
	mLO/u95U2CL4ofU8MiMVOioQEXtGhCqgItiMrUhCDUc5ylvG0in3QZ1FNAbpVdSk7RwyudDJqX0
	ti1MNQaIlJEb1xdHb21Uehqlr1MgrqGU6JJu0SHTLBKAhFAcmgNUZI5xbqOFRHrGApFhRw4wrcm
	V5ncIsQHO3ylGoXch4qJWD4pKcYexCTuQ2aXbZjxWFMXzNFxbiEyP9D6lJI1ltr//e9rQJ1/k3j
	iK/pAAU3uhcYx17eXz6vaMa6z8FeSdGvnjER5YPuMN4G/99hRIvUJdD0sBspqYhkRb8Kb76cCEH
	RJxUbcJQOZUZboLNa9JtYeS4LpVKltjzT7biWYh5c2llLXJbVzZkKMok5hA==
X-Received: by 2002:a17:90b:164c:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3ad86cc64d2mr5437501a91.60.1792693725903;
        Thu, 22 Oct 2026 11:28:45 -0700 (PDT)
Received: from wang0.shina-lab.internal ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490d4bfsm6115262a91.10.2026.10.22.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:28:45 -0700 (PDT)
From: Lianjie Wang <karin0.zst@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <karin0.zst@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] virtio_net: reject stats replies for queues outside the request
Date: Fri, 23 Oct 2026 03:26:58 +0900
Message-ID: <20261022182710.2055771-1-karin0.zst@gmail.com>
X-Mailer: git-send-email 2.56.0
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

__virtnet_get_hw_stats() passes the vq_index of each record in the
device's statistics reply to virtnet_fill_stats() without checking it,
so the device decides where the driver writes the counters.

For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
output array, which the ethtool core sized for curr_queue_pairs. A
record with the vq_index of a higher queue makes the driver write past
the end of the array.

For the per-queue netlink stats, the queue type also comes from
vq_index. A receive record in reply to a request for a transmit queue
makes the driver fill the struct netdev_queue_stats_tx on the stack as
if it were a struct netdev_queue_stats_rx. If the device offers
VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
bytes after the tx struct.

Fix this by rejecting the reply when the vq_index of a record lies
outside the range of queues the request asked about.

Claude Opus 5.5 was used to review the driver code and draft this patch.
To reproduce, the virtio-net device in QEMU was modified to answer an
ethtool -S request on a one-pair device with a record for a receive
queue the device does not have. On an unmodified kernel, KASAN then
reports a write past the ethtool -S output array. With this patch, the
driver rejects the same reply with "Failed to get hw stats.", a
well-formed reply fills the statistics as before, and the
drivers/net/stats.py selftest passes.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Fixes: d888f04c09bb ("virtio-net: support queue stat")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>
---
 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce4..0473fa9947858 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4955,7 +4955,8 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 				  struct virtnet_stats_ctx *ctx,
 				  struct virtio_net_ctrl_queue_stats *req,
-				  int req_size, void *reply, int res_size)
+				  int req_size, void *reply, int res_size,
+				  int first_vq, int last_vq, bool enable_cvq)
 {
 	struct virtio_net_stats_reply_hdr *hdr;
 	struct scatterlist sgs_in, sgs_out;
@@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
 		qid = le16_to_cpu(hdr->vq_index);
+		if ((qid < first_vq || qid > last_vq) &&
+		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
+			return -EINVAL;
+
 		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
 
@@ -5055,7 +5060,8 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (enable_cvq)
 		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
-	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size,
+				    first_vq, last_vq, enable_cvq);
 
 	kfree(req);
 	kfree(reply);

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0

