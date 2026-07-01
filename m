Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15408441020
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911128; cv=none; b=tGU3RuCag4fAfaj39IjcpCm8aKYYjK1jHSMT7OEZ3C+8bKU9PbZqJrX8w6P1EE7rAnrQagJ0Ook2udYl4r27jiX6sMG9UhoZxNn0bwcg2bXrvz0OQbg+2cV0izw8324SXuTw2tpBsk02hZjnXpEcM7DuZkkHB9YESh8TGm1X8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911128; c=relaxed/simple;
	bh=fEP9ef/N1AWvi9/oINhLx5eWsJ1F7KP+teA8vEFxCQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/LwkVAem8q2l9TyRxfMiDga+przLHE1G9gn6dIg1GEqErzsE839RIAR8iuimMPQpnKGwTTJp5oUP0bW2DlcUANh/2+D7PQtmUujIO2PrG9ZtJOsbTFh4H2MMjkEmusB3Y90evOyM4xp0ymejMSiSzuKe1ueisJ1r8vllv07mLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ogm0mNw8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ogm0mNw8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so51525e9.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782911125; x=1783515925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gu+E2JdVa1JRknmwyrW0o138XPVwsj6HNCm/db6x0Ac=;
        b=Ogm0mNw8/U4pGjnpu0FRT8tDipaKHqmvkepIN6cGcT98FXnRTr43T6Ut8+lzqqEHfQ
         S9B7BSCq5vHoXM7b06Iqxn8prkhrBL/Oe94jn5g/jU6dTQWmmld3S7Jeb8FB3jtU3sbu
         ISFrwSeleDsYXQ1emggkgEcdGTYUiFOIkjRGKUscNkrrKFALfJ1a+UuCYO0H9/1Nlav3
         tcGt1CUrZhrgSctVlpLyTH8z9l2jKJ2Aofnbj08x6cnRk3b/1nfa2Ca+8Az6+AR/zP/R
         AOaIDJbLp9Mf7qXxjwnT/vHRFq7Jx37e1NaiubI9NdCJGg9lqYlLr0n0KK9j4QUrU6Kz
         bl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911125; x=1783515925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu+E2JdVa1JRknmwyrW0o138XPVwsj6HNCm/db6x0Ac=;
        b=Pq9XnvWB2dFP6GWlmVEs6sjBYrt9A18sLtcjHgGHTb7asylr6NeMgwqgQ97A8uZr43
         AOVeg6nrrYNAGHQZFVTh+l93O3FN909T8ruqfBC2QQXmAw3NR1z5wkOLRiy+18MNnarx
         cTyqpsS6yYoHfkro4p8MkjTZH4I+QLFi7viaKFt5fSHwX4JUV/lcVi9VsZsKln/nLXl+
         pB0kVnuvP+q+O4uWHDRDzDobITON35bFGT6Lcz6bZStoz2DlxmxtGEu5uTsgwr8ueTUL
         nFbY8TA5R1Aj9GXYigLCnfA3II86UnAGmDrHhpeHm+2EAEpHgA+PdbkM/mncddaZAgAL
         QBMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mxP94GwqAVj03qoeOxbKfJ+DsVPyEOpdjxUgmzRG6ZJCZ6kSsIpwwYx90AgQvUKGQET+ssYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2cuYLzRT7ftigfzhw/Xe4Scy+fIXXzke2knqYZH2XUnmKcPv
	vsFpm1JH4+L/H6oyO7m8WZQAbVRNHSk7lBJzhdrUSDl8slYMuaVhPE/YXurcetBnO7yR+ugPUIZ
	HoNMg8Q==
X-Gm-Gg: AfdE7cmsPsnlHaRQHIXPh4te8FnTL0UdYDbMirrOVXX0OntQ4XCz7CPEMyD+Og5SIY1
	bYDLYBhn3FX7ZbaswD8pqg3GlKqOwEYf2JUJ92W8lSopuiTpZ6qjX+lPH9qGzQzJB8EQpV6TFBt
	gnKkiBlvEipo7LV1jht6K1HJ6ojlrcUq3poRl7MO1hdWPlktIBZt5HVXIBDN1I1VSBeAG8cYWz9
	wAetiJq6Gzu4TWqW5AlJpiUMGMe0iYOg0LIzdpytl9L0Tcc7mq48MJA/3D7abIFapWkilBuiM0U
	rxCNF12OQRijxOCgobyFWMhiG8EgyvejqbIM5/j/5MJa5m47/ITlET9BKILvEoGwsgrRC+mie+O
	zpPie9KsVd73w6UZpb2Hr/GYUt/sLmbtaZovmbu46/7C6HxWwG4k2FI8q1WXkheXgcqpOl6OTis
	zKOoooVhmHBXn5BUVumnRPOnbZEu4L7QcpALNFs38FkcQsVqo91X0=
X-Received: by 2002:a05:600c:4b9a:b0:492:203f:a378 with SMTP id 5b1f17b1804b1-493c0bca5e0mr702615e9.8.1782911124942;
        Wed, 01 Jul 2026 06:05:24 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47566743895sm18099701f8f.25.2026.07.01.06.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:05:24 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:05:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, kees@kernel.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akUQj2pa1W-MekgF@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630185942.GF7481@nvidia.com>

On Tue, Jun 30, 2026 at 03:59:42PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 30, 2026 at 03:33:12PM +0000, Mostafa Saleh wrote:
> 
> > For example patch#1 verifies log2size and split and both are read
> > from HW registers. Same for the base address or other addresses as
> > the page tables, they  might be corrupted due to a buggy driver.
> > My point is that, it is really hard to assume that the previous state
> > of registers/STE/page-tables were valid or even consistent, when the
> > kernel crashed and did not transition the state gracefully.
> 
> Sure, and this mechanism is probably not very useful for debugging
> these kinds of errors in the SMMU driver. Oh well, that isn't a common
> source of kernel crashes :)

I hope not! Although memory corruption can happen due to many other
reasons :/

I am not trying to bikeshed, but I wondering if there is a more
reliable way rather than doing archaeology from a panicked kernel
SMMUv3 configuration, as I am worried that will be even harder to
debug if it goes wrong.

>  
> > Similarly for TLBs, the kernel might have panicked in the middle of an
> > unmap or free domain. (not to mention what that means for RPM where
> > a device reset with unknown TLBs)
> 
> TLB is fine. kdump works by carving out a chunk of memory for the
> future crash kernel. When the kernel boots it ignores all the memory
> used by the prior kernel. So DMA can keep running into the old kernels
> memory with no issue. It doesn't matter if the TLBs are inconsistent or
> not.

Ideally if a TLB is to be missed (because of the panic), it should not
point to kdump memory as it is carved-out. However, it is still a leap to
assume that the TLBs are in a good shape as I mentioned with RPM (or
even if the device resets transiently for some reason) it can end up
with garbage in its TLBs.

Thanks,
Mostafa

> 
> Jason
