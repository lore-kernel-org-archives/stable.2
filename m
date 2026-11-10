Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327212;
	b=Ms+PlzrktMjU0XrwEnYQHkmyXZ+4PKWlFHM7SKITL3Mg9MJ2rNsG5dla19hZR8DIKn7B
	 2e5BLiRmWxe6tAZZz0pZJ1Kk3Mn+A1v0OwjGZM/IP/YHxfJ5zgpI4cxBCyy71m3deMzUb
	 B8jdWiY3+nnGI0fNSr2Y3JkVHxZ7oncBA5CzQSDqbFjqxFbcLZonwkL54Adcl+xou5NLs
	 dw80j88EinZDC8lnCCJSbQZnrFuZf/OWHutDFBUGzMzMdwpv5geCzZsrjlVPE1Sz4Jft7
	 PfOJeQmCMg7WxWfdgS/IMmPDO7LgzZqjPz2Xqr1dKTacllAIoI8nHVmp/HWd8U3TICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DD6q8QZEKN6O1rA4twGRX0t2VtIxl48PvlLu6hY7XHk=;
	b=amjn2pp2AZzwhl4BIUcZKY2o8gO8LwQyNXuRqmTGXp4qJ3cG3KIkzzZprNfSXCymgP7R
	 HndfmJohIDcUvosMsO7AXOkN/XkWjMXN+sdCdaYGZ8RIgqBrVmjSZ3FIdZScm5vuk3msC
	 RT8Gzv+IG/CaDVdY01a9ScgRVefo0ESCy6THTZEpL1U99AaSVLcY1UP7EDIqB0A2CZ31P
	 lgWugDBh6/G3RnwxKIWSbg209cNvMnI+2VrmywMUJBD2ZOXdUCxMTOXtjX7YL1UA1xpUB
	 qn+msc4IzPa6B3UP2/q2GIGJXYtHq9JHlFQYu1+fjtorWSdtzqhVcE6icJwcEAH6epg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6+f+bvH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844ED606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6+f+bvH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0C01F0089F;
	Tue, 10 Nov 2026 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327212;
	bh=DD6q8QZEKN6O1rA4twGRX0t2VtIxl48PvlLu6hY7XHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6+f+bvH0U/FLdNZo6qciLlaGcp8pdD4nktQInZ+F6Ov6ebA4AMlwiFQtRNl59yQQ
	 m+gCwPBvuka2VU/3yH3BaszmeYjQtjTQRr/6l51VQdibW3jRPIl3DFYBrKWyOJlQnm
	 HcvhLgfj5lHeWvluQPVNnWJizXdjN/d/4SyalMVOwuHCAe61DoakioYD/25eF0Wsro
	 ZJfzx0NEQwbOs+BPqzYOr+Myeh1XT9LroZcP98E7NNCwXXbc0v7vu0XAzaxPn/95XA
	 6nPNVoi9XKM1WkpUEgXxlTwDXidLSuXz+0gO8zZk5hgsOQ9GbFJLStwRMKmBde/jFT
	 wccmWaU68sNJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] sctp: hold shkey across socket migration
Date: Tue, 10 Nov 2026 11:13:29 -0500
Message-ID: <20261110161323.2411320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055009-failed-6.1-52ffeaa358d1@kernel.org>
References: <20261107055009-failed-6.1-52ffeaa358d1@kernel.org>
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
index e9e13ba9ae4c7..04c3b8a8d2dd2 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -147,9 +147,19 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
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
@@ -9692,7 +9702,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.53.0

