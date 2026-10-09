Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404F4E1C78
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554109; cv=none; b=e0iuCqTwpI+BmAR9XqDgMSCJXvbg1XMK/HnfIWO9TQ/vK8qJdOk5dghYCJxg9w38guNccbuWHtuiFlRCqGHsxA7rj5xyLCmbsd0bVasfWJZxTPA62xQIUz4Dwgu6EQJssft/ldM3LYH8zBQc3OYjfY808DVuKWqBDDpxfV6FT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554109; c=relaxed/simple;
	bh=GEjd/qW90wDrkNGcZj8QPQSEb0am6CGFCm7z0bXS1/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=urpDMW0/ftgTMPe5eiBqDAia43PTgtMOgMA/v3O/Iy3XMt2u1ia2So9YzpDEDPy35z0mK/vVB3ANJACj0x8guHNcPoa3qcI1TFMU5D3FrMwj54gnNvo1xR6TyMAOZPw/YHj6e071NC5o3+y4qV2whIO2DG3F290o0U7/EcG0wi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com; spf=pass smtp.mailfrom=runtimeverification.com; dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b=LjSpmE4p; arc=none smtp.client-ip=185.70.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtimeverification.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runtimeverification.com header.i=@runtimeverification.com header.b="LjSpmE4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=runtimeverification.com; s=protonmail; t=1791553112; x=1791812312;
	bh=u95xk4ByT0KOla+zRFNafUMHZYZpARYMpRVIx6gGvxk=;
	h=From:To:Cc:Subject:Date:Message-Id:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LjSpmE4p9ox2cnyqR9ueOIIUZ6o8mPB6Du2gYiYYQFqtNiKLfyrWOgrIYsPUuwBjV
	 B5RzGihLJ2ARs3p+oIGkf9EWi2UNr2XBIQTUQaxzGlgaDsIQ1zKeiCfMLJLXIUAEhu
	 hTTLc3xXCp7HKI06EBVCy19B8I0EZ0r+iU6ppO1GcRDzhRDIw8HW/sps7hslShGqz5
	 3MTEyxi8y/Rn8h/y5XUJyaKtP+5UyMh/eYOXJXwqPfull6nUa6fB8XOsWwst28HN0r
	 QKBVTPxLqYM1d+N5cixmrGq9rdcA993EcpqG+R/3SjK8gEy2uwy2IjWdUb2XSIqMaG
	 t9eHzPqWFyLjw==
X-Pm-Submission-Id: 4j1ScN26WYz2ScsK
From: Natasha Klaus <natalie.klaus@runtimeverification.com>
To: io-uring@vger.kernel.org
Cc: axboe@kernel.dk,
	Natasha Klaus <natalie.klaus@runtimeverification.com>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/net: populate CONNECT filter fields for 24-byte sockaddr_in6
Date: Fri,  9 Oct 2026 16:38:07 +0300
Message-Id: <20261009133807.730724-1-natalie.klaus@runtimeverification.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_connect_bpf_populate() fills connect.port and connect.v6_addr for
AF_INET6 only when addr_len >= sizeof(struct sockaddr_in6), i.e. 28
bytes.

The IPv6 connect paths accept SIN6_LEN_RFC2133 (24 bytes), which
already holds sin6_port and sin6_addr. io_connect() passes addr_len to
the socket layer unchanged.

At addr_len 24 the filter sees family AF_INET6 with port and address
zero, while the kernel connects to the real destination. A filter that
denies an IPv6 port or address is bypassed. Denying connect.port == P
rejects [::1]:P with -EACCES at addr_len 28 but connects at addr_len 24.

Use SIN6_LEN_RFC2133 as the threshold. sin6_scope_id stays zero when
absent.

The threshold mismatch was found by an AI coding assistant (Claude Code)
comparing this hook against the net/ipv6 length checks on my
instructions; it also drafted the reproducer and this patch. I verified
the bypass and the fix in a VM on 7.3-rc6 and that 7.2 has the same
code.

Fixes: 899bea8248ce ("io_uring/net: allow filtering on IORING_OP_CONNECT")
Cc: stable@vger.kernel.org # 7.2
Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>
---
 io_uring/net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 050ed274170a..f5f4f3ce6ef3 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -7,6 +7,7 @@
 #include <linux/un.h>
 #include <linux/compat.h>
 #include <net/compat.h>
+#include <net/ipv6.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -1741,7 +1742,8 @@ void io_connect_bpf_populate(struct io_uring_bpf_ctx *bctx, struct io_kiocb *req
 	case AF_INET6: {
 		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)ss;
 
-		if (conn->addr_len < (int)sizeof(*sin6))
+		/* The IPv6 stack accepts SIN6_LEN_RFC2133; port and addr are in it. */
+		if (conn->addr_len < SIN6_LEN_RFC2133)
 			break;
 		bctx->connect.port = sin6->sin6_port;
 		memcpy(bctx->connect.v6_addr, &sin6->sin6_addr,
-- 
2.34.1

