Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81ED47C0FD
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143300; cv=none; b=AflrkytObCvpSs9lCPFHt6s86MZqrEFhM09AMczorieM8+gRmljE4dtagXCWTmzuT418bWztwPf98z0mpwUL6coHtY1i37IIGJONGkRxO/5ZqTcUkSWes7gTBMh2Aak3bqFjNBbA4HljKxgNKRfCL60LFMDkSpHnxiNRNWexMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143300; c=relaxed/simple;
	bh=jATVXdSR7drPsGyun7txqDokUgxfAAuCezJBJU935HU=;
	h=From:Mime-Version:To:Subject:Date:Cc:Content-Type:Message-Id; b=Hl+tVq8rKg+R5mqm9qUwHe/37mIsg3ZpfUVILg5uw+4SDPF6JlTJSROKy77OBdzPWfz5ToxwcLyDS8Ez2RAD6g6csziQ6PQu6vDgyvGloBd65jesXXNviO6I+91Dc/wujXgcqYe1IdR3Jm49q4PTILEpQ9hlN5DeQVTdQfS5Egw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UaN1YuqR; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UaN1YuqR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792143285; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IzCgEU4IS2MI5o9AIJIF2awMWvZJL8KbhYSWjGTWDgo=;
 b=UaN1YuqRF87HnZfdlLHMpdoKC1a9cidH8hsNv4zXM2c2BVuVNciqffMOYbPmtGL76Fp2kx
 03JrmwXGfUSYU3VfXyT9trlNQ2Refy96N7Oh6GylqYs3dW9413gmukcmZUHK3CmEssADco
 pXpnv1CftnD4TjvwIKtOe3utu6xd1aUVO4W6pnVq0aD47MxY8a09y43M/gul84XGdouN09
 GD69RKvOxptxOfKtqcoqsUi1JY/u7egMH6zsWEmQmFqDoljs2Je9C9vZH4XKiKqYgJ3jzt
 EfEY5ZKibzm6410d4a09PIv+FkHNvGdUltLcRFeGVAPVLIpsNOQ6QwoKTIt1Tg==
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
Subject: [PATCH] vfs: keep the mount pinned while waiting for a parent delegation break
Date: Fri, 16 Oct 2026 17:34:21 +0800
X-Lms-Return-Path: <lba+26ad1efb3+343adc+vger.kernel.org+zhaogongyi@bytedance.com>
Cc: <jack@suse.cz>, <jlayton@kernel.org>, <cel@kernel.org>, 
	<neil@brown.name>, <linux-fsdevel@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20261016093421.90725-1-zhaogongyi@bytedance.com>

filename_mknodat(), filename_mkdirat(), filename_symlinkat() and
filename_rmdir() can call break_deleg_wait() on a delegated parent
directory after dropping the struct path that pins the mount.
try_break_deleg() only takes an inode reference, and an inode reference
does not keep the superblock active.

After a lazy unmount, closing the delegation holder can both wake the
waiter and drop the detached mount's last reference:

  Thread A (symlinkat)              Thread B (close delegation fd)
  try_break_deleg(dir): ihold(dir)
  end_creating_path(): path_put()
  break_deleg_wait(): wait
                                   __fput(): break delegation, wake A
                                   drop final mount reference
                                   cleanup_mnt(): shut down superblock
                                   shmem_put_super(): free shmem_sb_info
  iput(dir): shmem_evict_inode()
    use freed shmem_sb_info

generic_shutdown_super() may warn "VFS: Busy inodes after unmount" if
the waiter still holds the inode at the busy-inode check. On tmpfs,
this race was reported as a KASAN use-after-free in shmem_evict_inode(),
called from iput() in break_deleg_wait(), after shmem_put_super() had
freed the filesystem-private state.

Hold a mount reference across break_deleg_wait() in the creation paths,
where end_creating_path() must still drop the dentry and inode locks
before waiting. For filename_rmdir(), move path_put() after the wait so
the existing path reference pins the mount. This matches the other
break_deleg_wait() callers (unlink, link, rename, setattr, xattr, ACL
and O_CREAT open), which already wait with a path or file reference held.

With this change, a non-detached unmount racing with one of these waiters
can observe the mount as busy until the delegation break completes or
times out.

Fixes: e12d203b8c88 ("vfs: allow mkdir to wait for delegation break on parent")
Fixes: 4fa76319cd0c ("vfs: allow rmdir to wait for delegation break on parent")
Fixes: c826229c6a82 ("vfs: make vfs_create break delegations on parent directory")
Fixes: e8960c1b2ee9 ("vfs: make vfs_mknod break delegations on parent directory")
Fixes: 92bf53577f01 ("vfs: make vfs_symlink break delegations on parent dir")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Validation used arm64 KVM and syzkaller (procs=6, repeat=0). Both
kernels were based on af32da41b032 and used the same .config, compiler
and guest image. Both included the same local arm64 MPAM compatibility
change; their functional source difference was the fix in this patch.
The submission base is v7.3-rc7; the affected code is unchanged there.

The unpatched Image SHA-256 starts with 10e1bbf908bc; this is an image
hash, not a different source revision. The rebuilt patched Image
SHA-256 is:
  d39ac23fcc4c21bd1c7e9d9f2b79fa50f288e798abbd9363d80ca311cbd3b5ab
It contains the current mnt declaration placement. All patched results
below refer to this rebuilt namei-only fix, not the separate s_active
implementation or the earlier 2acfbb234ceb Image.

  mkdirat, original dd7c3373 reproducer:
    The original unpatched run crashed (1/1). The rebuilt patched
    kernel completed 2/2 runs of 300 seconds each, reporting 2028 and
    2070 executed programs, without warnings.

  symlinkat, original a203e0af reproducer:
    The original unpatched run crashed in shmem_evict_inode() (1/1).
    The rebuilt patched kernel completed 2/2 runs of 300 seconds each,
    reporting 2028 and 2070 executed programs, without warnings.

  mknodat, targeted S_IFREG and S_IFIFO reproducers:
    The original unpatched kernel crashed in 2/2 runs for each variant.
    The rebuilt patched kernel completed 2/2 runs of 600 seconds for
    each variant: S_IFREG reported 4163 and 4126 executed programs;
    S_IFIFO reported 4129 and 4164. No kernel warnings were observed.

  rmdir, targeted unlinkat(AT_REMOVEDIR) reproducer:
    The original unpatched kernel crashed in 2/2 runs. The rebuilt
    patched kernel completed 2/2 runs of 600 seconds each, reporting
    4174 and 4163 executed programs, without warnings.

The unpatched results are from the earlier baseline runs, not new
runs performed alongside the rebuilt Image. Each new patched run
completed its requested duration, left the guest responsive, and had
no Busy inodes, KASAN, WARNING, BUG or panic messages in its console.

For the patched mknodat and rmdir runs, sampling selected threads with
a break_lease wait channel and read /proc/<tid>/stack to identify
filename_mknodat() or filename_rmdir(). Together with the blocking
wait channel, this confirms delegation-wait coverage, not that unmount
occurred during each sampled wait. Merely entering __break_lease()
would not prove waiting: try_break_deleg() also calls it nonblocking.

A standalone C reproducer for the symlinkat sequence is below.
Run it as root, or with CAP_SYS_ADMIN for the mount operations and
ownership of the delegated directory. The program does not create a
user namespace; unprivileged user-namespace execution was not tested.

  gcc -O2 -pthread deleg_umount_repro.c -o deleg_umount_repro
  ./deleg_umount_repro

Its exit status only reports whether the user-space sequence completed;
check dmesg and runtime sampling separately for kernel warnings and
delegation-break coverage.

    // Standalone reproducer for the symlinkat delegation-break sequence:
    // On an unpatched kernel, the operation drops its mount reference
    // before waiting. The last mount reference then goes away and tmpfs
    // is torn down.
    #define _GNU_SOURCE
    #include <errno.h>
    #include <fcntl.h>
    #include <pthread.h>
    #include <sched.h>
    #include <signal.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/mount.h>
    #include <sys/stat.h>
    #include <unistd.h>

    #ifndef F_SETDELEG
    #define F_SETDELEG (1024 + 16)
    #endif

    struct delegation {
            uint32_t d_flags;
            uint16_t d_type;
            uint16_t __pad;
    };

    static int dfd = -1;
    static volatile int waiter_ret = 1, waiter_errno;
    static volatile int waiter_called, waiter_setup_errno;

    static int pin_cpu0(void)
    {
            cpu_set_t set;

            CPU_ZERO(&set);
            CPU_SET(0, &set);
            if (sched_setaffinity(0, sizeof(set), &set)) {
                    int ret = errno;

                    perror("sched_setaffinity");
                    return ret;
            }
            return 0;
    }

    static void *waiter(void *arg)
    {
            struct sched_param sp = { 0 };
            int ret;

            ret = pin_cpu0();
            if (ret) {
                    waiter_setup_errno = ret;
                    return NULL;
            }
            /* Keep the woken waiter from running before umount completes. */
            ret = pthread_setschedparam(pthread_self(), SCHED_IDLE, &sp);
            if (ret) {
                    waiter_setup_errno = ret;
                    errno = ret;
                    perror("pthread_setschedparam");
                    return NULL;
            }
            waiter_called = 1;
            waiter_ret = symlinkat("target", dfd, "lnk");
            waiter_errno = errno;
            return NULL;
    }

    int main(int argc, char **argv)
    {
            const char *dir = "/tmp/deleg-umount";
            struct delegation d = { .d_type = F_RDLCK };
            pthread_t t;
            int ret;
            int fd;

            if (unshare(CLONE_NEWNS) ||
                mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
                    perror("unshare/mount private");
                    return 2;
            }
            mkdir(dir, 0700);
            if (mount("none", dir, "tmpfs", 0, NULL)) {
                    perror("mount tmpfs");
                    return 2;
            }
            dfd = open(dir, O_PATH | O_DIRECTORY);
            fd = open(dir, O_RDONLY | O_DIRECTORY);
            if (dfd < 0 || fd < 0) {
                    perror("open");
                    return 2;
            }
            if (fcntl(fd, F_SETDELEG, &d)) {
                    perror("F_SETDELEG");
                    return 2;
            }
            if (umount2(dir, MNT_DETACH)) {
                    perror("umount2");
                    return 2;
            }

            ret = pin_cpu0();
            if (ret)
                    return 2;
            if (signal(SIGIO, SIG_IGN) == SIG_ERR) {
                    perror("signal");
                    return 2;
            }
            ret = pthread_create(&t, NULL, waiter, NULL);
            if (ret) {
                    errno = ret;
                    perror("pthread_create");
                    return 2;
            }
            sleep(1);

            close(dfd);
            close(fd);

            sleep(2);
            ret = pthread_join(t, NULL);
            if (ret) {
                    errno = ret;
                    perror("pthread_join");
                    return 2;
            }
            if (waiter_setup_errno) {
                    fprintf(stderr, "waiter setup failed: %s\n",
                            strerror(waiter_setup_errno));
                    return 2;
            }
            if (!waiter_called) {
                    fprintf(stderr, "waiter did not call symlinkat\n");
                    return 2;
            }
            printf("symlinkat returned %d errno=%d (%s)\n",
                   waiter_ret, waiter_errno, strerror(waiter_errno));
            return 0;
    }

 fs/namei.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c87c14ee1..de334d045 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5328,6 +5328,7 @@ int filename_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	struct vfsmount *mnt;
 
 	error = may_mknod(mode);
 	if (error)
@@ -5359,9 +5360,11 @@ int filename_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 	}
 out2:
+	mnt = is_delegated(&di) ? mntget(path.mnt) : NULL;
 	end_creating_path(&path, dentry);
-	if (is_delegated(&di)) {
+	if (mnt) {
 		error = break_deleg_wait(&di);
+		mntput(mnt);
 		if (!error)
 			goto retry;
 	}
@@ -5455,6 +5458,7 @@ EXPORT_SYMBOL(vfs_mkdir);
 
 int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 {
+	struct vfsmount *mnt;
 	struct dentry *dentry;
 	struct path path;
 	int error;
@@ -5474,9 +5478,11 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
+	mnt = is_delegated(&delegated_inode) ? mntget(path.mnt) : NULL;
 	end_creating_path(&path, dentry);
-	if (is_delegated(&delegated_inode)) {
+	if (mnt) {
 		error = break_deleg_wait(&delegated_inode);
+		mntput(mnt);
 		if (!error)
 			goto retry;
 	}
@@ -5605,12 +5611,14 @@ int filename_rmdir(int dfd, struct filename *name)
 exit3:
 	mnt_drop_write(path.mnt);
 exit2:
-	path_put(&path);
 	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
-		if (!error)
+		if (!error) {
+			path_put(&path);
 			goto retry;
+		}
 	}
+	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -5830,6 +5838,7 @@ EXPORT_SYMBOL(vfs_symlink);
 int filename_symlinkat(struct filename *from, int newdfd, struct filename *to)
 {
 	int error;
+	struct vfsmount *mnt;
 	struct dentry *dentry;
 	struct path path;
 	unsigned int lookup_flags = 0;
@@ -5847,9 +5856,11 @@ int filename_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				    dentry, from->name, &delegated_inode);
+	mnt = is_delegated(&delegated_inode) ? mntget(path.mnt) : NULL;
 	end_creating_path(&path, dentry);
-	if (is_delegated(&delegated_inode)) {
+	if (mnt) {
 		error = break_deleg_wait(&delegated_inode);
+		mntput(mnt);
 		if (!error)
 			goto retry;
 	}

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.39.5 (Apple Git-154)
