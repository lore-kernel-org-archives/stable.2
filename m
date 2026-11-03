Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748495;
	b=romRGf3KWw0/S1UvnqJ4+sePXI8qh1sZGiydcgEIljgnODc3sMSAvsqxmcyumJQpgXTY
	 PHvh73vYZv1cR5dyZZnT7aoH6vL1MS01Sy8x6awIJPi2wSy6yMZjb8zVACavVvDXw01Pj
	 pgmmWIBBBlEJD2ZFc4Qumj08zoz2n4B25NFv3WXvfvKM0qEF2BD1GNkbq97e5u9zMrnY1
	 kF65MXynxvneH/B3XnjI/9tJVul092/nbBhaZXNNZtVKteSH95TKaXnaWZpGidfXlEwLw
	 2kPlVn0Z/BWUJYVcQnrRDsxrhNCyYlBof/sJPnw+cwCDynxnGMlg3tEohKbTkYtMXmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BuvKBZZT7vspiL9khnnSeHmRCdSafJ+of+w9p2VPzFY=;
	b=xCndwJink7v1v626GSDf9hUzeMUUjDs3SHtwmeon4gZnSptj1pYUCpqJL755r2nKxkow
	 nDjGy8Na9T1C47sw8veIlRulRWnSub2elxXMQytzx/aAOxRfPA0ScHgbReJXzhMCmCS63
	 MF312LE5Bexk96gXbJB62j/HGOT9v7S00oZ2X8Qzh7quAYLVNvs9j8Qe3O1Byk9+9GH7b
	 vLKvs7lwIZ5qU7iug2j0ZVidlnMAkZHya9y5RhHA4glwdnLRj9Q4yS1Y3ofGO7Fuj1Ln6
	 /srurnmAGiht6CdJ1kX6ROL95ledingkdgiucd1Bl80TWgnGPTr5X0OhDKa0i5ozBuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE12fB6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CF606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE12fB6r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B21F00A1B;
	Tue,  3 Nov 2026 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748495;
	bh=BuvKBZZT7vspiL9khnnSeHmRCdSafJ+of+w9p2VPzFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZE12fB6r4ktlTn2rNZ+jtfiVeKnmj4TOIuifXS/VKXJiVaDK6a0l8bS75Vyf8PkGZ
	 es2uQMoaZbD+EwKr02phPKZO6n9qathPERX9VVA0To/End9AviQZw4btJkhpbC1Yr+
	 lgYmJYdly9ltbt0cQtRNnr8WgpfK9Gw0GFMaK22qe1lqcNAxmL5gFsPkHsJfH4RJND
	 zsuawc/w8TGlNjKP/wXcwp9EtmyjuVoR3bTYJ+jxeVAjKiNJ34tZXx0UeYzx6Qq+H2
	 SooTZz3/VTQ3xODvLIV6kQAYeJM9zOgjlL/ArG1UMvqoTWY2dGNEow8bWJ8MRjjK2W
	 Trczqn/2TUR4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix session reference leak on compounded SESSION_SETUP
Date: Tue,  3 Nov 2026 18:28:13 -0500
Message-ID: <20261103232718.1548000-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110320-crepe-chapter-73d8@gregkh>
References: <2026110320-crepe-chapter-73d8@gregkh>
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
[ sashal: omitted the installed flag assignment from the binding-error branch because it does not replace work->sess ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..d24c0b3d2a33a 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1703,6 +1703,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	struct smb2_sess_setup_req *req;
 	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess;
+	struct ksmbd_session *prev_sess = work->sess;
+	bool installed = false;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
 	int rc = 0;
@@ -1819,6 +1821,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		conn->binding = false;
 	}
 	work->sess = sess;
+	installed = true;
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
@@ -1976,6 +1979,14 @@ int smb2_sess_setup(struct ksmbd_work *work)
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

