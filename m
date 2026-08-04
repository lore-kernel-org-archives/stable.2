Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C473EC829
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868143; cv=none; b=AmSoYSwMOmDLbimX3M1aHzvFquK7VylmCsUvahMGu1uuB6HgAWlRY0wNj2sPXdHcIdoCJjtdS84AJvzvYY5ZRQ7AuJ8+uW1D8Pr0q2wC6nGf2VknpmZnxgyt1gQTZNP8oj4X35uh/FXZ0QNAuwut5+30XccwZAMGoBCwMQm1ulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868143; c=relaxed/simple;
	bh=8SzRCQuFS1qINZ3B9dYJd8/CxVtDsvdY5deK8xuGcM8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZlB/SJ8+8Qs01Zs9QEy25iWwPEAe9K4lGXbX7Kvwywb6VDTqYOOaFoDDqtWB9PDQo8bLsDxI77MKSB4w+wmrnsNM/WoGOGxHet7a9JuEv6qL9wvZoUYbdL8TShqfUDN934FofzL3AMBhemOmErOV08elrZsekcNxwZS1WqQZe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcqnEppu; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcqnEppu"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so165363a91.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785868141; x=1786472941; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3J//U+nRRgQiZlzctcbv8oWbrwHlN/NoFANKEDTPLRM=;
        b=kcqnEppuwPmhWQzLFPwdnE3ZS1pP0wo7HfnNSVs+2hOxYalRghPX/j3vnGJYKyCYIV
         lpdjMyFxRcrfN+uiXn+bAstgDeIj6SjgjJT8E3y6FpgXW05R5yZ3NKU8/AxVkzVpLEEZ
         J6DUWFcDPZUT2BmMhv8vTPhO7ikVpz7AlIv/mW6NBeQ1F9TD6g9g3V67f51GMS/KxiBJ
         Y1lKxzb67TMzChbTw/jqlMz3G62WAfLR+9knhxEhgHYV+2ymh0zOfaV5fM1MxYS99DFL
         iXslDIjXQ7G8rHpy/ijluQ0mRzUXPihlf9qespfA9xF2lv35sBpq8pZ8XPTGk+MQr6wF
         V4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868141; x=1786472941;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3J//U+nRRgQiZlzctcbv8oWbrwHlN/NoFANKEDTPLRM=;
        b=Q4eJnwHiXByh4DppR8AjUvedC4ygZ1Y4WjbeJIsnemx9W/amIv57u1KNGH/wKNIQEr
         ByjBL1n1aqkufAZWNh9riOtKS4/ZTC8gSvf+3N25af6sxi01Un5yAeVjp5wEuM2fjqT2
         aND+P7ZvDE/Z4LjEDu+zMlHwL8mnwKo/IczgEBovG8SiztDnE9h5SolbgsmYgXiVnrq1
         eV6rlqEliq0fScW87CqxYaCcCd2Gxo55Jv0LLEqmmNr1AX3BmEqcWs1XFarEKG4jfz8S
         +JGXXaMF3gO7iUdj8SV6xOSryYVwaYB/PhSZH+b506U3GMCkdq218XqmFhYdiGxvwoUM
         Oa1g==
X-Gm-Message-State: AOJu0YwptF+Ws7X0Zx6fKOuEXr3f6b7V/dDHUtemIB6x7YHiOSIIiCz3
	xrR+EzN/D5QSwT8/ozIakvr7QkNp2JqKIP/gkQqA9q6/SjnLz6yldWzAYS/V5fHjW+cYXpD9PHU
	c3O/NthJOblPHMXfxCjqFuHV2jfyt6q0J3ZyuJCiRZAfgnkq2nMVqo0dS9llve3BHTP9zJumypU
	V79Pmxal/hqTxcxB1QaJEjTGS+YS/1hw0=
X-Received: from pglr34.prod.google.com ([2002:a63:5162:0:b0:c9d:3fc6:93f4])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9149:b0:3c4:4555:2c22
 with SMTP id adf61e73a8af0-3cb85f5bab3mr708957637.40.1785868140977; Tue, 04
 Aug 2026 11:29:00 -0700 (PDT)
Date: Tue,  4 Aug 2026 18:28:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804182841.452925-1-tkjos@google.com>
Subject: [PATCH 6.1.y] af_unix: Give up GC if MSG_PEEK intervened.
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jiexun Wang <wangjiexun2025@gmail.com>, 
	Leon Chen <leonchen.oss@139.com>, netdev@vger.kernel.org, 
	Igor Ushakov <sysroot314@gmail.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit e5b31d988a41549037b8d8721a3c3cae893d8670 ]

Igor Ushakov reported that GC purged the receive queue of
an alive socket due to a race with MSG_PEEK with a nice repro.

This is the exact same issue previously fixed by commit
cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").

After GC was replaced with the current algorithm, the cited
commit removed the locking dance in unix_peek_fds() and
reintroduced the same issue.

The problem is that MSG_PEEK bumps a file refcount without
interacting with GC.

Consider an SCC containing sk-A and sk-B, where sk-A is
close()d but can be recv()ed via sk-B.

The bad thing happens if sk-A is recv()ed with MSG_PEEK from
sk-B and sk-B is close()d while GC is checking unix_vertex_dead()
for sk-A and sk-B.

  GC thread                    User thread
  ---------                    -----------
  unix_vertex_dead(sk-A)
  -> true   <------.
                    \
                     `------   recv(sk-B, MSG_PEEK)
              invalidate !!    -> sk-A's file refcount : 1 -> 2

                               close(sk-B)
                               -> sk-B's file refcount : 2 -> 1
  unix_vertex_dead(sk-B)
  -> true

Initially, sk-A's file refcount is 1 by the inflight fd in sk-B
recvq.  GC thinks sk-A is dead because the file refcount is the
same as the number of its inflight fds.

However, sk-A's file refcount is bumped silently by MSG_PEEK,
which invalidates the previous evaluation.

At this moment, sk-B's file refcount is 2; one by the open fd,
and one by the inflight fd in sk-A.  The subsequent close()
releases one refcount by the former.

Finally, GC incorrectly concludes that both sk-A and sk-B are dead.

One option is to restore the locking dance in unix_peek_fds(),
but we can resolve this more elegantly thanks to the new algorithm.

The point is that the issue does not occur without the subsequent
close() and we actually do not need to synchronise MSG_PEEK with
the dead SCC detection.

When the issue occurs, close() and GC touch the same file refcount.
If GC sees the refcount being decremented by close(), it can just
give up garbage-collecting the SCC.

Therefore, we only need to signal the race during MSG_PEEK with
a proper memory barrier to make it visible to the GC.

Let's use seqcount_t to notify GC when MSG_PEEK occurs and let
it defer the SCC to the next run.

This way no locking is needed on the MSG_PEEK side, and we can
avoid imposing a penalty on every MSG_PEEK unnecessarily.

Note that we can retry within unix_scc_dead() if MSG_PEEK is
detected, but we do not do so to avoid hung task splat from
abusive MSG_PEEK calls.

Fixes: 118f457da9ed ("af_unix: Remove lock dance in unix_peek_fds().")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260311054043.1231316-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Using include/net/af_unix.h instead of net/unix/af_unix.h on 6.6 ]
Signed-off-by: Leon Chen <leonchen.oss@139.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    |  2 ++
 net/unix/garbage.c    | 79 ++++++++++++++++++++++++++++---------------
 3 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b1f82d74339ef1e1dd08febea9992bb84784eb22..339d41d9a58679acbcefb9f9de4b50d1edeb96eb 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -23,6 +23,7 @@ void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
+void unix_peek_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e5dc698416f090b87cc4f4c12ed58d73c7f9d74..a4fa3c279a465e1b254928872aeba113ac8d7461 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1778,6 +1778,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+
+	unix_peek_fpl(scm->fp);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 66fd606c43f45d2f745c08061379e3e9cfedc92d..1cdb54c61619f5d2023b4713184ab25a3134dab6 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -306,6 +306,25 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool gc_in_progress;
+static seqcount_t unix_peek_seq = SEQCNT_ZERO(unix_peek_seq);
+
+void unix_peek_fpl(struct scm_fp_list *fpl)
+{
+	static DEFINE_SPINLOCK(unix_peek_lock);
+
+	if (!fpl || !fpl->count_unix)
+		return;
+
+	if (!READ_ONCE(gc_in_progress))
+		return;
+
+	/* Invalidate the final refcnt check in unix_vertex_dead(). */
+	spin_lock(&unix_peek_lock);
+	raw_write_seqcount_barrier(&unix_peek_seq);
+	spin_unlock(&unix_peek_lock);
+}
+
 static bool unix_vertex_dead(struct unix_vertex *vertex)
 {
 	struct unix_edge *edge;
@@ -339,6 +358,36 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
+static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+
+static bool unix_scc_dead(struct list_head *scc, bool fast)
+{
+	struct unix_vertex *vertex;
+	bool scc_dead = true;
+	unsigned int seq;
+
+	seq = read_seqcount_begin(&unix_peek_seq);
+
+	list_for_each_entry_reverse(vertex, scc, scc_entry) {
+		/* Don't restart DFS from this vertex. */
+		list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+		/* Mark vertex as off-stack for __unix_walk_scc(). */
+		if (!fast)
+			vertex->index = unix_vertex_grouped_index;
+
+		if (scc_dead)
+			scc_dead = unix_vertex_dead(vertex);
+	}
+
+	/* If MSG_PEEK intervened, defer this SCC to the next round. */
+	if (read_seqcount_retry(&unix_peek_seq, seq))
+		return false;
+
+	return scc_dead;
+}
+
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -392,9 +441,6 @@ static bool unix_scc_cyclic(struct list_head *scc)
 	return false;
 }
 
-static LIST_HEAD(unix_visited_vertices);
-static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
-
 static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
 			    struct sk_buff_head *hitlist)
 {
@@ -460,9 +506,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 	}
 
 	if (vertex->index == vertex->scc_index) {
-		struct unix_vertex *v;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		/* SCC finalised.
 		 *
@@ -471,18 +515,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(v, &scc, scc_entry) {
-			/* Don't restart DFS from this vertex in unix_walk_scc(). */
-			list_move_tail(&v->entry, &unix_visited_vertices);
-
-			/* Mark vertex as off-stack. */
-			v->index = unix_vertex_grouped_index;
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(v);
-		}
-
-		if (scc_dead) {
+		if (unix_scc_dead(&scc, false)) {
 			unix_collect_skb(&scc, hitlist);
 		} else {
 			if (unix_vertex_max_scc_index < vertex->scc_index)
@@ -530,19 +563,11 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
-			list_move_tail(&vertex->entry, &unix_visited_vertices);
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(vertex);
-		}
-
-		if (scc_dead)
+		if (unix_scc_dead(&scc, true))
 			unix_collect_skb(&scc, hitlist);
 		else if (!unix_graph_maybe_cyclic)
 			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
@@ -553,8 +578,6 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
-static bool gc_in_progress;
-
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
-- 
2.55.0.571.g244d577d93-goog

