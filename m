Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4722BDC28
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625888; cv=none; b=pmuQxBWKdtNBp7PrrN7SJPeQxV6ORVhaNQVrzbrgtth/qA3B4eCwrNm3LOU+MzHX5kXuqIu7xvTJjaVMkMNhxuHJAlztULWROAyCKKfz8ugGS8atHsMASK+xhAAr8Uy7IbHiZnrlmbo6xj+ReNJF9uw9KP46Z5ZPr/D8f1/jANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625888; c=relaxed/simple;
	bh=8iSwfP3DIhtMCMdUeuvYsZPHNyr1ny+L1FuegK4oMsw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Le1XCM4/iIT/X8W+gCuTdcYt5vxDNhfmQCMWQ0vTvun4s4uzrUbd6wn7GVAI771DCNNHtJPCM8o6QyeOHpicxiidv/a+McvHDNTYGSGveUTahDl+HC6l1v4rpa5bRoZNfxlM6KE9NRP1oQWVd5v8YDiu8K8Lfv1mWVL0t34+gJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkalJGZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkalJGZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410DE1F000E9;
	Tue, 21 Jul 2026 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625886;
	bh=kOZb4FuWgK+ZUJs8+G0RH74js9KLx+IAliVMEHyMAAs=;
	h=Subject:To:Cc:From:Date;
	b=VkalJGZaXT1uKBrPInAYXVoluJ4wcruQwxzdN3Z8KJKf33Q3mGNICOEZxxvOEkkxw
	 NQjx4lW9nMOaWcres3InQ4eB+YKWYI4Bc5kSH6KXQx5aWzqys8xLrCW6lnHLPKCrzg
	 4F/kd59o0rd1zn7iHXJQsDAoK5c7iBBSSsmSzUY0=
Subject: FAILED: patch "[PATCH] selftests/landlock: Add test for TCP fast open" failed to apply to 6.18-stable tree
To: matthieu@buffet.re,mic@digikod.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:23:58 +0200
Message-ID: <2026072158-hexagon-sulphuric-ebb8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f4b30e0b1d488e7ffd8ea28d1365b9ba8e551edb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072158-hexagon-sulphuric-ebb8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4b30e0b1d488e7ffd8ea28d1365b9ba8e551edb Mon Sep 17 00:00:00 2001
From: Matthieu Buffet <matthieu@buffet.re>
Date: Wed, 1 Jul 2026 23:46:28 +0200
Subject: [PATCH] selftests/landlock: Add test for TCP fast open
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 2ed1f76b7a8b..be2eb88092fb 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1281,6 +1281,103 @@ TEST_F(protocol, connect_unspec)
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
 TEST_F(protocol, sendmsg_stream)
 {
 	int srv0_fd, tmp_fd, client_fd, res;

