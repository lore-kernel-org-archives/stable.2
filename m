Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310ED3BFACA
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716979; cv=none; b=oyHK297gNYfl53npZg7g/t1U0LmSQm3gOYhIfRGxIFqTGfAx+P/wU65DVv4cX0Cg/U/aC5LIQqGigl5eytLt58t/haHYeTXDncwHkT1gAcEGD/aSNUe4rXtFbLF3RJ7Z2HiVnGCUBdAmOJsPltCEWQpF0S+9SGhbv45/W1XzkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716979; c=relaxed/simple;
	bh=wNpmRG0bvwI0zH3SDqeNYVrQrLdnvlPl+nuh3Ab+P20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixu9IyoomfOpa1M7yqWZhDICLWd4/akJ7MjQJXCc45bxZ5YBjEYIjtqyRaUej52e6cvJqA7rQJDN2pRKpZI3hgNds3Ua2IaApDSf0JToe+/oXqPXA1S16TCz7aI4MQ6CXIe6TinJEPmQd889s93gy4KP+wg9yXL7JrcREZLMtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kg2efFP/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kg2efFP/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso112155ad.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786716953; x=1787321753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rH19XpzJqW08+W7mG+VpaQ4KF0ayb7gJPWy2w+2WSfo=;
        b=kg2efFP/TtCo76QCoUbohIN1VPgDDwx85UcEjleCkINT7vo9PAgTqinR/tAwN+VcRv
         ZNqv4SHT91ZC6/2u5s9WnhxMjVPh9dn/qWsPQqFJH2QycEzCQbPMSbL6rZR9hnWcL8pp
         Xn8rNxPZa4bgT3iSqy4/iFShecuegYXcIG0vnC2OqQWbH7k8waS6CsGaRTz1KwIauS4W
         u7kPCNrY0jbX2esOfaeA8/A5svsl3H4FvASxyUdkGeOxUKSORya6K6dE18Yf38nvb0ub
         4QeByCY4StcNfGhyJpTGXfBDTA1VS0aiHn1lR68D6mQOSiqDpMkFchN7Tp4os5/KqS04
         jVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786716953; x=1787321753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rH19XpzJqW08+W7mG+VpaQ4KF0ayb7gJPWy2w+2WSfo=;
        b=mQItRzAh/VWq5AF22OSv+5MKm+1L+Sc7ErWqamzC/7Qk1NQxC3+H3iZYP4jjtMnw96
         cu6o3bKrrs0QzXqfBzd8eKmPQD5+li5yvSb+/kKZfn4ECBnZfXNAD3T4dWz3792HshC9
         +jlJsfE+okMW7xexETD6/bryEiUbng2RkE3IJzcWLKSDphR1nPPZ9XJ7pOvNkgFy9vHV
         i8uS20Ms+m6CjTiSg4v7EeXC7VUSNdHo/XrRYtQghrBkuTB18Cfkb/KttELVPZLarAFy
         /Q9fKRe8Ad+b4uqdTksrwZJl4QzO48fLQPsBIzxH7CwW6mbO3n3JwPed5GEPWnlK1vcC
         D4oQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaspNFEnWoTFvJGErJS21OAwSgBUl18bW3O9SStsSDGVNA6OWhwpCgst2NGQGHGx98yLX6Wt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNSoAeKoX3JWKgCwhfb/NVMwnkD8O3Jv6HrgGaUDrE105qfZ0
	gVfAFPVii4lVNnEE2kuuW0+i+H/ZA0mVTC46VEhUFxK8SsyHfbWl8pBJBEDtlNkBmg==
X-Gm-Gg: AR+sD10rHuYoaKYzNiPIGWNxtQxK9wpwHEvkdpdeCn02hAjpeUevdxiL60DbD4eEVZ/
	mVUr3PBJSSlHDR2AEjzCvb2H482MtkrMdIlmxpEuiBeewmc2s51LUnHOZ2n0T0259T/Xp+Urmag
	BxS9SkhiFVs9hMwTnNQO/SOl6CaJ/ZVpF9thIg4SXs9T9yJaNiTsgQ5dEEY/i1De1Im6lHrh0PO
	duJceOURhOc5Aq7CDgkRDXUbgt779iJFsTJo18zVAJi7RNZTvwOzsV0tFFtvQE7x7Uz5Jbm+4Gi
	buk/+wWW/K8M52c+mMyLQlsQCZ6+6Yewl2CT/LVL58Cy2QSZMsdgEENX0VmIAXy8L3IyPLeYme/
	jdKQ9qaWDja4mq1oNUkqHLA1bbXLFXCekzfwXsXHhPW5NjziJqbtXfgmwqE/s7/4w0PomFbpyHc
	cOrs/ivW02Vx77R2krzstTRUwucKLqkXZXXSK2b583IUwgmmer1Tf82ILEr2o6C6ROjzHoB+gIq
	fMbRXzQCOQVnlkNtdAL4AMRp94sYdggmg==
X-Received: by 2002:a17:903:15c8:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2d3af24fa75mr9130205ad.8.1786716952002;
        Fri, 14 Aug 2026 07:15:52 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223f8csm551513b3a.35.2026.08.14.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:15:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 14:15:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Dmitry Malkin <dma@nebius.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <an8jEbT9pAUYfsvR@google.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>

On Fri, Aug 14, 2026 at 10:07:09AM +0000, Dmitry Malkin wrote:

Hi Dmitry,

[...]

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -5,6 +5,8 @@
>  
>  #include <uapi/linux/iommufd.h>
>  
> +#include <linux/pci.h>
> +
>  #include "arm-smmu-v3.h"
>  
>  void *arm_smmu_hw_info(struct device *dev, u32 *length,
> @@ -118,6 +120,17 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  		if (cfg == STRTAB_STE_0_CFG_ABORT ||
>  		    cfg == STRTAB_STE_0_CFG_BYPASS)
>  			return 0;
> +		/*
> +		 * Group-wide domain attachment also visits host PCI bridges. Such a
> +		 * bridge is not exposed to the VM and therefore has no virtual SID.
> +		 */
> +		if (dev_is_pci(state->master->dev) &&
> +		    pci_is_bridge(to_pci_dev(state->master->dev))) {
> +			dev_info_ratelimited(state->master->dev,
> +					     "skipping vDEVICE requirement for translated nested domain: cfg=%u ret=%d\n",
> +					     cfg, ret);
> +			return 0;
> +		}
>  		return ret;
>  	}


I agree that this is needed for old bridges. However, should this check
actually live higher up in IOMMUFD? Instead of the SMMU driver deciding
to bypass the error, what if iommufd itself intercepts the vDEVICE 
mapping failure during the group iteration? If IOMMUFD sees that the 
device lacking a vDEVICE is an IOMMU group alias/bridge, it could 
explicitly tell the underlying driver to proceed with a NULL vmaster?

Also, regarding RID aliasing: while it's true the host bridge doesn't 
need a vDEVICE for its own host-consumed DMAs (like AER/PME), are we
confident this won't break guest-injected events if the bridge aliases
the downstream endpoint's traffic? For e.g. if the "real" endpoint's
traffic is aliased to the bridge's RID and the bridge has no vmaster,
won't we lose the ability to inject IO Page faults into the guest?

Thanks,
Praan
