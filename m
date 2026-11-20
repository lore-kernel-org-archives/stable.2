Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169891;
	b=lqE/LfB42mu/JLM6YPny86YBEAxmqDR1aXabiCGTwCWHigx9VhaJslGhF62/n3Fn4bDv
	 KirdrMAQVdc4jdF0/MxLSs7PrssFHDg0AgPUSHbhKpNvt5A9KTNGn7V+uEif+Ebg2DmW/
	 +vTD6rwi8y9P21l4knLQ2tFApJ40Vm3HxTnuXX2vlk2sw9sN1C94K+4h4fsMw7Fvxj02V
	 vNjh4KtOnZJj1qK4Vi68fKXndABK+/AeoFGm8IN3ArdqPSMdMOvz/Z5Nfrjki7Z6lwZ51
	 yNsH3ecoeLQpnuAJzz7G2UMQLMjffoUf9T83phfpUvVOv4kK4V/J+TueazAodHzWvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169891;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=91aSG4C3xDj7rNipux5lI7AnWD+3hz8cV70eKCK0A3Y=;
	b=stNJLw11W5IMhYUEFho/W6Z1jNySzvnS+Gw9lyYsfNZ+Z5WkQRTQnj/ZdIDQ7bN7ln0+
	 2f2iMXFzn/v5lNLt2QfdY8EgxGFCOGds52mgENDXTr/I2WVI2uVZDGfZtBIcxhuNDoABo
	 x9VXKOjD+nKNNaLyxltUq5A8fF+Oi+v/mhB44uCcDupnhkDjpVQuy14uHkT7ZDfrZQofX
	 6xnmUnSa2FqBJR6QBGTgQuQfRR5T2puhe3DNQ0ZnubUap8iryjB34nsRz8nhsvTPI75B6
	 oI3HHZF9g22DBosQzi8t6UsR8WPKqmmhmJJ4JLW0u3KD4sS6hBm7DbaE+O18ldYWu6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LMDZJNKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91E606A320;
	Fri, 20 Nov 2026 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LMDZJNKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4421F000CF;
	Fri, 20 Nov 2026 10:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795169890;
	bh=91aSG4C3xDj7rNipux5lI7AnWD+3hz8cV70eKCK0A3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LMDZJNKP3WhrzcLhiGmKo6B2KkXY5JuEVE3bD/AeAxLSQahDxrOspDslHBGaeyaug
	 cXKghlblt4VBw/sWnXKfJk/fU9Oi5louyLXTvJ5pmCEMmHrMZA3Bet7MIWSZnRy6VR
	 zvMvVn5qldvnD6hPq8izYmGEpYAvVGzvQ8yEkdGM=
Date: Fri, 20 Nov 2026 11:18:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: linux-usb@vger.kernel.org, Neill Kapron <nkapron@google.com>,
	=?utf-8?Q?Micha=C5=82?= Nazarewicz <mina86@mina86.com>,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+6227549bd2c8a1ec8ba0@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: f_fs: fix use-after-free of ffs_dev in
 ffs_free_inst()
Message-ID: <2026112029-depletion-small-f290@gregkh>
References: <20261006204202.59604-1-raghunathpalla.0209@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006204202.59604-1-raghunathpalla.0209@gmail.com>

On Tue, Oct 06, 2026 at 09:42:02PM +0100, Palla Raghunath wrote:
> When a function instance is removed through configfs, ffs_free_inst()
> first calls ffs_release_dev(), which takes ffs_dev_lock, detaches the
> dev from its mount and drops the lock again. Only then does it retake
> the lock and free the dev with _ffs_free_dev().
> 
> Between those two steps the dev is still on the ffs_devices list. If
> someone mounts functionfs with the same instance name right then,
> ffs_acquire_dev() finds the dev, marks it mounted and points the new
> ffs_data at it. The dev is freed a moment later, and when that mount
> is torn down, ffs_closed() writes to freed memory. syzbot hit this:
> 
>   BUG: KASAN: slab-use-after-free in ffs_closed drivers/usb/gadget/function/f_fs.c:4427 [inline]
>   BUG: KASAN: slab-use-after-free in ffs_data_clear+0x543/0x5b0 drivers/usb/gadget/function/f_fs.c:2305
>   Write of size 1 at addr ffff8880237b1e4a by task syz-executor/11910
>   Call Trace:
>    ffs_closed drivers/usb/gadget/function/f_fs.c:4427 [inline]
>    ffs_data_clear+0x543/0x5b0 drivers/usb/gadget/function/f_fs.c:2305
>    ffs_data_reset drivers/usb/gadget/function/f_fs.c:2336 [inline]
>    ffs_fs_kill_sb+0x84/0x370 drivers/usb/gadget/function/f_fs.c:2180
>    deactivate_locked_super+0xbe/0x110 fs/super.c:586
>    cleanup_mnt+0x3d3/0x460 fs/namespace.c:1329
>   ...
>   Freed by task 17408:
>    kfree+0x1c5/0x650 mm/slub.c:6923
>    _ffs_free_dev drivers/usb/gadget/function/f_fs.c:4336 [inline]
>    ffs_free_inst+0x233/0x2c0 drivers/usb/gadget/function/f_fs.c:4152
>    usb_put_function_instance+0x95/0xc0 drivers/usb/gadget/functions.c:77
>    config_item_release+0x13a/0x2d0 fs/configfs/item.c:137
>    configfs_rmdir+0x885/0x950 fs/configfs/dir.c:1580
> 
> Fix it by doing the release and the free while holding the lock once.
> To allow that, move the body of ffs_release_dev() into a new
> _ffs_release_dev() that expects the lock to be held already, and keep
> ffs_release_dev() as a wrapper for ffs_data_put(). A racing mount now
> either gets the dev before ffs_free_inst() runs, in which case the
> release clears its pointer, or doesn't find the dev at all.
> 
> I was able to reproduce this in QEMU with a small program that keeps
> creating and removing an ffs function directory in configfs while a
> second thread mounts and unmounts functionfs with the same name. On an
> unpatched kernel it hit the same KASAN report within about ten
> minutes. With this patch applied, the same program ran for 30 minutes
> without any problem.
> 
> Fixes: ecfbd7b9054b ("usb: gadget: f_fs: Fix setting of device and driver data cross-references")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+6227549bd2c8a1ec8ba0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6227549bd2c8a1ec8ba0
> Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index c64a268e98a4..f8ea9a980605 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -288,6 +288,7 @@ static struct ffs_dev *_ffs_find_dev(const char *name);
>  static struct ffs_dev *_ffs_alloc_dev(void);
>  static void _ffs_free_dev(struct ffs_dev *dev);
>  static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
> +static void _ffs_release_dev(struct ffs_dev *ffs_dev);

> -static void ffs_release_dev(struct ffs_dev *ffs_dev)
> +/*
> + * Same as ffs_release_dev(), for callers that already hold ffs_dev_lock.
> + */
> +static void _ffs_release_dev(struct ffs_dev *ffs_dev)

Then enforce the lock being held here by telling the compiler that it
must be held.

thanks,

greg k-h
