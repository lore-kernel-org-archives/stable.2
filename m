Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421D37F329
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091041; cv=none; b=SbCkEUDgA31XxV6Wp+JVPJ4jxlmXhvIlGHmkJGiBBnAV0/fNSdZfagggLPuVLFA9QUqhrFilvJGRlN6V2TnMVKV2tNn6BiIxP+8sCE8AifYYMI9VrtI397y4JKVAt8PExFGAIRHfoIyGpYLE/ImTBixsZX3Yk7pngszVbe5XaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091041; c=relaxed/simple;
	bh=Rlh3osSKzIbl8Od+t4a+lGptyeinRuKugcidhvkE2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bADpZEXaSG0jlsKlG25RHy280R53n8Z+y6gIdvBELRWfJEedf1u1vvCPyGe80XB0bSIYTplwBIkJMVTSL+cGCW4Z0MKkufzarjohcpM53sVrdSfyQ84DEArwgq+cOUl6wk+ZJI3dtwrZ7pq/kuPfdnHIPeNgttCZVwAf5O1FBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoRdLcRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoRdLcRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312C71F0089A;
	Fri, 11 Sep 2026 01:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091039;
	bh=PJUnrridjgpIN9HlYU5x7jjicKayBoYzW+hGNbppNdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QoRdLcRHcx6frCszv3MuwP+P5GAW/KUkJUwQxaoX8lqyr7vCL3hvfQbIzTtZnW0kp
	 BDpn3VIq09LG36xnYDn2iqp3j20NfFl4q2TCZC80ybOOgeiDd2Hx+Hi+oBnSFUGnX5
	 pWnkkT40/RzVO8CqVf3XFjwcf/tBw+VtlqnjA304MMkTTeOWsSUCK4JjjwrcuzYitG
	 9gJxerDxUh6OvKcmtXAOYq9ic63D8McFHlsIi/3UbIu+Uq2j2b1gQyd670OHNSW+f8
	 0etd7u26I0tnkdTOr6QegCdApFN9s5BmI0fi+bkEo1m3mshf0Js7n7sDE6zOUGlYhy
	 hjVJFzyE3m6+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] nvdimm: virtio_pmem: always wake -ENOSPC waiters
Date: Thu, 10 Sep 2026 21:43:53 -0400
Message-ID: <20260911014355.4149601-4-sashal@kernel.org>
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

[ Upstream commit 811808761e19fdea1c25b7c76734b8945f758f27 ]

virtio_pmem_host_ack() reclaims virtqueue descriptors with
virtqueue_get_buf(). The -ENOSPC waiter wakeup is tied to completing the
returned token. If token completion is skipped for any reason, reclaimed
descriptors may not wake a waiter and the submitter may sleep forever
waiting for a free slot. Always wake one -ENOSPC waiter for each virtqueue
completion before touching the returned token.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-7-me@linux.beauty>
Stable-dep-of: e57140944b5a ("nvdimm: virtio_pmem: refcount requests for token lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_virtio.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 63d420a7866f5..4b81544db4a61 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -15,26 +15,33 @@ struct virtio_pmem_flush_work {
 	struct bio *bio;
 };
 
+static void virtio_pmem_wake_one_waiter(struct virtio_pmem *vpmem)
+{
+	struct virtio_pmem_request *req_buf;
+
+	if (list_empty(&vpmem->req_list))
+		return;
+
+	req_buf = list_first_entry(&vpmem->req_list,
+				   struct virtio_pmem_request, list);
+	req_buf->wq_buf_avail = true;
+	wake_up(&req_buf->wq_buf);
+	list_del(&req_buf->list);
+}
+
  /* The interrupt handler */
 void virtio_pmem_host_ack(struct virtqueue *vq)
 {
 	struct virtio_pmem *vpmem = vq->vdev->priv;
-	struct virtio_pmem_request *req_data, *req_buf;
+	struct virtio_pmem_request *req_data;
 	unsigned long flags;
 	unsigned int len;
 
 	spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	while ((req_data = virtqueue_get_buf(vq, &len)) != NULL) {
+		virtio_pmem_wake_one_waiter(vpmem);
 		req_data->done = true;
 		wake_up(&req_data->host_acked);
-
-		if (!list_empty(&vpmem->req_list)) {
-			req_buf = list_first_entry(&vpmem->req_list,
-					struct virtio_pmem_request, list);
-			req_buf->wq_buf_avail = true;
-			wake_up(&req_buf->wq_buf);
-			list_del(&req_buf->list);
-		}
 	}
 	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
 }
-- 
2.53.0

