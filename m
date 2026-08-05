Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855640C5D4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923247; cv=none; b=tr2Dbc4C60T1T0gfZm9yJelJvSdbRD9dQakr3jipJ2bLT+UG5o9cLJ8Dm6FtvhGN2vb+J5flCjkkMRCQAfEYWTUuMw9xspGP61CojyWnsF+hjLq/PArqeDeCTkWWLmqXSsPEzFCWbEv1RBs9+PF5vGMIXtP6BXQgcmLMAeBKR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923247; c=relaxed/simple;
	bh=n1FW53m+yMKtkSLvwHdIbCVP6YIRVeWE3OGhhGZSMlk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ihnv9jCOhebHubC7jCdE/LH/w1j4+sVDmoEJJTzNb/Y3o9nx3rlExkTMAPBD9t3A3fpgm3xNmLEAolb1QeBqEfnoJa4BFYU+8CQrbiEUlZwpKCGUPDhlwxETaBBjGMHXnyEhRS4BaN2UlGixcTEjlQb7MrCbzoaAHIvpTfdRmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MAdUq6PD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MAdUq6PD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742F01F000E9;
	Wed,  5 Aug 2026 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923242;
	bh=D7tAIYPzzdJILTqz9rrdmqrFG1ynX0l2VneZIajrhVg=;
	h=Subject:To:Cc:From:Date;
	b=MAdUq6PD8VhURcbaKAq8DpfDkx1+j+dRILQXDC5MuaiOMMtBzIlUNdeYfWE7SHdj0
	 6CTgv50pnyBeLUlJmijCSy16NutwhRS4IZU7R3pj8IT7tKaxrv7wG80VLf2yj7+Lm3
	 iDxBYQPq7p5vmPBPzC/TyZe7Y7mlMBWIqA7ukuq4=
Subject: FAILED: patch "[PATCH] fou: Fix use-after-free in fou_create()" failed to apply to 6.6-stable tree
To: luoxuanqiang@kylinos.cn,kuniyu@google.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:46:57 +0200
Message-ID: <2026080557-pony-parameter-ab69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b14361aca6350ff7907b0e9903c7b94dc7d5d4a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080557-pony-parameter-ab69@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

