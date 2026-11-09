Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236930;
	b=WYcjl0hvRuXdvzdBZbSWQ/WEf+2VVLoMcRKyyipy48uThkrTXWDFFye54jMKof5YnhKc
	 Zc7XdaniA2XWrF3XSj+tUVNoCQpM79nyslzV6ClfYvR5JSzE7MZkXZBQVfdRHsgQi3L2U
	 WDnb2HejFouijUyrcWxesEI+kTli6Nykdqkj5NizdI7p7afJyVLWULNGxXm6cKPsieG3U
	 UeUbGAANPBBF3Aj20ikr5mqcDxPRYB+mGA32WEVB6KiFhcbPJLEV5XS2ApF0DpzDl7Vi7
	 lE5G2zS/BbLYiC0j20X1NKw98rEH7REj4K0P5v1eWYFnzMfksinTkxzXwQSsu3bRgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236930;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R8sE85I3kWcWg2MaBpVdjh2qMLTFtvwwxKtfpDZvQOg=;
	b=2opDY4V8ZKNZ7fMZ9SCokZy1TsvP8p2ik6gaOsNuAzyppYzVbo9PmhMbCz3xeG5Fnr1a
	 2EWR6LqUMpRH/h2jzkGG7vZ/+St2uomxvC+pxirH69vxuCDyNmKlmImAO5CJ5Jzen3bhj
	 xKXeZxFSVBylhXIi6LlHAsOtEwvMCMDXIpEULLYyoy/ZF0nLTbTcn/hJ20Ypg7y5C+DXT
	 THBoFGW3aq+I+Sd+lFlSk+Gzafxo0NA723+yUtuijT4IZl1WMjfDO27vk61AUACgN7j3I
	 qhOjrIjeAyE5lleFLG56Oy4NSOzk5V6roaZhdqaw2/6bcxroed86OkvO67vFo7wd1YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efl5Gv0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 78798606A330;
	Mon,  9 Nov 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efl5Gv0m
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3AFB91F0089F;
	Mon,  9 Nov 2026 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236930;
	bh=R8sE85I3kWcWg2MaBpVdjh2qMLTFtvwwxKtfpDZvQOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efl5Gv0mbFPPoLSWZXOLQhJPsvU69QnI6l3Mqzrvfunc4KegKUjmmbKH8l47VI1tj
	 suwx62bm3cdUxkC/m48qAmxaHeWlp03v2wqAuqNJcpHSrhUgf0tWvFftK79TnsX+pH
	 9QvW1X5Jh8sg017fyv4S+qWvraiH2SDAsOaBAHayTZ0lbCQu7VbOzfjGzxcPKLMs87
	 G8FmsUK1cHwoDMTXprKXl1bAVy3LO+6lhBQZkAYwVSswFylTfo2yK7L2u7Xxl3aR9h
	 xdq359cLbTFQZfGv2RbUwWRNraakkx2SqrCI4VzT1mwZgtrHm93eO8qVpVR7dKvvw9
	 0yWM4ICPJoV5Q==
Date: Mon, 9 Nov 2026 16:08:46 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] i2c: dev: fix blocked adapter deregistration
Message-ID: <xkcyszlk7ce6rdfsbfihlu4gyi52kgimeftruspl4tdingjc74@llcpfjzkwbis>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-2-johan@kernel.org>
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
In-Reply-To: <20260827102043.673273-2-johan@kernel.org>

On Thu, Aug 27, 2026 at 12:20:41PM +0200, Johan Hovold wrote:
> The I2C subsystem allows controllers to be used by non-child devices
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
> ---
>  drivers/i2c/i2c-dev.c | 95 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index ccaac5e29f90..0940070c0317 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -28,6 +28,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> +#include <linux/rwsem.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  
> @@ -41,11 +42,17 @@
>   */
>  struct i2c_dev {
>  	struct list_head list;
> +	struct rw_semaphore rwsem;
>  	struct i2c_adapter *adap;
>  	struct device dev;
>  	struct cdev cdev;
>  };
>  
> +struct i2c_dev_data {
> +	struct i2c_dev *i2c_dev;
> +	struct i2c_client client;
> +};
> +
>  #define I2C_MINORS	(MINORMASK + 1)
>  static LIST_HEAD(i2c_dev_list);
>  static DEFINE_SPINLOCK(i2c_dev_list_lock);
> @@ -92,6 +99,11 @@ static void put_i2c_dev(struct i2c_dev *i2c_dev, bool del_cdev)
>  	spin_unlock(&i2c_dev_list_lock);
>  	if (del_cdev)
>  		cdev_device_del(&i2c_dev->cdev, &i2c_dev->dev);
> +
> +	scoped_guard(rwsem_write, &i2c_dev->rwsem) {
> +		i2c_dev->adap = NULL;
> +	}
> +
>  	put_device(&i2c_dev->dev);
>  }
>  
> @@ -134,10 +146,16 @@ ATTRIBUTE_GROUPS(i2c);
>  static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
>  		loff_t *offset)
>  {
> +	struct i2c_dev_data *data = file->private_data;
> +	struct i2c_client *client = &data->client;
> +	struct i2c_dev *i2c_dev = data->i2c_dev;
>  	char *tmp;
>  	int ret;
>  
> -	struct i2c_client *client = file->private_data;
> +	guard(rwsem_read)(&i2c_dev->rwsem);

I think sashiko is correct in its comment and you should limit the
critical section to until right after i2c_master_recv(). Same elsewhere.

Looks good otherwise.

Thanks,
Bartosz

[1] https://sashiko.dev/#/patchset/20260827102043.673273-1-johan%40kernel.org?part=1
