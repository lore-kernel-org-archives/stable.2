Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B292D877A
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970916; cv=none; b=POe99aYkIitd5hRTdezGY2ccEV8KUA6RiNySP+YmbNoGIe3yJb4kUfN2LQJ0FnkqWV1HGGv1A2rLnWqdgQCZiJZZ3LCdyfb6uiWyQsJpofbTPLHEZGsQBAAutDx1UdTs390jQAHmiWGlflZKmxvcLtWdiyEHKgXnKjxMugJ/778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970916; c=relaxed/simple;
	bh=+CP9735q9z4HNc13+q/z2tvNla7jgahP0+it/3cCswY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Re9bgSI8yF+JpDJJIeDPeSVT9BMhaOFdShkJGfUgJU4/DFaS3TVy1rGULW2Lfo15+Ez9IVn/D5yLezCggpAkuQaagky+YSN/w0/XD539Y8YebdTCTyYyPPVaQqFnsNl9rBVgheRd+e3Ln7Vi9JR/nh3KFa7ApB+e5LMJUAkbkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KRwCMrQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KRwCMrQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB211F000E9;
	Mon, 17 Aug 2026 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970915;
	bh=eS6/q8VLsRR4Y00W5uo+HEXiYV1DzHxf1HRujbayX40=;
	h=Subject:To:Cc:From:Date;
	b=KRwCMrQmXBjPT0sbi4FjHmiG6c6XMrt9rOs8danQwnRiwNpr0oXVXt11a/28lmtrm
	 Ak+/KLfDit7KtKzIoKXHFaX3pl4bYNe+pxX/cBdyt1o9OzWKgKo4UfQY1GT9yPjG8a
	 B1xwiWC9vTOwQojYhlkKCHuKiVeWTQB/Mx4QoMS0=
Subject: FAILED: patch "[PATCH] tls: rx: restore msg_iter before TLS 1.3 optimistic retry" failed to apply to 6.6-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:48:18 +0200
Message-ID: <2026081717-cupcake-probiotic-dc66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8629651cb54f7b51db8fc0b1a9944e4a4b0f5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081717-cupcake-probiotic-dc66@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c8629651cb54f7b51db8fc0b1a9944e4a4b0f5e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Tue, 4 Aug 2026 12:55:28 +0000
Subject: [PATCH] tls: rx: restore msg_iter before TLS 1.3 optimistic retry
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d2e399be8ef6..133ed7c89402 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1456,6 +1456,8 @@ tls_decrypt_sw(struct sock *sk, struct tls_context *tls_ctx,
 	/* If opportunistic TLS 1.3 ZC failed retry without ZC */
 	if (unlikely(darg->zc && prot->version == TLS_1_3_VERSION &&
 		     darg->tail != TLS_RECORD_TYPE_DATA)) {
+		iov_iter_revert(&msg->msg_iter, strp_msg(darg->skb)->full_len -
+				prot->overhead_size);
 		darg->zc = false;
 		if (!darg->tail)
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXNOPADVIOL);
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 3d6f553eaf97..a0e72e402748 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1839,6 +1839,63 @@ TEST_F(tls, recv_efault)
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

