Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323535;
	b=5TQFE5M1OdD/2t8ZMZRejY07UDAiGg6vjUhMsZhsGbim1kZRlubGlYVGW/ShY+AsXbeT
	 S/j1cUu0kIhdFvRLFUgtNq9fBau7bLib6TD4zCowcU3IcQA2GiByuUEIMQcHUJKwAA/PU
	 l2w9H6rPxXV7YUmj8a8bnEcE3PL2b1Z7p4tPW5HVzT38grc9T853th0sXRX4/c40vfZIS
	 W42NfkmTfV8UrybvBS8CqOJKu20gM5BO5NgWwdzoFWllS9v3G5Vejo/rh4enJZKw4VHf8
	 vS8K54SgRz510ss4qQmflelD+wCcKEyPsdJ7G+fd7+xwUbJsrlE7jS5wuYy44cZD18g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WEWuWIl9SfahdvwBJC5sqKSh/EHEq9yfemvjwuPrN2U=;
	b=xGaPviPAZ1HtcTQC3DVUqreSCPclcHV0zs+zxE92Ppi3FnaaPlnECuIzDbE7SPEPkPfS
	 HAEDT9BWkhEn1jyBh4ocLy9RLPyr+SaIX0bJMSNFVn4x3a0nqYPSj5Oa9dgCvFie8VCWI
	 J3LYLnlCMjBiHQsUkVa9sz4+W2uH1GXthjODyu2vW9Wn7XelgQHJWETXA7qoJNorZlvHa
	 Wh4dvb7ty3I2yqUZDNPcrluY/ax6rfybuFhTz0oa3MkoVkqVjA2nSF5ZHQA+LlLoqtzgX
	 A4txxty+crBvmewL7ic4wMZ1lSBwzs0V3Ydi7qBresyRwk7CZGhyilDvvaITgBBZGpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jN1r1jof;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D1606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jN1r1jof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497671F0089F;
	Tue, 10 Nov 2026 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323535;
	bh=WEWuWIl9SfahdvwBJC5sqKSh/EHEq9yfemvjwuPrN2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jN1r1jofW59O2ccDLByicDQOq2DnG2KG2zMv+f3cBqdqe1mogfrESgvEL41RFWaw5
	 K1kbClhG7iYcWgUhHq/7kryZdHKsA0OXA3ebavj/A//CNdbOAEsqi5Xgjo3D9KtYcW
	 kzqLs/RwVg2B1jYF0pKzx+YtI/W9CmKaFwqxr0Nlm7cOjXfkkLBYofNAqVvnUbT9Xy
	 Adj7+DiZ65fmh2STBchYRhOMNvHU1ebcTv0DgVTCMhpKxn6qyTGnlPzhVcHXR3f8I8
	 fL+Bf+tdXfSz9ctCOiC6ToRbizaw9h4eNrdBwXtiqOL6cPvQvLcjUQsVarBr11ENZf
	 +yydV86ScuccQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] f2fs: return -EIO for a lost inode block after cp_error
Date: Tue, 10 Nov 2026 10:12:13 -0500
Message-ID: <20261110151132.2053181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051154-failed-6.18-53b12b63304b@kernel.org>
References: <20261107051154-failed-6.18-53b12b63304b@kernel.org>
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
[ sashal: adapted inode cache access to folio-based access using f2fs_get_inode_folio() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 60969e5f1201b..505611c13842d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -811,8 +811,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	if (!dn->inode_folio) {
 		nfolio[0] = f2fs_get_inode_folio(sbi, nids[0]);
-		if (IS_ERR(nfolio[0]))
-			return PTR_ERR(nfolio[0]);
+		if (IS_ERR(nfolio[0])) {
+			err = PTR_ERR(nfolio[0]);
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
 	} else {
 		nfolio[0] = dn->inode_folio;
 	}
-- 
2.53.0

