Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735331;
	b=ZeJBd9J7FDh32xsLsjKg+esWFKTuXIcFeP7enVTmX8MacAZKJyjzARSlaa9ZVtcLCVS7
	 wm2pYPbFsVQFOFivk+htPXGIEPxdrYvkCsefSh1nxGnaVQ+vR+9TM7Rir82h+JWLiq9lm
	 DGfcCwGcCW4f27PRS3FF5ksPpYbmjvzA30QKsi3/9/FsaqmRB4jTAzjnhCcafZvM3fN27
	 qrCkSoKcOT1S2G9RyzDUfdinakvlLr03Awo8HnLgLSmF1IDFkrY/SUK7wAYYjHdA8dJTx
	 0Z5784J0iO5Ucubbhlih0oYMM0uk3YyC5QdMAK1CzGVI3chLa4NSqMjtn+xAKON6GqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735331;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3D0TYih/xNhzYQX0ufrt10mgOTflSGBSQRAJGqrBRSI=;
	b=cU5o/QH9aRg0ZXprN7gUc2+iMXJuXoQoZBVaCg7drudTfJ9NehBJU1V5MKl4L8+TrKSL
	 zO6+kRs45LSrJnn9AcuQCFgb79ijpwLd9PO7VH4ukWb09X4QtcBcM/bvMgdWTbz7Y2plc
	 2W+SVHPjX1Okg6jYK3UJDXj93f+8NdTrhyS+8C7gnuUlo0ddtTK2g1T7Dn1e0D35OqKro
	 x6NFL5gcmepuFtIbXkLdaGhjsXzp4BdQZ/faGfpcMpqaXzBuNs30NqosB/ekVVOc1Fwpb
	 DfXbslSQlkjLJRcEAtaZ9QbINUGgvNxwIIUGuNGQYqMPF7z6Xqy6h7mCr+9ftwctm+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMPYY2Lw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD6606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMPYY2Lw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37241F000C1;
	Tue,  3 Nov 2026 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735330;
	bh=3D0TYih/xNhzYQX0ufrt10mgOTflSGBSQRAJGqrBRSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TMPYY2LwGXCRxtXVIIVrXniFPFklxjLBBWWcLIr+K/XfHGr6Gkp3H5qweSSVMbZuJ
	 GwQElinLLD3ny07u7G5QIyBApI+FQgnFO6azTAvGd4yreKMqTt4iszUOOrdjT47AG9
	 3jwAtoQs6So30oaSljti9tmajdT+2Ip4uTxvG1D2PsCXIgI68RWdSOp8sK88h/eyo2
	 NH3l4PNXEabIgkkGsWJJv185Zla5aXAha6PZOsf5zoEK8vpF1GP97ofY1qXdhAXjGj
	 2Fy7dsoyWklz5YvUif0vwOlLUC6q2UgqGIHoQx/5GL8/5NwnRChXnxuLAWco1ZLED8
	 HHFmjGV9X8YFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: fix session reference leak on compounded SESSION_SETUP
Date: Tue,  3 Nov 2026 14:48:48 -0500
Message-ID: <20261103194745.642326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110319-itinerary-very-706a@gregkh>
References: <2026110319-itinerary-very-706a@gregkh>
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
[ sashal: omitted the installed flag update in the absent session binding signature check block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..8fa81c7278837 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1697,6 +1697,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
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
@@ -1972,6 +1975,14 @@ int smb2_sess_setup(struct ksmbd_work *work)
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

