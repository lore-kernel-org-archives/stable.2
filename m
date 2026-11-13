Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600930;
	b=2Gtl6GpE4MVjnjyqLfKyMiCB9a9mCKPO8cxJ3DW2YR9+kpph1cizdFi1JJbqTSujcuyH
	 zR5Fg4ZqSU6oHjX32QQEQOnklasSFrzgV9BljQKJGxOgpSSzjgW+Im4TblN90yohvcuzh
	 vLaylkuiKW0O51nFvPjIXw2ejd3IXSb0JmMRaMVIlJppronyf2M+F10g6I0BhP/saaDPf
	 NRzNbXWyAwtM5jJlbjUyIOGzUMGHjw2I4ePc0a5vblrLTzQ+sZmSOD46ZsvQhQknWAhQQ
	 X/DIqMj8yvXeS0ICwNEIyz9l7cJRv5LTMLHKS5xwLCYXU7uxbzqLNlJb7vXv/Juv9OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=8H+CWUGQzI4Qy2wQthU4p5PCrPJHw0Bm8PIx68UYiVA=;
	b=hP3C2hZgsDH66UhJLirz8MDkjWJ+BjQ20Oyu5SZdaA9IP6XcAQJvqgDM1pbGbeObm6Bz
	 aZDbvIhjI3/Cc2TV6W9pWkbYbo4kJfZgI1wV2puc2rLcp5loZROU9xfwZokO1Wm1PB/go
	 LCsfih0mDgXGujVw+mTxEPXTTxIwy43iViKPyHlkG16ihkNQoR+XA7HROc5SRbnxpYSlx
	 CIj9YRe59AETWin98jYRLPhxx0aYW6tA4uzCfazTmEVWCVyU+r33RsJVH+ZfGa49qovuI
	 CpG6O/0MnXiElmP8Ije5GXmrl4ShHJNxm73mwKBZmeIhI8zHJt1XF4dXYR6JwoQjIlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kiUujirz;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAADF606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAADF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kiUujirz
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91f2b826fe9so15711696d6.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794600929; x=1795205729; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8H+CWUGQzI4Qy2wQthU4p5PCrPJHw0Bm8PIx68UYiVA=;
        b=kiUujirz20XpRSiYsymMzAFUM87+Kx+bTgzJiROSJSS0kLs0/aEad5APBagCWtpIum
         YPRiswGzoJhd+A08tPWUL0lzVf6QIOHZsuCL5JRig+ku2wdiiw/Q8gDbzxLdiRJ4dx4d
         rqx98Yn0yCAE0YOY2gkSlQBPYI6FM2UgjDzDc4q201hjMfh9/G4+2YFO9VFV97Fhdy/u
         F0pR0SmJ6pdp/VCRh67SUUa0C3K3uRWh7jBs7uPJez9fVM/4UdiMYZnaxQK/LHDTqiZL
         +392meILWIIFy+jfp5Asuo0aJyWdSKNJCKUQHWC5Irxj5kWDQ+jtusrFP43FMsjOvgXp
         weXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600929; x=1795205729;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8H+CWUGQzI4Qy2wQthU4p5PCrPJHw0Bm8PIx68UYiVA=;
        b=2TU8xA2k+yegPqzZPgsKTBMlU2KdWR9xn71++VjaMh1NyXSM3mSR23yHSrTa9FOmM7
         TtIpdGbTKwSalK8EoJofU63CdY4lRizOmaUXlYxUPh7XHpzx2wfyBRGPOD0IY5Xl/7+i
         wmyL/UFGsX2udaaYtDRbphN0WX9m93BzjDh/f7mJmDHfB7YVC4WxiIBybM3Ld+Awxw4P
         GNavyXpu9BHDcEWUvRY12fwXk7n8ZUpjBKS2juPKM4uhE5YgMWfQ+GagGQcyjRHU9VX7
         vk79N3AZYHrnqnvCXfr9DrsPwmP2ty8WsjuidX2mSHc19snWWGWta9fbSydR2t5UEnDk
         yuOg==
X-Forwarded-Encrypted: i=1; AL+hErGQ0OhD2i8r/SKjSUufJw9/cUe9ExeVtC51Y9dMKq1dd9TmR/62frPkfdtp0HqNYNXfuO+ogsk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1Z/d2etAiq/3pM0nZaMrqlEfqK4r2ddHGis3JUjKZiFiJK3o2
	HPnkFxuyLwxpERnvGVoo55UtEBn1xoZV0oyW3EGVW2gJV3JK7VWIOyuTxIGM0QP0XX7oSNPcFQ5
	juYto
X-Gm-Gg: AYBFou3l1gaYSH+5dBpKWS6yk3ewz8nr0tshhUASiTIvQNEHHfmo3bvCeyj6G55PJg3
	Yqqe6xuH8hTV65lCSzFAJAW8dLw9DxRlASIvG+8JHitGINjU2SA0Yy36cXal5vmBuVCKkgnEVZI
	FD+SZtREHfYNE0yMv0jg+y9zoPhVdQFtrF2bLG9F8DgXGvEkMIukQlIfs9Jx2++6xvBAc9Pm43e
	xiqVgMC6CC+DLes9XNW53T+RFKGv4bko9Jgd56AktqNmslw+bGpffFO/6Wn/COjsBUhqN56GcA3
	s+4FQyKyqGA73ZN6esqFoLunS6VzCx8r/TSqa5s3pGFDA3BLm8GS3vDQSjecrRczBtLBFMJ4dci
	oPZE2V4gqcmwYDImwwQBGwz+gFZx8wVWpogZxRqxVS6QFGgHwDnumFOTJOG900qkHrfEVAgFE8r
	4PlBj69Shx3qvKeaFCe+RbRS+JmeWtwCQZJBOj+MMd1tlHmPLJvDlDs6pPKJUelKBOwv2yLEiFH
	smTJN4UzURU/OqRgyU/oJL9uozM2JAPfOEsn11lA3M1oACBMZr6HcejrX05knOoEJp64B5rOuNz
	YrTzq54soc3UpPiUhpZ0S/sebactCZ3HoFDpHsR5Vbz3YZW8y0FALMoEETvgbGbd6xiF7y0Oi5b
	+YXOm+jh5nTsxKyDaznWGXV27SwjU
X-Received: by 2002:a05:6214:1d2a:b0:91f:17be:7c90 with SMTP id 6a1803df08f44-91f2424c199mr58365016d6.55.1794600928649;
        Fri, 13 Nov 2026 12:15:28 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23da6adfsm27424366d6.36.2026.11.13.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:15:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, jgg@ziepe.ca, 
 leon@kernel.org, akpm@linux-foundation.org, david@kernel.org, 
 kas@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <avdrZ716BHN-JLc6@gremlin>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <avdrZ716BHN-JLc6@gremlin>
Date: Fri, 13 Nov 2026 15:15:27 -0500
Message-Id: <179460092754.482102.6921125310815388864.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-13 19:57 +0000, Lorenzo Stoakes (ARM) wrote:
> On Fri, Nov 13, 2026 at 02:55:36PM -0500, Gregory Price (Meta) wrote:
> > HMM can grant ordinary device write access to a userspace shadow stack.
> > On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> > can be returned with HMM_PFN_WRITE without taking a CPU write fault.
> >
> > Nouveau translates that flag into a writable GPU mapping.
> >
> > Reject shadow-stack VMAs in hmm_vma_walk_test(). Use the existing
> > unsupported-range handling: a requested fault returns -EFAULT, while a
> > snapshot records HMM_PFN_ERROR.
> >
> > Link: https://lore.kernel.org/linux-mm/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
> > Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> > Cc: stable@vger.kernel.org
> > Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> Thanks for doing the HMM side of this, LGTM and:
> 

Fell out of my testing harness when reviewing yours :]

Stuff like this is becoming much lower effort than yesteryear.

> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

thanks!

-- 
~Gregory

