Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315994;
	b=d3mkPdiAa56gHdI2xEvEFQA0aoZqUzQlSSyV4zznSHYfL5NYpO1yByg8c3dspt9COO2q
	 8ND9nGqaFpxZGcnneI2wlbl1NsSYDFltq8XID1gziao844cUr2uhfiUDIIghEyuiYeBcL
	 iqlrXj510fn4OBPabPmyOvtXTrvV5F4h38ToseK1wa/a2gmfufCfUEmhycg3surXe1rlZ
	 tWm87/AlFFBttPKjCNy5dPLAZD1WW0TGihq4Y/KiPseKiwunMJbr/ybe8COP6srmx0PWx
	 BFnwkLkukTyzReL6FpPT+lhCNTRcvmPMK2o+w6dGiEMKOGAZ6GIwmQBRN/i16gIg22A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uLyalODT0zKL5/shmBpNLCmTN03YOum3+RCRPhPlJ94=;
	b=ox8P6ZDX9LV1kMfgzuaH+PK31mifPkJinAc+RvcwOp7zi8VrjAEJdcB2Uhz8U2dB8Hfp
	 z4q1YXZl+/NSW5mr79/xx4fr9AzxwKo0S4RIHzHkp68q1gtR1co3psht61R90iOxbTqlu
	 bRcoiDTYZ+fF7TQaSRj9dFkc+dhZjDu058MQfxy9erL+P/2TtjdS1I3suSTllvO1iEFij
	 IeGvfKnjLWv/U1fX9cMeqVWTmLxdOt/Kk6lDmOijcc+vQaFUU1Mp/B6YaB8iUmg3NrVgH
	 9mgSX7xP5kQxfrKfCRX3CJR3yqzijlsowF+wxIWM+2sSDHRB2zJMneUOhSFgVfzVd4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ems3wtaS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80170606A7D6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ems3wtaS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2321F0089F;
	Tue, 10 Nov 2026 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315994;
	bh=uLyalODT0zKL5/shmBpNLCmTN03YOum3+RCRPhPlJ94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ems3wtaSoE1fyfnedBTbxwiIvajZ453RuBmfyxfG0emhJzbKxzJdP2T67E5g9Uz4m
	 IBZLk0cJ499mIZVitRc+BMdiYoizQY0wv7iWOEa6A74k2zAmzZiqUzujGWT/UoDJgg
	 6PIXAxbWVAsV0YKrt+9yXBeKRDYSzTxpStUvN9kNy8ZKrlSZeO3qCTmcc2WqDHrYHM
	 Hj51th/eikWZhJ8cALptBDy9voUsE05lgZmgKKk4WzIWEQY496GA5K23C+29iYx8O2
	 k7fmR8IFUat2MvTIh0qiBrB/Gy+Z0f6jQOOTE8XhiAswvY8GyztgltT3b6YsztOWZd
	 fK21LL0abRIFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: algif_skcipher - rewind rounded output bytes
Date: Tue, 10 Nov 2026 08:06:32 -0500
Message-ID: <20261110130552.1648939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061933-failed-5.10-2f90facc7b94@kernel.org>
References: <20261107061933-failed-5.10-2f90facc7b94@kernel.org>
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
[ sashal: added the zero-length guard where no short-input check previously existed ]
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

