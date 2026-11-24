Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534578;
	b=x4v866iTtfLUcWmuC065chGsRHiOasgEcb87jlry5cXUe7cdvfPo/5+whjX7Vc5UGemW
	 ZNBkIHaAdffOhsM1YaiI7qYimuUE8z/BQMGJ5HVQ6WddFzGc9DOEQqOhf+udjy7xuh/FT
	 Ta5VMHQ2XZECZBJedwcf1sV8J4LMYxv1SbYjdIjqTtyb5U9LRU+9hW2UfsytQMeV9tKkq
	 RFy3sEhCQ55nD+IymQavV+MEBQwjtsfR627gfqVa5kuoZPXnwucdKVTp19+4y045i0D5w
	 zYvM82fZRMTvZIrSYJoKo7EKw+fDjEaoz87UUGOlZkaxb3GzO9KzQHoR+VhqasrUMEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pztq+Cm1+ZAP57GA6CuWEqPVZxEOeq25+Hlck3k+Nv8=;
	b=VVfDYezVB+x3rVYR027FtZHaWk8VV5Wgbxf4Csml1R3uKQr1a6xg+QcKoDiIIaO54UtS
	 BWSRXuFlcswV98DkZslBNoxDvrU2ZwoO/nbo2rON8nZh+JgIjnij7keMs+iLf1dbr9hTd
	 nB/Ngj0fGA04Yjtff3sHu1sYZ79HlgRAzqHxt0UrAanx+GH5xfEIXKgpcg5tz9kd7aQ2N
	 CBDyrbEsZUXNsafCcUUgnaUtIjt+lNBimD6AZbtH3VHlng+j3dqicqMAfMe133fB0I9+N
	 BuhF0o/qFqfUXiLuvCm0reXKXDTIrKjuG11R0wn4bj6qgnj4is4lCCwzlOzFvXz0xNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bVPOFHhq;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89FF606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D89FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bVPOFHhq
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-94999a08973so441736585a.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795534577; x=1796139377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pztq+Cm1+ZAP57GA6CuWEqPVZxEOeq25+Hlck3k+Nv8=;
        b=bVPOFHhq10ik9Bk7ROYmgO/NqxnMIXFTolb4IWLCiLnI45QyF+aI22nc4dKApDRJ33
         fkOzWBPwR58km9K00ANe8Xd4L8ZoXuSdk9770GP841FM2prZb3EU4rL+8Bh8FitCLtG5
         3UHMrqz0Tbx+t5Gi4YedcGBlfVoqK4HZfab9MjqST3leBqRmEeuGT9HJxM6n6W3QQsKg
         2vWlhjRt4Ro/Hf0jILpiY545i6lEJPrjbIS7UcxZUIbfPkN8ikOEA/f62gfAM322RA+X
         MNgvdwFKnGfrPzNEWtq3KGXj5Pn6pOyqW6EdH8ro2wvFheUQQaS2Ea7f3BOViCUF7fAg
         M+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534577; x=1796139377;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pztq+Cm1+ZAP57GA6CuWEqPVZxEOeq25+Hlck3k+Nv8=;
        b=VXE9tM20vDGi9PnKbr9gPuFBy3P3Es3Qpr7JGHi2lwjmIRHsHelVU5JEC98IJyQlwJ
         aMlGURFpgVuPCBzlzd/hNavXaFHhwXVeXmW0sqlT4zbCh7Mxaf/KFpZ/VXz24FrbnvPh
         GlQD2tzKVctS7AOAWwEIUOEO/wky17ILij6q8P/I/JELQoxPTa+xzZTSLnUCOAqQyNnC
         hsTw2kW3xe4Yve6/kP5wN1LiTKZoZmSDu1AxsHWNJHNDDjLnAk4T8TnE9F2IRRzl7eC1
         5y0yAk2PU4X6AjrvQktq4FRQHFGGI4k3ceQ/cdLJCKlWrw7x6X3cKfIBPz6ByG/5MVE9
         9rLA==
X-Forwarded-Encrypted: i=1; AL+hErFhK18g7SY3IWfMFK47o+6sCOF+sFNus7Iep6fg478NnOcS19YA9rqq2OXqDxnJ48vC8DWawuc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jS8K4GYxkabbHtugmwhriNstXGmJAF2SQDDJue0kY/R0YB1E7
	8iRsriZ8fwoBQmGpbo/skvFMNFqPJ7VKe2++OQxWNXFzlJ7HYQbl6zEl4qH8meRzjwc=
X-Gm-Gg: AZFdTZeaCra0SG7huJDgJ3X+L1eQ7MBOvLuK+GVZ+swuWS8+P+4Fp4ATLbCoWD7UHD8
	xcawEiFdqpJ8HmiMTzeNGcFO6U/lK4qaXzOheYuWdODmDaWyhgir7co5R+oj8tgDkzRE6lhrhgt
	1pUCO7jxAjUHaCkyPuDmDtoQbZN+ofHrIrZMSt+QraZaIT43CkzbeOT8MJS7K9GYBrJd0Kcunjm
	whh5o9t1J5X0FpVlx7p62v8qQNxwKgKE6b89VL3zxoMTe8isghCJR8/9DH2mkeGC4YiFzT8wnhr
	uaDllqkmDz1oNDGXQGW8+LdyMAbbbbExEL1VhvY/pADU1MlArgF7dhTZ18kra1cuZ81OnV/rWQS
	+T0hgfrrQyLZ7SGfrm/grGDpVwJi77RYZPVfKW33212GctSVSAFDmhesFsijH+aBVxwsCjml0p1
	D5Od/d4+Fc2bGNHG7CzLAsnN5mtg/XFIHi/jc7wzGLXbOItF2zhTKkulvcIJVEXyOKYO5RM+3BK
	vorHjyGuaAwk9yG8LU0QMemRrfhjf4eqwMUYc+F5pKjt+8crZ/bmopXeKFBOIG/Chr/8WzrF+xN
	DunR1A==
X-Received: by 2002:a05:620a:6892:b0:947:7691:7316 with SMTP id af79cd13be357-949bab3d3bemr2564224485a.81.1795534576594;
        Tue, 24 Nov 2026 07:36:16 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb4219c4sm1073980385a.41.2026.11.24.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:36:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVsZ5-00000000WyP-1TgI;
	Tue, 24 Nov 2026 11:36:15 -0400
Date: Tue, 24 Nov 2026 11:36:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Shukai Ni <shukai.ni@kuleuven.be>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH] swiotlb: clear read bounce buffers on confidential guests
Message-ID: <20261124153615.GA114530@ziepe.ca>
References: <CGME20261123205317eucas1p2f96032281e0f5e9f17acc7ec343acced@eucas1p2.samsung.com>
 <20261123205302.1034348-1-shukai.ni@kuleuven.be>
 <42415609-c784-45d4-a79d-ef3cc5e6c3ef@samsung.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42415609-c784-45d4-a79d-ef3cc5e6c3ef@samsung.com>

On Tue, Nov 24, 2026 at 04:17:20PM +0100, Marek Szyprowski wrote:
> Hi!
> 
> CCed Jason and Aneesh.
> 
> On 23.11.2026 21:53, Shukai Ni wrote:
> > On confidential guests (AMD SEV, Intel TDX) all device DMA is bounced
> > through swiotlb, whose pool is shared with and readable by the untrusted
> > host. swiotlb_tbl_map_single() copies the destination buffer's current
> > contents into the bounce buffer at map time even for DMA_FROM_DEVICE. For
> > a reused read buffer that still holds private data, the host can read
> > that data from the bounce buffer before the device overwrites it.
> >
> > For DMA_FROM_DEVICE into a host-shared pool, zero the bounce buffer
> > instead. Zeroing rather than skipping the copy keeps a short read from
> > returning a previous transfer's data.
> >
> > Fixes: ddbd89deb7d3 ("swiotlb: fix info leak with DMA_FROM_DEVICE")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> > Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> > Signed-off-by: Shukai Ni <shukai.ni@kuleuven.be>
> 
> 
> I'm not sure if DMA-mapping or SWIOTLB is the right place for such fixups.
> 
> Drivers should be aware that doing DMA from unsecure device to the given
> secure page might reveal its content to the host or other parties and
> prepare for that (like zeroing that page).

I think given the semantics we have to support partial write we don't
have a choice but to continue them as it is the DMA API.

The driver would have to opt out of partial write support somehow to
trigger this, and in that case it is more of an optimization and
shouldn't be linked to CC.

I'm curious if there is a real issue here with a definitive issue on a
driver or it is just speculation?

Jason
