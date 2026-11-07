Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046991;
	b=RR6dSoLqKJaY7CJpqZlmqzSY40fIiFCp0ACpBGlLTbNs24kuIqm39Qsvd61lgQdQCLZ6
	 MhY7IvhlN/mBYx9GBgUjwZY6jMgF7B+IAOjjGE1wA3NgABXQR6/90fi58H0WMhGXIv2it
	 b50AWm3oHPxrjQ2L5NtRJOFDH+oe1VbuLiWW3M407qon5ucEfpPIJlUre0NX72C3RVrhr
	 JSIDStDB2SgHWMY+RPnFQNgI3Be571IxoI5xsUMfLRgQVYp82aZycNCjOcHtBpWyE0dAt
	 7PNeDd53N4LRB+A6GY4s5Byqt8dfwfU64bmPpBKaby6sz9Lh030ZCf1lCa0rdnq2lNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BKhNX7KYNWI3pT5bfesbIniRieCPvUqvy1TvQW3Wsqw=;
	b=xCZOmh9k0uMjtsseHIinqahj12irvnyg1Ppj39fILIEiWiKP1+UzjsDGXxieakIFIkfv
	 lX5CEyRhM3QvyLGodnIx2HitHAdJGPQZXZ5hSGEtUMBF49pvbunXA/A9HWGNld58dkVSQ
	 03gJkGs5p73jeMMf0C9I3zwrSoKafegwHQZjmunVCucZJY6XK6854sm4JRkGGpD0prtrU
	 QIlqf9FR27VXP41OHOmW9//i3J/F52OEX33l8D9h4meUxCKhgti1ZTjZ4WVJaAJZf05Cv
	 BARzvjKsIZNlX7oZx4vOV9NBRpGN8GXomEfy9kDEeh8MsNQDfcwXsTS9fZVtlXKObvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESbj0zRZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED85606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESbj0zRZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4551F0089F;
	Sat,  7 Nov 2026 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046991;
	bh=BKhNX7KYNWI3pT5bfesbIniRieCPvUqvy1TvQW3Wsqw=;
	h=From:To:Cc:Subject:Date;
	b=ESbj0zRZCcErFw2D1aT31768T8obOU22qsr5VebptUNmD+4ei9fxbZQ5m9jPGmCXS
	 zw/tWQqS3xA2gvbKEMsOWUYC2fqihLm73gF7khhGJ/Ejn1PIBERhI9mdc3621o41Qh
	 NevDUCLDLRaXXFIgfa1CgvNZJ8VxRfl7mSPO5dl92/tt9BMFusZpTv7x+mDQPbbOPn
	 6U3UyU0P8xeIf00RcMjAAJuGrWWdhX1t8D/RFApuvmOI3Aab8CpVGnqbC5p9nexso1
	 l5SP+AiUlQ0M3Wy7gokHMcyZlHtGIkEDLLfePgN5YenbHpaY/uPYWzV8G4N4WXE5O0
	 O62EVuXLr4S6w==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: return -EIO for a lost inode block after cp_error" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:09 -0500
Message-ID: <20261107052309-failed-6.12-53b12b63304b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 53b12b63304b34a3850a901c4de3cc6ad08e0aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052309-failed-6.12-53b12b63304b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 53b12b63304b34a3850a901c4de3cc6ad08e0aee Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Mon, 12 Oct 2026 18:22:33 +0000
Subject: [PATCH] f2fs: return -EIO for a lost inode block after cp_error

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
---
 fs/f2fs/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1863e8f1c859f..2dc136dbee34f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -842,8 +842,20 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	if (!dn->inode_entry) {
 		nentry[0] = f2fs_get_inode_cache(sbi, nids[0]);
-		if (IS_ERR(nentry[0]))
-			return PTR_ERR(nentry[0]);
+		if (IS_ERR(nentry[0])) {
+			err = PTR_ERR(nentry[0]);
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
 		nentry[0] = dn->inode_entry;
 	}
-- 
2.53.0




