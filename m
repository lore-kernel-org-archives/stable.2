Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324767;
	b=wIfxUpZebbu/E1lCGErGdbbGsLJKI9ygpMJXKE2eZiolvkfoeW6TWtK6hbHuYEIX8/3V
	 5AHhB8yADsfU7Fu2APIxxn/9++haDb5xtbQooPM3u2tjt8hjt+xjHYj3yQzLxtTsWc91f
	 7e9M1rJyMr5VM3hauJnqULU140DHeYhNFUCu4yeO4kQyx6toZoIOGVyxkhMV/kw2ySbn5
	 tKCneQc7D8OcMbSMEL0s4aE7Fln12CMS+kjJhhaMjRo6gS982xdqM7Rtnp+EPZGNEG4uK
	 6zxR9NIgDZxqsE7d9SJ7Ekc93X+ZVbofqp3FeyYIh1ppCuoxWurSrCo92im+OypSTfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/REcGZu9OsJrfS6QoA4igwgsIUfjbFw4CPMbJS+5cbo=;
	b=XarFF3MaprH7+0ZBLKNuyP1oUxDlRjbIEegZJiS7k56Be0/wej5Uk+VBr0i2lmFQ3T/6
	 gobGSQMRAKuBJKFXN+e0fgVhOURJD1D0t3Et5pkFFEmZXWwTowRMWS+dt+lzOjTbmxHIA
	 1rm+KeDNDyW0f7PWcj0B4R89JJnAGLkbSS0RjCIBr2DzqAxlvMf0yAp3mvdvVoYYxsH9j
	 44spN6tq0x39qmZIZqkdo4OKZN2p+/4SPxR0ChDRM4QTiqFqKVs9A90Z4LfLWL1iT8n+i
	 MZxcHXOz/YUAAsvgwPEzA87GvvwtBudaj47tbLjflvTZJs+ufketjx9KLDc7MCFk48g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYc9WmzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D5606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYc9WmzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD411F008A1;
	Tue, 10 Nov 2026 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324767;
	bh=/REcGZu9OsJrfS6QoA4igwgsIUfjbFw4CPMbJS+5cbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nYc9WmzJNBIHQMgByxYr14bcfFvr7aNsvT1AKOVI+jpW+QatbMFzWOjInmxfGfp+m
	 hWh7dT3Wmkw06yIOtm6TL1xZlHrNU5koFBKz8BOhptT/M3cGjUEMOtUg7U79FwPByv
	 MMI/Ph0PNZKlelyxR0N8Q5nxxoUoSoEyi/nZowzPSiybsUiXmXpYDyptza6CUlJxPh
	 +fy+QsJOWUgK0eNq7jFJccIRy9JtCS6XUcgoIwWNODLmi7yCaQiJ8paSxVUQYfHft+
	 lbCASqv7Hok4Hd16oQ6uOTzkdMo+4nedbFtXMi8w+Z2oeuUPzH317fAZeBy9zZRsDA
	 R2nwSv3i/aFMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: return -EIO for a lost inode block after cp_error
Date: Tue, 10 Nov 2026 10:32:44 -0500
Message-ID: <20261110153214.2297832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055003-failed-6.1-53b12b63304b@kernel.org>
References: <20261107055003-failed-6.1-53b12b63304b@kernel.org>
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
index 233448ba3a299..c85ec028baef7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -783,8 +783,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
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

