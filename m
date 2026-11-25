Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577150;
	b=Jm0y+9bfB0d0+cIO+0Un2nb8QpbGLO/vvONjo99al1cIN3UWVmzhODUi4BVKqtPvy8ok
	 d2kOKRN4DvLYcJPb89sDZShHeaSdCsGysOVf8DNoK+jYCi+AB1nfNpIXSXMXU6B3fydx9
	 eiSAqyXQpTdHQV2dp+XqQa0ApgFH1f3TiJT9pjgQWlCTHvPbrDUSRez/ah/bR0D6gc+7g
	 DpjloEjDtK0gsuYfDibTpAu25ZLy2mqu0s6Z50mW7bvFnskWNx6epYx4GyGoki2s8b8/P
	 oE+RgJTDb8Ktes4s721lPcGJkWzuR9iiGPLBwdOwxUExGZpiOaCI1a4QaM81fOfqINw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577150;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=tC8xcrm3ejU9CdNZ6nVE0qye16pWf3mz7U1WG3ag+Sw=;
	b=V88DmsRXhJXLktRLDp63ZvVEFYzWWQfNZiTnB+9EsqGD/wvQNoTvx3iKpinz1FKUctUu
	 f0nIAdjWGUg1gPl4iEWhGwfBTM1v69qkcxvwyJPQ/E7pzMjtd26uJAy3WUK76Oz9B3BfK
	 JoE9WMsdcs/X0ZapvsK4LNCVRav0dwZADHP+7eGMrP/KenjZtbeXPcex0HIo10GhBD4zx
	 H9OmtysZLcpaRUmQzgQH+/3QpgqIaoh4mklgZ3AeIIMteETg1vaerm93fMDYLuzwnncW2
	 Y5HPy8U+mfN0wlxhQ04jfO60cIynH3V80Aax2HvQYqCxngi4QatCxs3U8yqGnx5BfrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EgOIVQK0;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C7606A327;
	Wed, 25 Nov 2026 03:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA9C7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EgOIVQK0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=tC8xcrm3ejU9CdNZ6nVE0qye16pWf3mz7U1WG3ag+Sw=;
	b=EgOIVQK0kNJ5jP4udtd3YF5sKBHfXysrDkywMAStCn66xtE/s/XcYNXKgZp7CD
	3ca1bJG669qGtYCBHoVRRPlIdr1sdD6H47yBroVP4NuEdznCSnUYK9napvUgb7I2
	0gIUh0cjqLPkbfqzLCivvBopunbw1WVLD7Wr27KDo50DI=
Received: from [IPV6:2409:8900:1a90:8163:30cc:9d3c:47b5:d01f] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXXywVVQZr+f9OKA--.44825S2;
	Wed, 25 Nov 2026 11:25:10 +0800 (CST)
Message-ID: <4c9826bf-a0c1-4d6b-9b6b-a2e2bc88a8ce@163.com>
Date: Wed, 25 Nov 2026 11:25:09 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] ntfs: trim the sizes after a short write
To: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, linkinjeon@kernel.org,
 hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com, stable@vger.kernel.org
References: <20261124025932.2360848-1-zhanxusheng1024@gmail.com>
 <1b7886b3-0529-46b8-bed8-56d31d7305f5@163.com>
 <179552385440.2421003.16146153406926819876.b4-reply@b4>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <179552385440.2421003.16146153406926819876.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXXywVVQZr+f9OKA--.44825S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw1xJr1kKrWDur1kCFWxZwb_yoW7XrWrpF
	9I9F9IkFs2yr4xGrn7Ka1UXa1F9rZ8JrW3JFyUWa1UZr9xCwn2vF17KFWY9FW0y392q3y5
	JF4vv3ykAryDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhFxUUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6ha2gWsGVRY3HwAA3N



在 2026/11/24 20:37, Ernest Borowski 写道:
> Hi Baolin, Xusheng,
> 
> On Tue, Nov 24, 2026 at 05:10:32PM +0800, liubaolin wrote:
>> Could an async direct write still miss this cleanup if it fails after
>> submitting some BIOs?
> 
> Yes.  I tested a 6 MiB O_DIRECT write at offset 0 into a file with
> 6 MiB reserved by FALLOC_FL_KEEP_SIZE (volume free space filled with
> 0xee, source buffer unmapped after 4 MiB).  Through io_submit(), the
> write fails with -EFAULT, the file stays at 6 MiB, and the last 2 MiB
> read back as 0xee, even after a remount.  The same write through
> pwritev() returns -EFAULT to ntfs_file_write_iter(), where the rollback
> that predates v9 resets the size to 0.
> 
>> Would using IOMAP_DIO_FORCE_WAIT for writes that advance
>> initialized_size let us handle this through the existing rollback?
> 
> Yes.  With the forced wait, the async write reaches the rollback and
> behaves like the sync one.  ext4 also waits for extending direct writes
> and fails non-blocking ones (IOCB_NOWAIT, e.g. from io_uring) with
> -EAGAIN before changing anything, so the caller retries them in
> blocking mode.  ntfs needs the same -EAGAIN return so that the forced
> wait does not block an io_uring submitter.  Resident attributes need it
> too, since the write makes them non-resident first.  On top of v9:
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index f3bdc54595..86297a1633 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -762,12 +762,13 @@ static const struct iomap_dio_ops ntfs_write_dio_ops = {
>   	.end_io			= ntfs_file_write_dio_end_io,
>   };
>   
> -static ssize_t ntfs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +static ssize_t ntfs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
> +				   unsigned int dio_flags)
>   {
>   	ssize_t ret;
>   
>   	ret = iomap_dio_rw(iocb, from, ntfs_dio_iomap_next,
> -			&ntfs_write_dio_ops, 0, NULL, 0);
> +			&ntfs_write_dio_ops, dio_flags, NULL, 0);
>   	if (ret == -ENOTBLK)
>   		ret = 0;
>   	else if (ret < 0)
> @@ -955,6 +956,21 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret <= 0)
>   		goto out_lock;
>   
> +	/*
> +	 * A direct write that moves the initialized size waits for its I/O
> +	 * (see ntfs_dio_write_iter() below), which a non-blocking one must
> +	 * not do, and a resident attribute is written through the page cache
> +	 * or made non-resident first.  Have the caller retry such a write
> +	 * blocking before anything is changed, as ext4 does for extending
> +	 * direct writes.
> +	 */
> +	if (iocb->ki_flags & IOCB_NOWAIT && iocb->ki_flags & IOCB_DIRECT &&
> +	    (!NInoNonResident(ni) ||
> +	     iocb->ki_pos + ret > ni->initialized_size)) {
> +		ret = -EAGAIN;
> +		goto out_lock;
> +	}
> +
>   	err = ntfs_file_modified(iocb);
>   	if (err) {
>   		ret = err;
> @@ -1001,8 +1017,17 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		goto out;
>   	}
>   
> +	/*
> +	 * The sizes were moved to end before the I/O, and only the rollback
> +	 * at out: takes them back if the write fails.  An asynchronous write
> +	 * returns -EIOCBQUEUED once it has submitted bios and reports a later
> +	 * failure, such as a fault on its source or an I/O error, only on
> +	 * completion, which would skip the rollback.  Wait for such a write
> +	 * to complete.
> +	 */
>   	if (NInoNonResident(ni) && iocb->ki_flags & IOCB_DIRECT)
> -		ret = ntfs_dio_write_iter(iocb, from);
> +		ret = ntfs_dio_write_iter(iocb, from, end > old_init_size ?
> +					  IOMAP_DIO_FORCE_WAIT : 0);
>   	else
>   		ret = iomap_file_buffered_write(iocb, from, ntfs_write_iomap_next,
>   				&ntfs_iomap_folio_ops, NULL);
> 
> Results on ntfs-next f674e4b6c315 with 512 B, 4 KiB, 16 KiB and 64 KiB
> clusters, on Ubuntu 26.04 and Arch Linux.  The async and sync cases
> write three files per cluster size; the RWF_NOWAIT case is a fully
> mapped 4 MiB pwritev2() into a zero-size file, either reserved or new
> and empty ("-": not run):
> 
>                                          ntfs-next  + v9      + v9 + diff
>    async write, old data readable        24 of 24   24 of 24  0 of 24
>    sync write, old data readable         0 of 24    0 of 24   0 of 24
>    RWF_NOWAIT, reserved file, -EAGAIN    -          0 of 8    8 of 8
>    RWF_NOWAIT, new empty file, -EAGAIN   -          0 of 8    8 of 8
>    killed_write_mmap                     FAIL       pass      pass
>    short_write_size                      FAIL       pass      pass
>    keep_size_short_write                 FAIL       pass      pass
>    killed_short_write                    pass       pass      pass
> 
>    ntfs-next:              https://github.com/xerrni/linux-ntfs/actions/runs/45384651132
>    ntfs-next + v9:         https://github.com/xerrni/linux-ntfs/actions/runs/45387762427
>    ntfs-next + v9 + diff:  https://github.com/xerrni/linux-ntfs/actions/runs/45387767567
> 
> The test is tests/aio_dio_partial.sh (with tests/aio_dio_partial.c) and
> the diff is patches/v9-dio-force-wait.diff in
> https://github.com/xerrni/linux-ntfs.
> 
> The bug predates v9, but the fix is small and only extends this
> patch's rollback to async writes, so I think it belongs in this patch
> rather than in a follow-up.  Xusheng, could you fold it into v10?  My
> Co-developed-by and Signed-off-by on v9 cover it too.
> 
> Thanks,
> Ernest

Hi Ernest,
   Thanks for reproducing this and for the fix and thorough testing.
   I agree that folding this into v10 makes sense.

Thanks,
Baolin

