Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B554B1DB
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989061; cv=none; b=NlCs6i6XSU/1jlfwEybcVE4ZowflR/6xJslQHHMGCtfYfZsUOc5o3XS65cegFehC1OcAxDwwivzIOX0AYTKyBpK3NOf85wnfT9reeUhAmwuZHuphGATRKP1FqLO762WrwGneq/pV4MJxojgjrG7wl4l8MCihEMJomfkK92QR8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989061; c=relaxed/simple;
	bh=d7yeQHNUAQalWHt6gI1JaR3r0kw3Io2Ajb+zkdzQP/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhrh7BP4wmdz+SvuuWMnTC5EbA57katbVis9gqD5mepl2FAXvm4NdKSx/Y9qpH1dleIQwFa8V964ro4t1K1nUnE44tuyM2mI14nALfnmUxKpqFpAyfTHwSPT8Y1v4Um6s9EaGCL73dJLXH1n+MDXPFWcnZnAKU7UsyfjLa/+vbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=u0T3JsgO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="u0T3JsgO"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93c5b7f5bfaso120938485a.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791989054; x=1792593854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vriP8FELCtgoC3m/NLZgUWDkbznuFEZ4v+5g9V4G9cs=;
        b=u0T3JsgOrkJOL0jVY+wSe9+ekXUH0Fbvyoauwos+ckqL0ErMwpFBK7m31wSicUJlUd
         LMBwLt8qOTajegV06rzQmH+IYLS88zLRvbRfXlWPrFAQtO8l9un01g8m1iayN6stnipW
         mp6PcapDl8YoIuk3C6UOAOgEwQlI6MKR7CkTuaXMaNpqDtBPT73XITTD0qxFBDL3udNV
         YSxzh5lWqFKxaVLfLZR1WSRgkB0eUYl/DEtq+e3zciLKwHSdfJ5jKupcHfrSZHZ1QfUJ
         JQhH/0RJ8vYmABGvC5VQeR7YB1LiY+lXUhwybGEkoK02qIrjU3vAI0i53bTX6KrE03qU
         2qAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989054; x=1792593854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vriP8FELCtgoC3m/NLZgUWDkbznuFEZ4v+5g9V4G9cs=;
        b=ONDPvxC9D7r2hkgO7mDM+zFh+ymHlo1GqcMcL1KEl9Ho5yBWOwQEeAX3DZ0Xni9I4f
         PoQjzCKK60l26WhcKIIcnMcMi4sf7/bJntl6NFbES0Ptnhqm5HDG9RlgT42i4JqEbXxQ
         wp4iNUEkLnhm9ulJQ/srvCu74+1P60Um3/pUJS7tJKN1vb3qX25712BsE3Bb6QQERNJE
         QmNHqfngtJ5o4LB7syrGHUyAdghyN0t7BacDzf67lRLFKqxmKHARH7gX3cRunJAK2DAq
         HjQEGh1CX10jbj95xDV0tH9vnr4vGkDjNA5WGMO+/yUzaD9rDG4NitK0Cm7iwoLvYDYX
         hcAg==
X-Forwarded-Encrypted: i=1; AKwUvBzBn2Cu10sX1SM0EiE/9lzCF1Edq0NGNDRNL5A64PsmIJenFcPGAVmSNkG+QLKCJAt0vSI5r4g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbxx3rHfsu+q0GRzBW+jXGclNeq7guCeINvNdw+Xc2kzkMBFkP
	jj7IdSNgw/3B0h2W7ZJlCZ1GDWlEUOLx0hsvqXkD6dS1rN58YGNoJZRfho29JZZQ6Q==
X-Gm-Gg: AYBFou2YEHYJ/t75nn95qo1vkitX5duklcljTYFc0LVv61B8qTO6aeCHd5zov+Mp2fG
	WHiDpwoP7HqB6LK966ZJbB6xBSMVqlEwR42vP80UBqonaIB3lTf8jh4whr7w+rH/Kkx2FsRAWOV
	J1SQ8W4a8sRCiIJszJv1d5NzAdt5JTshv34POLGqlVn8Jx8zxKw0XsHXsvSzkMyH1/BZ8cmVH8T
	/xNVIoIFTYSNhWJRfFnTAzxViaCEpUIE+eSITEefmRkkGE82IzBzbJ2sL9ISzPT3CotlJevlIq6
	9MQpDciDwvqEcpnWWJ7QRuwN1/QhXL/fofhkq7+xHp0nkck7gfOOTWOcSrb/7rqNGlWXOLZQXgg
	dTPuZcy53tnqhiP+pdcniGJ1f/i7jbvuMQ7TBYfrdqS0lMJnj/K8gRPci3dnR/I5/i2uaPv+QRT
	vjljJEPpMMAsoTTCOFf2y6zMeE1T+rDGZxaZ4SmsARsGyUQUHyc0qb2wOP/uq3qrBPXs+2+FGyh
	OQ45gaC0eggNq+b
X-Received: by 2002:a05:620a:1792:b0:93e:97a3:1c53 with SMTP id af79cd13be357-93ec14825bamr2388450285a.22.1791989053909;
        Wed, 14 Oct 2026 07:44:13 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50a4f82sm503565585a.43.2026.10.14.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:44:11 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:44:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [usb-storage] [PATCH] usb: storage: bound timeout=0 URB waits to
 30s
Message-ID: <c1a82ee2-c48a-44ca-9da7-d3bad26dc240@rowland.harvard.edu>
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
> control thread permanently,

Why do you say it hangs _permanently_?  I've seen plenty of examples 
where the hang ended when the transfer was aborted.

>  and the hang propagates into the SCSI error
> handler:
> 
>     scsi command timeout -> eh_abort_handler -> command_abort()
>       -> usb_stor_stop_transport()  /* URB unlink issued, but the URB of
>                                       a device wedged mid-transition
>                                       never completes */

Why do you say the URB never completes?  Unlinking an URB should always 
cause it to complete, whether the device is responding or not.

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

Then the appropriate fix is to add a suitable timeout at the appropriate 
point in this cycle.  Not to force every command to be limited to a 
pre-defined 30-second timeout.

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

Again, why doesn't the scsi error handler procedure unwedge the thread?

Alan Stern

> Validation: on the affected production machine the hang occurred twice
> across ~4800 hibernate cycles with identical stacks; with this bound in
> place, 990+ hibernate cycles completed without a recurrence.
> 
> [1] https://lkml.rescloud.iu.edu/hypermail/linux/kernel/2207.0/05816.html
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
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
> + */
> +#define USB_STOR_URB_TIMEOUT	(30 * HZ)
> +
>  static int usb_stor_msg_common(struct us_data *us, int timeout)
>  {
>  	struct completion urb_done;
> @@ -164,7 +173,7 @@
>   
>  	/* wait for the completion of the URB */
>  	timeleft = wait_for_completion_interruptible_timeout(
> -			&urb_done, timeout ? : MAX_SCHEDULE_TIMEOUT);
> +			&urb_done, timeout ? : USB_STOR_URB_TIMEOUT);
>   
>  	clear_bit(US_FLIDX_URB_ACTIVE, &us->dflags);
> 
> -- 
> 2.25.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "USB Mass Storage on Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to usb-storage+unsubscribe@lists.one-eyed-alien.net.
> To view this discussion visit https://groups.google.com/a/lists.one-eyed-alien.net/d/msgid/usb-storage/20261014093856.415812-1-xiehongyu1%40kylinos.cn.
