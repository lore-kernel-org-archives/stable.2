Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618413A1A22
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151384; cv=none; b=FKTEceuAeX8oKXLWGrWSnBp2S7aiDBmHNXrnMxNtKKRfQ8c1fru+bDq4T6vUq3taH4aarJo1l/ooj9rzK49t38EoJTQzDbibqigYrGVd3AU5qBeU2S4KnOwBTF2IhCIICiIzP/HxxELkAtGFT19YwBpyVHfystpk4nrlX7ylExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151384; c=relaxed/simple;
	bh=DKvvNEs6UeCfvDLKm2U6pz33QdK4/N1HizWTPFM0OAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biMrZ8h+1Bfb0yVZGxMcAVr98xdtCsUt5g7FClRP1A52yPdD4iSS7GfGhhmZiuuCGw9e6HtYzZefOEwRaFRz3sUsmfhr/C7depIwHmU2XZFuBHOJrp57sVtr5HBZ7YlfEAkNQPWgrOc/kqq1kql8MfkKuEvkJ99yHlTlRlGl1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqkmXfwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqkmXfwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914501F00ACA;
	Wed, 19 Aug 2026 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151373;
	bh=ssbu3uy38u8HkFoXCQzKCjqLB9df0cSnVJTW4LawQ48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqkmXfwLTMedKFUWA9BB0xcVMId+d6A2l09riWNSVb67MlfW/ng1poE0fSP0RyIHu
	 gVbe6Hc1XMBQhdAj9fNanyhXoJyypBEX4IVvuOJz/X2wkxayDbK0Zlt/JFuiOPDlYi
	 g77tcemTq9eYknz6K+i91QcbsOsS623DXVWDgW9eYna80JLEzuL7S86pfRYcPss9pm
	 V4WIgbAcl6WnO4xpwgYv6/SvOQjWDE7N/39VcoLKnFcSaJpew1Jxf7yi6SoFhWzPnk
	 e73u6gQYgiaUEJrge7YDPeCuQCDqRJTOnODcr3lPR/SKjejYnBdP/jrsvw2AH6CK2O
	 4nsTW0IYg8cWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] tls: rx: restore msg_iter before TLS 1.3 optimistic retry
Date: Wed, 19 Aug 2026 10:56:09 -0400
Message-ID: <20260819145609.3899291-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145609.3899291-1-sashal@kernel.org>
References: <2026081717-cupcake-probiotic-dc66@gregkh>
 <20260819145609.3899291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 1c8629651cb54f7b51db8fc0b1a9944e4a4b0f5e ]

tls_decrypt_sg() advances msg->msg_iter when it maps user pages for
the optimistic TLS 1.3 zero-copy path. If the decrypted record turns
out not to be unpadded application data, tls_decrypt_sw() retries into
a kernel skb, but leaves the iterator advanced.

The subsequent copy from the skb then writes decrypted bytes again at
a later point in the caller iovecs while recvmsg() reports only the
post-retry length. A TLS peer can trigger this after the receiver
enables TLS_RX_EXPECT_NO_PAD.

Revert the iterator by the number of bytes consumed by the optimistic
mapping before retrying without zero-copy.

Add a selftest which sends a TLS 1.3 control record with
TLS_RX_EXPECT_NO_PAD enabled and verifies that recvmsg() does not
overwrite later iovecs beyond the returned length.

Fixes: ce61327ce989 ("tls: rx: support optimistic decrypt to user buffer with TLS 1.3")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Link: https://patch.msgid.link/20260804125528.2139928-1-Jeremy.Jean@oss.cyber.gouv.fr
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c                  |  2 ++
 tools/testing/selftests/net/tls.c | 57 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 39021fab3c59..5ff814269224 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1727,6 +1727,8 @@ tls_decrypt_sw(struct sock *sk, struct tls_context *tls_ctx,
 	/* If opportunistic TLS 1.3 ZC failed retry without ZC */
 	if (unlikely(darg->zc && prot->version == TLS_1_3_VERSION &&
 		     darg->tail != TLS_RECORD_TYPE_DATA)) {
+		iov_iter_revert(&msg->msg_iter, strp_msg(darg->skb)->full_len -
+				prot->overhead_size);
 		darg->zc = false;
 		if (!darg->tail)
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXNOPADVIOL);
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index cfce63c7253a..73a777347227 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1605,6 +1605,63 @@ TEST_F(tls, recv_efault)
 }
 
 #define TLS_RECORD_TYPE_HANDSHAKE      0x16
+
+TEST_F(tls_basic, recvmsg_nopad_retry_iov)
+{
+	char payload[32];
+	char first_iov[sizeof(payload)];
+	char later_iov[sizeof(payload) * 2];
+	char expected_later_iov[sizeof(later_iov)];
+	char cbuf[CMSG_SPACE(sizeof(char))];
+	struct tls_crypto_info_keys tls13;
+	struct iovec iov[] = {
+		{ .iov_base = first_iov, .iov_len = sizeof(first_iov) },
+		{ .iov_base = later_iov, .iov_len = sizeof(later_iov) },
+	};
+	struct msghdr msg = {
+		.msg_iov = iov,
+		.msg_iovlen = ARRAY_SIZE(iov),
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+	};
+	int one = 1;
+	int ret;
+	int i;
+
+	if (self->notls)
+		SKIP(return, "no TLS support");
+
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+			     &tls13, 0);
+
+	ret = setsockopt(self->fd, SOL_TLS, TLS_TX, &tls13, tls13.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls13, tls13.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX_EXPECT_NO_PAD,
+			 &one, sizeof(one));
+	ASSERT_EQ(ret, 0);
+
+	for (i = 0; i < sizeof(payload); i++)
+		payload[i] = 0x40 + i;
+	memset(first_iov, 0xa5, sizeof(first_iov));
+	memset(later_iov, 0x5a, sizeof(later_iov));
+	memset(expected_later_iov, 0x5a, sizeof(expected_later_iov));
+
+	/* A control record forces optimistic TLS 1.3 RX to retry. */
+	ret = tls_send_cmsg(self->fd, TLS_RECORD_TYPE_HANDSHAKE,
+			    payload, sizeof(payload), 0);
+	ASSERT_EQ(ret, sizeof(payload));
+
+	ret = recvmsg(self->cfd, &msg, 0);
+	ASSERT_EQ(ret, sizeof(payload));
+	EXPECT_EQ(memcmp(first_iov, payload, sizeof(payload)), 0);
+	EXPECT_EQ(memcmp(later_iov, expected_later_iov,
+			 sizeof(later_iov)), 0);
+}
+
 /* key_update, length 1, update_not_requested */
 static const char key_update_msg[] = "\x18\x00\x00\x01\x00";
 static void tls_send_keyupdate(struct __test_metadata *_metadata, int fd)
-- 
2.53.0

