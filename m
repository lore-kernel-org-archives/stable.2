Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE44E56C0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449863; cv=none; b=ZQ4oUWavnCqWG8ZJdSczvzEoDKWw2aMCHeCbvJd78gmuM8BTMGAp/Oh2pECkPuHx3IS1vxAaTaPRkiUS6sCbw4Pq1QIrWN8N7fk71/2ndXGkNtWJvWFhHqJqprdeGL/u8ihFiZsWkB52CvDeJk8WA3p1Br7aN54igoRb38MTKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449863; c=relaxed/simple;
	bh=5JHf00Zqj9gNaI8k6tw8cTlg4YthioOyS1OnKTr4CqI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hvK/8ni5kzJt3BoJcElSaYtMKcN4/9ujA9DAV57qDIpW7w/okY5cZfZdRWkghixkF91IJGsEcU2YZzyA+zGUD+vdaVVRB6RTaVJHzgPAS9jyn/q4nd934ODm2n9xd58TUcnzuCyjBXQIi4tCEwOuLb4+fcgZrYElO8z47KjR9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=toxsNoTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="toxsNoTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7231F000E9;
	Thu,  3 Sep 2026 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449862;
	bh=9b2GDNF2zJWtQTBDxJa3W38tzomgxHqC/8Io7SyQuOM=;
	h=Subject:To:Cc:From:Date;
	b=toxsNoTkV9nVvO6Rlb15qOvuWhDr/q0Nk3+m2eXrEdS/Huqd09lMKqTNccJQ/dOg4
	 kDYaDjGuu/z7UjFuqm7gFhkP+DSOpc8FYXnvx5CWO6PXyZjq95BYl6VP+FOuj75NQ+
	 8ynX8+8d2Izl0YmRgJ43W5eHkwNhtDRUrWXjJ8/U=
Subject: FAILED: patch "[PATCH] net: l2tp: do not propagate multicast notification errors" failed to apply to 5.10-stable tree
To: zihanx@nebusec.ai,horms@kernel.org,kuba@kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:06:42 +0200
Message-ID: <2026090342-wasp-unplowed-934c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x af20e269f7459d2ce69887fdf2fad7caf986c865
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090342-wasp-unplowed-934c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af20e269f7459d2ce69887fdf2fad7caf986c865 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Thu, 20 Aug 2026 18:40:28 +0000
Subject: [PATCH] net: l2tp: do not propagate multicast notification errors

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

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index c0c4d1ebc7a3..38aac59d052c 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -251,8 +251,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 		kfree(tunnel);
 		goto out;
 	}
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
-				 L2TP_CMD_TUNNEL_CREATE);
+	l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
+			   L2TP_CMD_TUNNEL_CREATE);
 	l2tp_tunnel_put(tunnel);
 
 out:
@@ -308,8 +308,8 @@ static int l2tp_nl_cmd_tunnel_modify(struct sk_buff *skb, struct genl_info *info
 		goto out;
 	}
 
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
-				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
+	l2tp_tunnel_notify(&l2tp_nl_family, info,
+			   tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
 	l2tp_tunnel_put(tunnel);
 
@@ -648,8 +648,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 		session = l2tp_session_get(net, tunnel->sock, tunnel->version,
 					   tunnel_id, session_id);
 		if (session) {
-			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
-						  L2TP_CMD_SESSION_CREATE);
+			l2tp_session_notify(&l2tp_nl_family, info, session,
+					    L2TP_CMD_SESSION_CREATE);
 			l2tp_session_put(session);
 		}
 	}
@@ -713,8 +713,8 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_TIMEOUT])
 		session->reorder_timeout = nla_get_msecs(info->attrs[L2TP_ATTR_RECV_TIMEOUT]);
 
-	ret = l2tp_session_notify(&l2tp_nl_family, info,
-				  session, L2TP_CMD_SESSION_MODIFY);
+	l2tp_session_notify(&l2tp_nl_family, info,
+			    session, L2TP_CMD_SESSION_MODIFY);
 
 	l2tp_session_put(session);
 

