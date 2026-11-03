Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719795;
	b=kkJ+RaJZ1JiO+wkNfMvumbrZX487/4U2W2QLQtDeStd9skMq28BMbkQC/VxK0HEHEBST
	 1IbrsJgcIHnCdVbeWFVspnK6n2M3XOZEQUFcU5mb70jQJxdTYX+mG5wNXmTigPJ0W/evf
	 YWr8ItqURCQnXZ5CRH+5+euFnMbgYwnqjZYLo8MsQCoMoe9GPmz+Q6/6K9YoF+1eRGHEr
	 4TEpqehnxr/IJeK7YEvziogJPAHjf9rfS/RhHpMNBaCC+yD9KJFUKvqFbOk4UU/K9u88J
	 TY3COIDNZ2GYjhOBoHVpg3LbJQ9jkKwpYzdTU4W0dmVfPQAGf6MQ3SRbwTJY/TCS2og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=flO+7ofdpFozKcygsZRsf07vWitwhA6H190iuxTQg60=;
	b=KdR49UL+uC1JOJCyCuyZbIpwVGhsz7C9V1Bx53dBkaCJfzdXtEaE9Rq1bYCHxleSHItv
	 HjHb29BzAd5i+/yL76A6tb3QIDrR2QEN7TrwogqU4js6QbTbsq+aac5QJZJlhrMjVR9TO
	 /BNFIE/ONDJg9jv7T6auSSFwrCofV9EVmfaLj58GeSczmGz7m9GZc8qyLGcqL/NGbPHF3
	 6h+0PTsaxKDJy8d3cg+PbWi4H4xD03jbhv14aoIODTl0l1w6/RMEeLiE0RjSVanG0Td8u
	 ICfqnQGZhraj5kA84eZFt4plD0g+RD3rjzxpo9vImuu3QlmMSbttBVt3mDxeth5NkHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2O6aqJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0F606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2O6aqJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627301F000C1;
	Tue,  3 Nov 2026 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719794;
	bh=flO+7ofdpFozKcygsZRsf07vWitwhA6H190iuxTQg60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2O6aqJXAf+cva9ZcaCPMzFeHauAscqMsPNvWBUEoAYJmclotdqbZTrpmKKXduK6d
	 vcpcXEoMqypVUmPwh3Z8u0Shg0J2lpU79vm3zU7d5Kfwds3bZdjX4Lj4g6jkS0B/2E
	 OwgcGe7AsXESaLohc2CZkdp8HPaGqBS3ezmwo5rQkYix/++xMQhgG4hBBLSoIqlgKb
	 qtMwE+kdS8xAH5qxDBvsMrP5tTkqiddu0/51AmH+PXX30eF9rpOv3iwRfg3fD3iH+D
	 1lMJKVaWzrFjvsIbgSiLNFEgTKAJge/ON1WM1sKtSbQCEmihQIdRlmOhtgWeia31PJ
	 1IQLTZ9tvO6nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: fix session reference leak on compounded SESSION_SETUP
Date: Tue,  3 Nov 2026 10:29:53 -0500
Message-ID: <20261103152926.251494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110317-undermost-pretty-44e0@gregkh>
References: <2026110317-undermost-pretty-44e0@gregkh>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 03bd8f5279e490e15e0c0f0fa388ffbd2fbacd65 ]

A compound request can place SESSION_SETUP after another command. That
earlier command leaves a reference to its session in work->sess.
smb2_sess_setup() then overwrites work->sess with the session it looks up
or creates, and the dispatcher later puts work->sess only once. The
inherited reference is never dropped. That leaks the session, together
with its setup connection and socket, and every repeat of the compound
leaks another.

  unreferenced object (size 512):
    __kmalloc_cache_noprof+0x32c/0x3a0
    ksmbd_smb2_session_create+0xf6/0x9c0 [ksmbd]
    smb2_sess_setup+0xda4/0x6280 [ksmbd]
    handle_ksmbd_work+0x88c/0x1cb0 [ksmbd]

Save the inherited session on entry. After the request has been
processed, release it once, but only when smb2_sess_setup() has replaced
work->sess with its own session or cleared it. Do this after
ksmbd_conn_unlock() so the put does not run under srv_mutex. An error path
may instead leave the inherited session in work->sess. Keep it there, so
the dispatcher still puts it and the error response is still signed or
encrypted with it as before.

Fixes: 7aa8804c0b67 ("ksmbd: fix user-after-free from session log off")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Omitted the installed = true assignment for the absent rejected-binding signature-check block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 793c219b9a610..7c4b41a523e7a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1698,6 +1698,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	struct smb2_sess_setup_req *req;
 	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess;
+	struct ksmbd_session *prev_sess = work->sess;
+	bool installed = false;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
 	int rc = 0;
@@ -1835,6 +1837,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		conn->binding = false;
 	}
 	work->sess = sess;
+	installed = true;
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
@@ -1988,6 +1991,14 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	}
 
 	ksmbd_conn_unlock(conn);
+
+	/*
+	 * Later in a compound, work->sess holds the reference that an
+	 * earlier command took. Drop it once this request has installed
+	 * its own session there or cleared it.
+	 */
+	if (prev_sess && (installed || !work->sess))
+		ksmbd_user_session_put(prev_sess);
 	return rc;
 }
 
-- 
2.53.0

