Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182079;
	b=k6f99PHiVLmyEpBdBD6aeoGCcLfFDump+ZApNjseUReYGGxwgy2AXbk5IScIDlnb1dej
	 vRz7pJKy14G+kJMDOu+noh8zJeuMOU2hbXyduZCXTv26i0ww4hU0rtuB8kwzbTYIjA4Z7
	 bWi3ijeGUs+QEvv/uPiVOIwhDj0272S5G+zf6dnoYvK1cps8jl3Y5YlQ2Slsnlg1nBPEL
	 mtUe7lYBp3mPxn86cV4JYAFLO+Zwzm7C5XGNN1qSTMe1/Btj56YPXaP7OcQG1192C+7aY
	 FG7X3nCzsVj0x6ugid/1WSJ1pZ2rvxbBg76goGp7oeajeMejsLY2HjyNCmYawHCgFDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182079;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=vOOgddBWgltKFEmeGuD8UwtxaWxBDKmqI4RdR8D48Jo=;
	b=DR+zbZCwuYQSfDpMBiDAuBZjs3zK9Tihl2eCJzdkDPRK907PYC3jmlDGmk/+QR8mlfME
	 wRefmD0A0Sms3VXbkCiUv5I5qRs+8Jj7u2qtmb/vmv4CCc4zwuH0J3R46lCk9BvJsbkdq
	 8/EY0mYGr3JuHILOyyh4Nts6AaTttDgqrP1inJwiY8Vg39il911EKPE3f06Dkb0WrHkHE
	 oEohgqyO/XK3u6Y6hg0JWLYYfMerusf3CLDT5m0fR19fzu+6B1AFeWIsn4oQ8QVMtiIm7
	 c3z/bv6socvUIYlYcQGs1upAMvE/XvPSXRZ/f1xGwtjrdPtYkmhiaXZiFTyPSHPLW/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVy5jNMT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37778606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVy5jNMT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851351F01828
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182078;
	bh=vOOgddBWgltKFEmeGuD8UwtxaWxBDKmqI4RdR8D48Jo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=jVy5jNMTsp4i1xckHmwHAtIJ6l2tKQ6zUB4IUAmMYXu44Ck9p1GerclTY7r6HA95S
	 KTI4BuYW4f0/chOjUZfJ/L4hlbzT+JJg9SL/TRyurzJHrw5c4gcqw4A1D0LZxJwbZ/
	 Jcvg4Ap51XhCuqjcTp5IpmIEkQ6XkQYaj/ELCaidZYn8ry65nPZ2S9Zm0mwI5haLhi
	 HQLWYxARpGuGbx/9s2PDEqg22xUBzkhb/474o30jqBIbBK7ZOt9lyfHcI69+45kWn/
	 OK2dlvMTngfYNR2bh+F39RZwu2mgbomreB8Ksp1Aen/RYAjvpHT80uIhBCI40fhza3
	 VHOlEwGjb6lDg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ab4891fc73so6931871fa.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 03:07:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBylrGudtFt4aueLyygheosUKKmTeW73WsG/tz9Zzrh3isBOFXo14kKYjenxi6cHry7bb1sZU1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2SVK3Gc6xnASnPs5GDdGoTtrw/loK9zvI0bSZqE/PbAunTDY/
	w5TVlyYVtz0zYNydNlS1Ur1MiEIWeMGn59AKBJwo1JndQxD6criB81R3z2643FyULwlggOt7BVF
	8YzWLG9rXjJKnvTeXdh6JDHoMTNF9jUCRfooG+/8YHg==
X-Received: by 2002:a05:651c:4216:b0:3ab:690f:829f with SMTP id
 38308e7fff4ca-3ac9cf5b6d2mr3564271fa.15.1793182077221; Wed, 28 Oct 2026
 03:07:57 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:07:55 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:07:55 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261027085653.90471-1-yuz08559@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026060049.60599-1-yuz08559@gmail.com> <20261027085653.90471-1-yuz08559@gmail.com>
Date: Wed, 28 Oct 2026 03:07:55 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfuDQ9=bPYsxeEiRaLzC0Q+hVxjTov_JEGv_hsARM3U7g@mail.gmail.com>
X-Gm-Features: AclHuK_34tj_8ja9sL23kXDung94CrH0bwmSQ7FTRkNiuVSOb5YqzvW_MXrNI5E
Message-ID: <CAMRc=MfuDQ9=bPYsxeEiRaLzC0Q+hVxjTov_JEGv_hsARM3U7g@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: sim: fix the configfs lockup racing with mkdir/rmdir
To: Yu Zhang <yuz08559@gmail.com>
Cc: Koichiro Den <koichiro.den@canonical.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct 2026 09:56:53 +0100, Yu Zhang <yuz08559@gmail.com> said:
> gpio_sim_device_lockup_configfs() depends (on activation) and undepends
> (on deactivation) the leaf configfs entries of a device. It walks
> dev->bank_list and bank->line_list without dev->lock, while the lists
> are modified and their nodes freed under dev->lock by the configfs
> make/release callbacks. It also walks the lists twice, once to depend
> and once to undepend, and the two walks can see different entries:
>
>  - A hog created while the device is live is never depended on, but
>    it is undepended on deactivation, hitting
>    BUG_ON(sd->s_dependent_count < 1) in configfs_undepend_item().
>    The following is enough to trigger it:
>
> 	mkdir $G/dev $G/dev/bank0 $G/dev/bank0/line0
> 	echo 1 > $G/dev/live
> 	mkdir $G/dev/bank0/line0/hog
> 	echo 0 > $G/dev/live
>
>  - An entry that is being created or removed when the device goes live
>    cannot be depended on (the WARN_ON() fires), but it is undepended
>    later, hitting the same BUG_ON(). If it has already been unlinked,
>    configfs_depend_item_unlocked() dereferences its NULL ci_group.
>
> Toggling "live" while concurrently creating and removing line and hog
> directories hits the WARN_ON() and then the BUG_ON() within a second.
>
> Hold the configfs subsystem mutex and dev->lock across the whole live
> transition. The subsystem mutex is what configfs holds when it links
> and unlinks entries and when it calls the make_group()/make_item()
> callbacks, which then take dev->lock, so the lock order is the same.
> Record the entries that were actually depended on and undepend exactly
> those. If an entry cannot be depended on because it is being created
> or removed, undo the dependencies already taken and fail with -EBUSY
> instead of warning.
>
> configfs_depend_item_unlocked() and configfs_undepend_item_unlocked()
> only take configfs_dirent_lock for an item of the caller's own
> subsystem, so calling them under these locks is fine.
>
> Fixes: 8bd76b3d3f3a ("gpio: sim: lock up configfs that an instantiated device depends on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---

Is this in any way linked to your other patch[1] for gpio-sim? If so, and if
this one is in response to sashiko reviews, please indicate it by keeping the
series versioning, even if you changed the approach, otherwise, I can't know
if the other one should be dropped or not?

>  drivers/gpio/gpio-sim.c | 109 +++++++++++++++++++++++++++++++---------
>  1 file changed, 85 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 0c73bec..ad4affc 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -560,6 +560,10 @@ struct gpio_sim_device {
>  	struct mutex lock;
>
>  	struct list_head bank_list;
> +
> +	/* Leaf entries depended on while the device is live. */
> +	struct config_item **deps;
> +	unsigned int num_deps;
>  };
>
>  static struct gpio_sim_device *to_gpio_sim_device(struct config_item *item)
> @@ -974,31 +978,81 @@ static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
>  	gpio_sim_remove_swnode_recursive(swnode);
>  }
>
> -static void
> -gpio_sim_device_lockup_configfs(struct gpio_sim_device *dev, bool lock)
> +static void gpio_sim_device_unlock_configfs(struct gpio_sim_device *dev)
> +{
> +	unsigned int i;
> +
> +	lockdep_assert_held(&dev->lock);
> +
> +	for (i = 0; i < dev->num_deps; i++)
> +		configfs_undepend_item_unlocked(dev->deps[i]);
> +
> +	kfree(dev->deps);
> +	dev->deps = NULL;
> +	dev->num_deps = 0;
> +}
> +
> +static int gpio_sim_device_lockup_configfs(struct gpio_sim_device *dev)
>  {
>  	struct configfs_subsystem *subsys = dev->group.cg_subsys;
>  	struct gpio_sim_bank *bank;
>  	struct gpio_sim_line *line;
>  	struct config_item *item;
> +	unsigned int num = 0;
> +	int ret;
> +
> +	lockdep_assert_held(&subsys->su_mutex);
> +	lockdep_assert_held(&dev->lock);
>
>  	/*
>  	 * The device only needs to depend on leaf entries. This is
>  	 * sufficient to lock up all the configfs entries that the
>  	 * instantiated, alive device depends on.
> +	 *
> +	 * dev->lock keeps the bank and line lists stable and the subsystem
> +	 * mutex keeps the entries' ci_group stable. An entry that is still
> +	 * being created or removed cannot be depended on, in which case the
> +	 * device is not brought up. The entries that were actually depended
> +	 * on are recorded, so that exactly those are undepended when the
> +	 * device goes down.
>  	 */
> +	list_for_each_entry(bank, &dev->bank_list, siblings)
> +		list_for_each_entry(line, &bank->line_list, siblings)
> +			num++;

Maybe:
		num += list_count_nodes(&bank->line_list)

> +
> +	if (!num)
> +		return 0;
> +
> +	dev->deps = kzalloc_objs(*dev->deps, num);
> +	if (!dev->deps)
> +		return -ENOMEM;
> +
>  	list_for_each_entry(bank, &dev->bank_list, siblings) {
>  		list_for_each_entry(line, &bank->line_list, siblings) {
>  			item = line->hog ? &line->hog->item
>  					 : &line->group.cg_item;
>
> -			if (lock)
> -				WARN_ON(configfs_depend_item_unlocked(subsys,
> -								      item));
> -			else
> -				configfs_undepend_item_unlocked(item);
> +			/* Already unlinked by a concurrent rmdir(). */
> +			if (!item->ci_group) {
> +				ret = -EBUSY;
> +				goto err_unlock;
> +			}
> +
> +			ret = configfs_depend_item_unlocked(subsys, item);
> +			if (ret) {
> +				ret = -EBUSY;
> +				goto err_unlock;
> +			}
> +
> +			dev->deps[dev->num_deps++] = item;
>  		}
>  	}
> +
> +	return 0;
> +
> +err_unlock:
> +	gpio_sim_device_unlock_configfs(dev);
> +	return ret;
>  }
>
>  static ssize_t
> @@ -1013,26 +1067,32 @@ gpio_sim_device_config_live_store(struct config_item *item,
>  	if (ret)
>  		return ret;
>
> -	if (live)
> -		gpio_sim_device_lockup_configfs(dev, true);
> -
> -	scoped_guard(mutex, &dev->lock) {
> -		if (live == gpio_sim_device_is_live(dev))
> -			ret = -EPERM;
> -		else if (live)
> -			ret = gpio_sim_device_activate(dev);
> -		else
> -			gpio_sim_device_deactivate(dev);
> -	}
> -
>  	/*
> -	 * Undepend is required only if device disablement (live == 0)
> -	 * succeeds or if device enablement (live == 1) fails.
> +	 * Lock order: subsystem mutex, then dev->lock. This is the same
> +	 * order as in the make_group()/make_item() callbacks.
>  	 */
> -	if (live == !!ret)
> -		gpio_sim_device_lockup_configfs(dev, false);
> +	guard(mutex)(&dev->group.cg_subsys->su_mutex);
> +	guard(mutex)(&dev->lock);
> +
> +	if (live == gpio_sim_device_is_live(dev))
> +		return -EPERM;
> +
> +	if (live) {
> +		ret = gpio_sim_device_lockup_configfs(dev);
> +		if (ret)
> +			return ret;
>
> -	return ret ?: count;
> +		ret = gpio_sim_device_activate(dev);
> +		if (ret) {
> +			gpio_sim_device_unlock_configfs(dev);
> +			return ret;
> +		}
> +	} else {
> +		gpio_sim_device_deactivate(dev);
> +		gpio_sim_device_unlock_configfs(dev);
> +	}
> +
> +	return count;
>  }
>
>  CONFIGFS_ATTR(gpio_sim_device_config_, live);
> @@ -1546,6 +1606,7 @@ static void gpio_sim_device_config_group_release(struct config_item *item)
>
>  	mutex_destroy(&dev->lock);
>  	ida_free(&gpio_sim_ida, dev->id);
> +	kfree(dev->deps);
>  	kfree(dev);
>  }
>
> --
> 2.43.0
>
>

I'd prefer to avoid the allocation for deps but I don't have a better idea
because struct gpio_sim_line and struct gpio_sim_hog which are the ones that
can be leaves are quite different so I don't know how to generalize them.

Let's keep it for now.

Bart

[1] https://lore.kernel.org/all/20261026060049.60599-1-yuz08559@gmail.com/
