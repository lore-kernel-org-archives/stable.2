Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864896;
	b=f7IZzU+r52oDgKZOXERvRVLCAa+kELtxNdo7SiX51iOSHfI6fVqWrpaFgestZ7NuhtQa
	 11fic88yejp1Vk6MPbSHC1nWOB279M29dVt4TALvhk4J+xILDEDsX1bo+pSYuAdyPPbas
	 av+LAKaXeM1k6lB9yKwqbqh1KqS2V5M0BFgjDtoYwk4D/Nx39g1tyZQgQL7Yh2gemrsyG
	 mWLtlIAyeq1ABG11BkCurHl3xwV19Lt7uDnzWyrELML8nt+iQ+Bry/jrCBKeLndostO71
	 Wkyr/5lCN15Vz0by5GvOnq/MwNIxHlECIfXwaBusaOVncAI0erFQ6m0j6HFoU4uWz1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864896;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cccu6IRsMQeLQd78s6fwoKTtP+m0EnGz9D3UFhBgw70=;
	b=TNavUDPWc9u20eFsYvXcSFisl2a/UlFFrHsSzKr5lbXBvL0xEua+yGnU2qFnTBMPZ5Ee
	 tuwmfyL8RPRziO6ezWMpgkPpYLCR1u3h0rm7MCrqVciAicrRAmLUQgD/VsjYa1AoJL7zm
	 ogrYjQEVonlNWhuByJGhmnR9qSvWK9c6i9KecVM1aiHg6ZEkzaC8hlDpJxuos2jU9xjsy
	 dPbc5hisEMmGMEZRoD5gvlPAtWiy9NOMF47xudLdWrirsdNi2lHBiF5KQT0+JYMh5bdn3
	 Mu10rwGz5ZXAvux/IAClxIhNfnEe6R8elpOBbDW8ioM9nqt0qOVNLE767DraoDNIbag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tus64+ki;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF1606A326;
	Thu,  5 Nov 2026 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tus64+ki
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204FC1F000C1;
	Thu,  5 Nov 2026 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864895;
	bh=cccu6IRsMQeLQd78s6fwoKTtP+m0EnGz9D3UFhBgw70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tus64+kiiu8OCMzKk6Heycm1KF6FxRYt561NxnLKxXsXtN0qLbCDwpRtK5/a7KCEp
	 fkR2rRoHU8dJU47985DAeip4Y7Vi2OWAZIFdJIH8Rzrra54g/aW+IAGtx3LnFm/g78
	 mZrJ5/bTh0WHEZZlUTOiZ5MliGL9kkmDX88m+CfwFPhQ910iBwePtLaIePmyP7q/Xl
	 yGHIBJI+oCTpUYVeJVx4uLtEbb4uQPlxVZdPHnpMo1OEi9BNfvaJHAwivueZPicjz5
	 UBNq8PanCBb9RS5Uu1mV05PTBxbP0f/4FHnFEyK58B7xt6t0Pz9qbELZaxy8mIIhOq
	 XsSHaIc5sJqUw==
Date: Thu, 5 Nov 2026 08:48:10 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 03/10] irqchip/gic-v5: Serialise IRS synchronisation
 requests
Message-ID: <auw0ulR3wrsKVcYe@red-moon>
References: <20261104-host_gicv5_fixes-v2-0-e47ad20ea3c8@arm.com>
 <20261104-host_gicv5_fixes-v2-3-e47ad20ea3c8@arm.com>
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
In-Reply-To: <20261104-host_gicv5_fixes-v2-3-e47ad20ea3c8@arm.com>

[Remove stable from the CC email recipient list, leave it only in the log]

On Wed, Nov 04, 2026 at 05:47:57PM +0000, Sascha Bischoff wrote:
> IRS_SYNCR writes are ignored while IRS_SYNC_STATUSR.IDLE is clear.
> Calls to gicv5_irs_syncr() for different IRQs can overlap, allowing

Nit: gicv5_irs_syncr() has no notion of specific IRQs, this is
misleading.

> the second request to be dropped. Its caller can then observe the
> first request completing and assume that its own events have been
> processed.
> 
> With GICv5 ITS KVM support, gicv5_irs_syncr() is also called while
> restoring the host ITTE in gicv5_its_set_vcpu_affinity(). The callback
> runs under the IRQ descriptor lock via irq_set_vcpu_affinity(), so it
> cannot sleep.

Technically we are talking about a use case that does not exist yet.

I understand it is churn to fix it first and change it again later,
I would just say that gicv5_irs_syncr() might need to be called in atomic
context.

> Serialise the request and completion poll with a raw spinlock, and use
> atomic polling because the synchronisation runs while holding the IRQ
> descriptor lock.
> 
> Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  drivers/irqchip/irq-gic-v5-irs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> index 4edf787f3f97f..ead76560ea08f 100644
> --- a/drivers/irqchip/irq-gic-v5-irs.c
> +++ b/drivers/irqchip/irq-gic-v5-irs.c
> @@ -10,6 +10,7 @@
>  #include <linux/log2.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/spinlock.h>
>  
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic-v5.h>
> @@ -22,6 +23,8 @@
>  #define LPI_ID_BITS_LINEAR		12
>  
>  static DEFINE_PER_CPU_READ_MOSTLY(struct gicv5_irs_chip_data *, per_cpu_irs_data);
> +/* Synchronization requests must not overlap in an IRS Domain. */
> +static DEFINE_RAW_SPINLOCK(irs_sync_lock);
>  static LIST_HEAD(irs_nodes);
>  
>  static u32 irs_readl_relaxed(struct gicv5_irs_chip_data *irs_data,
> @@ -507,10 +510,11 @@ void gicv5_irs_syncr(void)
>  		return;
>  
>  	syncr = FIELD_PREP(GICV5_IRS_SYNCR_SYNC, 1);
> +	guard(raw_spinlock_irqsave)(&irs_sync_lock);
>  	irs_writel_relaxed(irs_data, syncr, GICV5_IRS_SYNCR);
>  
> -	gicv5_wait_for_op(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
> -			  GICV5_IRS_SYNC_STATUSR_IDLE);
> +	gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
> +				 GICV5_IRS_SYNC_STATUSR_IDLE, NULL);
>  }

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

>  
>  int gicv5_irs_register_cpu(int cpuid)
> 
> -- 
> 2.34.1
> 
