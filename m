Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABA4E1412
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411154; cv=none; b=Kz9V0z9O1NqF/tVBAV5eNB0Kzfe3Xugr2t4+xoiWcFqyhLJRn52bFmGotdE1lCqgIO20eMU4a9z6msb84IdSJivFQR/nXCJMHpd8Z4LegOl9O1otO/43SrfraDQicY06L1f40+0G7jkY1dFmwASwRVwC9YMOO5e+TEtnweqtusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411154; c=relaxed/simple;
	bh=v2kbENe1Gg16GvJP/V2xAlfnNkYrM6uk/4A1vvTDCQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvKkuIzmAigYvwZnrQ0kZ6KgdJmVbSZ1qVcD1qTenY57IyrXtowenMQRlS6T/F0PUJW6SOJXoz5gPD6wwVdIeyob3jYTRdSziuQyCA0A4YKxr2wzPWmib7IAHXoYCw4vvDiXBkFc0zt7yWxi7rZB+fyn/5TF7aNRdbuonuXucak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/VA0W+R; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/VA0W+R"
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-70399d7f076so957737eaf.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411151; x=1793015951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YosuWQAMqgNnl5wsrtp23mKOAS1Y5WXgHfA79f3F4k=;
        b=s/VA0W+RWEwBfpwDXyPrMsig8sxTan6aJb7bJQCo7L9KtJOC1SQwEb97fz0OQ7HJLc
         Z0yW4o7lwM2PeKk9ZC/t3AjJvK5XSpAyYSYypSWU3V4Ym7y0m2+v+SCcoqNy4amybOoX
         7HlUxfBkEvDLs7U7TxhSg1Io/NN9795Jh9VZpImGaFWz9CP1ssXKJ4Ml7RSaQv5qDhOB
         fE3767prkceZvwU6IqZz30A23TnZ+qnVTwxr5BZhsh0qFHcUPXlAHTIjM1IENt/4/sxo
         ynrpd7d535P0mM6I2BIbgN0yCIpu/X8YwBsI5jW4ODRya0ClHWvUhlOjm8DYkQKeCiEs
         vIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411151; x=1793015951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YosuWQAMqgNnl5wsrtp23mKOAS1Y5WXgHfA79f3F4k=;
        b=r3J5HaSwBbX0vFiI6o72AHcIo3CLvavGag7x8gG6NTYJvxbzrVk90l3ITzOyLbBmkf
         9X1PReMFLP625IuT5TeXzBGpZS9iRfMlvZbpZoAqh364Mw11EKNTTEl3b5NmJQq/1QcB
         8JcLnC7YXfzjyO7Fjmf9YzmLg3Fd4u+uVod3U761bcwS7kzX+U129QxfQUIJigZp3NL6
         gDR1IgBx8DSL2Sq16+QC/TUzwGElUA9cc0BiT5LDPOq/hePNbClyISyNr8T7e4UP14+J
         yi9O9Ns0SNfBXKZV72W3JTI1vUW/qgICzr4ZdR3a5r+oLJQbpTac3VwvbOlrJs03t95N
         UDOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwap0XoV51+h3ulrdAA78+hs/YuK0y60vE+ltl18vBkVvsN/khPSedheBw2L9mIzrWB59w5tA8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0bEHSw+nom0l/KRQtTarVNvIP2usYNrHE5kSSoigdP0vxoYNl
	JCbR5gJi7n9pN1LCRiOs7PGy8f2z+2UoDzEKxDJu2/n1yKnLDwIYjGap
X-Gm-Gg: AYBFou24NcDKn8bmeMRQKyXykM+iKVdaCu3JfA0Cpwcc6ABwPjAwbAwedGWt0h/vEdx
	0lgbCa1MPwcj58UgtDeBhImVpje6bExQJKp2i3djZ21d9zaqx/r1JcOxBtmNq7l+bq8sGnpBzsN
	jwnzHj5gyaaqnvz0mWcqMSheeC6yB7epbAK5OcsAUmSOA/Q9veoFAiwAumxudoYDhxTrioeKwoK
	MVAelA/nwcpCbguyHgCCRKjHgtd+eVIw1FaMovBMRfl1xek1fAbXhNX8G+25Y7HnqFkHfz1tqdu
	utQ3Eehn4BgEkt51Lsdg/tGgegjZ/KZWdTrig0tsvufrRO3nnj9fYv2vppbCy10mx+IJf8vTNzD
	9+lzls5VgfTblzncMerHZrii5NW7H4KfiE2nD6Vj/R5mvuobyHIsUJBG9wigcKD0KjOg76pvK7m
	YWScclMYqBsDNgFDfTBcZPxuhI5eO4ozhANnzx8e/vVNW/tApzXdFz3R+NdSJhqgCPtPvpU3EYp
	XIHc8Aafu9eChEX2obIBHCq858HkZkn4fV/Jg==
X-Received: by 2002:a05:6820:168e:b0:6fd:4277:16dc with SMTP id 006d021491bc7-703559911aamr4763075eaf.20.1792411151233;
        Mon, 19 Oct 2026 04:59:11 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-701900719c6sm7602973eaf.11.2026.10.19.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:59:09 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] tipc: fix broadcast sender hang on last acker departure
Date: Mon, 19 Oct 2026 19:58:59 +0800
Message-ID: <20261019115859.3471295-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <AM7P189MB113757F05921D6EAE994B0BEC6982@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <AM7P189MB113757F05921D6EAE994B0BEC6982@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TIPC group broadcast senders are blocked while a replicast still has
outstanding member acks: tipc_group_bc_cong() returns true as long as
grp->bc_ackers is non-zero, and clears *grp->open, which is what
tipc_poll() uses to report EPOLLOUT (via tsk->group_is_open).

When the last outstanding acker departs before acking,
tipc_group_delete_member() decrements grp->bc_ackers to zero but
never restores *grp->open.  As a result poll(EPOLLOUT) never fires
again.  A writer blocked in sendmsg() is only released if some other
wakeup happens after the deletion: with TIPC_GROUP_MEMBER_EVTS the
leave event delivery calls sk_data_ready() and wakes it, but without
member events nothing does and it sleeps indefinitely, since the
default send timeout is MAX_SCHEDULE_TIMEOUT.

Commit 99cc2a62e07a ("tipc: reject invalid and unexpected
GRP_ACK_MSG to prevent bc_ackers underflow") already calls this out
in its changelog as a pre-existing issue.

Restore the open state exactly on the 1->0 transition in the delete
path, mirroring the GRP_ACK_MSG completion path, and invoke
sk->sk_write_space() from tipc_sk_filter_rcv() when the group just
became writable again.

Also make the ack accounting precise.  The delete path used to test
less(m->bc_acked, grp->bc_snd_nxt - 1), which also matches members
that were never counted for the current replicast (JOINING/LEAVING
members keep a stale bc_acked), and the GRP_ACK_MSG handler accepted
an ack from any member whose bc_acked differed from the expected
value.  Either could zero bc_ackers on behalf of a member that owes
nothing and silently void an ack still owed by a real acker.  Track
whether a member owes an ack for the current replicast in a new
per-member bc_pending flag, set when the member is counted and
cleared when its ack arrives, and use it both to accept an ack and
to decide on deletion.  bc_acked has no remaining user and is
removed.  Suggested by Tung Quang Nguyen.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 2f487712b893 ("tipc: guarantee that group broadcast doesn't bypass group unicast")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v4: Assign bc_pending inside the receiver loop body in the simple
    form requested by Jon Maloy (m->bc_pending = ack); bc_ackers==0
    implies no member has bc_pending set (a pending flag is cleared
    either by the member's ack or by its deletion), so skipping
    non-receivers cannot leave stale state.

v3: Correct the changelog: tipc_group_bc_cong() only writes *grp->open,
    and a blocked sendmsg() hangs only when nothing wakes it after the
    deletion (e.g. member events disabled); also require bc_pending
    in the GRP_ACK_MSG handler so an uncounted member cannot decrement
    bc_ackers, and drop the now unused bc_acked field.

v2: Subject no longer claims a leak; add the reproduction; the delete
    path now discriminates members that were actually counted for the
    current replicast via a new per-member bc_pending flag instead
    of comparing a possibly stale bc_acked (Tung Quang Nguyen).

Reproduction (two QEMU guests, TIPC over UDP bearer, groups joined
without member events; the acking peer withheld GRP_ACK_MSG via a
test-only knob to emulate the lossy peer, the sender's kernel ran
unmodified TIPC):

    UNPATCHED (#88/#90, fix absent):
      sender:  NO POLLOUT for 30s after member departed -> STALL
      sender2: R2 NEVER returned in 32s (blocked writer not woken)
    PATCHED (#89, v1 of this patch):
      sender:  POLLOUT at t=18.5s, when the leave event was delivered
      sender2: R2 returned at t=18.6s, EHOSTUNREACH on now-empty group

 net/tipc/group.c  | 19 ++++++++++---------
 net/tipc/socket.c | 12 +++++++++++-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 74f6d3dac0784..0c6a762000b02 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -74,7 +74,7 @@ struct tipc_member {
 	u16 window;
 	u16 bc_rcv_nxt;
 	u16 bc_syncpt;
-	u16 bc_acked;
+	bool bc_pending;
 };
 
 struct tipc_group {
@@ -316,7 +316,6 @@ static struct tipc_member *tipc_group_create_member(struct tipc_group *grp,
 	m->node = node;
 	m->port = port;
 	m->instance = instance;
-	m->bc_acked = grp->bc_snd_nxt - 1;
 	ret = tipc_group_add_to_tree(grp, m);
 	if (ret < 0) {
 		kfree(m);
@@ -340,9 +339,12 @@ static void tipc_group_delete_member(struct tipc_group *grp,
 	rb_erase(&m->tree_node, &grp->members);
 	grp->member_cnt--;
 
-	/* Check if we were waiting for replicast ack from this member */
-	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1))
-		grp->bc_ackers--;
+	/* If this member owed an ack for the current replicast and it
+	 * was the last one, restore the open state so blocked broadcast
+	 * senders can proceed.
+	 */
+	if (grp->bc_ackers && m->bc_pending && !--grp->bc_ackers)
+		*grp->open = true;
 
 	list_del_init(&m->list);
 	list_del_init(&m->small_win);
@@ -394,7 +396,6 @@ void tipc_group_update_member(struct tipc_member *m, int len)
 
 void tipc_group_update_bc_members(struct tipc_group *grp, int len, bool ack)
 {
-	u16 prev = grp->bc_snd_nxt - 1;
 	struct tipc_member *m;
 	struct rb_node *n;
 	u16 ackers = 0;
@@ -403,8 +404,8 @@ void tipc_group_update_bc_members(struct tipc_group *grp, int len, bool ack)
 		m = container_of(n, struct tipc_member, tree_node);
 		if (tipc_group_is_receiver(m)) {
 			tipc_group_update_member(m, len);
-			m->bc_acked = prev;
 			ackers++;
+			m->bc_pending = ack;
 		}
 	}
 
@@ -800,9 +801,9 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
 		if (!m || !grp->bc_ackers)
 			return;
 		acked = msg_grp_bc_acked(hdr);
-		if (acked != grp->bc_snd_nxt || m->bc_acked == acked)
+		if (acked != grp->bc_snd_nxt || !m->bc_pending)
 			return;
-		m->bc_acked = acked;
+		m->bc_pending = false;
 		if (--grp->bc_ackers)
 			return;
 		list_del_init(&m->small_win);
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d5d70eb230b56..65cc0c4964b31 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2356,8 +2356,18 @@ static void tipc_sk_filter_rcv(struct sock *sk, struct sk_buff *skb,
 	if (unlikely(!msg_isdata(hdr)))
 		tipc_sk_proto_rcv(sk, &inputq, xmitq);
 
-	if (unlikely(grp))
+	if (unlikely(grp)) {
+		bool was_open = tsk->group_is_open;
+
 		tipc_group_filter_msg(grp, &inputq, xmitq);
+		/* A departing member may have held the last outstanding
+		 * replicast ack, which can restore the open state inside
+		 * tipc_group_filter_msg(); wake up senders blocked in
+		 * poll()/write() if the group just became writable.
+		 */
+		if (!was_open && tsk->group_is_open)
+			sk->sk_write_space(sk);
+	}
 
 	if (unlikely(!grp) && mtyp == TIPC_MCAST_MSG)
 		tipc_mcast_filter_msg(net, &tsk->mc_method.deferredq, &inputq);
-- 
2.43.7
