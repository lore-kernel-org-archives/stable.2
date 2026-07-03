Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0D6FBF
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042186; cv=none; b=MdZ2Fgh6x1hcKgERm+LZJRt3LI9rnXqUaJ/CEzvPkjSPDkpIHL1wVsFFnxHpn4YnKwynld41wlOYY79qaTaTa2GQvVneqbAFLL9DBLsFe1Yi5ri40IiAk7/x+t8T0VwfaPhY/QO66KGfT3TvN17gnR+ce36KvpEGe596KvsbaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042186; c=relaxed/simple;
	bh=vigRfPh84v/hzpmHzntSb/gUw2H/otH/iWxoNPdbsXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNEzDgmid7NObEJtyYDQIsn0OjmG4x/hxfS0sp4ImcDkVRxJ4m7mrEDJty4Ux9S4zq56qmZEqW45De4V0A8wRw6S5HH35LApYbnq34k0nuNovpW5GjjFyKY3dfFIKXJg22KtM/hPdAPG9spyvXlOFYfEzFTCcsGFmUqSueFoAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpSR7BwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpSR7BwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1768C1F000E9;
	Fri,  3 Jul 2026 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783042184;
	bh=Z7hNSPj//UYolhIe88eepCGBVhEOaWECEo+1QOTokFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MpSR7BwNWO9zveiuzQswjOrwCTZwON6nHKBKX1tjadVM64hmoy9F3pDHQB90OFXFz
	 fUxoVhb/R78OmrkwNdHVsNm07/fV3bn/SzurCY2vbaarjG5iBLCQP2YUHO+QYafqmr
	 Y8lwaMca+U4ZyFFhWg6RU5vIifTCiTy+uJZIqOjScsD2VKOPToo+PG1MLvaTF85qNl
	 5b12U5llVL9DyeucJhBZMJlzGFguuhdrYxbu/QFE8841F5+SuJ8IwmLZqQsSgcj0o7
	 aFU48uK7s1OpR16mIJSk9wiJQtb29YEtfXFT/reYFS7p4SzhwmrAistmWwhMNt1bCg
	 jVClpQ0AH90Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] apparmor: mediate the implicit connect of TCP fast open sendmsg
Date: Thu,  2 Jul 2026 21:29:42 -0400
Message-ID: <20260703012942.3803836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070241-scabbed-quarry-6e0b@gregkh>
References: <2026070241-scabbed-quarry-6e0b@gregkh>
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
[ inlined absent sk_is_tcp()/sk_is_inet() helpers into the equivalent family/type/protocol checks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 37aa1650c74eb2..6b259203557962 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -951,7 +951,23 @@ static int aa_sock_msg_perm(const char *op, u32 request, struct socket *sock,
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
+	    (sock->sk->sk_family == AF_INET ||
+	     sock->sk->sk_family == AF_INET6) &&
+	    sock->sk->sk_type == SOCK_STREAM &&
+	    (sock->sk->sk_protocol == IPPROTO_TCP ||
+	     sock->sk->sk_protocol == IPPROTO_MPTCP))
+		error = aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
+
+	return error;
 }
 
 /**
-- 
2.53.0

