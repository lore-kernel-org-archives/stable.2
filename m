Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610725B0A3;
	Thu, 30 Jul 2026 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373304; cv=none; b=LOit8IPViBp9ldtztEIjGhX3zgS1AaJsGLZHCTrjOi/7+bNG2Dne8Y5E75VoDXCme/AqpPl435f/t2b7fsxdMRZO0Nd9WE82DS8BK0Y1r9lYfxFmAAKgsoPro37tQ1DrYMBJNKhE34J6X6VsY3+bLhlnXxVVVJ2CDA6l5gt41Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373304; c=relaxed/simple;
	bh=pi3zZwULObg8Eamrw+MqiQZ4y6m4V2Efax2sz77kpJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQdKesQstXBYnim+im2YvbvPDtJdCcb3jis1k4dZ4ST77dF6MQUNCdIxWFEbhIfEqni0jgwrJ0f6+GbOhGuUEhjzF5yw8JmrjKKs6Jm6jDBt1p539SW8li8OdTyFbNmUzPcq8+UP2uOfeG2jNIpt8wmg27Pd5PRKjTYNgNgZAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U83PAzsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U83PAzsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0433F1F000E9;
	Thu, 30 Jul 2026 01:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373302;
	bh=nNlZpQ9KudagL/Hz3K0GKIET9gs5KkckAUwagpmKf8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U83PAzsapLky/9sJYrldGYbHaiKA8Tt++YeE8Ct104ZlWgfzQNXtIIZpnSxp++3s7
	 2B4sdf/ccWhXg9681rJpuZNiKmvwNy7JDuPGFEppP0LdVop6SfSYL+UJkBMCjXEvfP
	 lZq8zD4CbVLvzMhpfKxxwNjbLzqkFko5Awns8OTpp7tNCl9oAf0TDLxkot9Jmcoeao
	 kHruujPf6oW946phoz51xv3Efo8a7F20LBZRaw4CY/1TNZPLU3k7Q17n6cYnde8Wzq
	 U/4Yuq9eJA/Lbfi/7mPjYF1FI0lC7jnGvyV596+w+O69rpOdGg+u/eEQdPDPJGocPC
	 ChRl+s9+uKo5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/9] afs: Improve server refcount/active count tracing
Date: Wed, 29 Jul 2026 21:01:32 -0400
Message-ID: <20260730010140.1700208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072127-dress-overplay-421f@gregkh>
References: <2026072127-dress-overplay-421f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 76daa300d41acc1180f8a46eead36905054beafb ]

Improve server refcount/active count tracing to distinguish between simply
getting/putting a ref and using/unusing the server record (which changes
the activity count as well as the refcount).  This makes it a bit easier to
work out what's going on.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-10-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20250310094206.801057-6-dhowells@redhat.com/ # v4
Stable-dep-of: 26f17ce6fa3f ("afs: Fix premature cell exposure through /afs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/fsclient.c          |  4 ++--
 fs/afs/rxrpc.c             |  2 +-
 fs/afs/server.c            | 11 ++++++-----
 fs/afs/server_list.c       |  4 ++--
 include/trace/events/afs.h | 27 +++++++++++++++------------
 5 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 098fa034a1ccb4..a494657ba4aa90 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1650,7 +1650,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
 	bp = call->request;
 	*bp++ = htonl(FSGIVEUPALLCALLBACKS);
 
-	call->server = afs_use_server(server, afs_server_trace_give_up_cb);
+	call->server = afs_use_server(server, afs_server_trace_use_give_up_cb);
 	afs_make_call(call, GFP_NOFS);
 	afs_wait_for_call_to_complete(call);
 	ret = call->error;
@@ -1756,7 +1756,7 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 		return false;
 
 	call->key	= key;
-	call->server	= afs_use_server(server, afs_server_trace_get_caps);
+	call->server	= afs_use_server(server, afs_server_trace_use_get_caps);
 	call->peer	= rxrpc_kernel_get_peer(estate->addresses->addrs[addr_index].peer);
 	call->probe	= afs_get_endpoint_state(estate, afs_estate_trace_get_getcaps);
 	call->probe_index = addr_index;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index e9707624c5656c..fbaa8668018f19 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -184,7 +184,7 @@ static void afs_free_call(struct afs_call *call)
 	if (call->type->destructor)
 		call->type->destructor(call);
 
-	afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
+	afs_unuse_server_notime(call->net, call->server, afs_server_trace_unuse_call);
 	kfree(call->request);
 
 	o = atomic_read(&net->nr_outstanding_calls);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 5e40e1332259b4..cfade4a03484d0 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -33,7 +33,7 @@ struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer
 
 	do {
 		if (server)
-			afs_unuse_server_notime(net, server, afs_server_trace_put_find_rsq);
+			afs_unuse_server_notime(net, server, afs_server_trace_unuse_find_rsq);
 		server = NULL;
 		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
@@ -49,7 +49,7 @@ struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer
 		server = NULL;
 		continue;
 	found:
-		server = afs_maybe_use_server(server, afs_server_trace_get_by_addr);
+		server = afs_maybe_use_server(server, afs_server_trace_use_by_addr);
 
 	} while (need_seqretry(&net->fs_addr_lock, seq));
 
@@ -76,7 +76,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		 * changes.
 		 */
 		if (server)
-			afs_unuse_server(net, server, afs_server_trace_put_uuid_rsq);
+			afs_unuse_server(net, server, afs_server_trace_unuse_uuid_rsq);
 		server = NULL;
 		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
@@ -91,7 +91,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 			} else if (diff > 0) {
 				p = p->rb_right;
 			} else {
-				afs_use_server(server, afs_server_trace_get_by_uuid);
+				afs_use_server(server, afs_server_trace_use_by_uuid);
 				break;
 			}
 
@@ -273,7 +273,8 @@ static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
 }
 
 /*
- * Get or create a fileserver record.
+ * Get or create a fileserver record and return it with an active-use count on
+ * it.
  */
 struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 				     const uuid_t *uuid, u32 addr_version)
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index d20cd902ef949a..784236b9b2a9e0 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -16,7 +16,7 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 	if (slist && refcount_dec_and_test(&slist->usage)) {
 		for (i = 0; i < slist->nr_servers; i++)
 			afs_unuse_server(net, slist->servers[i].server,
-					 afs_server_trace_put_slist);
+					 afs_server_trace_unuse_slist);
 		kfree_rcu(slist, rcu);
 	}
 }
@@ -98,7 +98,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
 				afs_unuse_server(volume->cell->net, server,
-						 afs_server_trace_put_slist_isort);
+						 afs_server_trace_unuse_slist_isort);
 				continue;
 			}
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 4fcfb2411f9df2..527188f393caa3 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -132,22 +132,25 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_destroy,		"DESTROY  ") \
 	EM(afs_server_trace_free,		"FREE     ") \
 	EM(afs_server_trace_gc,			"GC       ") \
-	EM(afs_server_trace_get_by_addr,	"GET addr ") \
-	EM(afs_server_trace_get_by_uuid,	"GET uuid ") \
-	EM(afs_server_trace_get_caps,		"GET caps ") \
 	EM(afs_server_trace_get_install,	"GET inst ") \
-	EM(afs_server_trace_get_new_cbi,	"GET cbi  ") \
 	EM(afs_server_trace_get_probe,		"GET probe") \
-	EM(afs_server_trace_give_up_cb,		"giveup-cb") \
 	EM(afs_server_trace_purging,		"PURGE    ") \
-	EM(afs_server_trace_put_call,		"PUT call ") \
 	EM(afs_server_trace_put_cbi,		"PUT cbi  ") \
-	EM(afs_server_trace_put_find_rsq,	"PUT f-rsq") \
 	EM(afs_server_trace_put_probe,		"PUT probe") \
-	EM(afs_server_trace_put_slist,		"PUT slist") \
-	EM(afs_server_trace_put_slist_isort,	"PUT isort") \
-	EM(afs_server_trace_put_uuid_rsq,	"PUT u-req") \
-	E_(afs_server_trace_update,		"UPDATE")
+	EM(afs_server_trace_see_expired,	"SEE expd ") \
+	EM(afs_server_trace_unuse_call,		"UNU call ") \
+	EM(afs_server_trace_unuse_create_fail,	"UNU cfail") \
+	EM(afs_server_trace_unuse_find_rsq,	"UNU f-rsq") \
+	EM(afs_server_trace_unuse_slist,	"UNU slist") \
+	EM(afs_server_trace_unuse_slist_isort,	"UNU isort") \
+	EM(afs_server_trace_unuse_uuid_rsq,	"PUT u-req") \
+	EM(afs_server_trace_update,		"UPDATE   ") \
+	EM(afs_server_trace_use_by_addr,	"USE addr ") \
+	EM(afs_server_trace_use_by_uuid,	"USE uuid ") \
+	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
+	EM(afs_server_trace_use_get_caps,	"USE gcaps") \
+	EM(afs_server_trace_use_give_up_cb,	"USE gvupc") \
+	E_(afs_server_trace_wait_create,	"WAIT crt ")
 
 #define afs_volume_traces \
 	EM(afs_volume_trace_alloc,		"ALLOC         ") \
@@ -1369,7 +1372,7 @@ TRACE_EVENT(afs_server,
 		    __entry->reason = reason;
 			   ),
 
-	    TP_printk("s=%08x %s u=%d a=%d",
+	    TP_printk("s=%08x %s r=%d a=%d",
 		      __entry->server,
 		      __print_symbolic(__entry->reason, afs_server_traces),
 		      __entry->ref,
-- 
2.53.0

