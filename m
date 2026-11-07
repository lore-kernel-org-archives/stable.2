Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048350;
	b=b8X+h7ALnDXoEHH+G6/290b+inrZ2wRMibd6YlgLerQXHOOPB6vbxEysDs+RP6qnaVxg
	 9yL8wCB/xNVSjKO79f2dhqnIlxsRocne5PVTEY4UJjr2INO95wPdMouDqjpdhnHhUEFtN
	 M0rAX3b5dwKLMikaQU/RDLmSLviX3M/c6yMgEmLP44TcMTgODGQYRUqD4AhPQUZtD1y3D
	 swfizNk10lxDbcYZPhz2GKuUz5+W77hSaiZyFJCF5Y3K+2WR0mZ4W4eGb6DhGKv1QKiPG
	 MNbwvkLgZGY+UpybB1a76hUPipXw+Szfl478QUa0mA/ts4actBPuy0xJpAumpZlbt/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xReKY+8ECL7PdscqAugqw6aJHOUzlUR95LTGQmHBMb4=;
	b=pitHszPnT9q5XvmugL25C0SUOGaNDucEWSdZvF6bvZfKlQD1Hs9yANMn8A7UMsYviyzo
	 Pbdu7PMnbKmwCcRomr4USwTaljLUaeBWxSXsPyA5UjZ5FMH4Kswi3KwRAIK5LGzyHXp0y
	 pTMb5j89sF0GatoB311S24nHosfwndGwreELm4sidHhjEgiDdYgwV9WTDvyZEp3ViD3YM
	 tkLLNmIw264KAm0R9QF/1i0PjcGpJVK2puzzaEegKMLfM4gi2w9wBBMfou8e7W2i6PTTJ
	 iajUy2MR8pMwImTHx6TbNlw4mJO3EcmjhQhDNKXgvICLOLNWbLyz6pFT1M12CMERaKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9yrckiP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9yrckiP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FB81F008A1;
	Sat,  7 Nov 2026 10:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048350;
	bh=xReKY+8ECL7PdscqAugqw6aJHOUzlUR95LTGQmHBMb4=;
	h=From:To:Cc:Subject:Date;
	b=Q9yrckiPKpmhJkXWp5+B6TSanQzK2tThBZErOx8T8JsAbMtQXECNbOeM93GfR8rSB
	 l/K4Jn5417mHAxS8H28ZpHfsaWSHR3lclq3yD6PzpIuYMtJky4sepqc8HF3/m+kqDI
	 58E6WuWYi4fuCFgC+KHKSJ7E0uFS4Z+3lI1zEDm3LRbj13K5ZHU9PuLXz6QDLWS6F0
	 0k2Bhp/TPE3dwnM88HA2DISYo99zKz6zG8XriCApuOPZ3maFUAmcG2ql46/CzH0IE4
	 ZWIvvBTFPzJc+QXoqsguvCp6oVUL1D3ue6BM09QXyloCvrxfBu1+8qgWtZy7w9goPy
	 QiFmZtF6nKGlA==
From: Sasha Levin <sashal@kernel.org>
To: swinds24@gmail.com,
	jack@suse.cz,
	tytso@mit.edu
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ext4: fix fast commit replay failing on a read-only mount" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:48 -0500
Message-ID: <20261107054548-failed-6.1-e1a881ea4674@kernel.org>
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
git cherry-pick -x e1a881ea4674876721cab97680d1d8308f90e9a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054548-failed-6.1-e1a881ea4674@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




