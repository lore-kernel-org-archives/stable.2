Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDB47DD77
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356564; cv=none; b=XRmJ8/5Ga5JVo/m0JLW+TfwqEVxc1PHsxywcw3s3wVgh+xsVnaBykrBNV7KKdHqIG6E1IqTuGs7zrLUvpelAiSNXzwyQoLsoBag6FYl7eAyOoEzPmQ0tQ35Om6j/mTbk0dY2F0P/Vq2oTQ/V1ae+DiVDEkFA2Rj8lCALV+GolkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356564; c=relaxed/simple;
	bh=UnVBDT2yMgSQ4ZRWdKz2B29xT09qz00hTJhXeeB15OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bkv9T43lOIMpNYpJCgsKLKZpnv7PcKomukaCqDgP01tCHQL1+lVvaoz9zFAtJr+Y9wvqXzbjf2tkAmYRDaSJjXob7RQO3SYUyh6tYbblkRqHNTtvODcHLPlz8D/RkQ9G+cKTm6IkxJbGKRynIc1pJUwytyuO+hRFIGK1KbGmV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mn9JNnw3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mn9JNnw3"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so24605ad.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788356561; x=1788961361; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZSTpKHWOHnBacMTdwSxpJ9Et4v7FJnMFRqiSvtmfiLI=;
        b=mn9JNnw3spWEPVYQFXIrj7/1uM/ptLAeKAAWoADKjgmKfaM2ixS6rgKCcwSJBjIVi1
         NCIhA2Ihp68mVLeAxNeGtQt9aNX5hFYXHBtG8zW/cgJRUHcd4oj8E7UtW4oEASNq1jRy
         hBL2AjpqOLkpsHbEsVquVQBh7zLEj8RE3aA96ah9oDSrGwqE9DgwCjph8ZGPBbM9rpJe
         kwYRUi7UJIA/Wyh4ZysZM0xDCmLuwJHzL4QVQosxpuF3mA/BZd3E8QQYFpWQPEVpEsX6
         9ir1DFB01i/SQa8XEn88cooEGw6v1R0PjEiY0sF2UPnJRilx/Z8BHUorLz/1bO5TQiom
         xifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356561; x=1788961361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZSTpKHWOHnBacMTdwSxpJ9Et4v7FJnMFRqiSvtmfiLI=;
        b=C2wyt06+zoQvOZwY1ZQMJsv/y+GO01jwIkk44SGuW+eMBbqevYjAPhzVB75gFv8miT
         /Bmr44yZyl3Qzj8rBe2+RSatPo6lhm8huYS208MAGDFvH4pgJz5G8yh/pBCeKKBPtB3u
         rnvQ3ALaV7cOyZjTCbCs9spUugHn8wZEdrwYW+qaqI4l6A+W7FHz2A7T8Flo0NkwYONJ
         bjjxD8Ow3mYy17+BeYrlZ8C+rtMpW84DVfgFdpQBJGPF63HFIfcQgc4esbfdM9Dhtdpb
         PcKPX7efVEG7pEffI79S/GRGs3pWfzGZLl5+kYlffMbmkNBpkz41Ot51wwArbL/+9N5k
         WSQQ==
X-Forwarded-Encrypted: i=1; AKwUvByjZqc+8WQckwiLF+AvYypjEsIHRiHTItLmN/0mEjiMu9vYMTNkwCUcOigIPgp4l5AVm8KpIWM=@vger.kernel.org
X-Gm-Message-State: AFuF++nGr0lvC+B1r2fKD8pfG1xGLYCH9c/4aCNWfMxrjR7ZlrvlFiPE
	NZXkcHnc0M9+qXc1LjP8f+sAOoeDEniRH/G48rj86CsPtiHitx6wOoYN84CkVM7Kww==
X-Gm-Gg: AYBFou3tUIGQv1r2gvVbF7VrK04lsn/6AossALqqg1Z/F2vApuM/qd5JWplu2ka/vT6
	KszKzPDyYC/pNd05nxjVjv0A5IUuoXFB2nk2fgmUHnOe/eJhpwQk6Tr6SDxzkyCIY2mD9+Mvl2C
	lAca1kxMofbbP3QVRYiRw0UHXIqPbVprBLUnDJvbo01299FvFk2NEhtxd1N7SyS/niNVdVFi/nd
	ksez2f//3GoB7N33SZFS6ut6UjBJDWpTu7iqjD3BnC0/eym7M6qt4m8IBS2MHnmhNqr8B+qTAJn
	y1Euo7ls7HQQf5RMbYNzsD0xCxileRjWHO6LwX21GVg3ftx+jxLeoWR7Gs9ZFCJqMB9+fCGldok
	xdQZCAsXc4KObnwsolekTw7P9AQDtJMgAScWmOYY/hZc557K6TckKoUxlNURG7R1NGiDSp6MTZ7
	HcfzZfY4iWjIpxMi8mywPnB8Q2oCkpcUy2Rf9V2teA7rdqrL8cdswcknuyadTuNWLDz3fCT+uDF
	gSr0ZAPDgnIr8+Bqo/xKlkoG5Q=
X-Received: by 2002:a17:903:19e3:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2daf66043c8mr1378505ad.5.1788356560192;
        Wed, 02 Sep 2026 06:42:40 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc003aee2sm1404704b3a.30.2026.09.02.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:42:39 -0700 (PDT)
Date: Wed, 2 Sep 2026 13:42:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Hu <dhu@x6u.co>,
	sumit.semwal@linaro.org, alex@shazbot.org, ankita@nvidia.com,
	chriscli@google.com, david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	jgg@ziepe.ca, jmoroni@google.com, kevin.tian@intel.com,
	kpberry@google.com, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolinc@nvidia.com, sashiko-bot@kernel.org, stable@vger.kernel.org,
	viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <apgnx0pirQ2SUcmY@google.com>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
 <20260902095338.GU24140@unreal>
 <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>

On Wed, Sep 02, 2026 at 12:00:25PM +0200, Christian König wrote:
> On 9/2/26 11:53, Leon Romanovsky wrote:
> > On Wed, Sep 02, 2026 at 10:44:59AM +0200, Christian König wrote:
> >> On 9/2/26 10:32, Leon Romanovsky wrote:
> >>> On Wed, Sep 02, 2026 at 09:56:06AM +0200, Christian König wrote:
> >>>> On 9/2/26 09:39, Leon Romanovsky wrote:
> >>>>> On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
> >>>>>> On 9/1/26 19:08, David Hu wrote:
> >>>>>>> From: David Hu <xuehaohu@google.com>
> >>>>>>>
> >>>>>>> This series address two related issues in scatter-gather mapping,
> >>>>>>> specifically for the MMIO based dma-buf mapping. The fixes ensure
> >>>>>>> sgt mapping is correct, and proper for large MMIO regions.
> >>>>>>>
> >>>>>>> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> >>>>>>> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> >>>>>>> phys vec to sgt)
> >>>>>>> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> >>>>>>>
> >>>>>>> Patch 2 Splits sgl by largest page aligned chunk
> >>>>>>> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> >>>>>>> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
> >>>>>>
> >>>>>> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.
> >>>>>
> >>>>> And this is why so many in the kernel community want to get rid of SG
> >>>>> lists. It would be great if DMA-BUF could also eliminate the need to
> >>>>> convert to an SGL, like Jason proposed.
> >>>>>
> >>>>> The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
> >>>>> which is the one that depends on it.
> >>>>
> >>>> I'm all fine using an array/xarray of dma_addr_t in DMA-buf, just phys_vec is a clear no-go.
> >>>
> >>> You are proposing the same thing as an SGL, just in a different format.
> >>
> >> Yes, because that is the right thing todo as far as I can see.
> >>
> >>> It does not address the issue that dma_addr_t is expected to hold a DMA
> >>> address, while that is not always the case. For example, in the P2P case,
> >>> the addresses are not DMA addresses.
> >>
> >> Yes they are. They must be DMA addresses because that is the only thing the importer needs to do it's DMA.
> > 
> > They can perform DMA, but that still does not make them suitable for the
> > dma_addr_t type. For the PCI_P2PDMA_MAP_BUS_ADDR flow, these addresses
> > follow completely different rules: they are not unmapped, require no cache
> > synchronization, are valid only for peer access, and require separate error
> > handling.
> 
> The PCI_P2PDMA_MAP_BUS_ADDR is not supported by DMA-buf and as far as I can see is a complete dead end.
> 
> > All of this information is lost if only the dma_addr_t is stored.
> 
> Yes and that is fully intentional.
> 
> DMA-buf handles that cleanly on the buffer object level and not like PCI_P2PDMA_MAP_BUS_ADDR as a completely broken design on a per address/page basis.
> 
> Technical background is that the PCI_P2PDMA_MAP_BUS_ADDR approach can only be handled by a very very small subset of HW.
> 

With the rise of accelerators, the P2PDMA_MAP_BUS_ADDR is going to be 
increasingly more common where accelerators directly transfer data to
NICs, storage devices, other accelerators etc. 

With VFIO gaining a DMABUF exporter the use has already spread to RDMA &
NVMe devices (w/ SPDK). In fact, we found these bugs while trying to map
large BAR regions for RDMA.

Thus, it would be great if we could find alignment here. 
AFAICT, I foresee the use of dmabufs to only increase for
PCI_P2PDMA_MAP_BUS_ADDR. IIRC when the network stack moved to net_iovs
to support dmabufs, the SGL became a primary concern and partly the 
reason why we have "unreadable" skbs for memory we can indeed access
if mapped correctly.

Thanks,
Praan
