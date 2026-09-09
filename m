Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DC4086A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915133; cv=none; b=LyPLRok9eNYzqHx+d6ys+PexZZ/xbn7N2SNhtQs1AwfY50vL7HnVgFZvis0o6ensVbTmzdbQFxBLPA1pHEfInShTAIf0Us9YJTwGuAoGf1JzFX2S0faK/gv4UYK9BFpCVBJTE8aT221CIaKH09uwRD6CMsnCc7usUmtM94TGVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915133; c=relaxed/simple;
	bh=l7uCc0iaBF/oY5EM5Wguz/AnnOgW8FPYDGnqnaPBVBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jywX+nee8/NCQmCqJPt0ZmVwEN/pG9jTGzJXWxftEUvscaTSKAWHI8X/htzootvYWu3JSX7ZrChgoi3bcY1AbDDQleyBXOMeUfecFvgXMKUQzFY1CASVDGjN/K8id3gYQ6kBhQsg8K7NOQtKmizoCzJMbYFk8L+JxoatKxLj0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaFjlt9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaFjlt9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7481F00A3E;
	Wed,  9 Sep 2026 00:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915131;
	bh=0rwyHJJEEbhtuiXfB0n1+PRtbjtYZmUgMiilzrPhGUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UaFjlt9Pa6/WfeVhaluOwaRvPKNydIVmNoDvOoMukNZtUUGt+JmszYV1qTvsGPJ3t
	 80VYr87D3qdtSqAuTBSIOa29gAFbViBZtcwtfCuZBRVAZTtOnriPioD3IZSexYjEps
	 Jv3vfc1aVTm3ua8SxtdWMmTeOUaGkxHmypZ3wiUjZ0i9Qk5niCtbRGBfQoMnm+2zpu
	 LRZAwuSGULlaFdHkHk9qEBAwRzeXxApCr+OM+srvHoKmNZJNoS1zaVBUrKOM7jOmTB
	 V2/wsmLo9MUxCyb7lXG10ukgPvPq9Wl85OjnJBeR4bEIcGS021CPMpC7TJyqsLyeo4
	 YlHFLjqXcd20A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] svcrdma: Use svc_xprt_put to free listener on create failure
Date: Tue,  8 Sep 2026 20:52:08 -0400
Message-ID: <20260909005208.805626-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909005208.805626-1-sashal@kernel.org>
References: <2026090355-carton-stuffy-958f@gregkh>
 <20260909005208.805626-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e346ef7bcb137f50c49f969330ab7dcf64ea1654 ]

svc_rdma_create() calls kfree(cma_xprt) when
svc_rdma_create_listen_id() fails. svc_xprt_init() has already
acquired a net namespace reference via get_net_track(); kfree
bypasses svc_xprt_free() which releases it.

Replace the kfree() with svc_xprt_put() so the kref_init birth
reference drops to zero and svc_xprt_free() dispatches
svc_rdma_free() to clean up properly. sc_cm_id is still NULL
at that point; the preceding patch added the necessary NULL
guard in svc_rdma_free().

svc_xprt_free() also drops the module reference via
module_put(), but the caller _svc_xprt_create() does the same
on xpo_create failure, double-putting the single
try_module_get() it acquired. Take a compensating
__module_get() before the svc_xprt_put() to keep the count
balanced, matching the convention in svc_rdma_accept()'s error
path.

Fixes: 4fb8518bdac8 ("sunrpc: Tag svc_xprt with net")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-3-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index dc7e02ed8894f..d2659446a1111 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -348,7 +348,13 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 
 	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
-		kfree(cma_xprt);
+		/* _svc_xprt_create() acquired one module reference and
+		 * puts it on xpo_create failure.  svc_xprt_free() puts
+		 * a second one when the kref drops to zero.  Take a
+		 * compensating reference so both puts are balanced.
+		 */
+		__module_get(cma_xprt->sc_xprt.xpt_class->xcl_owner);
+		svc_xprt_put(&cma_xprt->sc_xprt);
 		return ERR_CAST(listen_id);
 	}
 	cma_xprt->sc_cm_id = listen_id;
-- 
2.53.0

