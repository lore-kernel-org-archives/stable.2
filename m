Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037DA4E4C24
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659891; cv=none; b=YTVrTzTIYO+Uh1InBejTdccVAkBY9cJvSM7kT91yVb/ijvoQbFQkKLLIKjRoP8K9pGNPM1Z9pQWXhlUsFk2PcBhbAuu+1MvtnvXJIx90Dd+6A1rZeUcfly4Rhxz9OYpCgIT43IJI7U62+SdDuiw3Tj1pU8Rgo1F7B/TE29/7KxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659891; c=relaxed/simple;
	bh=SOj87chP2AxEtACdkSVZLb3jWaqIDaQ5MFX/0okspts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RckN7AZurLlyIdqg1dBWSRaqvS2I2uCGNEpu6gim0Q0FjgDEwyK7i5apA4fj30GJWFBo0uErRGDEKnHYeI54d6ht6iGS/M1EZIzWY2Br2I50vlgfY7IjnPzx1gAQmXEotpkjd8H7bdQ+LLVA9XsqYv/ZUbtWXpf+Cb/v08WplLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jhQFQ3UT; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jhQFQ3UT"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm0F76G14z7K6;
	Thu, 17 Sep 2026 17:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789659307;
	bh=w6CI5N37x6ptMfr81zysL2zsZ2hqXLCkwQHtOZT7RQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhQFQ3UTd+OiAj5qSVM8IwnXCoM7ms18bfoiFHi+68wtV5CYIBicorWkJkPd2pOJ/
	 7G8eBSIqCxWQtF/ymEXXYDRZC0QrQsyHZSpisqeaBDdJWaU5kRqcSQBFYFoaKO9n7P
	 GHoY1D+uSGWa5q4O9A8Da1t/eKqTEw524tp0YrKY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm0F72RH3z9Td;
	Thu, 17 Sep 2026 17:35:07 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	gregkh@linuxfoundation.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH 6.12.y 1/2] landlock: Fix TCP Fast Open connection bypass
Date: Thu, 17 Sep 2026 17:35:02 +0200
Message-ID: <697fa3bb1602200a9f79647282a2d0433c05ce9a.1789655724.git.mic@digikod.net>
In-Reply-To: <2026072134-equate-depraved-19f6@gregkh>
References: <2026072134-equate-depraved-19f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Matthieu Buffet <matthieu@buffet.re>

[ Upstream commit 33cb713db0161b54f04fe830e062c9e102c29a04 ]

The documentation of the socket_connect() LSM hook states that it
controls connecting a socket to a remote address. It has not been the
case since the addition of TCP Fast Open (RFC 7413) support, which
allows opening a TCP connection (thus, setting a socket's destination
address) via the MSG_FASTOPEN flag passed to
sendto()/sendmsg()/sendmmsg(). The problem then got duplicated into
MPTCP.

Landlock did not take it into account when its TCP support was added,
leaving a bypass of TCP connect policy.

Ideally a call to the LSM hook would be added in the fastopen code path,
in order to fix this generically. But connect() hooks are designed to
run with the socket locked, unlike sendmsg() hooks.

Closes: https://github.com/landlock-lsm/linux/issues/41
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
Link: https://patch.msgid.link/20260701214628.33319-1-matthieu@buffet.re
Cc: stable@vger.kernel.org
[mic: Wrap commit message]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
[mic: Backport: adapt the TCP Fast Open check to the TCP-only network
hooks]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 9c9608924fbd..c5c26e902992 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -193,9 +193,23 @@ static int hook_socket_connect(struct socket *const sock,
 					   LANDLOCK_ACCESS_NET_CONNECT_TCP);
 }
 
+static int hook_socket_sendmsg(struct socket *const sock,
+			       struct msghdr *const msg, const int size)
+{
+	struct sockaddr *const address = msg->msg_name;
+
+	if ((msg->msg_flags & MSG_FASTOPEN) && address)
+		return current_check_access_socket(
+			sock, address, msg->msg_namelen,
+			LANDLOCK_ACCESS_NET_CONNECT_TCP);
+
+	return 0;
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
 	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
+	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
 };
 
 __init void landlock_add_net_hooks(void)
