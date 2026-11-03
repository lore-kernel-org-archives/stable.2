Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667553;
	b=oh6howqN0Vs24jfehvOjEBfQhFtzqRs7mFQ1YJZpBTtrJ83Ng9xpmT7P2Bmj9nWPkxrP
	 551kjbZjnPM6F+mi3EAaI4CdBjsPVJfsbYzCamugCH70fg5DNY+/PNy93t1bRS0werXJZ
	 P3Am0wbE7sSHxutnNZDVHkQgZm5dPxrL4CkR5OAUw3rmlGRpW8fq9dJBRe5sqqHOYFzrv
	 pIGB1xIDnVIXjCMAOofjQLpCPAsquS2sen9WBSrJ4Lhvi/Ma+epkTyJSFqnNcS6B+5mmB
	 iGzXHp3XThVAYzspW7hCqsNYiWHPruPcGcktxLG6CrcX7fDdL6n7rZ0KT3gy2OetqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667553;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uLjBAWx+16VRE7Lx5wES4v4itCOupvMVhVHaz6C9qsE=;
	b=SEfC+H9869zXHKuywGCGjlPp/olz848JKN1XFYuOng5AN3H0ho9RLC4cBH6BBiOWNkVz
	 kMRok8k5YcF3w7eppfN3YpehOGyM0Qu1I3c7/C373KBlyyfBjlVOpDNaokW/ENezLqxKz
	 QTMBV1v7Wzd9nwk228f8M0jvUtlTl0ulDOB7xo8VUvIOOQ+0F/7DUqDHomeAkj90SBHYK
	 PuQxwkP8+5fdsHxTOGK6dppL2eFMTJ+TuWli3CiAtukzCaP9LHm8bLlY0JiSHKvtfgcPw
	 Cd/askEvjOxaC5QDSIXAxN1pBWXBEvA6HRUjf7+uU6JApSngWRaWQTHJErDjD0tpQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJQ5FkyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F12606A326;
	Tue,  3 Nov 2026 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJQ5FkyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328A21F000C1;
	Tue,  3 Nov 2026 00:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667552;
	bh=uLjBAWx+16VRE7Lx5wES4v4itCOupvMVhVHaz6C9qsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PJQ5FkyDa9v9hz1rerNo7CCldg/vHMYUMM+I8fRwy2Rwzk+9oD/mJpSxf05tDLiPM
	 Xtys0dzW+Jb+Ne/6tbZ3XTgjFT/bGNuQXx9uoAu1wwFRl/X4FHr0vUofXBlYPfgbXV
	 QC3LZhAGDwr7CZAOZxeFITZaH1wyRRKLoLQl4+QHd4109Ro1/QGOWsJlrcMiS1K0jZ
	 oDwIN3NnltSjiraUL39XJfyyfPu9iGOJenIHvsBekh2hDmsAIh8t05LDPj1ckQPm1s
	 BzvKG/+liXLpZJo0STRD+/iWz6DEeLaoB4gEt73tEzwYBJ++mPnu6rXx1owHA5L+rM
	 kCLaocupS48hQ==
Date: Mon, 2 Nov 2026 16:59:11 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/6] Drivers: hv: initialize partition table before
 device registration
Message-ID: <20261103005911.GC1862133@liuwe-devbox-debian-v2.local>
References: <20261028044828.96177-1-yaojiale02@163.com>
 <20261028044828.96177-4-yaojiale02@163.com>
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
In-Reply-To: <20261028044828.96177-4-yaojiale02@163.com>

On Wed, Oct 28, 2026 at 12:48:23PM +0800, Jiale Yao wrote:
> misc_register() exposes /dev/mshv before the partition hash table and
> its lock are initialized. A partition ioctl racing module initialization
> can therefore access the table through an uninitialized spinlock.
> 
> Initialize the partition table and lock before registering the misc
> device.
> 
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

If such races are really a problem, shouldn't the msic_register call be
the last in the function?

Wei

> ---
>  drivers/hv/mshv_root_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefd..ce26320035b6 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2369,6 +2369,9 @@ static int __init mshv_parent_partition_init(void)
>  	if (hv_get_hypervisor_version(&version_info))
>  		return -ENODEV;
>  
> +	spin_lock_init(&mshv_root.pt_ht_lock);
> +	hash_init(mshv_root.pt_htable);
> +
>  	ret = misc_register(&mshv_dev);
>  	if (ret)
>  		return ret;
> @@ -2407,9 +2410,6 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto exit_debugfs;
>  
> -	spin_lock_init(&mshv_root.pt_ht_lock);
> -	hash_init(mshv_root.pt_htable);
> -
>  	hv_setup_mshv_handler(mshv_isr);
>  
>  	return 0;
> -- 
> 2.34.1
> 
