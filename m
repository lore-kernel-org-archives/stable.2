Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C43126C0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089201; cv=none; b=P6jzB+WQxXueFSTbLlxQG9U1g2dXx775TYAg20Z8KOy5G1ia04AdIDbZcVtBo7yYIE+sMhK5AEXIMa3ixMEGlb0vRWn5z9UvZnfogNOl0Wi0vwfdGJrxAqIuPvms0fv04gd9eD0LgwSl3800eqTvvBd9vUV7Sn9nqDtrJ/Gpx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089201; c=relaxed/simple;
	bh=hKoPSmVbNuoB5tneYMPagnfHIYq46LxqvBXRT4iub6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaeEMM0UQQlP8h9QDMWjo54fVW2gc7mCqXNaMggiLc18YtHfGHv6VlhgcskWI3jMYVG7QpPNFLrZb18wWqm7xFshpZW2BrVzaFo25V24aUS2+aqkmGe5utPnDcHsQ5cL7i5RQOddN6P+qlbnHotqMuNlXwJpD6FGzTx4Brbrb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4LxidvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4LxidvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A28C1F00898;
	Fri, 11 Sep 2026 01:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089198;
	bh=bH7QeetMspUWd2eHzLolC7tw9J9caB0I+mwYaP+n6Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4LxidvPuIxMZD2T+060BjTVV5AdGCxCXEUE/JUMxIPvTXODAvw4ejk41pt+i+Cx0
	 xw0xNMA/Pe9O9bh0HanilgAQKk2upolNADjAWRQt3OnVoucnLMiPjOP/H1aREzs8Um
	 38LoKFMLrtAFHDIHx09cLQ/UyVV2bh622oyT5SXFHx9b1Z1cHe61R3rirdljRGBXKm
	 8aC2nZK0u1RVVJujifbP46Mn0hqtV+Rq9MI8OveVPZIPeBGe+o9HSBfepupeLyRKYX
	 Um13wGsU/9Ajm7FaKzAUK7pfg9a7gcdgwhQqnpsRLsOJTCJbW8R5HHgON9pDszFvt/
	 osEfbeZM5SeAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/6] nvdimm: virtio_pmem: always wake -ENOSPC waiters
Date: Thu, 10 Sep 2026 21:13:11 -0400
Message-ID: <20260911011313.4034971-4-sashal@kernel.org>
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
index 8e16b7780be1a..75183a177d75d 100644
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

