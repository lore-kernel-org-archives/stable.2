Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325948;
	b=gVn7cKcVJp40vmGQgOT3ZYDsJLAw7VFjTbkydpPoGE5WBR4enndUxfymPisfa2HMjQh0
	 eUx98lUSQiPahFVkySubUmPZuup/QHocXJofAznkPdQ2IN2Apb/Ik0ojMfW/3x6lAL/g1
	 T6RolCvUeL3w8Np87cPKSa9H9EjViKx8pdMh/hS9uLRVWe+h21oPc+Se67qa040OxeaQb
	 KwE2DHeFL1izd7vo16iDVcFCV6FxsKn9MBze5kynrfTVEo/Ngu3ZPVI9/JEo//a43WISu
	 LQUi15f+a0RL6ZEWAYEpwUK/1yOHVBgDUvrCiRLK4yERTBLK40EPMFhjb1UkwMQq5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kvacwBNxHoohQeYATf3YslVd/AD5lRPWRkxpoDZW0zU=;
	b=5GtRCXtm2we8TOBTpdOLvJNZTjoOzNiEs5/X+S969oxE/BHzr/yb18uxpXjBxTRTt6df
	 fdbpPs2U0Vj2Io6rGg1KQY7rUr+dtXdvgvPOilUJ29lGlZBmT/Q22SUjBxAC/aLjHkhe8
	 xe4LQUpOtDOY966Lt4PtkAJmkLNu+CHqMkoHrdiwnUE8G6zdw44bz+70TcOpx5JlW9FqX
	 8q0NkeTqqJau2uScn5mexHry2K/RsdCTgzqn67t06wWmRSAGAyoIyf8jf1djZSL+T/H9X
	 qbGYSX5fwpX3HjXMlcomYw0ou33M49ebnpZYZGqG3zZOzUgnL4CKBRh0IrOvR546xSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6bo1BYt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC84606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6bo1BYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A991F0089F;
	Tue, 10 Nov 2026 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325947;
	bh=kvacwBNxHoohQeYATf3YslVd/AD5lRPWRkxpoDZW0zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6bo1BYtcmt6D9qdTxvke3DGODDqhE4ycaLPEre4OZRNJgvijb7eZYoewPLQtP6sA
	 NFVy0Rj+jgBh9CqubKKIeHl3rsN/FL9TZKj+tB7YBwdtUFzWbvkv3Ncyu0dJWe4JmL
	 sQM7SYN/97J9ytRGq3dy0NVlmpXEkXVg1CMMaBL+yHO2LuBnYXlVtDnIXV8z8p2lNK
	 v7+Vg10LH0wcpULQG8eemOX65N/8DGPHWL+NgYQ2T2V6IZQSUe9hqYQvf2+CxPo7Hp
	 gW7bwy2lclE9iuKUgTyf738WE4MQYvlvEtqaQcdUBXQiiw2OVJYpn8exmanzCdTpci
	 l92u70REBDuoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] sctp: hold shkey across socket migration
Date: Tue, 10 Nov 2026 10:52:24 -0500
Message-ID: <20261110155217.2337999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050505-failed-7.3-52ffeaa358d1@kernel.org>
References: <20261107050505-failed-7.3-52ffeaa358d1@kernel.org>
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
index c616f1609d0cf..b5e205eca3077 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -148,9 +148,19 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
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
@@ -9649,7 +9659,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.53.0

