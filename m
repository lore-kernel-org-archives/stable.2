Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776975;
	b=3QKLh4kfVRY9IevQ9gmFS38RsMhjILz8JCueH/YW9w+Em9arWO2a46jLLjlWOq3wBTcK
	 kbJRR2A/MWSvEXFdHMO2J8/JWmHSUV4jBTIUyCCTQMnOnGaQg0ucCnqmKKVK4lxWMI7AA
	 MOd4BmY9NRJqocs2e2sMO8vS789RgemwuVcXXUNhPuyFN3DQn32NVJkiROqH7MBrYL6yl
	 6PIqzwP6mTQ8QGRsEIRgnpDE/2WMPylAQ+bJY2gIo7XNb24tCKnguL31vO30lG/iT4aum
	 Rhz37Mm+1FgiabDrOhNwvBAxdVXa4oMqZSIY9LNA2C5I2zYYT0uyZ+RhzhMmsSxDeKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4oPbOOVAXn271nhP2YycpBt+iE9P/WvywOYHMnBDwp0=;
	b=qJnJJu3V5mSdgntuYVxB2FYgg+y5Wb7DxMCVIkVk6VdBXLtihY88UMyQbfcYTYW1qqhL
	 R8x7fUGq+dhHma8iNuQeYZU2w8+KWyjX84wFXCW4aOWKXdHrtT6UnKPiG3N3MqJ1Y811M
	 BFBuxn3z4BpHhTSzfFpz5dhhHj7ghbJoVJX05TrJSsWFfk+sExvyer/gVItIii3TQrKb0
	 zeU2UEi4TQgYHExZa5r2AfEb3oHqjhKDh8+hfcU/Txx8PcxwhtmYgWdQI0ws0CXnJMIUN
	 6aUgtHU68xt1gjhkyGIZiDD/JG3oPlWIapJWdo3tY7OZC9/Dg2ht1P+x/GXPgq31o7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ob+34Da0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C8606A31C;
	Fri, 27 Nov 2026 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ob+34Da0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5FB1F0089A;
	Fri, 27 Nov 2026 10:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776975;
	bh=4oPbOOVAXn271nhP2YycpBt+iE9P/WvywOYHMnBDwp0=;
	h=From:To:Cc:Subject:Date;
	b=Ob+34Da0d99Fsv2BnaAwkRUkAuesw76TTUC0wV1t0WuZIt+gSPo+MVFKYx6n3ouAs
	 t+jB+HqZWTMEZbWSUO0eu/Fqyj8EdgeOnsqW36J0t73uvvrYJC5gQMOrPJovkgGCyk
	 OWRZ928IZUt0pri3ncjDJ2zDo8pwLZRqLxmoxK1nz1PpLL/qc3Iq8AxA15qali0ViM
	 yM2PKFTBZdKJ3a18T9PlrTnzeuqankZubzN/5NtTlIrOKwhnHlBp66qp1iHTia5QlP
	 abN+YxWCq+RLECnXWe+4ue3pm3UHPyL9nj+BRFgP3m81ZU3+Sj03n0qqW9WfPzHrTM
	 Lpc6Ta8porAdg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/7] f2fs: fix to persist i_size extended inside last block for fsync
Date: Fri, 27 Nov 2026 10:56:08 +0000
Message-ID: <20261127105608.537148-8-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

From: Chao Yu <chao@kernel.org>

generic/737 fails on 16k block size f2fs, after writing a 1M file w/
O_SYNC buffered or direct IO and shutdown, the file size is 0xff000
rather than 0x100000, i.e. the last fsynced 4k data is lost.

It can be reproduced as below w/ 16k block size:

xfs_io -fs -c "pwrite -S 0x5a 0 32k" /mnt/f2fs/file
xfs_io -x -c "shutdown" /mnt/f2fs
umount /mnt/f2fs; mount /dev/vdd /mnt/f2fs
stat -c %s /mnt/f2fs/file
28672

xfs_io writes 4k per pwrite() and fsyncs it, the 16k-sized 4k unaligned
direct IO falls back to buffered IO as well:

- pwrite [16k, 20k): allocates the block, last_disk_size = 32k (end of
  the page) after writeback, i_size (20k) is unaligned, so fsync writes
  the inode and its dnode w/ fsync mark
- pwrite [20k, 24k), [24k, 28k): in-place update of the block, i_size is
  unaligned, fsync writes the inode w/ i_size = 28k
- pwrite [28k, 32k): in-place update of the block, f2fs_i_size_write()
  sets FI_AUTO_RECOVER as the inode was clean; i_size (32k) is aligned
  and equals last_disk_size, so f2fs_skip_inode_update() returns true,
  and nothing is written for fsync since the in-place update doesn't
  dirty the dnode

After shutdown, roll-forward recovery restores i_size = 28k from the
last fsynced inode, and do_recover_data() only extends i_size to the end
of a recovered block when i_size doesn't exceed the block's start
(28k > 16k), so i_size stays at 28k, losing the fsynced 4k data.

FI_AUTO_RECOVER means that the dirtied inode can be recovered from data
blocks via roll-forward recovery, it's not true when i_size is extended
inside the old last block, let's clear FI_AUTO_RECOVER in that case, so
that fsync will write the inode. It happens w/ 4k block size as well,
e.g. w/ 1k O_SYNC appends.

Cc: stable@vger.kernel.org
Fixes: 26de9b117130 ("f2fs: avoid unnecessary updating inode during fsync")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch.

 fs/f2fs/f2fs.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 882ff2617531..d35149191625 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3728,8 +3728,9 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 {
 	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
 	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
+	loff_t old_size = i_size_read(inode);
 
-	if (i_size_read(inode) == i_size)
+	if (old_size == i_size)
 		return;
 
 	i_size_write(inode, i_size);
@@ -3738,7 +3739,18 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	f2fs_mark_inode_dirty_sync(inode, true);
-	if (clean || recover)
+
+	/*
+	 * Roll-forward recovery only extends i_size to the end of a recovered
+	 * block if i_size doesn't exceed that block's start, so it can't
+	 * recover an extension inside the old last block, e.g. an O_SYNC 4k
+	 * append filling up a 16k block, which is an in-place update of an
+	 * already allocated block. Let fsync write the inode for it.
+	 */
+	if (i_size > old_size &&
+	    old_size > round_down(i_size - 1, i_blocksize(inode)))
+		clear_inode_flag(inode, FI_AUTO_RECOVER);
+	else if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
 

base-commit: 9ad6c58bfbe5882b1aa0cbe2393dbfca89d2c199
-- 
2.49.0

