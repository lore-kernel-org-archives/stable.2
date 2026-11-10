Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324528;
	b=dULdhcrSf3bsEv36trK5ekhb2irej7AD5lQzQR/Anf0kKfn5DL5j0ir0qrmqVcNa8LtP
	 Ac/DoII2jDoYBQV+ZIQ/VwthzcZ1UL3DkBLdJs8MsZBbVhYVDT5SScpB7KfIt0QLPTTYh
	 RjiZQ3HiDFweVkaB0+f+5ACdVXArUhjNVBx1OeY8M+epdGLixiDuV73VHHACtGZVXGbOn
	 AUuojSUH9YX9lSTWOMthPZowTk1m/9hPbNdONaOFcptyUidVEqdHR42a9FOavePy7L7Y4
	 mUsfCo7Kd2wElmsWPLT01fB9dBTt2xhkd83qHfIeUVvCsYodeAw/od3/WvlwJj0RFCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fDYOPd5LFa0h/zTqiB0+kTXEpg09EnzUzppHpHErxcw=;
	b=QtDxbeDTPXHFVWyAleWIG4EDueEteLvdVhdreR7Nsqk1FC4NlRDkaZ+UFuIZscn8eXaI
	 y9ixJx+TqQX1E9JcHsAf/Hv6Fw4M9goXQdvij4VCo2KJJkXJzOCTcGutGxFZZnBLuGKB0
	 QL2INZZuji+N9zu71rwjH1/EMgGc2mPzWeUSQUA5Vk2skXr9U/qQXaA/q1P1vjCWN+Cik
	 ToeQOPQn+0LI3EF4pTyigIQ3L2/q+P5127HeVpUtNwm1sGeM/zbTc9Y0DoDml2vdDKBJ2
	 CpZ0g8iDyajGbq1axaWx5jcicxnUeW+DVHs4luAgq1X1g5JexdmXEIm7mIImZ4pvMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxfjQUTD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659260A262A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxfjQUTD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DF1F008A4;
	Tue, 10 Nov 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324528;
	bh=fDYOPd5LFa0h/zTqiB0+kTXEpg09EnzUzppHpHErxcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PxfjQUTDF5fp7CjZw0kpX9/PWhx0+qXWOjzOV0FhPtSxbShXBd26jPemkK9qyx7nU
	 9wpSUUur/187nQXzAhMWsWdHuWlszp+N7mjb+Rik/18ej0wWXoEaAnu7iUUfV961RB
	 VMJcXwvBnKTdCifAIy3tKMNS6NWtLxqoB7ym1X2ND05TwUjyxTiCMiWNujZSRUVQFH
	 fjzpkOeGHgJOxbQi9QkyGAoHyECoAypba48bat57NrqzqpRBG9NuhQdxjseNL+FOnb
	 NzR6hEQpm6Gz+Yb0tHwWhnEuO+vEoobLerX+uyYtDiw+pow5yup+K/N2e5q4W+vqej
	 aqsw5971kMpVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: return -EIO for a lost inode block after cp_error
Date: Tue, 10 Nov 2026 10:28:45 -0500
Message-ID: <20261110152811.2138633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053545-failed-6.6-53b12b63304b@kernel.org>
References: <20261107053545-failed-6.6-53b12b63304b@kernel.org>
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
index 8aa52629f788c..557372582346d 100644
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

