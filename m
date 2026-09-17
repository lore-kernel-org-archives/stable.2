Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98424E781E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659738; cv=none; b=gPIBb//p9vMWJPUAzCJ8JXZm9dQYmjvK5WXut/LKZamxmYQ1V6/FZA3Ly8RGY2e5qQLGKe9+7L2diBHAWhrAglmdQH/xxOSRv29UFm0JoW9Gz+RUyYYhKulTyokj7RarSYSLTx9ZvyxeuZO35ONoNlXw9IClptCstYzYaeQp8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659738; c=relaxed/simple;
	bh=nIQGcrQvIAXopD2KxjxjzTcl1B41Czt/kfnOVNAA0GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc8hTBcGBVoPwoLbqj2a/FZ/5w2SiWA8tOufxZ9awLh/+p9O+qCkOpBjn97Ikbu4ejUmQ7ZXCRiX411mY67aogq3i/sdjtizhM18CIfTP3aiklElJczs5KjerWgUAdceNCWp4ueMnDnUdb53UZVaXYRagiaxdHZrIv/Y5s7fujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WYBXrw7u; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WYBXrw7u"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm0PF2Xh1zbQD;
	Thu, 17 Sep 2026 17:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789659729;
	bh=ZYvg7yphzNcsjq7oZqJA86Pf8xkEpgxo1P9XmKj8iLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYBXrw7uWxG8BLxv1q3riQo3Qa0P2fikSybbiQvW7XXup2NJxEm7qG3KPMz4iCpgD
	 IZCSjXhxCTmAsU6EuuysGl7K5aHlt+F4ZDaywpaWfaxLlX4wz26khpyGvFi3vWw1t8
	 Cy+JwX3ZocYbD4UlDPdblVfTHyvpZPvKqwc9nV1I=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm0PD5nLxzH5;
	Thu, 17 Sep 2026 17:42:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	gregkh@linuxfoundation.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH 6.18.y 1/2] landlock: Fix TCP Fast Open connection bypass
Date: Thu, 17 Sep 2026 17:42:05 +0200
Message-ID: <2f59e70a7b7c42becbea5f6d55dfaf2a8558dc8b.1789655724.git.mic@digikod.net>
In-Reply-To: <2026072134-passerby-litigate-863b@gregkh>
References: <2026072134-passerby-litigate-863b@gregkh>
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
index 8bce78cf3d6d..91b81ac31653 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -234,9 +234,23 @@ static int hook_socket_connect(struct socket *const sock,
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
