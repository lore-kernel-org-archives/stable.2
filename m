Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628788;
	b=ayLa59SJ2cYpURG2xBcKxvXRICON4Oj5lQSPC4ngGJMjPHqSPVMPjhuf/6QKdN9ntiEV
	 YZe3WBXt0EtSkMBULsdFr7EI7bOxBnv0pG2KUnFzmxL3GkIZlQLSJwWkux9Qube0fxohu
	 t0cRKt1iJnMXjjHVXeyyypwSuwx3M0Svp9VTVAT6zh6DC/uzyRsbtd5uhCHUHl9RrRew9
	 mwZ6ot6ui3RtTFVcgUN5mEAWw8XiL2vU6TtdGtYj7sxQT6BVTwoEZRcDRf8gttLrVpYU1
	 4tPBCRdn/M+sqo8n/xiCId+O6DS3BGvztFOEQ9GVApz7aMAqwmJ0q1VmkaBrnBvxTTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628788;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XPRtcZyPX5uyQlsqBbPqlbi2Hh4PJVsJ6P0BXSRYmAk=;
	b=qWVx2v+Ib7URpM8yLI2hoTil6983pDuHNGY0OK6ZfWpS6lAHgPWJTGDD3AHSTT3WxkZD
	 3seEePsSJOVQv7uNKrA3jVZPRb/Xvucn8uLsSuYjWZ1mHriXaoSALG+MZ5bz8MycN1zxA
	 nToUe2dHpnt7AH9qxmQu7WS3AOWzExxilNWxzKV9056ThH14n85XulKCEUhe+SDLmqcuR
	 8cFfBjsoBAbYDfh/S6TUAYMBiyeN394Vy+d8cH93xvvgzDgwHKyBryI+Jd/kF7jv7JfZ1
	 HNGjbsgeGPD8EqkPJheo43HFbin+HNQndGiKHdUkrC7J11LWDyeIxy4otJjYbA1kPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRxTfCma;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E6606A324;
	Mon,  2 Nov 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRxTfCma
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415641F00A16;
	Mon,  2 Nov 2026 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628788;
	bh=XPRtcZyPX5uyQlsqBbPqlbi2Hh4PJVsJ6P0BXSRYmAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VRxTfCma8suNDbAIew/uqNt2bgj8LgYc15bq9P6bz/YxU+n1N3TEzLZoUbSEpSg13
	 IHzInqJBrnlrpMl1kZxiMTqGHQu6ltNsXPcGdQ3xqXN7NB2oak6VPWpe9VMHEyKf8C
	 apXhKvnNNL5EspRWogeyjQXwMm+/nfDupYn7EVytH1qezntwPTyyaLh6GWcK4lqLMe
	 Z9bTalVJJCwnuoRg8vEfaY6Z4XXUs6bue1se/fw3bNFLiqoT+uoGAX/OZbolSBpY21
	 byimb68/dgZy+BOFsbKJcdSjrQrv9e8Up8iNKTNSAHkV6FhIMsvbiKy18gLftamcCt
	 tnm9kXlL55wqg==
Date: Mon, 2 Nov 2026 15:13:02 +0100
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
Subject: Re: [PATCH 06/10] irqchip/gic-v5: Honour ACPI ITS noncoherent flag
Message-ID: <auiabr1U4c9C7FwL@red-moon>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
 <20261102-host_gicv5_fixes-v1-6-743b61626fc5@arm.com>
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
In-Reply-To: <20261102-host_gicv5_fixes-v1-6-743b61626fc5@arm.com>

On Mon, Nov 02, 2026 at 01:32:59PM +0000, Sascha Bischoff wrote:
> The ACPI ITS probe passes its noncoherent flag to
> gicv5_its_init_bases(), but the common initializer checks a DT
> property instead. For an ACPI ITS, this always selects coherent cache
> settings and skips the cache maintenance required for its tables.
> 
> Use the noncoherent argument, which both firmware paths already
> supply.
> 
> Fixes: a97efa5ba5946 ("irqchip/gic-v5: Add ACPI ITS probing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  drivers/irqchip/irq-gic-v5-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> index 866c238f08dfe..c5d057f713134 100644
> --- a/drivers/irqchip/irq-gic-v5-its.c
> +++ b/drivers/irqchip/irq-gic-v5-its.c
> @@ -1135,7 +1135,7 @@ static int __init gicv5_its_init_bases(void __iomem *its_base, struct fwnode_han
>  			goto out_free_node;
>  	}
>  
> -	if (of_property_read_bool(np, "dma-noncoherent")) {
> +	if (noncoherent) {

Bah. This is a very stupid thinko. Apologies.

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

>  		/*
>  		 * A non-coherent ITS implies that some cache levels cannot be
>  		 * used coherently by the cores and GIC. Our only option is to mark
> 
> -- 
> 2.34.1
> 
