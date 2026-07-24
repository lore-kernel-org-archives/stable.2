Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E9427F9C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888788; cv=none; b=P0mTuY68CecbvGMJCUKyyDwMik1WYSItKtFujr8mmVKN5OieNCEAftYbLeRDT32baf75KIFnlz7Jk1DiAaKT6rCJVNaZbm0pifpa8TT5tGIg8ZycTLXErVgR6u2wmCch36lpIQWWT45o7uRzc7Lzrx/HRRmA/yaRkEcAef8M7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888788; c=relaxed/simple;
	bh=L13z0v/4V6iedGU6W+kYIv2UwuIh87L+nvy6bkLdUfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShFioSWfyEkj7RyszBqeLf2dYWSkRzyQiIe+0OxU2AF/qYYnNiO/Atfj/Ek+mxP6cx1FQI/A/aKyCmL2joOEIVoteuvVwInCsDxC4FV3rLP2YoRzvmcptqhCBLBZZQ7jhWEXGnXlZKJXuEJK2IUGhqekdgmUci1JbkwdhBkIwjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7G/1GCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7G/1GCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478FF1F000E9;
	Fri, 24 Jul 2026 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784888781;
	bh=VZbJsfM6Q57fvYHzlpRyc+n7GClON6xfcZQx8njmxPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L7G/1GCRBsmezvkG81qp8fpgDk/DIKO1vk4JXhmPXRrZvK30smJQotKVBFHPa+DpF
	 M6cRQmhVtEPctTFXDJQDYT6/an7iRQ3+Dg2kGU1VUZ5xgG2dyEubGYIAcHAOasAiuf
	 H72HFf+Tj9+agVykfXhsIocxLxHbIFltPIp2g2eE=
Date: Fri, 24 Jul 2026 12:26:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.15.y 0/9] can: bcm: backport of 9 patches that failed
 to apply to 5.15-stable
Message-ID: <2026072407-bannister-squash-adfe@gregkh>
References: <20260724083756.12430-1-socketcan@hartkopp.net>
 <2026072409-schilling-scheming-5aa9@gregkh>
 <82d7e31c-ecc7-4fd7-a710-32f39832e8f1@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82d7e31c-ecc7-4fd7-a710-32f39832e8f1@hartkopp.net>

On Fri, Jul 24, 2026 at 11:00:02AM +0200, Oliver Hartkopp wrote:
> 
> 
> On 24.07.26 10:52, Greg KH wrote:
> > On Fri, Jul 24, 2026 at 10:37:47AM +0200, Oliver Hartkopp wrote:
> > > This resubmits "can: bcm: add locking when updating filter and timer
> > > values" (commit 749179c2e25b95d22499ed29096b3e02d6dfd2b4 upstream),
> > > which failed to apply to the 5.15-stable tree, together with 8
> > > further bcm.c patches from the same upstream series that build on it
> > > and would otherwise fail for the same reason. This is the full set
> > > of 11 upstream bcm.c patches from 7.2-rc3 minus the 2 already queued
> > > by the normal stable process for 5.15 ("can: bcm: fix lockless
> > > bound/ifindex race and silent RX_SETUP failure", "can: bcm: add
> > > missing rcu list annotations and operations").
> > > 
> > > This assumes the 2 already-queued bcm.c patches for 5.15-stable have
> > > landed by the time this is applied. If not, please let me know and I
> > > will rebase.
> > 
> > This is a mess, it showed up like this in our inboxes, with no threading
> > or information about which patch was for what tree at all:
> > 
> >     1 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
> >     2 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 7/9] can: bcm: fix stale rx/tx ops after device removal
> >     3 N   Jul 24 Oliver Hartkopp (1.4K) [PATCH 6.12.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.12-stable
> >     4 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.15.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.15-stable
> >     8 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 1/8] can: bcm: add locking when updating filter and timer values
> >     9     Jul 24 Oliver Hartkopp (2.5K) [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
> >    10 N   Jul 24 Oliver Hartkopp (3.5K) [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
> >    11 N   Jul 24 Oliver Hartkopp (1.4K) [PATCH 6.1.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.1-stable
> >    12 N   Jul 24 Oliver Hartkopp (6.7K) [PATCH 3/8] can: bcm: extend bcm_tx_lock usage for data and timer updates
> >    13 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 1/8] can: bcm: add locking when updating filter and timer values
> >    14 N   Jul 24 Oliver Hartkopp (5.2K) [PATCH 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
> >    15 N   Jul 24 Oliver Hartkopp (4.0K) [PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal
> >    16 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.10.y 0/9] can: bcm: backport of 9 patches that failed to apply to 5.10-stable
> >    18 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 6/8] can: bcm: fix stale rx/tx ops after device removal
> >    19 N   Jul 24 Oliver Hartkopp (5.2K) [PATCH 9/9] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
> >    20 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
> >    21 N   Jul 24 Oliver Hartkopp (6.5K) [PATCH 2/8] can: bcm: fix CAN frame rx/tx statistics
> >    22 N   Jul 24 Oliver Hartkopp (3.5K) [PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
> >    23 N   Jul 24 Oliver Hartkopp ( 13K) [PATCH 2/9] can: bcm: add locking when updating filter and timer values
> >    24 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
> >    25 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 7/9] can: bcm: fix stale rx/tx ops after device removal
> >    26 N   Jul 24 Oliver Hartkopp (2.5K) [PATCH 8/9] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
> >    27 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
> >    28 N   Jul 24 Oliver Hartkopp (4.0K) [PATCH 6/9] can: bcm: add missing device refcount for CAN filter removal
> >    29 N   Jul 24 Oliver Hartkopp (6.5K) [PATCH 3/9] can: bcm: fix CAN frame rx/tx statistics
> > 
> > 
> > I'll delete all of these now, and can you use 'git send-email' or some
> > such tool that properly links emails together so that we have a chance
> > to be able to apply them?
> 
> The mails all contain the in-reply-to tag, so that they can be assigned.

Kind of, because of that, it really looks like this in my mbox:

  30   F Jul 20 To socketcan@ha (8.0K) FAILED: patch "[PATCH] can: isotp: fix use-after-free race with concurrent" failed to apply to 6.12-stable tree
  31 N   Jul 24 Oliver Hartkopp (7.1K) └─>[PATCH 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER                                                                                                       
  32   F Jul 20 To socketcan@ha ( 16K) FAILED: patch "[PATCH] can: isotp: serialize TX state transitions under so->rx_lock" failed to apply to 6.1-stable tree
  33 N   Jul 24 Oliver Hartkopp ( 14K) └─>[PATCH 2/2] can: isotp: serialize TX state transitions under so->rx_lock                                                                                                                
  34   F Jul 20 To socketcan@ha ( 16K) FAILED: patch "[PATCH] can: isotp: serialize TX state transitions under so->rx_lock" failed to apply to 6.12-stable tree
  35 N   Jul 24 Oliver Hartkopp ( 14K) └─>[PATCH 2/2] can: isotp: serialize TX state transitions under so->rx_lock                                                                                                                
  36 N   Jul 24 Oliver Hartkopp (1.1K) [PATCH 6.12.y 0/2] can: isotp: backport of 2 patches that failed to apply to 6.12-stable                                                                                                   
  37 N   Jul 24 Oliver Hartkopp (1.1K) [PATCH 6.6.y 0/2] can: isotp: backport of 2 patches that failed to apply to 6.6-stable                                                                                                     
  38   F Jul 20 To socketcan@ha (8.0K) FAILED: patch "[PATCH] can: isotp: fix use-after-free race with concurrent" failed to apply to 6.6-stable tree
  39 N   Jul 24 Oliver Hartkopp (7.1K) └─>[PATCH 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER                                                                                                       
  40   F Jul 20 To socketcan@ha ( 16K) FAILED: patch "[PATCH] can: isotp: serialize TX state transitions under so->rx_lock" failed to apply to 6.6-stable tree
  41 N   Jul 24 Oliver Hartkopp ( 14K) └─>[PATCH 2/2] can: isotp: serialize TX state transitions under so->rx_lock                                                                                                                
  42 N   Jul 24 Oliver Hartkopp (1.1K) [PATCH 6.1.y 0/2] can: isotp: backport of 2 patches that failed to apply to 6.1-stable                                                                                                     
  43   F Jul 20 To socketcan@ha (8.0K) FAILED: patch "[PATCH] can: isotp: fix use-after-free race with concurrent" failed to apply to 6.1-stable tree
  44 N   Jul 24 Oliver Hartkopp (7.0K) └─>[PATCH 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER                                                                                                       
  45   F Jul 20 To socketcan@ha ( 16K) FAILED: patch "[PATCH] can: isotp: serialize TX state transitions under so->rx_lock" failed to apply to 5.15-stable tree
  46 N   Jul 24 Oliver Hartkopp ( 14K) └─>[PATCH 2/2] can: isotp: serialize TX state transitions under so->rx_lock                                                                                                                
  47   F Jul 20 To socketcan@ha (4.3K) FAILED: patch "[PATCH] can: bcm: validate frame length in bcm_rx_setup() for RTR" failed to apply to 6.18-stable tree
  48 N   Jul 24 Oliver Hartkopp (3.5K) └─>[PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies                                                                                                           
  49 N   Jul 24 Oliver Hartkopp (1.4K) [PATCH 6.18.y 0/8] can: bcm: backport of 8 patches that failed to apply to 6.18-stable                                                                                                     
  50   F Jul 20 To socketcan@ha (8.0K) FAILED: patch "[PATCH] can: isotp: fix use-after-free race with concurrent" failed to apply to 5.15-stable tree
  51 N   Jul 24 Oliver Hartkopp (7.0K) └─>[PATCH 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER                                                                                                       
  52 N   Jul 24 Oliver Hartkopp (1.1K) [PATCH 5.15.y 0/2] can: isotp: backport of 2 patches that failed to apply to 5.15-stable                                                                                                   
  53   F Jul 20 To socketcan@ha (8.0K) FAILED: patch "[PATCH] can: isotp: fix use-after-free race with concurrent" failed to apply to 5.10-stable tree
  54 N   Jul 24 Oliver Hartkopp (7.0K) └─>[PATCH 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER                                                                                                       
  55   F Jul 20 To socketcan@ha (5.2K) FAILED: patch "[PATCH] can: bcm: add missing device refcount for CAN filter removal" failed to apply to 6.18-stable tree
  56 N   Jul 24 Oliver Hartkopp (4.0K) └─>[PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal                                                                                                                
  57   F Jul 20 To socketcan@ha (4.3K) FAILED: patch "[PATCH] can: bcm: validate frame length in bcm_rx_setup() for RTR" failed to apply to 6.12-stable tree
  58 N   Jul 24 Oliver Hartkopp (3.5K) └─>[PATCH 4/8] can: bcm: validate frame length in bcm_rx_setup() for RTR replies                                                                                                           
  59   F Jul 20 To socketcan@ha (7.6K) FAILED: patch "[PATCH] can: bcm: fix CAN frame rx/tx statistics" failed to apply to 6.12-stable tree
  60 N   Jul 24 Oliver Hartkopp (6.8K) └─>[PATCH 2/8] can: bcm: fix CAN frame rx/tx statistics                                                                                                                                    
  61   F Jul 20 To socketcan@ha (3.3K) FAILED: patch "[PATCH] can: bcm: fix data race on rx_stamp/rx_ifindex in" failed to apply to 6.12-stable tree
  62 N   Jul 24 Oliver Hartkopp (2.5K) └─>[PATCH 7/8] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()                                                                                                          
  63   F Jul 20 To socketcan@ha (7.5K) FAILED: patch "[PATCH] can: bcm: extend bcm_tx_lock usage for data and timer updates" failed to apply to 6.12-stable tree
  64 N   Jul 24 Oliver Hartkopp (6.7K) └─>[PATCH 3/8] can: bcm: extend bcm_tx_lock usage for data and timer updates                                                                                                               
  65   F Jul 20 To socketcan@ha (6.0K) FAILED: patch "[PATCH] can: bcm: track a single source interface for ANYDEV" failed to apply to 6.12-stable tree
  66 N   Jul 24 Oliver Hartkopp (5.2K) └─>[PATCH 8/8] can: bcm: track a single source interface for ANYDEV timeout/throttle ops                                                                                                   
  67   F Jul 20 To socketcan@ha ( 16K) FAILED: patch "[PATCH] can: isotp: serialize TX state transitions under so->rx_lock" failed to apply to 5.10-stable tree
  68 N   Jul 24 Oliver Hartkopp ( 14K) └─>[PATCH 2/2] can: isotp: serialize TX state transitions under so->rx_lock                                                                                                                
  69 N   Jul 24 Oliver Hartkopp (1.1K) [PATCH 5.10.y 0/2] can: isotp: backport of 2 patches that failed to apply to 5.10-stable                                                                                                   
  70   F Jul 20 To socketcan@ha (4.3K) FAILED: patch "[PATCH] can: bcm: validate frame length in bcm_rx_setup() for RTR" failed to apply to 5.15-stable tree
  71 N   Jul 24 Oliver Hartkopp (3.5K) └─>[PATCH 5/9] can: bcm: validate frame length in bcm_rx_setup() for RTR replies                                                                                                           
  72   F Jul 20 To socketcan@ha (5.2K) FAILED: patch "[PATCH] can: bcm: add missing device refcount for CAN filter removal" failed to apply to 5.15-stable tree
  73 N   Jul 24 Oliver Hartkopp (4.0K) └─>[PATCH 6/9] can: bcm: add missing device refcount for CAN filter removal                                                                                                                
  74   F Jul 20 To socketcan@ha (6.6K) FAILED: patch "[PATCH] can: bcm: fix stale rx/tx ops after device removal" failed to apply to 6.12-stable tree
  75 N   Jul 24 Oliver Hartkopp (5.9K) └─>[PATCH 6/8] can: bcm: fix stale rx/tx ops after device removal                                                                                                                          
  76   F Jul 20 To socketcan@ha (5.2K) FAILED: patch "[PATCH] can: bcm: add missing device refcount for CAN filter removal" failed to apply to 6.12-stable tree
  77 N   Jul 24 Oliver Hartkopp (4.0K) └─>[PATCH 5/8] can: bcm: add missing device refcount for CAN filter removal                                                                                                                
  78   F Jul 20 To socketcan@ha ( 14K) FAILED: patch "[PATCH] can: bcm: add locking when updating filter and timer values" failed to apply to 6.12-stable tree
  79 N   Jul 24 Oliver Hartkopp ( 13K) └─>[PATCH 1/8] can: bcm: add locking when updating filter and timer values                                                                     


Again, impossible to process :(

> What would help you best?

Patch series, sent with the subject you did for the 0/X email, and then
the patches in reply-to that 0/X email.

As you can see above, your 0/X emails are "floating" out there :(

> E.g. having the stable trees inside the msg description, like
> 
> >    16 N   Jul 24 Oliver Hartkopp (1.5K) [PATCH 5.10.y 0/9] can: bcm:
> backport of 9 patches that failed to apply to 5.10-stable
> >    18 N   Jul 24 Oliver Hartkopp (5.9K) [PATCH 5.10.y 6/8] can: bcm: fix
> stale rx/tx ops after device removal

Yes, that would be wonderful.  As always, there are thousands of
examples of this in the stable mailing list archives if you want to see
how others do it.

thanks,

greg k-h
