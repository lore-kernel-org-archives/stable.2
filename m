Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6153B71B3
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030835; cv=none; b=b3pn46T7VVB0Pdhz3xpjpTRTKgKeLFD37CKuO0S3WnuJ97FLqhbEZ7SmDhsGp/6yBBySAnszG9IL6UahcsfKXLoLJk9kXVqhKUZv7LxTTzzqGAwBFDgiPl+/hwhSORjBCi54wpr056UCF7MWYVbU96yy5PuDdNdggd1DDIprDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030835; c=relaxed/simple;
	bh=Vb/5KnsTKRxWRLFIdSk/2toupC2rnKLLIO8HXG2On2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOPS8guGeZymMtd2RayG4cO06wKztE/hxMrl3Kr//9Y72saeKh19eeRtcTOAs2unCG0DnmpcCHEd2D1oWyBLiyQlCLhb+4EqXUHvHh3sbXxHFVoDa/aTcvR2FEEhEONynBYgTsiGuelrK36MHsfkBigCNYtvAxNWyxBHfeYSSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4/HOuZA; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4/HOuZA"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6de056f06beso685852eaf.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792030833; x=1792635633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Kg27R3pkV7krXMuhfJV/qZMSUa2AeQivhHxVAjt+Tw=;
        b=Q4/HOuZAvJnu5uhOKkNmh3N8u3MfClupsJha1gDqN0H6OO2H6rMomv2lzMuNdQSv7R
         PAm2yovva8R/KtAs25rrE+71JfG/8zre8rCl6Oj8/4b+7V/kcb0qCftaNbtp7iapQ5ju
         GI+ID8HimsAP64KUZaVEJ+JefiCm1uVE1ORguT2LY3sqM6aZUk01ujVNG5eeFsRtHDkE
         fH+UzVBNXlooaW8FCZjeTIssp2E72kDIOtkoejf6mOpCKpwIgdlirc/SsbSQYp0FcdX1
         b7IFppVXrA6AzAq1gwZncR30g0n4JqAEk0bM7JrXAYBapaLbiesVCua5iMA5r8Wp//Nd
         47LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030833; x=1792635633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Kg27R3pkV7krXMuhfJV/qZMSUa2AeQivhHxVAjt+Tw=;
        b=EbQ8+tPl3WmjL8AOq8ZKMUBaS39Ue98SPLvFJMFq97bEeUDYL6oYIYkBtGKImV1PGs
         pDko3xyaC06GFqangrjm3GBWX8WdD3FTvMtzKuSFxWyapUhA8GpiwFGY2uEgaADT0fMo
         +37zwhObhrfKHPHkUemzJ08nQ5I06cIAW0kYZOjRFU/hlDz4AlHtUCL4+iLHE4ebYWI7
         sjqeNYxMc/JBypEh7xcpJkYCXOKnuXVONwW69392uXaCzVMDhFYsHMtcF4vZW1xQGLv4
         tQG7YlkYbEoqleYGJdaD1YtYpIZJ/INn66cd0HbZCzSfcqqc3vf16J13PdWXcDkMd1+e
         3niA==
X-Forwarded-Encrypted: i=1; AKwUvByHhnq6VLJi9Dq2hdfl5QomcT+OgBgejSeF7xjeWZgov6d+4U5d8Lb5p8+lKj8Z+nNdOPVLoB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPJuqUWr+WfaGDOQgiQ4ENGGXI9MuRCdByLWTXvdJhYg/GKkRu
	qenS5AJCbD75fGACUtmLNUX/epwDRlor6+dbIYnac8CL6u7rzE5TMJWR
X-Gm-Gg: AYBFou3OSO0pWZZkb4SLRmtgv+cGMOwh4410RdfQFmxifYR6FssKsd/yP5YBmDPf8Oc
	FW7k8DNaHw5cmYeBNCbyGcynj0nZKMNkoJHkFV6jut4WuRM53VnuGmh3A9vws0tXyBlM67U8ehD
	DpwouWi1oRvvr+ZYnFTNjtQXl3pbVQ6U+SQihNxF77h4n+k/zhC5TL56ImhcPKTpSCssqDgnE3O
	bjiKvA4JgY93xInIFmES9AcE3Hj7ywBq1+yDkdv6fk2AqQSJRbtFWfplI9rdDrpYGx2AVtEfChw
	NpcIgocJ4Tx6+ueqB9albkrey59YpYbrxV3PrLwB1l46qmJ3O3N1Ey5TdGr4jQgf70YR2/NNbGJ
	4VmtZpjQOtFZhbxjjNtVz+Qd+HQlhMoq8ewxNr/Grti3lNtMwWbXMczQ3pS9l5rhQLADZCCfysf
	id+DR52i11zlADGmbYgnFJ4rjziHv7HLovqLDagk/YnKxlx/wushSO1g9PgujAiiD0Jb0CIjkPx
	M0+z/aobBps66jgVvxvw7bcsvbBuKiAb5H+VA==
X-Received: by 2002:a05:6820:c8d:b0:6cd:3fbd:1d61 with SMTP id 006d021491bc7-6ef12be060emr13390714eaf.75.1792030832637;
        Wed, 14 Oct 2026 19:20:32 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f56b25672bsm9561764eaf.11.2026.10.14.19.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:20:32 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Jon Maloy <jmaloy@redhat.com>,
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
Subject: [PATCH net v3] tipc: fix broadcast sender hang on last acker departure
Date: Thu, 15 Oct 2026 10:20:23 +0800
Message-ID: <20261015022023.1894729-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <AM7P189MB11376F05ED2439EDBC2AEE65C69D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <AM7P189MB11376F05ED2439EDBC2AEE65C69D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
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

 net/tipc/group.c  | 20 +++++++++++---------
 net/tipc/socket.c | 12 +++++++++++-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 74f6d3dac0784..b76edd5001ffa 100644
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
@@ -403,9 +404,10 @@ void tipc_group_update_bc_members(struct tipc_group *grp, int len, bool ack)
 		m = container_of(n, struct tipc_member, tree_node);
 		if (tipc_group_is_receiver(m)) {
 			tipc_group_update_member(m, len);
-			m->bc_acked = prev;
 			ackers++;
 		}
+		if (ack)
+			m->bc_pending = tipc_group_is_receiver(m);
 	}
 
 	/* Mark number of acknowledges to expect, if any */
@@ -800,9 +802,9 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
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
