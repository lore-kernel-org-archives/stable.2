Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E530F94B;
	Tue, 16 Jun 2026 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596833; cv=none; b=CRocUrrth2H6GVACRLHNMQZUj5y2QJS1oKrYxvuPa2cxVESea31FLWM8qX5XSS4k26CTbEw4ynNb18ICYYC1wh+otvp8Cdi379kreNVmO4GrdJ925vIY08BLWEzAbwaaz01L/Bd9UfK4n60AKSqtwdySw+saIl8J0pNnyb6IWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596833; c=relaxed/simple;
	bh=Sx4BgdUbXtY8349JOfSKJyM4ISXv4GQ0K95FHJm8iVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndC/rvUjCw+WZmgnG2fPBAGHAWHONP3BhWzr7JMSwsqP2BVV9S3SSVqQottv5CmkdCvffsK36CtEETBjHgOrGsLqR7fJ3tfocng+7MNdWpSqG8gCxva1yb+J3siHlnOC+F0zR8KmWTald1B1wszK10skJIb67JTo7CP+mSwJ/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0lt+Z0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0lt+Z0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99E01F000E9;
	Tue, 16 Jun 2026 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781596832;
	bh=nlJrRZLeExLHQ3gYWinSJScgVamHrvpcc5p0YM0ZELw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0lt+Z0f4VcLo5nFw/0K+Mbv4vITwPHJlYN18VK/JRwI72Amlyh0nPNF3YOzxC5EL
	 w9LrqgHZK7RDtt+5VkUjhV9HFlZ7t3ZiNTj65UMLbRqE3WSjuhM0tRGhJijVEutPOM
	 F/JQUnYdi+I0mjME1rc9ZiSq2In7euDc5A0fcmX0=
Date: Tue, 16 Jun 2026 13:29:28 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com,
	jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com,
	stefanha@redhat.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <2026061607-risotto-getaway-c57f@gregkh>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
 <ag8EvTp29B-Q3nCq@sgarzare-redhat>
 <2026061624-harbor-capture-a5bf@gregkh>
 <ajD_FBEak8hKNdIK@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajD_FBEak8hKNdIK@sgarzare-redhat>

On Tue, Jun 16, 2026 at 09:52:32AM +0200, Stefano Garzarella wrote:
> On Tue, Jun 16, 2026 at 10:17:31AM +0530, Greg KH wrote:
> > On Thu, May 21, 2026 at 03:15:54PM +0200, Stefano Garzarella wrote:
> > > On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
> > > > > > What's the status of that fix?
> > > > >
> > > > > Stefano posted v3 and is working on v4.
> > > > >
> > > > > >  Should it be reverted elsewhere?
> > > > >
> > > > > Donnu. With the change we have no DoS but the socket gets silently
> > > > > broken.  Eric felt given the brokenness is upstream already it's better
> > > > > to work on a fix on top, not revert.
> > > >
> > > > Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
> > > > follow-up once it lands upstream.
> > > 
> > > FYI v4 is now merged in the net tree, so I guess they will land upstream
> > > soon. I CCed stable on both patches:
> > > 
> > > a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> > > c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full
> > > buf_alloc")
> > > 
> > > Both are related, but the second is the main fix of this patch.
> > 
> > THe second one doesn't apply at all :(
> > 
> 
> The second one is the fix of the patch originally added to stable queue by
> this thread, so should be applied on top of it (commit 059b7dbd20a6
> ("vsock/virtio: fix potential unbounded skb queue")).
> 
> I'm working on improving memory management, but for now I think it makes
> sense to backport all three to the stable branches.
> 
> So, in summary:
> 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full buf_alloc")

Again, this last one fails to apply everywhere :(

thanks,

greg k-h
