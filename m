Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047747;
	b=XblsPzd7PPZ8pe5cWZL+cnY4MFiTzd/jKwyzu8UjG2Ez0rmQljQqd4qU0OOGqPVW2yup
	 TPtzt/hhqoWDBWRNlc/g0XOleizW95Bxkb2IupB+hoy0NpglLu6vUYgEVl73vBKIocboe
	 Fkd9DcLVeNdyi7rcED73629r5wtb3qOwajkgYjqFbE9AJKztXeVWpnbLdWmU9eVSlMLgX
	 D+EEy0ppzj1DuQ1s5aRILubYZ0DENrI+2UI0cGd2AxpIiVdAOORdA/u+4tZeRLLCfZRIM
	 dqKQKeQw0qyRj5QyDo6jYJjCdrWnSOoGb0+xyz9IE9JRKTrb+VBBTVstPYHkW25LI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VJ95YSU3lSnTO3eaKvNfV+NpW3sV099SDandAuCAKIY=;
	b=4VdLpRGEZvBFHL4sk0Els2+6tf03xDWyK4WNJa4me9dLhlJqVP4jhmINOFtERW2c8TPc
	 8ablMVS1pmDoZOHf34ZmKReTbC9zPnZkHvg+pzKt1/BfcKw25C834WLrnykIqpuNmko7W
	 ac8cGA6jpGr/Py1H/f45jW1YzM5gRAwbM8lrL4PAUGC3/0/gi9Hli1+kzJX4ZDcrFpSl+
	 Gm3wUSfFYBlYhHetKU9K0IrbWRL8tb7Ss2wpm7PTKvIrvmqwhMa2kUpnxQk6dN8J/sC6P
	 CqOso0AxWg8E3mD/3GdqhMGLaA3CovM6amZWVUFAwtytxTg2M4m/KfdjXskIBYcmc5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF4Vfp4M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF4Vfp4M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B7D1F0089F;
	Sat,  7 Nov 2026 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047746;
	bh=VJ95YSU3lSnTO3eaKvNfV+NpW3sV099SDandAuCAKIY=;
	h=From:To:Cc:Subject:Date;
	b=aF4Vfp4MYEBHPlzB84gbf0zBnBYhc5XpGzCqZjwqiH5JgvBay7OTw/jOTWPxcog8+
	 pDcLINWC+tQSdbAudk6Vfybpf2Ibzgal4celxnNwWg3rPFan0qAvQxTaAQl7f2aakI
	 YUfQuYCP1OcYSxMuzEFi4cLxPHCVbN3cetv8hd2/MEPvBvTNYZ7eQRyTUsILSXiI1Z
	 5+VeXoSCdZ+myNCeDnGsn7OyZFw3/QporeAj0eDyjCq5l/zbC4HpbQk51sB7gckxJq
	 2xSGe4/MlOsV/N6ZDY9FkuBk57ouqOEChauCK94ZPE7Wgi6zi5n38pdOOB6RG8Ll4/
	 wrUZ67m9mfxwg==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: return -EIO for a lost inode block after cp_error" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:45 -0500
Message-ID: <20261107053545-failed-6.6-53b12b63304b@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 53b12b63304b34a3850a901c4de3cc6ad08e0aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053545-failed-6.6-53b12b63304b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




