Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323335;
	b=X4h/EjIxXgmFUR9GpwoP+m0wdoS208pkvYwHBigzZb1LWj3YSX/FUfDraaDDH93P+rM0
	 vA1gDvOOnbj16rGcro9zzaAi4h4nIDYkUGVzVFHqadokKrU2ZlsbIh3UtxXe/13ee6xdu
	 S9cM4Kq1dcxMG6StY8XQS8EFwe+9ybhPy6oAtnoXly6k0EsaZ/28Ok4cJgYFbQV8YRcdY
	 UNU+wrTPgjaBvN98oK24TYyudQEx4LOvwfBGBfc6dzWhOPh9pVIhM6qe2SDqVPTknmvJl
	 womLVudIJp3dzRp8xb0i6xYZE+7iar6HLF3KVC+jI4PFjKevN5hIB2oV7RmqgX3wvbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WIA6+aq2BFsonqdZL1do34wo6rMa13vPzf97dHEwv5s=;
	b=CiMs7+DiOlMSQevKKKnvnqDcV0evnGNEJdgyseBMbmMAu1MHhyfNgIXQ861SA4zII7+y
	 dRyEsxvqUo6laffwegolBHU2O3RMfEOdCYAnzL4NT9vA5QKndP5FSJcEic49f6pqHTx/7
	 ObyDrR/+zBuflyEsUC0Jz3OZp8a6qlPlVh9uzqVqZYttZyDW+q6CUGnlfp1VvNI3+5WOL
	 QoqavvMW07MFu5DVbQkQwXGWpdHESGe0ns8Lp6qRDFHAAT/paOEZ0XPktdbmrG60vUL4F
	 RgeYpUICGHLQxtYd7/STs7zVvNQLeGZUt2xZ07V2+2TdrmKBismzC3VamjnWD+l0pAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSxMQgOk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B8606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSxMQgOk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE6F1F0089F;
	Tue, 10 Nov 2026 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323334;
	bh=WIA6+aq2BFsonqdZL1do34wo6rMa13vPzf97dHEwv5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSxMQgOkBucdVCZkw3Eh5Dx/+gHCD216cIuRR+iQRmBIpdPF0EYf9Hd17v3tPBxm7
	 cX+1Pe8HjM/cmmxF3hPiYuC08bIJAJF6rxBeWM/QLcZaoYBVnaOuUqEnOB5WDmPZXr
	 4xC5yrU48Ur0jHTmSamGDbSXl1LW4NT7IzofjmQRcQTND4AuzlhqmTcXZ9JFk7NHP3
	 pq13TeNfjbZw6ZJtBFDW0lerSg7JWBmBRvWd8bG4arJtZQd0f+A+THu1OJiZAJkK81
	 mXoawzCFhjayPT2S9IHlJFaXEVXprg0FLuil3Vwo1ZmOkkwKgCz/L+0jh0hO/pZWYl
	 0M9e1/tCF5xDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: return -EIO for a lost inode block after cp_error
Date: Tue, 10 Nov 2026 10:08:52 -0500
Message-ID: <20261110150805.2030492-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050458-failed-7.3-53b12b63304b@kernel.org>
References: <20261107050458-failed-7.3-53b12b63304b@kernel.org>
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
[ sashal: Adapted node-cache access to the existing folio interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 86c2e67e43b6a..5f3ea61325914 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -835,8 +835,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
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

