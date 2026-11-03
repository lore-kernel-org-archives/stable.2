Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714445;
	b=E1UZ85F44SKz+gapVHIDGK24XSoZcoqdZ3z50zZDrn93d60wFvfeXb0939DGCxwULNTC
	 Zm79O4v72jIWh+ZfM23WNxKM9bbAGAudNP+FLtkfF1+bm12GFIjxSCf/lhLNKVJ8ZjUht
	 bUFPsMexfLDTfGNDvK5ooafB4/EEqoRvDYtLf0H9Htvy81ru30GRJ7vtoPnxK6TuwytZz
	 9Ig/jxX12uboBJd6EaFALYAUMe6FbTdPvOn1H/AkCKYT1Xaj8PUsNCQnGweL645XotKQm
	 nZRF3v4tiTK6Afcqb0Yx0+zqKcfk2wakAFZV+lHDnfc/LV3g+tml9XZO7WEy7FlRTcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714445;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9dvPCMv92+Br6DR9L77wZr0PCqqhY/B2uXV0ErGV8Kg=;
	b=M/3t03mEnmiNZWTDfTVYM41l+TLmiar3RNYQg2Is2WZaVUxnk3z74N5clhFfJthvDbT/
	 IV3Kizyq10WOpYjg889XSd7+/OOxfZeKRbpwbE9da66QbU7Qjm6gG+Gcl7yLbf6SsBSFh
	 P/OmjeqVF+aLE7lziHQ9nL52yUPGSxFD9V/gOrb7lDAOGwTCJARcxuGe+CsZo7tRWzRnb
	 aDpApz8DtZEt+mmvjzEvQEI8TEk+KYOuQhjT9YUnMT7Uy73o3IWuh3x+FmhViPO66jupf
	 009Bg+9dbBO9SG+Yxqt5CjpZfVRS4pgNcatBWyhie039q+tNJMnX0c6bFITigRDRrmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixvp5w+p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B2606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixvp5w+p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46A81F000C1;
	Tue,  3 Nov 2026 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714444;
	bh=9dvPCMv92+Br6DR9L77wZr0PCqqhY/B2uXV0ErGV8Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ixvp5w+pgvLsmkznMWlcrwnIq7Gee8dTh3T6/fdhWofliYQu4ZNzvRDX2rqs5ZqrI
	 2prFs0RlyviQDjU7y5UQhzQQeW754ZvEY2yo28Xcs7WqX5FU4EIe6TLdnvCIziYOCI
	 m1NzE9ncsCfG8k9vWjNepehf8CsKk9O4elTfHFZ5utV29352YfVYY64yx/w1VbdA8Q
	 UEcXbqjRtgRabO+B3GULGie4sl90YkWAJIthzHA0vUDwVVVA9X6CUL7Qt18N1ryaIc
	 QeJ3EurLqOq5P+pbvIeC/s8oz0mtXKPcXN2ZrF7LpkQdgRmjcgm5KzAGs9uqh31bH7
	 pbRroOAov/mqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: avoid restoring only in-memory EOF after allocation change
Date: Tue,  3 Nov 2026 09:00:42 -0500
Message-ID: <20261103140026.4186634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110313-diagnosis-specimen-de6d@gregkh>
References: <2026110313-diagnosis-specimen-de6d@gregkh>
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

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit 9455e920aebe41217cabff3f81e90da4c407fdb6 ]

When SetAllocation requests a size below the allocated block count but
above EOF, ksmbd truncates the file to that size and restores only the
in-memory i_size. The larger EOF remains on disk and reappears after a
reboot. A 3-byte file preallocated to 64 KiB can acquire a 4 KiB EOF
after reducing its allocation to 4 KiB. Extending EOF this way is not
a reliable way to reclaim the preallocation beyond the old EOF either.

Only use this truncate path when the requested allocation is at or below
the observed EOF. A truncate to the existing EOF still lets filesystems
release preallocated blocks beyond EOF. Remove the in-memory-only i_size
restoration. The size check still precedes vfs_truncate() taking the
inode lock, so a concurrent shrink can make the truncate extend EOF;
that race also existed in the original path.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..2b43c97a32859 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5887,24 +5887,17 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 			pr_err("vfs_fallocate is failed : %d\n", rc);
 			return rc;
 		}
-	} else if (alloc_blks < stat.blocks) {
-		loff_t size;
-
+	} else if (alloc_blks < stat.blocks &&
+		   alloc_blks * 512 <= i_size_read(inode)) {
 		/*
-		 * Allocation size could be smaller than original one
-		 * which means allocated blocks in file should be
-		 * deallocated. use truncate to cut out it, but inode
-		 * size is also updated with truncate offset.
-		 * inode size is retained by backup inode size.
+		 * Truncate at or below EOF to discard excess allocation.
+		 * Truncating above EOF would extend the file on disk.
 		 */
-		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
 		if (rc) {
 			pr_err("truncate failed!, err %d\n", rc);
 			return rc;
 		}
-		if (size < alloc_blks * 512)
-			i_size_write(inode, size);
 	}
 	return 0;
 }
-- 
2.53.0

