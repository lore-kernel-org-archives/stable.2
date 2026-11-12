Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458836;
	b=c6NYajIwP6Ejlmo8Dj96RQ9NwoX8g2n9uDdiTt8Cv+yIMG/I4db8C3wmAl73IiZ+MGL1
	 bH6JG/sFtgVSSuQtGujhSc0AKA+f4cPJpijxCQGqDEqkpX7/dinR9+xkAk9qyonUGo+og
	 OsI/vZSGLlFBzupqSKgthW9QTs8om4TVWWNq5Snonf9SGYH8CPg6BXNiytXyMqM5eEyZc
	 g7tTCXTPIPklxCICJRv/h3yqWC/f574DRzPP7VsGWQmJJlEyvZhGRM0PCmbJ6EcKt7eVi
	 xhO66UL+Qnkz/xskExu+//hix3zOiq8VRKaD7uWl3Zh5BW38Y5tnLVomxqom/JaXc8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WdHqz9JYcfNaHiavdCpKMF9dVXTFBJuVfJ5Q3LygRzA=;
	b=MQxm4mEojR0WOdBA+x7I6JmF+dUkTEN/4Cg5zL1xD4ph+yqn8/S5TwjfFr6ZDkTjpDcL
	 xn2ayx9S/5vYCrPkuZNiftKDGi60MKYLqW8GT0CgVVpFLMErB8emWoCQmdwh489R5a9sY
	 bd/licseNBYAB8RCODkWxWEBGYq37bYJU9Iy2AMeNJ6jTj2c1Q/Lt4iMG3EZWxI3z9LmF
	 K+oqz6fsTt/9n6Qd5oytIR1MLzdu6LscmYtFOfcZ46xdO5Cq3RFHqfOuixuwSQFQ4yFB1
	 jK/Cni7DHNv6PLr4qVGPGhItEvcBWdhBDEFYVHS9dgoyOAfQVa92HaEv3rYffRjez8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnsALIc7;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316A606A89A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7316A606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnsALIc7
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37628596783so3644616eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458836; x=1795063636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WdHqz9JYcfNaHiavdCpKMF9dVXTFBJuVfJ5Q3LygRzA=;
        b=WnsALIc7uEHaLv/PaKieu8CMijvWhaitGQ2AgB5sBvfanVDHj4xdf43QgjfchJzE+I
         2JJTDh1bIDM3gJjTjJxead0gcZcAVdqF8NyauXiS/qWVXYPD//llfdxfd203vFtSD2D4
         Ezojii0AhCYD01c3lteiuUgJejOF3hG0OFRfA1xi2REm6NASrAtY/13WOorO05N9X5bJ
         X4ASlM0ylb5jsbZmPtRcE83ws7eI7ETSkNX8YdjnZyWf9hXqVePll4FiiwCeMnSnAKsL
         yqGyHFFWsvheQeqhwkuYkJbtxckTBy2HlLvZaPR0rTpj/+JrNJA8kPRTrzcsaMb+RlIu
         QyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458836; x=1795063636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WdHqz9JYcfNaHiavdCpKMF9dVXTFBJuVfJ5Q3LygRzA=;
        b=ZR4J5NhrN8O/AFHasCE9eXZ98smkFqGdE2vp2Dg72Y7F0TsTOSPf3zBW7Q2rFBClO0
         YxvsSIUMV3V2d1TcUDl8tHJfJgyWiadXKZD8SwKR3hlujVSxH9GpAfToMdvkGs1/BfDY
         4Z8S0w1pFqF9YIm8IdcX9oz44Iiub27BUBdYgN1T3JJgW2FIDH3Vu03ikVBzwKRWlYKW
         cdb8jdvwi4q2CxlFWLlUpsol58yN8MSKGYr92K+zsa7a7hu0ULOr7lTF9XmTVJylXMxz
         Jcm/f/U2WKLkLWhFdCN6h5wE/r7BxZQxVVncNjy1Z+GrERkdxJ2UYbyLQwo6Ddx/bn/W
         scLg==
X-Forwarded-Encrypted: i=1; AL+hErHQeRssKjf+4EdZ3WJKl/1ptcw/oGT1lydfqYuV+Bj6iY5YmTmE/m57OWIofZCaIvyaiDvnYK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xN3zmscJzLPJGRkfR4kdysNQ2ehOs+MsaKPgE9I+DmR2hfg6L
	h5nQuGRVgChuva7afqhYoEZwxC9oUmwqJEv6yvmlSGoUi9jpSg5q8/Po
X-Gm-Gg: AYBFou0M4mgxtN+vXVZtihn69r2/wpneW7IIc4fUmJtDiA6HtZMNIp5R0tpYiQu+Xgc
	4UvsQJDQ2GLuH9vh/evtJv21+Wqb4/HhDcyIWsD/jTPJInKcl+7uP2EURPW8HSscKzxXmOiFzbX
	U7Z20aBPgyi9PiWOPwKL+kqizlyj8vvBPcNa25sLDKzWtfu2wGB0j3l7r3Qy3Vjg+wEnR+OR6d6
	5kljmDrvuG/mGW0YUpdh/vXj2w4R2I3DcpIj6u4ZsgLrTmd1fUbZAv3AI4qKriaP3XGX4PnA7Hp
	4AWwopcJGX+Skm2a5jkitHA4GFGdvnQq4Xg28TyR5gwevlzb6xvTTgaeJzsJgWJPgJI0+TrVRQF
	Ay0k+GhwuuF916VJrEXY70YQzmIeve6Vv7HUvUHXRHlK48XjWcF29Q7Mn64pdHYRG1MPXlYT/Vt
	JfJKTun83n22ZjfcbEAaSjYjj28iAye+cByycEcR2ZhkDZvuBlsJlGqDEOntZ5vnfmOMeWMTZeV
	fm1Ut0lAiXRuyH5sD9dmyetbyjMMqI4MqCMIp8syTrTfPHiFHk1dX6wVDjUjslF5y9hhkYbyT3N
	BU8XhCagQVAj2My7141B7i1NqU4XNwJ/ehoyyBbSWfXUaNq/x/UKLuW7QEwdp25NupIfKPolLGD
	q/+HlaTxDk17aN42eIOaPbd8R
X-Received: by 2002:a05:7022:1409:b0:1b3:a89c:c456 with SMTP id a92af1059eb24-1b3c024a7e9mr3414920c88.6.1794458835535;
        Wed, 11 Nov 2026 20:47:15 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:5d51:6f:e2db:335d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm21024827c88.12.2026.11.11.20.47.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:47:15 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: linkinjeon@kernel.org,
	stfrench@microsoft.com
Cc: icb@fastmail.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	ematsumiya@suse.de,
	lsahlber@redhat.com,
	hyc.lee@gmail.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 4/8] ksmbd: refuse a binding request on a connection that is already a channel
Date: Thu, 12 Nov 2026 11:46:41 +0700
Message-ID: <20261112044645.4074-5-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112044645.4074-1-mike.michalo@gmail.com>
References: <20261112044645.4074-1-mike.michalo@gmail.com>
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

smb2_sess_setup() refuses a binding request for a session that the
connection already uses, but is_ksmbd_session_in_connection() only
knows the sessions created on the connection, not the ones it was bound
to as a channel. A connection that is already a channel of a session
can therefore bind to it again. The new binding legs are verified and
signed with the session key at that connection's MessageIds, and on
completion generate_signingkey() replaces the channel's signing key,
while register_session_channel() keeps the old channel entry.

Refuse such a request with STATUS_REQUEST_NOT_ACCEPTED, as MS-SMB2
3.3.5.5 does for a session that is already in Connection.SessionTable,
which a binding adds the session to (3.3.5.5.3).

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: f5a544e3bab7 ("ksmbd: add support for SMB3 multichannel")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/smb2pdu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7b07108a48c15..0271ee4753236 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2722,7 +2722,9 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
-		if (is_ksmbd_session_in_connection(conn, sess_id)) {
+		/* This connection must not already be using the session */
+		if (is_ksmbd_session_in_connection(conn, sess_id) ||
+		    lookup_chann_list(sess, conn)) {
 			rc = -EACCES;
 			goto out_err;
 		}
-- 
2.43.0

