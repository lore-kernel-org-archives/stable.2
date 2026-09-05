Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC036D4FC
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644621; cv=none; b=Kj/NMzJ9w5XGRFUD+g4qBq9kodCuoDYyt+1Q4ULJ4vX3qJ1rGlkAubdZfA7jZJ4bZKUlEv7cN7oiVvNx/3D+JGn5Di8+JoS8BAeAB1YweYm4LgaU/xVWLERJpsJOrOXB5MjgagGTic4O/IVwObBHIfF4XXxXITRAHXBMVuHp8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644621; c=relaxed/simple;
	bh=/KSU73t88KCMz2+NaSi5w5KrwXQ9Zin5suaGvSO231Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/F6BogcSh6NxvjhvQFzIyWSWdQLdAz8/qE8c9vV2l2RZCqjfQ+PKM+8hibWQ5vglOlOCH2qjJKK+ipK1hVOJfqjMGqe4FBIGDrv8uIv0TL6B58i0ZP8VLMwqVFScXWdA07b2+Uiw9CoOvhJ2vPBpidLfQ6gVAsV5agCWGtt9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyEIv5WM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyEIv5WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B81F00AC4;
	Sat,  5 Sep 2026 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644620;
	bh=/LsPbntNnNRbiEbGmCywM57Z2uVdiQqyno5HLGuQe+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DyEIv5WMGgV4TEm0ZW0FKq2SLHgWZjIb7X3xkEHiy4gA8aAhhTQmsU4xp5vVTgRHp
	 L9uDd9bAqObSjd8e8X4HapTSg6OBvdj3c+pDFyPbbmEmEIs8vj25ZjYjR3BA80GDlE
	 qVvPLCHvThxd0lifHYtAKHWlSRoS4ukMNVFWaC8+2RtXhgkFHUgIYkw7ryqsqXh0Qu
	 PVE2KBkXQ15MDBckcFf5AKgZ77Zc6/Yitk2Pfk1XItNrrhDF1QaRfNuI18EvCrINIW
	 n3t2zMApaBg108r3t7PgsnaXt6G/L8/kdiuY+HjwP6acdZjFJMNqhIkTubr7x4iUy9
	 4qYToHgv7i+dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] NFSD: Use sockaddr instead of a generic array
Date: Sat,  5 Sep 2026 17:43:35 -0400
Message-ID: <20260905214337.701562-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905214337.701562-1-sashal@kernel.org>
References: <2026090305-viewpoint-outshoot-49ba@gregkh>
 <20260905214337.701562-1-sashal@kernel.org>
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
index fdb6cfad08793..3ef94bcb27ed7 100644
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

