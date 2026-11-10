Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304690;
	b=kzM4Xs8aBaGl7hd/2gfzIoA/VndFqDzGUm0Hg9LZptHuXHRwfVa2+o4FWLsPfW49S4sW
	 FHVG1BD4IL9ivzDb3uNEwdUXP0SX1B2WGV49EFrNm9gYhKZx28Atqaotg+9XgfgP92rMa
	 3E8pGy+8b9PFJ70tcVzXn58yVaKSaus0yvzB9CdQALSbU7OaRrpjlqF3+49bE8Ha95RTs
	 AFapDwWHjO1LfnpUnbF3M9/63gDwsb4V6c8R8E8YJ1E6PdKntonr/7bwhPnK2NfGQvB7Y
	 o3ji6n33SXel2UPE1cGFcdlTZ42BMojzIleWjiDHjmuNWiqQISJMri8xBgg344aVbNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=am4pQajB8Z2M3cS9jEAMeZZXdvO0PJr5jLPCMgFK69Y=;
	b=wiI/zBJVLEExrVfuzAmY4hJ+gTwKkeMgDso9CF1I6DCpFr4pDVzQlHAZpjXdD8Cw+OiZ
	 qdbg7jL28uGfAsjT6RWFKp2uKje5CHFdB9vONIVCXq3htNuYUGcSJK8f02mIIyNghcFYH
	 voiLLB3QOQYOGVDLqIlE5krr7Q9FV+flVKg4wALy0ndr2SyeJrK2azvdZrHo8/jFrkYc0
	 UNQafoMGZnKGLhcniFO9m8/yD9ScamEhYaIDOb63IqeKu4uf8OLPdt9ESteWJkLETL305
	 jfJ06F8kIJ/R3YZs4aBIHJ0syeZIFdItsp9khXt/EoRSgDdhj2ytor1KjJVrgAnb0WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDhgQL9e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97211606A338;
	Tue, 10 Nov 2026 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDhgQL9e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E191F008A1;
	Tue, 10 Nov 2026 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794304690;
	bh=am4pQajB8Z2M3cS9jEAMeZZXdvO0PJr5jLPCMgFK69Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDhgQL9ebtVCtYRR1eU96n/fgDF2P4+ltARvs7MWChtguuYl9YQFaqG1QkM7MBL8G
	 up+qonOXN1VV2Bz5KViu6qknduCXyYKXVDGlR2GgrRj2xbWyY+nfKZOiKgVxHa98Il
	 0c6so/pF2O19vxh1iK4xvVTVIWgotuqh/lU6hv8AIdGOHd4skBXkO5XeL1ldmlUQHW
	 vVg8o8U0pXmdsmgV/tot5n0AUxUHWALHTn3+0Sf3k0tNJwF29y5RCVBMbhUENcgC2b
	 zZFc3iM5I+LMsWaiB6SkOBdzPwm5SYtkZ9IpZQjPGlM11P33CWaDcNtZeTZkBpFMmq
	 DxSlrM1Lh5dCQ==
Date: Tue, 10 Nov 2026 17:58:05 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Chad Aldreda <ca@modelmiser.com>
Cc: Dan Callaghan <dcallagh@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>,
	chrome-platform@lists.linux.dev, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH] platform/chrome: cros_hps_i2c: hold the client device
 for an open file
Message-ID: <avLqrXdv4DK40A2v@tzungbi-laptop>
References: <20261107185258.4115770-2-ca@modelmiser.com>
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
In-Reply-To: <20261107185258.4115770-2-ca@modelmiser.com>

On Sat, Nov 07, 2026 at 06:53:05PM +0000, Chad Aldreda wrote:
> hps_release() finds struct hps_drvdata through file->private_data and
> calls pm_runtime_put() on hps->client->dev. hps comes from
> devm_kzalloc(), so it is freed when the driver is unbound, and a later
> close() of a file opened before the unbind reads freed memory. If the
> client was removed with delete_device, the i2c_client may have been
> freed as well, and pm_runtime_put() runs on it. KASAN reports a
> slab-use-after-free in hps_release() and, after delete_device, further
> ones in the runtime PM code.
> 
> release() needs only the client device, so take a reference to it in
> open() and keep it in file->private_data, and leave hps alone in
> release(). hps is still valid in open(): misc_open() calls it with
> misc_mtx held, and hps_i2c_remove() calls misc_deregister(), which takes
> misc_mtx, before devres frees hps. Unless the driver has been bound
> again, runtime PM on the device is disabled by the time such a release()
> runs, so pm_runtime_put() drops the usage count and its idle request
> fails with -EACCES.
> 
> Fixes: 5f9952548d91 ("platform/chrome: add a driver for HPS")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> ---
> Found with the coccinelle script posted at
> https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com
> 
> Reproduced in QEMU 10.2.4 (q35, KASAN). The driver binds to a client
> created with new_device on the i801 SMBus adapter, with the "enable"
> GPIO supplied by gpio-mockup through a test-only lookup module. A
> process opens /dev/cros-hps, the client is unbound or deleted through
> sysfs, and the process then closes the file. Without this patch KASAN
> reports one use-after-free after an unbind and six after delete_device;
> with it there are none, and an unbind followed by a bind works. Not
> tested on HPS hardware. Unbinding or deleting the client needs root.
> 
> Unchanged by this patch: if the driver is bound again while a file
> opened before the unbind is still open, that file's pm_runtime_put()
> lands on the new instance's usage count, so the sensor stays powered
> until the old file is closed. The counts measured the same with and
> without the patch (2, then 1, then 0); before it, that put went through
> freed memory.
> 
> For stable: before v7.0, hps_release() ends in
> "return pm_runtime_put(dev);". There it should end:
> 
> 	pm_runtime_put(dev);
> 	put_device(dev);
> 
> 	return 0;
> 
> This is independent of the revocable work for cros_ec_chardev; it only
> stops release() from using the driver data.
> 
>  drivers/platform/chrome/cros_hps_i2c.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chrome/cros_hps_i2c.c
> index 3b9485627831..290b136ce4fa 100644
> --- a/drivers/platform/chrome/cros_hps_i2c.c
> +++ b/drivers/platform/chrome/cros_hps_i2c.c
> @@ -36,17 +36,26 @@ static int hps_open(struct inode *inode, struct file *file)
>  	struct hps_drvdata *hps = container_of(file->private_data,
>  					       struct hps_drvdata, misc_device);
>  	struct device *dev = &hps->client->dev;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
>  
> -	return pm_runtime_resume_and_get(dev);
> +	/*
> +	 * hps is freed when the driver is unbound, which can happen before
> +	 * release(), so release() uses only the device, held here.
> +	 */
> +	file->private_data = get_device(dev);
> +	return 0;
>  }
>  
>  static int hps_release(struct inode *inode, struct file *file)
>  {
> -	struct hps_drvdata *hps = container_of(file->private_data,
> -					       struct hps_drvdata, misc_device);
> -	struct device *dev = &hps->client->dev;
> +	struct device *dev = file->private_data;
>  
>  	pm_runtime_put(dev);
> +	put_device(dev);
>  
>  	return 0;
>  }

Thank you for looking into this and sharing the coccinelle script.

I don't think holding the reference of &hps->client->dev for the fops
lifecycle is the right direction:

1. Once the driver is unbound in hps_i2c_remove(), any still-open file
   descriptors from that binding should become non-functional.  Continuing
   holding the runtime PM reference just for preventing the UAF makes less
   sense.

2. As you noted under "---", it bleeds into the new instance's usage_count
   if the driver is bound again before the old file is closed.

3. Instead, hps_i2c_remove() should clean up any remaining runtime PM
   references before calling pm_runtime_disable(), and a late
   hps_release() on a file opened before unbind should simply be a
   no-op.

For an immediate fix, I'm wondering if we should use a similar pattern to
what you used (devm_kzalloc -> kzalloc + kref + removed flag) for the other
issues discovered by the coccinelle script:

struct hps_drvdata {
	...
	atomic_t open_count;
	struct kref kref;
	struct rw_semaphore rwsem;
	bool removed;
};

static int hps_open(struct inode *inode, struct file *file)
{
	...

	atomic_inc(&hps->open_count);
	kref_get(&hps->kref);
	...
}

static int hps_release(struct inode *inode, struct file *file)
{
	...

	scoped_guard(rwsem_read, &hps->rwsem) {
		if (!hps->removed) {
			pm_runtime_put(&hps->client->dev);
			atomic_dec(&hps->open_count);
		}
	}

	kref_put(&hps->kref, ...);
	...
}

static void hps_i2c_remove(struct i2c_client *client)
{
	...

	scoped_guard(rwsem_write, &hps->rwsem) {
		hps->removed = true;

		while (atomic_dec_if_positive(&hps->open_count) >= 0)
			pm_runtime_put_noidle(&client->dev);
	}

	kref_put(&hps->kref, ...);
	...
}

---
This is actually a good candidate for using the 'revocable'[1] (just like
the other drivers found by your coccinelle script where open files
outlive devm_kzalloc() driver data on unbind).

static int hps_open(struct inode *inode, struct file *file)
{
	...

	atomic_inc(&hps->open_count);
	revocable_get(hps->rev);
	file->private_data = hps->rev;
	...
}

static int hps_release(struct inode *inode, struct file *file)
{
	...
	struct revocable *rev = file->private_data;

	revocable_try_access_or_skip_scoped(rev, hps) {
		pm_runtime_put(&hps->client->dev);
		atomic_dec(&hps->open_count);
	}

	revocable_put(rev);
	...
}

static int hps_i2c_probe(struct i2c_client *client)
{
	...

	hps->rev = revocable_alloc(hps);
	...
}

static void hps_i2c_remove(struct i2c_client *client)
{
	...

	revocable_revoke(hps->rev);

	while (atomic_dec_if_positive(&hps->open_count) >= 0)
		pm_runtime_put_noidle(&client->dev);

	...
	revocable_put(hps->rev);
}

[1] https://lore.kernel.org/all/20261102161710.24076-1-tzungbi@kernel.org
