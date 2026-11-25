Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635383;
	b=x1DhuzYtQId95VYrRV39Y7GsmEQYWB/0NDQ2125Z/sWXTgeiwTOcbOCov8XXl/Bq0Xlq
	 V+Pd6qxWskxDHMv+OJmU+lB+gDNWKXWUEskj2MCA48sndpddAG4tXWdbJIyJhzYLwLz/F
	 ajpzrsI8MHflhzqAXH3725vfWedZXPKZ2wR0NROQHRPorfbQiNVEQdPI1sHEmR5wNK7GV
	 YGNNqAP5xayzMYvkw8HQjtZWcqjpyjtPjoiMBexvNKcIOKK2UZrHfnqOsmt/U2T4j1hrN
	 3dP1bhTuHft33ZwEQMsNjtxAO5rfBt+mQrzvC4QwSgkvzlhhAKEk7gWBUw3UaPzrXgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d7097RO47fQNy2MB+ahoa9VjJXwIAUyj2/5v7GkBxhg=;
	b=LISIf2vo9GS326AcfxzpTdoDaa6+jFFjdi6wcL+GTXFZb+khiwX7YwqarX5gkiaSJn8k
	 1ccYohi3B7oNzQzHdH6ykDsRi5BSpyTL0+pwVk+z3pjsQYMsCwnJboVYUVAb9OfIxHUjU
	 zDqXzilXBlA+bNbnM6r/IXB8Fmp1w+9ptrPj4PgLZuyQqMGygjQYCSdvtuHM9tSRLtCZP
	 MXW8/DuVpi5BZvWoBOPljMIEUPCVcA7M7QngLABECFNKSoA5IWqTI79xjiS5aaTYhWFJp
	 1FV+oZrREuZCgKUxzMjmhaXX3jg2iJvALGojFb6LaWLwtfNJxw+zfGfrFTBHWrOeXPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MO8lBljK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02013606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MO8lBljK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17471F000C4;
	Wed, 25 Nov 2026 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795635382;
	bh=d7097RO47fQNy2MB+ahoa9VjJXwIAUyj2/5v7GkBxhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MO8lBljKskyJcYcD0oCXA39/M1J5Oc4ufFxb2vZxZOKWwboG8mE5gDvnTOPnJGQJQ
	 Ek8TrkjcHNsOlotw86V/a86fOnwXoZfK8e0vHa4Req2L3EDXi9OYt1uEr7VOolp5/4
	 xCHXGEXKJGstr6x1ATfWrbUtwSW0L3BpBMKxa2ZalNauisc3g578PHDWQ1jnEK70Mi
	 6fpz/han9H+MMTapBKXg4t7JZzUZT7tv8RsN2Pagx8Sa/BuM2AAhBSe14UQ35pn0+U
	 IwBKf29GKh78ezsOcC96rzXOaap46pK7ekKFvYT3BuhEysUWWHOfWkMFGdkab5Ijqx
	 rxZV+NbCET+Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wahid Khan <wahidzk0091@gmail.com>,
	Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: refuse to read a handle that is not open for reading
Date: Wed, 25 Nov 2026 14:36:20 -0500
Message-ID: <20261125193556.1280033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112526-cider-posing-d58d@gregkh>
References: <2026112526-cider-posing-d58d@gregkh>
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
[ sashal: Adapted the posix check to the older !work->tcon->posix_extensions condition instead of !fp->is_posix_ctxt. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 892ca634d1d66..1524454ef6de9 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -394,6 +394,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
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

