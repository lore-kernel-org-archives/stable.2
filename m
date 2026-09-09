Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA4367F25
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976325; cv=none; b=IbuQkiV9C7tXPUTwOUOyrw2bCgs8J3RLSreDozyiR8ugwtdIvxPNp4Bq/o2L5rvCqvtO792zZ4m0JDXqVb4012iWhUwj1Nt/q71Vf1tRV4QTWH2w9G4XjC8vb2zOR3HwX8Mfq4IDLKXLACgX5a8a2C+ol1OetRHTYHUbH3Yqo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976325; c=relaxed/simple;
	bh=eJXcxgr9XkAE0pXsrFGk/cbL+ePx7b46GONb8eyAX10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCudNXxqyMVgYOaSMB1G5COrfv6JB6NJSzGc6pO65l6KMLojKXd4FnAaMlOxLSYfHx8LWZRgzlm4x3cUG8TQbHYMjuOgp3LT9HPiQhuAFph4QzDMnR9v8ZeQhoMAy/WqV/2xC3HQJoDvHDYxDMZERki+aIOGlscqjHjxtE4JfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5kRzxlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5kRzxlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFE61F0089A;
	Wed,  9 Sep 2026 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976324;
	bh=KxJ1Pax3efyYOxo2MGTO+YkubAw7YffAO7ZU7El9QKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5kRzxlpypTxjogBUPfTWiJnxwFb3QBmIYLQ5fxDyXyVpySdHRqAEMvNyGdMLt1a0
	 2jHJf+VkoMbjU6iBJCFOK2yg+uqz/rc3omr0v4K6jDFr+BzaGiDGqu12oLqkTE5vzZ
	 5CR1CEX5BldNAxQIAUsrGJk7rbyISUEdL5mgr7g6wtibqBTar8NK/D89tXy3IRzQ6R
	 u0NZmlYHpAgO/qxRdYCrnPamiAZkZ/DJgQRGvCWE089doQctJeEm1v9fOvlgS2/P6S
	 FczKaK8I0TwbdxWjmwbY9u/Zko1IokxrcEpUWOeTPRPwmgmoDPpWgSnK+I3vCoR6IO
	 ImcPdL0Ky3Kog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/6] net: l2tp: do not propagate multicast notification errors
Date: Wed,  9 Sep 2026 13:51:57 -0400
Message-ID: <20260909175157.3360687-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909175157.3360687-1-sashal@kernel.org>
References: <2026090341-mustiness-pedicure-fa05@gregkh>
 <20260909175157.3360687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_netlink.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 9967c7d68e53d..550591910fffe 100644
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
 	l2tp_tunnel_put(tunnel);
 
 out:
@@ -304,8 +304,8 @@ static int l2tp_nl_cmd_tunnel_modify(struct sk_buff *skb, struct genl_info *info
 		goto out;
 	}
 
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
-				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
+	l2tp_tunnel_notify(&l2tp_nl_family, info,
+			   tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
 	l2tp_tunnel_put(tunnel);
 
@@ -637,8 +637,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 	if (ret >= 0) {
 		session = l2tp_tunnel_get_session(tunnel, session_id);
 		if (session) {
-			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
-						  L2TP_CMD_SESSION_CREATE);
+			l2tp_session_notify(&l2tp_nl_family, info, session,
+					    L2TP_CMD_SESSION_CREATE);
 			l2tp_session_put(session);
 		}
 	}
@@ -702,8 +702,8 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_TIMEOUT])
 		session->reorder_timeout = nla_get_msecs(info->attrs[L2TP_ATTR_RECV_TIMEOUT]);
 
-	ret = l2tp_session_notify(&l2tp_nl_family, info,
-				  session, L2TP_CMD_SESSION_MODIFY);
+	l2tp_session_notify(&l2tp_nl_family, info,
+			    session, L2TP_CMD_SESSION_MODIFY);
 
 	l2tp_session_put(session);
 
-- 
2.53.0

