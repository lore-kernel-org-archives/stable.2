Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9D40DB2B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923252; cv=none; b=cB9DXBmKpFOf/9UXwQlhfSGJz0OvRo2nv+08iBdacmAG7Xxhrj0EdCyWCznQpRUkipbVfyab0AkFKm009H8kz++y7Gx14u46ZdewQ6Dxfnqx7ckBYbGQlZZqhB1xNCsc+tivDFivJP8dr/NPVk/pQBOO5wZ2cisY9Lba+F3WH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923252; c=relaxed/simple;
	bh=jLAKc3DsTMi+jyzbIO1TTVGvoDSFasDLM71syv1jIZg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=enRY2siK7wh8LiEgSnKokNOf8fBr6oLUJhCpQoFHgBj6eObqKUUtGOMSDmsMPrUjl4JPm1Te6vhplc6vSiQ6AfvnJ//B6sIQItozvXZlrfb9LbnEWP5IssFXwYkWjVlB68c8udJvYB/C7EJnBpt3J9JLw65d148NZM7cCwMdpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7iSjAU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7iSjAU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D531D1F000E9;
	Wed,  5 Aug 2026 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923250;
	bh=t4wNNmakOWCwUXcogb2IhLo7U7U+OPqHL8At4f8SGqY=;
	h=Subject:To:Cc:From:Date;
	b=v7iSjAU2SrX41rEjX4RDpFN7y/78zg8GLsjBkovdm/re4V+lCmlKwBGIuOlrq6X3P
	 WrA1MIPO7wTcgw8cS/tQ1TnX2F9kEgAvXSh4xDnziJ/eN5Qim6QfNNOIks446sbWH+
	 ggLfMhFMEeCW2+eyJOHSZUo3b/WKtbt1/ARFFnbY=
Subject: FAILED: patch "[PATCH] fou: Fix use-after-free in fou_create()" failed to apply to 5.10-stable tree
To: luoxuanqiang@kylinos.cn,kuniyu@google.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:46:58 +0200
Message-ID: <2026080558-conceded-backfire-aaa8@gregkh>
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
git cherry-pick -x b14361aca6350ff7907b0e9903c7b94dc7d5d4a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080558-conceded-backfire-aaa8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

