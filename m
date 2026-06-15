Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571339281B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558180; cv=none; b=fySLLhPbPt+gixkCyGiRr7U8UQZyIPFuLNh5M0Rei1b9HKjXe4KElNOz+xroH9cfpsnZ76J0rFozjWCSJQCgfHk8P+1G8gOYhAfWBZnzYFao5baeXWdovNEaokP5yXW7V27k6NkuCosENSOxTZvS8gVsE8hMVkXdoCTLAD9FBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558180; c=relaxed/simple;
	bh=9uy1hQvDs4JlzY6MvW64N8Q0e/7XjbI+v3ZeMDk+4hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5QKuKKKBO21XQGZSKuLDAdBFNCKylY2o6ObZUQc+sJC8Uvg25lzWAO27BZGCXVLLjO2QN7/yDfMKivQ+Kg+WT/RJ3NXDL2ebql6f2bdG78ncElehSLKCOvpMyvpuAtpQdVJO1qnXEsdxRGr5XSukw/97J1gwhmKCPibFPBU9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iALGy5kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iALGy5kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3795D1F00A3A;
	Mon, 15 Jun 2026 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558179;
	bh=alS9NVJSl56iNiyT2QvlkAZbequnmzFJyQmJ5fRded0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iALGy5kf6y0CVTAvgTNL7cSolAAj6IcjDp9M5YQN3bXENQ2qysEvocNfBa4mDu7DQ
	 TtK1+nXkCbBQ0Ht9U3BMbqtxVimWTwLhlQPWzA9TzqQy55ow1g7+SGGBkc9wST3c9C
	 Az/6yW+uKDjhKjxpCyDhvmAXPZsmOckYmoaagw7RerPczim/OBKj+ye35BON0v8k5u
	 qvShU7FQzNP18GyOOBj/RllHe71MQJgcE+/2cgthd9vYNaubRalrOl0mLrBoiHlgtw
	 rC6zQr0CBtaLXEn1gOBtyV1+nW2NgQFM+H/xe4UcIDmSLWFPcMcN9Y5UjmYbZAzs16
	 MszfWFxFtCJeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] RDMA/umem: Add helpers for umem dmabuf revoke lock
Date: Mon, 15 Jun 2026 17:16:15 -0400
Message-ID: <20260615211616.2460210-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615211616.2460210-1-sashal@kernel.org>
References: <2026061550-repaying-riddance-1fc6@gregkh>
 <20260615211616.2460210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 3a0b171302eea1732a168e26db3b8461f51cc1f9 ]

Added helpers to acquire and release the umem dmabuf revoke
lock. The intent is to avoid the need for drivers to peek
into the ib_umem_dmabuf internals to get the dma_resv_lock
and bring us one step closer to abstracting ib_umem_dmabuf
away from drivers in general.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260305170826.3803155-5-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: badad6fad60d ("RDMA: During rereg_mr ensure that REREG_ACCESS is compatible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem_dmabuf.c | 16 ++++++++++++++++
 include/rdma/ib_umem.h                |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index fa31a21a970da0..b239ac09ec2921 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -276,6 +276,22 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned);
 
+void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_revoke_lock);
+
+void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+
+	dma_resv_unlock(dmabuf->resv);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_revoke_unlock);
+
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0a8e092c0ea878..228046385772ae 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -176,6 +176,8 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
@@ -236,6 +238,8 @@ static inline int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 }
 static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf) { }
 static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) { }
+static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf) {}
+static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
 static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
 #endif /* CONFIG_INFINIBAND_USER_MEM */
-- 
2.53.0

