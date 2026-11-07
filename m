Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049389;
	b=cTUCk/4HvjFUn9uu1ABTrScG8sAOiLDG0OtCStNIp+QM9N3UOeSquXwbLZdxN2e7K8fd
	 Mv08pMAn1civ+BsLnDWh4dxpYSakddkvW4u0p7KV2DsZO9VK3p9/PbnxKSZMLZAQxggBh
	 UayYLQCIVEZxPIX/CWl3GO6qFmvdXKc3PD7RJD/ZAY1KQi0lLraUhrE47IUr9GUySwgzD
	 x4KJm1Rc9KzF9BOMIqkvljVjEM4GHiLY1xtaB2GT1SBNtzORalP278f5w3XJafzOuEUHA
	 yWmeaz0HNQMSgxYsJOGZV6JEb5GiM1wItp7/CMamxcTZ1BQPzy59qV12ol+aCBwOoSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6/LITg6FREJMkPxebl1ejMbuhVVbsryqhXhCJpVPrio=;
	b=I+Sgwnni4Ecgo6Wmxg/wfHxuOgeWuSVO1aD1ATsJbxxgNejPlYhAAzqYeCeTea3Akou9
	 EUlU8w08fE+viDN2/IKqDyWWWeH+Euk09jODqDRroG7FYfTyEaaTQ2sY42qT9TkMWHhsa
	 aCACsBl5jC044/c4cacLtWqfxi5pOd4jpQrTNzkoFOj6dqqyiG3gWAQ43TFarPyMcXOo6
	 b/ZOHxj4+gE/rTQTDOmrOQBKjqwd3EiBIl2zPYacZJXpz34JKuI2QBHqVmCAxM520YK8D
	 19my+wcI6ZckymfM8aXCwoHSyiIwanT32R25nWONhCCBiMXjiEgjkgzhUQUolCxRGSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+nCNcJ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BF606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+nCNcJ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6E41F0089F;
	Sat,  7 Nov 2026 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049389;
	bh=6/LITg6FREJMkPxebl1ejMbuhVVbsryqhXhCJpVPrio=;
	h=From:To:Cc:Subject:Date;
	b=J+nCNcJ+Gf8uBwcu62NkmFDeckhZLblXDPuqgVPzL0tA5vReX8v70zPu60b5la1MA
	 FitZcZV5Uygenx1nDiHJp4BckOk6BI7MKib06rQzkmP4DbwqJhQT3tX54rSnXw+Y+l
	 9MstfKoTXQh3ivZvFPCwJEG2TihRe3HWnud/IQMNMOgzCL5QTpASaStYSs+BSDr0HU
	 yejGrjCGmYTCJ4NlEOJ6Wb88gwaPuVMA3a0P/+psMeWdg21CH/YNEmafeNn7pC9WVy
	 uG0OIxC1LjFM6TTac+0I0JPyHK4iuaQGlDtuoeQU7iK5U10nbXn4XADQqVBv76wXTF
	 GByldlUmTOD4w==
From: Sasha Levin <sashal@kernel.org>
To: swinds24@gmail.com,
	jack@suse.cz,
	tytso@mit.edu
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ext4: fix fast commit replay failing on a read-only mount" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:07 -0500
Message-ID: <20261107060307-failed-5.15-e1a881ea4674@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e1a881ea4674876721cab97680d1d8308f90e9a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060307-failed-5.15-e1a881ea4674@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e1a881ea4674876721cab97680d1d8308f90e9a4 Mon Sep 17 00:00:00 2001
From: Hsiu-Hsien Lee <swinds24@gmail.com>
Date: Wed, 12 Aug 2026 12:43:53 +0800
Subject: [PATCH] ext4: fix fast commit replay failing on a read-only mount

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
---
 fs/ext4/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bca0dc87d0b7c..ab243a02a493c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6123,6 +6123,7 @@ static int ext4_load_journal(struct super_block *sb,
 	int err = 0;
 	int really_read_only;
 	int journal_dev_ro;
+	bool enable_write = false;
 
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return -EFSCORRUPTED;
@@ -6179,6 +6180,7 @@ static int ext4_load_journal(struct super_block *sb,
 			}
 			ext4_msg(sb, KERN_INFO, "write access will "
 			       "be enabled during recovery");
+			enable_write = true;
 		}
 	}
 
@@ -6195,7 +6197,19 @@ static int ext4_load_journal(struct super_block *sb,
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




