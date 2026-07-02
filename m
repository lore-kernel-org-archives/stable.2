Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D95342510
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030992; cv=none; b=Exv+yYOvTjeJsL4u/wz2l+zpH9OEVt2YK9xEouIhyMUJyWUkqvqC0ovMmOUzBkeLEhwc9bGyl49zbs5RGRIlbo9zCSCErPNm2Nmy2wLCIs7asydM7Ux2T+YW/FhnmwCWJ/osmnJqsL9rckKV7o2IUjL5F6pHaUwakdkLQsw3scY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030992; c=relaxed/simple;
	bh=4tVViAncUNQXnCFMDGsobO2d5W+hbkKw0lAr47Q5oXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcrKjJxwgEzfeBWpyWreS/prvFRJghI05hF54ZpLA8p5Udwf26tAlqYA2pJs5z8oiEbZMLZiahphD3MDOV8gZRr3viyY7XsPOXPKaNGe44Kv5XZ7JpXDOE2hzJ/XKi2S6p96B+YT/KTsSs6Vrsvku/RmGPg6la8nw7RIkANEjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkD6dqXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkD6dqXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5B91F000E9;
	Thu,  2 Jul 2026 22:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783030991;
	bh=F85zmrWgKcWPmbBh+7MCT3hkGPwOzC7eOZOftK/rsEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkD6dqXNaZ/He6ty6vypG6DGi/Pdhf/t/8WGsZukDMZWeWce2Hdi8G+U1MLVHPxYu
	 u1PkVevXY2e+CnpHQWTeJKko9f0XNbCWs3AYFVRW3piqWkFCiNek327n+yO3zCSo8o
	 NdYyVgM6kb1XdsLIwjse2Iz9H5H2/R+lDARrC8ELUM9XvsQfjKFa5M+Qwq3MB6eAZB
	 V9mWj/iaepk8vNQsj/Ur3LKajD3pUlK3etcuwpc/dFfDcRrGDRQaswJz+e1S+dkZWd
	 ehO8XBosYmHDCkSCPkPR7VcDJvFtdL0l3lfAAzYyUsDF1BMdS41B5mWp7CQeAa+mFk
	 nU3bAWSUqaCsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] apparmor: mediate the implicit connect of TCP fast open sendmsg
Date: Thu,  2 Jul 2026 18:23:09 -0400
Message-ID: <20260702222309.3701611-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070241-upper-credible-fb47@gregkh>
References: <2026070241-upper-credible-fb47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 4d587cd8a72155089a627130bbd4716ec0856e21 ]

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
[ expanded sk_is_tcp() (absent in 5.15) into its equivalent sk_is_inet() && SOCK_STREAM && (IPPROTO_TCP || IPPROTO_MPTCP) check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index cf26ffe8cccb7d..6df909817993ea 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -960,7 +960,21 @@ static int aa_sock_msg_perm(const char *op, u32 request, struct socket *sock,
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
+	    (sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
+	     (sock->sk->sk_protocol == IPPROTO_TCP ||
+	      sock->sk->sk_protocol == IPPROTO_MPTCP)))
+		error = aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
+
+	return error;
 }
 
 /**
-- 
2.53.0

