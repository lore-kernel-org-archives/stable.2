Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD8529410;
	Tue, 29 Sep 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689220; cv=none; b=SBFk9zBNv4zl6G1ehMehOdysTltPPjaZe/xamWJ12AeeEUE3VUxjgDzdY9n8KXMw5+rMhCJFiIXLRrtPHW5cCVNmAqzMhyB4GahDkJGv8/HAEZqicD5fNLiw13FEPnnOKQk3ZhRlil5tZiqtMOhvFOS5RVS1rDWRqJQwpgxn7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689220; c=relaxed/simple;
	bh=6vJ9b9bS9ESJb229rOpDBG3VQsTM/rdgRvhIxm5dh5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvKZCGIQH3Xp6kIsR3DXGEIC32Kr23P+A/tpqkofkBDekC2OQU0C2KO6B92AF5kieJCfbSfNs9yyyUeTNj1y9e2wjlCBogOOwi/JNFxRSyDvDGMDzmxoqAqjwY/7exO5oKD3NQ1/DV0dv4dBzCZE3dAEHieiMbNwwVgMvGP++zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhmqGA/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhmqGA/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A9E1F000FF;
	Tue, 29 Sep 2026 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689219;
	bh=j94Pa7VaM7p8c8Dlh15w0T8p+gaw53KcUh+dh03Y6Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FhmqGA/J4nAUMmHg/+TJAeA1ecKTP+SXxKCGH1QR/BjWQ853pLgu8DZtRRmFOuO47
	 kLx8v81VNWU86xEKDDkvEPuDcAi1xhTNdtt4xaPqxPy1phfS5+0C6CVirwXFzE3FUB
	 SratOoqYVrdTlHzr3qNQN6C9qv7P9rLUfewBYzKlM2aPcDvbnuDhny5VHV/qUU/JG+
	 cgW+gepzMhbgTCTqro7r35uMHkvao0mVTesp0QXsyeNAETbv/g4l0BC+gIlLcPDPyX
	 vhKTc3AjsO++7hEy8j1eVXf7d72gIBZGQoEBHGtpe8JRmlYHHq7pU+l8Ynv2FBc73t
	 M68QuyONhPl0w==
Date: Tue, 29 Sep 2026 15:40:15 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Antoine Tenart <atenart@kernel.org>, 
	Chengfeng Ye <nicoyip.dev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net-sysfs: release the TX queue tracker before
 allowing reuse
Message-ID: <aru-5vdHmZw2d3a_@kwain>
References: <20260926173315.2452612-1-nicoyip.dev@gmail.com>
 <arty-oqohbGiefgS@kwain>
 <CANn89iLzwsrka1MUS64RKxx9TbKxGdwzB63nzs6v9endCwUahQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLzwsrka1MUS64RKxx9TbKxGdwzB63nzs6v9endCwUahQ@mail.gmail.com>

On Tue, Sep 29, 2026 at 11:27:54AM +0200, Eric Dumazet wrote:
> On Tue, Sep 29, 2026 at 10:13 AM Antoine Tenart <atenart@kernel.org> wrote:
> >
> > On Sun, Sep 27, 2026 at 01:33:15AM +0800, Chengfeng Ye wrote:
> > > An interrupted sysfs_rtnl_lock() can drop the last kobject reference to a
> > > removed TX queue without holding RTNL. netdev_queue_release() clears the
> > > kobject before releasing queue->dev_tracker, allowing the queue to be
> > > re-added while the old release still needs the shared tracker slot:
> > >
> > >   CPU 0                               CPU 1
> > >   netdev_queue_release()
> > >     memset(kobj, 0, sizeof(*kobj))
> > >                                       netdev_queue_add_kobject()
> > >                                         state_initialized is clear
> > >                                         netdev_hold() installs new tracker
> > >     netdev_put() releases the new tracker
> > >
> > > With CONFIG_NET_DEV_REFCNT_TRACKER enabled, the old tracker is leaked and
> > > the new lifetime's tracker is released prematurely. A later queue release
> > > then reports a double release. The numeric device references remain
> > > balanced.
> > >
> > > The kernel reported:
> > >
> > >   ref_tracker: reference already released.
> > >   ref_tracker: allocated in:
> > >    netdev_queue_update_kobjects+0x23d/0x5c0
> > >    netif_set_real_num_tx_queues+0x111/0x820
> > >    veth_set_channels+0x327/0x930
> > >    ethtool_set_channels+0x3ee/0x490
> > >   ref_tracker: freed in:
> > >    netdev_queue_release+0xbd/0x130
> > >    kobject_put+0x1f9/0x280
> > >    sysfs_rtnl_lock+0x18b/0x1f0
> > >    xps_rxqs_show+0xad/0x250
> > >   WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x49e/0x6d0
> > >   Call Trace:
> > >    netdev_queue_release+0xbd/0x130
> > >    kobject_put+0x1f9/0x280
> > >    netdev_queue_update_kobjects+0x3f9/0x5c0
> > >    netif_set_real_num_tx_queues+0x111/0x820
> > >    veth_set_channels+0x327/0x930
> > >    ethtool_set_channels+0x3ee/0x490
> > >
> > > Release the tracker before clearing the kobject. Use a full memory barrier
> > > to order the tracker access before clearing state_initialized, paired with
> > > the control dependency from that check to the new tracker allocation.
> > > Keep the device reference until after the reset so that the queue storage
> > > remains alive throughout the callback's accesses.
> > >
> > > Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attributes")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > > ---
> > >  net/core/net-sysfs.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > > index 352173df7578..b9aadc4c000c 100644
> > > --- a/net/core/net-sysfs.c
> > > +++ b/net/core/net-sysfs.c
> > > @@ -1906,8 +1906,11 @@ static void netdev_queue_release(struct kobject *kobj)
> > >  {
> > >       struct netdev_queue *queue = to_netdev_queue(kobj);
> > >
> > > +     netdev_tracker_free(queue->dev, &queue->dev_tracker);
> > > +     /* Finish using the tracker before allowing the queue to be re-added. */
> > > +     smp_mb();
> >
> > Can't you use smp_wmb() instead as it's used to order two stores?
> 
> I do not think smp_wmb() would be enough: ref_tracker_free() only reads
> queue->dev_tracker, it never writes to it. We need to order a load
> before a store; smp_wmb() only orders stores.

Ah right, it's not a store. Thanks for checking!

> But what does this smp_mb() pair with in netdev_queue_add_kobject()?
> 
> The changelog mentions a control dependency, but netdev_hold() is not
> inside the if () clause, and state_initialized is a bitfield, so
> READ_ONCE() is not possible. This works thanks to the early return,
> but it is implicit and fragile.
> 
> Please add an explicit smp_mb() in netdev_queue_add_kobject() after
> the state_initialized check, with a comment pointing to
> netdev_queue_release(). This is not a fast path, and will help code
> review/understanding.
> 
> if (unlikely(kobj->state_initialized)) {
>         netdev_warn_once(dev, "Cannot re-add tx queues before their
> removal completed");
>         return -EAGAIN;
> }
> /* Pairs with smp_mb() in netdev_queue_release(): the previous
> * lifetime must be done with queue->dev_tracker before we reuse it.
> */
> smp_mb();

+1

> Also change ( /* Finish using the tracker before allowing the queue to
> be re-added. */)
> to the symmetric one (pairs with smp_mb() in  in netdev_queue_add_kobject()...)
