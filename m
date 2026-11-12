Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458277;
	b=1C6E/ZaXbE4/xp2vojadEy1axFrCUKpfJhfr0PFfm8qa3OEY88v4GXptcZ2w4fqFx5zT
	 rX7bXR5hn6uSP6P1k7Ira6e66HJOWTJsJIT4wYmPKC7R4hQGfIbolJgh+fOVCg8QDpg9S
	 gTT0OMXch9jVwJqk6iidNKZLWtacA2S/ChVXE3lVKkP4I9F3cvU8suP9+6WvyfJFLgB4h
	 4K93xoJIXbKyOyj8WCO6TlnsUOULjcP/XJvJ9KViMP8vMJOVu/TNqXYmmJyqfqe/73G6b
	 IJAkrYGjubAo9L7g+dWm0YU+xopxFzKlmcMjeYdcolWsepWocRcaCpJ7WairHI16DAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2qhTXeXiZ+QajZ+Wj2AcBRgJY8BIBuV3Bnk1YKbzBOY=;
	b=XM8TxUHZS2lL2f/bGklmoCwmSoyWPAo9NDhyYyH8UOvhxbjQ7vBbt5B7JIyQmq07QFzr
	 SlgtrJ4Gw2r0Dl9mxITrAi2ik49ZPpitqFdN/g2+Avhr98qpbXvFpTMn8ArVUjf8CQCzQ
	 Aup+sY2Go026tD1Db4w4V/cWynZJQfJQGV1SthMe2tRbCTduB0peCUjjsts2H97w02RQr
	 LSsjR/laAQ+eZ3UCEazbA8xxdZz+xjauZY9EyBxAQiby9tmJRaw6YKqEUi66qIAKYl1Po
	 fH9HYmEiTC1rwRy4RsgXWtZQMkqpyd7BSSjfOmbJZF3O5kwdaVvjlwkPUFa50WPh3Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWBSLWR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E560A261C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWBSLWR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BF51F00A05;
	Thu, 12 Nov 2026 04:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458277;
	bh=2qhTXeXiZ+QajZ+Wj2AcBRgJY8BIBuV3Bnk1YKbzBOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FWBSLWR0OeYO+N6h7YTNtpP3pqGDmR/0D2Uih2g9NWMCRKxtBuqBh6ug+fdgD6IwI
	 TOiSbuD89EDBs3CzpBpqFsYNLAk+HYFnz3oQgjxxXTExbbvdKI1ES2HSKepTzrQLe/
	 UYyZuchtBXlx0hJXNud2wiGYK6vJ2jzBrCB8kD3YtlT0/pPcz1VAAFqwS8e4zamKil
	 +WtfbcIRpuxqHDqWjPpPFCPYMiuB9iqLPI0pWeQe3dI7aS4Ho+g3PX3YilXdR2bXnQ
	 T9/THmFTSs0K4mL8AvXNsPQzfSWaSxsEUdP3jmBWiZ5QqqJdKj0sApe0+1y2LB43it
	 coH800lqa/tFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: enforce the read-only share flag when creating a stream
Date: Wed, 11 Nov 2026 23:37:55 -0500
Message-ID: <20261112043728.1678574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201537-failed-6.1-09139429fab3@kernel.org>
References: <20261109201537-failed-6.1-09139429fab3@kernel.org>
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

[ Upstream commit 09139429fab3a5114c18d7c15fb161511d4d66c9 ]

When a share is read-only, smb2_open() rejects opens that would create
or truncate a file. Creating a named stream on an existing file with
streams_xattr sets neither O_CREAT nor O_TRUNC, so it passes this check,
and smb2_set_stream_name_xattr() then creates the stream. On a Time
Machine share, opening a missing AFP_AfpInfo stream also writes one. A
user who can write a file at the filesystem level can therefore add
streams to it through a read-only share.

Do not create a stream or synthesize AFP_AfpInfo when the share is not
writable. Existing streams still open normally, and a missing stream
opened with FILE_OPEN still returns STATUS_OBJECT_NAME_NOT_FOUND.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Fixes: eaff8e924f60 ("ksmbd: synthesize empty AFP_AfpInfo xattr on first probe")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Omitted the hunk for absent AFP_AfpInfo synthesis while retaining user_ns instead of idmap in the xattr call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 069ecc1d90b52..dec5da960af52 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2559,6 +2559,9 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
+	if (!test_tree_conn_flag(fp->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE))
+		return -EACCES;
+
 	rc = ksmbd_vfs_setxattr(user_ns, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
-- 
2.53.0

