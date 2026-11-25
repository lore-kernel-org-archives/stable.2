Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635184;
	b=K6PRo6WM4pl9PyPB0/FlXgdIuRvR/Uyvx134042NW61W5wwtjkKYJ95q5n/4Vchp0G2v
	 cEaq4xaBJbSMb1iy1LWVHrEr+lQGglR0ryFBeu8gaBz0qpZTW+av94jCSPw0MQkQcWE0n
	 HuVerXV9ig54Xzzb2CVG6afYlC3+bQmSaKY99QAiY3QiWTGDtfP524dlrMOnr/ZLfzf50
	 sY0JY8vK6VjeHpLKRGuyYREt77e/nE45tDaZrsNhY1q37lQPgE6OiHUu3KqOcwmwHWkaD
	 TGnYUgJE1TMlq+qETwlSPE3p/TZu43NM9UI7Bqcw9/Re3wISRL77PDJ8WmQ7DTRuB+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KzL+4eiYS/8oN/bVX7ATAQtSmTANHQcSDqhK96FP8Zc=;
	b=vQpB7GLSNeVseF1DWZGzjxtWi6+mvc+QiskvLluvRnFZciNKmD1kqlzt8ZcCkOztmAfJ
	 d/Mj1R27r1re+3HxRXzJSNSrURKs1SpMy/Rh6dNfZBCxIl4KlHGFyxxHkiZXSioVe8hs7
	 JETA3arWZx3+TQjR7QsSRrHGfhHdHr0eztRcUwERh9cw44Q8x8eTj884KnSSN4YeAbenP
	 C1LDX+S+tzGvTl/jiv6mZn9JWnF0G192EjTxiOL3ywin267K7yilow89GvWj/sN+FOmrj
	 xRebGeJ985HpWIMVtLUR8ZV2Ywqp/ycZdjAgEJJ55/AZGFaAgXdHwoty35vNuVlt2yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh6KwP8E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E51606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh6KwP8E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F027B1F000C4;
	Wed, 25 Nov 2026 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795635183;
	bh=KzL+4eiYS/8oN/bVX7ATAQtSmTANHQcSDqhK96FP8Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jh6KwP8ERF2bkSfxGPOGGklf/hHIgzTb1SJ4yQHjIoM7AB4/LIykGaoV97HjUM7lz
	 TteOBWZF0nd5UwX0tHKMNXhCRAKzwKxDCE4E5aH7Aszaq2zJfFtbMWAG5qVXRY6hbw
	 nhUQZdFCgwULWGLe38SGT8lxzEpd1GFdPtS3NJMCXoAPKVaQszQuCxEa8KOg6szj43
	 4z37qSvGIa497s4uZe/tMxJBnOT6qvGAw12PTVN0JyibVmVTlz2A1ZYbfsD/l96UUd
	 QPviL0Ug/ba93G9LtmHc8jK+TbNFSYc+mrD+sFWGIiFjU0Az2UDklyRd/n916CCRzD
	 YjOY49ZE0ulfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wahid Khan <wahidzk0091@gmail.com>,
	Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: refuse to read a handle that is not open for reading
Date: Wed, 25 Nov 2026 14:33:01 -0500
Message-ID: <20261125193222.1266068-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-paprika-cricket-1873@gregkh>
References: <2026112525-paprika-cricket-1873@gregkh>
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
[ sashal: Replaced the fp->is_posix_ctxt check with work->tcon->posix_extensions to match this tree's context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 54bd3e7012d7b..64178954a54db 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -391,6 +391,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
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

