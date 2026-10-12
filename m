Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B63603E8;
	Mon, 12 Oct 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810934; cv=none; b=LO4+uQQg1jpyp6PR5Rwf8XMqIyOnS1cuw/nGfGPMZKF+MDxRR9vl8Hd6RT5cSco1gkHyccr+ul+PwjrdACfilKt/RfBGVGMxGzYe7cDNydrUH3xAp5lwYjhHAAETxcrFWUKIxdy4VlaEp2Q1Cg6BZauNz67uvFSvDEXruPnLfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810934; c=relaxed/simple;
	bh=CcsDddioQEspoUqWl6ekwEF4GxlCj9HtGKe+tQ11q8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7U1T/ZvPsfNjTcmhgigRfqnxcIzuQl2vVKum2d7u0V8vNqhFIgV4Odyfi9nIdgIk77HeoeL6fuPiDd0ckwB5y6oq50jkSBo3YOIxzL56NeZR49keVC+B+gT2EltR3chcBqtcFyvKg5ESkG3Cv9caL52thlJ60TMqMHGF5MqUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj1W/RV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj1W/RV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C8F1F0089D;
	Mon, 12 Oct 2026 13:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810933;
	bh=vzdZwBY53hgOXufimVWyYl9byiw4CQca0m0JtaFNqTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lj1W/RV/DovL8ktpchp6gvv12J54qNMjUKkqTmm37779XjXZRq/jdudhFGLZA//Av
	 TZEQ/OELwv5DwYRoMLmO2SWBjJCTa79fwpgjl7i8qSjbmyHQ6DgycCcNCFFDegIrZN
	 0ecmZjZHv121BBAGM8F8YiBC150fo7FU7reqUyZhdDlS2n+cwV+LIbwSZzI3m0bSF0
	 EYW038FWyFWHkg4FOXXEer8fpat1tWJs6exURCvS//CjRDjaXPsztopiM4tkv4nQI1
	 S+t5STVavpd7y/T/IG2JKG+GedTpdRkLsSXOJw49xxwCqNL96o4ce2pBO/NPJ6+cVS
	 ociPFYl375liQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 15:15:18 +0200
Subject: [PATCH 4/4] namei: don't follow a symlink that lost its mounts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-namei-reval-v1-4-515664de33b5@kernel.org>
References: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
In-Reply-To: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Neil Brown <neil@brown.name>, 
 Jan Kara <jack@suse.cz>, fuse-devel@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11838; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CcsDddioQEspoUqWl6ekwEF4GxlCj9HtGKe+tQ11q8w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSduZvea6Erlr/T7q2dYk3AEY6Tafo5748YKkdcSlv/z
 Kln0fPkjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMOMnI0J5Up3LylTDDWlee
 a5+cJ/ZUud6ddtZ24uE+6U0s76ROfWNkONaQtGvK5jCHy+3vfOYcX3ng1Y78FSlGBSZtx7uyeZt
 +sgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

unlink_may_reveal() is only called for a dentry that the walk steps
onto. A symlink that the walk follows goes to pick_link() without that
check. But a symlink can be a mountpoint like any other non-directory.
move_mount() without MOVE_MOUNT_T_SYMLINKS doesn't follow the target
path, so the mount lands on the symlink itself, and graft_tree() only
checks that the root of the mount isn't a directory either.

So the race that commit 8189ab688f5a ("namei: don't reveal overmounted
entries in refwalk") closed for files and directories is still open for
symlinks. A refwalk finds the symlink while it is covered, its name is
unlinked and the mounts are detached, and when the walk looks at the
mounts they are gone. Instead of refusing the dentry the walk reads the
link and goes on with whatever it points to.

So make the check right after handle_mounts(), before the walk decides
whether it follows a symlink. The rcuwalk early return moves into
unlink_may_reveal() with it. Nothing changes for a dentry that isn't a
symlink.

The appended reproducer mounts the tmpfs file MARK on the symlink
F'/lnk of an open_tree() copy of a raw fuse mount and opens F'/lnk
while the fuse server unlinks F/lnk before it answers the revalidation
of lnk. On 7.3.0-rc6 with the previous patches applied the walker read
UNDER, the file the symlink points to, in 20 of 20 rounds. With this
patch open() fails with ENOENT in all of them.

  // SPDX-License-Identifier: GPL-2.0
  /*
   * unlink_symlink: follow a symlink that lost its mount under the walk.
   *
   * F is a fuse mount with the file f1 (UNDER) and the symlink lnk -> f1.
   * F' is an open_tree() copy of F with the tmpfs file MARK mounted on the
   * symlink F'/lnk itself. A walker opens F'/lnk. The server answers the
   * revalidation of lnk only after it has unlinked F/lnk, which detaches
   * MARK. Reading UNDER is a hit: the walk followed the unlinked symlink.
   *
   * usage: unlink_symlink [-n rounds]
   */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <pthread.h>
  #include <stdatomic.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mount.h>
  #include <sys/stat.h>
  #include <sys/syscall.h>
  #include <sys/uio.h>
  #include <sys/wait.h>
  #include <unistd.h>
  #include <linux/fuse.h>

  #ifndef OPEN_TREE_CLONE
  #define OPEN_TREE_CLONE		1
  #endif
  #ifndef MOVE_MOUNT_F_EMPTY_PATH
  #define MOVE_MOUNT_F_EMPTY_PATH	0x00000004
  #endif

  enum { ROOT_ID = FUSE_ROOT_ID, F1_ID, LNK_ID };

  static int ffd = -1;
  static char fmnt[64];
  static atomic_int lnk_present;
  static atomic_int walker;	/* unlink lnk in this pid's lookup of it */

  static void die(const char *what)
  {
  	fprintf(stderr, "%s: %s\n", what, strerror(errno));
  	exit(2);
  }

  static void reply(uint64_t unique, int error, const void *data,
  		  size_t len)
  {
  	struct fuse_out_header oh = {
  		.len = sizeof(oh) + (error ? 0 : len),
  		.error = error,
  		.unique = unique,
  	};
  	struct iovec iov[2] = { { &oh, sizeof(oh) }, { (void *)data, len } };

  	if (writev(ffd, iov, (error || !len) ? 1 : 2) < 0)
  		return;
  }

  static void fill_attr(struct fuse_attr *a, uint64_t id)
  {
  	memset(a, 0, sizeof(*a));
  	a->ino = id;
  	a->nlink = 1;
  	a->blksize = 4096;
  	if (id == ROOT_ID) {
  		a->mode = S_IFDIR | 0755;
  		a->nlink = 2;
  	} else if (id == LNK_ID) {
  		a->mode = S_IFLNK | 0777;
  		a->size = 2;
  	} else {
  		a->mode = S_IFREG | 0644;
  		a->size = 5;
  	}
  }

  /* entry_valid 0: every refwalk revalidates the name */
  static void reply_entry(uint64_t unique, uint64_t id)
  {
  	struct fuse_entry_out e = {
  		.nodeid = id,
  		.generation = 1,
  		.attr_valid = 3600,
  	};

  	fill_attr(&e.attr, id);
  	reply(unique, 0, &e, sizeof(e));
  }

  static void *unlinker(void *arg)
  {
  	char path[80];

  	snprintf(path, sizeof(path), "%s/lnk", fmnt);
  	if (unlink(path))
  		die("unlink lnk");
  	return NULL;
  }

  static void lookup(struct fuse_in_header *ih, const char *name)
  {
  	int w = atomic_load(&walker);

  	if (ih->nodeid != ROOT_ID) {
  		reply(ih->unique, -ENOENT, NULL, 0);
  	} else if (!strcmp(name, "f1")) {
  		reply_entry(ih->unique, F1_ID);
  	} else if (!strcmp(name, "lnk")) {
  		/* the walker revalidates lnk: unlink it, then answer */
  		if (w && (int)ih->pid == w &&
  		    atomic_compare_exchange_strong(&walker, &w, 0)) {
  			pthread_t t;

  			if (pthread_create(&t, NULL, unlinker, NULL))
  				die("pthread_create");
  			pthread_join(t, NULL);
  		} else if (!atomic_load(&lnk_present)) {
  			reply(ih->unique, -ENOENT, NULL, 0);
  			return;
  		}
  		reply_entry(ih->unique, LNK_ID);
  	} else {
  		reply(ih->unique, -ENOENT, NULL, 0);
  	}
  }

  static void *server(void *arg)
  {
  	size_t size = FUSE_MIN_READ_BUFFER + 65536;
  	char *buf = malloc(size);
  	struct fuse_in_header *ih = (void *)buf;
  	void *in = buf + sizeof(*ih);

  	if (!buf)
  		die("malloc");
  	for (;;) {
  		ssize_t n = read(ffd, buf, size);

  		if (n < 0 && (errno == EINTR || errno == EAGAIN))
  			continue;
  		if (n < (ssize_t)sizeof(*ih))
  			return NULL;
  		switch (ih->opcode) {
  		case FUSE_INIT: {
  			struct fuse_init_out o = {
  				.major = FUSE_KERNEL_VERSION,
  				.minor = FUSE_KERNEL_MINOR_VERSION,
  				.max_readahead = 65536,
  				.max_write = 65536,
  			};

  			reply(ih->unique, 0, &o, sizeof(o));
  			break;
  		}
  		case FUSE_LOOKUP:
  			lookup(ih, in);
  			break;
  		case FUSE_GETATTR: {
  			struct fuse_attr_out o = { .attr_valid = 3600 };

  			fill_attr(&o.attr, ih->nodeid);
  			reply(ih->unique, 0, &o, sizeof(o));
  			break;
  		}
  		case FUSE_READLINK:
  			reply(ih->unique, 0, "f1", 2);
  			break;
  		case FUSE_OPEN: {
  			struct fuse_open_out o = { .open_flags = FOPEN_DIRECT_IO };

  			reply(ih->unique, 0, &o, sizeof(o));
  			break;
  		}
  		case FUSE_READ: {
  			struct fuse_read_in *ri = in;

  			if (ri->offset >= 5)
  				reply(ih->unique, 0, NULL, 0);
  			else
  				reply(ih->unique, 0, "UNDER" + ri->offset,
  				      5 - ri->offset);
  			break;
  		}
  		case FUSE_UNLINK:
  			if (ih->nodeid == ROOT_ID && !strcmp(in, "lnk"))
  				atomic_store(&lnk_present, 0);
  			reply(ih->unique, 0, NULL, 0);
  			break;
  		case FUSE_FLUSH:
  		case FUSE_RELEASE:
  		case FUSE_ACCESS:
  			reply(ih->unique, 0, NULL, 0);
  			break;
  		case FUSE_FORGET:
  		case FUSE_BATCH_FORGET:
  		case FUSE_INTERRUPT:
  			break;
  		default:
  			reply(ih->unique, -ENOSYS, NULL, 0);
  			break;
  		}
  	}
  }

  /* a child opens F'/lnk once the parent has told the server its pid */
  static int walk(int tfd, int *err, char *buf)
  {
  	struct { int err; char buf[8]; } r;
  	int go[2], res[2];
  	pid_t pid;

  	if (pipe(go) || pipe(res))
  		die("pipe");
  	pid = fork();
  	if (pid < 0)
  		die("fork");
  	if (!pid) {
  		char c;
  		int fd;

  		memset(&r, 0, sizeof(r));
  		if (read(go[0], &c, 1) != 1)
  			_exit(1);
  		fd = openat(tfd, "lnk", O_RDONLY);
  		if (fd < 0)
  			r.err = errno;
  		else if (read(fd, r.buf, sizeof(r.buf) - 1) < 0)
  			r.err = errno;
  		_exit(write(res[1], &r, sizeof(r)) != sizeof(r));
  	}
  	atomic_store(&walker, pid);
  	if (write(go[1], "", 1) != 1)
  		die("go");
  	if (read(res[0], &r, sizeof(r)) != sizeof(r))
  		die("walker");
  	waitpid(pid, NULL, 0);
  	close(go[0]);
  	close(go[1]);
  	close(res[0]);
  	close(res[1]);
  	*err = r.err;
  	memcpy(buf, r.buf, sizeof(r.buf));
  	return atomic_load(&walker) ? -1 : 0;
  }

  int main(int argc, char **argv)
  {
  	char dir[] = "/tmp/unlink_symlink_XXXXXX", mark[80], opts[64];
  	int rounds = 20, hits = 0, fd, c;

  	while ((c = getopt(argc, argv, "n:")) != -1) {
  		if (c != 'n')
  			return 2;
  		rounds = atoi(optarg);
  	}
  	alarm(120);
  	if (unshare(CLONE_NEWNS) ||
  	    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
  		die("unshare");
  	if (!mkdtemp(dir) || mount("tmpfs", dir, "tmpfs", 0, "size=1M"))
  		die("tmpfs");
  	snprintf(fmnt, sizeof(fmnt), "%s/F", dir);
  	snprintf(mark, sizeof(mark), "%s/mark", dir);
  	fd = open(mark, O_CREAT | O_WRONLY, 0644);
  	if (fd < 0 || write(fd, "MARK", 4) != 4 || close(fd) ||
  	    mkdir(fmnt, 0755))
  		die("mark");
  	ffd = open("/dev/fuse", O_RDWR);
  	if (ffd < 0)
  		die("/dev/fuse");
  	snprintf(opts, sizeof(opts),
  		 "fd=%d,rootmode=40000,user_id=0,group_id=0", ffd);
  	if (mount("fuse", fmnt, "fuse", 0, opts))
  		die("mount fuse");
  	for (int i = 0; i < 4; i++) {
  		pthread_t t;

  		if (pthread_create(&t, NULL, server, NULL))
  			die("pthread_create");
  	}

  	for (int i = 0; i < rounds; i++) {
  		char buf[8] = "";
  		int tfd, mfd, err;

  		atomic_store(&lnk_present, 1);
  		tfd = syscall(SYS_open_tree, AT_FDCWD, fmnt, OPEN_TREE_CLONE);
  		mfd = syscall(SYS_open_tree, AT_FDCWD, mark, OPEN_TREE_CLONE);
  		if (tfd < 0 || mfd < 0)
  			die("open_tree");
  		/* no MOVE_MOUNT_T_SYMLINKS: MARK goes onto the symlink itself */
  		if (syscall(SYS_move_mount, mfd, "", tfd, "lnk",
  			    MOVE_MOUNT_F_EMPTY_PATH))
  			die("move_mount");
  		close(mfd);
  		fd = openat(tfd, "lnk", O_RDONLY);
  		if (fd < 0 || read(fd, buf, sizeof(buf) - 1) < 0)
  			die("open F'/lnk");
  		close(fd);
  		if (strcmp(buf, "MARK")) {
  			fprintf(stderr, "MARK is not mounted on lnk: read \"%s\"\n",
  				buf);
  			return 2;
  		}

  		if (walk(tfd, &err, buf)) {
  			fprintf(stderr, "lnk was not revalidated\n");
  			return 2;
  		}
  		if (!err && !strcmp(buf, "UNDER")) {
  			if (!hits++)
  				printf("round %d: read \"%s\" through the unlinked lnk\n",
  				       i, buf);
  		} else if (err != ENOENT) {
  			printf("round %d: %s\n", i, err ? strerror(err) : buf);
  		}
  		close(tfd);
  	}
  	printf("unlink_symlink: %d rounds, %d followed the unlinked symlink\n",
  	       rounds, hits);
  	return hits ? 1 : 0;
  }

Fixes: 8189ab688f5a ("namei: don't reveal overmounted entries in refwalk")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 63c3648b363a..9487f3d8567f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2104,6 +2104,9 @@ static noinline const char *pick_link(struct nameidata *nd, struct path *link,
 static int unlink_may_reveal(struct nameidata *nd, int flags,
 			     struct path *path, struct dentry *dentry)
 {
+	/* rcuwalk catches this via d_seq */
+	if (nd->flags & LOOKUP_RCU)
+		return 0;
 	/* ".." and LOOKUP_DOWN may land on an unhashed directory */
 	if (flags & WALK_NOFOLLOW)
 		return 0;
@@ -2137,6 +2140,9 @@ static noinline const char *step_into_slowpath(struct nameidata *nd, int flags,
 	err = handle_mounts(nd, dentry, &path);
 	if (unlikely(err < 0))
 		return ERR_PTR(err);
+	err = unlink_may_reveal(nd, flags, &path, dentry);
+	if (unlikely(err))
+		return ERR_PTR(err);
 	inode = path.dentry->d_inode;
 	if (likely(!d_is_symlink(path.dentry)) ||
 	   ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
@@ -2148,9 +2154,6 @@ static noinline const char *step_into_slowpath(struct nameidata *nd, int flags,
 			if (unlikely(!inode))
 				return ERR_PTR(-ENOENT);
 		} else {
-			err = unlink_may_reveal(nd, flags, &path, dentry);
-			if (unlikely(err))
-				return ERR_PTR(err);
 			dput(nd->path.dentry);
 			if (nd->path.mnt != path.mnt)
 				mntput(nd->path.mnt);

-- 
2.53.0

