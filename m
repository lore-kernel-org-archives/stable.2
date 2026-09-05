Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC123E33D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578905; cv=none; b=RAVph1SeRYDv+egA8ERgBcTM6gFBlC4IS1VpTUgbEIDZKw5HCiqvNAyaKLN6eO/ND1iBgwBcwuCNBIOgwD3FYl0Ac/G50V8htkiPZZqtL7zdX0Q5qBclZtWwfWdsNbgFdN+TRBkfqGiWFCLfCl5jrYP2K+cwJvL5fSrAUw3VbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578905; c=relaxed/simple;
	bh=bEvX+CWr68+s8ZCPcRcwHYWX8neiJnXk24tnsSQHfDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0lclH6Vv/60ToQQ5ztx97vM2LcOLANt5UfDP6nYFgGW09JBpNs54MA9GCgD6GcwXOWv6EIaFTE4Lo7PfjeWCWI0tHaHCS1OT/7EKqZ7wucFUNtlB9YdLPBACUyroesjv0k0wdJuoTvZFKQDa6izRx4/wJ+rJAeDeP4p7rOuENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkcR08bX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkcR08bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484711F00A3D;
	Sat,  5 Sep 2026 03:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578903;
	bh=Jr6bWO6qk3PoiygEDOqOoI4dVbzLBwLloTGlbBhQ6Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkcR08bXW/Xt21JA/CNBdpf018T1Q59oW5nsRa6ZMYeR0Qmh8bOrz12ZQaTSDtiyA
	 0NVWynZQWBQSPX+xyR6BXrdk4YWvmqaKDuwRpu1nuhqh4dZRwqUy4/ltNGt3Psdm17
	 sBGKhKOD4MEc8FD4SG40dmZ6Vi6UarSmZ/NiqRDj81EIdzRPaJnKeoPxAFxJRNqP2R
	 oBO660YZJ/8Ski7tSUrzYKgdzfQDs6RorxokMBVphDt8ttGF/6iSMD5I0RnZc6W0+C
	 9sHjCUL2hE4d9bErZ4yMeYXoB6H/MoqdBOyHke0kN3+8jCdvhPkb6OGNZ+tC48jNmJ
	 bX4Vbe6u6xRNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] NFSD: Rename a function parameter
Date: Fri,  4 Sep 2026 23:28:17 -0400
Message-ID: <20260905032820.1914550-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-starry-expulsion-6b91@gregkh>
References: <2026090358-starry-expulsion-6b91@gregkh>
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
Stable-dep-of: a99d720ed2a5 ("nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage")
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

