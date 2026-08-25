Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F33D301F;
	Tue, 25 Aug 2026 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643335; cv=none; b=eZO1sFufy9H0w0+cxMZqCPIE5tPl/Zq4YKwzYI1lf/8Msc/gUL8LUZlZ2P2xjl0cco5Rj6623scrgmin51jZM02QoZYDtJJ801tb9issdwrXwsOiPvRRC0ZWYOPu1ZIPyFhQqHVqpwgY+oE9Z4qZURVd/8vTax8b/HZKvj2YAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643335; c=relaxed/simple;
	bh=1nBO3tqC/rh3asonVg6eCnlzcd4vt3Cy0XL/AX3sLRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9s9n41hoDnsm9/ewFT6/By+pV2U/xqM1g2UQ6TfCO29+Gpz8fip5l8lZZL1Dt5AQUXUkA8qzeOedmtfMUVR17gJwjsaJkhlE+iJ1RaBtjor2w44ZQJwFaAS3ic+tA+lVV3t6AkrH8A7+xpYvh0C2mA3PUzygbhfD/MHUSEaYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fLZ1pdWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fLZ1pdWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CAB1F000E9;
	Tue, 25 Aug 2026 07:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787643334;
	bh=rE/4jkXsLBPVikp8VMJRbXVO5XNtq5XVkVJOG3dYLrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fLZ1pdWacfBirh6QpnR1xLV5i8GmBg2gRl3mUL1WExPbc3CPIBDq6Jz56raQ8PVi4
	 +UvjAxvGfsMFCr10TUTsJ9iR+T+vsAacKaiAQu+zL6S5xC4CnlPvwP5hFLRKQc7Z1J
	 vz4d1Hiz2PNCGzlgdvqUT8XJXUDIUrL9ZUCzOGDY=
Date: Tue, 25 Aug 2026 09:35:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] klist: avoid accesses after waking klist_remove()
Message-ID: <2026082544-polyester-regroup-d935@gregkh>
References: <20260825040408.59225-1-kmehltretter@gmail.com>
 <2026082559-cyclist-annoying-7a55@gregkh>
 <ao051-T1sSobzcXP@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao051-T1sSobzcXP@gmail.com>

On Tue, Aug 25, 2026 at 09:03:25AM +0200, Karl Mehltretter wrote:
> On Tue, Aug 25, 2026 at 07:25:48AM +0100, Greg Kroah-Hartman wrote:
> > > to go out of scope and its caller to free or reuse the node.
> > 
> > But does that ever actually happen?
> 
> klist_remove() waits until the node is removed so the containing object can
> be freed. bus_remove_driver() can later free drv->p, while device_move()
> immediately adds the same node to another list.
> 
> > > The task reference keeps the waiter task alive if it returns and exits
> > > before wake_up_process(). wake_up_process() provides the full barrier
> > > required by the sleep/wakeup protocol, so remove the explicit mb().
> > 
> > I'm confused, what actual bug is here?
> 
> I found this during a targeted klist.c review.
> 
> Only later I cam across the syzbot report. That report became too prominent
> in the commit message.
> 
> klist_release() sets waiter->woken, then reads waiter->process and later
> writes n->n_klist. After seeing woken, the waiter can return on another CPU.
> 
> My initial KASAN reproducer was klist-only. One thread held an iterator while
> another removed and freed the object. A delay after the wakeup made
> the race easy, hit KASAN on n_klist in qemu arm64. 

Yes, but real-world use causes this in the kernel today?

> 
> > > Closes: https://syzkaller.appspot.com/bug?extid=9cb1ac7fce4944ba9165
> > > Tested-by: syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com
> > 
> > Are you sure?  the whole bind/unbind mess that syzbot is throwing at us
> > right now is really causing people to go down odd paths in thinking it's
> > even a valid thing to consider at all.
> 
> I did not verify the dummy_udc bind/unbind sequence. The klist issue
> does not depend on this USB path.
> 
> I can reword a v2 around the generic reproducer. anything else I should
> investigate before sending it ?

Again, what user of this api in the kernel is causing this type of
problem to require these changes?

thanks,

greg k-h
