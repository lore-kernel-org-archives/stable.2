Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA707336EC0
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231456; cv=none; b=OgO1b910ljFTS/mfQAD9NCqAjiD7kiVaTDUmjMwcTw1Cu2iKC/xD9mse87c5TpUEep/NhmElc+Dz9ubnPew5/12BAA+Tsbu6Sh8AcXOsZ95eBXVsUCC4z8j3MJDUR5n065+aDjf3Cexf/tgbWX1qDyCTakgZyRKqCfvFuAgyS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231456; c=relaxed/simple;
	bh=06y8sZb/aVmdw3hkUbIEltKcjw5Xo9uoz7ulecfx6e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9IG53KMUwZp1i0vYr7FKdV9tLAF5TAVufkup1NkVJM7sDUf0o32FUGCkyo6kfjj+zNeSZ/LeVLiJ0ZqMoLMEsNHWosdY+2C1RYGWs8LRu5fhjkC1/fnb2UONjoC/dSQ826HFjTx8Is/BYRsPUWP0LsHJp4vgY1vrAsZdew6h0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7FHeRYv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7FHeRYv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso59275ad.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784231454; x=1784836254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pPEy0FEptLG0+wnEJxoQBykPLINVwp+l5W/GjXL8Dv4=;
        b=R7FHeRYvVPVoU/PVQH6ba3YaA89Xjy2gc0aUmCRozrwmyEcWGQEcGjXfdzZWw7QH5U
         BJG/A2KPqqxnkjI13LhIhWH57nPsSGCT2Q32HrhDYVWLSoGaIAbAj4iFXbRuJtmcFS+1
         9FAzwLn2j/EhEZZhqHX4gI64WzvZxiJq2LpvjAjRqYrHdSb5Zr9fGc9wAuL2HLodqu9j
         BefJdHAm71efmEcMgluukVb2t/LxVXYWzmJba+67UnBSpebv92IKK82Dz3L8Tupiwyzg
         fz+8GWgWAmpWqT8PuvepDAdgumE/hP/GJagJJVDtmAa1mIOSuLdQrhvLVSTILfUqKZEG
         pGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784231454; x=1784836254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPEy0FEptLG0+wnEJxoQBykPLINVwp+l5W/GjXL8Dv4=;
        b=UowtB6QqT/XE7DgQzqD8IvECREoh7kVqCBu/FtrJ/DQyI8vb7ml15UhOciMuPD2rJv
         WfHVw1ucgSewVmm+m/nkQpi0XWO34deIxJVEKXJ/F0UgYHPK7lFYyOt47XD863fHUKua
         1wX6sd/FcQiYActoFEsuWOCXN11Gasv4JN/MbMV93EKMnGXkiM9IlkhgiMYKCYT2NzWO
         NjRF8FVj+X7uKeocl5SheAtji55xQNAvENPRWyBHFn+NbsW73YizvRfPn4CQTaQOimOS
         kIkKl2cYbpPgW4/mTy3UVD+bpsV9Cz88+ZFOP/dZKakE9vge+GgPsyTGxpUVsT6+jzQI
         4fgA==
X-Forwarded-Encrypted: i=1; AHgh+Roq6P2LDJNpD4fr9HerdMtrkYQ15cMX17VFAh6BdugVWk0a5Vl9Z2I0GS0Vh+YKWjXTb2RzdUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39yk+3LhyV55dGKOH+NjxK+DvGmRwSt3XPxHUVtsfO+bzLxKA
	iBGpv5KWoj6ZGGOrLWRYGjcbXZxzYoyZaTm2cSGu7jkaABQwjQ67IoT0Gp6cKcmkOw==
X-Gm-Gg: AfdE7cnVcK+0IkxEXf/sqMPOr6Dh77EkVqrjskT9pe8usPcbiV0htcGekRBkBIwSLAh
	HHTXsj5ibfzw82jY0Bb9mVaqidqUjFtFmy3UdhyTiXFpB6DFpMi669OCc/XB/+/cDDp6y0TutKl
	eTtWrmWpACVVUzmsept7/lKsmLWxLxwzbytNXZlSfwxn09lSLuaXPtiOx/BXstryvGkLgpox6kw
	e19rnw9rTIMm/nr7dlH/y/qHyjRftJq1zcYG6FIz1bvD3ivOcfW9Lcnb1HSWxCQs/m+0DCTKOaM
	kDXNPglivkqUGZPOBC9z09Rod8wxxs7eNynwQ7O8WmeDVlYyNrqwFGU9IwfAUqTUsxnWmZBa2J9
	knptT/aTenuBDgtBJoE0P+zT1jS7YSXzzlTPL4OGOZ4J+BAfPukZJEjvqjjaBDNnQ7GSwtbB81r
	D8Yvha4WcR18m/ludhN1S1fl+ZZl2vRX+ydu0ujb/TQqhlqFbtAc8/82VR81lsMYe0RTqBqwlc
X-Received: by 2002:a17:903:24c:b0:2ca:e0ff:eaa0 with SMTP id d9443c01a7336-2cf2f74087fmr845355ad.2.1784231453825;
        Thu, 16 Jul 2026 12:50:53 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055cd5esm25047755ad.39.2026.07.16.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:50:53 -0700 (PDT)
Date: Thu, 16 Jul 2026 19:50:49 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
Message-ID: <alk14o48y7lR05Mg@google.com>
References: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260716053554.1642374-1-baolu.lu@linux.intel.com>

On Thu, Jul 16, 2026 at 01:35:53PM +0800, Lu Baolu wrote:
>Hardware implementations report Scalable-Mode Page-walk Coherency Support
>via the SMPWCS field in the extended capability register. If the hardware
>does not support page-walk coherency, a clflush is required every time
>the page table entries (which are walked by the IOMMU hardware) are
>updated.
>
>In the SVA case, page tables are managed by the CPU mm core, not by the
>IOMMU driver. Because the IOMMU driver has no way of knowing whether the
>CPU page table management code has ensured coherency via clflush, the
>driver must deny SVA if the hardware does not support coherent paging.
>
>Fixes: ff3dc6521f78 ("iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks")
>Cc: stable@vger.kernel.org
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---
> drivers/iommu/intel/svm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>index 0636987f03c8..432e35723ce9 100644
>--- a/drivers/iommu/intel/svm.c
>+++ b/drivers/iommu/intel/svm.c
>@@ -27,7 +27,7 @@
>
> void intel_svm_check(struct intel_iommu *iommu)
> {
>-	if (!pasid_supported(iommu))
>+	if (!pasid_supported(iommu) || !ecap_smpwc(iommu->ecap))
> 		return;
>
> 	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
