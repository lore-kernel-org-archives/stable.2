Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CA4A0127
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819252; cv=none; b=Fgl7sqb+nPHcIdmOHHBlnc0skSReRs7hzNpExjZZYI2gDofgNTfT8yHo7771zD8YhoEpnFr0YFqkgJT4WceAmGQIOLJ4MRBDATOQ+MYS6SN/TwqiTt7Y3vRp7N2Z6M/nkwdRAO4pUBheLx6SjNTTIPhQXNWWnpNDM3zCq7PZ2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819252; c=relaxed/simple;
	bh=nAu3ZVRMYQC2AoGQ3nSWEl3h3H5j+54En4gscuWuZbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyBacZYIKF6+niTVLZFbo4vRJJUFmBxU/+2taE0H3yjhRhGSjM4a9DFJ3kbYCGoZS+EnYelV98AMlSZACApsvJ7NrmhWcJMvKJAwSlBZH1b4F8dxq+1tgdb5isQiGaLtE2/rZgjWMN0vMNoy10tM+GPYdicFSZz8LM63qSvt8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNOthILa; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNOthILa"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4b94bb43008so251654b6e.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791819249; x=1792424049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSBqC/hD/Ly2AYbmjcrAztV3m8h2DttoWUWYtWCfyss=;
        b=QNOthILauayXohnPwGj5vbx67/Czhn2tTG5Qwd88GtRQOH6gtySETKpkttIk8oNexd
         /q2+dJczkhoi0RQOMogYdFDlywj1XRgZsCnvTQfiNvJRNzMqffmpQjrqXK+ZSrWJHwKU
         JlWtke0rjjXle4hOMwXdqIrs5tampqltkFKMwEJBxcx3U1ioO1NdNFO6B7dhRChBtQdu
         cXMjbijnik7E2ssiWdF+hIEaKGuVlhQ0Tl8g/1quMEVYbxNHmrVE48rcIwsowGm9I5Zg
         Moh5f+KYlntmVPDpnS3crm5RDS7SNLZf8c2liVraquQDxda0Bbqk/m8h8Cs4boWiBbqu
         FIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819249; x=1792424049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSBqC/hD/Ly2AYbmjcrAztV3m8h2DttoWUWYtWCfyss=;
        b=sAWebPFm4t2za9EBwewL7QZwwlhd4r8YDxaPFF3HxSxbKoZsg8XR8wpMRg7oq7boWW
         yefauH30nVesAhJP5B6z/vLLlOcVvBpgYNzn++xIOL4s6BQJ3f9WtX46KkMXqJZyKB4h
         UdSFi+qYEFNLUa1GDtFPq+5n/kmwZKLDzqAYUc/ZplMUZR3cX4F4BNjddmY8t/NS537Y
         pfLEiyyGJuYkCo04m+UFYCa3fEKR7nNCyDuwq5MAD3k+qzpWUu9c6riKhYrIwNA1CF6D
         MqDvH1dsbsb5rr1ErwwtwD1dEmGYY7+Fpa87309MspkbqRM9f15Mp6/0cduSwiu+DKQW
         7VcA==
X-Forwarded-Encrypted: i=1; AKwUvBzlh9tgbkAec31OSDN/bhV3OwJ2yke5CrnEJbmsI7Gln8QsdwZtbX3yXU8lWU/Fk18njJDEDwc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOazsEWdzP3KL6962CZ8D0UmJdFlVfiWerccdcxnsc2Vnd5TLC
	2ezSbSCrvNilUKWItM7bynHtBm5ffoqTm6oDB08uyWS/DycRdIdPT19r
X-Gm-Gg: AYBFou1c935wULN0+OVTqUe7YXdxuZqGxPtGMIjpDBXHjdcApednmdQDXmyGywirnSq
	APFGqxHlp62iWLR3HW9kGkgGLkrH2uKyDsQH235CteJrO+2Wn36Jcy8FCjoqyC7VdZtgKF9KXzt
	O6fF4qlWwAl61paWYfgplcFAXQW6BkMMR+vGb3zGLkh4dTvIMnG//q8X8f9qCqILWKsg0maXZoB
	jwwB+6jMJ6jXludUCVX7b+zvF0CRMnmYfa9M9dd4ZDJf9UOcbfJ21Hkxrnc9vdPz09S35si3N/3
	uMt/7Z3q2JDnis4C8H32pArZinoUervCHlIg0R3kcgcmgh0r+emqE+7XCvwAwKuH0YLEejoYRpA
	NKKfZbUJzhmFzZUtdeOvOKB6P4wGTLf479IgfpQYKLgypPFTaX+zqZFXeyn++6ysfcvg8iWL70j
	lU0uKrnaB1P3x1ueJyw88G3i4kyteuGs3M5S7L+8AlEDmCPt2o1s+jyVTX6FkcgEmLK/tTDAOnF
	pFOIg3zY/V72hShr9Ha7YZOifYIY+tFCKx7
X-Received: by 2002:a05:6808:138e:b0:4fb:ac9b:b076 with SMTP id 5614622812f47-50c5b473884mr8343784b6e.67.1791819249230;
        Mon, 12 Oct 2026 08:34:09 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a85edf81sm9920375fac.15.2026.10.12.08.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:34:08 -0700 (PDT)
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
Subject: [PATCH net v2] tipc: fix broadcast sender hang on last acker departure
Date: Mon, 12 Oct 2026 23:33:57 +0800
Message-ID: <20261012153357.1863316-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <AM7P189MB113731FB3655F88C6079EF1CC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <AM7P189MB113731FB3655F88C6079EF1CC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TIPC group broadcast senders are blocked while a replicast still has
outstanding member acks: poll(EPOLLOUT) only fires when
tsk->group_is_open, and writers keep re-sleeping on every unrelated
data-ready wakeup because tipc_group_bc_cong() keeps seeing
*grp->open == false (the default sk_sndtimeo is MAX_SCHEDULE_TIMEOUT,
so there is no bounded send timeout either).

When the last outstanding acker departs before acking,
tipc_group_delete_member() decrements grp->bc_ackers but never
restores *grp->open, and the blocked senders are never woken.
Commit 99cc2a62e07a ("tipc: reject invalid and unexpected
GRP_ACK_MSG to prevent bc_ackers underflow") already calls this out
in its changelog as a pre-existing issue.

Reproduced on a two-node TIPC group cluster (v7.3-rc5, two QEMU
guests over a UDP bearer): with one member's ack outstanding and
that member then departing, poll(POLLOUT) on the sender never
fired and a blocking sendmsg() never returned; with the fix
applied both are released when the leave event is delivered (log
below the fold).

Restore the open state exactly on the 1->0 transition in the delete
path, mirroring the GRP_ACK_MSG completion path, and invoke
sk->sk_write_space() from tipc_sk_filter_rcv() when the group just
became writable again.

While at it, make the accounting precise: the delete path used to
test less(m->bc_acked, grp->bc_snd_nxt - 1), which also matches
members that were never counted for the current replicast
(JOINING/LEAVING members keep a stale bc_acked).  Zeroing
bc_ackers on such a member could silently void a still-outstanding
ack from a real acker.  Track whether a member owes an ack for the
current replicast in a new per-member bc_pending flag, set when the
member is counted and cleared when its ack arrives, and test that
in the delete path instead.  Suggested by Tung Quang Nguyen.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 2f487712b893 ("tipc: guarantee that group broadcast doesn't bypass group unicast")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v2: Subject no longer claims a leak; describe the actual wakeup
    mechanics and add the reproduction; the delete path now
    discriminates members that were actually counted for the
    current replicast via a new per-member bc_pending flag instead
    of comparing a possibly stale bc_acked (Tung Quang Nguyen).

Reproduction (two QEMU guests, TIPC over UDP bearer; the acking
peer withheld GRP_ACK_MSG via a test-only knob to emulate the
lossy peer, the sender's kernel ran unmodified TIPC):

    UNPATCHED (#88/#90, fix absent):
      sender:  NO POLLOUT for 30s after member departed -> STALL
      sender2: R2 NEVER returned in 32s (blocked writer not woken)
    PATCHED (#89, this patch):
      sender:  POLLOUT at t=18.5s, when the leave event was delivered
      sender2: R2 returned at t=18.6s, EHOSTUNREACH on now-empty group

 net/tipc/group.c  | 13 ++++++++++---
 net/tipc/socket.c | 12 +++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 74f6d3dac0784..e9c77f12c9819 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -75,6 +75,7 @@ struct tipc_member {
 	u16 bc_rcv_nxt;
 	u16 bc_syncpt;
 	u16 bc_acked;
+	bool bc_pending;
 };
 
 struct tipc_group {
@@ -340,9 +341,12 @@ static void tipc_group_delete_member(struct tipc_group *grp,
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
@@ -406,6 +410,8 @@ void tipc_group_update_bc_members(struct tipc_group *grp, int len, bool ack)
 			m->bc_acked = prev;
 			ackers++;
 		}
+		if (ack)
+			m->bc_pending = tipc_group_is_receiver(m);
 	}
 
 	/* Mark number of acknowledges to expect, if any */
@@ -803,6 +809,7 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
 		if (acked != grp->bc_snd_nxt || m->bc_acked == acked)
 			return;
 		m->bc_acked = acked;
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
