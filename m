Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA643AF65F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558955; cv=none; b=Qkl+QPyL+pbl4OwpMoP5XP7RS7nRd8YZdA/BYNmWS0NEHSXuaVFqQ/zbPtkg7uQlU9kk/DptnNo9Kkl9kOTyEfqFZYqih9+uuTSjvqjP0HXcBrOhUcADfirYmRIZjkC2pKOxHxvR2UcSKb1CTBbWSsbSOHzN+nAs3n5cbFwPHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558955; c=relaxed/simple;
	bh=54qphyg/tOtrdLWzXwSOFwSwg6vZq92EhIomX94px5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPckgrWK/Bs5jDNeq9AiPJE3sEGp9+pn2KxfLM6judC657ZbkwpHEVyQrLDFkrKU5o59Bc1uXjkmZUAJG4LBuQcD4L7Aid5RhCM+P2VGpt5amdAmMj2Ge5a1zQlw1NV4t2FYcGfzC9v/y1fjvNstcxwAQGT7cU0iDMPligmM1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPioooNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPioooNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B0B1F00A3F;
	Mon, 15 Jun 2026 21:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558954;
	bh=EFsJSwhIFRtWtAJSg8rl4LaxynkrxSv0Eih5Q+LYrHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPioooNxIekV/3TjfjxxFcooxgNl77FGAQ0UoUck6fFhRaJmTsx1YChVRH16ULLoG
	 3uuaCyCEJkhH6aiDKL1vbKcFoNm/Da1BbOzkmY0v81EJo2SSyXAoHchFbjVb5WHIlM
	 cSqgyF8noE9kAogMZG71FjympWiy5Vkh24K+uYWXD8Eb/n3mVITFviSLeSB7CvUlN4
	 5W0QjAmheqEhzqXzI8rIKFCArBfx5XOZQPlkiUDEfeGlVa3xkIt4U+hKfkzHyEmKW9
	 sAy6cNw00ySZDt8Rf1y6NlOuMwhuxp7GYh3bUFHAz7uXQeEn4Rw0Qv1uxYlzXUp9M+
	 dGaHYMkxcX3ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] RDMA/umem: Add helpers for umem dmabuf revoke lock
Date: Mon, 15 Jun 2026 17:29:09 -0400
Message-ID: <20260615212910.2473729-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615212910.2473729-1-sashal@kernel.org>
References: <2026061551-manor-verbalize-74cb@gregkh>
 <20260615212910.2473729-1-sashal@kernel.org>
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
index be5977daafa1de..f16491bd5f2b11 100644
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
index 7dc7b1cc71b5ab..75f5acad646b43 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -159,6 +159,8 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
@@ -219,6 +221,8 @@ static inline int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 }
 static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf) { }
 static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) { }
+static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf) {}
+static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
 static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
 #endif /* CONFIG_INFINIBAND_USER_MEM */
-- 
2.53.0

