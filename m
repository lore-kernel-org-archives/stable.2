Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C63BB106
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984263; cv=none; b=Hcsj8PhHJHVdB4kHffmY1mAFXQk7DnGz9IUu37w9NVNvoKs9MG0yufd9MvGqJHjIqUy445KVIIuPxue5POCFSY6pamR4PdijnLzxjlu0WT1qHgkWyXjPO2qLZC/hUKKFdX9R+qxdRKJaBQYlV2rNTWNnAb54/UjUKAKC3lb+gAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984263; c=relaxed/simple;
	bh=oXdnJJByE6mj0qPKzgNYnjN6KvHmdNlyToWxStD8JLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9mO9p3yJBh1xu8hnGDPottI0ysb8lgQDEuu5dwnGOTbQFfkpTWF3ywHPMssoYj3XphWBOanuoMdeAB9oZ1W2mPBFfOTH8hS2QBJIzXOW8P0w9TGPLxw4oqI7qvuwlA1/NPXReuu23x6+w9y9JGkuS6+Df7dyr3TKtzsIvju+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jewS/mQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jewS/mQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13021F000FF;
	Wed,  9 Sep 2026 20:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984262;
	bh=zQ2T9ULSCx9/lNqNpRjCxeRlyXWmddCutsEXsg8sZ6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jewS/mQyxqJT+MNY+Dzph3BWKFz8xrlpcHEYQbWESkG66vWYIlKRK8r+8C33tP385
	 uSjvr1BoRixvGA/7XOQa4Ccq62nJkqYPW3RzQuBItlNHQfAZC9OB4lnFfzTzWwNNwH
	 WhMhftFoiykxZP0v3E77MMX5Cc3S/G/agq625pkxctawcSQ/CKmcw8nOeHla9nrDmL
	 1aDsrEngzWnHAZgJPEYdfglm5ApvWNDlRHPwdIokADo3cKoRTZGCnK1q1uw4D8c257
	 51b8J/VpS4lcECtZJ5otOKGnrjRTm3mgLJhAXgFm0gn+uxJtX0ZPmN6XpAqLM8L3NZ
	 Uxl/+IH3k5xFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: l2tp: do not propagate multicast notification errors
Date: Wed,  9 Sep 2026 16:04:19 -0400
Message-ID: <20260909200420.3595278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090341-cubicle-cattishly-1b0e@gregkh>
References: <2026090341-cubicle-cattishly-1b0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit af20e269f7459d2ce69887fdf2fad7caf986c865 ]

The tunnel create, tunnel modify, session create, and session modify
netlink handlers send multicast notifications through helpers that can fail
while allocating or encoding a message, or while multicasting it.

For tunnel and session create/modify, a notification is sent after the live
operation has completed. Returning a best-effort notification error as the
command result can therefore report failure for an operation that already
committed and can cause callers to retry and accumulate live objects.

Keep sending notifications for listener visibility, but do not propagate
their best-effort status as the command result. This also keeps the tunnel
modify command consistent with the other notification-only paths.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/54f48e812ca0424c47ffdb9a8182180921f7e6b2.1787247008.git.zihanx@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted context for Linux 5.15’s older reference-release and session lookup APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_netlink.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index f34ca225c2199..9481707176b37 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -247,8 +247,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 		kfree(tunnel);
 		goto out;
 	}
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
-				 L2TP_CMD_TUNNEL_CREATE);
+	l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
+			   L2TP_CMD_TUNNEL_CREATE);
 	l2tp_tunnel_dec_refcount(tunnel);
 
 out:
@@ -304,8 +304,8 @@ static int l2tp_nl_cmd_tunnel_modify(struct sk_buff *skb, struct genl_info *info
 		goto out;
 	}
 
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
-				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
+	l2tp_tunnel_notify(&l2tp_nl_family, info,
+			   tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
 	l2tp_tunnel_dec_refcount(tunnel);
 
@@ -637,8 +637,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 	if (ret >= 0) {
 		session = l2tp_tunnel_get_session(tunnel, session_id);
 		if (session) {
-			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
-						  L2TP_CMD_SESSION_CREATE);
+			l2tp_session_notify(&l2tp_nl_family, info, session,
+					    L2TP_CMD_SESSION_CREATE);
 			l2tp_session_dec_refcount(session);
 		}
 	}
@@ -700,8 +700,8 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_TIMEOUT])
 		session->reorder_timeout = nla_get_msecs(info->attrs[L2TP_ATTR_RECV_TIMEOUT]);
 
-	ret = l2tp_session_notify(&l2tp_nl_family, info,
-				  session, L2TP_CMD_SESSION_MODIFY);
+	l2tp_session_notify(&l2tp_nl_family, info,
+			    session, L2TP_CMD_SESSION_MODIFY);
 
 	l2tp_session_dec_refcount(session);
 
-- 
2.53.0

