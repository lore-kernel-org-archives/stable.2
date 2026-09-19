Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5613345725;
	Sat, 19 Sep 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837351; cv=none; b=i3kQlSwowmQ6k7OB9SoNpWC6bBIiHWoENL6l2HxaEJX6w8kSoWJT+gBFenMD1XuktmR2AN8xA0c7nRUtA6EhBITdpJIcNS3/cn2OnnDqn9Z3wdVMlu4/7VkpFgptnwBuH8ecplLlTNFJM+pd8j4Os8dOrKDHqnDkIWBOmexGzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837351; c=relaxed/simple;
	bh=6HWA56qzUjOeqCtbP5yo30HjgeAcGJiXUplwzbDJOUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am9FZGmEz3WZhIFcLTMOYoXgvI8yrat62gtukvV3lNdEptA+b++Rr4WNG/K0EbpsagAeWphDm5KKoOdBFif8nJd1JMIlKdgKFD7xykxM/zkbXRcKNtR1LPF/EiIKczcMhe3HB0kUYl9S1aMsp17VJrUNbijxrFWw+rMbwEES4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ArO+gSTT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ArO+gSTT"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83B4BC36;
	Sat, 19 Sep 2026 19:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789837230;
	bh=6HWA56qzUjOeqCtbP5yo30HjgeAcGJiXUplwzbDJOUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArO+gSTTvtOeApK7oZ5ILVD9tMduC5JnxBOEFpJfmkDwjqk4TzKoY2VDaxltHnlqZ
	 +5U5fG0iGyFQ+KZy+1u/oPsMoXzygvhIP8CGsxfA84gPjYOBvOcNPEFKIwk684ZRXt
	 m2SM5GafyFOyaAxx+S0Hy4J75ZWbbG1+7jXgmY24=
Date: Sat, 19 Sep 2026 20:02:12 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+74de6401dbdd377b5746@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: fix NULL deref in subdev_open()
 racing with unbind
Message-ID: <20260919170212.GE1124359@killaraus.ideasonboard.com>
References: <20260919162709.314464-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919162709.314464-1-ngocthang2710.1999@gmail.com>

On Sat, Sep 19, 2026 at 11:27:09PM +0700, Nguyen Ngoc Thang wrote:
> subdev_open() dereferences sd->v4l2_dev->mdev and then
> sd->entity.graph_obj.mdev->dev->driver->owner. v4l2_open() only checks
> that the node is still registered, while
> v4l2_device_unregister_subdev() clears sd->v4l2_dev and the entity's mdev
> before it unregisters the node. Opening a sub-device node while the
> driver is being unbound (e.g. vimc through sysfs) can therefore see a
> NULL entity mdev, or a NULL dev->driver once remove() has finished, and
> oops:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:subdev_open+0x193/0x510 drivers/media/v4l2-core/v4l2-subdev.c:115
>   Call Trace:
>    v4l2_open+0x1d2/0x490 drivers/media/v4l2-core/v4l2-dev.c:433
>    chrdev_open+0x234/0x6a0 fs/char_dev.c:411
> 
> Read the entity's mdev once and treat NULL as "no media device". Take
> the driver module reference under device_lock(), which is what unbind
> holds while it clears dev->driver, and fail with -ENODEV if the driver
> is already gone.
> 
> Reported-by: syzbot+74de6401dbdd377b5746@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=74de6401dbdd377b5746
> Fixes: 218bf10e39ed ("media: v4l2-subdev: handle module refcounting here")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Root cause
>   v4l2_open() checks video_is_registered() and then calls subdev_open().
>   v4l2_device_unregister_subdev() clears sd->v4l2_dev and the entity's
>   graph_obj.mdev *before* video_unregister_device() on the node, so an open
>   in that window sees a NULL mdev. After remove() returns, dev->driver is
>   also NULL. subdev_open() dereferences both unchecked (v4l2-subdev.c:115).
> 
> Fix
>   Snapshot entity mdev once (NULL == no media device), and take the driver
>   module reference under device_lock(dev), the lock unbind holds while it
>   clears dev->driver; return -ENODEV if the driver is gone. Errors go
>   through the existing "err" label.
> 
> Testing (QEMU x86_64, KASAN, vimc built in, syzbot's C reproducer:
> 16 threads opening /dev/v4l-subdevN vs. one thread doing vimc bind/unbind,
> vivid.n_devs=1 to avoid minor exhaustion at boot):
>   before: 32 x "RIP: subdev_open+0x193/0x510" GPF (same as syzbot report)
>   after : 0 oopses, 0 KASAN reports, reproducer runs to completion
>   (checked with 1 ms and 30 ms bind/unbind period)
> 
> Unrelated finding (not addressed here)
>   If the sub-device node registration in vimc_probe() fails (e.g.
>   "videodev: could not get a free minor"), the error path in
>   vimc_register_devices() frees the entities and then
>   v4l2_device_unregister() hits a slab-use-after-free. Easy to trigger
>   with the same reproducer if minors are exhausted. I'll look at it
>   separately.
> 
>  drivers/media/v4l2-core/v4l2-subdev.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index e9f81b9be9e2..cec63694a658 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -97,6 +97,7 @@ static int subdev_open(struct file *file)
>  	struct video_device *vdev = video_devdata(file);
>  	struct v4l2_subdev *sd = vdev_to_v4l2_subdev(vdev);
>  	struct v4l2_subdev_fh *subdev_fh;
> +	struct media_device *mdev;
>  	int ret;
>  
>  	subdev_fh = kzalloc_obj(*subdev_fh);
> @@ -112,15 +113,22 @@ static int subdev_open(struct file *file)
>  	v4l2_fh_init(&subdev_fh->vfh, vdev);
>  	v4l2_fh_add(&subdev_fh->vfh, file);
>  
> -	if (sd->v4l2_dev->mdev && sd->entity.graph_obj.mdev->dev) {
> -		struct module *owner;
> +	/* Unregistration clears the entity's mdev without waiting for open. */
> +	mdev = READ_ONCE(sd->entity.graph_obj.mdev);
> +	if (mdev && mdev->dev) {
> +		struct device *dev = mdev->dev;
>  
> -		owner = sd->entity.graph_obj.mdev->dev->driver->owner;
> -		if (!try_module_get(owner)) {
> +		/* Unbind clears dev->driver under the device lock. */
> +		device_lock(dev);
> +		if (!dev->driver)
> +			ret = -ENODEV;
> +		else if (!try_module_get(dev->driver->owner))
>  			ret = -EBUSY;
> +		else
> +			subdev_fh->owner = dev->driver->owner;
> +		device_unlock(dev);
> +		if (ret)
>  			goto err;
> -		}
> -		subdev_fh->owner = owner;
>  	}

This seems the kind of completely wrong fix that would be generated by
an LLM.

>  
>  	if (sd->internal_ops && sd->internal_ops->open) {

-- 
Regards,

Laurent Pinchart
