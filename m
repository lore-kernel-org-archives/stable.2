Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926A4D4883
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659321; cv=none; b=DTfnD5/5FkRT7gGMcNncEF+hbKTHiwKiLglzNmpRiKEwUxiJt8uvsjfOAMTcx7V9p24FmEhUA66qGsz8SZCQ1rCSoIn23LU0QQ0WIrCP7tgBNB8Bu6p5w6pQr0s2Evlw2h1PPgW3Omg9XzWnAFSl8H0j66cUSatDTCZz6eDtvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659321; c=relaxed/simple;
	bh=sqQi8DMU3msA06pZSFyXHm74h/ESvR6JrvJ71Ay9gHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzmrTaVWPFMoYX22YTofphfZ/mLcTkA9S9S+kTedIu887nd5ZZXKT1OQYpJYC01MzU2083XABdE6vnWkGKzprjHZC0jc5fn0EU3/K3fRfJvxYFxGzfEJOrU5/HaFLja39WuHFsBKvSmVAZzr641sa04rRMFzBiALBfOWOJBx7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=prW+0gu/; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="prW+0gu/"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm0F93MSJz5cC;
	Thu, 17 Sep 2026 17:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789659309;
	bh=IqKiFrXPNxwsryAMxS29xchY6prx3nvNOfTynFZaHW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prW+0gu/0VBlO9P6F/SobhE/FWMz11j7ZClheBUxH4f1WzpUIiCmzsyFiqsD0fqGP
	 U4YoCuK2hPykfAhGyjPH+aSsRO7f3CYNxZlOWqZ1C1WgzQan+qiopwWmQ4hGSydSf8
	 +G9japMaD+IFw2Cj7ca69AfNklVaEM0qqPEIQAV0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm0F85wPhzTZb;
	Thu, 17 Sep 2026 17:35:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	gregkh@linuxfoundation.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH 6.12.y 2/2] selftests/landlock: Add test for TCP fast open
Date: Thu, 17 Sep 2026 17:35:03 +0200
Message-ID: <c31e38b4d5266a93cc6f578d2be4b7369a58ccd1.1789655724.git.mic@digikod.net>
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

[ Upstream commit f4b30e0b1d488e7ffd8ea28d1365b9ba8e551edb ]

Enforce that TCP Fast Open is controlled by
LANDLOCK_ACCESS_NET_CONNECT_TCP. Semantics of connect() and
sendmsg(MSG_FASTOPEN) should be identical from Landlock's perspective.
Also enforce error code consistency, since UDP sockets ignore the
MSG_FASTOPEN flag while Unix sockets reject it.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
Link: https://patch.msgid.link/20260701214628.33319-2-matthieu@buffet.re
Cc: stable@vger.kernel.org
[mic: Fix formatting]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
[mic: Backport: adapt the test to the older network fixture and add the
required send helper]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/net_test.c | 155 ++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index d3cb27e24a16..0be69fcc4efb 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -257,6 +257,64 @@ static int connect_variant(const int sock_fd,
 	return connect_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
 }
 
+static int sendto_variant_addrlen(const int sock_fd,
+				  const struct service_fixture *const srv,
+				  const socklen_t addrlen, void *buf,
+				  size_t len, size_t flags)
+{
+	const struct sockaddr *dst = NULL;
+	ssize_t ret;
+
+	/*
+	 * We never want our processes to be killed by SIGPIPE: we check return
+	 * codes and errno, so that we have actual error messages.
+	 */
+	flags |= MSG_NOSIGNAL;
+
+	if (srv != NULL) {
+		switch (srv->protocol.domain) {
+		case AF_UNSPEC:
+		case AF_INET:
+			dst = (const struct sockaddr *)&srv->ipv4_addr;
+			break;
+
+		case AF_INET6:
+			dst = (const struct sockaddr *)&srv->ipv6_addr;
+			break;
+
+		case AF_UNIX:
+			dst = (const struct sockaddr *)&srv->unix_addr;
+			break;
+
+		default:
+			errno = EAFNOSUPPORT;
+			return -errno;
+		}
+	}
+
+	ret = sendto(sock_fd, buf, len, flags, dst, addrlen);
+	if (ret < 0)
+		return -errno;
+
+	/* errno is not set in cases of partial writes. */
+	if (ret != len)
+		return -EINTR;
+
+	return 0;
+}
+
+static int sendto_variant(const int sock_fd,
+			  const struct service_fixture *const srv, void *buf,
+			  size_t len, size_t flags)
+{
+	socklen_t addrlen = 0;
+
+	if (srv != NULL)
+		addrlen = get_addrlen(srv, false);
+
+	return sendto_variant_addrlen(sock_fd, srv, addrlen, buf, len, flags);
+}
+
 FIXTURE(protocol)
 {
 	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
@@ -949,6 +1007,103 @@ TEST_F(protocol, connect_unspec)
 	EXPECT_EQ(0, close(bind_fd));
 }
 
+TEST_F(protocol, tcp_fastopen)
+{
+	const bool restricted = variant->sandbox == TCP_SANDBOX &&
+				variant->prot.type == SOCK_STREAM &&
+				(variant->prot.protocol == IPPROTO_TCP ||
+				 variant->prot.protocol == IPPROTO_IP) &&
+				(variant->prot.domain == AF_INET ||
+				 variant->prot.domain == AF_INET6);
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	int bind_fd, client_fd, status;
+	char buf;
+	pid_t child;
+
+	bind_fd = socket_variant(&self->srv0);
+	ASSERT_LE(0, bind_fd);
+	EXPECT_EQ(0, bind_variant(bind_fd, &self->srv0));
+	if (self->srv0.protocol.type == SOCK_STREAM)
+		EXPECT_EQ(0, listen(bind_fd, backlog));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int connect_fd, ret;
+
+		/* Closes listening socket for the child. */
+		EXPECT_EQ(0, close(bind_fd));
+
+		connect_fd = socket_variant(&self->srv0);
+		ASSERT_LE(0, connect_fd);
+
+		if (variant->sandbox == TCP_SANDBOX) {
+			const int ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			ASSERT_LE(0, ruleset_fd);
+
+			enforce_ruleset(_metadata, ruleset_fd);
+			EXPECT_EQ(0, close(ruleset_fd));
+		}
+
+		/* Fast Open with no address. */
+		ret = sendto_variant(connect_fd, NULL, NULL, 0, MSG_FASTOPEN);
+		if (self->srv0.protocol.domain == AF_UNIX) {
+			EXPECT_EQ(-ENOTCONN, ret);
+		} else if (self->srv0.protocol.type == SOCK_DGRAM) {
+			EXPECT_EQ(-EDESTADDRREQ, ret);
+		} else {
+			EXPECT_EQ(-EINVAL, ret);
+		}
+
+		/* Fast Open to a denied address. */
+		ret = sendto_variant(connect_fd, &self->srv0, "A", 1,
+				     MSG_FASTOPEN);
+		if (restricted) {
+			EXPECT_EQ(-EACCES, ret);
+		} else if (self->srv0.protocol.domain == AF_UNIX &&
+			   self->srv0.protocol.type == SOCK_STREAM) {
+			EXPECT_EQ(-EOPNOTSUPP, ret);
+		} else {
+			EXPECT_EQ(0, ret);
+		}
+
+		EXPECT_EQ(0, close(connect_fd));
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	client_fd = bind_fd;
+	if (!restricted && self->srv0.protocol.type == SOCK_STREAM &&
+	    self->srv0.protocol.domain != AF_UNIX) {
+		client_fd = accept(bind_fd, NULL, 0);
+		ASSERT_LE(0, client_fd);
+	}
+
+	if (restricted) {
+		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		EXPECT_EQ(ENOTCONN, errno);
+	} else if (self->srv0.protocol.domain == AF_UNIX &&
+		   self->srv0.protocol.type == SOCK_STREAM) {
+		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		EXPECT_EQ(EINVAL, errno);
+	} else {
+		EXPECT_EQ(1, read(client_fd, &buf, 1));
+		EXPECT_EQ('A', buf);
+	}
+
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	if (client_fd != bind_fd)
+		EXPECT_LE(0, close(client_fd));
+
+	EXPECT_EQ(0, close(bind_fd));
+}
+
 FIXTURE(ipv4)
 {
 	struct service_fixture srv0, srv1;
