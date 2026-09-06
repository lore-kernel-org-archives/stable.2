Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE53CEBA6
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701321; cv=none; b=etxuJmJz8iXlbF/eK3i9kYPMi1h3BbiXlXeuw4xha655VV1nrgkKsYG4NnjiQ3ncgxfpFv7/6JzXGzNexCS/NqFnLJh5sACBi+AaiYjIrboem548lTiERDK9fPolk9E3Ma+VxRwCaH5PnaNivjBZvsuoTIii+1yuDmKVfPMgYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701321; c=relaxed/simple;
	bh=+lHFFa/mzcS3g24Gu2HFwRk0DFCDv8MuhWZixaU3h3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXSg7zdjL8be4cgeq2A+UES4jVn1GhctWr7dxRWDfd6yH61EAhEFGtl+4tPGdu4ma0kfSwnN0bm84mPs1co29DwfkaZRhcAD7ZJrbQRtSFYPr53j6RKke+x5U7CK4keNNaZo0WrIm+/3hKcGe4akKS4YhB+m0jQBaA1f9Wlm3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=budXFhkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="budXFhkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC91F00AC4;
	Sun,  6 Sep 2026 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701318;
	bh=lLa8yZW9GzOr2yiQxUXKHKaCxSS8JrWN4pf8BJ5J63Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=budXFhkkLPs5EP72NMRCpOYGLdpZefz/hdX37yTEERBzPEQy10Gw0tOZJwWtTsLgS
	 EX3MexcyvzC97PLfeW5aGnkXSDhCQfslvC4has1e9UoaOS8XkJOiTsaQMwRNU6qC/I
	 dZDmTDuebvU12heXK5nxpTPafSce0TgGwd95gVW0HUpL1d5EP8g4pS9bGpchuc1jvi
	 Y09F3fWVquh6F8neKP8PFOA1noerZF0wGY+/ygPxKEteI1zBcoZdJFtzG8cSFAK2Ms
	 FK9RCpSlt3vVlU1heqx3kfYpsAbw5dfXJ+X93X49b5lvfTm3XlRzxzhfp3JoYFm7C6
	 fSZ44wh8Pflyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] NFSD: Use sockaddr instead of a generic array
Date: Sun,  6 Sep 2026 09:28:33 -0400
Message-ID: <20260906132835.874565-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132835.874565-1-sashal@kernel.org>
References: <2026090307-suave-unlucky-a08a@gregkh>
 <20260906132835.874565-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 45e3eda46db467b8b934188ff2109ee29b5b0b00 ]

Record and emit presentation addresses using tracing helpers
designed for the task.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: eb0eca772066 ("nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/trace.h | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 91e9921db725e..8556de1a3bbba 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -16,22 +16,23 @@
 #include "nfsfh.h"
 #include "xdr4.h"
 
-#define NFSD_TRACE_PROC_RES_FIELDS \
+#define NFSD_TRACE_PROC_RES_FIELDS(r) \
 		__field(unsigned int, netns_ino) \
 		__field(u32, xid) \
 		__field(unsigned long, status) \
-		__array(unsigned char, server, sizeof(struct sockaddr_in6)) \
-		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+		__sockaddr(server, (r)->rq_xprt->xpt_locallen) \
+		__sockaddr(client, (r)->rq_xprt->xpt_remotelen)
 
-#define NFSD_TRACE_PROC_RES_ASSIGNMENTS(error) \
+#define NFSD_TRACE_PROC_RES_ASSIGNMENTS(r, error) \
 		do { \
-			__entry->netns_ino = SVC_NET(rqstp)->ns.inum; \
-			__entry->xid = be32_to_cpu(rqstp->rq_xid); \
+			struct svc_xprt *xprt = (r)->rq_xprt; \
+			__entry->netns_ino = SVC_NET(r)->ns.inum; \
+			__entry->xid = be32_to_cpu((r)->rq_xid); \
 			__entry->status = be32_to_cpu(error); \
-			memcpy(__entry->server, &rqstp->rq_xprt->xpt_local, \
-			       rqstp->rq_xprt->xpt_locallen); \
-			memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote, \
-			       rqstp->rq_xprt->xpt_remotelen); \
+			__assign_sockaddr(server, &xprt->xpt_local, \
+					  xprt->xpt_locallen); \
+			__assign_sockaddr(client, &xprt->xpt_remote, \
+					  xprt->xpt_remotelen); \
 		} while (0);
 
 DECLARE_EVENT_CLASS(nfsd_xdr_err_class,
@@ -142,14 +143,14 @@ TRACE_EVENT(nfsd_compound_decode_err,
 	),
 	TP_ARGS(rqstp, args_opcnt, resp_opcnt, opnum, status),
 	TP_STRUCT__entry(
-		NFSD_TRACE_PROC_RES_FIELDS
+		NFSD_TRACE_PROC_RES_FIELDS(rqstp)
 
 		__field(u32, args_opcnt)
 		__field(u32, resp_opcnt)
 		__field(u32, opnum)
 	),
 	TP_fast_assign(
-		NFSD_TRACE_PROC_RES_ASSIGNMENTS(status)
+		NFSD_TRACE_PROC_RES_ASSIGNMENTS(rqstp, status)
 
 		__entry->args_opcnt = args_opcnt;
 		__entry->resp_opcnt = resp_opcnt;
@@ -168,12 +169,12 @@ TRACE_EVENT(nfsd_compound_encode_err,
 	),
 	TP_ARGS(rqstp, opnum, status),
 	TP_STRUCT__entry(
-		NFSD_TRACE_PROC_RES_FIELDS
+		NFSD_TRACE_PROC_RES_FIELDS(rqstp)
 
 		__field(u32, opnum)
 	),
 	TP_fast_assign(
-		NFSD_TRACE_PROC_RES_ASSIGNMENTS(status)
+		NFSD_TRACE_PROC_RES_ASSIGNMENTS(rqstp, status)
 
 		__entry->opnum = opnum;
 	),
-- 
2.53.0

