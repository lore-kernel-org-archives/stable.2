Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634828;
	b=L1ryyPymteRV5xLp1OcwoyL5nbzGPY3MMsCXbRFX2DLHcUx0cJPMcOdjWb5TVoEITv30
	 VA4P4vhv7JjregIBIWHfoqcreGulZDTEQGRFYKbb99vBdAJlz6KnE97SNedlQsuMbVUni
	 t8bmN5xPQEmdtajEhF/EuXm71gWv7GckTQWCKlgnDGI8tVoPXpj9WooekoJxBsvdVmj2T
	 MCs4e2dNsfbkRukSEK3JpaVfDI0G5idv+peQVbaUiqz/EAhAeHxRYra3WZNbB8ABVKO6R
	 LgFUR06Z39XI18K3JU5jEVAVQ3KFevlQnlpMbdsx6JhaOSVqkWrc8m+vHExn9IJtPEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+AsYtzIZWPRPQPkhoWTikycpspuvcuhh5bEc2MHGRFY=;
	b=jhBTZI6t617pcxDdjFrYvJPkhKKe5XmRghHDoUkWFoSau61f4ihUU9bzU+68G3YL+KEm
	 x0TFOAMBN31pEV0IXedAQM9u/2Nzj4yS3i0BJXmL1tOuipiSDq7Nq4AQ1/w3wfks5GyXy
	 Mjs71y6axpls3jiBI/aBVt5nA4Xa4VteFq4QFaawUByoNQQM/kWm3g9gzOx//THlBOGua
	 D+kVvEdm3OmQG7pdPAj5MK0QHUUpVs2DjzAq4NcV4sTtMet8W76uK58CmazkL/fjA8qUz
	 1e7OHLGKq5cynVVkgh+V6MIT1W4BTBIumC3+OFk84jtW1SxuAGMC/QHOsdqYGbga0Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1hbXukh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E9606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1hbXukh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DBA1F000E1;
	Wed, 25 Nov 2026 19:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634827;
	bh=+AsYtzIZWPRPQPkhoWTikycpspuvcuhh5bEc2MHGRFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1hbXukh6vupakKOzG98TtAh74b7qFQxTm2K11JCv2pGBkFZn/2rg8EVTNRKeLLBE
	 VajOIBlP+exeaTVjGjLwvcTqpwnMwI8HRxmncNcWjMjGwqwr0XlergcNK3bMT38jJW
	 IFEvdZhdj+7QdcJ5EQFCUEgh7tfUekflphhbUmB4LYLz0nn65SsBlq6MJLYftR4Aqp
	 G608iV8XH9RvdXbxgxzJKO/qGPLHZ7/CC8W3NCMqjlEpLqfw7nO/FsHfBKwO2rXuVB
	 H2Q5Ud+QNUovUC7UJK9UFbMD7gWgRgI/llGAUJQrkkYF13dBsco/smN61ljgjF52/q
	 zuD7HAf9AOFgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wahid Khan <wahidzk0091@gmail.com>,
	Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: refuse to read a handle that is not open for reading
Date: Wed, 25 Nov 2026 14:27:04 -0500
Message-ID: <20261125192629.1245649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-gambling-extended-40d8@gregkh>
References: <2026112525-gambling-extended-40d8@gregkh>
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
[ sashal: adjusted context: the new FMODE_READ check is inserted before this tree's if (!work->tcon->posix_extensions) { line instead of upstream's if (!fp->is_posix_ctxt) {. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 9aee0214e8fdc..732cb489efd90 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
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

