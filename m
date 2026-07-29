Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608CF49250A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332763; cv=none; b=DZBctWfDBNCQ2ZOyz21ypZ477mhcEyaVz3TDFXz8QuJKCAaWb3tl/oiV4rMl36fLtDqyc1mKZYsrHm10ivh7YbYwlBcXaJkKhYNKdO+dOm/LHCsY+Sw3plrIjoq18Hi25L8ZpYu0kAkmKlaRDGU5+n+YK9uaq25OCiUbPAi7SUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332763; c=relaxed/simple;
	bh=7Sa/Lu49fxpYMYEXC6LTqXHAixILM2eZe77IaXWRf50=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rnoAiXPdEPM0ajfdtzG6CS1aFcSTydUnkkp4MSNv5EqNdDIIq6QppW3mV7+CWsrdgL6uvmFGrcHdffNPZCpKAhXXArfwsdvxJiJsm6Nm8V/8YKE+0wbLDYRvtdRLtOQF5MQT/j7mg/ADiRVZzL+o97dnAuL5FGp31SAwz3WcMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r0qyiH5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r0qyiH5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58951F000E9;
	Wed, 29 Jul 2026 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332762;
	bh=dJVri1JLbJ5vRHWi7uwszwwJhYZHAKo19N/SW+MrB8c=;
	h=Subject:To:Cc:From:Date;
	b=r0qyiH5MoZiQMRoTKgvo/xYdnwzT6S2tp1aiqLiF2uVVVHnjVXUndSsdlklZTsEIB
	 YDR0d0QFg5K2xlUioxdCtMCER/kE/81qbujH54EaqrcLyfWVRCba188ITdYT5kVyiY
	 VBmRbD6vFjuli5qo21xt+pYcVhaUqmRXJ5m6VW6M=
Subject: FAILED: patch "[PATCH] sctp: close UDP tunnel sockets during netns teardown" failed to apply to 6.1-stable tree
To: roxy520tt@gmail.com,kuba@kernel.org,lucien.xin@gmail.com,n05ec@lzu.edu.cn,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:45:46 +0200
Message-ID: <2026072946-runny-cathouse-1d3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ffb2bd7ade36ec4da32c46a6eddbf4515316d08c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072946-runny-cathouse-1d3b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffb2bd7ade36ec4da32c46a6eddbf4515316d08c Mon Sep 17 00:00:00 2001
From: Zhiling Zou <roxy520tt@gmail.com>
Date: Wed, 15 Jul 2026 09:50:11 +0800
Subject: [PATCH] sctp: close UDP tunnel sockets during netns teardown

proc_sctp_do_udp_port() starts per-net SCTP UDP tunneling sockets when
net.sctp.udp_port is set, and stops/restarts them when the sysctl value
changes. The netns exit path does not stop these sockets, so a namespace
can be torn down while its SCTP UDP tunnel sockets are still installed.

Close the UDP tunnel sockets from sctp_ctrlsock_exit() after unregistering
the per-net sysctl table. This prevents new sysctl writes from racing in
while the sockets are being released, and closes the sockets before the
control socket is destroyed.

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt%40gmail.com
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/6dab75f22855cb219e2e30a5497cab03b970ab91.1784033357.git.roxy520tt@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 49d9740b1e0f..27c26e12f95d 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1460,6 +1460,7 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
 	sctp_sysctl_net_unregister(net);
+	sctp_udp_sock_stop(net);
 
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);

