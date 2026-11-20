Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190783;
	b=1lLwyy1v+BMEjseq3sPLuQ84Ccvih8auxUljJy47d3RVc/uN+QTHhfwJd+PxfYIdz1jk
	 0fI7xikdHW34QyvLnKd99oxaXXFpCPr064Ms+gYt+MrFWkLUGmUQspavgWpBzUYJfTI9A
	 qdElzS50FZH1jWonBgDxVpBR71e7U9yoMM9c9ukXsm3XRf+fuWFUt54nYVW8lsirTImhs
	 hcmbLczDWdgG+VaOinRBkZvEFWo0RIiJFrA7aysdCHivOx511edGqwAjQfzAsKoLOGO9c
	 b4MgQKYi6qI8+Ff0yqWTlY7EpUbwcMZroB+gqCDfWDajtoC/gKl6TUKnIfinMk3Nycw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190783;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h4TonTW3SJY0/uQ/u5HES6hwQIEse7VmKPSjv012IRs=;
	b=DJ6MgDWoHbaSlGD5AMw33tjbqmNXV0F5SkdddtUJkYVvkN9Efv7XVFMj473uE6MB6mBW
	 25jCAKYRVbHYeMYfcaKRtfVdFB4ugjUF24dKboYjA7w8x1nRAwshHZcblFUcBnUpLxKpt
	 uZbW9/lmK5acBG+ALSOvUqRJU7xSoJmj39qej0KE+lAvKo/9WU/JMwHjHrUB8I1cntBDS
	 Q1YTn9ZIfmLkbQrx0qRMrSuYFvUZqEZzq8lSCz5SYSTQWIYkmTfyOPNeduTumNUsba5/e
	 oxCnlLb6HJdiZ+DaRAN8bV6E16LLzu8DJ2IEGMy9g07qlSSyKrgPOHaHQF2MFJ4ngbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BjinrI0b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07560A2600;
	Fri, 20 Nov 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BjinrI0b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948401F000D8;
	Fri, 20 Nov 2026 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795190783;
	bh=h4TonTW3SJY0/uQ/u5HES6hwQIEse7VmKPSjv012IRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BjinrI0by6eZVj37FZ2g4Dt9J+Ade8Tq7XJEvaaKAL49dO+fNY0FXlnceSmuyIx68
	 aP7hAJB2HSouZDcriO+6Q55jeHlLRax+QR25cOTLAUSX6hDwltBWKgmSYnM7dC+WLI
	 6WgDfYhv7I9zET5fc8I2ItOi26BLhfgSqM0Eph9I=
Date: Fri, 20 Nov 2026 17:06:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] usb: ljca: fix NULL pointer dereference on events for
 callback-less clients
Message-ID: <2026112045-napping-suitcase-26b0@gregkh>
References: <20261120150143.2591-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261120150143.2591-1-25031212351@stu.xidian.edu.cn>

On Fri, Nov 20, 2026 at 11:01:43PM +0800, YuanZhe Liu wrote:
> ljca_handle_event() dispatches an incoming event message to the first
> client whose type matches the message type and calls that client's event
> callback without checking that a callback is registered.  Only the GPIO
> client calls ljca_register_event_cb(); the I2C and SPI clients never do,
> so their event_cb stays NULL for as long as the adapter is bound, while
> they are present in adap->client_list.
> 
> A device that sends a message without LJCA_ACK_FLAG and with the type of
> such a client therefore makes the driver call a NULL function pointer
> from the URB completion handler:

What device does that?  How?

> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor instruction fetch in kernel mode
>   RIP: 0010:0x0
>   Call Trace:
>    ljca_handle_event drivers/usb/misc/usb-ljca.c:217 [inline]
>    ljca_recv+0x651/0x850 drivers/usb/misc/usb-ljca.c:295
>    __usb_hcd_giveback_urb+0x238/0x550 drivers/usb/core/hcd.c:1657
> 
> Check event_cb under client->event_cb_lock and skip the call when no
> callback is registered.  The same lock is taken by
> ljca_register_event_cb() and ljca_unregister_event_cb(), so the check
> cannot be invalidated before the call.

How was this tested, shouldn't the driver be fixed up not to do that
instead of this workaround?

thanks,

greg k-h
