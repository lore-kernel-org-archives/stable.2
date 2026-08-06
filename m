Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9E3A9D9C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035809; cv=none; b=MM0FUeMaaAs7uu9VobSOSfA3FDm1aZebPd8rU/00kvmF7oiUpcxVthCI+PPgknU6JO+rX0EKQWEdbKafhNoVLGku5A7LYdzvYFo1x8gJCd9hIYMqrKNk5ZQLwVEFxPFWd6b7Hh79QcYV089HvVBzH9bUx5fgI2IjmejDAamPx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035809; c=relaxed/simple;
	bh=wH2Z/7SStNPXHVKuBAna047dlnh8OKumWppmtohqDBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsJXKgd8Jt/YyuobpmRtwN1+h5u5hLoyrMHDlsBjyz/cie8A4OrpfEddUA+KsV5f+PfwaPVMMUoEqepwe0q15mdENTIeBjBermKAh2x+wQimiPuqb6Kyx2e6/z3l9h+nxWvwEtaOqcbeKYP6SXj+f1REjWrMLAUNUf1hZiXBuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VrqJHNGR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VrqJHNGR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8486672f03cso3034432b3a.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786035806; x=1786640606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jTcIYdDJrbFYM8SM/eR5/FInV0ODp6bCP4uR1qvvuCk=;
        b=VrqJHNGRRUoP/msyVxM5mpPdeQqY8og/M7kLPYkdcG45zy74Hyo001nabIAtdc7oJw
         6vnl1+Kgrblow4hzFefbVXqdy3K9PS/Vtp9Uh/sQUWDxiBYU337hp3YeqE3uoafhsyXh
         P7feEkHaE1EWfbTSdedW6ODLSYsdSfgAinn7KkDDQJ8s9XdwQVybCzAye985P45C/3dG
         p1m0CmzVnpuDUmlH+oqW9iKpj0+fuNQalecoj0d+WMUelnq66jjLAYU/ke1iV/SKKeKP
         vVHR/Ara/zOrRjqpRlJWhrhRAmU8qPjZ3a0AKu/IWGb3H7k9bKC2U+tWqaFT0vLHwGQC
         6coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035806; x=1786640606;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTcIYdDJrbFYM8SM/eR5/FInV0ODp6bCP4uR1qvvuCk=;
        b=bsKiGsDGwsspUSz2nbL9Ds1zFgQLrhEuoLyDBza8dixCcBLjRpgttqNAtFEIODK9AZ
         V4Rn+UpM4vr17fBEqOO9sQOiYSS0aViaJLG4pAIxtnyJblZkoYxQNCru57tBCEQCcVlq
         KB6tcJKMAbpjOkt/UijodWw2Z5OTL/w4u18Bs4+mmeXe9zgvJch6tFkDXANS/AhfAloJ
         EM4LSrsHnkF9OIXPaIm80VOKCM6PvdXT6EkvyhqXnEBFhVM7iz46IiukZQClY1dalI9q
         AqrQLm6bOMyXDHPRC5qA6kmgSrcay1MOlLvCxXOIxUpayIkyCh+eyZSGff1h1EDSDWJX
         tA5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrdGoz2pH7jrz5kkM821LdGES5fD8PRq82J+RbeWKQfgkOoTY6pZqe9pPArNtS7iC9Yen5fGwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8MCBeYtTqpOUIUu7XsPAboNyvP2r5X2miNhEpVkoMZ7VWywK
	wjKrJjEBhESpGKQIb0Yz0DZAdb3RAAN+CO7D91K7yFhpyhcrOTZSWUYd72+Ggd1pmS0=
X-Gm-Gg: AR+sD11toudSoujbuU250Zk2j5EUAAK65wXyPBhxDISwsy7ECHK3DCm+hhTK63DZ7pJ
	hxnrdpUl6FAfr5xQ7br0HKq82KY/XxGiPVUrBM8Btdc/6+js9xcut3MWzfeb2nTK1Y7n8v0GRmL
	azkgxTCav7GXtjTt/8UfddzVtOeWJC6nENgvYtPWWNRwM+6PvosKk0BWHrVdtYzc2fGJxZ0UPtZ
	nYBzoqf82p+1AsQ/6cJN8SOjpmAkaN/XoacA6jWZSGxULeMxw+bBRFChbdUrTeWlEvLkdh691+z
	Emp9LKaZbwH2q7zEw3sSCRFz8Zad6LpMhq5D13BLOVfQkSO0+BEcAM3LY3DLeEzhwM5iMMGOo4H
	AMbYUvIxkwXsyovAz85uxpn1DSIsphLvKQTbbTYzk/2M9eIqDCeLWuRf81s9vFFYFQDD/IOvn/1
	aw6tE26m6NVGU/R1cGfgik/hnMdoIdZNvGJFgM8aLtM7uVtfoIzEBtVLf/bL9m1Cwj
X-Received: by 2002:a05:6a00:2ea8:b0:848:4c0c:9482 with SMTP id d2e1a72fcca58-84f2e0cc746mr17400031b3a.35.1786035804907;
        Thu, 06 Aug 2026 10:03:24 -0700 (PDT)
Received: from fedora ([2607:fb91:201f:cebc:3a68:390a:144e:1b87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453bb24csm1745790b3a.24.2026.08.06.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:03:24 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:03:19 -0500
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sj@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	usama.arif@linux.dev, vbabka@kernel.org, jannh@google.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/huge_memory: skip zone device folios in
 madvise_free_huge_pmd()
Message-ID: <anS-V-k61246FkkS@fedora>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-3-gourry@gourry.net>
 <anSOvqN1_Hs190xi@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anSOvqN1_Hs190xi@lucifer>

On Thu, Aug 06, 2026 at 02:59:22PM +0100, Lorenzo Stoakes (ARM) wrote:
> I kinda wish he had some generalised folio handler like:
> 
> 	struct folio_ops {
> 		int (*handle_empty_entry)(void *priv);
> 		int (*handle_normal_folio)(void *priv, struct folio *folio);
> 		int (*handle_softleaf_pte_entry)(void *priv, const pte_t *ptep);
> 		int (*handle_zone_folio)(void *priv, struct folio *folio);
> 		...
> 	};
> 
> Or I don't know an equivalent type of thing, as we keep having these same
> patterns emerge in mm that are duplicated in a million places with slight
> variations... :)
> 
> I wonder if C is expressive enough to get us to something sane though.
> 

This is functionally folio->pgmap except it's not generalized and it
causes us pain :[

I briefly took a forray into moving pgmap to be node-scope, and that
works decently, but first i'm just trying to clena up what i can for
zone device.

Anyway, i get what you're getting at here, and that would be nice.

> > Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> Anyway LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>

many thanks :]
