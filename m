Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048606;
	b=YnOgVpoaoQS6CFot49u5hdqt0DHLzlt3YeiYhu+nPDsJzAbzUy8Bb/2ftocQXU50OEy7
	 IRl8zVnX1o6UwP2LoEq/BE4j7kJ95JQSfGwCC17vv2uWLwY87cWwIKOnic9/AuFalbKND
	 gtyeV3k/hA9Wst3lOdCFhT41efCUjeeufuLBld2lCYgLAU0EyjrvGSk71qI/UslH1NgCR
	 pH6Q4cQhxjEAoLIwrh6sap8UlzQFZ01rNNyFsVrQZDDZmn9wytCvEfsf6GKDRe4REKbRz
	 OeYGXHHDtF14+bcoDo67wrB0LkfmQDpGH6FdhoWydEIpKT/1pFtQgZu6W4SUYu9kxtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3sBcHkTel97yhN200mDcwpMVU5KGPo3QmzSNhqGDghE=;
	b=R7L8vuQRuSeJqLYlF1H/E2BOQni65MzQiVfeSTP2vAe+D+F4lwtr93ctEXoEATFV013+
	 x9vYdcD2HHnKu+GaUlZW/yN9f72GIqvz98iHTizKG9AjQnvrCw07kI0bZiSSPZmxvKXOY
	 3I2inYfKFt28MlHWmT0bYT+4D8XPdUWLt0x8KuHS8D/Yj/ptRCLekvIZZi4cU8FOSokrY
	 B8juIbF16B8QDHxmRSLYK+hJzsCJxkkd3CBpZKNkV+UEjXMFAjlgmDqsNt6Qlx3bue9RP
	 /bBEb35MshwMlr0VO5QpfU4oaN62NpXKh0ZVMiUN8S/+hAuZ03+PKprQHE059I1hywA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSWVLU+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E1606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSWVLU+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1911F0089F;
	Sat,  7 Nov 2026 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048605;
	bh=3sBcHkTel97yhN200mDcwpMVU5KGPo3QmzSNhqGDghE=;
	h=From:To:Cc:Subject:Date;
	b=RSWVLU+FJv5vcf7WJyevKKDVCbAfFcdaJwNMiEZvKbxjkgcV2vICTp97qe9mclhDF
	 BGERFp52Fa2FZmsVl378dcByPWkJZf7Xk9HU6hQQ/ZKwrE9B3wFrFrFodA9sIxFMVs
	 xp887zFIxycYiOos4i/U6Sgfqjnp9icla6N7H67K8BhkHk6FCnbuFXfd5GiLhj9yUW
	 LncCotE4e53q2gmR1U4L7QpEhHEmYIudkvUOee8nbBUJ+biaVpgxnCjjHT/qzcfHkm
	 aMyXLPPHR+jNDNHCL9xExFJjT5CPIJsDOP8mwxi929p+U4FeseqpGAg/Mvjp5zdpgQ
	 t4d5SD9tsIfFw==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: return -EIO for a lost inode block after cp_error" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:03 -0500
Message-ID: <20261107055003-failed-6.1-53b12b63304b@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 53b12b63304b34a3850a901c4de3cc6ad08e0aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055003-failed-6.1-53b12b63304b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




