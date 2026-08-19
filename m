Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5F2DB789
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151379; cv=none; b=WG/Hus9uAq/WRobZp676uX5egPsMGhIEtnAkAJ8UQKGf/4cMA9td7gaM7EcC4OUWV6Bz2BstQt6ZxdHNP86KRZ6/uEFL7DZdp8ADeLMcvmlIUSU+mSnD0XpN8mYsUMdWVlWhgrbl+ObmFqO+aeYQcyd1DU4oUQgxFC2LRtIW7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151379; c=relaxed/simple;
	bh=D/zFlUeGmQMr6QfgfhmgTmaFLSbCFXOSVpi94ykTDrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usP7ST4Q6Xqs+4yNPbFcBFJ7fVsWUwyZHss4fiSZ45DGtaZCVQsVw5QLBdrXCGsqe5MnVO0CVpi/VHtuC7r+nSKBk8oOL4xiF9nPO5towUsmrz7F9PMLu4567Pxn7iWHgTCGMWvRll9r/aDc6j6L+t4jDCgfPt233tZm6WnIopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMp9zX7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMp9zX7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE6E1F00AC4;
	Wed, 19 Aug 2026 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151371;
	bh=0bjCAfcH+R5O+TCqEMvPOhjQm7Xz/VwA72GXErsL93k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMp9zX7yU0d8MMFR5QnMPnTuMkFnl3ukUNbqXTQ4o+1zNFw/BMYFLk7PEWb2820qQ
	 FV8D9xgtVene8ls6NjEwTTJAHCtQnhKeiD0M+IPoNylHgHqSARMvhOV/VtrGRXq9nn
	 9OYtM7iSqm35vuRPT4c7j22kzRhvzfb1vcOGKPix+pYQRsNhJyJtDmqykoj47rG5Dh
	 eUBJo83liM4pYaRxk+fDNMrY+ehn0tPXFRiEL02n7GluFg7b2lLaEZqkGCCpoOIZ6I
	 N7f9tabj80sf0y7AvTvPi00nxZj4g49k6QTHLW2hcz9LAACszt/ta5yxHe+Nxl3rC4
	 4OMMAt4wVlxhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] selftests: tls: add test with a partially invalid iov
Date: Wed, 19 Aug 2026 10:56:07 -0400
Message-ID: <20260819145609.3899291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081717-cupcake-probiotic-dc66@gregkh>
References: <2026081717-cupcake-probiotic-dc66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit dc54b813df63020e946ccdef35b64d4fa99fd622 ]

Make sure that we don't return more bytes than we actually received if
the userspace buffer was bogus. We expect to receive at least the rest
of rec1, and possibly some of rec2 (currently, we don't, but that
would be ok).

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/720e61b3d3eab40af198a58ce2cd1ee019f0ceb1.1711120964.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 1c8629651cb5 ("tls: rx: restore msg_iter before TLS 1.3 optimistic retry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/tls.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index bc36c91c4480..a79270970ade 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1570,6 +1570,40 @@ TEST_F(tls, getsockopt)
 	EXPECT_EQ(errno, EINVAL);
 }
 
+TEST_F(tls, recv_efault)
+{
+	char *rec1 = "1111111111";
+	char *rec2 = "2222222222";
+	struct msghdr hdr = {};
+	struct iovec iov[2];
+	char recv_mem[12];
+	int ret;
+
+	if (self->notls)
+		SKIP(return, "no TLS support");
+
+	EXPECT_EQ(send(self->fd, rec1, 10, 0), 10);
+	EXPECT_EQ(send(self->fd, rec2, 10, 0), 10);
+
+	iov[0].iov_base = recv_mem;
+	iov[0].iov_len = sizeof(recv_mem);
+	iov[1].iov_base = NULL; /* broken iov to make process_rx_list fail */
+	iov[1].iov_len = 1;
+
+	hdr.msg_iovlen = 2;
+	hdr.msg_iov = iov;
+
+	EXPECT_EQ(recv(self->cfd, recv_mem, 1, 0), 1);
+	EXPECT_EQ(recv_mem[0], rec1[0]);
+
+	ret = recvmsg(self->cfd, &hdr, 0);
+	EXPECT_LE(ret, sizeof(recv_mem));
+	EXPECT_GE(ret, 9);
+	EXPECT_EQ(memcmp(rec1, recv_mem, 9), 0);
+	if (ret > 9)
+		EXPECT_EQ(memcmp(rec2, recv_mem + 9, ret - 9), 0);
+}
+
 FIXTURE(tls_err)
 {
 	int fd, cfd;
-- 
2.53.0

