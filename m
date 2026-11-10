Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314090;
	b=Lu81XoedswpbI1Jj7rKrhCraETbvVF7wUY/nWxiy2wm0JWkARi1C1a6AV5dNpOzrRB2u
	 8NmvoECNprglfW8yEbaz6e6L8c0Ika+oyPWevHQ6SgcH0f0Ww5GvlXf50r0ln/KxEABvj
	 bFOS9jhHArtGJMXZ7SSI+ozMSR56Hm//iQHsddqVCxva7Hs+lY2I6UT/MYDC5g9aVMZoT
	 kDUWzYIvL+b709cEVgSWqeEWTJOrkgkWt/x89KqbsQLyzw0PhcxKS7JjKOM2npkjYuwsQ
	 8X/0sAc37hh1wXAQgOuDX3CziHmG+ac8SnBsliFU8TeQ9YM/VQi7B0rfXydz3ezNZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314090;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Dxe8EREGS3Fis9aSI+wN+QJVDWEJVvvd5EUwRIzwg/U=;
	b=c6OEfy/rBzAX15ngJmu2ZsgXP6pPwrzOjbjJpuhEJzev93ToTkV9rTOrRwoLG6xynUIj
	 ZXLq8oEFfQj4BQrJGnPkJndfkjJxlEdioOZ3romPK0I7hMaypZLDgZdOFDufIl98BTwqe
	 1k+/RYvHsf/1Y2VjkOfZqU4ylv2zdJu+yP3aondgp8dNLtpQy1tW5LJM4hEYCW3Xu6Nv/
	 Rgqlt7tnwB2Ag3cQs6LSFSwxFLK/9XzThB4w8E+A/VzC+qswS1KCgxYfKU7IJ15FzlLs7
	 DG7RCix03M4xEUFHMETheU0sfIVxNsWCSJN7xLSIC6UIChR2sUlIKmHfATbr8ocfeRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRzq31kD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD6606A31C;
	Tue, 10 Nov 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRzq31kD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7C1F0089F;
	Tue, 10 Nov 2026 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314090;
	bh=Dxe8EREGS3Fis9aSI+wN+QJVDWEJVvvd5EUwRIzwg/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mRzq31kDDVuetn8DuuVVPOGIP7t0S0PK1lNyDLxQiYxlfP1xdS2hP13zkQxJHc+ep
	 p7bZv+XKzg015GE+xFLz2AWd/ZDbX96gwHMHmcL5oq+SVypJHzKDmeBT7YJiE39IVy
	 s9oeCB3aOFg/uvJopxOnQtxLBjgpI9wmrPWWpBTFSm0PUBbsKGxpnOGZZZmns4POeT
	 g6FEiZJR617sc1nZBTp8aWXK6KerHUpSlpekjlQOJNgbo18qn7hVBjq50PTarCaqHb
	 0psVWj0SHz6uEYbkM2veeDCRRjht3ezu2lqjP5abrYZCfmL2wVglGqcgyGUdlUR5HS
	 XbjFbdykTl+5A==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQl3n-0000000Avfh-3F8j;
	Tue, 10 Nov 2026 13:34:47 +0100
Date: Tue, 10 Nov 2026 13:34:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] i2c: dev: fix blocked adapter deregistration
Message-ID: <avMPZ5gB_k1KjpEe@hovoldconsulting.com>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-2-johan@kernel.org>
 <xkcyszlk7ce6rdfsbfihlu4gyi52kgimeftruspl4tdingjc74@llcpfjzkwbis>
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
In-Reply-To: <xkcyszlk7ce6rdfsbfihlu4gyi52kgimeftruspl4tdingjc74@llcpfjzkwbis>

On Mon, Nov 09, 2026 at 04:08:46PM +0100, Bartosz Golaszewski wrote:
> On Thu, Aug 27, 2026 at 12:20:41PM +0200, Johan Hovold wrote:
> > The I2C subsystem allows controllers to be used by non-child devices
> > that may remain registered after an adapter goes away.
> > 
> > To handle this, adapter deregistration blocks until the last reference
> > to the adapter is released. Albeit unorthodox, this is mostly fine for
> > the vast majority of controllers but can cause some trouble when
> > controllers reside on hotpluggable buses.
> > 
> > Specifically, userspace can prevent an adapter from being deregistered
> > indefinitely by holding an i2c-dev character device file open. And with
> > USB attached controllers this prevents further hub events from being
> > processed by the parent hub until the file is closed.
> > 
> > Fix the i2c-dev implementation by dropping the additional reference
> > taken at open() and using an rwsem to make sure the adapter is only
> > accessed while registered.
> > 
> > Note that before commit 611e12ea0f12 ("i2c: core: manage i2c bus device
> > refcount in i2c_[get|put]_adapter") an adapter going away would instead
> > have resulted in a use-after-free.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---

> >  static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
> >  		loff_t *offset)
> >  {
> > +	struct i2c_dev_data *data = file->private_data;
> > +	struct i2c_client *client = &data->client;
> > +	struct i2c_dev *i2c_dev = data->i2c_dev;
> >  	char *tmp;
> >  	int ret;
> >  
> > -	struct i2c_client *client = file->private_data;
> > +	guard(rwsem_read)(&i2c_dev->rwsem);
> 
> I think sashiko is correct in its comment and you should limit the
> critical section to until right after i2c_master_recv(). Same elsewhere.

I don't think that's anything we need to care about. If a malicious
actor has physical access to the machine, we have bigger problems than
worrying about them going out of their way to cause a USB hub worker
thread to hang. :)

Johan

> [1] https://sashiko.dev/#/patchset/20260827102043.673273-1-johan%40kernel.org?part=1
