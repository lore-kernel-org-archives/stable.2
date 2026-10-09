Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739513F5BE6
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525376; cv=none; b=fxWipbyUCbnHMlZkCq3DCuoP7d7wBQLZcsbFkJk99Iy3Ypd7HgpibPpil+8fP+LnJMHKuy4aHQk+VvdEbgNrpnd3bKTRPYcYsHDdfJ2owrjsOrXEsK0x6BMP80b3KSGm9wFmxJkARxjppntlct7dK/SMD6RpOGL95OkELSkBdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525376; c=relaxed/simple;
	bh=0Cd7BRJTOwMBwlto6I1RgpvE5V4HZw5T6GNxqVD2h10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOY4OGpYB1GGJDzS8vysaow4fxMEfhCEyJpWInjqSP5anNePhiyOPBr4W1bQLlm+SBYJq3Tjd1nMgYZTYlKujfRYIzAhL835bYIEu+ABxJ5CJFK19Q683HvXUrrWJWw/XP5Li3Gts0Oq/uzvH+1FN1M1CX5RzuAlfo/gNtwJQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9kld79g; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9kld79g"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e1066971so2352580fac.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791525373; x=1792130173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBM96Z0acKI7hIHci4HfMZ4VWwlNJJJw6ZcLXrahmw0=;
        b=Y9kld79gHMe/lWTLg9dwyKVSjp3aIjP93TFwhRhltmOLMKUwSVFrbHKxxJiCOn36PU
         Gcpfr9fDOY0UuOr+o3pPAsAcAdv93FtFOz3NPcCPND8h8To8WTkQACV12nP5Rf+3qglj
         iuK/k7mtpt136yuPg07ccZJ4k7bsX3cPbuHvkzyBfG8hj4+NZw6EP8SDWHf7oGlXLjcK
         hw/rsxdaAVc+kZpZ8Alr3cwYegrmBUNiEjaS9ydSksnV3TNTwB+7wtGobshlf7fjPb8o
         S/+8gDdwh4h/W6pQsN9Go4o80v+KxC6sljZ/nZ7Nr/mIRkzZPtmSdsm3NGnWxhDggZOP
         Yl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525373; x=1792130173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBM96Z0acKI7hIHci4HfMZ4VWwlNJJJw6ZcLXrahmw0=;
        b=gKnOhCuFzV0V+mJuakjUeGnx7loKahX0XIWsFLWs1X5rEODuQPD5GADRYxnHDG5iGs
         GnQjmmfPdu1outWeIMt8AvN4slgAMt1JzF96livqskTGmi2k0gWi5FMDQKNP1ni+lR30
         qw67Lfmv4IV/hL1/Ok3UFqGvqzPOf1535VnlBXCxh5b8EZJpyBVhwTs1pfR7dULdgNQe
         fr78bH5l4uSsFWVzdmQ2xBdypb4E92fIxWTuyWMIXwvL3wHsQTNqvPd9K9PYRV2SJsS6
         hqCWw+Go7Tp+EdASqENfd0CbKPhR/66i+kHvZo6A/WE97o7wsGeOh35Rgip6wX5wv8xI
         yFoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuZSX6V6jbdkgsF9I9GnEzjdhYChnKnz0VBKOnEtv1th3kyLInyLjNgeA8OQnd6/+2TVcXpsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqr83Q+TLtHSfC6joAgfEw88FIzozBUxRxoG22AvOZCj/jDTuQ
	YDuJhlvVGxchvtJhhv25gj8LAz1On4KoQ/rqk4SlWc0nZUzsykBtt+nh
X-Gm-Gg: AYBFou0nuJrsZc90re5DMsSUg7HXPBA3T36btEl9EZSWThCtk9xooGyv3gI7N5AqXrC
	Ql7+/BczmxU9Y2B/usaI1V92/EU0gFYb3RvPjB7hkyD23upEmH4g/wSVxsNeRzmgBtASz8VhMHq
	vGCi4RAUPHFtZziQu1oBJXRHS0dT+3z28PTn/Z+DDD+wOMWHfmclLRLIVsByX+yvet9GABDuJhi
	X9YqcSWhIMw2Mxw3IqvRPWyqFP58RcUvQ3NtB8JThvbD7zOAOQCCChyvH878Wl2CGvpa0GGBJk9
	pPHkAFEIJJOHcqD7T5MgEGQCjtekpfzSuEQg25SYULZZYAh/Ogpv4jWnhPRau7AJO9H3D+UDwEH
	Y6jYwClmFeeHUJgi97dChrOBwW1gbm/r/ekwfz3b77ARaVQH8ZGdAJHysF/XnexO2qnLYyx72Og
	y6Q6Z77gylfAK+BuwOQSz+UMlwj694rXmSr6Hr/SG9r6Nq4+Dx81Q+lawsbrkOZxDmvXttOcc2E
	SXZljkJcU4NNibr9ADXDxiMzGIHQuKXYi3S7A==
X-Received: by 2002:a05:6870:3329:b0:49e:6d1c:a569 with SMTP id 586e51a60fabf-4a2a88e66a0mr909544fac.38.1791525373223;
        Thu, 08 Oct 2026 22:56:13 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a84a14c0sm1079723fac.3.2026.10.08.22.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:56:11 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Ying Xue <ying.xue@windriver.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tipc: fix broadcast sender hang and leak on last acker departure
Date: Fri,  9 Oct 2026 13:56:00 +0800
Message-ID: <20261009055601.2304158-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TIPC group broadcast senders are blocked in poll()/write() until all
members have acked the replicast.  When a departing member held the
last outstanding ack, tipc_group_delete_member() decrements
grp->bc_ackers to zero but never restores *grp->open nor wakes the
blocked senders; write() then sleeps until the send timeout and
poll() is never woken at all.  Commit 99cc2a62e07a ("tipc: reject
invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow")
noted this as a pre-existing issue.

Restore the open state exactly on the 1->0 acker transition in the
delete path, mirroring the GRP_ACK_MSG completion path, and invoke
sk->sk_write_space() from tipc_sk_filter_rcv() when the group just
became writable again.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 2f487712b893 ("tipc: guarantee that group broadcast doesn't bypass group unicast")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/tipc/group.c  |  9 ++++++---
 net/tipc/socket.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 74f6d3dac0784..e20eb612f82ce 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -340,9 +340,12 @@ static void tipc_group_delete_member(struct tipc_group *grp,
 	rb_erase(&m->tree_node, &grp->members);
 	grp->member_cnt--;

-	/* Check if we were waiting for replicast ack from this member */
-	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1))
-		grp->bc_ackers--;
+	/* If this member held the last outstanding replicast ack,
+	 * restore the open state so blocked broadcast senders can proceed.
+	 */
+	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1) &&
+	    !--grp->bc_ackers)
+		*grp->open = true;

 	list_del_init(&m->list);
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
