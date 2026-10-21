Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596587;
	b=N2Uu0xvtyTy6x1UEJu5PuDgyi0YKs2UhTvHapObfLC8T2gYjmpoonXwzkG+XN2IJjDgQ
	 VkkcLSJ+KoUNBbEal3hnceMW56CvJZaw1kM4pvy43bp4F9mbazgGdG+I6sTHJftz+JPpi
	 /bvC84M3w/m1gEcnkbhLJbPeaCyi+e/fdhzWJZ8gIeIc591H5tDOhwSBsCk3DyC8zl7mn
	 jOG5tJZ5SNEEypJkc4Un9uxeW1xYPdzPQNxxgdOEUrnRq9pQ11e9B5qiG/jce98eqIHHD
	 cOwNClH9tRmOL/aJdSzy7hnuRmRLL90pzLt3C80WifpvUV3G0g8GMgeW0kS6olnwUhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bVldUKnQczsU78lKfuVdy5M0zS1UPWoE/ZRkKJN20Oo=;
	b=1IVnUvANp+zrxGEJkfJU456rtxil7pQkDLE797j0vhPaOLZUZ/2k0VyCCUrkxVFNShxd
	 IDByv6Yz9HFq/8lXRUOuE9BmYneA9EBcbQL9yszNaBeYzkWFNR2MCtoRdPsN4fncRrg+/
	 oAIyz1hM9qr3sZe148mpMAbqQIYqD3z33ihk74kUMbBP0m+GCFQo2r4FEtf2Z94PYamnv
	 p09JgY3WKQau34OiFgSF0Y3GugMwmfqiM2cYXD/bb3T4buBPXq8KNyXaKqKeReejVMmr/
	 0F6XZKiT5gzW4NJwwypW0oYjvIrcBNZZMAdxrBWVJBbn/iOQUimZ5LnOCOkMuJNohSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxo6v+pm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22C606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxo6v+pm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD141F000C2;
	Wed, 21 Oct 2026 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596587;
	bh=bVldUKnQczsU78lKfuVdy5M0zS1UPWoE/ZRkKJN20Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sxo6v+pm9ckoyh+jROQlp+Xr65gLP4S8eCk2FktlrSM8FkPTfvvZ3gWxUaIDL/lTm
	 jSzDD2kubeO6ufADwGBAJ8atyCpyqJxSWloTozwX62wFBvVy481QRpQs+uUlUaQQ0m
	 hqBJmKK5p3Uf4yI4N2huRDj56KdgVAekpXXsQXjpxhG/KXkGO8Mw5ypAjMy/Fbwsn+
	 iab80+C5f6w0bpfUSMKMb8J29xFi73RlcTbs38snoPvDEU1dHK0PkVPWEw+Ex+xwqs
	 zMa/n/pd67BhI7SgQI/JGy4vaNg5mUm8x/Cghlpc/t6+g7kDpwq02Vdwt/vClWxHgu
	 Dq0u/oDWHeb4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer
Date: Wed, 21 Oct 2026 11:29:44 -0400
Message-ID: <20261021152924.289040-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102119-suffocate-expensive-8655@gregkh>
References: <2026102119-suffocate-expensive-8655@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: K Prateek Nayak <kprateek.nayak@amd.com>

[ Upstream commit 547476063e123e73fc3aea8432104ab092ffea84 ]

Use pipe_buf() helper to retrieve the pipe buffer in
post_one_notification() replacing the open-coded the logic.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250307052919.34542-3-kprateek.nayak@amd.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 5e531d62f1f8 ("watch_queue: Fix note pool publication race in watch_queue_set_size()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watch_queue.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 6d1936fb8ff02..5da67a1047d00 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -101,12 +101,11 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned int head, tail, note, offset, len;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
 
-	mask = pipe->ring_size - 1;
 	head = pipe->head;
 	tail = pipe->tail;
 	if (pipe_full(head, tail, pipe->ring_size))
@@ -124,7 +123,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	memcpy(p + offset, n, len);
 	kunmap_atomic(p);
 
-	buf = &pipe->bufs[head & mask];
+	buf = pipe_buf(pipe, head);
 	buf->page = page;
 	buf->private = (unsigned long)wqueue;
 	buf->ops = &watch_queue_pipe_buf_ops;
@@ -147,7 +146,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	return done;
 
 lost:
-	buf = &pipe->bufs[(head - 1) & mask];
+	buf = pipe_buf(pipe, head - 1);
 	buf->flags |= PIPE_BUF_FLAG_LOSS;
 	goto out;
 }
-- 
2.53.0

