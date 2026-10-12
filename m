Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53C3D955C;
	Mon, 12 Oct 2026 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837762; cv=none; b=JLiKhw9amT/K5bHXdI0GgFlPQ16Jt7IC+PVIYgn9stWnz3Qb+kc1HdDLIOzgtIxVEQgq6v6x3yj93TCxOlOv9lnTZQGcrGFg8KgRk25uIrBbPVdNLNql06ocRbUfAw0Xs63949Wc0D9iICMoZXVbgcmtanznxi9wG0ZpCmqdQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837762; c=relaxed/simple;
	bh=T151PnLM20JA9oilHiiu6VZTXffmfYSckEjUlAEVRuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa/Al+6OFL36GIN1/k00GbpcfsIVm4+avDr6OCqwVvo7KT/zrCWmLWSuS1RDJ4Axb0zk1I9oOeRm4tdRPHicGekI+aZdbM+Aa7v+5DQSWTiYCL73cPr8vOOdiodgnfBnqH+EW58wtlnx/yJ34PcPUfcI3skrfdZq2dXYDXDyGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as2dsfy3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as2dsfy3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791837761; x=1823373761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T151PnLM20JA9oilHiiu6VZTXffmfYSckEjUlAEVRuE=;
  b=as2dsfy3WGiSC2BgomCDqR89/OmxJ1Paw18Dpxdxqa2fcmqZejhD955b
   2e1fs84IU9IFq2cTpDqyovqLA/QaJ4IxZH+xD3uZgnYyDsxlX2nkdk7XF
   haUVrfC7RUrke5RV11eDESrFm8GmlMq4hSjRuF8Q/t0erT0RlAUWNeyh7
   HkrlwULfHn8DRofHn92dAi7n/+EqCg5fQ4MbUVS06i1KaoxJNTjcHX9J6
   jYq3e/sR28QGveK/RA/yNM92Stx6YDtSsV6vEpjU0nduVLiSPnat0DHhb
   jngh/ZZ652x/TV2F0Iw2m/aT1Sp9ynh7q85yZ9Hr2H0SItEuoyNG0QY96
   Q==;
X-CSE-ConnectionGUID: 950tLytiTn63HCvsFALwCA==
X-CSE-MsgGUID: vDCupysVRTyky7gCLCYagQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="442682"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="442682"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:42:40 -0700
X-CSE-ConnectionGUID: RDfzDRRAQu2pi1ArV0BWzQ==
X-CSE-MsgGUID: tBtObo7lSruymUz/UC2Ggw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1078421"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:42:37 -0700
Date: Mon, 12 Oct 2026 23:42:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] gpiolib: wait for pending label frees before
 cleaning up desc_srcu
Message-ID: <as1GOweKHBq2HhpP@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
 <20261012-gpiolib-chip-removal-v1-1-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-gpiolib-chip-removal-v1-1-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 04:49:55PM +0300, Adrian Ambrozewicz wrote:
> desc_set_label() frees the old label with call_srcu() on gdev->desc_srcu.
> gpiodev_release() calls synchronize_srcu() and then cleanup_srcu_struct()
> on it, meaning to run the pending frees first, but synchronize_srcu()
> only waits for a grace period, not for callbacks queued before it to be
> invoked. Once the srcu_struct uses per-CPU callback lists, a label freed
> on one CPU, for instance by gpiochip_free_hogs() at the start of
> gpiochip_remove(), can still be waiting for its invocation timer there
> when synchronize_srcu() returns on another, and cleanup_srcu_struct()
> warns:
> 
>   WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
>   Call Trace:
>    <TASK>
>    gpiodev_release+0x20/0x60
>    device_release+0x3e/0x90
>    kobject_put+0x67/0xf0
>    release_nodes+0x3a/0x60
>    devres_release_all+0x8a/0xf0
>    device_unbind_cleanup+0x21/0xa0
>    device_release_driver_internal+0x1c6/0x210
>    bus_remove_device+0xea/0x180
>    device_del+0x152/0x460
>    platform_device_del+0x20/0x80
>    platform_device_unregister+0xd/0x30
>    gpio_sim_device_deactivate+0x26/0x80
>    gpio_sim_device_config_live_store+0x254/0x3e0
>    configfs_write_iter+0xc2/0x130
>    vfs_write+0x252/0x530
>    ksys_write+0x6c/0xe0
>    do_syscall_64+0x109/0x5d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f


Please, read Submitting Patches on the backtraces in the commit messages
and act accordingly.

> cleanup_srcu_struct() then flushes the callbacks itself, so the label is
> still freed, but the warning is what the comment above that check says
> srcu_barrier() is for. Use it.
> 
> A gpio-sim chip with one hogged line, set live and back in a loop, warns
> within 4 to 60 cycles in three runs on a 4-CPU guest booted with
> srcutree.convert_to_big=1; with this change, three runs of 1000 cycles
> pass. With the default srcutree parameters the srcu_struct only goes
> per-CPU under contention and the loop did not hit it in 3000 cycles; the
> warning was first seen that way, once, on a KCSAN arm64 guest unbinding
> a USB-attached GPIO controller whose firmware node hogs a line, and
> since then on real hardware with v7.3-rc5 arm64 KCSAN kernels, when
> unbinding a USB GPIO expander whose driver is not yet upstream, built
> both as an out-of-tree module and into the kernel.

-- 
With Best Regards,
Andy Shevchenko


