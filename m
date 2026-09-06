Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB038B7AA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660823; cv=none; b=OI1hdTWyYft1p1r1AEWUse92HzgKkI0ZR4euQHnBqGdOwvDw337W0afi3EdR2ZQch9jEPtDRk0TIZVmYngql4jGlsAXfLIPOq3NwrjM/ldqM3k51rc67DFY+OqestD31OJkBkp8JTQSpEZVUYrEPSLU4NygjJUt+zJYjqPBiQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660823; c=relaxed/simple;
	bh=/Vv2C2+b5AQsJ6K9TkBqQs0Scut+w2yR11OQSXsY7G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ8BkFRV+05+ekGJeAO4GoGEDhJ5BLLn3Sa440JyWfrzPf4olEeok8sjgUE8H/NYG7Vy6TmjItZBOvo60dio3noucMJhdNck0EphRMnDGbd/o0BV/orEnJAnzOlXa4FCM7wJnvfHakKTYwVahccoG+0kq4d47SEODkpLucHRaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLTBakgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLTBakgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3DA1F01558;
	Sun,  6 Sep 2026 02:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788660809;
	bh=xTjTcW75MGHngKvinm2t+i4aEkb7odFQHDc2XM9+l/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mLTBakgww17+gukPAUWHdPTe7j7t/y/3vfy93lzJwCWneCnlSTF7ENeYNwMNo+JSC
	 C8dtngxuJ0mOuHcHNxo9R8b1jd2oYYhBLHMMS63Oou1kZv0rKpH+I3oWNDRIWhJ75X
	 dS9XyyUHpX0oe34zEfbncrVbhRVV4+M7AO+RsU6wVTAdZbPBePixUqoLnOqyX0hL1f
	 QfK4K+7b8R1WROS5i4MqraLy2lG5XdtUf90CZU6O1XZBDT3f1INXvqg5i38tOb/pqu
	 PfnHGT7AYXCEn6iq8hmQY1wceXaouUemMlAv3bBzY7JCiqzzx5+DAYIvfiFEK8vHUA
	 Vh7SfJgQ7BQsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] NFSD: Add a Call equivalent to the NFSD_TRACE_PROC_RES macros
Date: Sat,  5 Sep 2026 22:13:24 -0400
Message-ID: <20260906021325.760715-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906021325.760715-1-sashal@kernel.org>
References: <2026090306-sarcastic-gristle-d434@gregkh>
 <20260906021325.760715-1-sashal@kernel.org>
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
index b951f7ffc0216..242f40b4e8102 100644
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

