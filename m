Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620089;
	b=PhId4iympC9nANyq5atLeEpKYBNss37fUGdQuC0P3uRJnurK6Hs5gn+dGJjHSP+B1mLM
	 b6o8nWeMJ7mJZb4rLEP2OwdTOihwO8AZMQKGhYcbAyJiyGI8dMvIsuZPdj1njjkTol2V7
	 SCicAmUd1kKjP3vA6AYxMKjLVqJIuQMw+jl42eVcmvEoGXUx34wVnZXQRrVHpMAjALSJQ
	 YtshwASRji5kCTalEspzxLkrYZuZkCASD61ivt75vq4IGI0WmJH6a3XxG7L5O1Xuofu8i
	 WNa2R+8YvfGl6TarXzmwsMdAxTMT16VRis5AAfc6SipATX7JNAdJfKwN8BH+SE7n19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l+gugUjJQh1gij8yZSii87A8/QKvBOnZzHfcWdJtUi8=;
	b=iwZrT18TSdq3jhDwDPzrqUe/+YJilTazryezHSvlZIHQ0BKenDsOzXYVXjJTbSQgiP34
	 MOYqVyhz2SygObkP0ycW8N4za29ckeHaeTT1V0lmfjrwerqgIgd0xGBrU7AukyZj4mccr
	 FFNg1qDbrYsDolvGP7FBA+gVk05Kz6jlnHtw4v5nXU0DQkHiLASkzGi8Wxwp9d+224XIZ
	 5reTacwOHPlgaKShLp2RsdHfwLqU7vtmWpfCaMKYsSo4CBsoKcpDCsMNiwGCynlRDFkGe
	 fuETleoK8nra+EXzW6ceJZZHpnPjNevvHYVY0Qq0MVxeas7IJuEkocF34mQBXKF5qpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1palxES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BB606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1palxES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C946E1F000D0;
	Wed, 25 Nov 2026 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620089;
	bh=l+gugUjJQh1gij8yZSii87A8/QKvBOnZzHfcWdJtUi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c1palxES9tfKYGnOfe1rD50tmViODszSYg9n9M9CMGWYKUp2ByLRlnEwRviTkWHBo
	 g+ZlSBT8uiyAN69LVHGQNYxng1PbJ0RPy49/tk6mU9FukPGPBiitLGm46YO3uiOrvs
	 ozbZkCBdbH3+/kWddyJCbDoi83g5VyldOkoUqlzTBfESQ6sgaBhz2K2EDdSrfTIeEx
	 fvgvWouv/BBXy30Xh9DDyvrMTA5fbyXQ4kRJz27sk7Lsf3Ek6gooJ8OKCOf6igsHD5
	 T5ZINgVSaGfdcZcBDEjKZVVuogu50vZs30HAlv1VaLkP2kCocamwYRRtC9CtRbunG8
	 NOI4xv41HGoqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] xprtrdma: Replace rpcrdma_mr_seg with xdr_buf cursor
Date: Wed, 25 Nov 2026 10:21:24 -0500
Message-ID: <20261125152042.30755-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125152042.30755-1-sashal@kernel.org>
References: <2026112558-goofball-gear-57c8@gregkh>
 <20261125152042.30755-1-sashal@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 7a079ab57c4eeff241d9abfc1ec6477cb90a6206 ]

The FRWR registration path converts data through three
representations: xdr_buf -> rpcrdma_mr_seg[] -> scatterlist[]
-> ib_map_mr_sg(). The rpcrdma_mr_seg intermediate is a relic
of when multiple registration strategies existed (FMR, physical,
FRWR). Only FRWR remains, so this indirection and the 6240-byte
rl_segments[260] array embedded in each rpcrdma_req serve no
purpose.

Introduce struct rpcrdma_xdr_cursor to track position within
an xdr_buf during iterative MR registration. Rewrite frwr_map to
populate scatterlist entries directly from the xdr_buf regions
(head kvec, page list, tail kvec). The boundary logic for
non-SG_GAPS devices is simpler because the xdr_buf structure
guarantees that page-region entries after the first start at
offset 0, and that head/tail kvecs are separate regions that
naturally break at MR boundaries.

Fix a pre-existing bug in rpcrdma_encode_write_list where the
write-pad statistics accumulator added mr->mr_length from the last
data MR rather than the write-pad MR. The refactored code uses
ep->re_write_pad_mr->mr_length.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Limit this backport to the request layout needed for synchronous
invalidation. Move rl_segments next to the request buffers so the
invalidation completion can follow rl_registered.

Keep the segment array for the existing registration code. A Write
chunk can include the tail iovec when the peer requires explicit
padding.

Stable-dep-of: 1fa415883c37 ("xprtrdma: serialize unmap_sync with xprt_disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/xprt_rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index d91f54eae00b3..7364a3648bd70 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -316,13 +316,13 @@ struct rpcrdma_req {
 	struct rpcrdma_regbuf	*rl_rdmabuf;	/* xprt header */
 	struct rpcrdma_regbuf	*rl_sendbuf;	/* rq_snd_buf */
 	struct rpcrdma_regbuf	*rl_recvbuf;	/* rq_rcv_buf */
+	struct rpcrdma_mr_seg	rl_segments[RPCRDMA_MAX_SEGS];
 
 	struct list_head	rl_all;
 	struct kref		rl_kref;
 
 	struct list_head	rl_free_mrs;
 	struct list_head	rl_registered;
-	struct rpcrdma_mr_seg	rl_segments[RPCRDMA_MAX_SEGS];
 };
 
 static inline struct rpcrdma_req *
-- 
2.53.0

