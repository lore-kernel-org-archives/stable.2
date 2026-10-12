Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093A3AAF49;
	Mon, 12 Oct 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814335; cv=none; b=ODK9xAYQROpFFf5caL1kpdF++ooZD2Nt1eXxnPg8rtIO6QseuoYDBVcXMrsHIk0AZG/4Y2w9hKPQbGbTHCQDXrwK5B/jhm62o31b0ZuQ5omH03mjh1fuGwM90appGqoP24uVPY0RRTuieUaj90NgyhdjDugTuInHTKRbxkM6Zzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814335; c=relaxed/simple;
	bh=nllefu12QVhYiGgXUmyqjRBJFFkoHGO3munFAuuKLXU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0iYKYelAmqXuOgoJO9dx/GMkXzdQYRnG+IcTjaJDl3yFGjBNPLfbaR4bShtaXJdzSrhDjkw+ZzDI0DLNUALSWzy0ma+33EWzt1zQatby2spiUyU8jKle9l6ZgESQ3T3CFu0z1URZVo0e0+qfy/ARFXz2Pp8L9/p4xl0zbyohSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi8674sE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi8674sE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0171F0089B;
	Mon, 12 Oct 2026 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791814334;
	bh=9u36VtvjwbGKm1ZZx0NMxuDcx0vrlbOC+6lNe8ZIvBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xi8674sE3vwnIjRU0A3NPYo06v+V3WOQecWoaLJzjjIlaJ/nbwyM0zpmKu7aTX0My
	 LZeoFwBJyguIKxydLbnLqi9W6gRrWCvid/M0mi+eIftUss22O05FBYkRcZBpffI/qQ
	 EooKanPjUakrmS/DoW6jlPpXWo0su+QTKV+EEd9F3geLRaAVIfuZGpQLQ5ZanAeip0
	 nzeJMtZlKoe83Vg+o0b6yw02/eROkS6VD30oZYcv93FzDFlvupMETgzRaw05FJPlfQ
	 KvXi+GSgY/k975sm5lyzU0pLFS8i8oiBd0dDEmgJo+oyzlZrqJ+3+KsAW0z8z05nyu
	 wRtI1GuCBml0A==
Message-ID: <197fe2bb697e3dab272cfc05f293a225a0b89867.camel@kernel.org>
Subject: Re: [PATCH] namei: test for a negative dentry the way
 traverse_mounts() does
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, Neil Brown <neil@brown.name>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Josef Bacik
 <josef@toxicpanda.com>, 	stable@vger.kernel.org
Date: Mon, 12 Oct 2026 10:12:11 -0400
In-Reply-To: <4e179e0f7ade23c37644ceecc39ee7f41f837858.camel@kernel.org>
References: <20261012-work-namei-ocreate-v1-1-c7883b17ee28@kernel.org>
	 <4e179e0f7ade23c37644ceecc39ee7f41f837858.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-10-12 at 10:11 -0400, Jeff Layton wrote:
> On Mon, 2026-10-12 at 14:57 +0200, Christian Brauner wrote:
> > lookup_fast_for_open() only hands an O_CREAT open a cached dentry if
> > it's positive. Otherwise the open goes on to lookup_open(), which takes
> > the directory lock and creates the file. It tests for that with
> > !dentry->d_inode, but traverse_mounts() later decides with the type in
> > d_flags. And when a dentry is instantiated __d_set_inode_and_type()
> > stores ->d_inode first and only then releases the type into ->d_flags.
> >=20
> > So a refwalk that took its reference to a negative dentry right before
> > another task instantiates it can find ->d_inode already set in
> > lookup_fast_for_open(), go on to step_into(), and still find the
> > negative type in traverse_mounts(). The open then fails with -ENOENT,
> > which an O_CREAT open must never do. rcuwalk doesn't get that far, the
> > d_seq check in step_into() catches the instantiation.
> >=20
> > Use d_is_negative() so both look at the type. While the type is still
> > negative the open takes lookup_open() and waits for the directory lock
> > like any other O_CREAT open of a negative dentry.
> >=20
> > On its own the window is a couple of instructions in the creating task,
> > so it takes an interrupt or a preempted vcpu in exactly the right spot.
> > I haven't caught it without help in about 600 million racing O_CREAT
> > opens.
> >=20
> > The debug patch below stalls the creating task between the two stores
> > for names starting with "ocrace", the way an interrupt landing there
> > would. The reproducer below opens "ocrace" with O_CREAT through
> > symlinks on a strictatime tmpfs: following them updates their atime,
> > which drops the walk out of rcuwalk, so the name is always looked up in
> > refwalk. With
> >=20
> >   echo 20 > /proc/sys/fs/ocrace_instantiate_us
> >   ./ocreat_enoent -t 60
> >=20
> > on a KASAN kernel open() failed with -ENOENT 43 times in 4.9 million
> > calls. With this patch it never failed in 4.8 million calls. Tracing
> > step_into_slowpath() during such a run, each of the 98 -ENOENTs it
> > returned came right after the same task had entered it with a dentry
> > that was still typed negative.
> >=20
> >   // SPDX-License-Identifier: GPL-2.0
> >   /*
> >    * ocreat_enoent: open(O_CREAT) racing the creation of the same name.
> >    *
> >    * Writers unlink "ocrace" and create it again. Readers open it with
> >    * O_CREAT through a symlink of their own on a strictatime tmpfs.
> >    * Following the symlink updates its atime, which drops the walk out =
of
> >    * rcu mode, so the name is always looked up in refwalk. An O_CREAT o=
pen
> >    * must never fail with ENOENT.
> >    *
> >    * -p arms a cpu-clock perf timer with that period in ns on every wri=
ter,
> >    * so that interrupts land at random points in it.
> >    *
> >    *   usage: ocreat_enoent [-t secs] [-w writers] [-r readers] [-p ns]
> >    */
> >   #define _GNU_SOURCE
> >   #include <errno.h>
> >   #include <fcntl.h>
> >   #include <pthread.h>
> >   #include <stdatomic.h>
> >   #include <stdio.h>
> >   #include <stdlib.h>
> >   #include <string.h>
> >   #include <sys/mount.h>
> >   #include <sys/stat.h>
> >   #include <sys/syscall.h>
> >   #include <unistd.h>
> >   #include <linux/perf_event.h>
> >=20
> >   #define DIR "/tmp/oc"
> >=20
> >   static atomic_int stop;
> >   static atomic_long opens, creates, enoent, other;
> >   static long period;
> >=20
> >   static void die(const char *what)
> >   {
> >   	fprintf(stderr, "FATAL %s: %s\n", what, strerror(errno));
> >   	exit(2);
> >   }
> >=20
> >   static void *writer(void *arg)
> >   {
> >   	(void)arg;
> >   	if (period) {
> >   		struct perf_event_attr attr =3D {
> >   			.type =3D PERF_TYPE_SOFTWARE,
> >   			.size =3D sizeof(attr),
> >   			.config =3D PERF_COUNT_SW_CPU_CLOCK,
> >   			.sample_period =3D period,
> >   		};
> >=20
> >   		if (syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0) < 0)
> >   			die("perf_event_open");
> >   	}
> >   	while (!atomic_load(&stop)) {
> >   		int fd;
> >=20
> >   		unlink(DIR "/ocrace");
> >   		fd =3D open(DIR "/ocrace", O_CREAT | O_RDWR | O_CLOEXEC, 0644);
> >   		if (fd >=3D 0)
> >   			close(fd);
> >   		atomic_fetch_add(&creates, 1);
> >   	}
> >   	return NULL;
> >   }
> >=20
> >   static void *reader(void *arg)
> >   {
> >   	char lnk[64];
> >=20
> >   	snprintf(lnk, sizeof(lnk), DIR "/lnk.%ld", (long)arg);
> >   	while (!atomic_load(&stop)) {
> >   		int fd =3D open(lnk, O_CREAT | O_RDWR | O_CLOEXEC, 0644);
> >=20
> >   		if (fd >=3D 0)
> >   			close(fd);
> >   		else if (errno =3D=3D ENOENT)
> >   			atomic_fetch_add(&enoent, 1);
> >   		else
> >   			atomic_fetch_add(&other, 1);
> >   		atomic_fetch_add(&opens, 1);
> >   	}
> >   	return NULL;
> >   }
> >=20
> >   int main(int argc, char **argv)
> >   {
> >   	int secs =3D 60, nw =3D 4, nr =3D 12, c, n =3D 0;
> >   	pthread_t t[256];
> >=20
> >   	while ((c =3D getopt(argc, argv, "t:w:r:p:")) !=3D -1) {
> >   		switch (c) {
> >   		case 't': secs =3D atoi(optarg); break;
> >   		case 'w': nw =3D atoi(optarg); break;
> >   		case 'r': nr =3D atoi(optarg); break;
> >   		case 'p': period =3D atol(optarg); break;
> >   		default: return 2;
> >   		}
> >   	}
> >   	if (nw + nr > 256)
> >   		return 2;
> >   	mkdir(DIR, 0755);
> >   	if (mount("oc", DIR, "tmpfs", MS_STRICTATIME, "mode=3D0755"))
> >   		die("tmpfs");
> >   	for (long i =3D 0; i < nr; i++) {
> >   		char lnk[64];
> >=20
> >   		snprintf(lnk, sizeof(lnk), DIR "/lnk.%ld", i);
> >   		if (symlink("ocrace", lnk))
> >   			die("symlink");
> >   	}
> >   	for (long i =3D 0; i < nw; i++)
> >   		if (pthread_create(&t[n++], NULL, writer, NULL))
> >   			die("writer");
> >   	for (long i =3D 0; i < nr; i++)
> >   		if (pthread_create(&t[n++], NULL, reader, (void *)i))
> >   			die("reader");
> >   	sleep(secs);
> >   	atomic_store(&stop, 1);
> >   	for (int i =3D 0; i < n; i++)
> >   		pthread_join(t[i], NULL);
> >   	printf("%ds: %ld opens, %ld creates, ENOENT %ld, other errors %ld\n"=
,
> >   	       secs, atomic_load(&opens), atomic_load(&creates),
> >   	       atomic_load(&enoent), atomic_load(&other));
> >   	umount2(DIR, MNT_DETACH);
> >   	return atomic_load(&enoent) ? 1 : 0;
> >   }
> >=20
> >   diff --git a/fs/dcache.c b/fs/dcache.c
> >   --- a/fs/dcache.c
> >   +++ b/fs/dcache.c
> >   @@ -32,9 +32,13 @@
> >    #include <linux/bit_spinlock.h>
> >    #include <linux/rculist_bl.h>
> >    #include <linux/list_lru.h>
> >   +#include <linux/delay.h>
> >    #include "internal.h"
> >    #include "mount.h"
> >=20
> >   +/* debug: stall "ocrace*" names between ->d_inode and the type */
> >   +static int sysctl_ocrace_instantiate_us;
> >   +
> >    #include <asm/runtime-const.h>
> >=20
> >    /*
> >   @@ -200,6 +204,13 @@
> >    }
> >=20
> >    static const struct ctl_table fs_dcache_sysctls[] =3D {
> >   +	{
> >   +		.procname	=3D "ocrace_instantiate_us",
> >   +		.data		=3D &sysctl_ocrace_instantiate_us,
> >   +		.maxlen		=3D sizeof(int),
> >   +		.mode		=3D 0644,
> >   +		.proc_handler	=3D proc_dointvec,
> >   +	},
> >    	{
> >    		.procname	=3D "dentry-state",
> >    		.data		=3D &dentry_stat,
> >   @@ -405,6 +416,10 @@
> >    	unsigned flags;
> >=20
> >    	dentry->d_inode =3D inode;
> >   +	/* debug: an interrupt landing right here */
> >   +	if (unlikely(READ_ONCE(sysctl_ocrace_instantiate_us)) &&
> >   +	    !strncmp(dentry->d_name.name, "ocrace", 6))
> >   +		udelay(READ_ONCE(sysctl_ocrace_instantiate_us));
> >    	flags =3D READ_ONCE(dentry->d_flags);
> >    	flags &=3D ~DCACHE_ENTRY_TYPE;
> >    	flags |=3D type_flags;
> >=20
> > Fixes: e747e15156b7 ("fs: try an opportunistic lookup for O_CREAT opens=
 too")
> > Cc: stable@vger.kernel.org # v6.12+
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/namei.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index c87c14ee1a25..8f3517000b8b 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4750,8 +4750,12 @@ static struct dentry *lookup_fast_for_open(struc=
t nameidata *nd, int open_flag)
> >  		return dentry;
> > =20
> >  	if (open_flag & O_CREAT) {
> > -		/* Discard negative dentries. Need inode_lock to do the create */
> > -		if (!dentry->d_inode) {
> > +		/*
> > +		 * Discard negative dentries. Need inode_lock to do the create.
> > +		 * Look at the type like traverse_mounts() will. A dentry that
> > +		 * is being instantiated gets ->d_inode before its type.
> > +		 */
> > +		if (d_is_negative(dentry)) {
> >  			if (!(nd->flags & LOOKUP_RCU))
> >  				dput(dentry);
> >  			dentry =3D NULL;
> >=20
> > ---
> > base-commit: 0b5c87bbf2742347b4e593defbfeee2cde0a316d
> > change-id: 20261012-work-namei-ocreate-8ef7c8d7f960
>=20
> Nice catch. My only nit is that comments that include function names
> like traverse_mounts() are subject to bitrot. Personally, I'd just
> leave the comment alone.

Oops, clicked Send before doing this:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
