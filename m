Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D833F58B
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014553; cv=none; b=Jiui6c/pauk3juI9TkFMklVYIeQx8FiodQ0y+gSJe7UgIl9dO0heCXRpm+WVn0nKZ8oFP7sXUczGgUDXpv4xHxzizq1BEpIrQ5Cj+jAI/rotnxq2G3dfMVFyVV+d9g2ajDFaj1ojcNyeLaRkbGsDK5zFLKz9RrGxZby01cGnZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014553; c=relaxed/simple;
	bh=MmkUJTtuyXY3s/7sXM+BP/PzWFzsXVq+eKe6PElRRWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLYiF/j99tSPf6L3ik9asFjOLQwFemnuzdUZn63Pb4hmFZI2pr6aD/nd8SBAsudc+qWTn+7uYaNGPS9Ma6OHvYBucqQO6suuKfS0kcXGirZeGs4lM+j820EWwXWvsBDqRnnGt5rpCIF7yhS0foRE1ifKLQGyMVOj+pkJ7XGfjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aaM+VksD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aaM+VksD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so85209086d6.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781014552; x=1781619352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=aaM+VksD81FwB9qeScW7Sviahb1dkjb/ysJ4WiEyEGLyTs0Z6cGucYu+dxVqbdpXRi
         f8gbU9i+o6e3FfWrmod8ExT89VcRLxM2HRnfSfDDzhaduA3uN4cR4Vd0tWpLyYtguRHR
         boHXaNm4jeKhWgSqym8XL+I7kQxM37q/Hctx7UNd9wCj0vbFATeAYasZ+qkq4WEdzXHH
         5xdTUaUOLnZKWZG0z4Tu/QKNDdjdQT+oR74Il5Vmx3mmgs58Be40v5pIqu6YzMnzzInY
         hjSMgGOfFHBJocJUiljwGsMNozPcr0jeQdE6Q2PLAcQtj/hi+jwCnC0dTaLYm+rkFccJ
         VYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014552; x=1781619352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=QuJbhNSsZwr7FVAXHPTqL6Wg6whGLhZvzzLCZ7E5nVI9KsfzvSpx6UvF5eZoVfq4B+
         3xpYKsA5dJa+pU+Okuhk8Faerp33aoKrye0h6YDHhCMUG9wq3MtMipXavUKfxnnpb2F6
         +u64VBqr6ZwyDtVzHQGJ7QO3HveNau4I3mhCbNdJCI+uapfYcyZPKNYNgCHSL/Bn0GkU
         88aTtLoau/QgB+9Lco5QWSX0maKB7zf0wyc1jJl01Qs0L9xuzOBFYHCoGts1rbScv3tZ
         dAFpY+RRJVsfG/OHeuj7PhXsokgMr4aSttYaU+wiXR5ORJc9bhnu9F7l8zBVysdcZzQG
         LTNQ==
X-Forwarded-Encrypted: i=1; AFNElJ91HftWkVFUdAKbUiGqH4/iI5Xx9Fm0gQ/uMv/Fy7D6t+Qs0Ev9YQ5mb0m9xE12jPx+PDLPqN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcA5HMrBYW38/Es/TuxP1TYYIMa8MGgXsAX1erIJUYpaL4AHS
	OZwu+4B5etEBjvwZrsg+bQUVhJR5TSJRQlBv+usk1rHIFQFLJLClZHHunDTrtPThcy0=
X-Gm-Gg: Acq92OH3GJwjAsU7j5Nlx9eSGNI4TQjn4Sx+qt0vefagk+j4tU2adb8x1dq4R/xt3lt
	xeyYP4umiXSzdBAyishj8v9pFH6mHNa17/tnzEXL8epW0p/2RBSqm4qEea/DC7NYEsc2oMoqQoK
	+7JJ3wg7lksxoAAe8yplraaMjMehnA0mgeoZ+dS52A1CI67jCayBcWze4rZR4sXKB7+YKJl+fSv
	nVmEkN12zMQE3ys0f9dcwZ++eeON0c85eb0ewuQAW693hhJ7ovCWKsEmzikmIo93TAook5XJV5x
	m3w+u9h/QgpmZ2k22sdkVHMdnf5ZkgWbch638wqoo2hjcSpKztWsozJNLH81aUMJOLDWr6haHAt
	qd1RCFKjfR552vTBeVXfHZ6Cp2xzesx5+5QcnerJgyTitbDEgPdsv5SaJUGQBxzcI9on/uOy2U7
	/RKUc9bxajv3QvVCruCfAKEv3EqBobhzISCih42T1Z2PkNITPRzBaPKT2g8bEAVrgSbb7wONFu6
	ARgLx00Ck4R6H++
X-Received: by 2002:a05:6214:626:b0:8ce:ba04:7bc2 with SMTP id 6a1803df08f44-8cee626f0eamr293032506d6.38.1781014535341;
        Tue, 09 Jun 2026 07:15:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm204702746d6.40.2026.06.09.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxEs-000000021xL-0mOX;
	Tue, 09 Jun 2026 11:15:34 -0300
Date: Tue, 9 Jun 2026 11:15:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609141534.GJ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-15-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:53PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}

You should probably put this at the start of the series so it can be
backported

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

To Petr's question I think this just shows nobody is really stressing
the PCI dma paths on CC VMs today.

	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

For instance the places even calling dma_alloc_pages() don't look like
things people would use in a CC VM.

Jason
