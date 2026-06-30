Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15563E172B
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795505; cv=none; b=Df96CRkXqLLOoE0fnsYOfNInRosiWCI/yW9HiBHXDm51qL0EtQC1NizrganAtj8qq4OpOtN/MyZKMu9uFgg/3KeNeHOyQg5ORr1CuyWisBoY8bRXCTVdt1UPvoIv705FL2oC8tTJnyaTxX9WL2YFnzBypw7+Zvoh5AuCBQJHmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795505; c=relaxed/simple;
	bh=PDtmAlN/l3AacalC3gwsynICMhrvd+rFwPMR8b97xBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYs3P9D5p+PkEcfxza7fHtVnLr7RjU66Y50Iyp123Og2uNsSv//IdCb89boXVozBBSMILK7COxQ5+dYoHUBurf6q/ajvP1MhJ6v4d+ipwfhkwt0YTtmo6VLDsB7rIpXhHVTds752sOpILY5GHTECcUVYhe7w9UkTQcIRXBcKMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZ5TrwG0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ5TrwG0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c81db32393so33955ad.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 21:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782795502; x=1783400302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BTfbnMUIEG0n8Nzn7+iH305BTPpn6kW1wYaDzBzIPgA=;
        b=aZ5TrwG0ZDfXuB2hdL/WI4s7/Pi+ZVcwWlZ0C9QJ0yjJnFEX1Iu7UCXH50SuipX9i2
         IOFvFUvYaW3uYq24erGhXg0C7yjxan9Qr0RHo0oscZDXnzNIM1yFHhvdLT91nA3peRHl
         TeIuIb1bDcJpqGIOZUFU7gysw3kYMImlbYjHOKO1y+XhRypDpd7LKc/wasZSGCEFln/2
         HCRgWxl/bqkB1SJdk8T0X8mWpaB3EYtNYHecjRgyxA/d3GwE7TM8/GKm6CZ3w/C8HwW1
         2omkhQIGyzvdIDRdAO+mgA+CRyIqyIVbi6U+wzd+iYoKLCrZQsQxvjvGwWZ5qC83fUld
         k2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795502; x=1783400302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTfbnMUIEG0n8Nzn7+iH305BTPpn6kW1wYaDzBzIPgA=;
        b=hd4TTg/38EmZ3tlwJh0V6dUrcbhA/1ZSJecJLv6Jp5ikL4y4TTpyltPrqhUJQ0pLv4
         C10hpYn0VpMDKr7Hf7mJRfEN3y/rxfR+GGkIhBzIstiqBtz1XxEYqink83///mgKaXgA
         4JqRK2+6b/LmB5wIV5RW4jsIZEz2h8+E4GL7YVs1YC/1tKUiS276YTeB2qlFurnstoOp
         izcFIQFLRRcc/AIIlk4iCs7Qr45ooBDoBGUi/LmK2EUs1e54acyHJUS7gg6QYytKFPfe
         Bybq+60B1DL/nWI+YBm1qDPD1STNQ5K8uzSljbLGCK7bt4Fsut9Nr9h+dmxI90Wp4CY9
         /G/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrYBopWJrHK4gpGkBmxtygLtgbA2WxEsOWduaW/GK2lZ9emDG1acvzTvLNIfFl8pg6lsOKf40g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oQGbCGDXbMtIyN7UDvhwhO/msV3PVp/zEHQsWPYswQBrq+rJ
	DFLVbi/PLXrxeaVSjzrDCLK8OeDDwWDLrtI7re4mycglFpWuYLrhmk6RuV6+ngcIzA==
X-Gm-Gg: AfdE7clmG0xPI3o1oUdyXn77/Jg/dWILV/DtzYdGSg3HxzT1s7KtStVkP9OTNmsXvmm
	eIQrm3TH7JpjCG/wK37jjaL9/XdVxFF55IFh4auWJQW+4VF+oMkFLHh8Dhq6iNB8ZzO/bFyVeWO
	zphHjoZRXUPNjx1Gd7yzeLiD33KzcCH8+va07S+j2RujYD0L00GX45i5RLOHx2m+lqNMwNmBpBj
	M4dlbEHnfzquL/ZuzFoxqnkaqjNYJkH/r/eLqeukHkcZnXJwrfQoMzNDSw/c7VYjEB4LgJXVMVQ
	WSehV6JwurTF2tDVPkmfMxAjkVouS4wWA+/8C2g6UthLU3Bhu/uxpyp68NNr9kr3SlpuYFSz6QU
	+TYHufFq962sIaApyLNn6uNpSv/xQ+XXNyYHRrnWNsEKmkwy/Iaid8HJuasiDP5PcswE5gQns8M
	IHwbCgqDQITsLsglsLgvTeULHXE/0BZAigtUQi0GW+KhetwgM=
X-Received: by 2002:a17:903:26c5:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2ca380db35emr922105ad.10.1782795501571;
        Mon, 29 Jun 2026 21:58:21 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38052f3281dsm859454a91.12.2026.06.29.21.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:58:20 -0700 (PDT)
Date: Tue, 30 Jun 2026 04:58:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 3/7] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ
 interrupts in kdump kernel
Message-ID: <akNM5peYovV3GdV4@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>
 <akIxS7kuhuLRHAMg@google.com>
 <akNCuEfZ30Gf21iQ@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNCuEfZ30Gf21iQ@nvidia.com>

On Mon, Jun 29, 2026 at 09:14:48PM -0700, Nicolin Chen wrote:
> On Mon, Jun 29, 2026 at 08:48:11AM +0000, Pranjal Shrivastava wrote:
> > On Wed, May 20, 2026 at 10:03:20AM -0700, Nicolin Chen wrote:
> > > @@ -5020,19 +5029,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > >  		/*
> > >  		 * Cavium ThunderX2 implementation doesn't support unique irq
> > >  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> > > +		 *
> > > +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
> > >  		 */
> > > -		ret = devm_request_threaded_irq(smmu->dev, irq,
> > > -					arm_smmu_combined_irq_handler,
> > > -					arm_smmu_combined_irq_thread,
> > > -					IRQF_ONESHOT,
> > > -					"arm-smmu-v3-combined-irq", smmu);
> > > +		if (is_kdump_kernel())
> > > +			ret = devm_request_irq(smmu->dev, irq,
> > > +					       arm_smmu_combined_irq_handler, 0,
> > > +					       "arm-smmu-v3-combined-irq",
> > > +					       smmu);
> > 
> > This `if` isn't needed, we can continue using devm_request_threaded_irq,
> > if you look at the doc for devm_request_threaded_irq [1] it says:
> [...]
> > So, we can pass handler() here while leaving the thread_fn == NULL:
> > 
> > ret = devm_request_threaded_irq(smmu->dev, irq,
> >          arm_smmu_combined_irq_handler,
> >          is_kdump_kernel() ? NULL : arm_smmu_combined_irq_thread,
> >          IRQF_ONESHOT,
> >          "arm-smmu-v3-combined-irq", smmu);
> 
> Are you sure?
> 
> __setup_irq():
> 1497-   /*
> 1498:    * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
> 1499-    * masked until the threaded handled is done. If there is no thread
> 1500:    * handler then it makes no sense to have IRQF_ONESHOT.
> 1501-    */
> 1502:   WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);

I meant without IRQF_ONESHOT: 

is_kdump_kernel() ? 0 : IRQF_ONESHOT, note that devm_request_irq is just:

static inline int __must_check
devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handler,
		 unsigned long irqflags, const char *devname, void *dev_id)
{
	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags | IRQF_COND_ONESHOT,
					 devname, dev_id);
}

Not a strong opinion though, just suggesting a way to remove the if.

> 
> > Additionally, the arm_smmu_combined_irq_handler() returns 
> > IRQ_WAKE_THREAD unconditionally, which causes us to hit the warn_on[3] in
> > __handle_irq_event_percpu.
> 
> arm_smmu_combined_irq_handler() does not return IRQ_WAKE_THREAD
> unconditionally.
> 
> This is the first part of PATCH-3 in v6:

Ahh I missed that, somehow.

Thanks,
Praan
