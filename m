Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A802DD60E;
	Wed, 10 Jun 2026 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058400; cv=none; b=Km7p1z7wx+vnt3/LnSG5rbPC9GmRWQsjGwKXfSSU1PqRl8MHqNMLBdBwC28j1Cp/H5GCAULKaBcQhX/mkGB21ekXsIEyGc1RGUifDRNHW6HwfcwM3mYqDcYchI8SiwAMhZ+OgUmVyJS/PpMfftIPawI2qoVvwFAIAsj3lVBSPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058400; c=relaxed/simple;
	bh=8EYQLkpO5Udc492Ko+dgbbkfrmLO2XwE2Pf8yARu0c8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0lWeYTHV7oO4zBCpf9LKGZfj3Zu0YVyJ5qiVROCZRwBN8DSOH32+9JMwtUW60B8jrvxCpA0WfX5mcBwEHYv3zRftDWIdmDD7Ffb9PqXEAY/BPq0UGREuYpyT6Nqi20RUYJXJHzRGzIi0LK3kHTyf5aI8dTU35nwAtg0ITC2pT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nAPENbWl; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nAPENbWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781058389;
	bh=jv0HD0eGv0qPg6iGVBj10nHoDRm9zAdKO2FRbjIunyQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nAPENbWlXsaOxC7cEGzRp2W+9J+GQNQ/QiOaOCPOJbUlt9wtOMOd2v0ya5XHwm4AC
	 knQMKsrjmB6FStM8SJVR489rkmNRc/tMyF9Nd8HofsoBTpuS3kyvit4rSr3/nGX/x3
	 QmSuRYEymf9w4R5mbFJ+WRId4HVG6GX0pCCOQTBfls0iK0Z9wev9r/sGoHgkQg10vg
	 g/cK1cp9nZ6Qo8mQbIMqJC1Q1cKk5P4CSygYgF6Qm0Mq6eJjL8+b3E0GIGxTqesYrs
	 cOWXspkx8zkLLmTXmlIr5PAGBxeJQeqlbh8MSYdhIgPf2Zs+igcK84xNGnw2FP8qZ+
	 uDp5DeZcsrLgg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1565760A0E;
	Wed, 10 Jun 2026 10:26:29 +0800 (AWST)
Message-ID: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 10 Jun 2026 11:56:28 +0930
In-Reply-To: <20260601125214.2071019-1-karthiproffesional@gmail.com>
References: 
	<1e2b77c7916259e3e269d19f637c29427c175350.camel@codeconstruct.com.au>
	 <20260601125214.2071019-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Karthikeyan,

On Mon, 2026-06-01 at 12:52 +0000, Karthikeyan KS wrote:
> put_fifo_with_discard() acts as both producer and consumer on the kfifo:
> it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
> the IRQ handler without synchronizing with snoop_file_read(), which also
> consumes via kfifo_to_user(). On SMP systems this concurrent access can
> leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clam=
p
> to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
> copy_to_user() past the kmalloc-2k backing store:
>=20
> =C2=A0 usercopy: Kernel memory exposure attempt detected from SLUB object
> =C2=A0 'kmalloc-2k' (offset 0, size 2049)!
> =C2=A0 kernel BUG at mm/usercopy.c!
> =C2=A0 Call trace:
> =C2=A0=C2=A0 usercopy_abort
> =C2=A0=C2=A0 __check_heap_object
> =C2=A0=C2=A0 __check_object_size
> =C2=A0=C2=A0 kfifo_copy_to_user
> =C2=A0=C2=A0 __kfifo_to_user
> =C2=A0=C2=A0 snoop_file_read
> =C2=A0=C2=A0 vfs_read
>=20
>=20
> Serialize kfifo access with a per-channel spinlock. copy_to_user()
> runs after dropping the lock, since it may sleep on a page fault.
>=20
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc ch=
ardev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
> ---
> Andrew,
>=20
> Thanks for the review.
>=20
> > This seems inappropriate and I expect is flagged if you compile with
> > CONFIG_PROVE_LOCKING=3Dy or CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
>=20
> v4 drains the kfifo into a kernel buffer via kfifo_out() under
> the lock, then performs copy_to_user() after dropping it.
> (cf. drivers/gpio/gpiolib-cdev.c, which drains under its event lock
> and copies outside it.)
>=20
> > ensure you develop, build and test on recent releases
>=20
> Tested on both v7.1-rc5 and v7.1-rc6 with PROVE_LOCKING,
> DEBUG_ATOMIC_SLEEP and HARDENED_USERCOPY enabled: read path
> round-trips correctly, no lockdep splats, no atomic-sleep
> warnings, no usercopy aborts.
>=20
> Changes since v3:
> - Replaced kfifo_to_user() with kfifo_out() + copy_to_user()
> =C2=A0 to avoid sleeping under spinlock
> - Rebased onto v7.1-rc6
>=20
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 24 ++++++++++++++++++++----
> =C2=A01 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/a=
speed-lpc-snoop.c
> index b03310c0830d..0fe463020e25 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -74,6 +74,7 @@ struct aspeed_lpc_snoop_channel_cfg {
> =C2=A0struct aspeed_lpc_snoop_channel {
> =C2=A0	const struct aspeed_lpc_snoop_channel_cfg *cfg;
> =C2=A0	bool enabled;
> +	spinlock_t		lock;
> =C2=A0	struct kfifo		fifo;
> =C2=A0	wait_queue_head_t	wq;
> =C2=A0	struct miscdevice	miscdev;
> @@ -115,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, cha=
r __user *buffer,
> =C2=A0{
> =C2=A0	struct aspeed_lpc_snoop_channel *chan =3D snoop_file_to_chan(file)=
;
> =C2=A0	unsigned int copied;
> +	u8 *buf;

Can use the cleanup helpers again here:

   u8 *buf __free(kfree) =3D NULL;

> =C2=A0	int ret =3D 0;
> =C2=A0
> =C2=A0	if (kfifo_is_empty(&chan->fifo)) {
> @@ -125,11 +127,22 @@ static ssize_t snoop_file_read(struct file *file, c=
har __user *buffer,
> =C2=A0		if (ret =3D=3D -ERESTARTSYS)
> =C2=A0			return -EINTR;
> =C2=A0	}
> -	ret =3D kfifo_to_user(&chan->fifo, buffer, count, &copied);
> -	if (ret)
> -		return ret;
> =C2=A0
> -	return copied;
> +	buf =3D kmalloc(SNOOP_FIFO_SIZE, GFP_KERNEL);

I expect using count clamped to SNOOP_FIFO_SIZE might be a better
option here? The clamp below can be moved here.

I'm not enamoured with the bounce buffer, but I guess it solves the
problem.

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spin_lock_irq(&chan->lock);
> +	copied =3D kfifo_out(&chan->fifo, buf,
> +			=C2=A0=C2=A0 min_t(size_t, count, SNOOP_FIFO_SIZE));

This is handled by kfifo_out() as discussed previously, but also see
the above. You may want to check that count doesn't exceed UINT_MAX
though, in the event that SIZE_MAX > UINT_MAX.

> +	spin_unlock_irq(&chan->lock);

Recently the kernel gained cleanup helpers. scoped_guard() would be
handy here, however the kfifo API also provides kfifo_out_spinlocked().
I'd use that as it is at least idiomatic.

> +
> +	ret =3D copied;
> +	if (copied && copy_to_user(buffer, buf, copied))
> +		ret =3D -EFAULT;
> +
> +	kfree(buf);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static __poll_t snoop_file_poll(struct file *file,
> @@ -153,9 +166,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_=
snoop_channel *chan, u8 val)
> =C2=A0{
> =C2=A0	if (!kfifo_initialized(&chan->fifo))
> =C2=A0		return;
> +	spin_lock(&chan->lock);
> =C2=A0	if (kfifo_is_full(&chan->fifo))
> =C2=A0		kfifo_skip(&chan->fifo);
> =C2=A0	kfifo_put(&chan->fifo, val);
> +	spin_unlock(&chan->lock);

I prefer we use scoped_guard() here.

> =C2=A0	wake_up_interruptible(&chan->wq);
> =C2=A0}
> =C2=A0
> @@ -228,6 +243,7 @@ static int aspeed_lpc_enable_snoop(struct device *dev=
,
> =C2=A0		return -EBUSY;
> =C2=A0
> =C2=A0	init_waitqueue_head(&channel->wq);
> +	spin_lock_init(&channel->lock);
> =C2=A0
> =C2=A0	channel->cfg =3D cfg;
> =C2=A0	channel->miscdev.minor =3D MISC_DYNAMIC_MINOR;
