Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D07380FC7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091043; cv=none; b=JaMuYjyClIvdHEVxp9J4NymZupYJAELa+pp4pRdKgqzgOf+d8uF9V/WJAWu2WueLWhiGA2BGspEJDwNFsjK84UhnruxdcokO2HkiG1SFJqfNEX8hXLKeNktbFCLK1YtTbY0Vs5h/9FPQcHSFdxSh/DnCOPOI0zargzY9zBEtzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091043; c=relaxed/simple;
	bh=JCgCU67i5MmpmvYje9awvuCmPLvqeh4HVbP66BetM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3vSSZ5yitk5qgvnGXQIcru/lj+Gxahvs6/wNVXmDs94yRb3LvrhtIXDMXPB3sUbxRnv5Xj/Q7rNGrnJPG7leD5pEJipvV9H1cOr50ms8jwngpWNp59obPWrflFmguY8h7LYAJ9FrErVwcY3AUN2unfXHBoefoWYQFfOoqYGWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2OGq4o7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2OGq4o7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89011F0089C;
	Fri, 11 Sep 2026 01:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091040;
	bh=/TtN6eHeLLTSS9JwR2G1HLAGCROTsxOMyHDVTpidaD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2OGq4o7jIOWkvVjs+VtD6kf7Hn1zFH1Tw8hZh1EaSLm7ix0VWYd1RJeAQ1kayQVr
	 p+EzeD2ZkiBVU8Vyh6jiV9uz2aSpu8grL6Py1ZttndnNQ4gy3yOSFmDYeoDZHS/Fjg
	 Yn6TnopSoIl4yjDX9fgN3oE/jgXn2a0KWv8EtHftD2yHP8RdXe7BT91vdU3Awm0Opx
	 yZRsLS2ah9VT2bX7A4D//CqnibqnALDzBse06romrk4+dJr0rahG3Em9WR2Hxe0V1Z
	 HT6YeqfH0Beoo7JJuLdDhdIqv3gTYib20qbhFJtBq3RC8ExKB+fw/5Z+BC+3Bn0/6Y
	 bjNeZLpLhIfvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/6] nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE() for wait flags
Date: Thu, 10 Sep 2026 21:43:54 -0400
Message-ID: <20260911014355.4149601-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911014355.4149601-1-sashal@kernel.org>
References: <2026090939-disdain-corridor-626c@gregkh>
 <20260911014355.4149601-1-sashal@kernel.org>
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
index 4b81544db4a61..ce3f14d99eac6 100644
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

