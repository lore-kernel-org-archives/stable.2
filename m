Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A28341ABB
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836756; cv=none; b=no/Tg1M9MRv6+3aSf3lHtaf2ficF76pt27BsJYceUygkdplDpGraJpkwhZ6PN66NgMJlw/yO67drU27g1avD9lkh/j/UwBUNWs6fdjbor/ntEbCm6tHDUstyRT8Q+bkyoQ6kpHd+4l9L47lU1H2kjACy9+1cbaEVqyyvEBPQyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836756; c=relaxed/simple;
	bh=VxZwcSb1QdN4wsKx6LrWqTy7RWNSYmgjBYXHG2aYwf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXP7Rue0MbAIs+mO/9T8mzYdFcv8oOuDf3BLwmc1i113c76cS2z+5dNViapJ2Pl2CD6cxF0OZA/OpNK8CGu1QAhWAvBOkTqOAFDTPgj7U1epVnfQFjUJqMKlNpwq9cyB3kx9IKbotrzWP4U8x75xSwyhihudQ94m5DbHGnl14HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCNRmq2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCNRmq2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9291F000E9;
	Thu, 23 Jul 2026 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836754;
	bh=fKfnLzsInL2+Vl2vPv3O2SGuIl0Ho6Lt8OXBH9C8PxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCNRmq2ZkGwOyPbpRgqpuZpzYan+zJxHg4hMTzx9KeNjlXQCeuv32MuefNv1iuEZ8
	 nqBjCtxk01+zCfN1f9LEmVEV2ieaBUapChIkajhyn/IMvjz0hLxh8VnS4dgdGuhsHZ
	 bFqDqZGEv1Zs9kBu+3SocyUjpN4+ZPUSw5QSDU3eLkEO6q9Mm3NUDOO+vcDqGFWDsf
	 DTu/J8Wwgn/dRv5M1IywnaBQkQmXu46MKmPFbGBxzlSZzjoR8tWD5zT4JddHyaFlz3
	 RZuT5/WIOOZEBUbAzEA7pLhzZwNj6vk9tAPIwrc0gS1vaoxybNv/ZDTW1n7G+vhxyN
	 FsHQ7OAWyE9BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
Date: Thu, 23 Jul 2026 15:59:09 -0400
Message-ID: <20260723195909.3685525-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723195909.3685525-1-sashal@kernel.org>
References: <2026072006-eggshell-gulp-8828@gregkh>
 <20260723195909.3685525-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit 56acfeb10019e200ab6787d01f8d7cbe0f01526f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 94c4ce88fa9827..fa91dc75cdb598 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4763,9 +4763,8 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
@@ -4901,13 +4900,17 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
 
@@ -5001,7 +5004,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5466,13 +5469,11 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
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
@@ -5501,14 +5502,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
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
 
-- 
2.53.0

