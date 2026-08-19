Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3F43C058
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139588; cv=none; b=ZwxyIbl+oouMpJlQyUKlh+olVt0SJs9aFwePlHjYBeBYPSOs3iErJSw+ibFFDoRvfBbNbFKDQOSAzr1K1OrMb3tHF94mpDmzaIldGqL2JJ0n434uQwP5TAKnnQ9Q5LQfpDKJwb1bZwRdQcf608Ojwm2sHPJRafuxQE0to/znIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139588; c=relaxed/simple;
	bh=B/CiFG8GQZ/gmqTdxlFGtNrsEwMuo6oszw+OjSukdnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZ9V+5HAhiy/NW5gV77NnESVPkvNLA4cyq8k7ZuPaiCkAABWa/gNQk+cxix9s23pvgnfH74OyCeLaMMUwTlyPELB5dCRpH72cC1bsfvT1pa7l/yOEoMSXXqAjmDrrIHd8L4jUFdZL3j23XuJR8LBE2NW1671JfO+8zb6VI9t48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIjFV9al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIjFV9al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE711F00A3A;
	Wed, 19 Aug 2026 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787139587;
	bh=q7M0VmL8o3f1/1/hKxY8u9RJOCAGF6f6mEXz4xSK4Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIjFV9al5PW56vTvKKwYLMDgD6eScFmEeH6dgc/aX3AyFTnXWOK7oIx7UCo5ZS0dh
	 4mGcNTgs17zH6PZpR6jpPbECICImiPedcD8alpD/pAaJ/Ua0jiX/Vax0VPiKl447yB
	 5s8PkIeNTXT3i5Rv2Zrzn8/3QZHPrOlR0xf9x/lqrfqFna+1kK94xdl/oVHe8gpU8v
	 tqq3A57TYbNiLj11VGkoB7goi5DQDH5KNf2BQAmsCVlPoRo5OYZXEs/Wj63UqSC6aI
	 ZjSFO4s4bZNpGHqMGuVT55wHQlhw82SUsM35TO2oeIuzAFIyjTcDM23MHca7LvQHMC
	 K6v1VesVtP9RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] tls: rx: restore msg_iter before TLS 1.3 optimistic retry
Date: Wed, 19 Aug 2026 07:39:44 -0400
Message-ID: <20260819113944.3620902-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819113944.3620902-1-sashal@kernel.org>
References: <2026081717-verbalize-stylist-2627@gregkh>
 <20260819113944.3620902-1-sashal@kernel.org>
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
index 2b875369d523..5c55a16ed593 100644
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
index 1264a20c1a04..9388e77a1b21 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1650,6 +1650,63 @@ TEST_F(tls, recv_efault)
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

