Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83E371053
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618989; cv=none; b=FnBSNHs9/dJcJwsZph86c62NmC0XcFdVurGtlIIQK9oUg7RV5OylBAeCGaLk4GMwUjLGd/W/pGjyjA3sHoUHqw66PxdkXGB8ut8Td24xwdHrQwGz1tcxOX37WpT4hetMqadmo2MUnPW3e5dk6lIvTCtlJC4fC8zuwMg70bNW3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618989; c=relaxed/simple;
	bh=L6GMVPTV02f5InSXPegGGo0ZPdI8zI63e1aNzHYew2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKUFN2lD5VUCWDvG6dbpNO4kzRdXYaoHLgeUbqUWskHYmxL1nSP/FnEgXnmSRIDP3P1Zl/i/0v3zMXtRaHiIGPrOiTBOXhzAeWr7AnKqisCErQlzkFpx03i3I++tRyVWdtZxHRrOmuNxNfyrxhq12rHGxwU1qmQvu6tgJ1YnjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENt5ED6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENt5ED6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71521F00A3D;
	Sat,  5 Sep 2026 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788618987;
	bh=eMIT/xLKFuy1No1NcU3oE5xVYe1huYQGXQefCqNsqAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ENt5ED6J0BvLJbm7yDT2s8M3G+/Gyapizxnu5ka93pJ4iIYrxn23bdjl1m3qfuzGn
	 RsBMH2Yctf2ZYLyvJ6hX8RfQ+W5i7en7gopZCaRMiQVDb3mETtX60p/Ha1Fw/Mxjcw
	 TLwZQ0/JSa9G4pwO3qgg6ZJ9rKBb2tEmFgemsKDqpcIkPCRPYb/54aFUvoMudVPcua
	 OdxOftPPd+vRThfJNQ7JFZ2+4bPnk2ohn+zDUM3g9P1R5CN1gCK5J6Xb1JKLf3nISZ
	 qZB3ajSbfL7wIbB584wtmQnrrBr7fRHngYR9oOw7kO/ZszTeTuMBJqX43tuA0X9tvO
	 RgjNtyk5naVmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] NFSD: Rename a function parameter
Date: Sat,  5 Sep 2026 10:36:24 -0400
Message-ID: <20260905143625.237435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-disbelief-saddling-d516@gregkh>
References: <2026090318-disbelief-saddling-d516@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 71bc2c6c413b78e5a47b4a62284f712d9f719007 ]

Clean up: A function parameter called "rqstp" typically refers to an
object of type "struct svc_rqst", so it's confusing when such an
parameter refers to a different struct type with field names that are
very similar to svc_rqst.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: e13d505af73a ("nfsd: fix netlink dumpit error handling for rpc_status_get")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7b0a6beee96ed..9a3c0011b6674 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1494,7 +1494,7 @@ unsigned int nfsd_net_id;
 
 static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 					    struct netlink_callback *cb,
-					    struct nfsd_genl_rqstp *rqstp)
+					    struct nfsd_genl_rqstp *genl_rqstp)
 {
 	void *hdr;
 	u32 i;
@@ -1504,22 +1504,22 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	if (!hdr)
 		return -ENOBUFS;
 
-	if (nla_put_be32(skb, NFSD_A_RPC_STATUS_XID, rqstp->rq_xid) ||
-	    nla_put_u32(skb, NFSD_A_RPC_STATUS_FLAGS, rqstp->rq_flags) ||
-	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROG, rqstp->rq_prog) ||
-	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROC, rqstp->rq_proc) ||
-	    nla_put_u8(skb, NFSD_A_RPC_STATUS_VERSION, rqstp->rq_vers) ||
+	if (nla_put_be32(skb, NFSD_A_RPC_STATUS_XID, genl_rqstp->rq_xid) ||
+	    nla_put_u32(skb, NFSD_A_RPC_STATUS_FLAGS, genl_rqstp->rq_flags) ||
+	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROG, genl_rqstp->rq_prog) ||
+	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROC, genl_rqstp->rq_proc) ||
+	    nla_put_u8(skb, NFSD_A_RPC_STATUS_VERSION, genl_rqstp->rq_vers) ||
 	    nla_put_s64(skb, NFSD_A_RPC_STATUS_SERVICE_TIME,
-			ktime_to_us(rqstp->rq_stime),
+			ktime_to_us(genl_rqstp->rq_stime),
 			NFSD_A_RPC_STATUS_PAD))
 		return -ENOBUFS;
 
-	switch (rqstp->rq_saddr.sa_family) {
+	switch (genl_rqstp->rq_saddr.sa_family) {
 	case AF_INET: {
 		const struct sockaddr_in *s_in, *d_in;
 
-		s_in = (const struct sockaddr_in *)&rqstp->rq_saddr;
-		d_in = (const struct sockaddr_in *)&rqstp->rq_daddr;
+		s_in = (const struct sockaddr_in *)&genl_rqstp->rq_saddr;
+		d_in = (const struct sockaddr_in *)&genl_rqstp->rq_daddr;
 		if (nla_put_in_addr(skb, NFSD_A_RPC_STATUS_SADDR4,
 				    s_in->sin_addr.s_addr) ||
 		    nla_put_in_addr(skb, NFSD_A_RPC_STATUS_DADDR4,
@@ -1534,8 +1534,8 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	case AF_INET6: {
 		const struct sockaddr_in6 *s_in, *d_in;
 
-		s_in = (const struct sockaddr_in6 *)&rqstp->rq_saddr;
-		d_in = (const struct sockaddr_in6 *)&rqstp->rq_daddr;
+		s_in = (const struct sockaddr_in6 *)&genl_rqstp->rq_saddr;
+		d_in = (const struct sockaddr_in6 *)&genl_rqstp->rq_daddr;
 		if (nla_put_in6_addr(skb, NFSD_A_RPC_STATUS_SADDR6,
 				     &s_in->sin6_addr) ||
 		    nla_put_in6_addr(skb, NFSD_A_RPC_STATUS_DADDR6,
@@ -1549,9 +1549,9 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	}
 	}
 
-	for (i = 0; i < rqstp->rq_opcnt; i++)
+	for (i = 0; i < genl_rqstp->rq_opcnt; i++)
 		if (nla_put_u32(skb, NFSD_A_RPC_STATUS_COMPOUND_OPS,
-				rqstp->rq_opnum[i]))
+				genl_rqstp->rq_opnum[i]))
 			return -ENOBUFS;
 
 	genlmsg_end(skb, hdr);
-- 
2.53.0

