Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634205;
	b=1HW49j1j5sLpkZXHNZ8UMdrAyx6fG+ZFTpR+osycEvAhAzKJEUS7CEXp6RYyR49J9IP5
	 8LSXWK+1eQptixlZ2VAye8//xxA/sXpCGkyr2eGmh3Z97uwFBLSjq7Me1HONE821miAte
	 y/BTkkGLeMh/wbLQsT+9hJBlH7f7XirKU6013IVA1lt44mGf++5Y+1ePd5bV7oL36QCZy
	 Sknkjwvs86i1f1l7rRt52LxuPhZHCzRnlzr0d7oKhdBzF2Et22efhp/FIJvi6QU17pG95
	 VW9FsJ9JRmQM5Z1kMUwQsPNczoXEKV2wJ1I8UT35tXVAU9b1vAUad+EnuQ1FQ00Tj9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1ux/FgjsT3I3Vu9v7sULt4clceUBxFuDxyfP7OkBtb0=;
	b=r+ZsPWIgzycmdoSxf/1HyplVssVv0MNwH85fZOQ450TkSaWzyw+Okqm3oppdN65r5DsT
	 wdfhKMfUbZYN2s5/ws0cbsYmGr6jXsMjmXyB1PHYSpWQ1JAmXUZXJp3L45ndNnj9BMJGV
	 2cHCoAaamt4pQZjUh1v1ysC7PdcV73MEUw0zPP4CduyvrASnCygvVZ4T53eDmKfGbgkAM
	 omzrUSlIqujyZautLkq8lKlXUv9SzyyaoOUzNSqbXxIbhHwgiznhmHxjpB8r0fnPBbOFH
	 ncI2nfyjQd78JJtuVbXOAxvmlrm8BzsiUX9HchLvXyzDACB5McZ+zIeEvEx13ot4XCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRy+Nltz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13BC606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRy+Nltz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F274E1F000D0;
	Wed, 25 Nov 2026 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634204;
	bh=1ux/FgjsT3I3Vu9v7sULt4clceUBxFuDxyfP7OkBtb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VRy+NltziWSAWZ5E+YetNWkthjdWuX78FQ7CT+kWplz9zyfKM9vr3PxbR+LApy2fk
	 46OXCcM6un2VD4IiY2wEgS62wk71nd+HYpQ+RUk41wiVNbFX4CelIUJd3meQpBxYw/
	 rNTm1dXcWsGUBvyXdy3h51YkzcX3/rJKtcHQVRbufd47/okRsw/9krz5BPQpC9rNyg
	 hGtTjoLucedRvEaZJ+q7m0AESXOH/ES4lrIVDclwn7siokpM3DUOaVcdckMBgwkQ8+
	 MOYPS+Ev/lGbsnVN1Y+bsj5M4j3l7N4GAhV1SjXnR2l2AmPZE5stwCvGklAEcBL9P+
	 7MUXl/M02tBIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wahid Khan <wahidzk0091@gmail.com>,
	Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ksmbd: refuse to read a handle that is not open for reading
Date: Wed, 25 Nov 2026 14:16:41 -0500
Message-ID: <20261125191635.1197631-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125191635.1197631-1-sashal@kernel.org>
References: <2026112524-enamel-landslide-2197@gregkh>
 <20261125191635.1197631-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index f9e4752b5bf2d..98adb812f8714 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -366,6 +366,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 	if (ksmbd_stream_fd(fp))
 		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
 
+	/* The access granted on open can include FILE_EXECUTE for a write-only file */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EACCES;
+
 	if (!fp->is_posix_ctxt) {
 		int ret;
 
-- 
2.53.0

