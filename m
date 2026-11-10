Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326250;
	b=gbqeH1jSnUTNVAlXGQoT66Nk3HpmizhfmZrHO+md9Bo56MjtLGrIR6RpshCXJh6Lb1EH
	 lkkl7g1GLa/YKSNs4tMhQDIFpqJ/1noeC/CvmuwM3Hvl45aPguwlLzQF7e+fV6ZCXA7Tb
	 rZ+zPmF5QywqHQ3pC0heW2pKbxUQVxb5SCXXnd8ebBowbmrNZ10nvUfvTYzret9xkHlCW
	 DrWV2Vb63KUOnCfTAWKHMbkmTKE7mRI4bNuOZsnu3NZvr6iR1BlYx/wQxML7miz4RhOof
	 Xe3KrbGlvxQKEi9MG+ha1DQhSu2Ba6c8hdA0E9DPtShVkcnk/IlhLMLrOA3n1PAaX3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326250;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c7Nlli5fWn3HHlIm+atjDAHBnCSJGgcpy/EuZhXv5B4=;
	b=4BDgjqv7fMXqSAdoJSmsCBjgtcURXvxrhJzFVGYU/BHZyxUgNg4DdQRRZYUd65H/fJOw
	 pZAPxGAgFFGGR8ytqPFOBPJKtK8u5/J3RHoI14284ZfwYjIa42k8tuM76yad6RMUQh54M
	 bQZAyJ8cGajLEmMqfj8VelsoM3ka9VcS+JyXUF+YNfiFlCF5P10JK6mOhAgVFmQlxGphj
	 YGsTbtD9DPn/fZrWq+8piSsZoedOWnwLJVbvenrqj45qAu/67tKOSz6MKH/J23AfuyzM6
	 c/7B4crtaX7W4bzZvtYbM9F7/02gbIJR/XmEhxWCXDdIfftk7inxbMBeVUYESkX2TkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3Q5GxN+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C5606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3Q5GxN+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5951B1F008A1;
	Tue, 10 Nov 2026 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326250;
	bh=c7Nlli5fWn3HHlIm+atjDAHBnCSJGgcpy/EuZhXv5B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3Q5GxN+hm8nrU9EMAtVuqXbVWLrzKOpkyHi0AJJDgdxc8yC+qx9hYoRhxqv3z7CE
	 slWoEDgf7P5eLHxt05VLZVELvHB4q/LdEsqCppI6ViC8cSK0pKMvKqD4kIBATlSeCr
	 sezlaKXsrNvYDBQJZBiiC7TUBtnAVnke17LzXWAXZUC5L3ljDUN22/m+AuvqSvizf0
	 GEPZz1jsu8E8ySGBpjc2oZzxTSwjs5gLLRntVhNyaKi0NliLqXByGNrNB1Oci0NoTG
	 pMo/si8fmuBlsQU2RCfIRCy++z1AZyv7uHL7iqzXsnyAg5z0+CFXSxT84puk006gN6
	 VdzTkygjTjkkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] sctp: hold shkey across socket migration
Date: Tue, 10 Nov 2026 10:57:27 -0500
Message-ID: <20261110155720.2371604-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051203-failed-6.18-52ffeaa358d1@kernel.org>
References: <20261107051203-failed-6.18-52ffeaa358d1@kernel.org>
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
index 8c9970352952e..285cd8e0a1cfe 100644
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
@@ -9669,7 +9679,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.53.0

