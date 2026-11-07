Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048338;
	b=Xz3NHrtIU/GdhTMlhWo2lMxUvviL6sT6VY6Iqw01BU0qLwTNDuh8+kTDbOHKJLdGYZUB
	 kUsgFPuy9IBjl85W1f201r5T4KKy3mTsz+5u63fbEkc4DeGlQkO3/SfLelOFASnFGaxDa
	 yzZ9Fpx335kE5Xkv98qweqqwqf6jWllKDEVQtUpX45YBOtXMQl2cSkzzfEBGCyAL/Qnkg
	 rZNnOZ/toUVwetmhV5MSfySVPq41+9n8Aoayf/utg889ZmunFMF888YJQmgglwL34SHoE
	 4150jXkbLyGwHGIqDTP/RcL+JzAv8MFVLjgthKEFrhXwl2wEtowY5PUBu+rlgsGkiyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ygWGMKlG7H4rAgGfDZMtOo5O5YZu42HOrSQkSRwt/qc=;
	b=Y+6/S/PN09P8lPleU8M52HQZAaDwaNVQqSww4RXaUgUpDRzTK5zQgnnI2xwvTM+LMgx3
	 Y2naseu+nv3fuE0yAv+ftSMFfyUl5EJGBUOXcAkcN515VjW84Lz70Z0F4z2ZKkHsgD/La
	 do3iO7k/vQcJqAMkpe3VUboLgBsOpw2YLU/MFX1QvMZDbz1oE2PwVs70BmCzCbSBGDLAg
	 BaO7MA4tF32CzUZTDjGIf8hSmyjWqx21PiVqaXw5JL6DH0s/HyrWPboiWQ8RJpu9UjMZV
	 noVFG8k0XxP3tZKC3DlC9y450DaUh1pG2m3ncAVDo2DtYBjtEWLIyWJwiwB7hCJEZ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E92FiAfN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E92FiAfN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C41F0089F;
	Sat,  7 Nov 2026 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048337;
	bh=ygWGMKlG7H4rAgGfDZMtOo5O5YZu42HOrSQkSRwt/qc=;
	h=From:To:Cc:Subject:Date;
	b=E92FiAfNXtTfAf5Bpe6MsGBlAPJKDTu6aIF/ibx6DBfqxRdhEETXP/V0yEGBCEj1/
	 fQKZLYX9lnY+FxFIsgVa2IFAVi01Mt+KtQcyFIPXWciGoMPcospLDv2PadjKz1Ssgx
	 G5J4JXjO55pHM05gnxPSK2HEzNJG+f6Tx6x+u0szquu1uuVAaKvmNyIYsKYvIdkX/4
	 IalbUW2w3w5LIacmMmrkzTRyPvSqPceR7iGDO5HIAa4iG08nFY3AOiI8RoloRcQ0/f
	 4wO5TS+AtS2cNXpAwWnGeN96AwAQfwxlv7sVct9rfZPlmHRkKSlpFjmMGmIjoOjnoC
	 c8650qFX6RnzA==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	herbert@gondor.apana.org.au
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] crypto: algif_skcipher - rewind rounded output bytes" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:36 -0500
Message-ID: <20261107054535-failed-6.1-2f90facc7b94@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2f90facc7b94934653eb7ebfadcc25d503b89196
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054535-failed-6.1-2f90facc7b94@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




