Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2538AC72;
	Fri, 17 Jul 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291451; cv=none; b=cAhKB7TKbvuC0imndQ5xagof2U4GzeclK3epKaCgmIVp0Wl8OdzyDnxWtxw7L7r5T+HqGptasD+rrcLfxdEmJVMyOxAHGkT1ymd4J68xJ3sr+7IGcL0STMaoDTHhA6VbkqjAgFWg4KybSCpOe2ezFlYhWarGL3WADT90CdKjEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291451; c=relaxed/simple;
	bh=MzpqfL7n3obVzN1YuBdUYE/ygd2CwMw6rh15th/mWyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLsxoR4sKR7o8RMNjzSXVc5sO4uMg66/sVQ/Ofiacc5zQUxazL7FTq8d2t4jZlnX5PF3tdC2igjSX+mf0tAd8bL7CFFHCBgaEx6z1/KO6yn4hvFTNyVRGxSoZN8lKRA4g3EJlNKJ0yWJzkH9az2wCrwlh111zQlOAmhYTmVujUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vq+6kvDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vq+6kvDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107F21F000E9;
	Fri, 17 Jul 2026 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784291449;
	bh=MBhRBhb0hFVL/aEfONnUitVWMnwxAmmny7vaK4RY1xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vq+6kvDrKJ9HF0ZmDIxbaT9Q1x/gs1IviNsuUOEpagXsgl3E+qaomcjvAwDYKOJOw
	 Sk+TwwW08HYKpD63ehtFbNY4jQ9i0dGy6dIbQWIDKpJ0Anhlt3Npabwn7uKuXirimg
	 sBkEORuuOlc4J9rnfTP3VfsmurU3ZyQXcwi9s0Gk=
Date: Fri, 17 Jul 2026 14:30:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpib: fix use-after-free between iboffline() detach
 and in-flight I/O
Message-ID: <2026071732-projector-bunch-d277@gregkh>
References: <akKZBpW135YW2Def@egonzo>
 <20260708073618.147714-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708073618.147714-1-jhapavitra98@gmail.com>

On Wed, Jul 08, 2026 at 03:36:18AM -0400, Pavitra Jha wrote:
> iboffline() calls board->interface->detach(), which frees
> board->private_data, with no guarantee that a read/write/command
> ioctl already in progress on that board has finished touching it.
> 
> v1 of this fix took board->big_gpib_mutex around the detach() call.
> That was wrong on two counts, both pointed out by Dave Penkler:
> 
>  1. iboffline() is reached from ibioctl() via the IBONL ioctl, which
>     is dispatched while big_gpib_mutex is already held. Taking it
>     again inside iboffline() self-deadlocks.
> 
>  2. IBRD/IBWRT/IBCMD explicitly drop big_gpib_mutex before calling
>     into board->interface, because those calls can block for the
>     duration of board->usec_timeout. So even without the deadlock,
>     the mutex was never actually held during the in-flight callback
>     it was meant to exclude.
> 
> Fix this by tracking in-flight callbacks directly instead of
> overloading big_gpib_mutex. Add board->io_active, an atomic counter
> incremented around the body of read_ioctl(), write_ioctl(), and
> command_ioctl() (which is where board->interface is dereferenced,
> via ibrd()/ibwrt()/ibcmd()), and board->io_drain_wait, a waitqueue
> woken when the counter reaches zero.
> 
> iboffline() waits uninterruptibly on io_drain_wait before calling
> detach(). big_gpib_mutex is already held at that point (via IBONL),
> which blocks any *new* I/O ioctl from starting, so the wait only
> drains whatever was already in flight; it does not need a timeout,
> and adding one would just let detach() free private_data out from
> under a callback that is still running.
> 
> gpib_unregister_driver() also calls iboffline(), but unlike the
> IBONL path it holds no lock at all, so a fresh ioctl could still
> race the detach()/board->interface=NULL sequence there. Take
> big_gpib_mutex around that call site to close the same window.
> 
> The KASAN reproducer from v1 (kprobe on a driver read callback,
> concurrent kfree from a detach kthread) demonstrates the class of
> bug this closes: a blocking read callback dereferencing freed
> private_data. It is reproduced against board->io_active rather than
> the mutex in this version; behavior against the harness is
> unchanged, since the harness only exercises the missing exclusion
> between detach() and an in-flight read, not the specific mechanism
> used to provide it.
> 
> Fixes: e6ab504633e4 ("staging: gpib: Destage gpib")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
>  drivers/gpib/common/gpib_os.c     | 21 +++++++++++++++++++++
>  drivers/gpib/common/iblib.c       | 27 ++++++++++++++++-----------
>  drivers/gpib/include/gpib_types.h |  9 +++++++++
>  3 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpib/common/gpib_os.c b/drivers/gpib/common/gpib_os.c
> index 5909274dd..86921856f 100644
> --- a/drivers/gpib/common/gpib_os.c
> +++ b/drivers/gpib/common/gpib_os.c
> @@ -912,6 +912,7 @@ static int read_ioctl(struct gpib_file_private *file_priv, struct gpib_board *bo
>  	mutex_unlock(&file_priv->descriptors_mutex);
>  
>  	atomic_set(&desc->io_in_progress, 1);
> +	atomic_inc(&board->io_active);
>  
>  	/* Read buffer loads till we fill the user supplied buffer */
>  	while (remain > 0 && end_flag == 0) {
> @@ -944,6 +945,8 @@ static int read_ioctl(struct gpib_file_private *file_priv, struct gpib_board *bo
>  		retval = copy_to_user((void __user *)arg, &read_cmd, sizeof(read_cmd));
>  
>  	atomic_set(&desc->io_in_progress, 0);
> +	atomic_dec(&board->io_active);
> +	wake_up(&board->io_drain_wait);
>  	atomic_dec(&desc->descriptor_busy);
>  
>  	wake_up_interruptible(&board->wait);
> @@ -1003,6 +1006,7 @@ static int command_ioctl(struct gpib_file_private *file_priv,
>  	 */
>  
>  	atomic_set(&desc->io_in_progress, 1);
> +	atomic_inc(&board->io_active);
>  
>  	do {
>  		fault = copy_from_user(board->buffer, userbuf, (board->buffer_length < remain) ?
> @@ -1038,6 +1042,8 @@ static int command_ioctl(struct gpib_file_private *file_priv,
>  	 */
>  	if (!no_clear_io_in_prog || fault)
>  		atomic_set(&desc->io_in_progress, 0);
> +	atomic_dec(&board->io_active);
> +	wake_up(&board->io_drain_wait);
>  	atomic_dec(&desc->descriptor_busy);
>  
>  	wake_up_interruptible(&board->wait);
> @@ -1085,6 +1091,7 @@ static int write_ioctl(struct gpib_file_private *file_priv, struct gpib_board *b
>  	mutex_unlock(&file_priv->descriptors_mutex);
>  
>  	atomic_set(&desc->io_in_progress, 1);
> +	atomic_inc(&board->io_active);
>  
>  	/* Write buffer loads till we empty the user supplied buffer */
>  	while (remain > 0) {
> @@ -1118,6 +1125,8 @@ static int write_ioctl(struct gpib_file_private *file_priv, struct gpib_board *b
>  		fault = copy_to_user((void __user *)arg, &write_cmd, sizeof(write_cmd));
>  
>  	atomic_set(&desc->io_in_progress, 0);
> +	atomic_dec(&board->io_active);
> +	wake_up(&board->io_drain_wait);
>  	atomic_dec(&desc->descriptor_busy);
>  
>  	wake_up_interruptible(&board->wait);
> @@ -2115,8 +2124,18 @@ void gpib_unregister_driver(struct gpib_interface *interface)
>  			if (board->use_count > 0)
>  				pr_warn("gpib: Warning: deregistered interface %s in use\n",
>  					interface->name);
> +			/*
> +			 * Unlike the IBONL ioctl path, nothing else holds
> +			 * big_gpib_mutex here, so a fresh ioctl could race
> +			 * this teardown and dispatch into board->interface
> +			 * right as it becomes NULL below. Hold the mutex
> +			 * across iboffline() and clearing board->interface
> +			 * so ibioctl() cannot enter until this is done.
> +			 */
> +			mutex_lock(&board->big_gpib_mutex);
>  			iboffline(board);
>  			board->interface = NULL;
> +			mutex_unlock(&board->big_gpib_mutex);
>  		}
>  	}
>  	for (list_ptr = registered_drivers.next; list_ptr != &registered_drivers;) {
> @@ -2149,6 +2168,8 @@ void init_gpib_board(struct gpib_board *board)
>  	init_waitqueue_head(&board->wait);
>  	mutex_init(&board->user_mutex);
>  	mutex_init(&board->big_gpib_mutex);
> +	atomic_set(&board->io_active, 0);
> +	init_waitqueue_head(&board->io_drain_wait);
>  	board->locking_pid = 0;
>  	spin_lock_init(&board->locking_pid_spinlock);
>  	spin_lock_init(&board->spinlock);
> diff --git a/drivers/gpib/common/iblib.c b/drivers/gpib/common/iblib.c
> index 07a30d520..0de6ca50c 100644
> --- a/drivers/gpib/common/iblib.c
> +++ b/drivers/gpib/common/iblib.c
> @@ -257,22 +257,27 @@ int iboffline(struct gpib_board *board)
>  	}
>  
>  	/*
> -	 * Acquire big_gpib_mutex before calling detach() to prevent a
> -	 * use-after-free race. I/O callbacks (read/write/command) hold
> -	 * big_gpib_mutex while caching board->private_data on their stack.
> -	 * Without this lock, iboffline() can kfree(board->private_data)
> -	 * inside detach() while an I/O callback is still running and holds
> -	 * a stale pointer to the freed memory.
> +	 * iboffline() is always called with board->big_gpib_mutex already
> +	 * held (via the IBONL ioctl), so it cannot take that mutex itself.
> +	 * That mutex is also dropped by IBRD/IBWRT/IBCMD before they call
> +	 * into board->interface, since those calls can block for a long
> +	 * time, so it never actually excludes an in-flight read/write/
> +	 * command callback in the first place.
>  	 *
> -	 * Affected board drivers: cb7210, ines_gpib, tnt4882 (all delegate
> -	 * to nec7210_read/pio_read which blocks in wait_event_interruptible
> -	 * for up to board->usec_timeout microseconds while holding priv).
> +	 * board->io_active counts callbacks currently executing inside
> +	 * board->interface. Wait here, uninterruptibly and without a
> +	 * timeout, for it to reach zero before calling detach(). Since
> +	 * big_gpib_mutex is held, no *new* I/O ioctl can start while we
> +	 * wait, so this only drains whatever was already in flight.
> +	 * Returning early would let detach() free board->private_data
> +	 * while that in-flight callback is still dereferencing it, which
> +	 * is the use-after-free this is closing.
>  	 */
> -	mutex_lock(&board->big_gpib_mutex);
> +	wait_event(board->io_drain_wait, atomic_read(&board->io_active) == 0);
> +
>  	board->interface->detach(board);
>  	gpib_deallocate_board(board);
>  	board->online = 0;
> -	mutex_unlock(&board->big_gpib_mutex);
>  	dev_dbg(board->gpib_dev, "board offline\n");
>  
>  	return 0;
> diff --git a/drivers/gpib/include/gpib_types.h b/drivers/gpib/include/gpib_types.h
> index 28b73157f..1c1f29c12 100644
> --- a/drivers/gpib/include/gpib_types.h
> +++ b/drivers/gpib/include/gpib_types.h
> @@ -288,6 +288,15 @@ struct gpib_board {
>  	 * store additional variables for this board
>  	 */
>  	void *private_data;
> +	/*
> +	 * Counts read/write/command callbacks currently executing in
> +	 * board->interface. iboffline() waits for this to reach zero
> +	 * before calling detach(), so its teardown of private_data
> +	 * cannot race an in-flight callback still dereferencing it.
> +	 */
> +	atomic_t io_active;
> +	/* Woken when io_active reaches zero, so iboffline() can wait for drain. */
> +	wait_queue_head_t io_drain_wait;
>  	/* Number of open file descriptors using this board */
>  	unsigned int use_count;
>  	/* list of open devices connected to this board */
> -- 
> 2.53.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
