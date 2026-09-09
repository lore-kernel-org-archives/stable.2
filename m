Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21E3E3156
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984416; cv=none; b=m7jo4pFIFKNfiCgdJcqnT02A52kISrjVWd/A3fhwBPQ1nHu8Q4TQPaE1vg9O98DiAReylQoqU+rx4BQxz49A7XqZ6rGSrIscciP7kVzKJDWvwyBKHYyq1vQWJnCNaBl+9hYq+oShfDN85iQwfUWYLHbVeO3ajYKtXjwzONikqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984416; c=relaxed/simple;
	bh=oXdnJJByE6mj0qPKzgNYnjN6KvHmdNlyToWxStD8JLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiPwb8j2AAj/A+6NptnBsVoW5OsJgfMHIt0tYCHpM/qycmVkjKI9RCb+ASg/kBJOEvl6jiq4Kf6Yuy/pwYKdOlKB7E2HSSoH8n+5lP3CAdv8cYAz737z9p6ZIZOc6wumfyJpZfzBy8svBgoH70WhCJp1txmWkWuGyWZOVDiVj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEG/OZgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEG/OZgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3501F00893;
	Wed,  9 Sep 2026 20:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984415;
	bh=zQ2T9ULSCx9/lNqNpRjCxeRlyXWmddCutsEXsg8sZ6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEG/OZgsLjd1fvjd7Oqrhr4S3areDYbb9ID/qISvFqWu6l0uFcUHMkeSSXaAW3kNP
	 i9U3HgE1eluVCZbqG7I+rd5oaAyugPndslMyqnPnXgMtzpmD4OIKfaIx+Ef7p6AmYR
	 BRtPO2GAXH/70OMdB0F2Fsvp7jK7kIhWvGXosWsjTosGLrjcR6WiA9G1USyHRay8iF
	 lsdPooHM6uilCVU+mLj3QSicSLy5X5XSGeYgCytS9q7VnU9kq5lIK8bfon8sHtMwyB
	 d/Wf7VlnzIWtlcxSAl9CbFDcvIMUrWFrKlR5p21Txow6sbjeag7q+5NPX1gmirYSvS
	 92ohmD0lm3MTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: l2tp: do not propagate multicast notification errors
Date: Wed,  9 Sep 2026 16:06:52 -0400
Message-ID: <20260909200652.3597187-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-wasp-unplowed-934c@gregkh>
References: <2026090342-wasp-unplowed-934c@gregkh>
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

