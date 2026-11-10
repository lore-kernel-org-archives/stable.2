Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315707;
	b=MlJr46PzQo+OYgsLArYyDy3plcPatYhtzREkvHJWJwKEzFVfV/Q4+xjL7b2dWiwcAn6h
	 mYv1andZQbFxR/ZDr5FWXbZgOlK/SHZ29YBqAeG3TIxFdhBZP0NldP7onuPUwGUhtemZe
	 IiVqetgAhbzjtMlmzYMKbGo0D1QVQeKYSTxjbbALmMNrAUKZgKrYINvDMSkZR9qeM9QuU
	 jQ3jjJ0yPeQj4jHbObGhfQAvT29+DiSOyv8oOnHmVNVPFy3Ky6Q1hNp28Y6OUxf7IgV82
	 iBM7GUOIxfq7UpT4GIkNjfQueF3U3Mn/ClJZwdCXl9wZ1XC5rweZPF1AiPzECHr72Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xpZJ4PDVOKJCFKkXAvSJaZyb0hzkItV0E7HWgCTch0Q=;
	b=INDHVixN9Xtr1GSiDU/65sDAOjk+PaL8K4DNRAIKePynfz7LXaJzjM/YDhMi6kmuJs4/
	 IkFZupJ6T2wTBdYdRMo7dwHlwe5ZmGNecuqZa762GRmTqg1U2RSTJZv/IoLnQO6nZ4M0v
	 Q6Gz3lCMOTsUOeMDDH1tHxCEti4hXP08hzxS2s3qKTB4PQfGk4MDWtSkfzYCBcfGq+9F+
	 bgScGgytFDyZIzTRau6tlCkLRHbQmogFDqw9Ca2x7cxsefA4hF+cgTf0mKiPbpEKeC7Lv
	 h5ZyiMAoTWtKZOjKhA0q7NWYIO4J+MNbCSuK9F9X8s9aAUs1lwHWJsfepiitxHwgjig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHF8Kh87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD78606A7D6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHF8Kh87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2701F0089F;
	Tue, 10 Nov 2026 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315707;
	bh=xpZJ4PDVOKJCFKkXAvSJaZyb0hzkItV0E7HWgCTch0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHF8Kh87ev7D0rsO/a2KSRrDkeGikQoh+jlF+ZDJBdipe7fBEcsYfOIyQKhHIRLmC
	 DYmc/gHQ3NkNeGc+ymHTb8fZAIeypv3Rhojk22i28aGHm1oHXp8Ke4Rh7WgivhJhiq
	 j7fqRP1yL5iHWH0MDNvm7doEN4rAilCZ89d71b5tXFtXp/rsxWz+u6JMYjG4PKFa4I
	 xWEEDJAYty3hF80NF3DgUcPUzdiw3iMxEn1/xsPHCZJLtjGgFw1uu25hGVpSfQDxCN
	 zFQpp22VxicjzmqQb/zZjuuw9KQN2pMDv01aruXgRirBElHLqnMAzJ/075k4I7VBbr
	 X3XXEhSwfZJVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] crypto: algif_skcipher - rewind rounded output bytes
Date: Tue, 10 Nov 2026 08:01:45 -0500
Message-ID: <20261110130122.1545220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060252-failed-5.15-2f90facc7b94@kernel.org>
References: <20261107060252-failed-5.15-2f90facc7b94@kernel.org>
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

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit 2f90facc7b94934653eb7ebfadcc25d503b89196 ]

af_alg_get_rsgl() advances the receive iterator by the unrounded RX
scatterlist length.  For a continuing skcipher request,
_skcipher_recvmsg() then rounds its local length down to a whole chunksize
without restoring the iterator.

A later chunk starts after bytes which the provider never wrote, while the
syscall returns only the processed length.  When copy_splice_read()
supplies non-zeroed pages and publishes that return as a dense prefix, the
gap exposes stale bytes from a previous page lifetime.

With unprivileged xts(aes), a 31-byte MSG_MORE request followed by one
final byte advances a 47-byte destination while returning 32 bytes.  A
hardened v7.2-rc5 image retained all 15 seeded stale bytes in 4,829 of
4,829 records.  With init_on_alloc enabled, all 72,345 gap bytes observed
were zero.

Rewind the iterator by the tail excluded during rounding, before rejecting
a zero processed length.  The crypto request uses only the rounded length;
af_alg_free_resources() releases the entire RX list before another receive
iteration.

The fixed target-like kernel returned byte-identical dense 48-byte output
in 4,771 of 4,771 rounds.  The unmodified kernel returned the vulnerable
32-byte short record in 2,409 of 2,409 rounds.

Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ sashal: adapted the rounding block to code lacking the upstream zero-length check and CRYPTO_SKCIPHER_REQ_NOTFINAL flag ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algif_skcipher.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 6a1a71284fe82..c037c3969e9d6 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -82,8 +82,17 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * If more buffers are to be expected to be processed, process only
 	 * full block size buffers.
 	 */
-	if (ctx->more || len < ctx->used)
-		len -= len % bs;
+	if (ctx->more || len < ctx->used) {
+		size_t excess = len % bs;
+
+		len -= excess;
+		iov_iter_revert(&msg->msg_iter, excess);
+
+		if (!len) {
+			err = -EINVAL;
+			goto free;
+		}
+	}
 
 	/*
 	 * Create a per request TX SGL for this request which tracks the
-- 
2.53.0

