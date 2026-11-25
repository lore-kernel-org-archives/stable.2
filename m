Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635626;
	b=pGQpAoBVACys4V1fNov78v/YMagMMu+SYvZfiWPKxxxtgitvmQbl673wiSfsCJbWpLMF
	 rsoYfvk6AXNuOuZ2PxDCkC0SxWcyf2lT2LskGdaj1vOdI0a5XbdV3m/GroZliy8JmWnG0
	 vDSZzrZecco53BkEtw3bXnPfDDyLhp8ElkMZSfU2Qo7aXQWosL7YHfAU2cOeihg0MBLu+
	 NPZH4KwHPjNWZcm8LFQdLGuhtPddZMI3oocBWRNWzf6TDwzM9quMl2D2q+uJZZmnWlIYi
	 q8CN1vphs1GCAsdrL5z8J4gbdC9lwOzEZ1pCIcfjs80m7o+KD6gBcOzfcRhFoz/3T8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fkoQublCTV+s5K89cS7hF2NvF3oSNnHszSS91rpmGn0=;
	b=e4fHp+rRLz5yWeL9osaCuf5X3m9UNmzb4Ne2Li+LwRWpgOPHZ85LbKDnLgkiE9sserPt
	 i9ShBk6sQ0lg4CNjejfGBBISATCbm2Riv5BXTCM8fOVj68Ym14Kif/YuyNmbqfJ6uHw7t
	 MDL9VbALBTxMJeeTvqFqlKzVsQ1Azp2C5i6GyDHAfZrSzvPVJETAuebWK8A6ogMjZ6nI8
	 GS4K1vDlYM7M2umm0k5/12RJB+ZHFyQTdmOzKcXX7gyjRlplVcvXqlCwNdb74mvWg+Tmu
	 yIPFgT8k0Dg5GJYPuccVf4s2KwhlBq9hF1K6gcIWZku6Po56+v2YYIUQISFBKO8YX2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cM9Mlkm8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E18606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cM9Mlkm8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8840F1F000D3;
	Wed, 25 Nov 2026 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795635626;
	bh=fkoQublCTV+s5K89cS7hF2NvF3oSNnHszSS91rpmGn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cM9Mlkm8TWoN4ZYZ5WBKWZcJe03hZCXx8nDxPlWmYOdIiL7VhjKiu3zun77F5idqS
	 DRESqlhdvR4F8EO/5OxGR3dCObZYX+WkyYXWcfZYuNtKy4Yqg4BJbAy4/D2/Zcqbaq
	 pmHEFjaukytBDsmNPOvwX4/jWvACEjZLYStoSKlqbRudTWmHhZyPPj5raoVrwMn9Fd
	 q6DrcvRPSrM/RzK52jx0Zo4phUT5zUPo0C8jCEAQF7KvBaZef63P8cUaqCti1Vf8Ws
	 bp0Q7fMofqgIUrei9HTAeaBvkHzVFYU0i8T/I/yxspx8DtLu0dCSPggeR/qlwAtnqR
	 ON8ygNvmmLciA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wahid Khan <wahidzk0091@gmail.com>,
	Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: refuse to read a handle that is not open for reading
Date: Wed, 25 Nov 2026 14:40:23 -0500
Message-ID: <20261125194003.1284705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112526-surviving-carpool-9331@gregkh>
References: <2026112526-surviving-carpool-9331@gregkh>
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

From: Wahid Khan <wahidzk0091@gmail.com>

[ Upstream commit 2fd145f8865bb1a6c38a3dc68fa44290008789d8 ]

smb2_create_open_flags() picks the open mode from the read and write
bits of the desired access. FILE_EXECUTE and FILE_READ_ATTRIBUTES select
neither, so a request for FILE_WRITE_DATA | FILE_EXECUTE |
FILE_READ_ATTRIBUTES opens the file O_WRONLY.

smb2_read() accepts FILE_READ_ATTRIBUTES and ksmbd_vfs_read() accepts
FILE_EXECUTE, so a later READ on that handle passes both checks and
reaches __kernel_read() on a file that has no FMODE_READ:

  WARNING: fs/read_write.c:518 at __kernel_read
   __kernel_read
   ksmbd_vfs_read
   smb2_read
   handle_ksmbd_work

Any client that can open a file with write access on a share, including
a guest session, can trigger it; with panic_on_warn it takes the machine
down.

Return STATUS_ACCESS_DENIED when the file is not readable.

Fixes: f44158485826 ("cifsd: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
Reviewed-by: Ian Bridges <icb@fastmail.org>
Tested-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Added the FMODE_READ check before the tree's existing posix_extensions line, since the context line differs (work->tcon->posix_extensions instead of fp->is_posix_ctxt). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 1e087ae68e239..cb38c011c3f67 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -390,6 +390,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 	if (ksmbd_stream_fd(fp))
 		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
 
+	/* The access granted on open can include FILE_EXECUTE for a write-only file */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EACCES;
+
 	if (!work->tcon->posix_extensions) {
 		int ret;
 
-- 
2.53.0

