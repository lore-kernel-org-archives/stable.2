Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523873;
	b=2E2KHIQq8sgw0Y0FpKtOXZwzDELjusj5tS+Z/cmfMFAKNrJMGLLTKg7Z2f3SmF11Pv5D
	 z7tOacRFWimUN7wGdO8J8fu6bV9XshtNYFiH0n/yWyS3YaKKywbDTpiliTDvEl+S3H10t
	 qJVRAS5mCnjazId45eiJ9IyJNwb9hG58vnncm0SYB9xCDT3snvKtncrYfAnC6uGUVGrvF
	 zX7CZn73PaX3Yk+AQKSh5hLQ6xIaI4puAMaaDZJMBLAWwHF1+OhgaONetubVw/RhF14EK
	 vRe/wSd5SJ72Wxe5k3xrnxPIG4fMWw/+E7Vbsbv4tmkBvRDD5FE59sA2YDBlHYsPRSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523873;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=CdsgRK2T0aSdGR26HR3wVuVY1ZtQy7Ic5TLZPWwxqBQ=;
	b=w7tYUBJ57dlRk1og2Oxd9a9W90FaygTI7aibNIBtMJsSPu684NRGgyUJXcg0G/T7zY5C
	 L9PYj9QLPyPfnX3TfNYcYyJQM590uk9uKDMzekrzkeb3D3Cehe/cEwSY4pMRM8qtaZMLt
	 SEHGRlsBeqktQwzrEqrtOx1nLinvijABHvnAJ+Mtjf1az1QDvm44ByVy5J24ov9mewfnF
	 Y52QtW3ZM/11OND1etK8TC8g5foAhw47n/k3rXlwPvcaaU3XIY7HEmhTYTAnki3ZAKsKe
	 V6z1OKWa30nA9D78wn6Usym61OeqQvTH5vZpbRqqy/YiMEE98hHcyPaIU9vPK4MmooA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=3rx2lxeyrrfkxfkrozb6utcmz4.protonmail2 header.b=EY5DX2J8;
	arc=none smtp.remote-ip=79.135.106.101
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B6606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 934B6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=3rx2lxeyrrfkxfkrozb6utcmz4.protonmail2 header.b=EY5DX2J8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3rx2lxeyrrfkxfkrozb6utcmz4.protonmail2; t=1795523868;
	x=1795783068; bh=CdsgRK2T0aSdGR26HR3wVuVY1ZtQy7Ic5TLZPWwxqBQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EY5DX2J85KyKU5pEdZi0kjG33mntUMylj7/hpgwJ03BxlK7ow7fBTiFtXFQKWi8Cc
	 OBzSwuPYXsoFrw/HW+bpZNnhxcf3lHr1gywUoJ1emahHl9oPyGCwA4HRu6KNm1xOAE
	 vW08E4ioxsWzboPVfQ4Dr7oRTPPhRhwvQ61hlrGz22xulL7tKuVemWdR4XmBxVZcrE
	 rFR1gK6twWuxC9RPWoeOhiGD7YCPJuJ5vwSMASJlcofmVYSrvGXrsVrhams6/6W1it
	 TGXK3rJHRt8AW0pg8Ww34pm2fenuZ8FOCPkX0YOSDcPtyvCWLJXUhRWAJQ4Mr/Je1w
	 Ucb2ymevHOAqw==
Date: Tue, 24 Nov 2026 12:37:38 +0000
To: liubaolin <liubaolin12138@163.com>
From: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org, hyc.lee@gmail.com, ernest.borowski.git@proton.me, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com, stable@vger.kernel.org
Subject: Re: [PATCH v9] ntfs: trim the sizes after a short write
Message-ID: <179552385440.2421003.16146153406926819876.b4-reply@b4>
In-Reply-To: <1b7886b3-0529-46b8-bed8-56d31d7305f5@163.com>
References: <20261124025932.2360848-1-zhanxusheng1024@gmail.com> <1b7886b3-0529-46b8-bed8-56d31d7305f5@163.com>
Feedback-ID: 236360163:user:proton
X-Pm-Message-ID: a8667dfb405c83cf9ef30a93b13fa92c540dab37
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

Hi Baolin, Xusheng,

On Tue, Nov 24, 2026 at 05:10:32PM +0800, liubaolin wrote:
> Could an async direct write still miss this cleanup if it fails after
> submitting some BIOs?

Yes.  I tested a 6 MiB O_DIRECT write at offset 0 into a file with
6 MiB reserved by FALLOC_FL_KEEP_SIZE (volume free space filled with
0xee, source buffer unmapped after 4 MiB).  Through io_submit(), the
write fails with -EFAULT, the file stays at 6 MiB, and the last 2 MiB
read back as 0xee, even after a remount.  The same write through
pwritev() returns -EFAULT to ntfs_file_write_iter(), where the rollback
that predates v9 resets the size to 0.

> Would using IOMAP_DIO_FORCE_WAIT for writes that advance
> initialized_size let us handle this through the existing rollback?

Yes.  With the forced wait, the async write reaches the rollback and
behaves like the sync one.  ext4 also waits for extending direct writes
and fails non-blocking ones (IOCB_NOWAIT, e.g. from io_uring) with
-EAGAIN before changing anything, so the caller retries them in
blocking mode.  ntfs needs the same -EAGAIN return so that the forced
wait does not block an io_uring submitter.  Resident attributes need it
too, since the write makes them non-resident first.  On top of v9:

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index f3bdc54595..86297a1633 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -762,12 +762,13 @@ static const struct iomap_dio_ops ntfs_write_dio_ops =
=3D {
 =09.end_io=09=09=09=3D ntfs_file_write_dio_end_io,
 };
=20
-static ssize_t ntfs_dio_write_iter(struct kiocb *iocb, struct iov_iter *fr=
om)
+static ssize_t ntfs_dio_write_iter(struct kiocb *iocb, struct iov_iter *fr=
om,
+=09=09=09=09   unsigned int dio_flags)
 {
 =09ssize_t ret;
=20
 =09ret =3D iomap_dio_rw(iocb, from, ntfs_dio_iomap_next,
-=09=09=09&ntfs_write_dio_ops, 0, NULL, 0);
+=09=09=09&ntfs_write_dio_ops, dio_flags, NULL, 0);
 =09if (ret =3D=3D -ENOTBLK)
 =09=09ret =3D 0;
 =09else if (ret < 0)
@@ -955,6 +956,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struc=
t iov_iter *from)
 =09if (ret <=3D 0)
 =09=09goto out_lock;
=20
+=09/*
+=09 * A direct write that moves the initialized size waits for its I/O
+=09 * (see ntfs_dio_write_iter() below), which a non-blocking one must
+=09 * not do, and a resident attribute is written through the page cache
+=09 * or made non-resident first.  Have the caller retry such a write
+=09 * blocking before anything is changed, as ext4 does for extending
+=09 * direct writes.
+=09 */
+=09if (iocb->ki_flags & IOCB_NOWAIT && iocb->ki_flags & IOCB_DIRECT &&
+=09    (!NInoNonResident(ni) ||
+=09     iocb->ki_pos + ret > ni->initialized_size)) {
+=09=09ret =3D -EAGAIN;
+=09=09goto out_lock;
+=09}
+
 =09err =3D ntfs_file_modified(iocb);
 =09if (err) {
 =09=09ret =3D err;
@@ -1001,8 +1017,17 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, str=
uct iov_iter *from)
 =09=09goto out;
 =09}
=20
+=09/*
+=09 * The sizes were moved to end before the I/O, and only the rollback
+=09 * at out: takes them back if the write fails.  An asynchronous write
+=09 * returns -EIOCBQUEUED once it has submitted bios and reports a later
+=09 * failure, such as a fault on its source or an I/O error, only on
+=09 * completion, which would skip the rollback.  Wait for such a write
+=09 * to complete.
+=09 */
 =09if (NInoNonResident(ni) && iocb->ki_flags & IOCB_DIRECT)
-=09=09ret =3D ntfs_dio_write_iter(iocb, from);
+=09=09ret =3D ntfs_dio_write_iter(iocb, from, end > old_init_size ?
+=09=09=09=09=09  IOMAP_DIO_FORCE_WAIT : 0);
 =09else
 =09=09ret =3D iomap_file_buffered_write(iocb, from, ntfs_write_iomap_next,
 =09=09=09=09&ntfs_iomap_folio_ops, NULL);

Results on ntfs-next f674e4b6c315 with 512 B, 4 KiB, 16 KiB and 64 KiB
clusters, on Ubuntu 26.04 and Arch Linux.  The async and sync cases
write three files per cluster size; the RWF_NOWAIT case is a fully
mapped 4 MiB pwritev2() into a zero-size file, either reserved or new
and empty ("-": not run):

                                        ntfs-next  + v9      + v9 + diff
  async write, old data readable        24 of 24   24 of 24  0 of 24
  sync write, old data readable         0 of 24    0 of 24   0 of 24
  RWF_NOWAIT, reserved file, -EAGAIN    -          0 of 8    8 of 8
  RWF_NOWAIT, new empty file, -EAGAIN   -          0 of 8    8 of 8
  killed_write_mmap                     FAIL       pass      pass
  short_write_size                      FAIL       pass      pass
  keep_size_short_write                 FAIL       pass      pass
  killed_short_write                    pass       pass      pass

  ntfs-next:              https://github.com/xerrni/linux-ntfs/actions/runs=
/45384651132
  ntfs-next + v9:         https://github.com/xerrni/linux-ntfs/actions/runs=
/45387762427
  ntfs-next + v9 + diff:  https://github.com/xerrni/linux-ntfs/actions/runs=
/45387767567

The test is tests/aio_dio_partial.sh (with tests/aio_dio_partial.c) and
the diff is patches/v9-dio-force-wait.diff in
https://github.com/xerrni/linux-ntfs.

The bug predates v9, but the fix is small and only extends this
patch's rollback to async writes, so I think it belongs in this patch
rather than in a follow-up.  Xusheng, could you fold it into v10?  My
Co-developed-by and Signed-off-by on v9 cover it too.

Thanks,
Ernest

