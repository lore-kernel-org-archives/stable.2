Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7C44E662;
	Wed, 14 Oct 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978446; cv=none; b=k6HLjg0XVsT3F+5HNX+g0UiD6xUI+3g5srACxs8PLG6uH/7+O3e3yVYpIEkCrFRA4oJJ/YGG24WRrcZK06E+3ry6LkHFof4isggFeYrt5yLRZYP78trsZMf3jW+U97nG9ZKRbTyTiWNQtqf9tvZMCDdpu1v9GZ2MpnpfjiPpZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978446; c=relaxed/simple;
	bh=ILhBZJCEuct5sP2YsHKzlUh4iKWnRwYMXrZnAg4Ca1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQzy8F9teYgr3GH9JrHDMdGIk8vevTiXGnJCr6kBTYKfWrAg7ywjTRhyjRtRXg6sI9+uIwhzWmFbvWR8m8u47snh3weMmQhrJgzHnd9X8PlJjQRTrxoCTqExn7YVAqREYQMKvHqguRSptTwk+qDWM1KqH0t59+WYsgO/J7xaqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sOeyWaaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sOeyWaaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE101F000FF;
	Wed, 14 Oct 2026 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791978444;
	bh=LLYhgszy6ZH9nQCkUTNqMMjfJeES0ElaWQzVBTD2Pko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sOeyWaaJULi3bsHFTFJYywzV+9QXJ6m9a2qTYJNGA+XZufZiw6pc4NTue1J1BnB6A
	 35VKjVwvPdo9kB/UFAf3mBFNYqKBFB17cz7nbk0GGuDcVmvWPMKhaJrNWpbQELVR9U
	 8NsfQeU1HaH0IU7TuowqgQswROEuIHnakrUxSPHc=
Date: Wed, 14 Oct 2026 13:47:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: storage: bound timeout=0 URB waits to 30s
Message-ID: <2026101406-lair-impaired-172b@gregkh>
References: <20261014093856.415812-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014093856.415812-1-xiehongyu1@kylinos.cn>

On Wed, Oct 14, 2026 at 05:38:56PM +0800, Hongyu Xie wrote:
> usb_stor_msg_common() is the common URB submission/wait helper for
> usb-storage transfers.  Callers that pass a positive timeout get that
> timeout, but the three internal transfer helpers (usb_stor_ctrl_transfer,
> usb_stor_intr_transfer and usb_stor_bulk_transfer_buf) all pass 0,
> which selects MAX_SCHEDULE_TIMEOUT: the control thread waits for the URB
> forever.
> 
> A device that stops responding while such a transfer is pending hangs the
> control thread permanently, and the hang propagates into the SCSI error
> handler:
> 
>     scsi command timeout -> eh_abort_handler -> command_abort()
>       -> usb_stor_stop_transport()  /* URB unlink issued, but the URB of
>                                       a device wedged mid-transition
>                                       never completes */
>       -> wait_for_completion(&us->notify)  /* no timeout */
> 
> The unbounded wait also closes a deadlock cycle observed on arm64 servers
> running 5.4.x, where a Realtek USB WiFi dongle in CD-ROM mode (sr0)
> wedges during usb_modeswitch's re-enumeration transition: the system
> shutdown hook (mdadm --wait-clean --scan, which opens every block device)
> blocks in disk_block_events() holding ev->block_mutex, waiting for the
> disk events work whose TEST UNIT READY timed out into the
> command_abort() wait above.  No timeout anywhere in the cycle means the
> shutdown hangs forever -- hung_task warnings every 120s until power loss,
> two production incidents with identical stacks.
> 
> Bound the fallback wait to 30s, matching the SCSI layer's default command
> timeout for disk and CD-ROM LUs (SD_TIMEOUT / SR_TIMEOUT).  When the bound
> fires, the URB is killed, the transport reports USB_STOR_XFER_ERROR, and
> the command fails through the regular paths: the control thread
> completes, notify is signalled, the abort returns, and the events work
> (and with it the shutdown) can finish.
> 
> For disk and CD-ROM LUs this bound introduces no new policy: a transfer
> that produced no URB completion for 30s has already exhausted the SCSI
> layer's patience, and the error handler trying to abort it cannot make
> progress while the control thread is stuck in the unbounded wait.
> 
> A blanket bound for this helper was suggested before [1] but dropped over
> concern that legitimate SCSI commands (format, tape rewind) can exceed
> 60 seconds.  Those commands are issued to tape LUs whose SCSI timeouts
> are much longer than 30s; usb-storage-attached tapes holding back a CSW
> for more than 30 seconds remain the residual false-positive window of
> this change (modern tape bridges use UAS, which is unaffected).
> 
> The scatter-gather data path (usb_stor_bulk_transfer_sglist(), which
> waits in usb_sg_wait()) is a separate unbounded wait and is not covered
> by this change; a device that stalls mid data phase can still wedge the
> control thread there.
> 
> Validation: on the affected production machine the hang occurred twice
> across ~4800 hibernate cycles with identical stacks; with this bound in
> place, 990+ hibernate cycles completed without a recurrence.
> 
> [1] https://lkml.rescloud.iu.edu/hypermail/linux/kernel/2207.0/05816.html

Please only use lore.kernel.org links.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---

No diffstat?  How did you generate this?

> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -112,6 +112,15 @@
>   * command _must_ pass through this function (or something like it) for the
>   * abort mechanisms to work properly.
>   */
> +
> +/*
> + * Bound for the URB wait when the caller passes timeout == 0: matches the
> + * SCSI layer's default command timeout for disk and CD-ROM LUs (SD_TIMEOUT /
> + * SR_TIMEOUT), so a wedged device surfaces as a regular command failure
> + * instead of hanging the control thread forever.

Please rewrite this from scratch and do not use a LLM for it, as this
doesn't make much sense to me at all.

thanks,

greg k-h
