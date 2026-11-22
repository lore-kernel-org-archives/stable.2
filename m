Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371699;
	b=mehwhQOfiG62TVX/FOrE5m895TS97uMu7xy4LYOlto1vpupT8p53AJTqNyeHQ6G2CPtX
	 WN1yDhYZiUoayanof9Us/TWmdJFYz5ZFdky+DZTZX8ykWD6oOfiFK4pzGKOZFWnWJMK4g
	 L7CoYLLyACd8kYPQ0iO3cPh0mDF704f8h9Wy6PHeQMThfUauPs2os5kIVqVFkKlYywJTP
	 dcr+fKVltJqb5a5OdGPUgA6C8XDFxqkjX2MspJQ2OarBJxC9CH047WgKSkSPPJaJK3B3H
	 zW1TGApSEi8fr6qsvHkgA7maGz5BxcXoBockN6OFDoQ5mZiDvDGLabdi4G+F55DmVkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371699;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3z8LmMvyTb7V927J5J/vEzJ5VN1Hy4oZMJgZJYtszZA=;
	b=M8nJh3BoP4z48zhRAk32FNyK5cHoiGBRwNjWwdX+gIdKczxJtiLFTrUtod6hM8aC1Tn2
	 I2SvHlNime4DylMMHsh50nF6Gy6+r0MSt1dsRiizEvbVsWoKAZo77f4tJPiKVmGJaFjL/
	 nWsQWEHW1AUwVX8MezAg6jEGTDhJU+uRyk1zn5Ej7DFYLzmnDoGA10q3WKGyPiJmtXL26
	 lss3J1naRXroGeN04zbNWNq0Nx4WXBnuTtWA2nN/yMkgl6EmKxD1Pz11850qypQsdwrP3
	 +wzgNhY5maeqoHUfi6VS91xjhi/GxUOpUllqJl7W1lGYc9CVwyjQ+M7puAWGyNfGNxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ftyjk5u2rjdkzee2k64x2fjvp4.protonmail2 header.b=W4PAgOHz;
	arc=none smtp.remote-ip=185.70.43.166
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDC7606A334
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FDC7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ftyjk5u2rjdkzee2k64x2fjvp4.protonmail2 header.b=W4PAgOHz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ftyjk5u2rjdkzee2k64x2fjvp4.protonmail2; t=1795371695;
	x=1795630895; bh=3z8LmMvyTb7V927J5J/vEzJ5VN1Hy4oZMJgZJYtszZA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W4PAgOHzBr7V5/mwaJ8hbnTpM93a6txVNSujmJ6Sf9d/DHMrwOVBGr+tugWj5JP/A
	 vusjRQ8WxrbFvTOmlUuFc4ch7bIgtt8+BusPcsVhgXzwIrVkQ/Ec56hSmtRuyyIg+C
	 q/b/lB/sHU1eKGxIGScOSeofh6eq1sCMeYi8xdT8kXpYJjmQRaam2rLQUA2VvjOpdS
	 cyftgos1Ql798byQ9sdJ3ZEN5YgCEjnQ1yZNmfMzdGYe0A8jrxSWla9MrBvgr5kqGn
	 uGX5BlMTUAVGKdlmDZd+CbLIQfdWHGMDdDPZAbSsDE4O2VwbPgACzjWx4t//8E6IV7
	 4hZwgZ9E57+DA==
Date: Sun, 22 Nov 2026 18:21:27 +0000
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
From: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: linkinjeon@kernel.org, hyc.lee@gmail.com, liubaolin12138@163.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH v8] ntfs: trim the sizes after a short write
Message-ID: <179537167473.2649834.14001007738076272792.b4-reply@b4>
In-Reply-To: <20261120023504.4134966-1-zhanxusheng1024@gmail.com>
References: <20261120023504.4134966-1-zhanxusheng1024@gmail.com>
Feedback-ID: 236360163:user:proton
X-Pm-Message-ID: 5d499b5daac2baa6fe99a4f0b3ba1d1cadc0a334
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zhan,

I tested v8 on ntfs-next (f674e4b6c315) in QEMU, on a kernel with KASAN,
lockdep and UBSAN, at 512 B, 4 KiB, 16 KiB and 64 KiB clusters. It fixes
the file size after an ENOSPC short write, keeps FALLOC_FL_KEEP_SIZE
space, and fixes a short copy into allocated clusters past the initialized
size, which on ntfs-next leaves the uncopied part of the write reading the
old contents of those clusters.

One case loses data. It needs a writer killed during its copy, and a
shared writable mapping created while the write is stalled:

> +=09=09=09if (zend > zstart) {
> +=09=09=09=09err =3D iomap_zero_range(vi, zstart,
> +=09=09=09=09=09=09zend - zstart, NULL,
> +=09=09=09=09=09=09ntfs_seek_iomap_next,
> +=09=09=09=09=09=09&ntfs_iomap_folio_ops, NULL);

iomap_write_begin() returns -EINTR at once when fatal_signal_pending(), so
for a writer that got SIGKILL this zeroing always fails, and the fallback
then does

> +=09=09=09=09new_init_size =3D min3(ni->initialized_size,
> +=09=09=09=09=09=09     zstart, new_data_size);

followed by truncate_pagecache_range(vi, new_init_size, ...) up to i_size.
Meanwhile ntfs_file_mmap_prepare() can have extended initialized_size to
i_size for a MAP_SHARED, PROT_WRITE mapping (it does not take the inode
lock, so it does not wait for the stalled writer), and the mapping can
have dirtied a page far past the write. That page is dropped from the
page cache and the initialized size is moved below it, so it reads back
as zeroes, also after fsync.

Reproducer: a file with old data in allocated clusters past its
initialized size (as Windows leaves it after SetFileValidData(); the test
sets the field on the image), pwrite() at offset 0 whose copy blocks on a
userfaultfd page after 16 KiB, mmap() of the file and a store at
i_size / 2, then SIGKILL to the writer. With v8 the 4 KiB page written
through the mapping is lost at every cluster size; without v8 the
mapping keeps its data but [16 KiB, 64 KiB) shows the old contents.

Zeroing from a worker when the caller has a fatal signal pending fixes
it. Something like this on top of v8:

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 25034735d2..a65892bb08 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -22,6 +22,7 @@
 #include <linux/overflow.h>
 #include <linux/security.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/ntfs.h>
=20
 #include "lcnalloc.h"
@@ -871,6 +872,52 @@ static loff_t ntfs_allocated_end_on_disk(struct ntfs_i=
node *ni)
 =09return end;
 }
=20
+struct ntfs_zero_work {
+=09struct work_struct work;
+=09struct inode *inode;
+=09loff_t pos;
+=09loff_t len;
+=09int err;
+};
+
+static void ntfs_zero_workfn(struct work_struct *work)
+{
+=09struct ntfs_zero_work *zw =3D container_of(work, struct ntfs_zero_work,
+=09=09=09=09=09=09 work);
+
+=09zw->err =3D iomap_zero_range(zw->inode, zw->pos, zw->len, NULL,
+=09=09=09=09   ntfs_seek_iomap_next, &ntfs_iomap_folio_ops,
+=09=09=09=09   NULL);
+}
+
+/*
+ * iomap_zero_range() gives up with -EINTR when the caller has a fatal sig=
nal
+ * pending, and a writer killed during its copy is one whose short write m=
ust
+ * still be zeroed: zero from a worker then, which has no signal to see.  =
The
+ * caller holds the invalidate lock, which keeps page faults out meanwhile=
.
+ */
+static int ntfs_zero_range_unkillable(struct inode *inode, loff_t pos,
+=09=09=09=09      loff_t len)
+{
+=09struct ntfs_zero_work zw =3D { .inode =3D inode, .pos =3D pos, .len =3D=
 len };
+=09int err;
+
+=09if (!fatal_signal_pending(current)) {
+=09=09err =3D iomap_zero_range(inode, pos, len, NULL,
+=09=09=09=09       ntfs_seek_iomap_next,
+=09=09=09=09       &ntfs_iomap_folio_ops, NULL);
+=09=09/* the signal may also come while it zeroes */
+=09=09if (err !=3D -EINTR || !fatal_signal_pending(current))
+=09=09=09return err;
+=09}
+
+=09INIT_WORK_ONSTACK(&zw.work, ntfs_zero_workfn);
+=09queue_work(system_unbound_wq, &zw.work);
+=09flush_work(&zw.work);
+=09destroy_work_on_stack(&zw.work);
+=09return zw.err;
+}
+
 ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 =09struct file *file =3D iocb->ki_filp;
@@ -1000,10 +1047,8 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, str=
uct iov_iter *from)
=20
 =09=09=09zend =3D min(zend, new_data_size);
 =09=09=09if (zend > zstart) {
-=09=09=09=09err =3D iomap_zero_range(vi, zstart,
-=09=09=09=09=09=09zend - zstart, NULL,
-=09=09=09=09=09=09ntfs_seek_iomap_next,
-=09=09=09=09=09=09&ntfs_iomap_folio_ops, NULL);
+=09=09=09=09err =3D ntfs_zero_range_unkillable(vi, zstart,
+=09=09=09=09=09=09=09=09 zend - zstart);
 =09=09=09=09/* A direct read must not see the old blocks. */
 =09=09=09=09if (!err && iocb->ki_flags & IOCB_DIRECT)
 =09=09=09=09=09err =3D filemap_write_and_wait_range(

With it the test passes at all four cluster sizes, and the tests for the
ENOSPC short write size, FALLOC_FL_KEEP_SIZE and a writer killed inside
a cluster that was a hole still pass. The same five tests on the same
ntfs-next commit, each run on Ubuntu 26.04 and on Arch Linux:

  ntfs-next:                 https://github.com/xerrni/linux-ntfs/actions/r=
uns/45025520955
  ntfs-next + v8:            https://github.com/xerrni/linux-ntfs/actions/r=
uns/45025527902
  ntfs-next + v8 + the diff: https://github.com/xerrni/linux-ntfs/actions/r=
uns/45025534974

                          ntfs-next   + v8   + v8 + diff
  killed_write_mmap       FAIL        FAIL   pass
  short_write_size        FAIL        pass   pass
  keep_size_short_write   FAIL        pass   pass
  killed_short_write      pass        pass   pass
  short_copy_stale        FAIL        FAIL   FAIL

short_copy_stale fails at 4 KiB clusters in all three: a short copy into
a hole still shows old data there, with or without v8. That is a
separate bug; patch 7 of the series I just posted [1] fixes it. With v8,
the diff above and that series, all five tests pass:

  https://github.com/xerrni/linux-ntfs/actions/runs/45029305849

Patch 7 has the same kind of helper in fs/ntfs/iomap.c, so whichever
lands second can share one copy.

To run the test on your own tree, locally (needs KVM, QEMU, what a kernel
build needs, gcc with a static libc, mkntfs from ntfs-3g and python3, but
not root; the README lists the packages):

  git clone https://github.com/xerrni/linux-ntfs && cd linux-ntfs
  vm/build_kernel.sh /path/to/linux ../build
  tests/run_reproducers.sh ../build ../work killed_write_mmap.sh

It prints one line per test with the PASS and FAIL counts and the first
FAIL line; the guest logs are in ../work/killed_write_mmap/. Or with
nothing installed: fork the repository, enable Actions in the fork and
run its test-kernel workflow, which takes a kernel repository and branch,
patches (lore links work, b4 fetches them) and the tests to run, e.g.

  gh workflow run test-kernel.yml -R <you>/linux-ntfs \
    -f repo=3D<your tree> -f ref=3D<branch> -f tests=3Dkilled_write_mmap

The diff above is patches/v8-zero-for-a-killed-writer.diff in that
repository. If v8 is already queued, I can send it as a separate patch
on top instead.

Thanks,
Ernest

[1] https://lore.kernel.org/all/20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0=
dce403@proton.me/

