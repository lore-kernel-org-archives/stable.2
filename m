Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1C3909A4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421065; cv=none; b=q25n1OX2a23CzISESBUoM3igywmVJ462eCaJM5Vh7ZsYHHHviIFeMHckwTWcf53x/EbEWLuLHEWpM7JXtI46iKlagx8CoRUEr6SQ1zXlJg1T+TRF08jHn1g5l8QjC5xc9Ne1SPO36CpWxeRzGmLyhRvXkcbQgaqnPibaT+59UXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421065; c=relaxed/simple;
	bh=7X/8xlWF8r/5QFTR3J7oJgfdaCZRAUfvSQhpURuUxX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZm+0fSsvUQg8F6C0jC0vX3jU5ZKvVEzWyF26KgVXoZ7owXk7r3o47R5EE6i6/5PzFYYvnHXrPbMPTKKp7xLWwURrQHNsL+TSIgA8mX69M1Bz80oOvNGmzr1GycmWN+ZiaYQP1rok6Ryg2aoRrSJtLwPTabc9Y8I6DAAkYdr5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QVi+6xIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QVi+6xIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C724E1F000E9;
	Thu,  3 Sep 2026 07:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788421063;
	bh=IvtJijASBWmMfGHojGqpAc4b64Ttq+adhAq+l3BhFOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVi+6xIHIlA8p1e1amLoYpYuakyQcwsDZ8C3nubSPB9P99enKhhQN5uE6VFLCdZdR
	 6VNBoy9yvM6REI7+OzkhSnEffoVtdv5aSljMDP+gECfOCsVwyEsMT7COQbDEPaMseq
	 SdjQnmFMrK0ikmdAcg3h28Xgq4E428c+QlaBUvXQ=
Date: Thu, 3 Sep 2026 09:37:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
Cc: syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: core: fix GPF on disconnect when interface claimed
 before registration
Message-ID: <2026090334-saddlebag-aground-ecd8@gregkh>
References: <20260903065513.97561-1-khiemtranzo532001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903065513.97561-1-khiemtranzo532001@gmail.com>

On Thu, Sep 03, 2026 at 02:55:13PM +0800, Nguyen Quang Le Kien wrote:
> usb_driver_claim_interface() sets dev->driver unconditionally before
> checking device_is_registered(dev).  When called from usb_audio_probe()
> during configuration, the interface device has not been added to the
> driver core yet (device_add() is called later in usb_set_configuration()).
> 
> As a result, knode_driver is never attached to the driver's klist, but
> dev->driver is set.  On subsequent disconnect, bus_remove_device() calls
> __device_release_driver(), which calls klist_remove(&dev->p->knode_driver)
> unconditionally on the uninitialized node, causing a general protection
> fault:
> 
>   BUG: kernel NULL pointer dereference
>   RIP: klist_remove+0x...
>   Call Trace:
>    __device_release_driver
>    bus_remove_device
>    device_del
>    usb_disable_device
>    usb_disconnect
> 
> Fix this by deferring the assignment of dev->driver for interfaces that
> are not yet registered.  Instead, record the claim via two new fields in
> struct usb_interface: a claimed bitflag and a claimed_driver pointer.
> After device_add() completes in usb_set_configuration(), call
> device_bind_driver() explicitly for claimed interfaces.
> 
> device_bind_driver() skips ->probe() (which is exactly what usb_audio
> needs — PCM and MIDI devices are created before bind), but it does
> attach knode_driver to the driver's klist, making teardown safe.
> 
> The else-if branch in dd.c that handles dev->driver already set at
> device_add() time (used by w1, usb_port, ccwgroup, pata_parport, and
> others) is intentionally left untouched.
> 
> Reported-by: syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=87188222c77c0dbbdb4d
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>

Did you forget to add an Assisted-by: tag here?

And how was this tested?

And I think you forgot to cc: the right people here,
scripts/get_maintainer or b4 will do this for you automatically.

thanks,

greg k-h
