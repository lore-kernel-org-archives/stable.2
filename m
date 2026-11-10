Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326548;
	b=MahjmF3ZhaQYzyTshSK8Wg/KZLinGYW5rGBTgHs3gsKfHzrg+nmvkW5UabAoFAAk0y6M
	 UlDYGLp+MGKYVNRKBZMm8vRnkLsMDrHfL+1qqWPYATinYxMBkwE5ZNRfrluq/7cxsFuHK
	 YlbzbPaL80FdRv72JtjOijXcj1fHn9F3PafC3d3vZxKKmGbyNntzrJeJyfIsF0a7D1Snv
	 H0UL+/rWyVwjQ5t1PjnQ/NOW2/xVA6ZZQC0TKp7YYq0d9YohA6z9z4/+yUZRvtOEtW7J5
	 RLA66ahDzMWNMtOl3mte7vjFMSq5GKkFQVhfTRi1rU5MEd+FQ0adSIJREgYRGPtQE8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y+Dm/oDupbMZFnnm4R4Tia831mGuYz9Atax42vL79sI=;
	b=Jtc+Jc7yb/pzZHDdv7pY0tW+viallciJCLTHZXmjOJKfhNRnMjLTD7o6TtnLD19Ps5jp
	 w6lCEMOMjZFNt5UREKijOQThpDaIqXjJDsuRJOsBWvOqrbM1Wgdc3NMVEasnSQekyAz4G
	 gyzmjWb7e5oDSaFjL5bbGmEoD/38feVTUHqjl8OY8o53SypUsvA6vpUZK4BE1z8EOXOJJ
	 b7ST65RKOVV8OazlruVm8wgtxJFsMfOi8GYS7jhoex2KDD9SgEemgjgugVqWsI+YUoma1
	 uJUVZronDp8RTlE7A0kQQ0EarKwdv2LS5RhVU2XaOBZS0Iw3DPACgqhjsCcCwKGGdFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6T7A9IX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE16606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6T7A9IX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A18D1F008A1;
	Tue, 10 Nov 2026 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326547;
	bh=Y+Dm/oDupbMZFnnm4R4Tia831mGuYz9Atax42vL79sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6T7A9IXYjwfShLVOseU6W/2KIuoBOecpQSgjf4n2fcN+aVHf4hcnKgUy4JARWCPQ
	 poid2qtuV3x8z3+r86Iz3b6dOTkjKiVhSERQ+qlJB7dpa/afpsh/A3Fx65Bhvn3lwB
	 YBvNfAGlTcq451dG9W8TM10EwiuDOlFQRFfV/ZUPNCnNJOajLhof6UjsH54yIvWpWF
	 +ZzCvYJ/b6IqsNB1UuwlzIDqhE8OZh+SnIaPSYnRL7LjdAfV57YJvU9UxWEaglLtKo
	 GnBxaJwcmJoqgmeE2UegkTaYziGrY3JGRKIlQ3EggwwFwIBEygt8VBYydJmg1W98F7
	 rjFjuJc7y0J4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] sctp: hold shkey across socket migration
Date: Tue, 10 Nov 2026 11:02:24 -0500
Message-ID: <20261110160216.2383568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052316-failed-6.12-52ffeaa358d1@kernel.org>
References: <20261107052316-failed-6.12-52ffeaa358d1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lee <david.lee@trailofbits.com>

[ Upstream commit ad1320865b1826ffa2e81e37c49535751e81335c ]

sctp_sock_migrate() transfers queued DATA skbs from the old socket to the
new one. skb_orphan() invokes sctp_wfree() during that transfer and drops
the skb-owned shared-key reference.

If userspace has removed that key from the association, this can be the
final reference. The following sctp_set_owner_w() then dereferences the
freed chunk->shkey while trying to take the new owner reference.

Take a temporary shared-key reference before orphaning the skb and release
it after the new owner has taken its reference. This preserves the selected
authentication key throughout the ownership transfer.

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20261009074244.3718-2-juny24602@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 52ffeaa358d1 ("sctp: re-point retained control chunks on association migration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e2885a994314a..3d45188488b97 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -149,9 +149,19 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
 static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 {
+	/* Keep the shkey alive until the new owner takes its reference. */
+	if (chunk->shkey)
+		sctp_auth_shkey_hold(chunk->shkey);
 	skb_orphan(chunk->skb);
 }
 
+static void sctp_set_owner_w_migrate(struct sctp_chunk *chunk)
+{
+	sctp_set_owner_w(chunk);
+	if (chunk->shkey)
+		sctp_auth_shkey_release(chunk->shkey);
+}
+
 #define traverse_and_process()	\
 do {				\
 	msg = chunk->msg;	\
@@ -9707,7 +9717,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.53.0

