Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB01386C9;
	Thu, 24 Sep 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238321; cv=none; b=IWPFN5tA4qg+DBiUghQ6SVhQxIcdIlIvGc50tOzNyqBah0kY0VO47xBXGNjA61IlFJ7g3i1+iPcZ7KFt9aygAALxoyy3x4JJAobwzMHLpKSDWTckCPbeMGSeDiZGb7eCb2fAPeWTLvLu218ebfUVo8jWsUlZYI0otYsRZISisKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238321; c=relaxed/simple;
	bh=JHdQhmT1l6sixRFZxBZewAAo4nmvaPftOIPTX/2GUtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvaNZU+YxYRY+qWFcXzcdKZdFl75klICpn+nOdBalt2ghy3ibQicYakxObjCYiBZegVnlfeSY20zv54V/vTfTyk8kA36V4k4WKAqAe4WtWcnrGltEmquNrrW5GWE/Cz5hRoTPHA6k8RCYFY9P79lMh5dqmIIlORZpp75pTPu/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=e4unAcEB; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="e4unAcEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1790238316; bh=JHdQhmT1l6sixRFZxBZewAAo4nmvaPftOIPTX/2GUtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4unAcEBEFUB/Rfln7h8wodxevq0fK+R4aRz2sp389m804OFmsMO4nRiBJ6UO5SrJ
	 jEv0sIXClmKP8CBfAM0/xHdfJHd+x/APcZHkloiWnkT402gXzZYxeAS4qaFDxdCfOf
	 /wL5Bc0uzoKrdvtKINl9bLg0zqAY0kcyL73gqfvSLGqGoSrRhTGXdadGRsgEltbDDm
	 pR8LEY5doyXf2q5pA+OsJ/T56qRzZyTy1d+b+HGKWZCAWK5y/vXyDYYYMF7T8Bg7PE
	 ZfnvNFbMbmqETSrBr5m7+bcdI4eWTrUbiukKh7d8QNexB+skMniZtJ5bpDCSGy3M+K
	 8ss/upS0COZ4Q==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id CB31340B86; Thu, 24 Sep 2026 09:25:16 +0100 (BST)
Date: Thu, 24 Sep 2026 09:25:16 +0100
From: Sean Young <sean@mess.org>
To: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
Cc: mchehab@kernel.org, oneukum@suse.com, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] media: rc: igorplugusb: quiesce callbacks before
 unregister
Message-ID: <arTebGLt_KKQiiud@extorris.mess.org>
References: <20260924025351.122-1-25031212351@stu.xidian.edu.cn>
 <20260924025351.122-2-25031212351@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924025351.122-2-25031212351@stu.xidian.edu.cn>

On Thu, Sep 24, 2026 at 10:53:51AM +0800, Yuanzhe Liu wrote:
> igorplugusb_disconnect() unregisters the rc device before poisoning its
> URB. rc_unregister_device() stops the raw-IR kthread, but a completion
> callback that is already running can still call ir_raw_event_handle().
> This makes wake_up_process() dereference the kthread's freed task_struct
> and triggers a KASAN use-after-free in try_to_wake_up().

This is problem with the framework rather than the driver. The
media-committers tree already contains a fix for this issue:

https://gitlab.freedesktop.org/linux-media/media-committers/-/commit/3ae19773168104fa57d2a2ec57731e89df54175f

> Poison the URB and delete the timer before unregistering the rc device.
> Poisoning drains any active callback and prevents resubmission, while
> deleting the timer stops the other URB producer. No callback can then
> reach rc-core after its raw-IR kthread has been stopped.

Stopping all the urbs before calling rc_unregister_device() isn't really an
option for all drivers. Users can still do various ioctl/write on the lirc
chardev which could bring various URBs back into flight. For receive-only IR
devices like igorplugusb this might not be an problem.

Thanks,

Sean

> 
> Fixes: b1c97193c643 ("[media] rc: port IgorPlug-USB to rc-core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
> ---
>  drivers/media/rc/igorplugusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
> index b5117ee..42e05b9 100644
> --- a/drivers/media/rc/igorplugusb.c
> +++ b/drivers/media/rc/igorplugusb.c
> @@ -241,9 +241,9 @@ static void igorplugusb_disconnect(struct usb_interface *intf)
>  {
>  	struct igorplugusb *ir = usb_get_intfdata(intf);
>  
> -	rc_unregister_device(ir->rc);
>  	usb_poison_urb(ir->urb);
>  	timer_delete_sync(&ir->timer);
> +	rc_unregister_device(ir->rc);
>  	usb_set_intfdata(intf, NULL);
>  	usb_unpoison_urb(ir->urb);
>  	usb_free_urb(ir->urb);
> -- 
> 2.45.1.windows.1
> 
