Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DF37DAD7
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644622; cv=none; b=XOJBNy07+Y69ADNmBKK2g+YKLKHr+ksz6dcKHoWqWxc/uVIkgacIj72BATP1SHotDiZrx8HAR8faaAeaiSH0osG2H9YLjlQsgwbcDKnNHehbfza9E2RvwoHEAAqt+V9QJ3kJC60jKzPskfhLLLWstHwlXU1bR3K8xlNoOskVVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644622; c=relaxed/simple;
	bh=ZbceTJKyzxVSFiX35Qwhzl49cQm4Jac9qRg5wOXJTeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uetarr8n2HkT33nBbKc0DDRnnqNhI7B/xIMJr6/vjaMtyPpAjF7A63rIXiD/YDPYwLrdc3YLIIe4WVfJpC0RdzZ//duasPmmJib25/ycqmDpaF4YZw1JHBf+YSu8LVpDcrADuIGaLAnTvQSoyHCQ2F8qmGJ14lEaoomxdpmPCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4V48yDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4V48yDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0021F00A3F;
	Sat,  5 Sep 2026 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644621;
	bh=hUhZOtQfNbNLZxAe4FnFIUotFxDbs4WDSIOidN0+LXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M4V48yDFu9BjYDBHRI9YGyI0or6K67SLrjLvD+GsFlKvg3XCggfbu4RerAY5gvydR
	 rDOlpnZ0SqUrbkJUiWQ66R6yF7BlLybeVxObdGR288huTLOjN6vuKmPdTNC1ZATTFR
	 SxP3mUPlvEXJTxcQbpm0gMnEiSmtgCvbwJUYiCER7rgfQT/gmpQLYRxG0vwOYmRa91
	 CFBnr3ylXv7XpIBLEj2fVCH8W99lOGZ6B0c40zGmFf+lX6WTxTbhF9jz0RB+ln3jt3
	 iR2WEf73IU6+4my0p00bPa1QzaqWLizRvk+RqhwOKCxcfbmbCZPUUWAVliYK+e0vv5
	 eUx45ahQdiwvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] NFSD: Add a Call equivalent to the NFSD_TRACE_PROC_RES macros
Date: Sat,  5 Sep 2026 17:43:36 -0400
Message-ID: <20260905214337.701562-3-sashal@kernel.org>
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

[ Upstream commit 218927aa47647cc3bb58520cc630279844d8adde ]

Introduce tracing helpers that can be used before the procedure
status code is known. These macros are similar to the
SVC_RQST_ENDPOINT helpers, but they can be modified to include
NFS-specific fields if that is needed later.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: eb0eca772066 ("nfsd: reject out-of-range nseconds in NFSv3 SETATTR and create ops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/trace.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 3ef94bcb27ed7..032a38b23260a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -16,6 +16,23 @@
 #include "nfsfh.h"
 #include "xdr4.h"
 
+#define NFSD_TRACE_PROC_CALL_FIELDS(r) \
+		__field(unsigned int, netns_ino) \
+		__field(u32, xid) \
+		__sockaddr(server, (r)->rq_xprt->xpt_locallen) \
+		__sockaddr(client, (r)->rq_xprt->xpt_remotelen)
+
+#define NFSD_TRACE_PROC_CALL_ASSIGNMENTS(r) \
+		do { \
+			struct svc_xprt *xprt = (r)->rq_xprt; \
+			__entry->netns_ino = SVC_NET(r)->ns.inum; \
+			__entry->xid = be32_to_cpu((r)->rq_xid); \
+			__assign_sockaddr(server, &xprt->xpt_local, \
+					  xprt->xpt_locallen); \
+			__assign_sockaddr(client, &xprt->xpt_remote, \
+					  xprt->xpt_remotelen); \
+		} while (0)
+
 #define NFSD_TRACE_PROC_RES_FIELDS(r) \
 		__field(unsigned int, netns_ino) \
 		__field(u32, xid) \
-- 
2.53.0

