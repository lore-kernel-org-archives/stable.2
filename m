Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BE469855
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852716; cv=none; b=uordP/NqBAZc5WXwzWsyDqkvtwSvgcimiYf0xK73myp/xUBrKFGQXF5gBjm6wg0TOpxlKUT2/vCGGGCVSBYzZ3T+zSxRF9weiA0XRMGcnELrp09dSolJYAKCo1TdonWDM6ZcPB2lVm23gSQ2OYf8ZPrXmEoiqbwu1NXpYwUJ6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852716; c=relaxed/simple;
	bh=wwdvShafnvo79XiHgPJmFHqjZovymbBOZ9lQgVFHZzM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=P/Ux9avp3z5HTrtMQKfPIFPV5EWaVBIUW5SvROCCE4zWvBxuIHYYSnxdgoTmqfKnq8/kCnY+H7vAnJpCUtRhX4jW8IugAoAxURtKxcSbCKHn06Ne3o3JoVFrsVyWIpwg80t2zPYjc4ntl12AD8G9OebwoltYWx6LJ/nqEYvkMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyvIW2Zm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyvIW2Zm"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso3522855a12.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852712; x=1786457512; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vh4jiNB+QM/k1EF3hB6ldYl4nAMV7WkREZGBEOhBpvE=;
        b=OyvIW2ZmDawQ+LxCKqGHK2qEOHQO+b/KCv81pQWJADtneTwgYj54X14SJUgDFgCjGG
         IK3rOAd08r1MD6hwNUWJ9SqWyt00HG0o9zDa/3WWVyMalm06AEuB7CldixqG+Of6ZT12
         97z8mTN8QusSkoI/7IDN8EYQj4nSnVgq1a0F9AGNunoqtoAamnKK7om7fhaBV1WMqFvN
         FXKB80e2lkcoI3X3yoHDUWn0yj3m82IgbkwKZOAvfBNArK/U7j9+bRgvVUhzdfJ56YTE
         oUvX2fMPGc1NpaiYJW++ltJWGyXnHNGlGZ2eXHZSLD0hVSlaAKRRiYfG6wdtcnjO5wba
         FNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852712; x=1786457512;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vh4jiNB+QM/k1EF3hB6ldYl4nAMV7WkREZGBEOhBpvE=;
        b=rL4nbx4mdKfeOcrvZVDRC5Qml4KeDQrkpxIbIKY8EfiI2CbP1HJP+S8p2H5kp82+7Y
         s+MYj86ksVhuz6863g77VXIGECPG4jNtMn3zoJ1hGJqvilP/77ofJJxFSCdqlnWzbYku
         UbPPLInep6eJYny2/fujfmXNOu3eq1OiAl45sxPmwXq2BFQewwtuYJAd2QvC2iPxc/ML
         crfFRQkAbOJNC2ugoI1lNcGhq5OXNuRkIwOUzIMKcxcUa8kAEc5soNfwq8mm+AcpL4a7
         L185B6RvHxhJqHwsgveXl7O8bSmpcjkYi0LUt3dp3dEJbHhOxqw7G4/OIgRPnnTuVign
         JgAA==
X-Forwarded-Encrypted: i=1; AHgh+RpNas6D0mw9wDGS9jxR9MLGTukGPPZ+eqEDoGopNxzROc7xvA9xsv+lgYeWAFriu2oDeTx8Mlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92izVYgTW75FFSfhpzPubzRXBjqkqhnlUhikg7dqcjpLIKJNP
	EpO4kOagfoQW1lzuhM9nTfqUV7WgJ0OifbE5AHJnzNmHqTt+pVplQvwH8/af3A==
X-Gm-Gg: AR+sD11HKBz4n4FEs/BeV+5jV4poLgcKnL1AtGNRDlL8z49ujk7JHy/APw+e5DUALvI
	h/gXPLIbkKr1KnEJmvZediYtE5h0DZe5yBhKTQyG/Sob00juKfyqc9B93m4hvyppAR9MbM5DHIR
	Rfv42mroSkBktH86+5DN3LasucMH66EoGUCHtl97UIXM7srXQZeC++ua0yQL5fymCeW52m6Mvi9
	GQdA4V9r5h7FkFNjdYQKjsZa5OuRgdrmGMXHwld1vG0q6nnXLNEKHJ/7bfYvH8nTxFc7e1tMs7A
	5MEtQ9FPHRd0fTVfwF7bQ/yDDkZj6tGQn8cF9r/o1Mu2K3jf4eag+75R+moiZwQUretMzO/ACQM
	mLQhjIsbKdOhfV92BVa1qymU35dvBeW2ioKMg3SymKzrgDdzWhBlCVB8ppjygXzI2ANSnR3zyV2
	0tzv2f2VGpVcqGClorM0cv89cWgscw94+/nMKBVJiOOxMo3b8zv+8BH0n0OpI=
X-Received: by 2002:a05:6a20:431f:b0:3c3:a1ed:3c36 with SMTP id adf61e73a8af0-3c92a543d11mr13674670637.24.1785852711886;
        Tue, 04 Aug 2026 07:11:51 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm6178315eec.18.2026.08.04.07.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:11:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com, donettom@linux.ibm.com, harshpb@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
In-Reply-To: <db0911c1-0be3-4b8e-be0a-ea02a76cf122@linux.ibm.com>
Date: Tue, 04 Aug 2026 19:36:47 +0530
Message-ID: <33wum13c.ritesh.list@gmail.com>
References: <20260727221437.89644-1-gbatra@linux.ibm.com> <a4r9mf8r.ritesh.list@gmail.com> <db0911c1-0be3-4b8e-be0a-ea02a76cf122@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Gaurav Batra <gbatra@linux.ibm.com> writes:

> Hello Ritesh,
>
<...>
> As you correctly pointed out in the enable_ddw() code, this could lead 
> to EEH if
> pmemory is assigned to the same power-of-2 chunk as (RAM + 16GB pages).
>
> It would be better to set device bus_dma_limit to pseries_ddw_max_ram 
> and *not*
>
> max_ram_pages, which in this case is the size of the DDW.
>
> I will fix this in my next version of the patch.

Sure, thanks for veryfing that claim.

> Please let me know if you have any other concerns. I will incorporate all those changes in the next version of the patch.
>

Nothing else. Otherwise, it looks good.

> Thanks a lot for spending time and checking this code in deep.

No issues. Thanks for fixing it!

-ritesh

