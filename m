Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F73D9026
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387429; cv=none; b=P+NEHUs98RgVDwFpc5yOXL5GOasU6YXJmqShwBKi9U1+aigu1U/kdKST2xYDZcj8skqFuwlOB/w9n6b7GO7/vpzAdlufc85/HeA9byHnwmMW3tuWpfrU4jIILyX8vEh6eKGyp0DGTzGErUa/zhK5fgq7kDQSbUs3leuxS2I0uYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387429; c=relaxed/simple;
	bh=HnlHQXGsvp+6F/r93fDYilMWTToRwzIzL5ppp6nRv0w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc1ppIGdh+CHTT4bAIuCtc0HnvtWxsEg7uFS9Wnly5DMK1UUTslXYOevWDSTEof21k7RP97WTcTfSpJ0E3MmUMzw7hYviXcm7xReDwS3SJwc8OXTa83U0+Zdmnyq9mxSoGHRGNq6awfpIRiSDJbPSuTex3YWyxxarLuz88zVtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsfTEt1e; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsfTEt1e"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30c8f2d93baso461736eec.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782387427; x=1782992227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnK/0+TnvTsU7klFGLefqowugiRNUuGQYFS44xmyZM8=;
        b=SsfTEt1eiU9wKiTsdXHaTP3upWuApWjXizLY7yaJ2rcXEzzQoIiSo2QctACj3zPRym
         NnS6SBmBnFlf3ZYS6Gv1A8GlgdgkOlDjdsbJWHU4yCnyIj641KeJbi2lhyxVRgHv2hNQ
         QH4147Ggfmsjcccq+PCfBDkVAhHs8XwM5LD0o7Zx8tRF2GH1gYFaMoA/bz3E3gkkljmZ
         KDbuHwCJB5DGK0GaRh/bZSvtjVCqApi7etFt68UyU607711YiV9RDVEgJOP+HnmXFDT3
         5v/gWIOvrh2KUl/vzhyxZYpAiDGeFWW/rYjrLduW6UXALXrBy0587iAmnrfMGr1KRhYJ
         A3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782387427; x=1782992227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnK/0+TnvTsU7klFGLefqowugiRNUuGQYFS44xmyZM8=;
        b=U+HLVVV+Y83CP54RdWzxEBHiqFg1CCkCnvDnnsd12UTKiQoAKbjIl1yzS5exm0EI+r
         HWg7CMtZ+zLMxxhpcVkxFL3O5A3xGWtiJvoa9CTP8CG6kt5pi5fMogyLcmTtRZdWmFb1
         iTk9TyVbvS9fEsXeY24yVyjcFbNUYG7S4s1yNLR6eWuJdACIscjZ6KYwiSALdzN9vcJR
         z7ZNdUAFv8HrUbcqijYC54dWdVsOJgk0trwiup3CT2EyWqXG2ao2hOPWM8hnU5XuKi/b
         Q4TWobMdOw2EGzWseaeuRW9IupquAk3+Ux1fu91CVUyW7+HwjJqKxsNnczVxqdeNvrZM
         EmeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtQyHrCTb8HFbGf3C+UTR7EotkZdenRDqTOmEtX8MzigQq8uwSuKCd47J+w5ig1PTWjOoLBA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0oXuIRcd+xB5xToWklDC3Mi1sgI3y0ljhwxBG+CRIQuO1iG6
	tJwHDb/3NQSYOInx0g5081ZhcPY5EBtTB9kr7xSr1jB5GadBc71fur6l
X-Gm-Gg: AfdE7cnrKz8XyHxVWKN/+1LAbBNeGR+MLBqJAOG4rP7niSALEhB88Jj9iztzcmdJ1tO
	3/g8V3hAfaUtz0pljXVSw39EBN1hruaUE72wVMVX2BBZ6xyzCYJOQpVdEBd7vXDHezDb8pY2uoD
	f0KzKdssEl8cpfXx+lah+AswyNy7TsiXNwj/WBy6OFYx+rYbH39hP3lacBgZHMGezeZxlejpF/L
	u7NI6fIGkkjQZK4+ubbuiJvO3P+PhoUXR/mMjrK37SfYWD6h7d7oRakAbctqBuIjXGdW6rcEPYL
	S7c4bTDl32djVOu5zrG2nkCOtCZoeHP4CnrOsIdy33NPEbqGUn0xaik74rHyJdZUYo83ifT3NvC
	aL5tNFfvS6PB+3ooYYY6UhgY4+jswMwCeV2WCUXAD7sKputBaSMuIwS12enNmdzkW9blADx5tk4
	bV4IdAR9yPw8fi9HQzyPJZyTNyrQpyQ8MMwMTvVusauJwGrlhI+weZ6qljXTQe5MH7InL7QyqAS
	WFtrgo=
X-Received: by 2002:a05:7300:7c21:b0:30c:6847:c2ec with SMTP id 5a478bee46e88-30c850a9096mr2615045eec.32.1782387427005;
        Thu, 25 Jun 2026 04:37:07 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca69c8asm9061887eec.26.2026.06.25.04.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:37:06 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 25 Jun 2026 04:37:04 -0700
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cxl/pmem: Format nvdimm serial numbers as decimal
Message-ID: <aj0S4AW-V6IMayd-@AnisaLaptop.localdomain>
References: <20260619055932.1354182-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619055932.1354182-1-alison.schofield@intel.com>

On Thu, Jun 18, 2026 at 10:59:29PM -0700, Alison Schofield wrote:
> The CXL NVDIMM security passphrase key is looked up by the description
> "nvdimm:" followed by the device serial string. For serial numbers of
> 10 and above, the kernel auto-unlock path fails to find the key
> because ndctl names it with a decimal serial and the kernel uses hex.
> 
> That means a passphrase-protected device cannot be unlocked after a
> reboot, and the pmem namespaces it backs do not come up. Devices
> without an enrolled passphrase are unaffected.
> 
> The mismatch occurs for any serial number of 10 and above. Since CXL
> device serial numbers are vendor-assigned 64-bit values, that covers
> essentially all real hardware once security is enabled.
> 
> The 'id' sysfs attribute is established ABI that ndctl consumes as
> decimal, so format the kernel's serial string the same way. A u64
> decimal string requires up to 20 digits plus a NUL byte, so grow
> CXL_DEV_ID_LEN to fit it.
> 
> The issue was exposed by CXL unit test cxl-security.sh when cxl_test
> mock serial numbers were recently extended to 10 and above.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Thanks for the fix! Can confirm from my ndctl-test runner runs
that cxl-security.sh passes when applied on top of DCD v11 patches

https://github.com/anisa-su993/ndctl-test-runner/actions/workflows/main.yml

> ---
>  drivers/cxl/core/pmem.c | 10 ++++++----
>  drivers/cxl/cxl.h       |  3 ++-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index 68462e38a977..2ccdf04c1f43 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_nvdimm_type;
>  	/*
> -	 * A "%llx" string is 17-bytes vs dimm_id that is max
> -	 * NVDIMM_KEY_DESC_LEN
> +	 * dev_id becomes the nvdimm dimm_id used for security key
> +	 * lookups. Match the decimal serial emitted by the CXL 'id'
> +	 * sysfs attribute. A u64 decimal string requires 20 digits
> +	 * plus a NUL byte and must still fit in NVDIMM_KEY_DESC_LEN.
>  	 */
> -	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
> +	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
>  		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
> -	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
> +	sprintf(cxl_nvd->dev_id, "%lld", cxlmd->cxlds->serial);
>  
>  	return cxl_nvd;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..3463faeb8a15 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -487,7 +487,8 @@ struct cxl_nvdimm_bridge {
>  	struct nvdimm_bus_descriptor nd_desc;
>  };
>  
> -#define CXL_DEV_ID_LEN 19
> +/* Holds a u64 serial as a decimal string: up to 20 digits + NUL */
> +#define CXL_DEV_ID_LEN 21
>  
>  enum {
>  	CXL_NVD_F_INVALIDATED = 0,
> 
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> -- 
> 2.37.3
> 
