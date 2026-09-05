Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B43245020
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573594; cv=none; b=ZXIH2dLzbFK7pJxtjAJF5StnuSs/YkTmaUoGU0czBJuHJkMmCFlyfzoIpSLBiDI9VKonzGpQuIyweKgKTJBhoP8dJ45O4/+uMdLgNbBdTUW4JkaW49l5ZPdM8C/MH0tK40PY09asruBQaYLfEg/7GLsF/jpAor0IeyLjHd9QVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573594; c=relaxed/simple;
	bh=w5RNMf8m77kyPp/3FdjAPLOMnBqfWYE7VJComzQQG/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdPRQ1poUeSLdt1HIPJlxdDplRWlB+CYcagZJHZRZkPoFGqKXCZhCHuEo6Gg4uLwwVrbF/QNgtyS6NhVx14cBFyyQicJGF4pi/F7Dc31QR8B5oF6XLYRDYPwABIlA77mFp2BE49IvxYik5dFlXA1LPTEebwHwQA/L8sdC6ngLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3in/pEP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3in/pEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373DD1F00AC4;
	Sat,  5 Sep 2026 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573593;
	bh=0i19fiO3LvReFkY0sLYTfZYz2LJQANzO1bmvbV8Q5vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d3in/pEPoL9iLbOMVk1uwNA+xUmLSgicftHrlufXW6aVVf+UeHwTDbjYZEeWkuFSH
	 EL2GjNnKmJJ6v5M1BWWjPexElgo6LD6eimTATYDWi2+Ie5Z8bi/NIUOEHt8j2yIkec
	 FWtZZ9X50prTUj1FKQO7bULfyP7/PbZSGlpcle/JIT/y2UWTFiCgMmV0lmWYaYr5+o
	 M9Ehk1MDuswBVuyCQfki/CxtxwvssMHYHGzwMY8On46pX8w5aLmmR+538hbLoIPk8G
	 12Da+CWfNSuhBLattjhTTjDHzf9rYg1gt3Rr2DRCjyNMqSDtl8Um2D4kxfJzp4Rne3
	 EzJZqUnkk91RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage
Date: Fri,  4 Sep 2026 21:59:50 -0400
Message-ID: <20260905015950.1825770-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905015950.1825770-1-sashal@kernel.org>
References: <2026090358-marital-swizzle-715d@gregkh>
 <20260905015950.1825770-1-sashal@kernel.org>
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
index c806e074d6488..df48ee574075f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1412,8 +1412,8 @@ static int create_proc_exports_entry(void)
 unsigned int nfsd_net_id;
 
 struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
+	struct sockaddr_storage	rq_daddr;
+	struct sockaddr_storage	rq_saddr;
 	unsigned long		rq_flags;
 	ktime_t			rq_stime;
 	__be32			rq_xid;
@@ -1448,7 +1448,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 			NFSD_A_RPC_STATUS_PAD))
 		return -ENOBUFS;
 
-	switch (genl_rqstp->rq_saddr.sa_family) {
+	switch (genl_rqstp->rq_saddr.ss_family) {
 	case AF_INET: {
 		const struct sockaddr_in *s_in, *d_in;
 
@@ -1525,7 +1525,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 		list_for_each_entry_rcu(rqstp,
 				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
 				rq_all) {
-			struct nfsd_genl_rqstp genl_rqstp;
+			struct nfsd_genl_rqstp genl_rqstp = {};
 			unsigned int status_counter;
 
 			if (rqstp_index++ < cb->args[1]) /* already consumed */
@@ -1549,9 +1549,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
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

