Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050376;
	b=iepePM1C88MQhqqoChz6mhv+0jBjxp8FxV2eiBqR7y4saeE/R9ub+3K97O/dBOOs0fQU
	 vU03RkZvCzrEUEpwc0urbH5nA4ua+QD+ZhxETvojxvvcghOuthtcW4SB5PW+ciyySZgLP
	 s1PgGchf/QuMUdPK8ozifJnbDoE5hYj8eVeWfXEUtFTnrzh0E4kfa9EPPJftcbIXxbYbT
	 zIgafhohgexCZcFqqor+8c4ZunzfwABSS27nGhoQ8KRLffhbClLOQgpKQjkUFoi2boBWC
	 dbM8KQqxENUxLOUJjh08Oyq5Jh93uwQbvbpiak5tmMe1v9EVTeqORLLGuhAfUklSeMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z9lpd7pY+LoJ+M/46ZlsWto746shTrQGXyvxjJuoivA=;
	b=oGSD3zMkS5N/nAWJ13emhLrZ5OcLLYfNG9JUCct9bZc9zFc2rbl/zyOulrGjUbGvkyl5
	 RDhYAhBUfTAkwC65fIRbW5m/SmJ2aKgzo/e18ftmOqvrfifd5CzTwgoqIkxtFAm2OIZz2
	 S7Lv2BTdRmiBCM9SzzxqWQhla7dtfUUQoSfGXM1MprUaiA3dKqnT4e2glGKYuXEEMgSbl
	 a7F+6pmx7XZzqdR5rXVguCdqZEsmo2TnKoFAOULyNhM3R4TKlM3Dl9tw8kuTmHEt/6LJi
	 rXBJW3UPjV0f4TI0AFc141G784+v2tezD/z5T4iXqVwYDlCFFNxqUmEMUFaJqPrij/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BH3Xa/JG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27506606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH3Xa/JG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3CF1F0089F;
	Sat,  7 Nov 2026 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050375;
	bh=Z9lpd7pY+LoJ+M/46ZlsWto746shTrQGXyvxjJuoivA=;
	h=From:To:Cc:Subject:Date;
	b=BH3Xa/JGsslXUF0lMLAZABmGobXNMaDECm9P5iV2Ywi8A37nceKCFnCZRPkcRfwf0
	 yKz+frGGBlGkwhz8vShJoZWOXz050pG7zSzvNbfJFE6tADnwEL9XfYk1SWQrPxW0jw
	 YG6iiKD+v2iKlk6iw/KZ/htgpbcehRiJM6vhR4j+hWXyaNnfb5bojrA7MFrmwuWw7Z
	 jKRbKj/g5FCQhM0k8YypY8Nu4QwYn77nJJQ4ZkgW2pVGa3dYpHYDC5+6wWyG0LUGf2
	 oCPDYwZxvNRRrnfOSnoHi5NH09Mj2BRVFzIjlFCEilnAVaL2qcNLm4IxxK9fvOY+Z3
	 qvqDcfYlIuUNw==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: algif_skcipher - rewind rounded output bytes" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:34 -0500
Message-ID: <20261107061933-failed-5.10-2f90facc7b94@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2f90facc7b94934653eb7ebfadcc25d503b89196
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061933-failed-5.10-2f90facc7b94@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2f90facc7b94934653eb7ebfadcc25d503b89196 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Sun, 4 Oct 2026 14:09:46 +0900
Subject: [PATCH] crypto: algif_skcipher - rewind rounded output bytes

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
---
 crypto/algif_skcipher.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 1e61fe6e24b99..291dbd6989325 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -135,12 +135,16 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
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
 
-		len -= len % bs;
 		cflags |= CRYPTO_SKCIPHER_REQ_NOTFINAL;
 	}
 
-- 
2.53.0




