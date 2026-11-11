Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413997;
	b=nSPmANLdwcBIbqanapDALzvSLDm3/+GDLCFOuKLRhZ0j1atEmQpQz18ITMCKarl5l+zQ
	 vUtIK8hJw6jDHDNuJV+HjMsem2IXvdcISzSW/4WVw5tbmXQNR6tuwViKmUzFgWAVxknT3
	 qceKxDc/VwyklS5U6sPIhGI2ppckUuQ1CmXENfZf7ORBiIOW0XKfvhGQkAPjnb03ZYkbs
	 5NewWBE+pbk76TDMxoH/NYV6f0lGX5w8dBfwPpO4ok/TQsOCm4SaJZp8cXDhOWyMaHWxH
	 1AfEYHiKVxKnw9O7hk8Vnk5cQCnXWqhLLbE7X/TijhFQ7oOwyLoj3H64evB2A7hc8vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413997;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kkl13wWc7o/i0IUzuhsbclB1UChE0NN7Xi9zt+/bn+w=;
	b=SM4OAQe4Nn7G5evpMfrre317b1bnW3RFmxEHHKl8UxaH1Y1vDr5t7rRO7vroraAVQHQ/
	 uYlJsCUcuDVk5wIPIubtD4186eEcpauwjtaWk48LwOJ7nmwiUF0+Nd/EEBzvuYDF8TsdT
	 +jncTU2l3REeRn7TDlzqP0zYzON7L2KQScHzmW17VBFZcq5/6HvgoLCppWnvg9uOgIMAR
	 XMTJhCPWMMoFvCI/qTIxWaimRzs5LDAqewW4mA33E78eu6JHIJq/LS4HWYM2p2vBx4Kd9
	 pN5M04o3rJ7mO8dO1iv7WBR3Xz64h1OgUpZMpDETRi49q02Yp+cujGv8lRUefunawRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYaxwz2E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47C60A263C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYaxwz2E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1EA1F00A0F;
	Wed, 11 Nov 2026 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413997;
	bh=kkl13wWc7o/i0IUzuhsbclB1UChE0NN7Xi9zt+/bn+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYaxwz2EoGaCicXIBlCxpBhjP/DpK5B/Sk3YkZCQ21ME2CeB2wSdwj/S2N41//z7M
	 bXiyot52SYzp5WGamyz61ZFGXmhGXoPmSEFKyGQYYwJX0k8Lr2ZhiH6hTNWXwPXVz2
	 bmbXf2P2wZsxbytkiQoP7tjFX1rQL7PoM19ON7axN+YxfjN2jqrhlfDR+BTfxBLX2+
	 rR0gTAGJgtLSyZ+ENkChhZiwXdq+w/dDzvchUtl5B4xMfd5IJ+Gl8dpK7l6r/m2vd0
	 xAI+OqDJ8WD3jMJF0tjKwVWLBBbOkXTUpyK9BpaVcS+7f7Rmvov2B2vu93qVmxAJ4i
	 IMtVyD1UOBDWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] do_splice_to(): move the logics for limiting the read length in
Date: Wed, 11 Nov 2026 11:19:52 -0500
Message-ID: <20261111161949.3187571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063106-failed-5.10-79b496ebe382@kernel.org>
References: <20261107063106-failed-5.10-79b496ebe382@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 313d64a35d36b4bb00edde418179ff1a5f342070 ]

Both callers have the identical logics limiting the amount of
data we try to read into pipe - no more than would fit into
that pipe.  Move that into do_splice_to() itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 79b496ebe382 ("splice: avoid stale f_pos writeback on error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 5b15c25f30527..070b192b56386 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -774,11 +774,16 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 			 struct pipe_inode_info *pipe, size_t len,
 			 unsigned int flags)
 {
+	unsigned int p_space;
 	int ret;
 
 	if (unlikely(!(in->f_mode & FMODE_READ)))
 		return -EBADF;
 
+	/* Don't try to read more the pipe has space for. */
+	p_space = pipe->max_usage - pipe_occupancy(pipe->head, pipe->tail);
+	len = min_t(size_t, len, p_space << PAGE_SHIFT);
+
 	ret = rw_verify_area(READ, in, ppos, len);
 	if (unlikely(ret < 0))
 		return ret;
@@ -859,15 +864,10 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	WARN_ON_ONCE(!pipe_empty(pipe->head, pipe->tail));
 
 	while (len) {
-		unsigned int p_space;
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
-		/* Don't try to read more the pipe has space for. */
-		p_space = pipe->max_usage -
-			pipe_occupancy(pipe->head, pipe->tail);
-		read_len = min_t(size_t, len, p_space << PAGE_SHIFT);
-		ret = do_splice_to(in, &pos, pipe, read_len, flags);
+		ret = do_splice_to(in, &pos, pipe, len, flags);
 		if (unlikely(ret <= 0))
 			goto out_release;
 
@@ -1086,15 +1086,8 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 
 		pipe_lock(opipe);
 		ret = wait_for_space(opipe, flags);
-		if (!ret) {
-			unsigned int p_space;
-
-			/* Don't try to read more the pipe has space for. */
-			p_space = opipe->max_usage - pipe_occupancy(opipe->head, opipe->tail);
-			len = min_t(size_t, len, p_space << PAGE_SHIFT);
-
+		if (!ret)
 			ret = do_splice_to(in, &offset, opipe, len, flags);
-		}
 		pipe_unlock(opipe);
 		if (ret > 0)
 			wakeup_pipe_readers(opipe);
-- 
2.53.0

