Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E312580F2
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089202; cv=none; b=SNZEUbRK9TzwH6u5vzcJAeItYboj3Fk9LHHtTBfO+yHjqphqR1wZ92NK1meOgQRL18+/IJT97zR0RaBsfd3r1WDumWr+Vc032LZCKFQqwXC+CSu59LMLNxpc6k9vebndxP81B5js5mQfeD3cuHdSUw40HM+iVOopLIiRu1cgZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089202; c=relaxed/simple;
	bh=b3VEzD4rm/FS/PnzVVrz5CWx+QC9gU4eZsOGUXkAeZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2V0VUeEX1t20VZ/brkWM24O7nlu+4FKdOt2Kt8TQkCQhKclRdS7C9hDoj3OUMsOZe6Hk3rYjHimEvu1rkQSmihzoDTebSOQaJEHRZbWJv2RrIvhRF2NcnOyhiNVaJZ48H6fT2wP41futsIOvMn1AF1animALhjttWoc0k/F6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/DwusbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/DwusbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8E71F0089B;
	Fri, 11 Sep 2026 01:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089198;
	bh=Tqn1mzJAt+JsUB+KmhiMk6YYRyqZ8rAayjHO9VEALk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/DwusbHkwNDX3YcSxCw1w+zkl69/1F7vvjogwJeJ/5wKW8gClWyZwVbFQRUHzeql
	 n3+QF/uXNc8io98bBSgZlf4oiGYMSMYMwEMgg4AW2p23RZHtzEwGciaRk0L3EhUZ5+
	 ENBx5K1DSPx7dHztBgPHCEgEGyUb/7zBHKq/Sz/PiCIgyrSGUwGrteLaHayLjEozn9
	 Bqtx0p4gIqv0aJiFFgTsiR1CSNMzZ0afX7yTNXQ8PwRCMvk5sIZgWJBCzSR3BbVwFP
	 4NUiidmz3+yG6UopqcymsDnpSpgGOhTpPBfcUWjGVwvM4K6EVGSBbXpsTJxaabNV/u
	 hTVgVbf44FSrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE() for wait flags
Date: Thu, 10 Sep 2026 21:13:12 -0400
Message-ID: <20260911011313.4034971-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911011313.4034971-1-sashal@kernel.org>
References: <2026090939-defiance-yelling-974c@gregkh>
 <20260911011313.4034971-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

[ Upstream commit 08e72a5ba1ab9dc0adf993ff0f4d606a1e3445a8 ]

Use READ_ONCE()/WRITE_ONCE() for the wait_event() flags (done and
wq_buf_avail). They are observed by waiters without pmem_lock, so make
the accesses explicit single loads/stores and avoid compiler
reordering/caching across the wait/wake paths.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-8-me@linux.beauty>
Stable-dep-of: e57140944b5a ("nvdimm: virtio_pmem: refcount requests for token lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_virtio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 75183a177d75d..4f40cf85feb40 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -24,9 +24,9 @@ static void virtio_pmem_wake_one_waiter(struct virtio_pmem *vpmem)
 
 	req_buf = list_first_entry(&vpmem->req_list,
 				   struct virtio_pmem_request, list);
-	req_buf->wq_buf_avail = true;
+	list_del_init(&req_buf->list);
+	WRITE_ONCE(req_buf->wq_buf_avail, true);
 	wake_up(&req_buf->wq_buf);
-	list_del(&req_buf->list);
 }
 
  /* The interrupt handler */
@@ -40,7 +40,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 	spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
 		virtio_pmem_wake_one_waiter(vpmem);
-		req_data->done = true;
+		WRITE_ONCE(req_data->done, true);
 		wake_up(&req_data->host_acked);
 	}
 	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
@@ -72,7 +72,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	if (!req_data)
 		return -ENOMEM;
 
-	req_data->done = false;
+	WRITE_ONCE(req_data->done, false);
 	init_waitqueue_head(&req_data->host_acked);
 	init_waitqueue_head(&req_data->wq_buf);
 	INIT_LIST_HEAD(&req_data->list);
@@ -93,12 +93,12 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 					GFP_ATOMIC)) == -ENOSPC) {
 
 		dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
-		req_data->wq_buf_avail = false;
+		WRITE_ONCE(req_data->wq_buf_avail, false);
 		list_add_tail(&req_data->list, &vpmem->req_list);
 		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 
 		/* A host response results in "host_ack" getting called */
-		wait_event(req_data->wq_buf, req_data->wq_buf_avail);
+		wait_event(req_data->wq_buf, READ_ONCE(req_data->wq_buf_avail));
 		spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	}
 	err1 = virtqueue_kick(vpmem->req_vq);
@@ -112,7 +112,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 		err = -EIO;
 	} else {
 		/* A host response results in "host_ack" getting called */
-		wait_event(req_data->host_acked, req_data->done);
+		wait_event(req_data->host_acked, READ_ONCE(req_data->done));
 		err = le32_to_cpu(req_data->resp.ret);
 	}
 
-- 
2.53.0

