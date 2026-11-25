Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624813;
	b=D38PkjZiWrfmRHSha9uTfzcbKXiGyPom9TMULrHZkUPpo84J8ErYs6BK5ZvWXmSiMG35
	 ZV20n823tauyunkofhgBkeOZ07TGnwbWTiOBS5RCDyNBCqajO2OYr4IoBL57y09w1gruc
	 qyct7KhamgvzhnIuNTx9tSfVNo15XeUhGRiDgrrmvAedq/hraxqU6FWXHgbLI52l4uWjV
	 T5knaBRvMWoVXJoLDl2qhzgZ30lk2zZXs9y3QxacVhjIXdhWzfCz45fbgMPltGTCZ7JQd
	 ePTc4RB/TzeNGZlijFl9K5Yl+aMYOaubxjO4iKKWADfutCBb/2i2XIt/LquOcovBo2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+ee9oFd+AV92Zn1TwZ7BemweEx9+HC4RCU3AsWOO+KE=;
	b=d59xw4nzWXahipDbAuuIpWqVZTZw66ZCLrxLYn99gQrMRk6OHO4MV4QYiLDcNUl6qHyd
	 aZzcnOrTNOufare2IduBnKV3WrOFYahCFi/Efq0DHkV/7ea7nbbrlea4u4SqKFu34Tnsi
	 L2HNhqVezTdSl3qf1uq6ki3ghJyiVnf1eg4hTJK/OyNrtXZKk8NqRizQtzlwXHDYr3JW5
	 aINs5LVJdpUazlHQKx8c3LTeOFG9NLr1MQVrF9GfiGjOnHwKCLt2Me4sdzrdIKpFpqDy6
	 Gre85uluV0X0DQNI04wMMBB4X+Yfej+ShAOpqbWFWgtbQaxQfBzoGVP80qEc0LySMYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8EObDxj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF5606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8EObDxj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D1A1F000E0;
	Wed, 25 Nov 2026 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624813;
	bh=+ee9oFd+AV92Zn1TwZ7BemweEx9+HC4RCU3AsWOO+KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8EObDxj6q5NJaiAQLfivg8om/KRYajspvYezyUKNPKNk1KEJIeo8wvPoG3d6XC0A
	 rziZjdNPjKTrO6OkKY2KTDnFQr/rBV+2/0Vg7kclENfRMGIY83+wVmgtZf3DAMS+Me
	 n/uw/NOdhcNutZ+bJl6mAHHyyuVLTG6s81fz8BdCICpoqJRSc6PgLfxE7NFpvigmNS
	 8IM0J9AqLXv/dlCUwjIDN0XBmaRzkmxlkepCdcHYVFVuJpQRTxucQgLINT5HFUdUcy
	 BgVJqMoLUhDs2FEf36rTGSOzOpWdDu9QWTgOuj8h2PPpYkZ/ANyCE+UF6uQECN8M4s
	 YSZORodWx+yaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] fs: set I_METADATA_WRITEBACK in mmb_mark_buffer_dirty()
Date: Wed, 25 Nov 2026 11:40:09 -0500
Message-ID: <20261125163943.826475-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125163943.826475-1-sashal@kernel.org>
References: <2026112543-dipped-sultry-a7a2@gregkh>
 <20261125163943.826475-1-sashal@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit d4fdde3257a577f184b4498d040f6fe20be72326 ]

ext2, ext4 without a journal, fat, udf and minix track the metadata
buffers of an inode in a mapping_metadata_bhs list and sync them from
->sync_inode_metadata() and ->evict_inode(). The inode block itself is
only tracked by I_METADATA_WRITEBACK which ->write_inode() sets after
copying the inode into its buffer.

Set the bit in mmb_mark_buffer_dirty() as well so that it covers all
the metadata an inode may still have to write out. Set it after the
buffer is on the list. An fsync() that sees the bit then also finds the
buffer when it walks the list, and one that cleared the bit before we
set it leaves it set for the next one.

The inode itself may never have been dirtied. fat for example tracks
the FAT buffers on a private inode that nothing marks dirty. So attach
the inode to a wb before setting the bit, the way ext4_mark_iloc_dirty()
does, or writeback_single_inode() has no wb to lock once evict() syncs
it.

That lets evict() write out everything the bit tracks in one place
instead of every ->evict_inode() calling mmb_sync() itself.

Suggested-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org # v7.3
Link: https://patch.msgid.link/20261109-work-inode-metadata_writeback-v3-8-91ac6c024018@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 30e7f2cc2386f..3f430fb824500 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -623,12 +623,15 @@ void write_boundary_block(struct block_device *bdev,
  * @bh: The buffer to mark dirty.
  * @mmb: The list of buffers to add the buffer to.
  *
- * Mark the buffer dirty and add it to the list if it is not already on
- * a list.
+ * Mark the buffer dirty, add it to the list if it is not already on a list
+ * and set I_METADATA_WRITEBACK on the inode so that fsync() and eviction
+ * write it out.
  */
 void mmb_mark_buffer_dirty(struct buffer_head *bh,
 			   struct mapping_metadata_bhs *mmb)
 {
+	struct inode *inode = mmb->mapping->host;
+
 	mark_buffer_dirty(bh);
 	if (!bh->b_mmb) {
 		spin_lock(&mmb->lock);
@@ -643,6 +646,15 @@ void mmb_mark_buffer_dirty(struct buffer_head *bh,
 		list_move_tail(&bh->b_assoc_buffers, &mmb->list);
 		spin_unlock(&mmb->lock);
 	}
+	/*
+	 * The inode itself may never have been dirtied, so attach it to a wb
+	 * before setting the bit or writeback_single_inode() has nothing to
+	 * lock when evict() syncs it.
+	 */
+	spin_lock(&inode->i_lock);
+	inode_attach_wb(inode, NULL);
+	inode_state_set(inode, I_METADATA_WRITEBACK);
+	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(mmb_mark_buffer_dirty);
 
-- 
2.53.0

