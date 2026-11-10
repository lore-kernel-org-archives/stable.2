Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324217;
	b=k35fiHqyXNc+ztjwuQjiBCIXZ5TqicTfrMc6SO+6dfJ8oHY5c67uvNVcBDsx+YRrHgxl
	 t8lfGJGaysb8kRQWpRNefPzPeZw7R5DuOmwabU4wcALcvvzgtUHtFHwBHhv6LT6sN530m
	 X/rmABIHO3S9Pknxxq9zHyw3NxLtEfDZgFm5j7/CqjkRXImoTfMoP0cqObWfMCEIYiC/Z
	 RpTy+bpOUIwTqOa2fNxT2U/MrzTX7lpMcezeYffG4n/qhFNVk/u/uRHFTrNvIx1MQY8LO
	 k0zv/DWjaKSAGEXmr/ER/sI/j7enbY7MQCzU2jOdZdnAkhlIgXsb2EbdorX4SeiB5fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oxS7DKb1Z+ZWq2sDTfYHxc5U6ojP2hnJCEd2Ptkx8UM=;
	b=c+bppc4Po7SRld+w6Q8/NG7vd91XsZMVw3J6+VN7QSyj0p6WrlldJuKBiHMkkbEaBlDA
	 UwPDUgH55zDGWWBjuDyLKHv2CRES5ll0Ggwinm/fLpWzgHY5+X/wSEAOzhx+dH2BJD1b5
	 vOSfu6bfgNX7X0pocpGrX48KkvZSG3AYuRrh1qzGNIwz3UGMLMJuZr9kHW8StmZOy/QXr
	 eqQ6Kr1PihC1AuDEYjanLx9pYxI63i1QNKgXRlsULC9Z8duAzsuE9XnC7feipf7sqmA/l
	 PZEaKWoYVxgbGPAcPSvdh+jMeT6vNazsg7dk3xtslpDCUtpd2GofRTg7/yJSmsTZdrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8is8zFx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88841606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8is8zFx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459001F008A1;
	Tue, 10 Nov 2026 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324217;
	bh=oxS7DKb1Z+ZWq2sDTfYHxc5U6ojP2hnJCEd2Ptkx8UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h8is8zFxiFbFyUKglVx5Vhuf38FUVhA4kO08TRyzvK6NNhs3hfDYYnjKQ0ytr0vWO
	 Y+g+l9D3JCT0dD33vI7Asu3+X1mUSnd702iLo0FqV7+NGi9Lw+CjCECv12KtAoh70v
	 EA61Iyoa1DuBX5eg4rXH8UE8dE8WJsFcMh9ABnFrAfXGB3lv4a8kWkDdmHUfICXGnL
	 /bZEcuBLElFGDSjvatP/KL59zjTS2Jpg6gT6O2sTiC7WbUHrNocDAPNioP4jdSNdJd
	 Vy0aCkNHf+HLf50CqlxVZWRuZs95KTIPXXVoqnQ0dTK9+WcMAylsS9Kkt96R7iB2FU
	 UStdDRW2zDmTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: return -EIO for a lost inode block after cp_error
Date: Tue, 10 Nov 2026 10:23:35 -0500
Message-ID: <20261110152254.2084483-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052309-failed-6.12-53b12b63304b@kernel.org>
References: <20261107052309-failed-6.12-53b12b63304b@kernel.org>
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
index 8a11623dbf1ef..963adcf00e910 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -785,8 +785,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
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

