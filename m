Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35433D3CFF
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646862; cv=none; b=Kp2LyLSav4jb+HKlxzIrJME4S2HIlinA9FCpP++VQWJSGadlNtw0m1DZZuEmPC2Q9RPftahquWde8dKfMSuSyZzvvolwIhwQcplsFFvdIKqUbOvaVCgGN+h87JVb6Sa2vwhSXiKit+5AouMyIIbBO3YMCD6hVSgiAjdWWrKPEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646862; c=relaxed/simple;
	bh=k9UdTUFjCo/3f5G+Pxw2bjAU9qkDmVibVVrVSl/63c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3I/Mk+veb8Bdk6XApVuBgSxnXcM8NMiv2lp9hSUtexh+v/sb9zkQJ0EJJJOjPJ7jPgVE9caHvjzmTTtV5nWKzY1/1fgDTWFkaM+vUwBjF1Md29evjxikNhXi4uOi6Ozw3h50f3V/sDSEYBIHZPI+iKRRIHVLm6mJc14sYOjDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=SXYazNjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZbLS/ik; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SXYazNjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZbLS/ik"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CFC96EC013B;
	Tue, 25 Aug 2026 04:34:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 25 Aug 2026 04:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787646859; x=1787733259; bh=e+f+zDfK/d
	BUvvOD26PpzhWLBdVpYsQESNCQ0eubESk=; b=SXYazNjzuUQiUcpCMAZ3Pzykki
	4rMbJD2vZzpK7EUsJxmgwpDPBXcvgTSbwyqL0QVTrFkn0RpSjvE7aTpuQ0kGBmPu
	1KOUrtheOgTnh2n+jzJIjyOoozlY2li75RjYp4nksPkH/3IpoyGi4KZMNNQOq/XI
	p4CyYEW1+9cFW7t0wqbv3A4v7Pt7PrOghmhymklM0JpcvTtcywrI3y61gtAtUdoE
	0Q7nV4GUujPsbOnoNz8Qg3Zjh4JRh9HJDVU6Of09yQo+Hr7Ra2nsdPEK1jk6ZXUd
	mAkklB6vRRgI4VyDirwvH6W/Zv4kGQYSkPsRKmvGfxGok/53wrZkPDlxcaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787646859; x=1787733259; bh=e+f+zDfK/dBUvvOD26PpzhWLBdVpYsQESNC
	Q0eubESk=; b=JZbLS/ikhaJoBUdMDyqNjBiSG5ngp0WZIfA/RHvKH9dC+Ne+Zxg
	ckJrBDDtkOtrJTMarauLKJlHiK+s7PZDSOzA0AVdCSWy3ffAMW8nxN1JG9SgsQfb
	GwSwGuvuuSyfL4L+HkuJ42trJZu0t+aGapi4FVKwe3u9qBsvRWZ3RJR+JFhHaGYY
	VuznR1s0tf+s4eARzQ5kEgo6RMA9tKn422mvebhzFoi0yiSul+8H18nDqjD/s60b
	gwLnsRa8h2sS+03+78/zeqKCvlBzUDWO7i9cx0vtB6aNNnMfQ9zSOMNgUPS5jShU
	lSk+EHNfdPKACJ4w4hfQxGl0FSnhWlqO1nw==
X-ME-Sender: <xms:i1ONavQCPOpDYkxdugANdEITCj3xNj_CSB3fgBSWtHTWd--XZzRwRQ>
    <xme:i1ONatL5BDj-APoy3uQ2sM-l88Q-fLiKLlGDL1soNpygjZDbeeQymDzXqQDYnvUd9
    pjDFY8D74_WcnDMtdwRKGP13nIbr5hOJGF6Sy2rEGRa80lF5Q>
X-ME-Received: <xmr:i1ONapSb5P5-vKvHgeSDlYxJdossoDJjqLQFYjY0rB6TcJ3O4BzJ8YD2ks60r_-UJL3gPWvOBt-fzAo50zYUxiRleGlQVrbUxlqvj9-xhTw>
X-ME-Proxy-Cause: dmFkZTGsMRe1TW8gFMsPZEZXruyDsIrahTHapajjyCXDg8pAOrkY8dekrH6Yr3IKdqA90w
    tnhb4KUuGVt0GXZckJGLUk/dEOQ4TdN+Qd/Q2tAvIHaY5bA4kW6XhiEaZZ7C7cOG+NlY1e
    OG5Q6odqRLYj1zfkGiVgnqlYGHayo2F+kMpG1wat9Dcfxw+LL5kYJGsSRSD0sgsxZpBgUO
    pidJWje1yD5rI/nFW3tmL9XMINfMsKN4pogYx/s6zgxASkJ7OQIiMWxvO3+s6SbCduIV40
    RKaztSy7LdDUMYFZhc/5Vx36n4GYJCWnFzt+Byj0reIu1OZ/00+ce1O5j0bCsKAHZKtDqK
    LlnacvJ4E1Vm2WTGdy327SQ9TT+YsoUh7QjoM+Ai12L89VAXouLU+n88Sh0dh93/bfTVuK
    Y9O6NCETNJCfj1tw6VW1xXUrukt4mujrWY9seMBTRFCcDyD48UsbWJdfQ8dbWXjfpPapUQ
    pw+6F2jL94SiN6Sgu8R2gjVTCNDR/6oUZP4kryuYT/9+xc+UvFaZ2f9vgZ8aM+dFoDXS5S
    PsTo9x7u/0b383ZuQToaxWhKkDKk9Qc2sIlwgdr6O06VqEJ1jPzZ9U9b8AdXoba3kxCd8T
    lvEu+dkH3c7LJhbvQHeUk7QsqAT1ETLJiDirgEnm1eZaIY1fcSGrck/occMA
X-ME-Proxy: <xmx:i1ONatJKwjYhRE9qcTFc2MpVrqI0K-abHyl3mAqb-bWlRA4u7w0mxQ>
    <xmx:i1ONak8nUaLjyKgVXn1iC_twjzUoPAd-wTurmJcSBzzBkfPr_waSPg>
    <xmx:i1ONasLaGeDvRBFiOQt4FvXaqaReekIyy5JTgnuUFDcVeuyEaqINCA>
    <xmx:i1ONarF1jyASyfRcCP2ONwUAYY6yEVcJL_CgMaWmvZm0pXAzXpKyXw>
    <xmx:i1ONarZyYhgRnd0OEovnmVA30I0EHl3KdtK1QpwSKB6-jpP5KfD9gFig>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 04:34:18 -0400 (EDT)
Date: Tue, 25 Aug 2026 10:34:10 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 5.10.y] s390/vfio_ccw: Implement a crw lock
Message-ID: <2026082504-prewashed-juggle-c0c8@gregkh>
References: <2026082012-jam-hardly-84ee@gregkh>
 <20260824162615.4144738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824162615.4144738-1-sashal@kernel.org>

On Mon, Aug 24, 2026 at 12:26:15PM -0400, Sasha Levin wrote:
> From: Eric Farman <farman@linux.ibm.com>
> 
> [ Upstream commit 16b0798024c0e9117e395829ddbbe70981c79d9c ]
> 
> Unlike the channel_program struct, which covers synchronous I/O
> submissions and asynchronous interrupts, the CRW region relies
> exclusively on asynchronous events coming from hardware.
> 
> Implement a lock to manage the list of those payloads, to ensure
> they are read cohesively.
> 
> Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/s390/cio/vfio_ccw_chp.c     | 16 +++++++++++-----
>  drivers/s390/cio/vfio_ccw_drv.c     | 10 ++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  4 ++++
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index 13b26a1c79886..4fc493584a1e2 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -84,19 +84,24 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>  	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
>  	struct ccw_crw_region *region;
>  	struct vfio_ccw_crw *crw;
> +	unsigned long flags;
>  	int ret;
>  
>  	if (pos + count > sizeof(*region))
>  		return -EINVAL;
>  
> +	mutex_lock(&private->io_mutex);
> +	region = private->region[i].data;
> +
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	crw = list_first_entry_or_null(&private->crw,
>  				       struct vfio_ccw_crw, next);
>  
>  	if (crw)
>  		list_del(&crw->next);
>  
> -	mutex_lock(&private->io_mutex);
> -	region = private->region[i].data;
> +	/* Drop CRW lock while copying to userspace */
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  
>  	if (crw)
>  		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
> @@ -107,14 +112,15 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>  		ret = count;
>  
>  	region->crw = 0;
> -
> -	mutex_unlock(&private->io_mutex);
> -
>  	kfree(crw);
>  
>  	/* Notify the guest if more CRWs are on our queue */
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	if (!list_empty(&private->crw) && private->crw_trigger)
>  		eventfd_signal(private->crw_trigger, 1);
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
> +
> +	mutex_unlock(&private->io_mutex);
>  
>  	return ret;
>  }
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index e3c1060b6056c..83993a1423d00 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -119,11 +119,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>  static void vfio_ccw_crw_todo(struct work_struct *work)
>  {
>  	struct vfio_ccw_private *private;
> +	unsigned long flags;
>  
>  	private = container_of(work, struct vfio_ccw_private, crw_work);
>  
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	if (!list_empty(&private->crw) && private->crw_trigger)
>  		eventfd_signal(private->crw_trigger, 1);
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  }
>  
>  /*
> @@ -207,6 +210,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>  	INIT_LIST_HEAD(&private->crw);
>  	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>  	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
> +	spin_lock_init(&private->crw_lock);
>  	atomic_set(&private->avail, 1);
>  	private->state = VFIO_CCW_STATE_STANDBY;
>  
> @@ -238,13 +242,16 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
>  {
>  	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>  	struct vfio_ccw_crw *crw, *temp;
> +	unsigned long flags;
>  
>  	vfio_ccw_sch_quiesce(sch);
>  
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {
>  		list_del(&crw->next);
>  		kfree(crw);
>  	}
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  
>  	vfio_ccw_mdev_unreg(sch);
>  
> @@ -305,6 +312,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
>  			       unsigned int rsid)
>  {
>  	struct vfio_ccw_crw *crw;
> +	unsigned long flags;
>  
>  	/*
>  	 * If unable to allocate a CRW, just drop the event and
> @@ -322,7 +330,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
>  	crw->crw.erc = erc;
>  	crw->crw.rsid = rsid;
>  
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	list_add_tail(&crw->next, &private->crw);
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  	queue_work(vfio_ccw_work_q, &private->crw_work);
>  }
>  
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 8723156b29eac..38f470c2d26c3 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -83,6 +83,8 @@ struct vfio_ccw_crw {
>   * @cp: channel program for the current I/O operation
>   * @irb: irb info received from interrupt
>   * @scsw: scsw info
> + * @crw_lock: serialization of CRW list information
> + * @crw: list of Channel Report Word elements
>   * @io_trigger: eventfd ctx for signaling userspace I/O results
>   * @io_work: work for deferral process of I/O handling
>   */
> @@ -104,6 +106,8 @@ struct vfio_ccw_private {
>  	struct channel_program	cp;
>  	struct irb		irb;
>  	union scsw		scsw;
> +
> +	spinlock_t		crw_lock;
>  	struct list_head	crw;
>  
>  	struct eventfd_ctx	*io_trigger;
> -- 
> 2.53.0
> 
> 

Does not apply to the queue :(
