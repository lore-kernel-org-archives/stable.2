Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498145;
	b=C3IYK9RsyQp2YpZkk2lbEzrpNjz1TWsHKSUKnGJUO5YEICplnwT/z79zm2zp4a4HrQls
	 oemOMqFh4M0Bar8C4PO28LA8fpGPJxJreIeYe1HVXQOAegd+WGbyhFZO1n0+R+aEhJKDQ
	 i57MydOuNkhn8hq/kiIe+yBAFknGL84Use7E8zoyhcQ9zRoC4trD7NOtwouFep2v06YEN
	 8Rvnzx7RejhOT6USTsgUR580gdqqcbWDGTS6NwN6g4riw4mFQhBsbLMAvRAzm+QXVXqF+
	 Yd+Eud1J66s3i85Dm7Itu9sL/3jQ1SAl3zCkHEBFF3xHDpk34x/1DNVFzD/eUC+a7CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qPdK+vh8/g3uS3dMRmESD66VYLEkQ0XCEscEZnuHhMY=;
	b=TVZ/lGes2gG8ej27xy2+OhxxbSaPLJqBtXdrABRaN0KSzYjtTzdwffIP3fKGVhyLcvUy
	 UwaoW7CE4q//yP43w3F9vwDssswMG1DNRSEwe9qO110pU2jHKn+viz4+T3Ja6XzUXwK5b
	 GSYBNF8G38xRh7SpjMlPm8rYJvJnrF3xK7jU31hEuh8xBj4MVUzP0PDzNwnFyX8C48CrW
	 m9lMN6e2OWuVNNElqHIKJl9kUimfXugdlerd7GVbV5MP9oCq9606fqQ7JOxxlc0N7f50W
	 7d2Ey3d515krK5CPbYcALSnFDFHCymA8I+0MA894S5NRchzeCUlOIJD+VxmbrEbIn0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNzXi57n;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A02606A331
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A02606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNzXi57n
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so3371392b3a.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498144; x=1795102944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPdK+vh8/g3uS3dMRmESD66VYLEkQ0XCEscEZnuHhMY=;
        b=UNzXi57nIEINpiLTnoJVLHkb3iSpvqvZxAH5zhOTFLYYq3JC2pBwTtCUqR8HLWWJl7
         dvWdgn8wrADdnYvaeFX/6i5X9sWXAY8dacQSJHpex7H2cPFJjHpqvyb162Z/U+flSnTM
         yI0nxbIsMix1Gdwd5Qgg91zBnzU0CsqOFM/glgCb+b3W5ftAKLobixe5X+rPKSDr8jPp
         UNz3vCCdBePGqrOih0FXIwxBvUWNTzJmSOngSzsivXe1+V1R0yO5dm+s24qtTCHIzPY8
         z5D287sbnTS/dZgPYoIlqyguRO95+dC+xkLVtW7x3xdRJg76TcqVosKokof0NIHRmWRk
         +QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498144; x=1795102944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPdK+vh8/g3uS3dMRmESD66VYLEkQ0XCEscEZnuHhMY=;
        b=OZAIV9WuVHxZnf2QWWJXOlz5aF27LNSbUKvMCoc1zo3cvOYn1XjDMb3A5wgdiTfnzu
         K60rmLABb8XGT7qpj2xVG3AZSWpIvxd/6PP15nEA7r/yqUNHY/529lI/pi1uKXhXHjhF
         TwBVDl9b6g/x0HhEgchevcGeqJzn7UggTPqCy9CD0KDUSEam23SjJnE5i/w9kx7iaDZS
         Z7iLvgsgtNR+FT541QZ6ZzwBathI1as4FOHqgbTFvhX79rw44A5NZGkHemF/vC+N+ULs
         aV4vDpi7Dba3id7xVz8HRBFKg67l68LVh6u+FD01nYcp6yOnAH/VOMuq/NDk3L8uUFo5
         N0Yg==
X-Forwarded-Encrypted: i=1; AL+hErGeav2A6FSOUC+cJNCJaZ1RhStSdMjVXcV0kchrkiot6xQ23eOHjU0KfM/m282eupk8vU/G630=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W/Hwsw8xXVnGx3lyOG/RXIXOI47N6O8mzqw7rwOWgoIfkKkn0
	LW+spxtqS2cH3Rz+mtkUppe0egRjqEpHwzo/RQXnEnvD2AhcOkrnzwyL
X-Gm-Gg: AYBFou2jRZ11sEbHqnMTOXFlCc+lQD0pl72U5LUwBzUUInI3bqkYz0X11J7N6Z7sony
	Yd9MnLe2VztVwfevL/shyKOnOK5njXra/GoOk1OJqLm6JWfsYS2Ozf4rm0EjzUPEdsLsCLNvyGW
	BGWmJGT2vp2nbeKjBX4t2QNev27sHYwCydTzfi50lPQh0DDG78ZnxwwQrFr/kyaQd/N+bWhLXcc
	K3nbbYZVHM6TlEAXQWs3Fr+FU9TWreKQ3p0VpGBu0HpAgbja6v6S0BbUEp8exDsy46aMMnuRGLj
	6GfWWnBA4ot24iaxe6Fx4oeEXcO2n1wyPGBGdo6y3MxHPr0fkNGR6Tel1UM3LUnOD3Pi7NRLOeC
	J5qgWUibTFCF/sIYHwE6nWuZpzcp4VCqwPOPoULQIStdM+tiGvxKqUmgJ1cn9O9ZTRqiir4eBPh
	UsKZzAfldLwm7AX0jA1FPA4rLQQ7X/TxMkEKcbl5IWLyIVNJh1guAwbZfuuhkM9OYHXkIUgZkkp
	VKau6h2BqKu8Cd/vUFdmiCnbAdrRa/BqAXHPDmKe91mfJOgJkAbFwsXjvqNL9ziSmFwvea4IwTr
	1mza6h3ttU7hg/VUERFLonCNR6fwIWc2vei3cbIWMvmO8s6h+aSd9XUDjY9CGxDKmoLrCzanXVR
	5v62PYKQ0zqIgKs12Nk6JZKkldY0=
X-Received: by 2002:a05:6a00:21ca:b0:89f:1b32:29a5 with SMTP id d2e1a72fcca58-8bc195038abmr5834051b3a.7.1794498144019;
        Thu, 12 Nov 2026 07:42:24 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:21c4:c32f:67c1:d87c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm3790596b3a.5.2026.11.12.07.42.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 07:42:23 -0800 (PST)
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
Subject: [PATCH v6 4/8] ksmbd: refuse a binding request on a connection that is already a channel
Date: Thu, 12 Nov 2026 22:41:51 +0700
Message-ID: <20261112154155.20255-5-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112154155.20255-1-mike.michalo@gmail.com>
References: <20261112154155.20255-1-mike.michalo@gmail.com>
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
index a15dd200645bb..186a497f83c62 100644
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

