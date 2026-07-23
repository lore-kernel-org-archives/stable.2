Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB26386C31
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801423; cv=none; b=HvT58jpDDwS3PIeox7K1BlE/gPe+eOy+Eot5BTovhhwr53napdGlSLeDPYnpzIWkSAh+qq1p50v6ywadXvoWmaSLBj/JMP8lTnTcnoU+Cqed/MXBZTFkWOC9OVGZoA6tmNzY1bNpGePYqrwi32g3GYaDjiJr6WoxFEE+wEJO1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801423; c=relaxed/simple;
	bh=OgOh1aMC0Ggh2RWDPsTe4rcWV8yHbkb2b8Y3VvUJblM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4UYi217HSa6p7cEUJK87E+GZQ2V8sUP509j8hUQiwPlDMFxhqq41m1H+PWSLp+u6BuLu64tFDh6eD175Z5TLu6KkqW6I08ncnCeVCbTFWtMAlll3j9mK65kP0lm3vC2lMthOcH7uuHCGliSG2j/Fn20Faz7fFgMMfDuHOYNoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ8jufCn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ8jufCn"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso5190275e9.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801420; x=1785406220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YAaFtu2QvkIm0fHzAg3ibsbE371CzeySYROtUcBWC0o=;
        b=WQ8jufCn2RC+KZzhJCxkJ1vlYxIiOVbCQk/ihnk1tl3S3d/tCLQGGPQ6gUzzmEQ270
         WwKt/uBwLtoYmNx6RLgst1NADNKPkbiKo0AgLMjX39O1EfEG12NGPFFxGvhAY3ofY/ES
         ZP7vwD+BL799l6fS9d35l2azJXEvfIjZbFAIJuzXJZ3npPPTBEoX5fpMBvquwcL9hLzD
         1cSFUuOkrNJ/CnVdJpZG0YOrT0SpLoqpXDYRpiFdFvnWX1cRrGd/g10J4JqWQqpb+oh7
         pB7qttTAudtctWecfWz3Xq7l2+6uFKrYGE9p/tHvwAeT6SmNiHOCTcc17pW7CsQctO/R
         CpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801420; x=1785406220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAaFtu2QvkIm0fHzAg3ibsbE371CzeySYROtUcBWC0o=;
        b=J0LxJZdhqYZeuIct1NeAClWU4YktOQVhduKPHEcTvzaFbfrS7pdT3xUQx40OOQQWoY
         07LxmOKSecNo4bGhqOHy9m2vv+jVmhUFh49jeCXYl9gz7qQZtJ+PnaM72734p9E80eok
         AmzAU54x9p8c/23XfaQ3ebNwxx+blG91YcYPtcPbGACcQJDO3hJm+QIb3Tqtbie+ZNjc
         gndmtO/uo8NEkJyaRCM7a75PO/YfucixWtWUoZ5KAdb6RTNhOLAjSTGMMPcM2WqYu7OZ
         f1yDNszxb2+c5i0Z/ADE6QD47v+ghveVP6GTwwEdJL5/7EojDO2ptCjLsLt1QxPNFEfT
         il2g==
X-Forwarded-Encrypted: i=1; AHgh+Rqs55XN9qbN4K+nlDo2eWeCx/488z9F1j73kxCyRgGovNyabDzmYRmrcNPpeYWzPm44u+G/v9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBN+oniUr5wbkib24KI0EcL8iu4/AK7Bl/Xec2Vj2g9K+BOqyx
	x1qbr/HbxOV2z0wUhNCsertNdcec2XtTwnTGcFu+mUcQ50VSLi0rxLz+
X-Gm-Gg: AR+sD11MaSHD4hXJajhaPeZ85HU/zIkG3E5z9iTM+NNV+nGz92lJmPRhlTL+7UKtI84
	uctFhkb4ivseCiQk0XWGc2V9Zz8s6ptrl1d1mirRFpWz2+eqfzg5FQKlvHYcmb4earkxpXItNfZ
	/5dng/iTbK1ejm0BCdoFvmzBxdOSSHGJBkrhbJXm+apKu/fyC57t9vR0ojCDPmyWMb6QfpY+ZH1
	OPNdawY5T/2L0kxs0V+JBP1F3mLbnJ0sQuRoKmXjUh7q1bgE940/paI5AtwQ9A/+0dWmYINtKgn
	w3IlLSgMwLgyxRK8w1DUQayGJWgkPBUII/MWYQnvKHQePQy8XisCYOAcQv24lNozU/eB2izLnxW
	56OOpR3VmXMwjU3Q8NjOzC7kC8E0ZMUctAuZdA4VncxWFr4NTlVI36HPjT8ZAxdAySx/eBDEeiw
	==
X-Received: by 2002:a05:600c:6012:b0:495:4d2d:82f2 with SMTP id 5b1f17b1804b1-49573d0eb3emr18630985e9.26.1784801419725;
        Thu, 23 Jul 2026 03:10:19 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c7desm322479535e9.7.2026.07.23.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:10:18 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:17:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: James Kim <james010kim@gmail.com>
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org,
	alex.bou9@gmail.com, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2] rapidio: mport_cdev: fix use-after-free in
 dma_req_free()
Message-ID: <amHOFV9I2OFnj-XY@stanley.mountain>
References: <20260615070530.371640-1-james010kim@gmail.com>
 <CAPdMtfdPmmV-d-kT6KfAD_dP9y2Oc-Z7zStMMLRhRXHC+wn2FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPdMtfdPmmV-d-kT6KfAD_dP9y2Oc-Z7zStMMLRhRXHC+wn2FA@mail.gmail.com>

On Wed, Jul 22, 2026 at 09:36:35AM +0900, James Kim wrote:
> Hi,
> 
> This is a gentle ping for this patch, as it has not received any
> feedback for some time.
> 
> I'm CC'ing Dan Carpenter and Andrew Morton for additional visibility,
> as this patch fixes a potential use-after-free in the RapidIO driver.
> 
> Any comments or reviews would be greatly appreciated.
> 
> Thanks,
> James Kim
> 

Yep.  I think this is a real bug and the fix looks correct.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

