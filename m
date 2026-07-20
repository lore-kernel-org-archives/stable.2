Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7534192FC
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551035; cv=none; b=R/ZyFXHynOsN01gTx9wONDr1FEzwZuWxzS30W6ACCaIfFtgO35ltVjC1ZWpT/zo7LVlK52sLOhHo/GFmSl88JV+VxMH86V5CKRlJYpevPS7cX4R0EBBK60G//tUODNfDDNtKyEBQCm2RszegrpHvK1eCndfJBNRixkuCFaOhh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551035; c=relaxed/simple;
	bh=RygUMPChZqBWFQd6ikTMj0A5VuC4P4PSxFOOoINfEDg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BEw8G1+iRNjeXSlPPlWc3XU7g116gNH440ESseX3/ZqrYluTwrD6Gvr0YYU9F/fE4wBb/JEyjKiGr/uWbeSKogjMe8XfUZpUDaKs0GndE2tN1WTNBRInkQySwWrNwP++K6yOjPtYIKmKfJepT44MOOGA9I7asJnseuB+5aJpZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcjXMKQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcjXMKQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFD81F000E9;
	Mon, 20 Jul 2026 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551034;
	bh=ooSJvjNV1lS04blkoSMqhxZfDoVa3CQslGCuMbqscxM=;
	h=Subject:To:Cc:From:Date;
	b=hcjXMKQlfNZJOSzA7LTX/BMZOKCB1n75SbVVhNXYOLgE0GgeeHeYNyi7jw8JV9HzZ
	 tbaurFh3p+x5MNjE+VpGTdh4Lxxwt4sI8EoNyoBeRFzwDALiaXqEwg9KfgSHDBLYCP
	 YoeoRwWgcd9IX2T6V3fm7huw428qxybRADv23XOY=
Subject: FAILED: patch "[PATCH] selinux: avoid sk_socket dereference in" failed to apply to 6.6-stable tree
To: tristan@talencesecurity.com,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:37:05 +0200
Message-ID: <2026072005-statutory-bonus-bc65@gregkh>
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
git cherry-pick -x 56acfeb10019e200ab6787d01f8d7cbe0f01526f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072005-statutory-bonus-bc65@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56acfeb10019e200ab6787d01f8d7cbe0f01526f Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Thu, 25 Jun 2026 23:53:36 +0000
Subject: [PATCH] selinux: avoid sk_socket dereference in
 selinux_sctp_bind_connect()

selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
struct socket * to selinux_socket_bind() and
selinux_socket_connect_helper().  However, when the hook is invoked
from the ASCONF softirq path (sctp_process_asconf), there is no file
reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
callers (bindx, connectx, set_primary, sendmsg connect) hold a file
reference and are not affected.

Both selinux_socket_bind() and selinux_socket_connect_helper()
immediately resolve sock->sk, never using the struct socket * for
anything else.  Refactor the inner logic into helpers that take a
struct sock * directly so that selinux_sctp_bind_connect() never needs
to touch sk->sk_socket at all.

Cc: stable@vger.kernel.org
Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c4677ce89399..70a3388c047d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4994,9 +4994,8 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
@@ -5126,13 +5125,17 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	return -EAFNOSUPPORT;
 }
 
+static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+{
+	return __selinux_socket_bind(sock->sk, address, addrlen);
+}
+
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
  * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
  */
-static int selinux_socket_connect_helper(struct socket *sock,
+static int selinux_socket_connect_helper(struct sock *sk,
 					 struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
@@ -5221,7 +5224,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5723,13 +5726,11 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
-	struct socket *sock;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
 	/* Process one or more addresses that may be IPv4 or IPv6 */
-	sock = sk->sk_socket;
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
@@ -5758,14 +5759,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
-			err = selinux_socket_bind(sock, addr, len);
+			err = __selinux_socket_bind(sk, addr, len);
 			break;
 		/* Connect checks */
 		case SCTP_SOCKOPT_CONNECTX:
 		case SCTP_PARAM_SET_PRIMARY:
 		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
-			err = selinux_socket_connect_helper(sock, addr, len);
+			err = selinux_socket_connect_helper(sk, addr, len);
 			if (err)
 				return err;
 

