Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634539;
	b=ih7gPH6CxH0/md5JOSNLVjEHuQh7uKKlNP7+ClkXGc/Y7aQ3Mwqvfanc6K2pc6FRo+y+
	 K81DY90sRI0DsGYw+gZQrnUXFR6oWfW8PZ2KmM6OrRJjkA++5ViL1KB+JBNUQle4MeX0V
	 xSbjo3hsmUqGcEnYJ33eNKiEz81TCxW31lU/K118th73wmq/aG8VIOsAkzLzOEvgmHwtB
	 cv0FviFWbytEcz0B60941lI5i8lptbQrxMKM6wstgqubrs0P73wcnQ6Jhg/dlZ9vOjDRK
	 HU9QCVv6iPPptzVvn+v5UfuJL+rmDe08Z2HH+WA/aof6xOOSGFiSjv3DAGENg07htug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7l4ZjiI/MoN6eDjqLU+jITR0hfC99v7I2pyk5N4/dbs=;
	b=qP94KfvFkGvhaMKmkMlc6grZe4z38v/e3CgBWcQLNsS31vf5VCImUxTTcelyANTZGIWF
	 aiFuE8XQ0rAKGTDEGUkCcu9w3XVruSgrYQ4bjeUH8q7Y4tGswl27bkyhA1MMvJ7eZd7EY
	 UAHmCWqkl9p7q73vzrAywLnH9R7Y4Fgb+3Ltm0tpao75wmEVpwcuvfGXNcbnt4nc2C5qH
	 TpumiAnsXypG5TKDrmWZPv8cgem8TixVIIcO/tv8KqlRODc+5uczT+M4zdbCOdAkJrtH6
	 IJVooHWxGRrQuGeDxxfNqCSI+REpx7i6LYYiLKsD1dWJJ8em0yhkDOTL6vS1y1nhevg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQWl92J4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9A606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQWl92J4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2803E1F000CF;
	Wed, 25 Nov 2026 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634538;
	bh=7l4ZjiI/MoN6eDjqLU+jITR0hfC99v7I2pyk5N4/dbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQWl92J4HZcfbTETVThaS2c+n2tSiQsyDInSml50KIJ9PQbMWgle1i7COVwCDjyuO
	 I9O6NBR4VNMGEa99kcmfwFoGGRhqTSKclwmI43j65hKiLwOK4cio4RUTQkWrTzqpdR
	 42SItb0dfvxM6TjmFBZWGlrCvfyApCgbm9p7Yjqm0Nwhas5BCNLFAeqcCVE1mcLqzS
	 FMuok9ssH0WtUgUGVxyAeYKCKabtOgy+OrAHY7jKHfzbahtAT8MQ/2ZbK8Kffauz4J
	 Qj4aOwlm8/LmqxBlq2G9ImyCF4Tm098nn1rw1nWmRHoVHTnwaf5lVW8R/WVi9BDG3u
	 gdXTswPecB4VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wahid Khan <wahidzk0091@gmail.com>,
	Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ksmbd: refuse to read a handle that is not open for reading
Date: Wed, 25 Nov 2026 14:22:15 -0500
Message-ID: <20261125192205.1231082-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125192205.1231082-1-sashal@kernel.org>
References: <2026112525-parole-barometer-3f2f@gregkh>
 <20261125192205.1231082-1-sashal@kernel.org>
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
index 1c3dd8a416182..17d39149c2067 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -393,6 +393,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
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

