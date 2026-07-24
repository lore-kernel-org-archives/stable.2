Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAF349CC4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906744; cv=none; b=lJ7l+wdtkkVGEWXlppEQXzDWe1sSxAELYMbIo2P1AZ5XlFtPSpH1A3w/d2trLjRKn1YyxOv3c6IZvdQFGlhx6FxFWyxUgDBE5tCS+PyA7J9+vIt+HM+ewUYqaV3r29WGIBD7FW/Y80Yxqq6wLiEluXU2AifJ52SmMTkhRZwFwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906744; c=relaxed/simple;
	bh=RNXkKFPQ93ogE4JR3suD8/iYTS6/DkqLKIppv5cQ7N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7gVPar/a5Hsur2zYH3pJ7mnIaV0jJvWTkT4QOcxeR05MF24SOL2I98rCp6qGFkq/iapkf6OcbFGCztewB6C5ViFXtTY2DUO3rZ/3PQLR1pmJO6FyG5zmk6QA99DBB5eni6KYNUElXNPy3G1DVp4KTgtXMKMQ/KxrmMBG1vr3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G1T/FNfg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G1T/FNfg"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e7391839cso528309a12.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784906742; x=1785511542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr7PU9QdQLaE9g7OxEq1p1hH6fPGZz9aJy8GzEkv17Y=;
        b=G1T/FNfgj3p7DA9pfyLHnOg+iplyUSL3qq8We9mvc8S9jzMCbgKuZbXjB7U685ktde
         7HQc2iOUVT6uBQijHWtq2Il3ruF716tFI6iL4LECo7FiU4LVV+uCzRstZFUCBhzYmZd0
         1d/iT7boh2GdG/dYsui89lGa/C0xQCD0/g6TrHixAS3XnbWuM+94jxC0yEJeCABFL22+
         xel5SY2rgjG+szN+Z+zynltuOWp2PgxWOmCJZtjqOAHpW4cRP3qU17YkAPZn9Zk6xi7N
         87S/DIDhvJkrxP/BCiHnL9xZljywBxsaHeIQIARtlyT6LgsLgupLwSqzvdd8hQLZ7xP4
         CaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906742; x=1785511542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr7PU9QdQLaE9g7OxEq1p1hH6fPGZz9aJy8GzEkv17Y=;
        b=Z5cdfvowkkVE/FxjnsxbSv486BH5MA7CvtQWJtzSUhFjGjulBO8+a6Hz79I1FKoH7t
         +KgzvO7ozRYxL6Q2jltpfcHSiECkCQxZysJp+AYk2LSkpDhqSZLlIE2BTBuqemQXjva9
         tTaDJNwr5rnK/SEOR1KcGPaH4APBxpgocTFIjA2AGq3Eow4q3pgH1CnYZkTbRQKWwWyX
         X224fneZ4Zq4zoD1R+pfL2DjWFqfGL+6lmZL/qX5NBojjeCfkHacnCGZ1nPj94vM29vA
         fa5GP+5xhRzkIBrw3r3h3UbwZzZFrYE5u8UGxgQrIXlwACaXe/CWls2Lvzopyn24bQtM
         +UUw==
X-Forwarded-Encrypted: i=1; AHgh+RrglI/kUtNr/l2iVRoe//wTFF2Sz3XwTOwjNml4Zod3CUjhU/GrY/Uq92BU2npyuhahLi3Xl6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY97V7bVGZyZBLhX7EfWWvCsUfiB4XkvpMAJkrJ19uHcvYLW+V
	MTmBwhoLoreKFOeQJNjQnvsBhhJgjFJ/NrW91f+cFfnWmXxXowvQgwo4Ly0QmNVRM6k=
X-Gm-Gg: AR+sD13mZ2V8qaCmVfxUSiHaGxDLw3AC2GghnamyC7cvB1YU+xnTFeSDsS7kgkO3ZRT
	Wu7tYXKGuE5sxDExAwCvjKa445w8e8XdBbymVCTjBUfyeMl5Ur0HszlLYPcevCJWwAHqLjhOzlJ
	iL+M9/i3jhZ2Mazgh3+DKtFHq0VVXgW+MtRJR+qMlmBE6ii2/m0ntBEmXhOvkLEnMaOBuyAp29q
	/tL2RsFMw7hi24U+RlSFIesr3Jhx867I3vKz36oLwbIxUA4J3qnpZXBS+RyuFczWsTJAABiqjeY
	Tsq9szIcRnRAd8tYWiewteSyrFGPruH4LWPIr1ccLhLalCopbW5KBl4GUpCw9pwPYZGHbgn7VVS
	wVVS1TX7ROoGN0PHU7KoJBnwrvL9QG7LUkZb69mrhom3P6WFipURQfxy2Q+zsnoM=
X-Received: by 2002:a05:6a21:6b16:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3c44b00772bmr8719542637.17.1784906742420;
        Fri, 24 Jul 2026 08:25:42 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc59434fsm590606eec.24.2026.07.24.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:25:41 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wnHmO-000000002o5-3k7t;
	Fri, 24 Jul 2026 12:25:40 -0300
Date: Fri, 24 Jul 2026 12:25:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, nicolinc@nvidia.com,
	joro@8bytes.org, jpb@kernel.org, catalin.marinas@arm.com,
	yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amOD9GAz0j7wMMij@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <amDEmlcyC3Tfmkel@willie-the-truck>
 <acd85a2a-af1f-4ebf-8370-773338d4fd15@arm.com>
 <amFCQDrEowvL28O_@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amFCQDrEowvL28O_@willie-the-truck>

On Wed, Jul 22, 2026 at 11:20:48PM +0100, Will Deacon wrote:

> > We might block traffic in the process of _explicitly blocking traffic_!?
> > Whoop-de-do, surely?
> 
> Hmm. I have very vague memories that there were some virtualisation (?)
> cases where Jason and Nicolin cared about the type of event that would
> be generated by concurrent DMA (e.g. bad CD vs translation fault) but
> maybe I'm misremembering.

Yeah, it is actually important for that special SVA mm drop/release
case. We need to write a CD that blocks walking but always generates
translation fault.

I'm away from my computer right now, but if sashiko is saying that the
SVA flow that uses EPD generates a racy bad CD then that is a bug that
needs to be fixed. Possibly by ignoring HAFT in the used calculation
for the EPD cases.

We should also try to have a kunit to cover that specific mm drop flow
in the SVA code.

Jason
