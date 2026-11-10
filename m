Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325206;
	b=23jywYfu4tWDX4PL4EU58cd43BUMvd6pEoWvCLpJMQOVAliqOjGGFsuhhYNyVTImWEe0
	 MWFYt0mGwg5+sH4ZTspZplk2wgubgB3Iz12mXmp16lXbMdh14jRhB3DkmbbJUCEy37u/l
	 lKmfS0YD9K3o2jxKKtK/yq1EYIeyPZK3nT3R53Ro4vewxGXPKDKyAwS6OhBA84pu7y1HJ
	 QlKjO8iHrh0QE9Ft9ahvOD6hFfs4oNXzJDCowADHvpqY+CKrQOW7Hxih8MiPzcuqY2UgJ
	 V/k5OD/9LA2ucmgWm6eqNqkh3bQpY4+mkta/7Uvnl2nIOVHko0wnq2dQAKEmgiThnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nPXN54qvbIkSSX3/s1oD2L8ssGfWhFTgof+Nfm2fi7g=;
	b=ry8h4XOODyiHWLPnC9yxU8M/FklzJ2gW9j5hCCi8o18H0wFRaxbd/9woo5UNZ0c9CISw
	 rpc6opNjqniiCjtMiu8uYVNpRA/+j4fQrkaWSGIWJ0brgYEbsHdfIh0dav7i4mBYNdB3b
	 FmzaXUxMjhp8rJBTJAoPdEZLW7XTQ//6ewu5s5ePSjXppJ64BFt4dz5rxegM1X6rnNVV0
	 0dwVbBHCjvEmPF8hLrO8FpS0eFiuMhjbv8gBQQPU7AY5Vw0BdxlEvmpvYwB6O+rtIN6zP
	 9FUSRRRIbLG2guCxL0HazCVn/1VaNotvZyAhTfighwVev/SDpOHoL+fYPqM/L1HOksQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y13dwEGa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCB606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y13dwEGa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73EA1F008A2;
	Tue, 10 Nov 2026 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325205;
	bh=nPXN54qvbIkSSX3/s1oD2L8ssGfWhFTgof+Nfm2fi7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y13dwEGahaXFNjR2+MY5X6WhHwL/ysf7BnWOMIiCDoqIgp8LhbEo4lYORj62rNdRq
	 cC0ngoduAkDIFdJsam1QSmcb68+u7VBHy/Tt1xJD2XB9yVKVPb64gJ8YBbB0xMVzqR
	 0uW5HwDRCZ1lrUqUQejwKlUAB7xpWBF8mS2QrqSWVZ+BCWhdHM6BUAM8p6ptYl4GOK
	 fhUTNqXHqYi7S2Of1BklhM0KJJvFm9Om6zH9/8kAypnuWSCRJ4grJKt/Pfh32QoZ1u
	 H3+WcFVLY+91u1QI53tlQqghlb2cjl/mXCbw48QFeBGk0egfneJu+ARSKoUC3zqeUZ
	 5D9i6k3te04iA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: return -EIO for a lost inode block after cp_error
Date: Tue, 10 Nov 2026 10:40:03 -0500
Message-ID: <20261110153934.2310261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060707-failed-5.15-53b12b63304b@kernel.org>
References: <20261107060707-failed-5.15-53b12b63304b@kernel.org>
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

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 53b12b63304b34a3850a901c4de3cc6ad08e0aee ]

After cp_error, dirty node caches are dropped without being written.
If such an inode was never written, its NAT entry is still NEW_ADDR,
and reading its inode block returns -ENOENT.

f2fs_get_dnode_of_data() passes that -ENOENT up, and callers take it
as a hole. Since the inode block is missing, the next offset can only
advance one block, so fiemap walks block by block up to maxbytes,
about 2^30 blocks, while holding the inode lock. It took hours in a
power-off recovery test after shutdown and blocked unlink and umount
on the file.

Return -EIO instead of -ENOENT when the inode block itself is missing
after cp_error or shutdown. A missing direct or indirect node is still
reported as -ENOENT.

Cc: stable@kernel.org
Fixes: 28607bf3aa6f ("f2fs: drop dirty node pages when cp is in error status")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e5a06a65a5398..65f3501b939e0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -777,8 +777,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	if (!npage[0]) {
 		npage[0] = f2fs_get_node_page(sbi, nids[0]);
-		if (IS_ERR(npage[0]))
-			return PTR_ERR(npage[0]);
+		if (IS_ERR(npage[0])) {
+			err = PTR_ERR(npage[0]);
+			/*
+			 * cp_error drops dirty node caches, so the inode block
+			 * of an inode that was never written reads as NEW_ADDR
+			 * and returns -ENOENT. It is not a hole; the inode is
+			 * gone. Callers treat -ENOENT as a hole and keep
+			 * looking block by block (e.g. fiemap up to maxbytes).
+			 */
+			if (err == -ENOENT && (f2fs_cp_error(sbi) ||
+					is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
+				err = -EIO;
+			return err;
+		}
 	}
 
 	/* if inline_data is set, should not report any block indices */
-- 
2.53.0

