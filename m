Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741855;
	b=Y+0vmdw0NvGntoNQL8sOAtbpQhwfBVeCjJnhLsqSGdV1GXkjpjsfUnVjxLTncPELVG0I
	 wt88lQvUFP12BEsgmp1VRn8rXeDELTlTGqs2axl2dhReSaONBo8Xr3PdptSt02wFNP2QG
	 4Y7BItfjB3eWU4q+rKAg2AMC/yw1RcJtTFMFM90Be13fIkJPz+aK+657JeYDp4vNeRh6W
	 a6Ezeuo9kLhEaDFgH89+AO6jFZOE4O5loc3ZUTdvCkk/RuTODM1WHRBQs62Qbumq+cfDn
	 KOHcWfJdcLDI4UHOIRbAoqc0f2GV7JC5IhZlnpRvNynrF1pegUEJV1J4eG4ox/sHiFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JyKMTorrRQEgUYdDc2Tgy7G9i1HBpVsCja7LD/xzdNk=;
	b=Ht0UrHiyp1nS1gLm7CJbg2h1bn3UexP/TEmqREMw9PCfdMT8fSMBSSfEKhzMwLznYPB8
	 h4zxAGi97eoUQS0sjzEpV0IykIWeKQFWhxs0p/vRoCUQNne9keH4EAdN3niRFwavBBOa1
	 ykWCY9QUcogHz/sBwcLcGRxv6CDWwHgsqlYv7tVkPXjkfgkYfBuoeYHAMF0CG6TFo2HCh
	 YwVZ/79ELWhg+bbqemaqaY3DpOuMbKbFe01jQipoJyJWg/C00nzY5MzBGHFoDmQWSNdxP
	 6Xu9J6wncNntEhijQr/7wvkKC4MuQ2tRdebVpsJPUNghEfX1A+tjvLfRkqXdjTGuq+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9+VGhrH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BC606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9+VGhrH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431AB1F00919;
	Tue,  3 Nov 2026 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741854;
	bh=JyKMTorrRQEgUYdDc2Tgy7G9i1HBpVsCja7LD/xzdNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9+VGhrH0s9Dp0jdkl+lpfcICLrNkn+S+opj626RNvQrCjnnH5bR+bldoOV876vrt
	 h2wvCwAbvJu7Z8JQdMidEf2KcqC4R3h3nmRHN1Mpa38NpMqPoNQHCZkubN6s8QA7S6
	 WGZNKjY9BwqTWQAx7Z/znzesYcPHQ/G9EDXjS8t1iESP4+64H4nxEi+PWATlb8NHKX
	 e0Pljx5LDY/OiahvaKPj3F6MM+HNe/j2hTH/Ro9f3OWjNpmuObs2EygNjSJ1nqs71R
	 MyVx/eT05zvLexh/ihAQ/7vSOlWfFW0xB0+fuGKstninrEICkkZ13puPxSIMXhAvhL
	 L18ILvsbXY3dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: fix session reference leak on compounded SESSION_SETUP
Date: Tue,  3 Nov 2026 16:37:32 -0500
Message-ID: <20261103213658.1422951-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110320-denture-coke-1c72@gregkh>
References: <2026110320-denture-coke-1c72@gregkh>
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
[ sashal: omitted the installed flag update for the missing session-binding signature-check block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8d2f5e4e9ae3b..3e7e5e30533b6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1714,6 +1714,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	struct smb2_sess_setup_req *req;
 	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess;
+	struct ksmbd_session *prev_sess = work->sess;
+	bool installed = false;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
 	int rc = 0;
@@ -1836,6 +1838,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		conn->binding = false;
 	}
 	work->sess = sess;
+	installed = true;
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
@@ -1989,6 +1992,14 @@ int smb2_sess_setup(struct ksmbd_work *work)
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

