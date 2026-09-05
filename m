Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C327FD49
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578907; cv=none; b=VysuMTGw7wankhG7OPaDxkncId3AsBPUSa33GeKeRoAbI0zt5P/zgI0ozoTGK6HOJV9Rdng6prJjKyqvEs3JIZUL9GUFrOzT43GpgwcdUxZ0KR9RYqVrWsWhk6hX4a3V/vXD0Toj5fK7uI7cyMJfXk57OuifXd9R6ZUXN4BrHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578907; c=relaxed/simple;
	bh=Srclh7xOWfHJsKSe6S7EWKr9/zQzMn06auf4+hyjbAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyW+TjeISG+/jHC/V4WxH930beu/IOBRCGiidCZXuASqndIOJEKxKf+DFr6fH8e1zDbCmhZv2tKgUzpt0vgTUiljt2GaFEC9FNWOjixEptF5dQ86EXNIuXD1wahE6eYDJ2I5EAQ5c/gGj5Md39q242eJmqXCzvP3s/lX1muVgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt3T6929; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt3T6929"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE47C1F00A3D;
	Sat,  5 Sep 2026 03:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578906;
	bh=4rcvGBaWSfGo1zs4RLC4E8hRsFQh8Zk4o/6A9LA4sIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pt3T6929+z63ddH1vD3tuOwNLEs4Md4j27PIYyOj7RMQGcjyBnd2G9WOVn0LCvvDi
	 lerPY9mdngHrm/WlSj2wU+Ci/666G9X7SbQaEmctXXk5p0QnglEPQmV7y0pv7N3WYd
	 gCTJEr0WW6m4xvE7z4x2n4CbZlPDlBXLBBRHBDjd/A0R7f2p7oTiwuC3LHW6AXMV2k
	 sDjaMN4R1TxapfIneet8H/BIIUWHB17ureIy/eANJUML3HMybUyAi1y3GhEsumD7Yd
	 jAQwg2IJLspAEIUGgtCeoSxla7erI1LtlTB8NjOo4FEs4zG33gUb/KAjznLCqzxVID
	 lLEB43lNC0mTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage
Date: Fri,  4 Sep 2026 23:28:20 -0400
Message-ID: <20260905032820.1914550-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905032820.1914550-1-sashal@kernel.org>
References: <2026090358-starry-expulsion-6b91@gregkh>
 <20260905032820.1914550-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit a99d720ed2a5258564e5e9d5f39f3184a030d354 ]

struct nfsd_genl_rqstp declares rq_daddr and rq_saddr as plain
"struct sockaddr" (16 bytes). When an IPv6 NFS client is connected,
nfsd_genl_rpc_status_compose_msg() casts these fields to
"struct sockaddr_in6 *" (28 bytes) and reads sin6_addr at offset 8..24,
which extends 8 bytes past the end of the 16-byte sockaddr field into
the adjacent rq_flags member. The 16-byte nla_put_in6_addr then ships 8
bytes of truncated IPv6 address followed by 8 bytes of rq_flags to
userspace via the NFSD_A_RPC_STATUS_SADDR6/DADDR6 netlink attributes.

This is reachable by any unprivileged process in the network namespace
because NFSD_CMD_RPC_STATUS_GET uses GENL_CMD_CAP_DUMP without
GENL_ADMIN_PERM.

Fix by widening rq_daddr and rq_saddr to struct sockaddr_storage so the
IPv6 casts operate within bounds, copying sizeof(struct sockaddr_storage)
bytes in the memcpy calls so the full address is captured, and
zero-initializing the genl_rqstp stack variable to prevent leaking
uninitialized tail bytes through netlink.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260602-nfsd-testing-v2-5-e4ea62e3cd5c@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3daf3993c7973..10f35050c9c01 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1493,8 +1493,8 @@ static int create_proc_exports_entry(void)
 unsigned int nfsd_net_id;
 
 struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
+	struct sockaddr_storage	rq_daddr;
+	struct sockaddr_storage	rq_saddr;
 	unsigned long		rq_flags;
 	ktime_t			rq_stime;
 	__be32			rq_xid;
@@ -1529,7 +1529,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 			NFSD_A_RPC_STATUS_PAD))
 		return -ENOBUFS;
 
-	switch (genl_rqstp->rq_saddr.sa_family) {
+	switch (genl_rqstp->rq_saddr.ss_family) {
 	case AF_INET: {
 		const struct sockaddr_in *s_in, *d_in;
 
@@ -1606,7 +1606,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 		list_for_each_entry_rcu(rqstp,
 				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
 				rq_all) {
-			struct nfsd_genl_rqstp genl_rqstp;
+			struct nfsd_genl_rqstp genl_rqstp = {};
 			unsigned int status_counter;
 
 			if (rqstp_index++ < cb->args[1]) /* already consumed */
@@ -1630,9 +1630,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 			genl_rqstp.rq_stime = rqstp->rq_stime;
 			genl_rqstp.rq_opcnt = 0;
 			memcpy(&genl_rqstp.rq_daddr, svc_daddr(rqstp),
-			       sizeof(struct sockaddr));
+			       sizeof(struct sockaddr_storage));
 			memcpy(&genl_rqstp.rq_saddr, svc_addr(rqstp),
-			       sizeof(struct sockaddr));
+			       sizeof(struct sockaddr_storage));
 
 #ifdef CONFIG_NFSD_V4
 			if (rqstp->rq_vers == NFS4_VERSION &&
-- 
2.53.0

