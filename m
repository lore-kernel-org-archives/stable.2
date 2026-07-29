Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7B3EC803;
	Wed, 29 Jul 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337277; cv=none; b=ozcs4yILyA/Km2G45c4LtQy0QNYP1Jni1mtr++Jgql7FbBWRanh2gfRHs5rt34m1gJZBfuc6VamlGYkj6x0RghWvkAkeAuKNzMAH71d+Pql2mu/I8BN1drB+Qx5APS2ebaw+1eDCdfzUtcv0zkTzlOoeJOaUTytieJbnNdMnqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337277; c=relaxed/simple;
	bh=8Ixaf8F1+jRNf6tX7xW9g080h2e8P+0xSOjt/Xv9tuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aci+qdYmjgNSEc2r6S3UNCB9ODOWhZGnmP/IA5w8uSzLclePMqFoXB73IXtvCwqGco7Mqf2kn1VyjFPDlTsEU33+9SxglBvt07eYJdKxWq1zfGGI/6TuAYqxn0N9I23q+hsof1rW5rikUTSqzEoRfXNRTarzlDaSt2KWOYlEM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=mvu+67H2; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="mvu+67H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785336816; bh=8Ixaf8F1+jRNf6tX7xW9g080h2e8P+0xSOjt/Xv9tuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvu+67H2JurXfjP9o/uaHg/VUJ1zaWvuowyM9lT4ywlpem7Giur3tJwedjXUqZFAu
	 FvjnZUlD1+/hTCUw4mSluhVp8XX+lwwmdGlvMwfT9++ytUz+R0RgFs1bdOTsMZehRl
	 Hpz0yDc57/+7+tigxZHmWD3DzwBEEzYo6FZev1kgYlwoVnbPgJRCZX82laq0JXdAOI
	 Az1m4/VQeMgnvcZnCdzUb/22/8rAlJ9vhqoi2aCdftM3wSEYDxER4D0+84uaBugqxN
	 WJLU/e7gKa8yd1Fwrrgi3ETMZuzeNmMYz3r8KoojgqJn4lHWNGcse0u3xB2VXYvo+u
	 Boq9u1f+c+exA==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id 82FCB41567; Wed, 29 Jul 2026 15:53:36 +0100 (BST)
Date: Wed, 29 Jul 2026 15:53:36 +0100
From: Sean Young <sean@mess.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/15] media: rc: Fix race condition during
 rc_register_device()
Message-ID: <amoT8EjAUId230Rz@extorris.mess.org>
References: <cover.1785158244.git.sean@mess.org>
 <5479a9288629888ea5a9f25b5ac03a7384d1dce3.1785158244.git.sean@mess.org>
 <a4f5c93d-e323-4926-97fa-f65ddd40bd51@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f5c93d-e323-4926-97fa-f65ddd40bd51@kernel.org>

On Tue, Jul 28, 2026 at 11:35:36AM +0200, Hans Verkuil wrote:
> On 27/07/2026 15:18, Sean Young wrote:
> > The correct sequence for rc core is so:
> > 
> >      rc_allocation_device()
> > 
> >      /*
> >       * setup hardware and now calls to ir_raw_event_store etc are
> >       * permitted, as well as rc_keydown. There is no rc device in sysfs
> >       * or lirc chardev.
> >       */
> >      rc_register_device()
> > 
> >      /*
> >       * After rc_register_device(), the rc device can be used now from lirc
> >       * chardev, sysfs and IR is now decoded and reported.
> >       */
> > 
> >      rc_unregister_device()
> >      /*
> >       * User space can no longer access /dev/lirc or the rc sysfs
> >       * attributes. They will get -ENODEV if they still have a file
> >       * descriptor open.
> >       * Calls to ir_raw_event_handle() etc or rc_keydown() are permitted
> >       * but they must stop before the call to rc_free_device(), so
> >       * this is the time to stop the hardware.
> >       */
> >      rc_free_device()
> > 
> > This means that during rc_register_device(), we can get calls to
> > ir_raw_event_{store,handle,overflow,store_with_filter}. Ensure this
> > is done race-free.
> > 
> > Fixes: a3572c34da8d ("V4L/DVB: ir-core: Add logic to decode IR protocols at the IR core")
> > Signed-off-by: Sean Young <sean@mess.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/media/rc/rc-ir-raw.c | 20 +-------------------
> >  drivers/media/rc/rc-main.c   | 19 +++++++++++--------
> >  2 files changed, 12 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
> > index b32f3cff9401..bebb45ffa971 100644
> > --- a/drivers/media/rc/rc-ir-raw.c
> > +++ b/drivers/media/rc/rc-ir-raw.c
> > @@ -71,9 +71,6 @@ static int ir_raw_event_thread(void *data)
> >   */
> >  int ir_raw_event_store(struct rc_dev *dev, struct ir_raw_event *ev)
> >  {
> > -	if (!dev->raw)
> > -		return -EINVAL;
> > -
> >  	dev_dbg(&dev->dev, "sample: (%05dus %s)\n",
> >  		ev->duration, TO_STR(ev->pulse));
> >  
> > @@ -102,9 +99,6 @@ int ir_raw_event_store_edge(struct rc_dev *dev, bool pulse)
> >  	ktime_t			now;
> >  	struct ir_raw_event	ev = {};
> >  
> > -	if (!dev->raw)
> > -		return -EINVAL;
> > -
> >  	now = ktime_get();
> >  	ev.duration = ktime_to_us(ktime_sub(now, dev->raw->last_event));
> >  	ev.pulse = !pulse;
> > @@ -129,9 +123,6 @@ int ir_raw_event_store_with_timeout(struct rc_dev *dev, struct ir_raw_event *ev)
> >  	ktime_t		now;
> >  	int		rc = 0;
> >  
> > -	if (!dev->raw)
> > -		return -EINVAL;
> > -
> >  	now = ktime_get();
> >  
> >  	spin_lock(&dev->raw->edge_spinlock);
> > @@ -166,9 +157,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_timeout);
> >   */
> >  int ir_raw_event_store_with_filter(struct rc_dev *dev, struct ir_raw_event *ev)
> >  {
> > -	if (!dev->raw)
> > -		return -EINVAL;
> > -
> >  	/* Ignore spaces in idle mode */
> >  	if (dev->idle && !ev->pulse)
> >  		return 0;
> > @@ -200,9 +188,6 @@ EXPORT_SYMBOL_GPL(ir_raw_event_store_with_filter);
> >   */
> >  void ir_raw_event_set_idle(struct rc_dev *dev, bool idle)
> >  {
> > -	if (!dev->raw)
> > -		return;
> > -
> >  	dev_dbg(&dev->dev, "%s idle mode\n", idle ? "enter" : "leave");
> >  
> >  	if (idle) {
> > @@ -226,7 +211,7 @@ EXPORT_SYMBOL_GPL(ir_raw_event_set_idle);
> >   */
> >  void ir_raw_event_handle(struct rc_dev *dev)
> >  {
> > -	if (!dev->raw || !dev->raw->thread)
> > +	if (!dev->raw->thread)
> >  		return;
> >  
> >  	wake_up_process(dev->raw->thread);
> > @@ -612,9 +597,6 @@ EXPORT_SYMBOL(ir_raw_encode_carrier);
> >   */
> >  int ir_raw_event_prepare(struct rc_dev *dev)
> >  {
> > -	if (!dev)
> > -		return -EINVAL;
> > -
> >  	dev->raw = kzalloc_obj(*dev->raw);
> >  	if (!dev->raw)
> >  		return -ENOMEM;
> > diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> > index dda3479ea3ad..d93e98189c1a 100644
> > --- a/drivers/media/rc/rc-main.c
> > +++ b/drivers/media/rc/rc-main.c
> > @@ -1701,14 +1701,24 @@ static const struct device_type rc_dev_type = {
> >  struct rc_dev *rc_allocate_device(enum rc_driver_type type)
> >  {
> >  	struct rc_dev *dev;
> > +	int ret;
> >  
> >  	dev = kzalloc_obj(*dev);
> >  	if (!dev)
> >  		return NULL;
> >  
> > +	if (type == RC_DRIVER_IR_RAW) {
> > +		ret = ir_raw_event_prepare(dev);
> > +		if (ret < 0) {
> > +			kfree(dev);
> > +			return NULL;
> > +		}
> > +	}
> > +
> >  	if (type != RC_DRIVER_IR_RAW_TX) {
> >  		dev->input_dev = input_allocate_device();
> >  		if (!dev->input_dev) {
> > +			ir_raw_event_free(dev);
> >  			kfree(dev);
> >  			return NULL;
> >  		}
> > @@ -1724,6 +1734,7 @@ struct rc_dev *rc_allocate_device(enum rc_driver_type type)
> >  		spin_lock_init(&dev->rc_map.lock);
> >  		spin_lock_init(&dev->keylock);
> >  	}
> > +
> >  	mutex_init(&dev->lock);
> >  
> >  	dev->dev.type = &rc_dev_type;
> > @@ -1917,12 +1928,6 @@ int rc_register_device(struct rc_dev *dev)
> >  		dev->sysfs_groups[attr++] = &rc_dev_wakeup_filter_attr_grp;
> >  	dev->sysfs_groups[attr++] = NULL;
> >  
> > -	if (dev->driver_type == RC_DRIVER_IR_RAW) {
> > -		rc = ir_raw_event_prepare(dev);
> > -		if (rc < 0)
> > -			goto out_minor;
> > -	}
> > -
> >  	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
> >  		rc = rc_prepare_rx_device(dev);
> >  		if (rc)
> 
> I don't see what the race condition is you are trying to solve. AFAICT the sysfs
> files aren't created until the device_add() function that is right after this line.
> 
> I'm probably missing something, but that would mean that the commit log needs to
> be improved.

You're right, the commit message is terrible. I've reworded it for v5.


Sean
