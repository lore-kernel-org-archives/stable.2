Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2233DE456
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923252; cv=none; b=DkdbKFWcADnGMRq8kfkS5mQCOwlc2clnRcaBjuHIRnESNECP4icsXgC/t2Uub01lk7+nWQzVf5NkBvfYcfK7zQA30KshcZo+Fm0dJP5WFsWIhBKgor9tJdwdn02wpkk7uyjamzc4Pm+eFXkMukS0oYbTfJkcgUmsxZ9Ae9xz4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923252; c=relaxed/simple;
	bh=yR+KevutLnOt/fDDUsPPOzDj+PBgbZXXu5QQ9MdIuds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iqKIDD1RkcFWRxu/7/BxlVijL70MFtHcoW9J4UVSYzAWJATxzVVsRThG/uCmvdzpAy5tvtY2fXtjlxpTW9xjqiFfgM/igaix8npvym9bmfiee9U+/5wLmBBgotLYIoFDC9/QWEKnoSGbfkEarL2J/IIJLsMFkXisANoPcHBX8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHCFvqRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHCFvqRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF2B1F00A3D;
	Wed,  5 Aug 2026 09:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923247;
	bh=rO0UrkNSWHzDZVbynVPQE2u2GmCEDY3C7bTWLY2SuuM=;
	h=Subject:To:Cc:From:Date;
	b=KHCFvqRLlRLu9u8I9SPiZ0ixFdD7CxupMut7hd62gxcsXyON03yMN3afuGTC76ou4
	 BwB4XOH+qXZDeZUjjaXhzh48vK8OUpWeT4dxDwHrlsm9Lc4bJGdQUuPZlKOMHFFDDH
	 CPkOj0+jlnQ82oByQCG0W9MNQuTcf4cMXDOBl5rw=
Subject: FAILED: patch "[PATCH] fou: Fix use-after-free in fou_create()" failed to apply to 6.12-stable tree
To: luoxuanqiang@kylinos.cn,kuniyu@google.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:46:57 +0200
Message-ID: <2026080557-railway-joyous-ef9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b14361aca6350ff7907b0e9903c7b94dc7d5d4a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080557-railway-joyous-ef9c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

