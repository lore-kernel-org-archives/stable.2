Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404389;
	b=LT16rPos4BDoFk0AQzzIKOYnk9qWesqcBXQ+N0dBoEK6AaNmmsOjuayW/J899MNH0hYG
	 Hsl3UDANGeVXyvMH3OSJG0kfr28XkG5N9FbXySkwSs7SUd6nNyGcxtd1SEbD2Egr4y0JS
	 uB9I9nUiunPBsP/fT144ZKOULXlTl7WxhiS/MGMgS0eDJUHU343L8r4WHXH0HpYMfK915
	 QbAaYToRJ3+qgDhGyq5VTzyKyTDrM5uO85C/5E/pi7CylTuZ6Oqo3z4lQu6vIYIhyGgT2
	 B/utX9FYRYSvLUYl7Revht6YCwTdxxfr/oa49+BaSyhQ2IPuGQqBYtX9w8OKg25jbBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A5DmeS2+BPAwHNHAnFN+zzC8nswMO/spzsVIeUXnwl0=;
	b=k0lZrWQbgS8uiGwwel2uA4DyR1H34G+a+CWibc5LPi5nB8nPFar15qZSN7HREsVxT907
	 r+j9jZaKPuz/swuJiCjh0zMqyEn5ghap3bLiJdlJzzhh3LNLGW3f3Z+CSDqfNsYzExu24
	 Sf36WmRM1W0sI1dLslIrIXOxJBQkC7csDha1Bh//bcTQuFmjfKaGPlpa9BYLLpahlEedI
	 PMzPkmZnXYH/Bye/oDl6awsB+V6AhKwfXITT9kxkbckGzkcDvox8Ix/ixjgiXji1XCFwd
	 giq4jYHHJSUIdNK9mfuJQNPxtucnRuuDRrfBNwUQ24lo9iIZohlTjimkabUZw6z5zqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzqs+M1j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C6606A33B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzqs+M1j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3B71F00A07;
	Wed, 11 Nov 2026 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404389;
	bh=A5DmeS2+BPAwHNHAnFN+zzC8nswMO/spzsVIeUXnwl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzqs+M1jNiumWzOkAGMOiuZZfKczWe2HfB7+V8YfpE12fNGtFBGE9Qy4/wHDw+kob
	 Pq7ujG4ZlgBM2WtWgivALRnbIY4Y18P+7ack/7vPc65CsMF4kzxY0a0R2QqCliHP81
	 giMx1xRlXrTWoM6EFxJChIz14f7xPZLguvtz0e1LVtIkgo+Gq9wSMtBJ/EQ7VLROu3
	 8I5cyAWupxvzVRfaHHp2MCHbSHxahXEvnDXV1572cpvQV61CJruNj5d0q3Jf2Pi5Ca
	 qKmeG/m41ibTwZ31w913LOUyAPZpZVduNTVWtuej+bV8DClbXpYlngTVtRZLiuob2T
	 f4A5VDSkp+zDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hsiu-Hsien Lee <swinds24@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] ext4: fix fast commit replay failing on a read-only mount
Date: Wed, 11 Nov 2026 08:39:45 -0500
Message-ID: <20261111133858.1650548-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111133858.1650548-1-sashal@kernel.org>
References: <20261107054548-failed-6.1-e1a881ea4674@kernel.org>
 <20261111133858.1650548-1-sashal@kernel.org>
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

From: Hsiu-Hsien Lee <swinds24@gmail.com>

[ Upstream commit e1a881ea4674876721cab97680d1d8308f90e9a4 ]

A filesystem with fast_commit that needs recovery cannot be mounted
read-only:

  EXT4-fs (dm-0): INFO: recovery required on readonly filesystem
  EXT4-fs (dm-0): write access will be enabled during recovery
  WARNING: CPU: 22 PID: 5544 at fs/ext4/ext4_jbd2.c:73
   ext4_journal_check_start
   __ext4_journal_start_sb
   __ext4_unlink
   ext4_fc_replay
   do_one_pass
   jbd2_journal_recover
   jbd2_journal_load
   __ext4_fill_super
  JBD2: journal recovery failed
  EXT4-fs (dm-0): error loading journal

Fast commit replay runs ext4 metadata operations instead of writing
blocks through the buffer cache: ext4_fc_replay_{unlink,link,create}()
reach __ext4_unlink() and __ext4_link(), which start a handle.
ext4_journal_check_start() returns -EROFS on a read-only sb, and as
that is not -ENOENT it propagates out of jbd2_journal_recover() and
kills the whole recovery.  The EXT4_FC_REPLAY check that would hand
out a no-journal handle sits after the sb_rdonly() test, so replay can
never complete read-only.

ext4_load_journal() has already promised that write access will be
enabled during recovery, so make that true for the superblock as well:
clear SB_RDONLY across jbd2_journal_load() when recovery is needed on a
read-only mount and the devices are writable, as ext4_orphan_cleanup()
does.  Unlike ext4_handle_error(), which avoids SB_RDONLY because it
would need s_umount, the sb here is still inside ext4_fill_super() and
not published, so nothing can observe it.

The failure is not clean either: the replay handlers passing a NULL
handle (ext4_fc_replay_inode(), _add_range(), _del_range()) never hit
ext4_journal_check_start() and do write, leaving a partially applied
fast commit behind.

Reproducer, where the unlink only ever reaches the fast commit area:

  mke2fs -q -F -t ext4 -O fast_commit -b 4096 /dev/sdb3 262144
  mount /dev/sdb3 /mnt
  dd if=/dev/zero of=/mnt/victim bs=4k count=1 conv=fsync
  sync                          # victim now in a full commit
  rm /mnt/victim
  dd if=/dev/zero of=/mnt/trigger bs=4k count=1 conv=fsync
  <crash, or snapshot the device while mounted and write it back>
  mount -o ro /dev/sdb3 /mnt

Without this patch that mount fails; with it recovery completes and
victim is gone, i.e. the UNLINK record was really replayed.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Cc: stable@vger.kernel.org
Signed-off-by: Hsiu-Hsien Lee <swinds24@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260812044353.1018268-1-swinds24@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index acaaa0218f22d..64a7d7beadf21 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5939,6 +5939,7 @@ static int ext4_load_journal(struct super_block *sb,
 	int err = 0;
 	int really_read_only;
 	int journal_dev_ro;
+	bool enable_write = false;
 
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return -EFSCORRUPTED;
@@ -5995,6 +5996,7 @@ static int ext4_load_journal(struct super_block *sb,
 			}
 			ext4_msg(sb, KERN_INFO, "write access will "
 			       "be enabled during recovery");
+			enable_write = true;
 		}
 	}
 
@@ -6011,7 +6013,19 @@ static int ext4_load_journal(struct super_block *sb,
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
+		/*
+		 * Fast commit replay performs regular ext4 metadata updates
+		 * (see ext4_fc_replay()) which refuse to run on a read-only
+		 * superblock.  We promised write access above, so make that
+		 * true for the duration of the recovery, the same way
+		 * ext4_orphan_cleanup() does.  The superblock is not published
+		 * yet, so nothing can observe the transient state.
+		 */
+		if (enable_write)
+			sb->s_flags &= ~SB_RDONLY;
 		err = jbd2_journal_load(journal);
+		if (enable_write)
+			sb->s_flags |= SB_RDONLY;
 		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
 				   save, EXT4_S_ERR_LEN)) {
 			memcpy(((char *) es) + EXT4_S_ERR_START,
-- 
2.53.0

