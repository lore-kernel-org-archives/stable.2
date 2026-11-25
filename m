Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634538;
	b=Rgyy8EnKk1SArPp4BMxrRwfrpdyfuKpOBaGYp1TGEB77Go7ilqymh6W34DB95uiPB3PV
	 7LIur+OSh/QzWkb2T5FbcmC2J5Pqo00K3besWtTlkFG1rvjl80PS/PN8zzMHQteRXulZS
	 eL+M5Z5bIrX9HH8bamguswZONEe9rkAHnGWVg1Pi4FBy0/XUx6bHLV9Bo0x89OB28/96+
	 QVOoN1o3pVJ4RmTG8C62+EW/o3Myy4adPaM+5xRCXa+6Xey1Smmv7S1zZEhVV/BuhR+H7
	 aWAul2KnKrEoM4jHF5dRc2K+A++R23N7Ja/y60RGryQz1DToIDj+kaUERl9HaUdR2Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634538;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8jFxxcacZMxF7VdX7l0lSumohqtCf4rAutrm5m04GRw=;
	b=GfnVRUAh25EGGVRDHvU72LQgmMmhZQcNR2OXzltc71veU8UIoCGMXKRPDBIUq2BKx97D
	 Muggix0v/stkV3BFj+lrcs2wbx8EAGfYbCj4Jli72Ac3UPA2uyzkIRZz3ireoJMb2reIZ
	 +7QGgzybX/y1BqeSJRYCl2omWGm3yazRyH4tu1Q4aZecyhf/03oYHjtDTZvVYA8jwUC4A
	 AWL/IHwQmwZjq3/OeVxSP8U/79mXiUjcFoZH3quOSCB90U5zkwTyL874su9c9WFSWbTPN
	 PnLV2Y0gu/F37DGmNpkx6CK1R1PgoVgY9txI6TqAVdcyTulBvg+NTxnC2vgie6mklkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Pq6ZZ/26";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CF606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq6ZZ/26
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4735C1F000C4;
	Wed, 25 Nov 2026 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634537;
	bh=8jFxxcacZMxF7VdX7l0lSumohqtCf4rAutrm5m04GRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pq6ZZ/26nb/KLh7Gw8or2g2/Ll/DDvEeM2XjJmTDU350lvUASIdbB7EQCaf4ve+w9
	 Y5BX8jkvWeMQaWUsJ9NgkqiB1MOgEZoffQG5K1Y6rRrRwhiI95tDPHUREGqwUMuuhg
	 TqTPlQ8nfEbHfb6qL8MWBUrB5PwvsMNzBV49RavLLVTe5IS2oW6sGwG3Zm5QkpxpXC
	 wCIF6knWXaFDKpTMRCFDxjtKgucg73VTEOuJRIGi+B6/f+8Jm1Qj+V2QZMvompHPD9
	 rqhajlqHSVgAoTlMFyNQoEH6M/A5vhXI8q4La0NLe6lKdGaIoIhtF+Cf07rLqoF8Fy
	 85IW6oJPcM5uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ksmbd: apply byte-range lock checks per open
Date: Wed, 25 Nov 2026 14:22:14 -0500
Message-ID: <20261125192205.1231082-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-parole-barometer-3f2f@gregkh>
References: <2026112525-parole-barometer-3f2f@gregkh>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit bfefe73543197d06e43c5669148b5bcc44f2dcff ]

Using the tree's POSIX extension flag to skip byte-range lock checks
also skips them for ordinary opens on a POSIX-enabled tree.

Base the read and write lock checks on each file's POSIX create context
instead.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 2fd145f8865b ("ksmbd: refuse to read a handle that is not open for reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 466a0853dc486..1c3dd8a416182 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -393,7 +393,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 	if (ksmbd_stream_fd(fp))
 		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
 
-	if (!work->tcon->posix_extensions) {
+	if (!fp->is_posix_ctxt) {
 		int ret;
 
 		ret = check_lock_range(filp, *pos, *pos + count - 1, READ);
@@ -578,7 +578,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		goto out;
 	}
 
-	if (!work->tcon->posix_extensions) {
+	if (!fp->is_posix_ctxt) {
 		err = check_lock_range(filp, *pos, *pos + count - 1, WRITE);
 		if (err) {
 			pr_err("unable to write due to lock\n");
-- 
2.53.0

