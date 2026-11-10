Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274154;
	b=Ryi1WS7vZfF3NDnmiEdYC9QMmp6VPjMbuKdyw7fKAFZ9VoY15tEexir08sTVRV7MtAH6
	 1+R8egD66NXPG6uwNPCvPjfd6gXKp+cq+m/sm/Ph+c+uwu/2w1iZyn67QEy44m6tzDK/N
	 s25iUuOlQVgdwNIob+iRmnWkQetXgvM/dYEBrSetHGvf7ib0KxGYmpnO8Hs9UZ6M/lksj
	 jvU7PsH/ozAtpisgV8Q6A7TaViLBf2kOxRVuzqboQqJqjkRYQl9ANVL3FO6tOpmk2k5nv
	 FF66wWE+/EEqG9M7qXzhUD94RBdXGclTjUk6zl4aK9GZECrFUp6m8dvCp6x2zJ/C7/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274154;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LsheQbVvW4vRpMmoaheMbO0/exU422pzREf1j/UW3Xw=;
	b=N1Xg6sgV1E0otU1z4jEPIKy2bzbbr/1fOd4qcWo+YJ27x/ihf1Uf5DTCUvR0EkuIB3fu
	 bKOE+Q/LvHe59O8QdAcfH2PUe2ncmzP2UOC/NCFraNQFQcysXTk6j9OOaEE+0t47edHzL
	 3iYlxfok8WICtaetqhUYVXCHNy18f3R9s6+EBqGbvKaE/W5Y/IeMMk+9Spw++MuToTwwD
	 wanqPGafG6C/kc065uAmpV7w9OuAB72aoi1EfPaXEqHTj2vCEd2gSc6gKm2hBH7fUqN/6
	 p9155a0ajsNWFPB0ydekaiD5sDOIgUpQUAxCkniGszGUgxgL/cXAJSirbr8w3Timg/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0YpKscC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0YpKscC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4241F0089F;
	Tue, 10 Nov 2026 01:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274154;
	bh=LsheQbVvW4vRpMmoaheMbO0/exU422pzREf1j/UW3Xw=;
	h=From:To:Cc:Subject:Date;
	b=V0YpKscCi8bHdhJk8NZzsuDhl0Z+ly1O/E19w6jc+aTey0+1Ag0W9TEEoIRBkaiPh
	 LwrEEA0NIe2R9AdWnnggYMb3+kNzCMPj1Q59JQlte6907eDCUmPjAalZZ3nwaS8Qix
	 wFJ2L9X3nPUCUr+v3LdzOIifFPKs8kZvEvKu3BjB2OlQkhdPpy5spDVjd5/2B4K0SO
	 CiuOXsvet1MRvB6pjr0e/Ystjx+0sIc2OS8r/dGMn6n5l/ZDkzn7X2aSwX2SF0mD3N
	 JfrgfvMvgaGnCH9h2ZDbSshKrQElBnwUegaBT9Ad/GYqJkut/lK1gTORAqyHxwdOKw
	 KTWGi+iWurtvw==
From: Sasha Levin <sashal@kernel.org>
To: matthias.goergens@gmail.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: check the unallocated space table when it is loaded" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:29:12 -0500
Message-ID: <20261109202912-failed-5.10-e614c3e35a66@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e614c3e35a6699ed691b4d17e1ec4230e34aa3eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202912-failed-5.10-e614c3e35a66@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e614c3e35a6699ed691b4d17e1ec4230e34aa3eb Mon Sep 17 00:00:00 2001
From: Matthias Goergens <matthias.goergens@gmail.com>
Date: Fri, 30 Oct 2026 22:05:35 +0800
Subject: [PATCH] udf: check the unallocated space table when it is loaded

udf_table_new_block() hands out the first block of the extent closest
to its goal and trusts that the extent covers at least one whole block
inside the partition.  Nothing checks that.  A zero-length extent makes
it return the block the extent points at, which need not be free, and
the subtraction of one block then underflows the length into the type
bits, turning the entry into a bogus continuation.  An extent running
past the end of the partition makes it return blocks behind the
partition.

Such tables are not only found on crafted images: until the previous
commit, udf_table_new_block() itself left zero-length extents behind
in tables written by mkudffs, and then converted them into extents
running past the partition.

Check every extent once when the table is loaded, and refuse
read-write access if one is empty, is not a whole number of blocks, or
does not lie inside the partition, in the same way as for other
allocation information the kernel cannot use.  Check first that the
table is an Unallocated Space Entry at all: the walk starts at the
offset of the allocation descriptors in one, and for a file entry that
offset lies before the inode's in-memory copy of the descriptors.
Treat a chain of allocation extent descriptors that leads back to
itself the same way: the walk would otherwise return the same extents
forever, and the mount would never finish.  Let a fatal signal
interrupt the walk and fail the mount.

Refusing read-write access to an empty extent is deliberate.  It shows
that an old kernel took the last block but left the entry behind.  If
consumed again, the entry returns an in-use block and turns into a huge
bogus extent.  Refusing the table before that
happens avoids this second allocation; the filesystem can still be
mounted read-only.  The check cannot detect every overlap that may
already exist in a damaged table.

This patch should be backported together with the previous one: that
patch stops creating new empty extents, and this one rejects existing
ones before they are consumed again.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://patch.msgid.link/81233decd91f4a48bf4d74e3d15b547c7711e39f.1793349907.git.matthias.goergens@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2335c31cde314..a81a8509524a9 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1106,6 +1106,73 @@ static int check_partition_desc(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Check the Unallocated Space Table once when it is loaded: the allocator
+ * hands out blocks from the start of each extent and trusts that every
+ * extent covers at least one whole block inside the partition.
+ */
+static int udf_check_unalloc_table(struct super_block *sb,
+				   struct inode *table, u32 partition_len)
+{
+	struct extent_position epos = {
+		.block = UDF_I(table)->i_location,
+		.offset = sizeof(struct unallocSpaceEntry),
+	};
+	struct kernel_lb_addr eloc;
+	uint32_t elen, blocks;
+	struct kernel_lb_addr seen_block = {};
+	uint32_t seen_offset = 0;
+	u64 steps = 0, period = 1;
+	int8_t etype;
+	int ret;
+
+	/* The walk below assumes the layout of an Unallocated Space Entry */
+	if (!UDF_I(table)->i_use) {
+		udf_err(sb, "unallocated space table is not an unallocated space entry\n");
+		return -EFSCORRUPTED;
+	}
+
+	while ((ret = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1)) > 0) {
+		blocks = elen >> sb->s_blocksize_bits;
+		if (!blocks || (elen & (sb->s_blocksize - 1)) ||
+		    eloc.logicalBlockNum >= partition_len ||
+		    blocks > partition_len - eloc.logicalBlockNum) {
+			udf_err(sb, "invalid unallocated space table extent (block %u, length %u)\n",
+				eloc.logicalBlockNum, elen);
+			ret = -EFSCORRUPTED;
+			break;
+		}
+		/*
+		 * A chain of allocation extents can lead back to itself, and
+		 * then the walk returns the same extents forever.  Remember a
+		 * position at doubling intervals; a walk that comes back to it
+		 * is in a loop.
+		 */
+		if (epos.block.logicalBlockNum == seen_block.logicalBlockNum &&
+		    epos.block.partitionReferenceNum ==
+				seen_block.partitionReferenceNum &&
+		    epos.offset == seen_offset) {
+			udf_err(sb, "unallocated space table loops back on itself\n");
+			ret = -EFSCORRUPTED;
+			break;
+		}
+		if (++steps == period) {
+			seen_block = epos.block;
+			seen_offset = epos.offset;
+			steps = 0;
+			period <<= 1;
+		}
+		if (fatal_signal_pending(current)) {
+			udf_err(sb, "interrupted while checking the unallocated space table\n");
+			ret = -EINTR;
+			break;
+		}
+		cond_resched();
+	}
+	brelse(epos.bh);
+	return ret;
+}
+
 static int udf_fill_partdesc_info(struct super_block *sb,
 		struct partitionDesc *p, int p_index)
 {
@@ -1166,6 +1233,16 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 				  p_index);
 			return PTR_ERR(inode);
 		}
+		err = udf_check_unalloc_table(sb, inode, map->s_partition_len);
+		if (err) {
+			iput(inode);
+			if (err == -EINTR)
+				return err;
+			if (!sb_rdonly(sb))
+				return -EACCES;
+			UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
+			return 0;
+		}
 		map->s_uspace.s_table = inode;
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_TABLE;
 		udf_debug("unallocSpaceTable (part %d) @ %llu\n",
@@ -2243,8 +2320,9 @@ static int udf_fill_super(struct super_block *sb, struct fs_context *fc)
 				/*
 				 * EACCES is special - we want to propagate to
 				 * upper layers that we cannot handle RW mount.
+				 * EINTR means that a fatal signal is pending.
 				 */
-				if (ret == -EACCES)
+				if (ret == -EACCES || ret == -EINTR)
 					break;
 			} else
 				break;
-- 
2.53.0




