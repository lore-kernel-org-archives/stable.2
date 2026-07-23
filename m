Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902C38C42B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825682; cv=none; b=lZyVvVW1lSLCrp8p6uMsXywgMkBcjAJJQR/FUwePLOnDhs/Jkiq52oo/Fnp9HkY/GfQwUKRa9M/SZqMRNGRu5N8d2sTeO71eBZdcpp58z4GtHOubf+3Lf2Hzs/QJylkmrWco5Vmmlo0DY17BcGxnsCnboA+uE9FKX5EDe2ehjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825682; c=relaxed/simple;
	bh=U20+7z/lAfA/ARlXgAMqj4txU6MAXJ+4VtAlRvltFYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLgIYz4YJ9T0vsCxFNx0lZQ0ohklXWIQpeU+rRc9w8JXE7umo14UftxS+aHpZdvjO6q9m6rmZUwG6ah8T4yPYwDnyFIBJYYbZqgKNB0I85upze9TBypxLg+yRroLoTlpkg2OuayAcpldXpHYYOE/D32zQ+jjyWqLyzQTDDAjdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj7hTCRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj7hTCRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0967F1F00A3D;
	Thu, 23 Jul 2026 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825681;
	bh=qv+76W3eTpX/bfAQQSARACGvWDFsVT6O1GKHGO1/fXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tj7hTCRtYHdQ9ijTjBxubWrsoJZrDgvI3d4V4DmEdJo3FFH2b35yzSjX1Qi5sgNqD
	 HG0WdjrUKA3IClZITRjzo35Ypndk3gUnPfydc8Wd+tlIfbN3ot8DUTmkLtU5AbO3/l
	 OMsb+SFhNGPY6YvBEN/G4SEdii6HpPHo5GoM7uBBq80NrXCuhoQKq1RzP6a2KA0rjg
	 w3PitHtAzOUmfSV44IXjqeWOCq1aczgVwl3dliH4Oe5bxxYvsLkcYzghHPE+dLc9D4
	 0bCllG4eqiXzaVJm8PNgyNsXg5B6NNrDSWf3/weTxpcRKJaLTkXoM+ZapP+yFTgdIm
	 AVbXyhduBEQRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
Date: Thu, 23 Jul 2026 12:54:38 -0400
Message-ID: <20260723165438.3391770-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723165438.3391770-1-sashal@kernel.org>
References: <2026072005-stays-levitator-a873@gregkh>
 <20260723165438.3391770-1-sashal@kernel.org>
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
index d87af3fb5957a0..e0fc1c67cdc6e2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4678,9 +4678,8 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
@@ -4816,13 +4815,17 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
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
 
@@ -4916,7 +4919,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5422,13 +5425,11 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
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
@@ -5457,14 +5458,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
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

