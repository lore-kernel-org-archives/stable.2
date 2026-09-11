Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F029B76C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086574; cv=none; b=O+1R6WPh4FOiesWCjfmkYa0SDDO3UvQM95cUyQ1+vzKbz0ILOedJ9fDLYpR3YiO/CiVp+yttERU1o+CyH/En3Dep5VFmqADL01XUDsqP3+3JvluM9mKriyNSsijznP0Rxer6LZYPJ8rE031KcsXJZyWXAEzr+eUoGNJvIB+PPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086574; c=relaxed/simple;
	bh=hKoPSmVbNuoB5tneYMPagnfHIYq46LxqvBXRT4iub6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDXgGscuR/iQ6rVp9FMweixPfa0noRUVZVpbZCeztZ4BvKXyN9I12rZRxMso/FuKufKSkRbsCrHQRD2BDNwJJ5wLwaznf6g7lpmLdngn/ibs+3uweG3g36WMXDLyMFXJ6fWlCk05KiapA1SQr6ESeoPi486+5cYbBHwjGNzPmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on9Ib2D+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on9Ib2D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928541F0089A;
	Fri, 11 Sep 2026 00:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086573;
	bh=bH7QeetMspUWd2eHzLolC7tw9J9caB0I+mwYaP+n6Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=on9Ib2D+z20xfI03z7fy5G7uUJWtOj2pYrXq2/EC7ggTjHvRDhygqt3Lhid8rbxFV
	 YX+b3dyt4yHCOgysfOiE+ULnUWDF/VN7H6YaYA8w+cBPdEIFsTJuowaJJgZgZwofYd
	 XYmH/50Ym0okHCiVJtbUF7BkLwWiq1OdUbVxpqZCkzcSEpzETImc6CoFw13iYYIyB5
	 O78PZaZwdpEoNWN5FXzh7Ur8r6vh1n5lcMVH+1iLsPzxCjEZ3am1DGJdwwEJqIhcSX
	 6nW2VhXhOiqbnn70elUpVg2pPK4kUjYFkVdPdy3tcFsMbF3GKPwYg/6Nz9mch6rXx1
	 cORR/xHViv1yQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/6] nvdimm: virtio_pmem: always wake -ENOSPC waiters
Date: Thu, 10 Sep 2026 20:29:26 -0400
Message-ID: <20260911002928.3429646-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911002928.3429646-1-sashal@kernel.org>
References: <2026090938-graves-stress-5791@gregkh>
 <20260911002928.3429646-1-sashal@kernel.org>
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

