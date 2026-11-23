Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795453512;
	b=vF+VcNCJQ/VHPj8CM4F+9Ek0TEZo8ptuNlKmxHSUsTIcA47iP5hEP8NPUfp3zwSX4Cdx
	 HdyBppD+dKmyG558O5rOzj1lC6oOFhvTND/S+6wYjB4kYKBw8V6paTS+ePtje/Z+U9wpv
	 ZwrO96IJ57GtrDjik+mOoFvQuYaWO13Imr1chj1KqJ1CQYRDgZiJag/1WTsjFTu9QFXNf
	 +XAxW5bYfS7nNIQZOZFbrDHW1GbU+/bT5NWNcHtvPAGUS9O8A3CRgArOkH12RiJHqs/WI
	 lpVW8bZusWRMHoinpQTInqFtJmw3bAotIMMnWk//ItH1zXy+CwEp7u9WkiZZBXswFIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gIo6r+IlTGcpmO+YqtWN+p8Vb41yHG75b/8fYfmBgxI=;
	b=RZE+tbQ6P2JWfhgUF5TyZXzFkNWZlye0WoUi2cqNwGdC8AZxL14jaJuMp6fM7Hg+WcE4
	 mBEHgACtUAKyGmKuV3GCTCDwOfxXQB4fYOpeKx73wkqGfWS6gYJni2me+Ey9jgCf3jcxk
	 PCNQAM+n4Ry8lU6H45z0z3PPESQrOtNbdL7j0v8S5BtUg35+LQ8vhiwLkiBTjgSce6IID
	 /5f5Yqci1VzM/n7JFLJrRlgKN3EPnq+MGrdt0rR2n7MrhKk9V73bwpucFf+TDSxKaxqTe
	 mFAYfMBOmbCFhvUzbHTqZp7Ag+hZLtwF5XxxwLzi3UpF0MNGAUeWOtUUpIh2LqXQEVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wsz3TOv/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24E606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED24E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wsz3TOv/
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso2941137f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795453510; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5fJXHOtXHrzPxt1zgx4yOZP4UXi17bEvzYeYT+AMkSelSS4c5psSFDAV5dPPqnK4z
         CsuKn4QrquxgK+16E8vyS08PbYgwYae5qPuRsBJINoYHuSRDdgFlSKKUQNBGcMcl05Ew
         k/ga4bwQ7Jn8UDUF/Z7fF7Cn/QIs0jZNT2I4tqah2C18S0e6QGvk6ht5BblJOvOwBEPh
         cITlZY+weZnFHdfdPYbkO+xAS3cli9DQ/LDkVMsvECA5heauXEusPctjHtF5amqxNgI6
         m1BlQry21OoJEXKWmxk0ShyVeE8XgSG3yKYDNU5N2JUe1srk5MpnLX/UNysz3+xSdZdl
         yGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIo6r+IlTGcpmO+YqtWN+p8Vb41yHG75b/8fYfmBgxI=;
        fh=JK+MawPfHh11EwYfZuoxH3o+fWFvdZoYh7h2Z4xwZgE=;
        b=ZwycBsg83wwQrtAUOo3+P4R99qRAR1gNbW3MTQl+iIezg8Z3E+MpIdcv/MQmZXqh2J
         nxHV+AtAgtIB1y+gtV81vppI/984jZ981hxyFlMa67bo0wz5Ttr4n/q/BSvguvJM8yeu
         PBT+MPAMq2UZqqWJy/p7IfI2E4GLsdzb5Juoz5vCRddCmIXHVsVOQ4wiv98qvs+sGAYs
         cUNKpLUi6QpAWIe/FFk32kcWEiipuUDyY80RtDSSXHam9fEYLsR8QF3gGowynrhLXcwX
         tfoMELWxEHC+weA8jCK6PCMWXfBbC8MUByIM3tikWdor43s/bPbz4Vf9x0ptfAgYp72X
         AAGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795453510; x=1796058310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIo6r+IlTGcpmO+YqtWN+p8Vb41yHG75b/8fYfmBgxI=;
        b=wsz3TOv/BRrOlNOqNq2C5+FRN80XKknBMidIRbfRskX9JSGNoXG/mNuJTBX5K6EIFG
         g9eVLPoJ8mELRNE/GKy6Pso04j85619UVhw7YBP53tnBRwKxsIGRmC/lskHHH5Titjpj
         KoV/boaaJ0jXAwGCtZXwq1IC16XuyQU4dAheztk6O+y1ZOW2BSdWbdcx1kavjV4l9hJv
         Wcqzd/ocSvDp9EAePiDcJL0iz9r+2fir5Ju9jjLY/oRJRhMmwZ3ZIZHLJGbiyZUlJsAW
         eex5QUG0RDtwuD+yD0HupiGcIxGNcyNG9cdwvlRuU1+tl7YFGsGLP0PvShIOEm7fhwQZ
         ER7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453510; x=1796058310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIo6r+IlTGcpmO+YqtWN+p8Vb41yHG75b/8fYfmBgxI=;
        b=rG/hm4bP/8wRQuzv7fD8zT0QcdZy/kHtJ0zJ/NLpSxjPoq65MlcY1Md2sJivr84Gr/
         VlNctSXOLlaqiR6LiCmlqNWOz1qUwGVLCEu0A9lINde5eEbZoG1sfZyuYAaxLV7Af+VE
         2Jj2CpGKjaK2atboK79/rAOfzIdbK825SMg3Nt45fMi0SCKTOjDevK+yzppIKoOo35NK
         OIrfCk3DloceU/LGu7RLR339FHzWE5uJx23wiomTFvaZPZoIbEvxFM/4Nbxx0K74I3ha
         KEt2E6dTUjEhgY1jb1M56yJdzmMVBMbdGPAGnGrO8qVzls6P5RLdw0AnTkciv2m1Iq3V
         gf/w==
X-Forwarded-Encrypted: i=1; AL+hErFpWfbzoC5ogtzCcQqd0tSwSjMibLB/7IIz+0JzPpbNQXQg4CzwHg6MUPtKh8QW6DkGtbTpulw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2ZE3cqsbNIidKhD6vuQnOfDo4AItuHLRp9L3P/oZCtOeZvhn2
	l4JouX7JtUG9U6ZCvevWo15FrS7WEVG1SPC0jPMUdpiFd8caeN1YwYq+pyEVzWbU4+BMmKFR1x/
	Ck6l9Q9fYMsMjXC5fH1WLduQjAtUFd3Q=
X-Gm-Gg: AZFdTZdQqhTEtgavfxuemPQBCLCEVOm/UWVHg07HMIGnRBwWLycv+lnMlb61J7Q173m
	ZB6Vbh7mydhsx1j073fA+Pl5LDFZm2BkSqpJjjfag0GDoIfSqGNwcPZqLRQSeYhP7tNfHB1Qfcq
	pm6NjpiCwS0+EBeYEoBxkB4bdMH0+AsCsIThi4e4iUxyPP5rC93b0hrsB+K6xbxbcUkc4GMe6uJ
	xShCFK6zyJrEavR5rnhw9D4rsC9WSMH/xYFKGBNPTZRswNF+sN5OS5ERZgeS+6/ED03JUfKN9dX
	+l6tyqYr9PjhIE1ij3La3NBw+5aQ7yyn3gYjd3sYzENhRrY74ZPQ1gXUU+0PswFeafn7TGpdBzR
	vwx6xv6YsR3rVBlC9IobiLmoJK/15ug70U5y0oQ==
X-Received: by 2002:a05:6000:2c13:b0:4a7:9630:7b57 with SMTP id
 ffacd0b85a97d-4abb43dece6mr23714436f8f.44.1795453510025; Mon, 23 Nov 2026
 09:05:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122130247.2069007-1-hengyul@cs.unc.edu>
In-Reply-To: <20261122130247.2069007-1-hengyul@cs.unc.edu>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 24 Nov 2026 02:04:52 +0900
X-Gm-Features: Aa3M54qGyl-5nhX8w0MHT-aB71DD5ZloTtvWl-1mwjjKRU7JRZiwFoatqGxbJV8
Message-ID: <CAKFNMo=5c=TufoAFXfge_YDOF7RDXgetywO+6041k_xXhsFifw@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: count new blocks that a short copy leaves dirty
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 10:03=E2=80=AFPM Hengyu Liang wrote:
>
> Commit 665575cff098 ("filemap: move prefaulting out of hot write path")
> made generic_perform_write() fault in the source buffer only after a
> copy into the page cache has made no progress.  A write from memory
> that is not present yet now first calls ->write_end() with copied =3D=3D =
0,
> and copies again after the memory has been faulted in.
>
> However, nilfs_write_end() adds only the clean buffers of the copied
> range to the count of dirty blocks, while block_write_end() zero-fills
> and dirties the newly allocated buffers of the rest of the range.  The
> retry finds these buffers dirty, so the new blocks are never counted
> and nilfs_near_disk_full() does not stop the writer.  As of now, a
> write from a fresh anonymous mapping is accepted far beyond the free
> space, fsync() fails with ENOSPC, and the file is gone after a remount,
> together with the other changes made since the last log was written.
> On a volume shared with another user, that user's fsync() fails with
> ENOSPC too, and the files and directories that user created after the
> write are lost the same way.
>
> The issue can be reproduced on a 160 MiB disk with this program:
>
>     #include <errno.h>
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <string.h>
>     #include <sys/mman.h>
>     #include <unistd.h>
>
>     int main(int argc, char *argv[])
>     {
>             size_t len =3D atol(argv[2]) << 20;
>             /* fresh anonymous memory: none of its pages is present yet *=
/
>             char *buf =3D mmap(NULL, len, PROT_READ,
>                              MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>             int fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
>
>             printf("write: %zd\n", write(fd, buf, len));
>             printf("fsync: %s\n", fsync(fd) ? strerror(errno) : "ok");
>             return 0;
>     }
>
> and these commands:
>
>     mkfs.nilfs2 -q /dev/vda
>     mount -t nilfs2 /dev/vda /mnt
>     ./cold /mnt/f 256
>     umount /mnt
>     mount -t nilfs2 /dev/vda /mnt
>     wc -c /mnt/f
>
> Before commit 665575cff098 ("filemap: move prefaulting out of hot write
> path"), the result is:
>
>     write: 67518464
>     fsync: ok
>     67518464 /mnt/f
>
> After that commit, the result is:
>
>     write: 268435456
>     fsync: No space left on device
>     wc: /mnt/f: No such file or directory
>
> With this patch, the result is:
>
>     write: 70217728
>     fsync: ok
>     70217728 /mnt/f
>
> Count the buffers that block_write_end() is going to dirty, including
> the zero-filled new ones, before calling generic_write_end().
>
> Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> Cc: stable@vger.kernel.org # v6.14
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> I found this while comparing the behavior of different kernel versions.
> I used an LLM to analyze the problem and to draft the patch and this
> message, and I analyzed the result myself.
>
> Tested on nilfs2 for-next (8fef1a9dec7b) with KASAN and lockdep: after
> single writes (new, appended and overwritten blocks; cold, warm and
> unaligned sources; 4 KiB and 1 KiB blocks) dirty_data_blocks_count in
> sysfs grows by the number of blocks written, as on v6.8, and a nearly
> full volume stops such a write at the same size as on v6.8.
>
> A write into page cache pages that were read from a hole is not counted
> either, on v6.8 as well, because __block_write_begin_int() dirties the
> new buffers of an uptodate folio itself; this patch does not change that.

Hi Hengyu Liang,

Thank you for reporting the issue and proposing the patch.

Through reviewing your patch and testing with the reproducer, I
confirmed both the dirty block counting bug in nilfs_write_end() on
short copies and that your patch properly resolves it.

However, the short-copy handling in generic_write_end() and
block_write_end() was already present when nilfs2 was originally
introduced, and it appears that this bug in nilfs_write_end() -- which
skews the free space calculation and causes excessive consumption of
reserved segments -- has been latent since then.
I verified this locally on an older kernel using a reproducer that
intentionally triggers short copies via pwrite() from a buffer
straddling a readable page and a PROT_NONE page.

Could you please update the Fixes tag to point to the original nilfs2
implementation commit rather than 665575cff098, remove the kernel
version constraint from the Cc: stable tag, and revise the commit log
to state that the dirty-block counting bug has existed since the
original implementation, while commit 665575cff098 made it much easier
to reproduce?
Once updated, I will forward it to Viacheslav.

Thanks,
Ryusuke Konishi

>
>  fs/nilfs2/inode.c |  3 +--
>  fs/nilfs2/page.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/nilfs2/page.h  |  4 ++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index b217eee57c36..dd0bed24972a 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -249,8 +249,7 @@ static int nilfs_write_end(const struct kiocb *iocb,
>         unsigned int nr_dirty;
>         int err;
>
> -       nr_dirty =3D nilfs_page_count_clean_buffers(folio, start,
> -                                                 start + copied);
> +       nr_dirty =3D nilfs_page_count_buffers_to_dirty(folio, start, len,=
 copied);
>         copied =3D generic_write_end(iocb, mapping, pos, len, copied, fol=
io,
>                                    fsdata);
>         nilfs_set_file_dirty(inode, nr_dirty);
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index 857926da9f21..0dec7b5b27c4 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -481,6 +481,47 @@ unsigned int nilfs_page_count_clean_buffers(struct f=
olio *folio,
>         return nc;
>  }
>
> +/**
> + * nilfs_page_count_buffers_to_dirty - count buffers a write will dirty
> + * @folio:  folio being written to
> + * @from:   offset of the write in @folio
> + * @len:    number of bytes to be written
> + * @copied: number of bytes copied into @folio
> + *
> + * Count the clean buffers of @folio that block_write_end() is going to =
mark
> + * dirty: those overlapping the copied range and, after a short copy, th=
e
> + * newly allocated ones in the rest of the range, which it zero-fills.  =
As
> + * there, a short copy into a folio that is not uptodate counts as a
> + * zero-length write.
> + *
> + * Return: Number of buffers that the write changes from clean to dirty.
> + */
> +unsigned int nilfs_page_count_buffers_to_dirty(struct folio *folio,
> +                                              unsigned int from,
> +                                              unsigned int len,
> +                                              unsigned int copied)
> +{
> +       unsigned int to =3D from + len, end =3D from + copied;
> +       unsigned int block_start, block_end;
> +       struct buffer_head *bh, *head;
> +       unsigned int nc =3D 0;
> +
> +       if (copied < len && !folio_test_uptodate(folio))
> +               end =3D from;
> +
> +       for (bh =3D head =3D folio_buffers(folio), block_start =3D 0;
> +            bh !=3D head || !block_start;
> +            block_start =3D block_end, bh =3D bh->b_this_page) {
> +               block_end =3D block_start + bh->b_size;
> +               if (buffer_dirty(bh))
> +                       continue;
> +               if ((block_end > from && block_start < end) ||
> +                   (buffer_new(bh) && block_end > end && block_start < t=
o))
> +                       nc++;
> +       }
> +       return nc;
> +}
> +
>  /*
>   * NILFS2 needs clear_page_dirty() in the following two cases:
>   *
> diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
> index c3ba3468af5c..4ccd740966ec 100644
> --- a/fs/nilfs2/page.h
> +++ b/fs/nilfs2/page.h
> @@ -45,6 +45,10 @@ void nilfs_clear_folio_dirty(struct folio *folio, bool=
 force);
>  void nilfs_clear_dirty_pages(struct address_space *mapping, bool force);
>  unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
>                 unsigned int from, unsigned int to);
> +unsigned int nilfs_page_count_buffers_to_dirty(struct folio *folio,
> +                                              unsigned int from,
> +                                              unsigned int len,
> +                                              unsigned int copied);
>  unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
>                                             sector_t start_blk,
>                                             sector_t *blkoff);
>
> base-commit: 8fef1a9dec7bf58a29bc8a7ee6909ab629401cd3
> --
> 2.53.0
>
