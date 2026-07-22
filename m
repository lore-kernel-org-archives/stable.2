Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79126368D7E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731723; cv=none; b=FGCNU91qoWCOIY8Dw+ffuIfKQE++pv0D4mrA2WeO87dql73ed77dGrQ3HxTmrhU9xOmIAN3vRs3MRRL9ECGfGoKThHc9umHRbvgv/29beDTI6N8UBtTLku+HnCsjLLNESEI1jva6f2J7kF3Uc2h3PWixpzRevtMxgmatgfce6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731723; c=relaxed/simple;
	bh=UVlXsqrMyy8Sj2t/3fqcACVfxusqSC4Ji1S/o/8TR3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C56J84M48cknfNZpyJvdZ1KeigJGHElud9Xtumm4tLQ+Y+a4SCAv1pu1cmBg7O5HC1RAbbU5ZZTzICZ93sV7m6FkR38MrK5OfQkzzuQcoI3I7hgzWEAi6WdRnK1L5oJ9jDIpZi5XbeUFPwxPgYv5zwCsCF3NCuTWqiJYF6mVcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS8oRMwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS8oRMwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDFD1F00A3F;
	Wed, 22 Jul 2026 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731719;
	bh=yPSxBQIInB9zzRVUEr1Uuer/MHb5aHbwB9IN2uWPCbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hS8oRMwuZSm/iE9Y/gJeeuhvK3u0QFM1NoXm5AxtpqEVtVQQOFO8bVVTJiVhx5Qlt
	 xa6hxkOC+Jwn3Xe17KnB5G+D795HAWoLlRCYgqE8nT/90PCxyfqQznHxMsqZPzAIJK
	 A7eoYuyDblplbp8+ajhMWhijJ0v3EZRxpF2dfd0JFGy8ACuQO4WoaJrAefuYNjm0tH
	 PU7YK2f9TbB7ashoB9hibEf3NcSNO09o30h3sEPUwrEctJxYeEGEETNQKcsdVtltuu
	 QuGzoWBRx0vEs4xuaYaOh/315lNt8bDI7GGkHhdGE86im9Jda4P8A6XYO7OBcKfW0j
	 y5NAeo95Mt80g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] afs: Turn the afs_addr_list address array into an array of structs
Date: Wed, 22 Jul 2026 10:48:34 -0400
Message-ID: <20260722144836.1601242-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722144836.1601242-1-sashal@kernel.org>
References: <2026072053-iciness-ecosystem-430e@gregkh>
 <20260722144836.1601242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 07f3502b33a260f873e35708d2fa693eb52225cb ]

Turn the afs_addr_list address array into an array of structs, thereby
allowing per-address (such as RTT) info to be added.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Stable-dep-of: dc175389b18c ("rxrpc: serialize kernel accept preallocation with socket teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/addr_list.c | 10 +++++-----
 fs/afs/fs_probe.c  |  6 +++---
 fs/afs/internal.h  |  6 +++++-
 fs/afs/proc.c      |  4 ++--
 fs/afs/rotate.c    |  2 +-
 fs/afs/rxrpc.c     |  4 ++--
 fs/afs/server.c    |  4 ++--
 fs/afs/vl_alias.c  |  4 ++--
 fs/afs/vl_probe.c  |  6 +++---
 fs/afs/vl_rotate.c |  2 +-
 10 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index de1ae0bead3baf..ac05a59e9d4649 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -45,7 +45,7 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr,
 	alist->max_addrs = nr;
 
 	for (i = 0; i < nr; i++) {
-		struct sockaddr_rxrpc *srx = &alist->addrs[i];
+		struct sockaddr_rxrpc *srx = &alist->addrs[i].srx;
 		srx->srx_family			= AF_RXRPC;
 		srx->srx_service		= service;
 		srx->transport_type		= SOCK_DGRAM;
@@ -281,7 +281,7 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 		return;
 
 	for (i = 0; i < alist->nr_ipv4; i++) {
-		struct sockaddr_in *a = &alist->addrs[i].transport.sin;
+		struct sockaddr_in *a = &alist->addrs[i].srx.transport.sin;
 		u32 a_addr = ntohl(a->sin_addr.s_addr);
 		u16 a_port = ntohs(a->sin_port);
 
@@ -298,7 +298,7 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	srx = &alist->addrs[i];
+	srx = &alist->addrs[i].srx;
 	srx->srx_family = AF_RXRPC;
 	srx->transport_type = SOCK_DGRAM;
 	srx->transport_len = sizeof(srx->transport.sin);
@@ -321,7 +321,7 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 		return;
 
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-		struct sockaddr_in6 *a = &alist->addrs[i].transport.sin6;
+		struct sockaddr_in6 *a = &alist->addrs[i].srx.transport.sin6;
 		u16 a_port = ntohs(a->sin6_port);
 
 		diff = memcmp(xdr, &a->sin6_addr, 16);
@@ -338,7 +338,7 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	srx = &alist->addrs[i];
+	srx = &alist->addrs[i].srx;
 	srx->srx_family = AF_RXRPC;
 	srx->transport_type = SOCK_DGRAM;
 	srx->transport_len = sizeof(srx->transport.sin6);
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index daaf3810cc9256..3dd24842f277ba 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -153,12 +153,12 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_FS_SERVICE) {
 		server->probe.is_yfs = true;
 		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-		alist->addrs[index].srx_service = call->service_id;
+		alist->addrs[index].srx.srx_service = call->service_id;
 	} else {
 		server->probe.not_yfs = true;
 		if (!server->probe.is_yfs) {
 			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-			alist->addrs[index].srx_service = call->service_id;
+			alist->addrs[index].srx.srx_service = call->service_id;
 		}
 		cap0 = ntohl(call->tmp);
 		if (cap0 & AFS3_VICED_CAPABILITY_64BITFILES)
@@ -182,7 +182,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	spin_unlock(&server->probe_lock);
 
 	_debug("probe %pU [%u] %pISpc rtt=%u ret=%d",
-	       &server->uuid, index, &alist->addrs[index].transport,
+	       &server->uuid, index, &alist->addrs[index].srx.transport,
 	       rtt_us, ret);
 
 	return afs_done_one_fs_probe(call->net, server);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 771880d4b010d7..d1287cc3d9381b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -87,7 +87,9 @@ struct afs_addr_list {
 	enum dns_lookup_status	status:8;
 	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
 	unsigned long		responded;	/* Mask of addrs that responded */
-	struct sockaddr_rxrpc	addrs[] __counted_by(max_addrs);
+	struct {
+		struct sockaddr_rxrpc	srx;
+	} addrs[] __counted_by(max_addrs);
 #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
 
@@ -972,6 +974,8 @@ extern void afs_put_addrlist(struct afs_addr_list *);
 extern struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *,
 						      const char *, size_t, char,
 						      unsigned short, unsigned short);
+bool afs_addr_list_same(const struct afs_addr_list *a,
+			const struct afs_addr_list *b);
 extern struct afs_vlserver_list *afs_dns_query(struct afs_cell *, time64_t *);
 extern bool afs_iterate_addresses(struct afs_addr_cursor *);
 extern int afs_end_cursor(struct afs_addr_cursor *);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 2a0c83d7156598..ab9cd986cfd9e1 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -307,7 +307,7 @@ static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 		for (i = 0; i < alist->nr_addrs; i++)
 			seq_printf(m, " %c %pISpc\n",
 				   alist->preferred == i ? '>' : '-',
-				   &alist->addrs[i].transport);
+				   &alist->addrs[i].srx.transport);
 	}
 	seq_printf(m, " info: fl=%lx rtt=%d\n", vlserver->flags, vlserver->rtt);
 	seq_printf(m, " probe: fl=%x e=%d ac=%d out=%d\n",
@@ -399,7 +399,7 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   alist->version, alist->responded, alist->failed);
 	for (i = 0; i < alist->nr_addrs; i++)
 		seq_printf(m, "    [%x] %pISpc%s\n",
-			   i, &alist->addrs[i].transport,
+			   i, &alist->addrs[i].srx.transport,
 			   alist->preferred == i ? "*" : "");
 	return 0;
 }
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a840c3588ebbbc..abe020f1a63a06 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -409,7 +409,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 	_debug("address [%u] %u/%u %pISp",
 	       op->index, op->ac.index, op->ac.alist->nr_addrs,
-	       &op->ac.alist->addrs[op->ac.index].transport);
+	       &op->ac.alist->addrs[op->ac.index].srx.transport);
 
 	_leave(" = t");
 	return true;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 43154c70366ae1..6fba45bc52476f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -296,7 +296,7 @@ static void afs_notify_end_request_tx(struct sock *sock,
  */
 void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 {
-	struct sockaddr_rxrpc *srx = &ac->alist->addrs[ac->index];
+	struct sockaddr_rxrpc *srx = &ac->alist->addrs[ac->index].srx;
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
@@ -468,7 +468,7 @@ static void afs_log_error(struct afs_call *call, s32 remote_abort)
 		max = m + 1;
 		pr_notice("kAFS: Peer reported %s failure on %s [%pISp]\n",
 			  msg, call->type->name,
-			  &call->alist->addrs[call->addr_ix].transport);
+			  &call->alist->addrs[call->addr_ix].srx.transport);
 	}
 }
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index f92ce4b7d73a19..b068711301ebb3 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -43,7 +43,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 			hlist_for_each_entry_rcu(server, &net->fs_addresses6, addr6_link) {
 				alist = rcu_dereference(server->addresses);
 				for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-					b = &alist->addrs[i].transport.sin6;
+					b = &alist->addrs[i].srx.transport.sin6;
 					diff = ((u16 __force)a->sin6_port -
 						(u16 __force)b->sin6_port);
 					if (diff == 0)
@@ -59,7 +59,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 			hlist_for_each_entry_rcu(server, &net->fs_addresses4, addr4_link) {
 				alist = rcu_dereference(server->addresses);
 				for (i = 0; i < alist->nr_ipv4; i++) {
-					b = &alist->addrs[i].transport.sin;
+					b = &alist->addrs[i].srx.transport.sin;
 					diff = ((u16 __force)a->sin_port -
 						(u16 __force)b->sin_port);
 					if (diff == 0)
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index b2cc10df95308c..9580b03d849389 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -94,8 +94,8 @@ static int afs_compare_fs_alists(const struct afs_server *server_a,
 	lb = rcu_dereference(server_b->addresses);
 
 	while (a < la->nr_addrs && b < lb->nr_addrs) {
-		const struct sockaddr_rxrpc *srx_a = &la->addrs[a];
-		const struct sockaddr_rxrpc *srx_b = &lb->addrs[b];
+		const struct sockaddr_rxrpc *srx_a = &la->addrs[a].srx;
+		const struct sockaddr_rxrpc *srx_b = &lb->addrs[b].srx;
 		int diff = afs_compare_addrs(srx_a, srx_b);
 
 		if (diff < 0) {
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index 58452b86e67270..bdd9372e3fb2a5 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -106,12 +106,12 @@ void afs_vlserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_VL_SERVICE) {
 		server->probe.flags |= AFS_VLSERVER_PROBE_IS_YFS;
 		set_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-		alist->addrs[index].srx_service = call->service_id;
+		alist->addrs[index].srx.srx_service = call->service_id;
 	} else {
 		server->probe.flags |= AFS_VLSERVER_PROBE_NOT_YFS;
 		if (!(server->probe.flags & AFS_VLSERVER_PROBE_IS_YFS)) {
 			clear_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-			alist->addrs[index].srx_service = call->service_id;
+			alist->addrs[index].srx.srx_service = call->service_id;
 		}
 	}
 
@@ -131,7 +131,7 @@ void afs_vlserver_probe_result(struct afs_call *call)
 	spin_unlock(&server->probe_lock);
 
 	_debug("probe [%u][%u] %pISpc rtt=%u ret=%d",
-	       server_index, index, &alist->addrs[index].transport, rtt_us, ret);
+	       server_index, index, &alist->addrs[index].srx.transport, rtt_us, ret);
 
 	afs_done_one_vl_probe(server, have_result);
 }
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index eb415ce563600e..e52b9d4c8a0ab9 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -249,7 +249,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 
 	_debug("VL address %d/%d", vc->ac.index, vc->ac.alist->nr_addrs);
 
-	_leave(" = t %pISpc", &vc->ac.alist->addrs[vc->ac.index].transport);
+	_leave(" = t %pISpc", &vc->ac.alist->addrs[vc->ac.index].srx.transport);
 	return true;
 
 next_server:
-- 
2.53.0

