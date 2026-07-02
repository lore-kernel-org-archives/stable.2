Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E58352029
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981302; cv=none; b=JSCMkviZ/NwlvWsxxaKrBVJeYhuguVPgkZoqqeVD5Bn0XwTCVc135k4zMd4F9V/kcRYiXOVeSBYeizsptO6jSCwWX4951W2FGI4J03PpUgyvi/IjQzYzKjMmbVvwoYwIK/u68/iZRzqOlB64a69gEZXDDSr7/BH/o37AlxpTeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981302; c=relaxed/simple;
	bh=EA7Tom8SoGg1n3XNsZQPZJLW3bdmbpmhf4XwzXb6wH0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W0465r7YHWbqHaXEETTd27eATzznqkrX3lCEjepRz5Xw2oix/pius2YXravjBxh/q/QzUoA5MkU/rUNi76+GE/Hw1IhrvNTnyeE31uUXgx03LwVYAopeZTenh8m4svkoL7U8w8EZ8rcKZw6pvJErHeSS6ldDQg9SBK/UKV1XVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c8+CQpWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c8+CQpWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F301F00A3A;
	Thu,  2 Jul 2026 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782981301;
	bh=DmJhohYzYN3VzA5wtXbtjUh7COTErXPLLtyWyRqnfFw=;
	h=Subject:To:Cc:From:Date;
	b=c8+CQpWdMlW3s9A3vvmA0R+9eK4cDQP0VPY7ye0Gdv3uWj1zH+GHncE2o0iJsPC6Q
	 yqC+27Ub0NdXsegcncb0J7wvS2RwPd+nGgIuwE8bEcZQ184LDNbjfcsxdxY2466zyw
	 UcktIpV8k9ymMtu26v7tQN3q9vv1AoqQkY5JUIG0=
Subject: FAILED: patch "[PATCH] apparmor: mediate the implicit connect of TCP fast open" failed to apply to 5.15-stable tree
To: hexlabsecurity@proton.me,john.johansen@canonical.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:34:41 +0200
Message-ID: <2026070241-upper-credible-fb47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4d587cd8a72155089a627130bbd4716ec0856e21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070241-upper-credible-fb47@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d587cd8a72155089a627130bbd4716ec0856e21 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Mon, 22 Jun 2026 15:57:38 -0500
Subject: [PATCH] apparmor: mediate the implicit connect of TCP fast open
 sendmsg

sendmsg()/sendto() with MSG_FASTOPEN is a combination of connect(2) and
write(2): it opens the connection in the SYN. apparmor_socket_sendmsg()
only checks AA_MAY_SEND, so a profile that grants send but denies connect
lets a confined task open an outbound TCP/MPTCP connection that connect(2)
would have refused, bypassing connect mediation.

Mediate the implicit connect when MSG_FASTOPEN is set and a destination
is supplied. Add it to apparmor_socket_sendmsg() (not the shared
aa_sock_msg_perm() helper, which recvmsg also uses) and call aa_sk_perm()
directly, mirroring the selinux and tomoyo fixes. sk_is_tcp() does not
cover MPTCP fast open, so the SOCK_STREAM/IPPROTO_MPTCP arm is explicit.

Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7457067e8192..88d12e89d115 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1422,7 +1422,21 @@ static int aa_sock_msg_perm(const char *op, u32 request, struct socket *sock,
 static int apparmor_socket_sendmsg(struct socket *sock,
 				   struct msghdr *msg, int size)
 {
-	return aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+	int error = aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+
+	if (error)
+		return error;
+
+	/* TCP fast open carries connect() semantics in sendmsg(); mediate
+	 * the implicit connect so it cannot bypass the connect permission.
+	 */
+	if ((msg->msg_flags & MSG_FASTOPEN) && msg->msg_name &&
+	    (sk_is_tcp(sock->sk) ||
+	     (sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
+	      sock->sk->sk_protocol == IPPROTO_MPTCP)))
+		error = aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
+
+	return error;
 }
 
 static int apparmor_socket_recvmsg(struct socket *sock,

