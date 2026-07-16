Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFF42BE92
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212062; cv=none; b=Ds5N4SpYeiNhs+2umJqwxU7bFzD84KOTL0GcEUhW0wgHPJWUr9VtDx0OWRxClVwPHq5U0mGjx+V7Kw3ow6+DXCC+Y2HBPkrJ3vK5OfPU/TdJJtRnDZ9+ofgZUGmDJJ4X6w5ioeVxtsjZIHF+FznM3xc+/arJ59cUA3entSLyJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212062; c=relaxed/simple;
	bh=ZbUusZWAWiub6I5lspLkxQnCXKKW3t5+PS6RPFzQstU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsUnid+8pg5JBQpkjaVw+ijRsKKZM6rm7T2cOQMPopthUTEgJQk+QqzzMmeVwYECydgrqTfUVJcQIzBx21smzTowqEmuVgnYC0Y12EJMWEGz2MrXQaLP+1Gla1x2drZEv6IfjA5lzcR+b8fwfn8ylcoGML+bXiNFDxGr6XhLk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g4oowcqV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g4oowcqV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c167c58f2so48562721cf.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784212059; x=1784816859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zpbV942NiMem3Siz+yBEQUzBLYNQDtxtcBJx2zb2Omk=;
        b=g4oowcqV+b5ayzC20AYWSHkLpGIf8JLrR/g5GMfOMNZFlLpZr3fl1pQYgHMQWQ+lRP
         gaN5W2Qg+TykW5Xh/2iLQUbSxpiJoIln+TMYeNdD0K8qcdA3mbA9jMz8XD+Jb8I3sR/f
         /8p3kvPe0wwjCr2KfoaeM5ZFbnDyEC8JYbPMljMPr5hIeDsz/UnAGdWVj+q3j73u1O8E
         50CGGdqgdoiKphUWmpyXcRnkzlW3K6I7SOGHQrYZWXQ5AFaJzURrJgTj9/158PPprzaj
         mLIGX8G16XL6UK4HR3MSSY1/P1LKCxdZdoSYSOrDdj6IsMAqUhsnNdW0k/DBxU8cihP6
         QPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212059; x=1784816859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpbV942NiMem3Siz+yBEQUzBLYNQDtxtcBJx2zb2Omk=;
        b=q02mcAcSh79tAvuycS5T47P2+l4xgdkbr/wRWg7BU5FJdRlPq35f9k7D4QIZAmuFmj
         kIQqb3Rd0Mv1+qdF6CbxOO6ji1Mh6EFLfdtCKHIHWuecPMR4w+RK3m41ddVmiShrEXiL
         H5DzoBC1rU+WYIwA0nNh+9awlmb5mB6bphTorkEOm9G22CsAToNldg/2gVILpgOlg6k9
         1KUP3rvU7J6nvFh0//p6IscNmC9zgtkcjRjeFkO/OZjVtii/i1/fx4xi8c7viNu8QW8N
         9pw2+C7nNnyxSQXdppv2KBXnRm/ZZSJcwCF4WZLsfhiJlf06yle7pWU5RM9qIrVoGcSH
         ubxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7DDwBGTdd4nF7qHzfkm1pPvcW0M92xBWcYZUXjsI9lZ1yAHi3ArAXyBfCutPD2Ku09PaJOjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Uhuj4n7waHtYs+03MATDWdMxjiPEomPevX1prHlArDRc2E58
	h66N9b3W95sNJtPAMWFrV+QWe4sRxYs92iGCsKNkUkETUb49hQrwARzQj9zkwU4VFmI=
X-Gm-Gg: AfdE7clNkXfnxXEK1nfizfWGis9Zdn23/06E1r9vqPmcud54637UEbn1rUHQeR+OREM
	ipFC9/Vp08M/yxtJCYLIsCauDKNaM+6RB/FeqPa8GNUWjSlnsaQhH1x9Yl5IJo0oltYEAbYH7UB
	6QixR8THkPAiMN9Q+jOhJ84dXERgrhtwWf5osUqGYJj71CHgQRa3vNw4S/DuGtdSZVTwafq3Wpa
	UwGNXixeiZEtBlPE4Vzuxc2FFbFR4A++H65u4DpCm/naitwB7emPcOTPhqGnfz/qQ8NtWYyzYny
	45vI2bjUwx3r6KzirsyXyoJg6KOnHX90OXto0N2QNbVUrDw3tb4B9wMAqkJFFiqRWcDMcD6dkah
	oRXhnSZ2K7oNSeNuJ8inS8dk7T+V14uK+vSkexuN1Re1+pYFN1g==
X-Received: by 2002:a05:622a:2c4:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-51e42494334mr105321611cf.59.1784212058599;
        Thu, 16 Jul 2026 07:27:38 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51fca094208sm11946681cf.10.2026.07.16.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:27:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkN3p-00000002WW2-0fBf;
	Thu, 16 Jul 2026 11:27:37 -0300
Date: Thu, 16 Jul 2026 11:27:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
Message-ID: <20260716142737.GC210048@ziepe.ca>
References: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716053554.1642374-1-baolu.lu@linux.intel.com>

On Thu, Jul 16, 2026 at 01:35:53PM +0800, Lu Baolu wrote:
> Hardware implementations report Scalable-Mode Page-walk Coherency Support
> via the SMPWCS field in the extended capability register. If the hardware
> does not support page-walk coherency, a clflush is required every time
> the page table entries (which are walked by the IOMMU hardware) are
> updated.
> 
> In the SVA case, page tables are managed by the CPU mm core, not by the
> IOMMU driver. Because the IOMMU driver has no way of knowing whether the
> CPU page table management code has ensured coherency via clflush, the
> driver must deny SVA if the hardware does not support coherent paging.
> 
> Fixes: ff3dc6521f78 ("iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
