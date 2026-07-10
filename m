Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBC4195C3
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682748; cv=none; b=t0fc1iihO6ce218+BzuogPkO7NymucVv5KAOyhSykvvKJeneAkzB2tIw9feS9vKZTcVFB2ZO9NHofnzGJPvvAiH0mw5+aLm9N6748EszOwgkBKasgpv6C+UVfV0gp8VxWASPbkkfbBRubJNxXopBSdybH5R722rwNuU9hGdXf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682748; c=relaxed/simple;
	bh=NmZAtAimMAcYEGU7PVxmVYliOIv6/UMM3TlVMC/v1cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1ktMSwVh5GT+2/hfBha4o+dLiUeYWi8e9g/JKJYGJ80X1P6SnPCcq3vmQDNlrAiMD/R8XJivasgzHLs/HMJAwSUAcxWGVROFG4BFuVQd2lKfGxwEdXEtjcfP1LkaeWtbjfPNS4Y2Nlq6lt/Oy3izTVsnD329aYh4EY9mKHuEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVinBMdu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVinBMdu"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848595b338cso860598b3a.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783682739; x=1784287539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4KxEecbJeAnfoH/HFfiLTjt47ShuOirRWvUozKk93M=;
        b=RVinBMduarf+vUQz9N/ioFeP+j2c1auzHLzCS+0ULJvPTUK+MezaT02dU62NEvBfid
         XzFQZSkBCUmjt9pUUhOXnRWExl1jmRGIs5GTxtOjMvg63/dOh4GPx85vUOSPFkkMBClT
         qEslnNj+CLPRDYErBNBUfCeqnTbwSp3PP3AEQanEkW2xAmrzmgOjGCHSgeS7vbeZtJql
         LVY40Vk+J15S3FD5NchF5INcZ7sDAipxj3/0rxh4O3s0new0PtxZ+M9fmxHNRMKl7KRG
         dRS4sgop5erIXMGdgUDZMJ8yxxfsdi6SLdKtemNtJQBEYNCG/bZTy9ceYX+TCKn4OOGI
         Y4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682739; x=1784287539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E4KxEecbJeAnfoH/HFfiLTjt47ShuOirRWvUozKk93M=;
        b=JoLbpT8VxVL4rspMJJonSERjFTvYOaCfOGSD6AzRWCExLszpkGwFrdIzXaYLFXP5AW
         ki/G43/NFU5nc1xpP7RglvDTJGPZEeZe4Jl30tpEUG/nI7nSMFp/Sq0gkQ6XC39fiX6c
         aZrrUt7ATmO6uiNO307jLHQzond3jvjzlhIncqGYOoMR29WQ0rVpwU8E+PNvJDXQr5dH
         V5j2Hw5km0pM6ep0ExetPJTu0eL+o4a34v7A1CbORaAC10KBQrtKys+6VLtJdDU5GD27
         A7wRyqOVkTk+MQCsy8gS9f9C3Zz8ffjKEij6J9Xau10kUQMrCYx50jh2rhfl7DDkIoK2
         B3gw==
X-Gm-Message-State: AOJu0YzNst+/GkPJSC7aiNHCN8NGkNO6sSzEN7YvSu2icTwD5x8adlB+
	xYxGPcYLNJ+pjRVeMyTj1p5K0AerjltsKYQwqehY9wXpCWJVu7zVxDMUaGwfQuAA
X-Gm-Gg: AfdE7cn1U9CaxHd0eMOLqTZkgG6evIkDXGyO8eyc4PvRy6OsdFzh/+LHHEedPymUgnC
	9OQu98tSackjuu8pDxGcMSb7lxmS9r5c7328OXi66pdxoG8M6WlKw6dJw2rqvN4yTdJ9yKNnI47
	QQmjwWhOnxOa19MHuHH9Vb8hkLtrJgQzGmKBCN6Ow608oTO0SEWhVvVJhLiibTqp7kYlpUgtWm7
	q4fsde699T2QUv4HuoIqxciNudRjmcVchgF72zB3Xw6AaUClhnbscUQv9O+XLCX6v/3xVmJ0wyX
	1aISc5oQCYpbYUVPSCpLRWGH2G5ZHi+6NZXY8Mv2EIQ1hQi3tifFQB1i60kusNx01R4Hedk6Y3w
	BbV2OS9pX2XGiVn9+OMEZulEYSzNaJfSwKxpXSdVAir8KSnLL0twH7yyxnGlwtUBAQdNCOZOH8I
	yBxdYtQf/vi7HDcWYErCKnG1uLpHX0DhXMxjYk7V61ntV8JO24MZAjKb5oxI+OsRxPTvJapbCsp
	MJRQpSqZmRIjIVmnB+jgDSPqwZMhT1XKphZRb+zM/LFL4m6dLY=
X-Received: by 2002:a05:6a00:12c6:b0:848:3fe2:c88b with SMTP id d2e1a72fcca58-84842ed26a7mr10863271b3a.6.1783682739009;
        Fri, 10 Jul 2026 04:25:39 -0700 (PDT)
Received: from ip-172-31-54-240.ap-northeast-2.compute.internal (ec2-43-203-160-83.ap-northeast-2.compute.amazonaws.com. [43.203.160.83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8485ff27e24sm2336997b3a.11.2026.07.10.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:25:38 -0700 (PDT)
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
Subject: [PATCH 6.1.y] virtio_net: Support dynamic rss indirection table size
Date: Fri, 10 Jul 2026 11:25:21 +0000
Message-ID: <20260710112521.234909-1-pulpannie@gmail.com>
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
[ Hyokyung Kim: 6.1.y predates the refactor that moved the RSS config into
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
index b62b769631..2fb00df795 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -179,15 +179,16 @@ struct receive_queue {
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
@@ -2488,6 +2489,25 @@ static int virtnet_set_ringparam(struct net_device *dev,
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
@@ -2497,11 +2517,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
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
@@ -3415,7 +3439,10 @@ static void virtnet_free_queues(struct virtnet_info *vi)
 
 	kfree(vi->rq);
 	kfree(vi->sq);
+	if (vi->ctrl)
+		rss_indirection_table_free(&vi->ctrl->rss);
 	kfree(vi->ctrl);
+	vi->ctrl = NULL;
 }
 
 static void _free_receive_bufs(struct virtnet_info *vi)
@@ -3610,6 +3637,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		vi->ctrl = kzalloc(sizeof(*vi->ctrl), GFP_KERNEL);
 		if (!vi->ctrl)
 			goto err_ctrl;
+		if ((vi->has_rss || vi->has_rss_hash_report) &&
+		    rss_indirection_table_alloc(&vi->ctrl->rss, vi->rss_indir_table_size))
+			goto err_sq;
 	} else {
 		vi->ctrl = NULL;
 	}
@@ -3642,7 +3672,10 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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

