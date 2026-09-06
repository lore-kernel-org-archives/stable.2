Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273E3D47C0
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701323; cv=none; b=jC3+Sk7euDxKIdCHyxenO5gAVZL+ZsfmIIybX5q17dPZdmf/0eA9Eir9OCyE8ihotpGrJoJeoa8H+3tKqgGklX5k/ANwqMxumNehvbi2183ug4ChmcjC75A/GceQcP1coY29iLibOqyvpHTcQoJmM0Rq++3UVibbEfU0OkoDrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701323; c=relaxed/simple;
	bh=Y3w7O+lUl9sMuq2qqbtLJCbXsiUw/DMxV6XsBHhuFVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqeqI761LSHnis+cfcQuun6UyosJh/UMFdyYZP8HjyAlfaFcDSI1gRJ9MxdknhmDdcHkw/NTpTqX77HzXJO6W3yQnIA8pfdgXN7VFp4FtSPGz95XUYA5SaW77PvnTC8MZS5S5lizye3H5TYDvBX/iHzOHiwZUNqTjA+tjdMI1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0aQo1Rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0aQo1Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95071F00A3D;
	Sun,  6 Sep 2026 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701319;
	bh=sLbOONnEIWRqSK773fPRCf/xU+7h4gaOYcBAgNL8XTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0aQo1RwKk0ndKuL6JDmS2vqfaJDd0sIFTeMevlWFJh5jidmpUUIkW97xvWsfF3gs
	 ETM1MwYe03+J3RkXXnSQIX9Iwq/lKw9NAheu/Tw8tVWuOSmCnouL1dF3KqMp3RtPrd
	 lf/l75Kig/Q4Ifoua4yUIQWa3vfGM1VepQGxZrx6YC7Zz4RFaiKK5x7qm8kN9rh1ZO
	 9sALqEyxuplwvgH6Ky7bq0YWN8Wdlieb/VJwZxK26mRbdM0wXPyW78PIA4UqrxDJB+
	 V/9TEbQFcVFP9jLiUcQu6R4m/tzN6yKLeV1P8aGPF2j+mV03ZKzPO0G1s75wBbAUQ3
	 q1QREH2JZQJrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] NFSD: Add a Call equivalent to the NFSD_TRACE_PROC_RES macros
Date: Sun,  6 Sep 2026 09:28:34 -0400
Message-ID: <20260906132835.874565-3-sashal@kernel.org>
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
index 8556de1a3bbba..faefa759f3375 100644
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

