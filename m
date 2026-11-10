Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315026;
	b=0FjwsPUtqdlhnDkrPH6MzH4Rm715CDR2zQPPyyowg/zk/0vr+QXnjmHr6Mevf3vaeDDg
	 FlaiFZyxnSqp0OM9RKJxrjDEK2XjxwoWViULItJVOwA3ni69qG8qej4p6CrdI4EnH5LBh
	 ILWMNOdOiw1/iwnT6WjOxHA5QlOg9HrDeMLOdS0VuKgPmLiKWxplNnvYlrzMp6o3LF2sp
	 B5Wf+cDoarj+os97z5WGYtJRUYBsdiN+jtDDd7e9DAFsTSSSEirFUn7/uJH4yWlI23fLS
	 XLK8H7x/ptgtjYvovM9cHzmdzft0b18zeXUB9iqpEg3w/1b6mvPvTRZJC7b5pgScZzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vr4b8zS4CfToNfU8lSN7U7CRy2FwnQl252api3FF65A=;
	b=3ifFXO3KFxdDBU4/7RVw1uexIxgZAhs/jAC1sr+dxS1krx19pln5ADoDue41TWgkGh0k
	 PUFRA9VFXKwcv7/tgzTaSImIUr+e36sidBcS/J4NgWtKjbYjZXyZgph2t5+s+efgqB0O+
	 A2MPwMON+vUZU+0gIkUm2UxfA9SUcrVcmv9qrVuEKJfwvRbhwsryszRGbwoHi34RXn7Gx
	 O0Qkw9mTUrO/j4IgkbLwDD284LwFWjubzEl45MqzGqqudsr9w6yzoJR9TRbh8BlABA1li
	 vfoJomeHcmzwemac59AznuMZIP8SI2gjKhu1fH5QKC3pfGhztDzJ6Dv0M1fVmJARYgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB+MExd4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E8606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB+MExd4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6051F0089F;
	Tue, 10 Nov 2026 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315026;
	bh=vr4b8zS4CfToNfU8lSN7U7CRy2FwnQl252api3FF65A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VB+MExd4AXz7z+y1RSi47toMUvrNG9T6+IzF88ngZrwKI0aCp3AIX9ei71/AoR7R1
	 PYVv7Dqp5Bea2pba/dJKLaxyHH4CQWNPz2A/dN/T3cmUYoHEBW3sZdfEWY49h8nS5k
	 836Hj+LA/dGLGfBWK9xosF5MZcBfLoSfPzLxwfAh+j1a4yq67idOJhaeszpvn+Jw40
	 xRxSCoCZvYDpLOyBF4HRh2ft6xZeDJicDquD6+r9ihz97Ld3KY0V7U9Or3cIXP1usn
	 xWodWoW3a1r7rpZW/2VA34ZmkXrAsqOTdxVaP2YYRUzpzF4W+Jar92DHdLZE+wgFM5
	 Y1tp/KuCo0rBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] crypto: algif_skcipher - rewind rounded output bytes
Date: Tue, 10 Nov 2026 07:50:24 -0500
Message-ID: <20261110124956.1532643-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054535-failed-6.1-2f90facc7b94@kernel.org>
References: <20261107054535-failed-6.1-2f90facc7b94@kernel.org>
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
[ sashal: Adjusted context to account for the missing CRYPTO_SKCIPHER_REQ_NOTFINAL assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algif_skcipher.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 0fe62be7470f2..c037c3969e9d6 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -83,12 +83,15 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * full block size buffers.
 	 */
 	if (ctx->more || len < ctx->used) {
-		if (len < bs) {
+		size_t excess = len % bs;
+
+		len -= excess;
+		iov_iter_revert(&msg->msg_iter, excess);
+
+		if (!len) {
 			err = -EINVAL;
 			goto free;
 		}
-
-		len -= len % bs;
 	}
 
 	/*
-- 
2.53.0

