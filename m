Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314658;
	b=BWzUp14KZd+4DnYFFWg77YJpAyMRPRs5YDdzHjBDYIABM8TesP4IOZZLr0nLqlzbrCk8
	 2OeraVLZMCi7cO4cir7GUExH4CpRQHlvy0uBEl2RXjJw2api83a/X3pqlDcAU/rbf4Bs+
	 W/0z/My2YxilXXxPfX3AyDyOu+DtclreVPRzBvV2bovEQaf9FPIDsbeCFQfKEqs+oyvWY
	 8+NEDsKI6N8oL7Fs8uyddyHaMsFwH+jVYXGsgsU4zgQ+Ck95Qlx6bz7yF9NLl6LGK4LPA
	 FxXQNIXn1AKsoSF5N4tenr9xxMQOFygeAiiKq2tJKAAwAJB6KHkNpQMgnWMtgG/ihmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rUQdxBhN+AW/V9J408tsmx6ctX2hwymu4P11z5XJCtQ=;
	b=Gz0E1XJbGGzcBT2oiny+SbhYtj4XiwTJsfLGLkHzcPS+mPp+ZShzu2K8DgOhIIwa8if8
	 otUl2WoXotyo69YUlqzVaQ6at2YE8a1PIzpzzMrsJaUengbrxHrKu3MYjkO1uF6BiYfqN
	 Bkl0OrOGBxU1/kz9HPX9y17bBsq2GYpy7FT564lXZev3jkdhS84pre1tSB78ShU0nJ6zj
	 P7mqT7YrRL64KZuwYquw0xakf0lQppVrCedOmMpiOqWDic81OVerZNor5j0dX9ajORckl
	 T2vCqSDTkqbu5kIhWkYkyHehn2f4hJgC3DWh+t/sP7kDzLZ5UMYmxAkZwoF7umjQXFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAEr8PmK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE91606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAEr8PmK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380F91F0089F;
	Tue, 10 Nov 2026 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314657;
	bh=rUQdxBhN+AW/V9J408tsmx6ctX2hwymu4P11z5XJCtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gAEr8PmKStKcu2Ya6jf/WMe3Np3QKoOTXkhZJt2nfeW+XWGw146PNdw8BPG4MDDgW
	 zeklRjlqL2vrGO1zVnio7Z7qMC33iJXnVcIfrjMO7yot2tLBUHkuJuDPm5VKZSaqUo
	 2ceHd3ipmcTYHPCdfssRpKdWgxVauFLSm9eDWa34dq4j41f80bMXPzqWG5iwHtCcZe
	 YN9zMFTRFwYjRnUcY4UkT9qvdszGFNt/dRW1DJrAMeJVI/slXpYWwk91/6M09xefIu
	 OFjezm254A2PgT3bm1tNhojSA7DTmulidTDEyJ7rIiEf0KCt/fTTdtkglyurU/rN/E
	 SgChbpSSruhYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] crypto: algif_skcipher - rewind rounded output bytes
Date: Tue, 10 Nov 2026 07:44:16 -0500
Message-ID: <20261110124351.1434294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053242-failed-6.6-2f90facc7b94@kernel.org>
References: <20261107053242-failed-6.6-2f90facc7b94@kernel.org>
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
[ sashal: Adjusted patch context for the absent CRYPTO_SKCIPHER_REQ_NOTFINAL flag statement. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algif_skcipher.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 8729ef268d9d8..4fc077f31aa48 100644
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

