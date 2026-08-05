Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3940BCD4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923249; cv=none; b=l6GDfCPFg74kqiELDK+0fTTFQNe3scY00Q9khm1t/v0otEE9KGTCKr/SW2+to1+xcyl2t8I5x3WUzPg7m2DVcFuRxZ/3Vr0w8P8JDOE7ySYdFa2ZzPvCCpdmr3COQgyQllPOa+MPvBYk/31OnRKxN7UTCnmLdw7YT4nnvcOtQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923249; c=relaxed/simple;
	bh=5QwUVuqVIZ4UH5kAIp1i5Eo3PO9KHu9LrQRqGtOQfb8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GTTy14jpiDLGb93wg9TDxa7RAg2QiEbwD0RjkmGFuHkEvCzkOUY7548vXdZ9WL1WFwAVlQQHVxtZLC+iff+l4tg3H16Ir/eJ8LTh9gULIDE87COBoAJ7YhkU8bAYly5DeFN7hhdafXPJgrcfk29cTg6TREVGDp+ZTWSVJI56GLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X7JMEziT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7JMEziT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B82E1F00A3A;
	Wed,  5 Aug 2026 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923244;
	bh=VZv62zXjr78J1WHQ47PMC7LpG0Roy5F3uG7+jpWBIqs=;
	h=Subject:To:Cc:From:Date;
	b=X7JMEziTTxdYTyTItN+LyUlcUAeQBpA92MATQYnuqRkmLbgDlfjnQbLMVNNDIF0Ki
	 l/TWH6GKKGCEPJ/TNEYU2Gk9CUXNQ3s99F9flykgs8ZGO84anskzNgJwaus9+Drsb9
	 L5Wg0Qn0v6fClLf/F2yRH8xLR5gJTLHcsToBAVoA=
Subject: FAILED: patch "[PATCH] fou: Fix use-after-free in fou_create()" failed to apply to 6.1-stable tree
To: luoxuanqiang@kylinos.cn,kuniyu@google.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:46:57 +0200
Message-ID: <2026080557-polymer-crave-6f8c@gregkh>
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
git cherry-pick -x b14361aca6350ff7907b0e9903c7b94dc7d5d4a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080557-polymer-crave-6f8c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b14361aca6350ff7907b0e9903c7b94dc7d5d4a0 Mon Sep 17 00:00:00 2001
From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Date: Wed, 22 Jul 2026 16:38:58 +0800
Subject: [PATCH] fou: Fix use-after-free in fou_create()

fou_create() publishes struct fou through sk_user_data before adding the
new FOU port to the per-netns list.  If fou_add_to_port_list() fails,
the error path frees fou while it is still reachable through
sk_user_data.  A concurrent receive can then dereference the freed
object in fou_from_sock().

This ordering issue was previously noted in the linked discussion.

The failure is reachable when local port 0 is requested.  Each socket
binds to a different ephemeral port, but fou_cfg_cmp() compares the
requested port 0 and reports -EALREADY once an entry already exists.

Release the tunnel socket before freeing fou so sk_user_data is cleared
first, and defer reclamation with kfree_rcu() to protect concurrent RCU
readers.  This matches the lifetime handling in fou_release().

Fixes: 23461551c006 ("fou: Support for foo-over-udp RX path")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://lore.kernel.org/netdev/20260502031401.3557229-12-kuniyu@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Link: https://patch.msgid.link/20260722083858.182506-1-xuanqiang.luo@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 865bd7205122..ab09dfcdecbd 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -629,9 +629,9 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	return 0;
 
 error:
-	kfree(fou);
 	if (sock)
 		udp_tunnel_sock_release(sock->sk);
+	kfree_rcu(fou, rcu);
 
 	return err;
 }

