Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAA3254AF;
	Tue, 16 Jun 2026 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603079; cv=none; b=ju8njIgU1ZSETgH9sToLB0wUu9dRjZ9iBrAc+coFdHbP8oISH/FYCO/hBVDSR9RHb77L02MYzBRFHhPMogI7Lo2koEGsHKzY7OKMaWySYxATQK9IyTkyoHugMjfXCF136ddlB623ng3K+X39/rDatIupFyk0r3v1L1rnwWXw9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603079; c=relaxed/simple;
	bh=u3lluoPEdWO0+dGbFE0Q9ERMeCLLYy3Of1xuBDYfdlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm+B0/TakROl77hgwo1CYSWmbs3Wth6hBJt4hrjdhx2f4mW0TGxd65jY6s3tZvqD7wqEhPQjc8q+rV+NXS/5mggTW2iGMen+6mG11BukzwHQutiUkQDvnywhinyC+qIgJyVYzncQZ+H856g21pcUZcz910KS3N2W2WKuURuAMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1NWGaeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1NWGaeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E11F000E9;
	Tue, 16 Jun 2026 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781603077;
	bh=uYKv1ykBzXWm3lpL8/mfBmwASj0+sYgUMr2UpvygTWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h1NWGaeh95BJ//WskBpG4gXvF+6ChJbz22mm9f/EOT97zuz1vSRgbT0Sq3GNBPEfa
	 vPwBU/l4AvOuhoCBm+zaXrt2COzkqquUie9BXTv2zld3hS1Fst0ZEd3N3joMZG8xxH
	 Wo+N0k/SO9dh8l+anhWGAs8e9Es7ZRAOECThJo34=
Date: Tue, 16 Jun 2026 15:13:33 +0530
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
Message-ID: <2026061606-generous-smudge-2036@gregkh>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
 <ag8EvTp29B-Q3nCq@sgarzare-redhat>
 <2026061624-harbor-capture-a5bf@gregkh>
 <ajD_FBEak8hKNdIK@sgarzare-redhat>
 <2026061607-risotto-getaway-c57f@gregkh>
 <CAGxU2F6PDqHKLsW97qLUg+7hWq=iYk5qDAGUuxWSbdkyEDmsQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F6PDqHKLsW97qLUg+7hWq=iYk5qDAGUuxWSbdkyEDmsQw@mail.gmail.com>

On Tue, Jun 16, 2026 at 10:36:43AM +0200, Stefano Garzarella wrote:
> On Tue, 16 Jun 2026 at 10:00, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 16, 2026 at 09:52:32AM +0200, Stefano Garzarella wrote:
> > > On Tue, Jun 16, 2026 at 10:17:31AM +0530, Greg KH wrote:
> > > > On Thu, May 21, 2026 at 03:15:54PM +0200, Stefano Garzarella wrote:
> > > > > On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
> > > > > > > > What's the status of that fix?
> > > > > > >
> > > > > > > Stefano posted v3 and is working on v4.
> > > > > > >
> > > > > > > >  Should it be reverted elsewhere?
> > > > > > >
> > > > > > > Donnu. With the change we have no DoS but the socket gets silently
> > > > > > > broken.  Eric felt given the brokenness is upstream already it's better
> > > > > > > to work on a fix on top, not revert.
> > > > > >
> > > > > > Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
> > > > > > follow-up once it lands upstream.
> > > > >
> > > > > FYI v4 is now merged in the net tree, so I guess they will land upstream
> > > > > soon. I CCed stable on both patches:
> > > > >
> > > > > a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> > > > > c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full
> > > > > buf_alloc")
> > > > >
> > > > > Both are related, but the second is the main fix of this patch.
> > > >
> > > > THe second one doesn't apply at all :(
> > > >
> > >
> > > The second one is the fix of the patch originally added to stable queue by
> > > this thread, so should be applied on top of it (commit 059b7dbd20a6
> > > ("vsock/virtio: fix potential unbounded skb queue")).
> > >
> > > I'm working on improving memory management, but for now I think it makes
> > > sense to backport all three to the stable branches.
> > >
> > > So, in summary:
> > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> > > c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full buf_alloc")
> >
> > Again, this last one fails to apply everywhere :(
> 
> Again, c6087c5aaad6 depends on 059b7dbd20a6 (as also indicated by the 
> Fixes tag in the patch description).
> 
> I don't know what you meant with "everywhere", but I just run `git 
> cherry-pick 059b7dbd20a6 c6087c5aaad6` on linux-6.12.y, linux-6.18.y, 
> and linux-7.0.y without any issue.

Sorry, I was just searching for the short-id, which is in commits
already in those trees.  The real commit worked, sorry for the
confusion.

> On linux-6.6.y it's failing because we are missing zero-copy support in 
> AF_VSOCK. So, I guess we didn't backport commit 45ca7e9f0730 
> ("vsock/virtio: fix `rx_bytes` accounting for stream sockets") because 
> there were conflicts.  That patch is needed to apply commit 059b7dbd20a6 
> ("vsock/virtio: fix potential unbounded skb queue") cleanly.

That commit does not backport cleanly to 6.6.y, so I still need a patch
series for that tree.

thanks,

greg k-h
