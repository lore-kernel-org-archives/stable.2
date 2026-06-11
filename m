Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48411A9F83;
	Thu, 11 Jun 2026 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146262; cv=none; b=Ph1Lk5BUXkVTf1g9UtxyqIqd2a9cqf2Iq6/gE2HB70bb/ng8ok7Q/m1k7UnIuRDw2SwesJxaV3zfBYTe1fxOAvpaw2MTf7XgAbSzsq6SHOzBQtWko9zCeazYG9W5p4a8zUHcPHrQUMA4hN4lcIbeJpN7PYgcdZzEOGXeRxDirs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146262; c=relaxed/simple;
	bh=C3YTxhG6yw9+1kzmS/holNzq9WZBoZgPlwMhdmYMrfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOa7h+uxtPRgbrCRhFn1uFlzfPxWoxAZxPxadUJ7XxypkOUgyGDLslWFcspkpy1QJaFewQclsY2AfEKuOrEe7mrIgAM4ceKQGqxa+GhoI/qBK6jlwTQ/yfCXdxGFTVXm4Re4ghC3E31l5DjOZZ3oyR8/3mtbsB7VsNAkuXycMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=SYVLyqrQ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="SYVLyqrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781146253;
	bh=jC17BLRupxjFh4QurP21wywIDB1dwNBEJxTReffswGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SYVLyqrQiN1Offva8UPZ/gcqnw2zJNMdKsotwp/JLCuPsS3QbUUTWLgd3VSMGSx4r
	 5lNrAFl0iQ3VyHQIhNRslyvUoQegK1YJJyYIAmSLlcH7SQ295Iurh6pvD2LRT0tS+2
	 Vy7YqlcusxaPBLVl7Qr8IDkViYYromvKsx1lbSv2soYjuVT2VMp/P5xdFe3MAkHBbc
	 TQxiaY/7wvy1R/wqtie29/p7FPHVYpvL0c+u/zRts/P49RXY/SZGPdtIdqtW8GiU10
	 r9MpCEybw18qEdiOALgdqtormaeygxfVlaMpcKEFkh2Rx077FgY1Q7uEdgLXbpMoCc
	 GaFVW+6bDAG4A==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6573D60A0C;
	Thu, 11 Jun 2026 10:50:51 +0800 (AWST)
Message-ID: <64f8d88bf4cd72d8120baaa304dfe34bb66cbe0b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 11 Jun 2026 12:20:50 +0930
In-Reply-To: <20260610172310.163321-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260610172310.163321-1-karthiproffesional@gmail.com>
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

On Wed, 2026-06-10 at 17:23 +0000, Karthikeyan KS wrote:
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
> Serialize kfifo access with a per-channel spinlock. The reader drains
> into a bounce buffer under the lock with kfifo_out_spinlocked() and then
> copies to userspace after dropping it, since copy_to_user() may sleep on
> a page fault.
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
> Changes since v4:
> - Use __free(kfree) for automatic cleanup
> - Allocate clamped count instead of full SNOOP_FIFO_SIZE
> - Use kfifo_out_spinlocked() in snoop_file_read
> - Use scoped_guard(spinlock) in put_fifo_with_discard
>=20
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 25 +++++++++++++++++++-----=
-
> =C2=A01 file changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/a=
speed-lpc-snoop.c
> index b03310c0830d..c9c87a794228 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -11,6 +11,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/dev_printk.h>
> =C2=A0#include <linux/interrupt.h>
> @@ -74,6 +75,7 @@ struct aspeed_lpc_snoop_channel_cfg {
> =C2=A0struct aspeed_lpc_snoop_channel {
> =C2=A0	const struct aspeed_lpc_snoop_channel_cfg *cfg;
> =C2=A0	bool enabled;
> +	spinlock_t		lock;=C2=A0=C2=A0=C2=A0 /* serialises @fifo: irq producer v=
s reader */

I'd prefer we avoid trailing comments, which it seems you've added this
time around. Since you did that ...

> =C2=A0	struct kfifo		fifo;

... in this specific case we can improve on the comment, with:

   struct kfifo fifo __guarded_by(&lock);

More details here:

   https://docs.kernel.org/dev-tools/context-analysis.html

Adding a change along these lines currently produces:

   ../drivers/soc/aspeed/aspeed-lpc-snoop.c:164:32: warning: reading variab=
le 'fifo' requires holding spinlock '&aspeed_lpc_snoop_channel::lock' [-Wth=
read-safety-analysis]
     164 |         if (!kfifo_initialized(&chan->fifo))
         |                                       ^

I ended up applying this on top of your patch:

   diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
   index b35d74592964..9cba7be8c395 100644
   --- a/drivers/soc/aspeed/Makefile
   +++ b/drivers/soc/aspeed/Makefile
   @@ -4,3 +4,5 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)          +=3D aspeed-lpc-=
snoop.o
    obj-$(CONFIG_ASPEED_UART_ROUTING)      +=3D aspeed-uart-routing.o
    obj-$(CONFIG_ASPEED_P2A_CTRL)          +=3D aspeed-p2a-ctrl.o
    obj-$(CONFIG_ASPEED_SOCINFO)           +=3D aspeed-socinfo.o
   +
   +CONTEXT_ANALYSIS_aspeed-lpc-snoop.o    :=3D y
   diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/=
aspeed-lpc-snoop.c
   index 9165a543a250..7fa1a345acac 100644
   --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
   +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
   @@ -75,8 +75,8 @@ struct aspeed_lpc_snoop_channel_cfg {
    struct aspeed_lpc_snoop_channel {
           const struct aspeed_lpc_snoop_channel_cfg *cfg;
           bool enabled;
   -       spinlock_t              lock;    /* serialises @fifo: irq produc=
er vs reader */
   -       struct kfifo            fifo;
   +       spinlock_t              lock;
   +       struct kfifo            fifo __guarded_by(&lock);
           wait_queue_head_t       wq;
           struct miscdevice       miscdev;
    };
   @@ -161,9 +161,9 @@ static const struct file_operations snoop_fops =3D {
    /* Save a byte to a FIFO and discard the oldest byte if FIFO is full */
    static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan=
, u8 val)
    {
   -       if (!kfifo_initialized(&chan->fifo))
   -               return;
           scoped_guard(spinlock, &chan->lock) {
   +               if (!kfifo_initialized(&chan->fifo))
   +                       return;
                   if (kfifo_is_full(&chan->fifo))
                           kfifo_skip(&chan->fifo);
                   kfifo_put(&chan->fifo, val);
   @@ -240,7 +240,6 @@ static int aspeed_lpc_enable_snoop(struct device *de=
v,
                   return -EBUSY;
   =20
           init_waitqueue_head(&channel->wq);
   -       spin_lock_init(&channel->lock);
   =20
           channel->cfg =3D cfg;
           channel->miscdev.minor =3D MISC_DYNAMIC_MINOR;
   @@ -252,9 +251,11 @@ static int aspeed_lpc_enable_snoop(struct device *d=
ev,
           if (!channel->miscdev.name)
                   return -ENOMEM;
   =20
   -       rc =3D kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);
   -       if (rc)
   -               return rc;
   +       scoped_guard(spinlock_init, &channel->lock) {
   +               rc =3D kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_=
KERNEL);
   +               if (rc)
   +                       return rc;
   +       }
   =20
           rc =3D misc_register(&channel->miscdev);
           if (rc)
  =20
I prefer that we add the annotation as the compiler analysis provides
some comfort in contrast to the comment.

Otherwise, the rest of the fix seems okay to me.

Andrew

> =C2=A0	wait_queue_head_t	wq;
> =C2=A0	struct miscdevice	miscdev;
> @@ -114,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, cha=
r __user *buffer,
> =C2=A0				size_t count, loff_t *ppos)
> =C2=A0{
> =C2=A0	struct aspeed_lpc_snoop_channel *chan =3D snoop_file_to_chan(file)=
;
> +	u8 *buf __free(kfree) =3D NULL;
> =C2=A0	unsigned int copied;
> =C2=A0	int ret =3D 0;
> =C2=A0
> @@ -125,9 +128,16 @@ static ssize_t snoop_file_read(struct file *file, ch=
ar __user *buffer,
> =C2=A0		if (ret =3D=3D -ERESTARTSYS)
> =C2=A0			return -EINTR;
> =C2=A0	}
> -	ret =3D kfifo_to_user(&chan->fifo, buffer, count, &copied);
> -	if (ret)
> -		return ret;
> +
> +	count =3D min_t(size_t, count, SNOOP_FIFO_SIZE);
> +
> +	buf =3D kmalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	copied =3D kfifo_out_spinlocked(&chan->fifo, buf, count, &chan->lock);
> +	if (copied && copy_to_user(buffer, buf, copied))
> +		return -EFAULT;
> =C2=A0
> =C2=A0	return copied;
> =C2=A0}
> @@ -153,9 +163,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_=
snoop_channel *chan, u8 val)
> =C2=A0{
> =C2=A0	if (!kfifo_initialized(&chan->fifo))
> =C2=A0		return;
> -	if (kfifo_is_full(&chan->fifo))
> -		kfifo_skip(&chan->fifo);
> -	kfifo_put(&chan->fifo, val);
> +	scoped_guard(spinlock, &chan->lock) {
> +		if (kfifo_is_full(&chan->fifo))
> +			kfifo_skip(&chan->fifo);
> +		kfifo_put(&chan->fifo, val);
> +	}
> =C2=A0	wake_up_interruptible(&chan->wq);
> =C2=A0}
> =C2=A0
> @@ -228,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct device *dev=
,
> =C2=A0		return -EBUSY;
> =C2=A0
> =C2=A0	init_waitqueue_head(&channel->wq);
> +	spin_lock_init(&channel->lock);
> =C2=A0
> =C2=A0	channel->cfg =3D cfg;
> =C2=A0	channel->miscdev.minor =3D MISC_DYNAMIC_MINOR;
