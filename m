Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351735;
	b=aCAKZVwGARwAT7/4UsnyQl1Git6hRwuoSgU6qtqUvPF2zqouHZQDoPfkWOJfqmcIyaAW
	 Scfffl3ed/8nP0qOwDu2dHSUXWFLVXWPaoHkKgwHBNzATD3f4Mph1wtJpPGny4ghLZ212
	 7x0jnLNTr7YwDUoFkkhUJmZMyWqbEHHbUO/dYRZbfTa04NGxiOSxPCFNX5K0d0mRQtvB0
	 uzIH5pm2scMdwfntKvSdnzMijl+qqp0nKfQTupRw7hFa+Buv2TdeNwqu9WTYl3+3zBk4M
	 ru/+p5RuQwpLwUqIqReBhg8y3R1/UINCjQIVvYz/vkk6GJjn/qMiEJdrDpy3shZ24dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b0Pwj0msTdPhzaKN21Jqub3HQ2ivQUi/T4qOGcLK2DU=;
	b=bseL4edFIA9SwMvIQ19W93wZhbanBeRlFb71HLpUo6HoFRU9QSDkJZosB9X8Hq8mqDng
	 7fg9TWjkkrpv0EbPQiDjIDKvptT73X9id4OksKz4piDsLLHYQKVEA4CJukBNFG8jrbySF
	 YRvQq0rE9qI5K+xLaLzpjb6W3jGfC1sQB6ESaKgi4trV0c5qdfMBykiiA+qVaDC6X6//U
	 WyTd6mDq8oWWdixM2a09H53g07chw9x5h63VJnDI0d89JucMt17KI5Wn6i69MwaSfvy/P
	 Y8Q3z/Nhh30k/a/q8hAGS0Bhuj2Jy1y1JEHWfrBSbz20c9kIAKngFNmJGPhSguvvXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=X5PeiCq0;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480F606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8480F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=X5PeiCq0
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917a707f37eso6179216d6.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793351733; x=1793956533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b0Pwj0msTdPhzaKN21Jqub3HQ2ivQUi/T4qOGcLK2DU=;
        b=X5PeiCq08Px6Q2+gm0+cSznJRnrCGOpR++9gKoLmSM+tL29IdcDig5qzwmoLEFmm+k
         GHMcu/VFbaEG/rYJH0pGVGQvbwzwiT/nQPiknHJn1jf5nC7LNZ1NPocpsqU0hhpi0ybL
         CkzP8QK0gNMfTq1qbtMZxK+J5TOlfWhKnfOvBMQY4s4vog57988wktVIXB1AX0KdcGNe
         yXlQ2/ldDHjYIfvXZQJWRxhxu332Szpu1Ka+LnWyE+2psHPUPkWdYJQ0p3xLhyQQZc8r
         RFJZas+sgvLKWzXdYOplUUkS+pXqtDYV6mRupSXrkWZrVzsnxDWD9uVDz5Tk6scB8JHy
         P8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351733; x=1793956533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b0Pwj0msTdPhzaKN21Jqub3HQ2ivQUi/T4qOGcLK2DU=;
        b=MN5Cedt26rexERf9YIqoZCbwNfGkYclcQ3pthOvpUZM67Cp2ekp440jioSlzThMWYn
         8T14JngGzfCUS/O391IGeYwnJ3nbjcjBeKUQUhFdXIlPW3GBhIAsYf6rEv1D12yzF6sX
         hpb4e7jrEe2nJQfkeZxX2I418V3+Uho8GK7nucXeGiOGPc3Rp9zM/KuKi1/FfVmupYkz
         4n+IX21iPZnd9KQGqfJtd5iKiS5cey1jhur7X6KiSwFbXRGhubmYZmxzSJ1nGvb/syM4
         2T38Iub2cY6pvqNVtOdWHA5eKo4ce6iuVB8tFvsTrZYKrg9okqbVNqJIEuH8sAzw4gcH
         dSgg==
X-Forwarded-Encrypted: i=1; AKwUvBzxjAOE9nFdaYbYsjHLmjZczdQUsMk7uVqCclA/4chzfdsKB/ZP9l3FZWZaj7XyjeSnUU9tVVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnWXtWafglTTpWuguGnPBoPuSJKTHxMcTu+lDbgbjbPhXCd2x9
	vNVuVl6T2hKlZ7wZvUbfDoJaACg8rCJND6XXM1mbja4pYYYZqAD452Ug9F7KetuO5w==
X-Gm-Gg: AYBFou2UOpSOln4J4wgg1gGBPEh3kLtG2vWrLlhYId/2jwOGbhmZaKRCRTqNGSJmJYf
	uLVV7fqz3d1RLYjkJobgsVYScsIB1gj2Pp195qAWIOwKTuHc2bKjtzwqqrt5dS73y/VHBZgMC+C
	K4nGWQUTa3hGNSZxlIxeKjZjJvA6lPBkNXOK/tt9xEf0kAnbHEK/WfNDa8+8wOCYEFZRcw7X1Pi
	vNWwxcTFBxJjasky3e3mT7cZKtIwDCDL7ci/yatHarJs67arOcj/DQQcqe4E6Y+7iLdqN8287cK
	IBkqbIIz3LCLgSYoJgs3MJ8nmHNiS0ob/pOhGZ56/Kwhih8RmTpV/Y3+17CzQ/0fIIJx7ATR5pz
	2vFgz9eylmfsPpKi3VsGJVyRqkM16r/Z676RysXqPwnhSeK5qmEHn8vRzum5jlANeSQr7+kimjq
	IZkmDOG2tPmnraS838rAHGdzZZr3zfqpDpH1cjWpoChlEY/DLrWiKKoFEQ9gR8GxrDXOWlSteVu
	H7RY1U6QByUrO2nTEXUFkQc9ranzawwg/KMeobdzmEc0mrAjLL77rh2RpgU4QwGZxpxLWJgFzII
	9muOhdi96dHD4qLD4+/Wu62sn4hkSkKo2+qCOTOgaN2P90CVgxii
X-Received: by 2002:ad4:5cab:0:b0:919:5a24:d77c with SMTP id 6a1803df08f44-91ca4b2a557mr24211986d6.31.1793351733042;
        Fri, 30 Oct 2026 02:15:33 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f4767asm10428406d6.21.2026.10.30.02.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:15:30 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: viro@zeniv.linux.org.uk,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: don't fail namespace operations on dirsync checkpoint errors
Date: Fri, 30 Oct 2026 05:15:24 -0400
Message-ID: <20261030091524.292463-1-hengyul@cs.unc.edu>
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
Content-Transfer-Encoding: 8bit

Commit dafb84f092a6 ("f2fs: fix to propagate error from f2fs_sync_fs()")
made create, link, unlink, symlink, mkdir, mknod and rename return the
result of the checkpoint for a dirsync directory. That checkpoint runs
after the directory has changed, but the VFS takes an error to mean that
nothing happened and skips d_move(), d_delete() and S_DEAD. The dcache no
longer matches the directory.

For example, on a filesystem mounted with -o dirsync whose device was then
set read-only with BLKROSET, rename() fails with EROFS while readdir lists
only the new name and stat() only finds the old one. After a failed
rmdir(), stat() still finds the directory with no links, and a create
inside it fails with EROFS but leaves the file there. Once the device is
writable again, these "failed" changes reach the disk. A write error during
the checkpoint causes the same mismatch with EIO.

As commit 24c1a47f1ed2 ("f2fs: don't leave the hashed inode while it's
unlinked") notes for symlink, the final flush or checkpoint is not a reason
to roll back the operation. Ignore its result again in these paths. Errors
from before the directory changes are still returned, syncfs() still
reports the checkpoint failure, and the remount change from the same commit
is kept.

Fixes: dafb84f092a6 ("f2fs: fix to propagate error from f2fs_sync_fs()")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
With this patch a dirsync operation can return 0 although its checkpoint
failed, as before v7.3. In the write error test below the change is not on
disk after a remount, so the EIO was accurate about durability, but the VFS
cannot represent "changed but not durable". The filesystem has stopped by
then: later creates get EIO and syncfs() reports it.

Tested on x86-64 KVM with KASAN, f2fs dev 83f32c773255 with and without
this patch:
- 14 namespace operations (all eight callbacks plus rmdir, overwrite,
  cross-directory rename and whiteout) with -o sync, -o dirsync and
  FS_DIRSYNC_FL on a read-only device: EROFS and stat/readdir disagree
  before, success and they agree after. Remounted contents match on both.
  No change without dirsync or on a writable device.
- dm error target under -o sync, nine operations: EIO and the same mismatch
  before, 0 and no mismatch after.
- ENOTEMPTY, EEXIST, ENOENT and injected ENOSPC are still returned, with
  the namespace intact.
- fsck.f2fs --dry-run exits 0 on all images.

xfstests were not run; without a failing checkpoint the only difference is
ignoring a zero return.

 fs/f2fs/namei.c | 46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ce5d536d892b..9b127b38b6c6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -402,11 +402,8 @@ static int f2fs_create(const struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -458,11 +455,8 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	d_instantiate(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out:
 	clear_inode_flag(inode, FI_INC_LINK);
@@ -642,7 +636,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		d_invalidate(dentry);
 
 	if (IS_DIRSYNC(dir))
-		err = f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
+		f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
 out:
 	trace_f2fs_unlink_exit(d_inode(dentry), err);
 	return err;
@@ -730,7 +724,7 @@ static int f2fs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0,
 					   disk_link.len - 1);
 	if (!ret && IS_DIRSYNC(dir))
-		err = f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 out:
@@ -787,11 +781,8 @@ static struct dentry *f2fs_mkdir(const struct mnt_idmap *idmap, struct inode *di
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return ERR_PTR(err);
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 	return NULL;
@@ -845,11 +836,8 @@ static int f2fs_mknod(const struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -1149,11 +1137,8 @@ static int f2fs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 
 	f2fs_unlock_op(sbi, &lc);
 
-	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
@@ -1321,11 +1306,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_unlock_op(sbi, &lc);
 
-	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;

base-commit: 83f32c773255720a661aa45d83e36278135f23f5
-- 
2.53.0

