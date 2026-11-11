Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405315;
	b=3wV0ccrzMNfzRK4L2vIlAHVyk9BN4vrsm59hY5T9352U/k34VNlyaQJ49lfOcvbuXdJu
	 4uvO+NUGJxrmNxpBfxq9Y6eyUtiezX9z/ww8bwfEmtuGJT6/0l2r3y2dewj5kMudum7eS
	 Ez8IncIR9zLryJXqsnu0RT0evZBY5fjZvjS22hOAnIpf6tOgX/L4N1Wz3shSYpjDuCOj9
	 H9arxB+xLmKuQXAfF5x5LFuZeafeF5PVlITLyXt4OzBhMuc/yoSoanCDag9MUUADC3Zi3
	 ZoX1ifd1Clopz1J5plXywxtGCCi1kYlG8InVDXlpOt3tdfnJEdGtKfP7H6DZXDq0AzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aigQNnyp2sOEYLazIL8f3/NFKsLaBIOwNdsnfyk3kkw=;
	b=DI0R+yzTXJeh53uIi1zlYG//XpK7sPUfqHuJjq6ZmRUSQl0L2gprgQu1vGxu7wg0lVne
	 8OXNlCAVEcYJO2PaauRrPNa0EE7VGf7PABnhoRj8qW0bI2WYeo8VVoCGX/De2+qW0NNcz
	 HBaHYj8cd703xK3qpi7NMsnSeNzWLhpqeV9+cjVdUFbS3dJoboRN5aLXrBgA6P7aOIEN/
	 R8zygg+diOT3geKIrYQ9YnM2GlEURITgzdc60tukMxDfO1hrBa4+HDq+WLbSU9ehSIIoH
	 tYVuGHYXb0eaFX632OVdOklcsqcIMZsWeAnjBiHDL8UNgZnm2LPx5rMVkstQpBpHsew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuuIzBMH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E26606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuuIzBMH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A206D1F00A05;
	Wed, 11 Nov 2026 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405315;
	bh=aigQNnyp2sOEYLazIL8f3/NFKsLaBIOwNdsnfyk3kkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OuuIzBMH7m4CGwmIMRnXLSyakNshi31i5qEM6H/3OSLnXPAnCK3X0hcNdCe5WoBo7
	 /f6HinYDw6CU1OH2QXZb3GiIN4/324gjDqvYGz4tUAg/HZcefU83AQjwdKOFtm21zO
	 SKShjD4ODqqjmuCoH64AjmBwKLgDgbeYLsoIJjL0hyMucM3xIyzEdMXgY6IqVqhkLA
	 N7uDwE7y5Mq8uTZKHGWBgVP60uEbgyP9og9OrbbE6BQPH0PTk7sZVQ1X5NAfP8N18k
	 OmG7S995wgWEs8DAj13HxlkN0gHktw2c/EDvhhjXMH0jzEyXcsL2jGtFbm+73fwGpU
	 fHcvZ9DLLuXng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hsiu-Hsien Lee <swinds24@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ext4: fix fast commit replay failing on a read-only mount
Date: Wed, 11 Nov 2026 08:55:13 -0500
Message-ID: <20261111135413.2165817-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061949-failed-5.10-e1a881ea4674@kernel.org>
References: <20261107061949-failed-5.10-e1a881ea4674@kernel.org>
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
[ sashal: Adjusted context to preserve the simpler if (save) error-restoration block without upstream's memcmp() check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c1538e61022cb..4846f2ff98ec3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5411,6 +5411,7 @@ static int ext4_load_journal(struct super_block *sb,
 	int err = 0;
 	int really_read_only;
 	int journal_dev_ro;
+	bool enable_write = false;
 
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return -EFSCORRUPTED;
@@ -5467,6 +5468,7 @@ static int ext4_load_journal(struct super_block *sb,
 			}
 			ext4_msg(sb, KERN_INFO, "write access will "
 			       "be enabled during recovery");
+			enable_write = true;
 		}
 	}
 
@@ -5480,7 +5482,19 @@ static int ext4_load_journal(struct super_block *sb,
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
 		if (save)
 			memcpy(((char *) es) + EXT4_S_ERR_START,
 			       save, EXT4_S_ERR_LEN);
-- 
2.53.0

