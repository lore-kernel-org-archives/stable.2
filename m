Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509474;
	b=nMAGR/0G8P9n3dziC4f1pmWCJb0qVLT4ewNojLW8jZ2oN8uZ5Yk6khWO1k2Zep1NELzu
	 Xu+oISWVJ8NTxabu0NqKSaXWNEgMVpHHBDQjXMOjf3JKUp/tFApX2Mgoy6bteUVjDsL3Y
	 YvF609jfFoOnXtSZ0ItiOMeHY8iCWyWY7eu03ALJ75mc1WYrhSszz2A4PRIsjECMFjJOD
	 8WA5DGgiZagmb7iD5oTS0v3aqlS2snuHlT/qN6+IUwCQBUPg22XA/a2yG5R0ovmO27sOq
	 y8t02RMYHu7qrZeE7ffLtyd6chZMmP+wJkxVbht9tTV0CaokCU9qG3AHF64dF88YFXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gFSI+HHYT4seNa8BU1xKJtAjCfEadHjjO87I98TwLD4=;
	b=2DCZ2G4Ly98QG+BjMyIYTh893T+/89/wrsjXyGq30Erlvg6OIm++Ve1dZbt8uTd21Gb0
	 cxfEtQmc477docpp1fbwz7Knph/3dvKIHIUQ74tj3+sC9UAILp6W/aZ+XH/ACrOHa72rz
	 qDhmGJIzK5Hy5C9ggP0OWf6o1Rn35FJ5NR7e4p3zJsTqVYixWaUMBVjW++N1WYQqQ/O9N
	 OheLBoDYqEWLf3V3Ne6Q7Dh4fmCeLhK1QCQJOrHhvzG0TWJVzGEpB73OPG+DYDEIf0IqL
	 uRUTnxXAYFcNk7JCW1o8oBzhsqHXVs8kXBcg3oAIRZbpkY76+9mbaD3da6IjEn89zOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qGxwyCqo;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E660A261D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581E660A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qGxwyCqo
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so652655ad.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509473; x=1795114273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFSI+HHYT4seNa8BU1xKJtAjCfEadHjjO87I98TwLD4=;
        b=qGxwyCqod/rexmsG9ZsOYcnBQFKqr5u+tQrTqRJDpclqKc0CTeDOjoWjisWvRO1o90
         mMvxdQ6y99AnMT/jEkLgWrm2SLatXYb8/Di9++wMqyJTl9JBFwSurP1QvxXMFX5xBYnI
         bYPaHXa8aRuXEOvar1OOCt7OIeJqrc8zwkQgT51cRYGrbQMux66VLAcpxrg6SDUAfAHn
         uGMeUjQAqvx7WG9MqK6MI9Ua4grYSKr9XmGAPSFxUdIzgw7rJf5klXW2d23P4B0wEth5
         vsmKzsBANTXwvSnX5Ft5No7JEffewoaUmvLbHtE6dfQzcPjNCf4pVRWcIGNtbQCPDXvV
         U3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509473; x=1795114273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gFSI+HHYT4seNa8BU1xKJtAjCfEadHjjO87I98TwLD4=;
        b=IJnxcVjkEhTml6kzk6BRSyjjWvnCBk/dWBsGP46KitNo0xV2t2Adw/z9HmqMeHMm4I
         g+ACwT8xv4c41JhQSMWCVPe8C05gQyH7HD2W7vCy7ivQWAwtvjxZ8unLGSRq82jUtBj2
         eyv/f8F1dfStNLIp4DxkJscBBzB3/d7lszb1W8p2uNoqy52iuvZZ9/CDG88U8cz9+GaX
         zVFUgmPZWapj/bhzW9/JJCd8gECku9j0hIpqO9cLK5QPJ1jZUtRgTjTrorEOfb/zNtLM
         flfiLKm/Kz83QdhkDNca5SebZdXkM6E0MfW8rpFVptW35Jzc5iRct9kS9IWmpZr2LmzU
         rkRg==
X-Forwarded-Encrypted: i=1; AL+hErGMegZFcR3jWIS4Su1mNLCZSmhmHt22bywv199bAO/zNaeGEcDbb9DSaiz4je2FxvgLob91ZZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z92pu8HUjeWCSLP9NXlK0E0IFq/DSfPRngVvITRTvqyCbAlEzFF
	NqnCRnETrPlVQPnfYTkRXTb/85mDO/m2IxXPVV+D6EuezaP8Ia0wAdi9
X-Gm-Gg: AYBFou15syaI9s6AooalNY8YdYNPbPwnjUvRkRz0NF9AwUfLE0cfwiGx2rXku/l1IbB
	InAfwhMIHJbTvRYYwY2Ro1hZJfabDbndrRAHzTrtNXSJCv387OnkxGq0EthWg0WTrTt6qoBISvL
	bS7SJOrqDSlWkxqY729DAeS7QTvuSLEc9Q55SLI9vCUk6s1TsvhJhzrZ7w9U3s12ltd+d/bMXEm
	Eh/GgTPzufmMFbsPkIXHPHwA3h/z+yAOcJ6AcAhq9BxGbdbh7JRPs5j0cpzNcB46pK2TUfQ6O4N
	/ypF9+bW0fqTETv7buGkUd9WVau5syFeAy1TLoPS+5ObZBDG1/AYobj79r2hEqJk0abtjEhWtq8
	oO4aXhs23bYTvKhSdxng8QFsMktvNJL75A3L8wqp4rC/0kItgeB0kF3stCEAa+LqnL8fzwWN0pj
	7Mq9iGchrcu4tWNcj1hEb1Jgz941m32CKAURmaMiog65lHmoNNwR7mYd0oaoyUcpVoLZJ7Iom+5
	FO82GGFQB0LIrlKw/CwVVtxOXFEFNPc5GDqZ9R8tfsvEaWz8G2nUfdPbbFLy1gmWTvOR68jzGXj
	ig5s87uHBAcHUY602X99XGyrMlXTBpcfc41M+jyUf9ifdToUT6zYCnq0sU1CCU9q+J8T1QR+RF0
	+RPlcNLBuDelX63KIro/RdfNPj4jDqcEcfSw/6byHbo/y5vo=
X-Received: by 2002:a17:903:3887:b0:2ed:2810:7cc5 with SMTP id d9443c01a7336-2ee0dcc6d2emr2280895ad.56.1794509473534;
        Thu, 12 Nov 2026 10:51:13 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:cbb:dbe2:bd9d:a035])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7cf7bbsm66205ad.29.2026.11.12.10.51.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 10:51:12 -0800 (PST)
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
Subject: [PATCH v7 4/8] ksmbd: refuse a binding request on a connection that is already a channel
Date: Fri, 13 Nov 2026 01:50:40 +0700
Message-ID: <20261112185044.41571-5-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112185044.41571-1-mike.michalo@gmail.com>
References: <20261112185044.41571-1-mike.michalo@gmail.com>
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
index c6e6cf60b1afa..7790aa618fcbb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2765,7 +2765,9 @@ int smb2_sess_setup(struct ksmbd_work *work)
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

