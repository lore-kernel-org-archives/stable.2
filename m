Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6351891A9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086858; cv=none; b=qZ/SJT8VN9IU1D6H+udw1kPkuShG0yAUEeksbw+VjTOqmF+nBHyJxxQjH8rYAMVRNMa9jURw3rc9XtOLwsMXuuuxpmcjr50GI2vToSx2vc61HXqDqzoGCNggvdw5N2+V5T9y34j3R6HtvGPaCIN3rDnfinZbwonbWNUwpbPEHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086858; c=relaxed/simple;
	bh=7ctE6MOjll48+D25s0ViMyw/p4TWh4mqiU3c7iuD7/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nV7fezUgJmMThodXiU3qG908mwpi9jk/ma/Lzyo0sIx1kx4afL+JNp79RVR/SVFUn1NPAgFH0ltmZhHYFyhm269rCLN15cE7f+He1mhsBMdKwVBq6zUhNn+QogIt7ooANt4eCI1otjK4/xP1FLjcucr/L20W9FAqWdPinPG/cz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSzH29ZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSzH29ZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2531F0089A;
	Fri, 11 Sep 2026 00:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086854;
	bh=UAMvTsbABiGRVoOaSRfq6lSNQgfHd4jeox7utp0alTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSzH29ZC9H1lc6zX43fInWIfSfdCBXkXPmMDGszVKBMA+noUn0XGQUMVwz5MciJYH
	 8sFcKrm/yf9BkxiEC4fe/bnEDqNdwU3IkH5sciIyRRzGRE/L4zYLnL0WgrHTTJJGie
	 6anOxbh14ZzWJ/UWYjCBbEsrvrssjQemdag4KiczUSQD75jJfBz7sWJihiROOm+prk
	 q3HoILE7I++UBwGnx5AZJCONSygKv8OWLXmaG7tt3wiSP0AZTZSwCibkGr54v9wXQA
	 iAuhXge26KYxERzbq6qa3D9n+2r/O+WNHB1AWtaI8bTt9kt6O2lZNgThBAQux23Fj0
	 JYKxC9LgFmk8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] nvdimm: virtio_pmem: always wake -ENOSPC waiters
Date: Thu, 10 Sep 2026 20:34:08 -0400
Message-ID: <20260911003410.3483414-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911003410.3483414-1-sashal@kernel.org>
References: <2026090938-reliance-nearly-8ed8@gregkh>
 <20260911003410.3483414-1-sashal@kernel.org>
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
index dc6babb9742d4..0ef8a7820fea2 100644
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

