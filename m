Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435874;
	b=qsHi8tXktq7QgSUnpSh9wz2O8PFCH6w516NVObqFAExql5DmJSFjhZ9icpeqclKNDRiS
	 H7DxKovmGPZUTuCQkv/dNCbIHtmwd1su1mV4PHb3RqCZN3KjAgKDhgvHzn7+Jfpr20kez
	 r4s2IlqRAvYDIYbo+v9jj9hjyH9l2B9OmPlGSKBaZYCdL0R/yZ+ObQ537IJMFE8P79EiZ
	 LG1zU7xR1snB3WDcTJU99g3omYgmjIU1FT4rWOffSlw6niqe+6yB8szQDSRqYAPNN6xUi
	 heEFOMTuq1nooma8OFhKMEdjx/gOkIVPHqv9ybhuQGCjLdAIlyxIzHW5ayIfh+FVnTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ewLyE1aftpkdM1oArd6K7dzXkrABbSm6esaIbu8bXrM=;
	b=CgrA3ao1yLIuNbKUqQklCvWIFgw3rqcYRauwRpFMMN/jBTsTi4HaKHQVnf7vqDQ5BajN
	 aZlHjiU3xAAuX++5codhpSdRIuuSSWodTOTKw+TLRPn/U45pZLD4vuWhstrX1MKu0ZX7o
	 wFnRMemL8I7iUAvygE2K8z3FRGwVyBhHIqMGNUR0BbM3AxAwBf79Vm+Ara7fXSnZOr0xc
	 6zr8+bT0kveVrXa8MSmtvejWkTvm3ngrfv8Z59L5KymT+wyc0DdC9UhTSO20dwl63LK+k
	 M0WQrFLgpEYgE6OBXOIbvtWzzODt0EWZJEOlmdJa2HKL0T8u8Ii4q34DS0/WtDwcvlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrY1Kqhz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A1606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrY1Kqhz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83321F00A05;
	Wed, 11 Nov 2026 22:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435874;
	bh=ewLyE1aftpkdM1oArd6K7dzXkrABbSm6esaIbu8bXrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZrY1Kqhz7BPWY5djZTTRTCA0I4MvSnveZqJ+or3SAQVuHQEgqJgl1v8Th3kC1xqQ6
	 UDc9DMvaARfTVms1JUIk/fVWAUVT6mq/HiWVbQ6zubrY35Gp4e0uXCpZ5qVMjOAW8w
	 Z1zdeKasRo+U1TGngvOgRRaibxxHBM+Z4Se4SVH0pzfdOKFYVPG/Be5TnQrmpT2mYD
	 Zgy++rjlt//W93cpaODxhrACusgnkPtCEbjLITRssJR9mHIEmwIukvkQFVvGt99OVE
	 xrW3rPCjAGr6zWy84oHScDWt1c1KRFyaBRWET3eVzBDx6a+EGgpbhRLhjYdzAUjS44
	 /IaqkU8HdLVuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <aleksa@amutable.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] proc: don't let an entry below /proc/<pid>/net be a mountpoint
Date: Wed, 11 Nov 2026 17:24:32 -0500
Message-ID: <20261111222406.4137222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052756-failed-6.12-eeecea75ece2@kernel.org>
References: <20261107052756-failed-6.12-eeecea75ece2@kernel.org>
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

[ Upstream commit eeecea75ece2ba894bee4d3c53ed2e40abda8f0e ]

proc_net_d_revalidate() always returns 0 so that a dentry below
/proc/<pid>/net is never reused after setns(). So lookup_fast() will end
up calling d_invalidate(), which unhashes the dentry and detaches every
mount on it, in every mount namespace; including locked mounts.

Then lookup_slow() creates a new dentry for the same entry. So a mount
on /proc/<pid>/net/dev succeeds and goes away with the first lookup of
the name by anybody with search permission on the directory. Given it's
0555 that's everyone's grandma. A mask on such a name hides nothing as
the repro below shows.

Treat those entries like I did fd/, fdinfo/ and map_files/ and refuse to
mount on them in the first place. It's nonsensical theater otherwise:

  procnet net/dev stat

  // SPDX-License-Identifier: GPL-2.0
  /*
   * procnet: cover an entry of /proc/<pid>/ with a bind mount, lock the mount,
   * then look the name up.
   *
   * The first task stays alive, <pid> is its pid. The "container" task has its
   * own mount namespace. There it binds a mask on /proc/<pid>/<name>. It drops to
   * uid 1000 and enters a new user namespace with a new mount namespace, so that
   * the mask is locked. Then one task looks the name up:
   *
   *   stat    the container calls stat() on the name
   *   umount  the container calls umount2(MNT_DETACH) on the name
   *   nobody  a task with uid 65534 in the first namespaces calls stat()
   *
   * The container lists its mounts before and after (that does not look the
   * name up) and then reads the name. MASK is fine. Anything else means that
   * the lookup uncovered the entry.
   *
   * usage: procnet <name> stat|umount|nobody
   *   name "status" is the control, "net/dev" is a file below net, "net/stat" is
   *   a directory below net
   */
  #define _GNU_SOURCE
  #include <dirent.h>
  #include <errno.h>
  #include <fcntl.h>
  #include <sched.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <time.h>
  #include <unistd.h>
  #include <sys/mount.h>
  #include <sys/prctl.h>
  #include <sys/stat.h>
  #include <sys/wait.h>

  #define WORK "/run/pn"

  static char target[128];

  static void die(const char *what)
  {
  	fprintf(stderr, "FATAL %s: %s\n", what, strerror(errno));
  	exit(2);
  }

  static void write_str(const char *path, const char *s, int flags)
  {
  	int fd = open(path, O_WRONLY | flags, 0644);

  	if (fd < 0 || write(fd, s, strlen(s)) < 0)
  		die(path);
  	close(fd);
  }

  /* list the mounts below /proc without a lookup of the target */
  static void mounts(const char *when)
  {
  	char line[512];
  	FILE *f = fopen("/proc/self/mountinfo", "r");
  	int n = 0;

  	if (!f)
  		die("mountinfo");
  	while (fgets(line, sizeof(line), f)) {
  		if (!strstr(line, " /proc/"))
  			continue;
  		printf("container: %s: mount: %s", when, line);
  		n++;
  	}
  	fclose(f);
  	if (!n)
  		printf("container: %s: nothing is mounted below /proc\n", when);
  }

  static void show(const char *when, int isdir)
  {
  	char buf[48] = "";
  	int fd;

  	if (isdir) {
  		struct dirent *de;
  		DIR *d = opendir(target);
  		int hit = 0;

  		if (!d) {
  			printf("container: %s: opendir(%s) = %s\n", when, target, strerror(errno));
  			return;
  		}
  		printf("container: %s: readdir(%s) =", when, target);
  		while ((de = readdir(d))) {
  			if (de->d_name[0] == '.')
  				continue;
  			printf(" %s", de->d_name);
  			hit |= strcmp(de->d_name, "MASK");
  		}
  		closedir(d);
  		printf("%s\n", hit ? "   <-- HIT" : "");
  		return;
  	}
  	fd = open(target, O_RDONLY);
  	if (fd < 0) {
  		printf("container: %s: open(%s) = %s\n", when, target, strerror(errno));
  		return;
  	}
  	if (read(fd, buf, sizeof(buf) - 1) < 0)
  		die("read");
  	close(fd);
  	if (strchr(buf, '\n'))
  		*strchr(buf, '\n') = 0;
  	printf("container: %s: read(%s) = \"%s\"%s\n", when, target, buf,
  	       strncmp(buf, "MASK", 4) ? "   <-- HIT" : "");
  }

  int main(int argc, char **argv)
  {
  	const char *name = argc > 1 ? argv[1] : "net/dev";
  	const char *op = argc > 2 ? argv[2] : "stat";
  	int isdir = !strcmp(name, "net/stat");
  	int to_host[2], to_cont[2];
  	struct stat st;
  	pid_t pid;
  	char c;

  	setvbuf(stdout, NULL, _IOLBF, 0);
  	snprintf(target, sizeof(target), "/proc/%d/%s", getpid(), name);
  	if (unshare(CLONE_NEWNS) || mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
  		die("unshare");
  	mkdir(WORK, 0755);
  	if (mount("W", WORK, "tmpfs", 0, NULL))
  		die("mount W");
  	write_str(WORK "/mask", "MASK", O_CREAT);
  	mkdir(WORK "/maskdir", 0755);
  	write_str(WORK "/maskdir/MASK", "MASK", O_CREAT);
  	if (pipe(to_host) || pipe(to_cont))
  		die("pipe");

  	pid = fork();
  	if (pid < 0)
  		die("fork");
  	if (!pid) {
  		if (unshare(CLONE_NEWNS))
  			die("container unshare");
  		if (mount(isdir ? WORK "/maskdir" : WORK "/mask", target, NULL, MS_BIND, NULL)) {
  			printf("container: bind the mask on %s: %s\n", target, strerror(errno));
  			exit(0);
  		}
  		printf("container: bind the mask on %s: ok\n", target);
  		if (setgid(1000) || setuid(1000) || prctl(PR_SET_DUMPABLE, 1))
  			die("setuid");
  		/* lock the mount: a new user namespace with a copy of the tree */
  		if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
  			die("container userns");
  		write_str("/proc/self/setgroups", "deny", 0);
  		write_str("/proc/self/uid_map", "0 1000 1", 0);
  		write_str("/proc/self/gid_map", "0 1000 1", 0);
  		mounts("before");
  		errno = 0;
  		if (!strcmp(op, "stat")) {
  			stat(target, &st);
  			printf("container: stat(%s): %s\n", target, strerror(errno));
  		} else if (!strcmp(op, "umount")) {
  			umount2(target, MNT_DETACH);
  			printf("container: umount2(%s, MNT_DETACH): %s\n", target, strerror(errno));
  		} else if (write(to_host[1], "g", 1) != 1 || read(to_cont[0], &c, 1) != 1) {
  			die("sync");
  		}
  		mounts("after");
  		show("after", isdir);
  		exit(0);
  	}
  	close(to_host[1]);
  	if (read(to_host[0], &c, 1) == 1) {
  		pid_t p2 = fork();

  		if (!p2) {
  			if (setgid(65534) || setuid(65534))
  				die("setuid");
  			errno = 0;
  			stat(target, &st);
  			printf("nobody: uid %u: stat(%s): %s\n", getuid(), target, strerror(errno));
  			exit(0);
  		}
  		waitpid(p2, NULL, 0);
  		if (write(to_cont[1], "g", 1) != 1)
  			die("sync");
  	}
  	waitpid(pid, NULL, 0);
  	return 0;
  }

Fixes: 1fde6f21d90f ("proc: fix /proc/net/* after setns(2)")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261024-work-procfs-fixes-v1-1-46b03c3a8fac@kernel.org
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Aleksa Sarai <aleksa@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: replaced the PROC_ENTRY_FORCE_LOOKUP flag check with de->proc_dops == &proc_net_dentry_ops. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index c3cc99973ef64..e8fe204a88c39 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -255,6 +255,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
+		/* never reused and so never a mountpoint for long */
+		if (de->proc_dops == &proc_net_dentry_ops)
+			return proc_splice_unmountable(inode, dentry,
+						       &proc_net_dentry_ops);
 		d_set_d_op(dentry, de->proc_dops);
 		return d_splice_alias(inode, dentry);
 	}
-- 
2.53.0

