Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634994;
	b=Gpmwh/9z8XcjbYXgvK11tgPYnkdFS9QyUO2Ozg6C+5KrwMng7WoQcgu0AsbFvC1Omk+W
	 lHtTCbSfuvzqCKYbF4ZqfcxriiFWkfqDZKA+MnX5rPgBSqIXwKcPxbt41YHStKYGbpVgA
	 oqqx4bV2UDR6holMTBXclQmBaY5ycmHD9aRuJsWiawUKSdDVgE8bI4g0bKCsUy3/wNXz5
	 9lkoiaV6goc2ZtJYOzNddwRS8E5InCGH05EQ68FayZlccSmfgrDGm6Qpizmj1U9Zp6d/N
	 ZcIkK40LYASGDVnefqrKG4EQUhxm3VGP7oR2p58nnYBYE703lzpE5MCQGEnBjYqJbEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rIIz/gtfC2Y+ir/ymx8Qwz0qEnZD5kOfLUgExDZlSUE=;
	b=ZBFzFfuNNOOI2FzVWFTDHGxFFE1zph1aMhnHUqt67y7xUnVwBZXzPXr4rcda9L1KaAFU
	 PG5x2794AJ3qIV8FXl+SZKuoedRlcppc1ludNTDU0jpb0Y7QhV3e4HLgJtdyU531Fe+D0
	 Os+H6hsNg24MivYNkQCQdnyqFcqajNRQFXh4YYV0n9EuRtfjpdIpW2jRabjMljnNRrFch
	 h/CLXg6SuM88Tfk5fU7EXbphOgnJi+tzrX/HNPXeLYQ7NVWQTQzNLTRZ4Dd4Z9GG6bBBz
	 A7wmZqvt9EHRWEZH/CGnc24C5uCKxb0CNiapsRbjp/0OA3LwPR3LV4Qt9CkDyxG8Xsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X0TlLx/+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA66606EE90;
	Mon,  2 Nov 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0TlLx/+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3842E1F00A16;
	Mon,  2 Nov 2026 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634994;
	bh=rIIz/gtfC2Y+ir/ymx8Qwz0qEnZD5kOfLUgExDZlSUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X0TlLx/+2BqpUJ0O7uF4HJlMVjvUqcctCY4wJh2DmEYtVPJMg/9bWsnMuFoxFMO7/
	 MHHvPM999easQh4jTVkg75DMRhcS29B06kRPVVmHKc75emzSi00DGtxtv/DxIyQ4yg
	 w9PQDEyAO1LRnGyVBgqgsSIafZzzptaLT4MEa/zEFBFuAXD/5ot8yT8pfKc6e1GYYD
	 AF7yXXmK9NChbzEO1Fv/Tzj0lvMDW+wZbc2tvAum4QhbDU/pVrCQL36pdKP+WiC5eQ
	 SxSj10W/ACEPziCQVHNxjY+RYeC4lNHQrtSIvBcliS/BFJ09TguCFozEEGSZ78+nna
	 JjEmR9ugF0lQQ==
Date: Mon, 2 Nov 2026 16:56:28 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 04/10] irqchip/gic-v5: Serialise ITS invalidation commands
Message-ID: <auiyrFXjX0hGgd7D@red-moon>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
 <20261102-host_gicv5_fixes-v1-4-743b61626fc5@arm.com>
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
In-Reply-To: <20261102-host_gicv5_fixes-v1-4-743b61626fc5@arm.com>

On Mon, Nov 02, 2026 at 01:32:57PM +0000, Sascha Bischoff wrote:
> The ITS uses DIDR and EIDR to select the translation to invalidate.
> These registers are shared by all interrupts targeting the ITS. Event
> invalidation can run concurrently for different IRQs, and device
> invalidation can overlap it. The per-IRQ descriptor lock does not
> serialise the commands, so one CPU can accidentally issue an
> invalidation using another CPU's DeviceID or EventID.

"Another CPU's DeviceID or EventID " can probably be explained better
(or just removed because it is unclear) I understand there is a link to
Sashiko's report but it is worth updating the log IMO.

"using the DeviceID or EventID associated with an IRQ that is invalidated
on another CPU" or something like that.

> Add a raw spinlock to each ITS and hold it across the command register
> writes and the STATUSR.IDLE poll for both invalidation paths. A raw
> spinlock is required because the forwarding path calls the event

Can you please define "the forwarding path" more explicitly ?  See above.

Thanks,
Lorenzo

> invalidation helper with the IRQ descriptor lock held.
> 
> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11
> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  drivers/irqchip/irq-gic-v5-its.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> index 28e39b065de0e..6d98f3dbe34b6 100644
> --- a/drivers/irqchip/irq-gic-v5-its.c
> +++ b/drivers/irqchip/irq-gic-v5-its.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic-v5.h>
> @@ -28,6 +29,8 @@
>  struct gicv5_its_chip_data {
>  	struct	xarray			its_devices;
>  	struct	mutex			dev_alloc_lock;
> +	/* Event and device invalidation commands share DIDR. */
> +	raw_spinlock_t			inv_lock;
>  	struct	fwnode_handle		*fwnode;
>  	struct gicv5_its_devtab_cfg	devtab_cfgr;
>  	void	__iomem			*its_base;
> @@ -129,6 +132,8 @@ static int gicv5_its_itt_cache_inv(struct gicv5_its_chip_data *its, u32 device_i
>  	eidr = FIELD_PREP(GICV5_ITS_EIDR_EVENTID, event_id);
>  	eventr = FIELD_PREP(GICV5_ITS_INV_EVENTR_I, 0x1);
>  
> +	guard(raw_spinlock_irqsave)(&its->inv_lock);
> +
>  	its_writeq_relaxed(its, didr, GICV5_ITS_DIDR);
>  	its_writel_relaxed(its, eidr, GICV5_ITS_EIDR);
>  	its_writel_relaxed(its, eventr, GICV5_ITS_INV_EVENTR);
> @@ -371,6 +376,9 @@ static int gicv5_its_device_cache_inv(struct gicv5_its_chip_data *its,
>  		  FIELD_PREP(GICV5_ITS_INV_DEVICER_EVENTID_BITS,
>  			     its_dev->itt_cfg.event_id_bits)	|
>  		  FIELD_PREP(GICV5_ITS_INV_DEVICER_L1, 0x0);
> +
> +	guard(raw_spinlock_irqsave)(&its->inv_lock);
> +
>  	its_writeq_relaxed(its, didr, GICV5_ITS_DIDR);
>  	its_writel_relaxed(its, devicer, GICV5_ITS_INV_DEVICER);
>  
> @@ -1112,6 +1120,7 @@ static int __init gicv5_its_init_bases(void __iomem *its_base, struct fwnode_han
>  		return -ENOMEM;
>  
>  	mutex_init(&its_node->dev_alloc_lock);
> +	raw_spin_lock_init(&its_node->inv_lock);
>  	xa_init(&its_node->its_devices);
>  	its_node->fwnode = handle;
>  	its_node->its_base = its_base;
> 
> -- 
> 2.34.1
> 
