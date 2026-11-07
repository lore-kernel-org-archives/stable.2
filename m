Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048034;
	b=BVUT4vRI36mQ4X7UAthOGBBjHgY02IbNYUPEGRgJwOxm7UIctqmao6g0+ZOic5RnRJ3D
	 k+MHrvS3vgB9fJnARuxjFBvAGL3Ed+QU+58kuNfojqt2QNsMez/7mq3aKzUVX4iDjJYNr
	 uGF4+oex0dpDXTi8dyQXekgeig9Vw7jpH+0xo2ob6nXDjK6Tzdaul55sUSeTEAH6VIm+h
	 L2e1DtYxRS+HiQSgwlHY0wpPgkstLsJ+QqYMTlwt6UIuElZG8PwkLTUFAw6QZ8156HwoY
	 zrT+10dVDJI5nRhtbcxJ3YPiggEXBxIDa8nrY6lqWpEuBvENdOLysxA6zlcJJEf6+1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048034;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2ipXHJX+r3/JacULsc7NhPYpoTQT3gH244wefR/U8Bg=;
	b=L5tqbkV0YL8tGy2JxX0SckJ2kXq7MTenMqPtc69w+8xoR3pkHtA/0njDHmoin8FNUnaw
	 LvppdXvXUwGjZruUbHV/aL/uaxx6YKzitLyOufMeu4h3z1+Xb6AYIlAa2jog49rQvr9Ea
	 gwLLGvP9palddI4h0YlK7pAwMmlOImmFrBd+t1i/32fVvfwMt/igJ1T9RkZIG/MZbgA5a
	 2gRYCrJq/djpFu0UNyB2X8gxO1ztnYKvXfVSXI65C7qqEYML2/RAcnEZADdlzPmOdHXP0
	 8Wl7d5CyxDsuqLP0qkhU/6hNWr6wt2HBvoacmyczY8pWS1IMLzUCzcgZyaEqopovq8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD2Zkuhx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD2Zkuhx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1BE1F0089F;
	Sat,  7 Nov 2026 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048034;
	bh=2ipXHJX+r3/JacULsc7NhPYpoTQT3gH244wefR/U8Bg=;
	h=From:To:Cc:Subject:Date;
	b=bD2ZkuhxCv4ZOxy0VsuK+C6c+xy6NZqeEpUF74GGHFsSLNBkI3O+1/Fabm+O+99e3
	 hH3A1T6pe7jCKyrzbr5kyhunDAtVgbalLSowranCONZg3RhcYjkdvyeMF22xk+uS/w
	 goUBwqKewMB4GKKLbSwIVt3oDAcs+jfrX5u+78Ux12VCUv72IHV3hq8rqQ40GzKZTI
	 jE86SSe0m2q0x4znhcKBcKebK7m91jAGFnd5U/GGdWK+mhHi8bcy8fLK2+GHV6N8oo
	 YnEh7FgX00pLQTGN6lFpt0Ygk1M/fjLgWM+2+XcnYFfoYwoLkRt2GiwtN6ajduYbKB
	 Dq2HaSoPR7Isg==
From: Sasha Levin <sashal@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	aleksa@amutable.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] proc: don't let an entry below /proc/<pid>/net be a mountpoint" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:40:32 -0500
Message-ID: <20261107054032-failed-6.6-eeecea75ece2@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x eeecea75ece2ba894bee4d3c53ed2e40abda8f0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054032-failed-6.6-eeecea75ece2@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eeecea75ece2ba894bee4d3c53ed2e40abda8f0e Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 24 Oct 2026 12:38:27 +0200
Subject: [PATCH] proc: don't let an entry below /proc/<pid>/net be a
 mountpoint

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
---
 fs/proc/generic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 2b1971da4a85a..4c3fcaf68ef40 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -256,9 +256,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
+		/* never reused and so never a mountpoint for long */
 		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
-			return d_splice_alias_ops(inode, dentry,
-						  &proc_net_dentry_ops);
+			return proc_splice_unmountable(inode, dentry,
+						       &proc_net_dentry_ops);
 		return d_splice_alias_ops(inode, dentry,
 					  &proc_misc_dentry_ops);
 	}
-- 
2.53.0




