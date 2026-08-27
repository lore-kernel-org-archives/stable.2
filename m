Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FC427F91;
	Thu, 27 Aug 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823822; cv=none; b=RG8eGn9w7rslFgvbbtAbCUUki5vqsrd7RWnSoqorUnyOdM8jpWgs4OtXS0iJRlcOi+LTwabW4bki5AcxCyqhvWE7xr87e63ee8OOupQ+0wABhpHLgQeVKxZVOc3S6sA+tIYOo6faUDtyXsC8EOMj3dRZPdwQvAQhENgSptBJBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823822; c=relaxed/simple;
	bh=Kml3UFpqKmuyNf6MPWVigrUiYTDyfoerBU7UcsXJHck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiTInyXVJvDuWXEVKfKaGoWVK83iHB98NFNZvW1njBTi6OW7qeoc35cvQj5xPnflpCrdPLyZBX1+28oaBrYTwZDaiAX/HqnHc8r7DR/0L6PgMjxz3cYKR8Vd1AaxwsRVKbQQzqQpNTjoe3Z9stydErLQnyxm1hTA5woparlZ4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpGWjk39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpGWjk39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA2B1F000E9;
	Thu, 27 Aug 2026 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787823817;
	bh=Y4cZ0UoCXxH9qXg2RynlUOzzxRFmakF4LP9Cl47C+ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpGWjk39akJN778WuJcEBg1B5/32So6V0zQonbpf5DoI+Q4CWlAJJNNIh3pfjv8md
	 u91T8xEgnqA6GLetH4c/IDHs2exbv4ofeoBiCnY97zOljqsJYym6b4a8o+87X4x1G3
	 rrFBWwA+hsMUnIt3jPcU4puz0Dan2h997V21PNLqzvxlROPPyBbRG4Th5vdsBanIkR
	 8UmZrfuCz5sNHFQ3KdvINnlMxEQpAkmcFbAFa10BZFILKRq8JsRbOZgzKWg4fM8pyA
	 V6zlmMojIYiNFCHItBvQCi9VZk9Zww7EocOGrPD6XrtS/0Oq++89LPJ+kSX6LQlmca
	 lF90qjvqR15nw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzWdy-00000002iAA-30xi;
	Thu, 27 Aug 2026 11:43:34 +0200
Date: Thu, 27 Aug 2026 11:43:34 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] i2c: dev: fix blocked adapter deregistration
Message-ID: <apAGxmeDmdTTYgCQ@hovoldconsulting.com>
References: <20260827090804.638565-1-johan@kernel.org>
 <20260827090804.638565-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827090804.638565-2-johan@kernel.org>

On Thu, Aug 27, 2026 at 11:08:02AM +0200, Johan Hovold wrote:
> The i2c subsystem allows controllers to be used by non-child devices
> that may remain registered after an adapter goes away.
> 
> To handle this, adapter deregistration blocks until the last reference
> to the adapter is released. Albeit unorthodox, this is mostly fine for
> the vast majority of controllers but can cause some trouble when
> controllers reside on hotpluggable buses.
> 
> Specifically, userspace can prevent an adapter from being deregistered
> indefinitely by holding an i2c-dev character device file open. And with
> USB attached controllers this prevents further hub events from being
> processed by the parent hub until the file is closed.
> 
> Fix the i2c-dev implementation by dropping the additional reference
> taken at open() and using an rwsem to make sure the adapter is only
> accessed while registered.
> 
> Note that before commit 611e12ea0f12 ("i2c: core: manage i2c bus device
> refcount in i2c_[get|put]_adapter") an adapter going away would instead
> have resulted in a use-after-free.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
 
>  static int i2cdev_open(struct inode *inode, struct file *file)
>  {
> -	unsigned int minor = iminor(inode);
> +	struct i2c_dev *i2c_dev = container_of(inode->i_cdev, struct i2c_dev, cdev);
> +	struct i2c_adapter *adap = i2c_dev->adap;

Bah, I of course need to take the rwsem here as well as pointed out by
Sashiko.

Let me respin.

Johan 
