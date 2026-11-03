Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723978;
	b=zww6llB5VSY/uSiHOLZgNzn5seGNzCLMZrzcQ1E7Xgb0ZDkFdq4fCqUMWwv4IRTl3lp/
	 T6RGVlPYUFnZvEaWdxmwMrnG6imMuFbkfyJ76kCGVspp7nqP2MpLg9IBjPtPJaaNjLaWq
	 SQVqOJIPpDrXWXVdd03y1qKtNP/LQ48qXlWwWG/stZBizWcuzzc66yGueJfZNdjsu+VES
	 EzTBMWOhu3YBnP+Gv8inmpx6tXQTq5ETTrDtkhkfvaf57/SWe7pf6/TiiasoH/T/z56Fe
	 lZJPhmbYeV2b+VeluI5Sm3WuZDq8LMDwX4qmNp446pHpSIkJZCJmUVlaNHHRC+Rw7Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=91QgwEfxl8W1kdK4arIilG24I1a6A7OWOfpadQ42GFw=;
	b=UDncc8yRssnRgVizlUrmKRcA3TFgPpNRI9EwNR49OJNlLX3rnMuGQYa8io2gRS+mKsT1
	 AH0R67p6cjBhXRqjPKDZRDUQiIJnBvAKf7vAAxoTEiebADqFyt2pWANtkgL0Fa8mB6AN7
	 JssnwGKj36R4lPuiLkNT7NwjUCwwpbiK0rjMLHzEz11nGN9nKUtALq9E7llJK1R+a2hJf
	 cxHXYOgyBZb0G7ngrsezYJOgnwcYmhsZTrCOFEZfj7g2Oc4wl/MnWoaUKhihAXm/FNoY7
	 cpNIarpj3rkEPZ0e3WP+8PRzAyefKoqz8wEM38jmpCL0fmlBaIREId95bcXwczyRjww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f2OeKI/m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20E60A6F47
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2OeKI/m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE031F0093A;
	Tue,  3 Nov 2026 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723978;
	bh=91QgwEfxl8W1kdK4arIilG24I1a6A7OWOfpadQ42GFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2OeKI/m4nggdcp50FvYvUnqeH5S+COAMRn5+bQ2Kop3fxVOf9K7Ee8cfcXHbx8P2
	 k6wYspqC8zed+tTkdqI4BbrnWd+/WfkCDQuWpCa4NNNkQqOlbWH+SMelLqpwNCGor0
	 HFN0F/XeTb8NnkEKDmxNGIZ6ftw5XcNW7IjoN3ItIsImn37IbAk2PsqRHvolxJQwxy
	 D3ZH/XBmr7u2tCU8dWEVH0JtMMCYeUVMoVyjwJcpyK7U7Bt2cJlqSunDSysxLBHvXX
	 eRxTQ0z6kFICvGTXvYpXBcUPHjW0cNIETa1N7yCtDGkFpmaK15dvTZFWOd7qPbLNVR
	 EVcFEjQqqGavA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: fix session reference leak on compounded SESSION_SETUP
Date: Tue,  3 Nov 2026 11:39:36 -0500
Message-ID: <20261103163910.472406-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110318-mountain-transpire-6844@gregkh>
References: <2026110318-mountain-transpire-6844@gregkh>
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
[ sashal: omitted the installed flag update for the absent early work->sess assignment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5f752434be3cf..ef851d5c605b4 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1707,6 +1707,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	struct smb2_sess_setup_req *req;
 	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess;
+	struct ksmbd_session *prev_sess = work->sess;
+	bool installed = false;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
 	int rc = 0;
@@ -1844,6 +1846,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		conn->binding = false;
 	}
 	work->sess = sess;
+	installed = true;
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
@@ -1997,6 +2000,14 @@ int smb2_sess_setup(struct ksmbd_work *work)
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

