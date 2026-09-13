Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4F38B7BA
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789274558; cv=none; b=L1VyF25/28Ey26RncdVxgDsdNTlaCxIhYUtfBmEkUr7l5Q85jknTS68kyUPOc0PsYWVYaXWd9WRn6kymrQXAjPt2QtWvTEtz4dmuDY3/tDbSJulzHFL8SD+wksAx1BIOWzEigNaZrtZkvjKCUVQGpplrBfuDJCezpZr8LHXos8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789274558; c=relaxed/simple;
	bh=3tI5HXN5sQjU+9xL52vBRW7azoV7w1XlKKo+f86JnbU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IJIgfq8qnAHXokGi0+VtVX8UWzkGoJuETsSo+D2RbRXWU9Cc8B1Z2ZmG0giyvY9bBeGBcmIVGsVZbuAQWnODinqBwQuTtXLRAD4lDSQP/HR2e8poBUzujegLSKgXqBbWrgOClIrFwABscyduyVIaQvxu4RxOAZHAJ9HV1sr69Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTcPU875; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTcPU875"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530e89b584cso19312661cf.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789274555; x=1789879355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3dFfX9ybNbrViB+vpg9SB5CjzFois/63//qb+LkBGOI=;
        b=UTcPU8754Cd0jY73jA/MxlXf3znr3cVOvv8nhQlywfTWTJvh92J6Xkq/CPJ2QfrtyW
         0wOeRdE+SqZRjHWKC6//PvgWOc5ymC28HYmj0BpyCLVd0ll+E2E/CfdCYKBp3wgjvzQ0
         Nfg6RLtQWZFXw5S7VDlQ4YxlGwGCKnAVq/ZORmU8bX+2p3dFg/BchE4KuDjfBpJNKLLs
         Ycp17wKFK9yITOz/Ar4Xyb37vtyiRnFZrnFezwcmlFB9IhGojVOtie324YPEsCp3YFcF
         SdN6un9HmeLiQ+Z1Ligk78q007w3bdS4yBVCYFU+BOlTF2Xgf1T9Xf/2pM5EM3xGvbSr
         UP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789274555; x=1789879355;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dFfX9ybNbrViB+vpg9SB5CjzFois/63//qb+LkBGOI=;
        b=DQH1wv4Eaj5QNm1v03c7UvkiDlHcnmigadCESao7H6ckDbV1DXA6z6ESwNjCZg1Afh
         9n6w+m3c7TM7x1evzFFdcXehdRbqQaUvhQqgUz/3IWwmERkohpbBtuoXOC94dO1jWqvT
         db1/vcIJ9G0VR017tK6AlEjCK1Fvr+m65PDhYTKABD4ucjjrsGtZC/MCKgpkLLLrhXAA
         jO9rptuegGnUX03UGr1i+KGbhgVK4AbWz8QysO57mS48MuqY18xjccllH9wWlUpXZWqo
         igWwvOJ2BbQWGGL3FTJpEeCZXpMdm7/OxzWJnstz6fOjqW364Z3aFMxrOgTfi+TtNUqV
         Z9sw==
X-Forwarded-Encrypted: i=1; AKwUvBx7Ka19PKcAx482XsrvJCsAC/d9zhHBCikiwhk9ZXkYKMmeDFig0faUmkYkTDlq/OPFMOXgvbA=@vger.kernel.org
X-Gm-Message-State: AFuF++kuSDJami9kWcMf+D8F4jHwnFKB5UvZGvwZwDvphcqD8jiu1Y0d
	e3razKfWr/MnfYp6GsKVTeOoJNlFXpeqxxooUo1SVcLaJXsHTf++9wiEmEmlJXGA25fs2dKYXWv
	NwvXn3EwHFX/zgg==
X-Received: from qtbkg23.prod.google.com ([2002:a05:622a:7617:b0:530:e326:b9da])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:410e:b0:530:fdd1:ae45 with SMTP id d75a77b69052e-530fdd1b17emr4271891cf.54.1789274555142;
 Sat, 12 Sep 2026 21:42:35 -0700 (PDT)
Date: Sun, 13 Sep 2026 04:42:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260913044233.193927-1-edumazet@google.com>
Subject: [PATCH net] tipc: reject invalid and unexpected GRP_ACK_MSG to
 prevent bc_ackers underflow
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, James Burton <jamesburton@meta.com>, stable@vger.kernel.org, 
	Oleh Konko <security@1seal.org>, Tung Nguyen <tung.quang.nguyen@est.tech>, 
	Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Commit 48a5fe38772b ("tipc: fix bc_ackers underflow on duplicate
GRP_ACK_MSG") rejected duplicate/stale ACKs in tipc_group_proto_rcv()
by returning early when less_eq(acked, m->bc_acked).

However, that check remains incomplete in two ways:

1. When grp->bc_ackers is zero (e.g. on a quiet group, when replicast
   ACKs were not requested, or after all expected members have already
   acknowledged), an unexpected GRP_ACK_MSG with acked > m->bc_acked
   passes less_eq() and unconditionally decrements grp->bc_ackers.
   Because bc_ackers is a u16, this wraps to 65535, causing
   tipc_group_bc_cong() to permanently report congestion and blocking
   all future group broadcasts on the socket.

2. During an active broadcast round (grp->bc_ackers > 0), the sender
   transmits packet S and advances grp->bc_snd_nxt to S + 1. Receivers
   increment their expected counter to S + 1 upon consuming packet S,
   so the only valid ACK value for the current round is strictly
   acked == grp->bc_snd_nxt.

   However, tipc_group_update_bc_members() initializes each member's
   m->bc_acked to prev = grp->bc_snd_nxt - 1 (S - 1 before increment).
   This leaves a 2-sequence gap (S - 1 to S + 1) in sequence space.
   An incoming ACK is therefore neither rejected as duplicate nor
   prevented from decrementing grp->bc_ackers if an unexpected or stale
   value (such as S) is received. A member sending acked = S followed
   by acked = S + 1 could decrement grp->bc_ackers twice in the same
   round, prematurely clearing bc_ackers or underflowing it.

Fix this by:
- Dropping GRP_ACK_MSG immediately if grp->bc_ackers is zero.
- Requiring acked == grp->bc_snd_nxt and rejecting duplicates where
  m->bc_acked == acked. Because replicast broadcast rounds are strictly
  sequential, only grp->bc_snd_nxt can be acknowledged, and each member
  can acknowledge at most once per round.

Note that a related pre-existing issue in tipc_group_delete_member()
(where grp->bc_ackers decrementing to zero upon member departure does
not restore *grp->open or trigger a socket wakeup) will be addressed
in a separate patch.

Fixes: 48a5fe38772b ("tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG")
Fixes: 2f487712b893 ("tipc: guarantee that group broadcast doesn't bypass group unicast")
Reported-by: James Burton <jamesburton@meta.com>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Oleh Konko <security@1seal.org>
Cc: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>
---
 net/tipc/group.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 14e6732624e28edc20ff80163787bca3018cb2dd..74f6d3dac0784d5a54db3e2202ead3878d8df9e2 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -797,10 +797,10 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
 		tipc_group_open(m, usr_wakeup);
 		return;
 	case GRP_ACK_MSG:
-		if (!m)
+		if (!m || !grp->bc_ackers)
 			return;
 		acked = msg_grp_bc_acked(hdr);
-		if (less_eq(acked, m->bc_acked))
+		if (acked != grp->bc_snd_nxt || m->bc_acked == acked)
 			return;
 		m->bc_acked = acked;
 		if (--grp->bc_ackers)
-- 
2.55.0.1007.g17ff1f9808-goog

