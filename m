Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C527144B;
	Wed, 26 Aug 2026 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730822; cv=none; b=dy+y9XP2+XPwBMcvJHPjpQuHceTK6xzFYlgiCzwwKA59V4J5I7bLyX+cx27nci7kIxlnzlGfVMLuCEW5KaOwONIAwrwvVdQF2MEoPLeePPCvb8YSAl+vKHot36brYRNlr15s6ngko5C0DtW5d0Q0hG1zh819gWce1naoUPGLvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730822; c=relaxed/simple;
	bh=0KfEbqnDTdOceuaOkU3mdBu566L40MteOW/Tc1fkWUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utLoHmyxErZr8oDWzGhDE/BHd83pc1uplEwKRIH32Ye6PPC+QmQyA0w8cs8Oz4Aa+LliBNtKC9egtPJr+6pLGB6abkuXX5GCDHmaZxWBPXBVv8UYzfB+SUrGyrrIoQELWrZub+4H3i0NOJVOofgwmhNziOCoCsXgH6CONPtEtac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMnOw6w4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMnOw6w4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113E91F000E9;
	Wed, 26 Aug 2026 07:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787730821;
	bh=GFZ1eWUK2aCU5hx1QdT914JOIzfjTIdqLP24BI9REkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mMnOw6w4EiVFl8fAej0nCflcutPxW3zuAraqm+wscRrS5IIAqJJBE95u3UVM0HFfD
	 Ak33wxdrvXWOlZkglL6SeWzTy5QEQLHY4Hup6FW19pxUREZilUubaXrw/gwXKOXLYU
	 hCUau+ZuK+fc5G/wyt5D6Uh8fWK9cbj0cn6IVdKo=
Date: Wed, 26 Aug 2026 09:53:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lukas Wunner <lukas@wunner.de>, Gerhard Engleder <eg@keba.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Message-ID: <2026082645-stench-backpack-6e07@gregkh>
References: <20260826073237.1377668-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826073237.1377668-1-linuxoid@gmail.com>

On Wed, Aug 26, 2026 at 09:32:36AM +0200, Ruslan Valiyev wrote:
> serial_core_unregister_port() dereferences port->port_dev before it has
> been checked:
> 
> 	struct serial_port_device *port_dev = port->port_dev;
> 	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
> 
> serial_core_get_ctrl_dev() takes &port_dev->dev and reads dev->parent
> straight away, so a NULL port_dev faults at offset 0x40.
> 
> port_dev is NULL whenever no port device is installed:
> serial_core_remove_one_port() clears it on teardown, and it is never
> set if registration failed before serial_core_port_device_add().
> 
> serial8250_unregister_port() reaches that state. It calls
> uart_remove_one_port(), which clears port_dev, and then re-adds the
> port with uart_add_one_port() without checking the return value. When
> that re-add fails, port_dev stays NULL while port.dev still points at
> the ISA platform device, so unbinding that device once more calls
> serial8250_unregister_port() again and oopses:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
>   RIP: 0010:serial_core_unregister_port+0xef/0x990
>   Call Trace:
>    serial8250_unregister_port+0x1e4/0x8a0
>    serial8250_remove+0x8c/0xb0
>    platform_remove+0x5f/0x80
>    device_release_driver_internal+0x46b/0x640
>    unbind_store+0xf8/0x110
>    sysfs_kf_write+0xf2/0x150
>    vfs_write+0x6ac/0x1050
> 
> Return early when there is no port device to remove, and read
> port->port_dev under port_mutex, since every other update of that
> field is serialised by it.
> 
> Also clear port->port_dev on the serial_core_register_port() error
> path. serial_base_port_device_remove() frees the port device but left
> the pointer behind, so unregistering after a failed registration read
> freed memory instead. That is the use-after-free variant of the same
> crash, and matches the title syzbot first reported this under.

It's an invalid syzbot reproducer, if root tells the kernel to unbind
from a device when it is being used, it gets to keep the pieces when
things break :(

Let me go polish off my "taint the kernel if bind/unbind runs" patch to
keep this from happening...

> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Reported-by: syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9f57c1b2792029198fcf
> Cc: stable@vger.kernel.org
> Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>

Did you forget an Assisted-by: tag?

thanks,

greg k-h
