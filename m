Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0641B35C
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682618; cv=none; b=mPuyfwrvKh5xwaws/iFva8eACLD+fvz6aRtnZD9XpDiNUZwx3PD8n0DPCeLEKwcqryYamnWfMtekVXIqXGbcecYRsMJi0CbT5f1TyQl0Ted4XPOfqr1q3fRCs5DkdVAFj25mUK1FzPM9qd8V8iCnSneL+5PDUSRAeUM7d5R+UVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682618; c=relaxed/simple;
	bh=29xiFC1J6wo7zb8FK6bJ1+y5GotjoNBoErEWl56Gtzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiOEQDqiDEesnsM7xHWYdrtIBgxIlWTP3spa3cnOEvMOUWQqZtXwDx/N9Bq0bHr7LZtotV+Jc49eg6UPhiiou5LNrqWKFESzK7alAZ8ccWnE7CGjf2md2gQTzS1z79aHO0Ze5KQWtMU6ceOCCDCnAWYZVR7qlJBvdWN4WrE/tpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOPwjSqS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOPwjSqS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacd69a9c0so7563765ad.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783682614; x=1784287414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lesz3zvgc+1C6E8BACW+YNJxKt7pdV6bHtGUVcqgJuk=;
        b=SOPwjSqSKl4bCd9M9OFFeXZT6whoR4t2xgaesaksVcO+Elqx0mXsGUoMjCq28RxEMB
         5H+eMkecxKXJGFOk1c0tZ19c0R6uCrJJ04tWSky8UCZowIrGmqWPCJZPW5en2gewVEfP
         h1EtsdSgY3xy1b4qMrbVEyAPFuUfRD+aAR9nEuh4IkOXLDg0CPBgbLeXnmtTD1BhpvC+
         iBOknSOrbKz2egq4ahcbeDPolL7/+xbKJxGa8sdZhKCSTHhiDnXJzr0FPCLztNqk8mQi
         jfh/PmYWYs8sp82trP/8rsoP+Dh/+7cidODrCYR5Ew9b748M1nvZwLOvj0hHd1vPBv7p
         c/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682614; x=1784287414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lesz3zvgc+1C6E8BACW+YNJxKt7pdV6bHtGUVcqgJuk=;
        b=b3tROWHgvAr16ERPMyRsqUTTknNQPgdyN1vvu+cS+c2zSWrk/eROppO68b0RjiBWcH
         WQ/beIS4IiYdErJDzJaZnQamgdM3fJnuPFlJz3XN4pKaXjCxYun9NS0jXFcssCWO13cZ
         3mfSq+h6ZxjAOTRAlgOLZJjvydYMj/q31uRTuGhdpCEHERfqyOqLrLck3d6wFkOPVq8w
         Chbces1dBPZj7fxMG0yveB6+A8OaBUqwDA73L8yI5cg2AKdJNpm29bcO2Orc8vi6SaO3
         l+x9R6Lf3aDv7Y8d7QOi21dfpiNnwzRARjuHHCZSOvH/DSqBZ1NUdwc7uJ3dyL3pGlCm
         QCvA==
X-Gm-Message-State: AOJu0Yx8Uf8aBI258whkz71glB+lswKF/SIDT8ThdfLFj+ayDTKCeeot
	UeXQRBrEa+JbY3zp68tFiX8fechc3U8BEhsAU4Slog8zk83b7uX0pEbtUez3pFBl
X-Gm-Gg: AfdE7cnoFADKfa3ASKV05Faws6oQGBva6gqRn2QmcI2Dj2KQiBw6VA6gNsxJWrv0cuo
	h1wHYYPiq82DM1rJCZxs8+0RSH/KY82p62H24W8wAluhW42B2l9EVZ7UQ2UJiI1yKZTHhC860V8
	OJ45jwij808jDZdgTlkL7xA2mhY7SGEBiSw8VUlyyqkjsRiKiHKM3YN+9RkzSyu7zqZyhxs5a8g
	88/NZXkgpDyarOfoGfYggPn1wu58Xrl4mn+KX8rvLObbKol2gIcUIEtyF7cR7fVaiSvw9g6Tai3
	MkgKFE7e2wcDulOODAzS3ao8BtKW8dsqdrDOBbDyhBxTemWUkQ/GlJX2+0fYK2q4yludzb90sgF
	26JrD2jfJwncymCAuWLVbi3B2MbSW7Kues6Tqx1x42CzD6+oSfSN0PHdS0WIFjWXHw6b4gP++P5
	CMlkOcucHJXHpBzUr2fuUDvPeygrUPb6ySXmuakklEE6myiD/1gJ0n+kyA/rHjT0lVceeMdBW0D
	RVjruOnm8xQo6PPrqyCqRH4zB1HQdDDKokK0tLjN3mQC85X6IQ=
X-Received: by 2002:a17:902:f60b:b0:2c9:97a7:f540 with SMTP id d9443c01a7336-2ccea433949mr121433875ad.38.1783682613643;
        Fri, 10 Jul 2026 04:23:33 -0700 (PDT)
Received: from ip-172-31-54-240.ap-northeast-2.compute.internal (ec2-43-203-160-83.ap-northeast-2.compute.amazonaws.com. [43.203.160.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bd33sm58745315ad.58.2026.07.10.04.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:23:33 -0700 (PDT)
From: Hyokyung Kim <pulpannie@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: [PATCH 6.6.y] virtio_net: Support dynamic rss indirection table size
Date: Fri, 10 Jul 2026 11:19:54 +0000
Message-ID: <20260710111954.234758-1-pulpannie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philo Lu <lulie@linux.alibaba.com>

commit 86a48a00efdf61197b6658e52c6140463eb313dc upstream.

When reading/writing virtio_net_ctrl_rss, the indirection table size is
obtained from vi->rss_indir_table_size, initialized during virtnet_probe().
However, the indirection_table was statically sized as
VIRTIO_NET_RSS_MAX_TABLE_LEN=128, potentially causing issues when
vi->rss_indir_table_size exceeds this limit.

This patch implements dynamic allocation for the indirection table,
allocated alongside vi->rss after vi->rss_indir_table_size is initialized,
and freed in virtnet_remove().

In virtnet_commit_rss_command(), scatter-gather lists for RSS are
initialized differently based on hash_report presence, so indirection_table
is unused when !vi->has_rss. Therefore, allocation is unnecessary for
hash_report-only scenarios.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Hyokyung Kim: 6.6.y predates the refactor that moved the RSS config into
  struct virtnet_info, so struct virtio_net_ctrl_rss is still embedded in
  struct control_buf and reached through the heap-allocated vi->ctrl. Every
  adaptation below follows from that single difference:
  - the new allocation and all indirection_table accesses use vi->ctrl->rss
    in place of upstream's vi->rss;
  - because vi->ctrl is allocated in virtnet_alloc_queues() (via init_vqs())
    and freed in virtnet_free_queues(), the table is allocated and freed there
    too, not in virtnet_probe()/virtnet_remove(), so its lifetime tracks
    vi->ctrl across the probe error-unwind and freeze/restore paths;
  - since freeing the table now dereferences vi->ctrl, vi->ctrl is set to NULL
    after each kfree so a re-entered virtnet_free_queues() cannot dereference
    or free a stale pointer;
  - the table is allocated with kcalloc() so it is zero-filled when
    reallocated on the restore path (upstream never reallocates it). ]
Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>
---
 drivers/net/virtio_net.c | 43 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 33f61922c1..5bcd129685 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -208,15 +208,16 @@ struct receive_queue {
  * because table sizes may be differ according to the device configuration.
  */
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
-#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
 struct virtio_net_ctrl_rss {
 	u32 hash_types;
 	u16 indirection_table_mask;
 	u16 unclassified_queue;
-	u16 indirection_table[VIRTIO_NET_RSS_MAX_TABLE_LEN];
+	u16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
 	u16 max_tx_vq;
 	u8 hash_key_length;
 	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+
+	u16 *indirection_table;
 };
 
 /* Control VQ buffers: protected by the rtnl lock */
@@ -3011,6 +3012,25 @@ static int virtnet_set_ringparam(struct net_device *dev,
 	return 0;
 }
 
+static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
+{
+	if (!indir_table_size) {
+		rss->indirection_table = NULL;
+		return 0;
+	}
+
+	rss->indirection_table = kcalloc(indir_table_size, sizeof(u16), GFP_KERNEL);
+	if (!rss->indirection_table)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
+{
+	kfree(rss->indirection_table);
+}
+
 static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 {
 	struct net_device *dev = vi->dev;
@@ -3020,11 +3040,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	/* prepare sgs */
 	sg_init_table(sgs, 4);
 
-	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
+	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
 	sg_set_buf(&sgs[0], &vi->ctrl->rss, sg_buf_size);
 
-	sg_buf_size = sizeof(uint16_t) * (vi->ctrl->rss.indirection_table_mask + 1);
-	sg_set_buf(&sgs[1], vi->ctrl->rss.indirection_table, sg_buf_size);
+	if (vi->has_rss) {
+		sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
+		sg_set_buf(&sgs[1], vi->ctrl->rss.indirection_table, sg_buf_size);
+	} else {
+		sg_set_buf(&sgs[1], &vi->ctrl->rss.hash_cfg_reserved, sizeof(uint16_t));
+	}
 
 	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
 			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
@@ -4080,7 +4104,10 @@ static void virtnet_free_queues(struct virtnet_info *vi)
 
 	kfree(vi->rq);
 	kfree(vi->sq);
+	if (vi->ctrl)
+		rss_indirection_table_free(&vi->ctrl->rss);
 	kfree(vi->ctrl);
+	vi->ctrl = NULL;
 }
 
 static void _free_receive_bufs(struct virtnet_info *vi)
@@ -4266,6 +4293,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		vi->ctrl = kzalloc(sizeof(*vi->ctrl), GFP_KERNEL);
 		if (!vi->ctrl)
 			goto err_ctrl;
+		if ((vi->has_rss || vi->has_rss_hash_report) &&
+		    rss_indirection_table_alloc(&vi->ctrl->rss, vi->rss_indir_table_size))
+			goto err_sq;
 	} else {
 		vi->ctrl = NULL;
 	}
@@ -4298,7 +4328,10 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 err_rq:
 	kfree(vi->sq);
 err_sq:
+	if (vi->ctrl)
+		rss_indirection_table_free(&vi->ctrl->rss);
 	kfree(vi->ctrl);
+	vi->ctrl = NULL;
 err_ctrl:
 	return -ENOMEM;
 }
-- 
2.53.0

