Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867498;
	b=201KZtdmFRoIRzls82ij/VzCB08WHKEaK+Z/0TZIH3DQGSwf0Q5ddJbtX6Uumz6eGu3g
	 fUSZxAZnLReoh18xM7XMoZMM6F3iEEKO0j9Uq61ZJBklaMM+H+xzN1NIxMl61J6rg7CdY
	 p3yKQENB+ZoSp03l/Ops5goaUL6UhbzL9AGsFDRMTRMWCKZ5Qt4n6EQspA3NoUXi0g410
	 pyTmZFdkDTl8KodX0ynrtKKKVGb2PxreyU2/gyOHTvt6ZFCIFr6gaWt+I4e2gH/bppbBT
	 F0uK+x+yGos5USF1Jt3KMScqKGrFPlfz60e/hLMEIECb7N/t78F/uyO3rH5JCa0MX0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867498;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VTYeLaYKKNnR4GNV/TaYDsoMFc7kD+xhaqkactUd/3g=;
	b=FBzJ6jhoC3eIKfprOwGRbiRJNbMurFMFAzsW0tFIElqoMyZXxmlAMP+V6Ni1phBj1dbJ
	 8EdMvtwtoOB8cQFeI3FvJLP5QXkIxV3Jkxg+nN5VaPY5hKzSKK6mfYSzJgIEII2ByoUqi
	 RBT5JluGDyGPUWwT3g9qosgIUuDQWgevo/ikKmb6JK5F63IXdprIjxoCJFsIQHsuMqVW0
	 PpXe+ow/K+ePKJlMNxnCOc2xXYOszCVlcoXrgyLkEYEbNND6jsa9nfv+s+Y40nTXIh3e0
	 OQf0dt7KXjptw2g9/xqF3fDMaRP/A0X5+2RnT7UyarospzEVYeER3iSi6Z2kHVqbI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdpAjSX1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70553606A31B;
	Thu,  5 Nov 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdpAjSX1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB8D1F000C1;
	Thu,  5 Nov 2026 08:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867498;
	bh=VTYeLaYKKNnR4GNV/TaYDsoMFc7kD+xhaqkactUd/3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UdpAjSX1Ro0Jx1+rM9vTzFKPs+jUr4o3qyZkDKLIoulXlVpD2YPlJvVvDOWjHASuj
	 +yLcDwbbQPABVdze7sA2RY2GN+t3teeLFEJcaSC5bmEF9fM7fbjoBsvCyqLsk8DA9F
	 oqGyrhiP3CXAZdK9WEQhAlOhKvWrj8WMFcK70NhUkfMNODpoH7l30kifsigPUx5G4q
	 lcNj2sBFDmdqf/qNvyEDHAmIKn+zvcpiE1VSDExndt3rZv5LIew1oIRX1dgqUvxZuo
	 qjrmtbfPGHJJ9Pi708oRJOadeqNITHmJ39z7dBeJWrVb6u7Dbqpg93qCgBE+LAgLRN
	 6JkFfr9Qa4PYA==
Date: Thu, 5 Nov 2026 09:31:32 +0100
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
Subject: Re: [PATCH v2 04/10] irqchip/gic-v5: Serialise ITS invalidation
 commands
Message-ID: <auw-5EyY_aifcv1N@red-moon>
References: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
 <20261104-host_gicv5_fixes-v2-4-e47ad20ea3c8@arm.com>
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
In-Reply-To: <20261104-host_gicv5_fixes-v2-4-e47ad20ea3c8@arm.com>

On Wed, Nov 04, 2026 at 05:47:58PM +0000, Sascha Bischoff wrote:
> The ITS uses the shared DIDR and EIDR registers to select the DeviceID
> and EventID whose translation is to be invalidated. Event
> invalidations for different IRQs can overlap, as can an event
> invalidation and a device invalidation. The per-IRQ descriptor lock
> does not serialise these commands, so writes can interleave and cause
> an invalidation to use the DeviceID or EventID of another IRQ being
> invalidated concurrently on a different CPU.
> 
> Serialise the command register writes and STATUSR.IDLE polls for both
> invalidation paths with a per-ITS raw spinlock. The KVM
> gicv5_its_set_vcpu_affinity() callback calls the event invalidation
> helper via irq_set_vcpu_affinity(), which holds the IRQ descriptor
> lock. This path cannot sleep, so use atomic polling.

Same comment here as IRS sync. This one though looks like a host
driver bug that can happen regardless of KVM, so I'd just fix it
and remove/rephrase this paragraph.

> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11

Again, this is linking to a report on a series that wasn't merged
yet but probably it makes sense to leave it there for context.

> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  drivers/irqchip/irq-gic-v5-its.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

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
