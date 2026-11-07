Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045900;
	b=rjjJ+Crw6QJ4UCIYUJ4N19vE7g61Y9ycGB44iwcZEUyeQjC0FLxwCMYBtzuxCIAnB0ny
	 lPzzbk8ooJDcxoeOWxm1J7m0ZdvcHhedNHyMchbL5TIgk93SjK0iFNTyfnszMMgnhWG7V
	 PZ0A8AkLPx5McW9ozwvAZxhMbcVBZcG9mb8PhwTY6pnfYii4lQiwn0xmQcOuADW5Q+Omf
	 u26UtGmObcaLQjE2NehKq79VyQdsR9kA4gq20x3QBPlo8cZ2Fcg+K3peXfZheJuk2WHOA
	 ocJ6Da0Rx5ZWS/Spht6Pb399IZkknkkj7wMPS4MCfppyeOExELdA/6f5guA2LeJsAfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2plouk3Ge6jkrWJ1iTWn9Sf+M3j4BgCiksFQ51pmR30=;
	b=HM3XxNVbzdGRga6AwDRfQqxRvclROL4m9rg6ycvqUNuII6Whnsnpx9441wZ+Rl+BaIAP
	 UVccdF0kOFNnMzDC+EL0yEDKEb+iocwesv7qxoq8w+cijnmnjEYL3yRb0bbVOdiPLcbCR
	 gwlfzJeO3N0nugeYkDzv3fYH2GYnzoawzvVcMMeQAiN7sAeIaa1hhH1NqTeMJTnlsIg2r
	 b9K6dwr32WK4tWLQRNMZkxxCr6q0bNdRdJ8uNr0jGPCikDfX4kOj1l14kbghA/J5xaFOI
	 XUdRvCAcpq3IWR62BMjryhC5gdmRKa3WAGL+i9fC5wJS7YXlcIkeoobSSanRHnHpc0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnqS2tjV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44541606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnqS2tjV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E37F1F008A1;
	Sat,  7 Nov 2026 10:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045900;
	bh=2plouk3Ge6jkrWJ1iTWn9Sf+M3j4BgCiksFQ51pmR30=;
	h=From:To:Cc:Subject:Date;
	b=PnqS2tjVSxYRz+K442PFMFLq/Uvbt9Ew9lSfPJ30NADAQtBP+QlxKhlSaNMFxAseq
	 F27wStZqWo//H73haQyH1tMm8EL9ezqmPRoD90QecsbShKvdwm+xMS4Rd1sMsq9oRd
	 F/TIclhb3fy+HNozTY/BbI0ten9mYWRWMV4sdOXFiXBU8wH5IAamnzexOOVoNW9WKM
	 T0yE0WU678wldm6XD9O5AD9xKX9220s4WVB6RSkDHzj4Q5V2XHs58COzTXLSTnuBDN
	 DftJkZINhPt8mMCfxhEi66MzMXD3zBOxnw5E+ef0XN717Ur3yEpmURG2alublcLZz3
	 5x5w1o5EKMt6Q==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: return -EIO for a lost inode block after cp_error" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:58 -0500
Message-ID: <20261107050458-failed-7.3-53b12b63304b@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 53b12b63304b34a3850a901c4de3cc6ad08e0aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050458-failed-7.3-53b12b63304b@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




