Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB523392C
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795663; cv=none; b=iijFgQYxKjXGioCdx6ccdrLTcA2SmSJtV+1px8GybYvp2zTI4Zi4jfdaOvhoi5CxMw1cvx1M63Rs/8b21TY1RP3DLAHui+cDBl/iFBaqRoyjckdJf+kJCIFXU6eC1NpI+IEt8dQdeZdD2oU5moEsJPQIxUIFR7YZw1r7uJGZnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795663; c=relaxed/simple;
	bh=cshp6EzvH/z+lGb8qp51J7AAzfUL7EToPgWpEXGShdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0kkgZVaucyZtNsSHkHpPIvZ61zoILMHuTlIdNAL6ll0o8Ylf+al1kPIYmgjjUkWajKkTljJf3nBJQNVOixEmqwl/RviTmyhxfX50Bfs9FlCxl2Ug1vUeOBUSg4pVpO7U/jvvXOs7+Gqxd2jW7n6s+V6bmag2D0MgL+WTXrDkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8YmT/ii; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8YmT/ii"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso19525ad.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782795661; x=1783400461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qZlx3+QrS8E5J6yUhrTaagwhrce5Kq0xuQVQ07nl46w=;
        b=l8YmT/iiNVu0b0Yk8Clfeu1rVtvq075YlSg2Uu6daDWI11rUQUO7SDELb7sqU3Yrz0
         cUMQ6PL4kBoYr3Wt6SkvCRnPVqFrM+/YkkK30ERDpl854tEUqCRLYvi2C6npUX2ZEwng
         N/I7ABaMj4zexAa5U6dRa4qit7ZBUUth//lnlHEecM9MNuYsQ2ZcRy20OXjW5itVv9vm
         JptNrdK+4EA3cV4Dw3ExbfmGxCW1f4sDbTudfBwL3Rjdv7xicfLBtM2V1Xb4gaFI5dHu
         iF4XhlD7nS2y6/N0w8N4AB3IJ5HMAz2mVyD/bQbQM1m5Up6E1Qv9Mcsx5Yp7EfvSQSIA
         DS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795661; x=1783400461;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZlx3+QrS8E5J6yUhrTaagwhrce5Kq0xuQVQ07nl46w=;
        b=BZI1GAtz0h/zkFlfYig+ECA0ELFekeUyCqtGNI0SLoMWK8M9Fj1mzUIuJWciQm7gXW
         kRs0xGhS3EDRxR1kClxZuWR0pYCfHn/aW3MOZhR+xW34Ay3gi8N/H+rC7pxtf3FKk3Wd
         /ZVinknGbr0rd+K3FQ3kcWX+RSHkAHLmAZ0QbIo1E+2l4Tte32jidvGprmLhrLou1tA8
         iXxZBQujc/TZwdq89UsMEmdfPamCpub92Jh7xyQfWTfLAFA+IbQu0vBmVnIZ/RlaPgUB
         /VGuK7KglPBQa4qKX6P+sNXzZenM2Fou2hCt7lmVLBhzav72qSLS5/yVPtXOX8XNlnvP
         B8jg==
X-Forwarded-Encrypted: i=1; AHgh+RrmbsLohA9RhQO5fvT2KNSJZRDWDuXd5kTe/IRtPnPCWRqE+zYvjnYSi/DvICbd//dtzBgJ7ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5XB3TRF1NeFeb7fu2QFZ54egywzVEsIuQ8bg1iArG6xQMFxIW
	YQXlHqYPX02TNSzv2DbF3D3FxXy2x4nykzCsU06EqqhpDqA/g4rcPHLxK/2zboY/nw==
X-Gm-Gg: AfdE7clpBNrDw4KPEjIUf3xC4E1X38pZhzB77lNhcndUVQF3R/I3V72tM2rQ9DZ0aFf
	eRl0NoVcjmCyjvyTOoz7jf6A4N/psEonil2KOe9vk1RHbF7yDTGuw4opciKGGTBJrzicqUu3SJe
	bPDC2DzSX0FBs4Nu3P61pYUeyXnREVRwWVLW3m0p9RXvQvbGbF/qSiGeaFknP5bRmchd+VQwCGp
	h10Phw+kuSns6hQPvcGIX8qdX3c3j3igxsY0hdh2jJ3SJLHFplE9Dc0t7n7qxWyNmOTjbjF26M2
	+AK9Kamqed44h2TydCgbd2onkHau2cOKU/enTJdNx22iSlJvMMnjFC+QzdRWjzPhmvb3IU9TC9G
	31iYfO7UxQ3j2QM8gZN473ughqcypRtcOKhwtBWwOx9lQX9MlJ8QCb2cQ1JqDuqk87Wl9RnrL4L
	MQ3YIPmyEfKpYtGtpe+Hvd6gNzo+eP7fGIsCpM6+igf2zydys=
X-Received: by 2002:a17:903:240c:b0:2c1:ee6e:be1d with SMTP id d9443c01a7336-2ca3df01df2mr507815ad.27.1782795660514;
        Mon, 29 Jun 2026 22:01:00 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02cd237sm986590b3a.32.2026.06.29.22.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:00:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 05:00:54 +0000
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
Message-ID: <akNNhjmOulawZwX1@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>
 <akIxS7kuhuLRHAMg@google.com>
 <akNCuEfZ30Gf21iQ@nvidia.com>
 <akNM5peYovV3GdV4@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNM5peYovV3GdV4@google.com>

On Tue, Jun 30, 2026 at 04:58:14AM +0000, Pranjal Shrivastava wrote:
> On Mon, Jun 29, 2026 at 09:14:48PM -0700, Nicolin Chen wrote:
> > On Mon, Jun 29, 2026 at 08:48:11AM +0000, Pranjal Shrivastava wrote:
> > > On Wed, May 20, 2026 at 10:03:20AM -0700, Nicolin Chen wrote:
> > > > @@ -5020,19 +5029,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > > >  		/*
> > > >  		 * Cavium ThunderX2 implementation doesn't support unique irq
> > > >  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> > > > +		 *
> > > > +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
> > > >  		 */
> > > > -		ret = devm_request_threaded_irq(smmu->dev, irq,
> > > > -					arm_smmu_combined_irq_handler,
> > > > -					arm_smmu_combined_irq_thread,
> > > > -					IRQF_ONESHOT,
> > > > -					"arm-smmu-v3-combined-irq", smmu);
> > > > +		if (is_kdump_kernel())
> > > > +			ret = devm_request_irq(smmu->dev, irq,
> > > > +					       arm_smmu_combined_irq_handler, 0,
> > > > +					       "arm-smmu-v3-combined-irq",
> > > > +					       smmu);
> > > 
> > 
> > Are you sure?
> > 
> > __setup_irq():
> > 1497-   /*
> > 1498:    * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
> > 1499-    * masked until the threaded handled is done. If there is no thread
> > 1500:    * handler then it makes no sense to have IRQF_ONESHOT.
> > 1501-    */
> > 1502:   WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);
> 
> I meant without IRQF_ONESHOT: 
> 
> is_kdump_kernel() ? 0 : IRQF_ONESHOT, note that devm_request_irq is just:
> 
> static inline int __must_check
> devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handler,
> 		 unsigned long irqflags, const char *devname, void *dev_id)
> {
> 	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags | IRQF_COND_ONESHOT,
> 					 devname, dev_id);
> }
> 
> Not a strong opinion though, just suggesting a way to remove the if.
> 

I though I had given an R-b earlier, but I didn't.
With that nit:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
