Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697169;
	b=zpBvpyuHtAKR7j1iDGV99a1NVfR750vgx0Ann1xDMB+OIylrx/gOIzwipKGGbDHDPJBb
	 GxQWK4g3cYVpdpK+fyhW+VnAzqoHEXq81v+RRaWI0wIdadhwxsLo7vo0ZYbDLFnwmlNpG
	 SVo9giHRgsiitec58m4ICPshD/lRcLBlyVsPAVMqtMt/Vuzny/Rw5Ztx7Jh/YBiNFqFsN
	 74nYkFEWeKVW2b/8OGDtcsrMjfNCFlCQ7LL/NaIGeuI/0UJLO3HUoIQkLBsHfnn2v/RqT
	 PUH8T5hcfbW6b83LleVcTWB/Xq6DLbhwDBJijElqffzaWeM44mIMq5juoTRznyamHBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697169;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ErjjaE4RW/5nRw+4oz+qsM8b9z5s5mnnmQMT84WCfP4=;
	b=HEADAQm0NpuZ7ICZ5kjVJHlTx9UdPq3j9sDDm9EXq5bieGFE3KX/mxWlQTR+7DWjxD9h
	 p8ACB25bgVmYt9OMKJCfkQn4v38riH6gD9L8RsNRNo1gUQC0qHVGVMS6iYpyR+Qlq5fcp
	 5tqDVUtkEMbCoJUe2eSe2Gquhq6HDge7LoIoP7E491Zo04pt8PKD2XWux041FM+4Lsmem
	 mcBBhAG9AbKaPVOl56/oWEEvpyqX7b9mWXBGORpiptXMZ9euGvJTWSEDCotIrxFeIxgQW
	 cfTCUilvHH/La3ziR9BGO3hCyIcrlw1xXas3Aizgb0J3NwSFYWKutuYOhLyVhklupag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjHJjZnH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DD606A327;
	Tue,  3 Nov 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjHJjZnH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649761F00A16;
	Tue,  3 Nov 2026 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697169;
	bh=ErjjaE4RW/5nRw+4oz+qsM8b9z5s5mnnmQMT84WCfP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CjHJjZnHJhML0IaNYkNnjUimzWrMY+rv3vUBhX7VJZ58Hn/Vja471Sv8GRBP0j9wR
	 GoUYKY6SGyiMtf2YG3486PCDMd02cSD6kIs0zFGArLXN8bclXQovAAJi1tWz8u6i+2
	 VTzAZbalCBsa6ib+cVgk2UKQ2ov4j4uiX7TjaNpepEZx1jYJpztowO9RApgU/lSnqR
	 3SUb0e3AOACYHkJkQ7Sgd8fQZjp8iy3cFCoJwNZwBkLH6l/D89Hp+qKC2x51M9EsqW
	 gndNLpn9RVygU3gcvTkHkFBC5DRvu7VibL1eABt60xFGG4pVbmgvUGQc+RhLVfl5oy
	 d3hSMv3S3jANQ==
Date: Tue, 3 Nov 2026 10:12:43 +0100
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
Subject: Re: [PATCH 03/10] irqchip/gic-v5: Serialise IRS synchronisation
 requests
Message-ID: <aumlixJkwDBlv8Yf@red-moon>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
 <20261102-host_gicv5_fixes-v1-3-743b61626fc5@arm.com>
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
In-Reply-To: <20261102-host_gicv5_fixes-v1-3-743b61626fc5@arm.com>

On Mon, Nov 02, 2026 at 01:32:56PM +0000, Sascha Bischoff wrote:
> IRS_SYNCR writes are ignored while IRS_SYNC_STATUSR.IDLE is clear.
> Calls to gicv5_irs_syncr() for different IRQs can overlap, allowing
> the second request to be dropped. Its caller can then observe the
> first request completing and assume that its own events have been
> processed.
> 
> Serialise the request and completion poll with a raw spinlock. We use
> atomic polling, as the lock cannot be held over a sleeping wait.
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

Why does it have to be a spinlock ?

Thanks,
Lorenzo

>  	irs_writel_relaxed(irs_data, syncr, GICV5_IRS_SYNCR);
>  
> -	gicv5_wait_for_op(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
> -			  GICV5_IRS_SYNC_STATUSR_IDLE);
> +	gicv5_wait_for_op_atomic(irs_data->irs_base, GICV5_IRS_SYNC_STATUSR,
> +				 GICV5_IRS_SYNC_STATUSR_IDLE, NULL);
>  }
>  
>  int gicv5_irs_register_cpu(int cpuid)
> 
> -- 
> 2.34.1
> 
