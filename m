Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39B254B18;
	Tue,  2 Jun 2026 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435578; cv=none; b=n2F8VpvphVkcavMcBowREO+Ofq18uq/Br1lilQRBKcY5o5B/DlspnMmV2rOkojTapN5IWNxew2nJtormHAxY/D+OuiMt3TaaB70ShiiiqRkXdjFYg03hsSI/ajfnFv/8yaI7IudqwTf3t7C0gXHa5IHVGYSu9iFqqfbDdQpCHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435578; c=relaxed/simple;
	bh=8EBy7ybTl//vu+nm9PnTbrUFhFcMdkTOxZac6oloY44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIeaSL0uDCKgcPNB6tikPZRJBY29n7SEx1QWY37LcX4GfBCSVrgz+QFFPTFJmtIaP7n3G51e1X/BP+NhlDzXv1YVGLpHeRny+HH19zSDjbWMzHv9oj5uSZ7b7zK+0hjZ7G6KXskq3xzNPqdWxV5hm66lzY/JGB3OhXJk+atQTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdbJmsmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdbJmsmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBC41F00893;
	Tue,  2 Jun 2026 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435577;
	bh=Q67DNBKcuffmWspv6LvVXCmA21SteXLC22ebhEgdn1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mdbJmsmkEsdF6WXBnuWjh113rOwL2Pkj8cahrG8MIion6Mz4kplBkEhwPrDD33eDD
	 znJSL3Bibb+P0LWtHqZVhkaYTTlsjFLBbn+TB7WYFekuQYnB6/BA0xquWaFJL5DHPn
	 TuwV9LJLjB8JHgjfzUrsFuUHGOQpbKFa+5fp+uG1pxjBjrnB9SODF/YTjNxUg7ymZt
	 HQ8g4hoCHHaBwCoFvYsf8ubM69aIgs9gl+gLeVh5B6quLPTQTFmjCV6bU2eGkCAFn7
	 PDwfb2rpskRTXn+L5A43fU6kavrSI3fkI7tESb84CJ7qEImG5/D25t8R64BdT3qupN
	 Hb7Xbj58pX/sw==
Date: Tue, 2 Jun 2026 14:26:16 -0700
From: Oliver Upton <oupton@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: maz@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, kees@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: vgic-its: Serialize translation cache
 invalidation under its_lock
Message-ID: <ah9KeH8bFl8NOveO@kernel.org>
References: <ah6Lsi4MfKUU6wBR@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6Lsi4MfKUU6wBR@v4bel>

Hi Hyunwoo,

Thanks for respinning.

On Tue, Jun 02, 2026 at 04:52:18PM +0900, Hyunwoo Kim wrote:
> @@ -607,17 +609,16 @@ void vgic_its_invalidate_all_caches(struct kvm *kvm)
>  	struct kvm_device *dev;
>  	struct vgic_its *its;
>  
> -	rcu_read_lock();
> +	guard(mutex)(&kvm->lock);

Urgh, entirely my mistake but we can get here holding the vcpu->mutex
which is an ordering bug. We can defer the locking cleanup as a long
term fix (which I still want) and take what you had before in v1.

Sorry for the noise.

Thanks,
Oliver

> -	list_for_each_entry_rcu(dev, &kvm->devices, vm_node) {
> +	list_for_each_entry(dev, &kvm->devices, vm_node) {
>  		if (dev->ops != &kvm_arm_vgic_its_ops)
>  			continue;
>  
>  		its = dev->private;
> +		guard(mutex)(&its->its_lock);
>  		vgic_its_invalidate_cache(its);
>  	}
> -
> -	rcu_read_unlock();
>  }
>  
>  int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
> @@ -1725,8 +1726,10 @@ static void vgic_mmio_write_its_ctlr(struct kvm *kvm, struct vgic_its *its,
>  		goto out;
>  
>  	its->enabled = !!(val & GITS_CTLR_ENABLE);
> -	if (!its->enabled)
> +	if (!its->enabled) {
> +		guard(mutex)(&its->its_lock);
>  		vgic_its_invalidate_cache(its);
> +	}
>  
>  	/*
>  	 * Try to process any pending commands. This function bails out early
> -- 
> 2.43.0
> 
