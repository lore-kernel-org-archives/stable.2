Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3648E0EE;
	Mon, 12 Oct 2026 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809831; cv=none; b=QwdCAqzDgAhv5EcReOWB6Ax6vhPwOcsSn/LkR1cOgldYuZeC/6I0CeFV1kLV0NI9trmUYl3m0rplyNZY0o9s/jNzyuMPLRMRoX5rJ7xyX14tevNCgGxXzSphxMhv9TVLJoFRZWyIklPUS3cwgNifYFFLMYAkDUkW6PPheq8qUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809831; c=relaxed/simple;
	bh=dBY3+xwIKEaPLHd/Kx9zTwBZHipQtgzBkiMCALK0eZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lv7ib+Bw6HVnkuPIqq7HWqmuF9sFb7b9KMfegfAqUmVBKVKZFnDjuqf7NByjtB9EHVlvLPIa+7WqtBsx06GH6G6il47Jn5Vjy92FALyskrZxa7ev79BZk76oPCuxyR/HeRQh1useEScm2n32gzfBYA6joy3H7TPlnDGazkT3V04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axI3RXsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axI3RXsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0901F0089C;
	Mon, 12 Oct 2026 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791809829;
	bh=vckB/qfRvzFDx2z0jMoKF81UOpbamMn9t5snlLJ6BY0=;
	h=From:Date:Subject:To:Cc;
	b=axI3RXsA+I23bgkkiIz6VyrLqkNttDyM5jqG/fyC/EnCU5aMo5OwncDgNlhSVdqHr
	 ru8iINUKIPd8oddv4JX8q9AaWW2mwsf0AopXlhdyEefiwApaZZ1pqAMkD/XOPHYnNB
	 rQa/gvekPyZ4mqy0+IoBQAKL2Cc2mfSjQEraES0Rq1KWiKaNu0nCEjjI5lX4MSAP5W
	 N1dp6woBVPIS/dgIdk4JUW0UcQy/k0eoY7vA1zul2BfpSPB4BambEqHP8nPIPL7dy2
	 /s9CNrWhpFMHywukLyIW716x1vIaIjXqq/8r46wFZLzS449SpBm/Aow98GB1+Wy8h/
	 y1UAKXWmInomw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 14:57:04 +0200
Subject: [PATCH] namei: test for a negative dentry the way
 traverse_mounts() does
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-namei-ocreate-v1-1-c7883b17ee28@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MwQ6CMAzG8VchPdtl7ADoqxgP2+ikGjfTgZoQ3
 t0NPf6br78VMglThlOzgtCLM6dYoj004Ccbr4Q8lgajTdfq1uA7yR2jfRBj8kJ2Jhwo9H4Y+3D
 sNJTHp1Dgz46eL7/Oi7uRn6tUF85mQic2+qmeqql2U/1NVRewbV9l+ClRoAAAAA==
X-Change-ID: 20261012-work-namei-ocreate-8ef7c8d7f960
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, Neil Brown <neil@brown.name>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7853; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dBY3+xwIKEaPLHd/Kx9zTwBZHipQtgzBkiMCALK0eZA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdualYed43d/XBI8d+bd6owGGcVlNTcOCmu82WremM4
 lq7AjdFdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEbAXD/6rHaVn6fi1bQr7+
 rLiqVPLyu/UH9hXn39r678h5dajV9Rsjw5sp+1jrNx4/9eC1fqL+jQkXStm92YrlbSu9It4o8PF
 KcAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

lookup_fast_for_open() only hands an O_CREAT open a cached dentry if
it's positive. Otherwise the open goes on to lookup_open(), which takes
the directory lock and creates the file. It tests for that with
!dentry->d_inode, but traverse_mounts() later decides with the type in
d_flags. And when a dentry is instantiated __d_set_inode_and_type()
stores ->d_inode first and only then releases the type into ->d_flags.

So a refwalk that took its reference to a negative dentry right before
another task instantiates it can find ->d_inode already set in
lookup_fast_for_open(), go on to step_into(), and still find the
negative type in traverse_mounts(). The open then fails with -ENOENT,
which an O_CREAT open must never do. rcuwalk doesn't get that far, the
d_seq check in step_into() catches the instantiation.

Use d_is_negative() so both look at the type. While the type is still
negative the open takes lookup_open() and waits for the directory lock
like any other O_CREAT open of a negative dentry.

On its own the window is a couple of instructions in the creating task,
so it takes an interrupt or a preempted vcpu in exactly the right spot.
I haven't caught it without help in about 600 million racing O_CREAT
opens.

The debug patch below stalls the creating task between the two stores
for names starting with "ocrace", the way an interrupt landing there
would. The reproducer below opens "ocrace" with O_CREAT through
symlinks on a strictatime tmpfs: following them updates their atime,
which drops the walk out of rcuwalk, so the name is always looked up in
refwalk. With

  echo 20 > /proc/sys/fs/ocrace_instantiate_us
  ./ocreat_enoent -t 60

on a KASAN kernel open() failed with -ENOENT 43 times in 4.9 million
calls. With this patch it never failed in 4.8 million calls. Tracing
step_into_slowpath() during such a run, each of the 98 -ENOENTs it
returned came right after the same task had entered it with a dentry
that was still typed negative.

  // SPDX-License-Identifier: GPL-2.0
  /*
   * ocreat_enoent: open(O_CREAT) racing the creation of the same name.
   *
   * Writers unlink "ocrace" and create it again. Readers open it with
   * O_CREAT through a symlink of their own on a strictatime tmpfs.
   * Following the symlink updates its atime, which drops the walk out of
   * rcu mode, so the name is always looked up in refwalk. An O_CREAT open
   * must never fail with ENOENT.
   *
   * -p arms a cpu-clock perf timer with that period in ns on every writer,
   * so that interrupts land at random points in it.
   *
   *   usage: ocreat_enoent [-t secs] [-w writers] [-r readers] [-p ns]
   */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <pthread.h>
  #include <stdatomic.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mount.h>
  #include <sys/stat.h>
  #include <sys/syscall.h>
  #include <unistd.h>
  #include <linux/perf_event.h>

  #define DIR "/tmp/oc"

  static atomic_int stop;
  static atomic_long opens, creates, enoent, other;
  static long period;

  static void die(const char *what)
  {
  	fprintf(stderr, "FATAL %s: %s\n", what, strerror(errno));
  	exit(2);
  }

  static void *writer(void *arg)
  {
  	(void)arg;
  	if (period) {
  		struct perf_event_attr attr = {
  			.type = PERF_TYPE_SOFTWARE,
  			.size = sizeof(attr),
  			.config = PERF_COUNT_SW_CPU_CLOCK,
  			.sample_period = period,
  		};

  		if (syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0) < 0)
  			die("perf_event_open");
  	}
  	while (!atomic_load(&stop)) {
  		int fd;

  		unlink(DIR "/ocrace");
  		fd = open(DIR "/ocrace", O_CREAT | O_RDWR | O_CLOEXEC, 0644);
  		if (fd >= 0)
  			close(fd);
  		atomic_fetch_add(&creates, 1);
  	}
  	return NULL;
  }

  static void *reader(void *arg)
  {
  	char lnk[64];

  	snprintf(lnk, sizeof(lnk), DIR "/lnk.%ld", (long)arg);
  	while (!atomic_load(&stop)) {
  		int fd = open(lnk, O_CREAT | O_RDWR | O_CLOEXEC, 0644);

  		if (fd >= 0)
  			close(fd);
  		else if (errno == ENOENT)
  			atomic_fetch_add(&enoent, 1);
  		else
  			atomic_fetch_add(&other, 1);
  		atomic_fetch_add(&opens, 1);
  	}
  	return NULL;
  }

  int main(int argc, char **argv)
  {
  	int secs = 60, nw = 4, nr = 12, c, n = 0;
  	pthread_t t[256];

  	while ((c = getopt(argc, argv, "t:w:r:p:")) != -1) {
  		switch (c) {
  		case 't': secs = atoi(optarg); break;
  		case 'w': nw = atoi(optarg); break;
  		case 'r': nr = atoi(optarg); break;
  		case 'p': period = atol(optarg); break;
  		default: return 2;
  		}
  	}
  	if (nw + nr > 256)
  		return 2;
  	mkdir(DIR, 0755);
  	if (mount("oc", DIR, "tmpfs", MS_STRICTATIME, "mode=0755"))
  		die("tmpfs");
  	for (long i = 0; i < nr; i++) {
  		char lnk[64];

  		snprintf(lnk, sizeof(lnk), DIR "/lnk.%ld", i);
  		if (symlink("ocrace", lnk))
  			die("symlink");
  	}
  	for (long i = 0; i < nw; i++)
  		if (pthread_create(&t[n++], NULL, writer, NULL))
  			die("writer");
  	for (long i = 0; i < nr; i++)
  		if (pthread_create(&t[n++], NULL, reader, (void *)i))
  			die("reader");
  	sleep(secs);
  	atomic_store(&stop, 1);
  	for (int i = 0; i < n; i++)
  		pthread_join(t[i], NULL);
  	printf("%ds: %ld opens, %ld creates, ENOENT %ld, other errors %ld\n",
  	       secs, atomic_load(&opens), atomic_load(&creates),
  	       atomic_load(&enoent), atomic_load(&other));
  	umount2(DIR, MNT_DETACH);
  	return atomic_load(&enoent) ? 1 : 0;
  }

  diff --git a/fs/dcache.c b/fs/dcache.c
  --- a/fs/dcache.c
  +++ b/fs/dcache.c
  @@ -32,9 +32,13 @@
   #include <linux/bit_spinlock.h>
   #include <linux/rculist_bl.h>
   #include <linux/list_lru.h>
  +#include <linux/delay.h>
   #include "internal.h"
   #include "mount.h"

  +/* debug: stall "ocrace*" names between ->d_inode and the type */
  +static int sysctl_ocrace_instantiate_us;
  +
   #include <asm/runtime-const.h>

   /*
  @@ -200,6 +204,13 @@
   }

   static const struct ctl_table fs_dcache_sysctls[] = {
  +	{
  +		.procname	= "ocrace_instantiate_us",
  +		.data		= &sysctl_ocrace_instantiate_us,
  +		.maxlen		= sizeof(int),
  +		.mode		= 0644,
  +		.proc_handler	= proc_dointvec,
  +	},
   	{
   		.procname	= "dentry-state",
   		.data		= &dentry_stat,
  @@ -405,6 +416,10 @@
   	unsigned flags;

   	dentry->d_inode = inode;
  +	/* debug: an interrupt landing right here */
  +	if (unlikely(READ_ONCE(sysctl_ocrace_instantiate_us)) &&
  +	    !strncmp(dentry->d_name.name, "ocrace", 6))
  +		udelay(READ_ONCE(sysctl_ocrace_instantiate_us));
   	flags = READ_ONCE(dentry->d_flags);
   	flags &= ~DCACHE_ENTRY_TYPE;
   	flags |= type_flags;

Fixes: e747e15156b7 ("fs: try an opportunistic lookup for O_CREAT opens too")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c87c14ee1a25..8f3517000b8b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4750,8 +4750,12 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 		return dentry;
 
 	if (open_flag & O_CREAT) {
-		/* Discard negative dentries. Need inode_lock to do the create */
-		if (!dentry->d_inode) {
+		/*
+		 * Discard negative dentries. Need inode_lock to do the create.
+		 * Look at the type like traverse_mounts() will. A dentry that
+		 * is being instantiated gets ->d_inode before its type.
+		 */
+		if (d_is_negative(dentry)) {
 			if (!(nd->flags & LOOKUP_RCU))
 				dput(dentry);
 			dentry = NULL;

---
base-commit: 0b5c87bbf2742347b4e593defbfeee2cde0a316d
change-id: 20261012-work-namei-ocreate-8ef7c8d7f960

