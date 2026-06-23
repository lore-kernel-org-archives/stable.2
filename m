Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9C377ED2
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782255239; cv=none; b=Rd5VETDt5fh6QbZBQIW2nLnW+yWvWkDQsLfHrxf5TjtsuLEgLGm8o/xQeysyF8IMWkiUurLubhgBhG03NP5y+0mZta4Or36UuPa0qaJjsQvS4U6QU8gyce1PxgNXWUqODBScGnPIs70nET2lpLGhadENSMsKrsH6VkaXd77iZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782255239; c=relaxed/simple;
	bh=l5xGEwOU5Sa74WwoX1gAb4cWW9N59zGi3t963nAFy/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRQ2dtimlLglrgrVJkk9yF2oEZjsY1DUKlb442iv8hQ8MuDDZ7FfDkZm6d+BhdHeksld6GaeJerlZSvTJD8VBufe4ZrX8/b2rZ9xyeNUrdaUHPpgt9P0XFlBcL6eAnZS1JZ/GlNwVRyMQB3FPOm3kL5MEhnoo3DZD3WMPDEmNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inllvPRh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inllvPRh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4924f8db066so2212625e9.2
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782255236; x=1782860036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl7+6G6mEg9f9+ckJBvnEW32MGFOl9Otf3/P0x9y5MY=;
        b=inllvPRhJqUn/IoxNENrnSTU2xOUduZ7qb97qZD5ie5oQhfvsbdtzHYDVxm0gYwgvb
         VYR0RgYB+bqEQVJhs8OFjRXVbnqzp3wO4dpEtYGtLwzAk0M8vqflLh1uvHYTm0f6eFUH
         +3mOugLCHu4x4Eh9S/kF8eaA2hNkRxvF6LpyYI8DHUCOyCMCKmZ2TifU4Ob+ovVKmbB+
         N19XNAl3xfclJ/DZjrNHLzIP/hAKEg955O3AfhvvvAlh5UrkC6FXkghdZFTMicrYFbMv
         wnyeNuC9tWxFiK0J2DGQL4H0+g0XmVQNBrMaEdVsfFbim8Fd1SJ5oRR0FIhqc+EP07Xh
         cOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782255236; x=1782860036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kl7+6G6mEg9f9+ckJBvnEW32MGFOl9Otf3/P0x9y5MY=;
        b=RjX8roJiCelBwhoDt7pOOyyynXL5EuCajHOHxqNSMyjtrBKy8MYYlADFmPuo83fXhy
         b9Owabv160ESI+fi8RMibCt1XfFVgLlsQTOX2TmuijKoIIXwLI8HJB95fVk+ve/We34Y
         4XkJ8hbWy31UBO7mjqQ9h6Agox467Rx2Nx1W/4AtL10l2aePJ7zJ7SiObxxscesj7UyB
         N6GYt8lU7F+uf3mLowsz+E6liVdKIAFPKmBuDD1qVvc2Qc56B8Y89M0jT/6L1mCwDcsX
         eHGVeMYiL0MF4aXr7MNqeypG8QmcNg/WM+QCxCQyrtDYmpcwe0XI25NKBDSMM1XP6IIf
         2NFA==
X-Forwarded-Encrypted: i=1; AFNElJ+vGprQUGw+j1sZqh+WKB0xhJ90lkqHH0m70Gd0fIVtmz1W/+PXcAv0q3Jtj4rQo91JlnQEClo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMw/AdF84z29vokjX9lcVDfCiiVUdnIuDojbAl/3PeIfkCURot
	o5xwDw3Eisa5BF8Pbv3fmGxWbe85M5iwPgrZo5nvCFsEd+FgxkDDI8Gl
X-Gm-Gg: AfdE7ck7NPgYyywCZFBNSft4HvoAjWVEeFokpfKMlwk8QJhox9DGM6ptqBpirJBzE9/
	gXizh4/3NfryLmvbermVWn7Z7ftULUmFIUNqPH2W471xY5q0Yo3xBFGoaXkPQSJt65C/XRH30yn
	B5IeAUrI4IEaZALqd297BTfTad6WFARgKPz+AWdWv7L7NroEpDU1HfeU8tb6swSYEDMy9tzGFkU
	S8O1B8b8yxFuOSqYbyT9aTBXBIwpUPUctsYPyofm33PP8qZC3j4yrWsws7xjoz9Q12dYMKdN/Ta
	6jPbxvcJ1fiJriesQ2vtXYcMAmgJLgQOh6u0daFn8w1Kz27LA65/avlHzZ0W2cC7Xy+BHKI/wbn
	RZMWJ3NC1j7QetgpP+u/Jpk1u8Q7ZwZBnWVUmLjC8AV4wjtEOHtOI+w8rSY/JYtlrsSn4oyRf4W
	EIauMTtgAtNRF/cCuJFre4BqFCUZv1dpdTSzx0/nELj61IYLcx7A==
X-Received: by 2002:a05:600c:699b:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-4926113d5camr183865e9.17.1782255236221;
        Tue, 23 Jun 2026 15:53:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm583674705e9.0.2026.06.23.15.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 15:53:54 -0700 (PDT)
Date: Tue, 23 Jun 2026 23:53:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, jmoroni@google.com, kpberry@google.com,
 chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260623235350.6540eaa2@pumpkin>
In-Reply-To: <ajryxMaT5evDUxaq@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
	<20260623015459.1153884-1-xuehaohu@google.com>
	<20260623094446.4a8fc2ed@pumpkin>
	<ajryxMaT5evDUxaq@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 20:55:32 +0000
Pranjal Shrivastava <praan@google.com> wrote:

> On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:
> 
> Hi David,
> 
> > On Tue, 23 Jun 2026 01:54:59 +0000
> > David Hu <xuehaohu@google.com> wrote:
> >   
> > > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > > first entry, resulting in non-page-aligned DMA addresses for all
> > > subsequent entries.  
> > 
> > There is a separate issue of whether this code is even needed at all.
> > Where can transfers over 2G (never mind 4G) actually come from.
> > 
> > The read, write and similar system calls limit transfers to INT_MAX
> > (even on 64bit) and a lot of driver code will need fixing it longer
> > lengths are allowed though.
> > io_uring better enforce the same limits.
> > So the transfers can come directly from userspace.
> > 
> > Not only that but you also need a single physically contiguous buffer.
> > Good luck allocating that!
> > 
> > Now maybe there are some peer-to-peer places where the large buffer
> > is device memory, but they will be unusual and probably need
> > special treatment anyway.
> >   
> 
> I agree that traditional VFS read/write face the MAX_RW_COUNT limit 
> (~2GB), and io_uring has its limits, but I'm a little confused by the
> push to enforce these limits here in the SGL code?
> 
> File I/O seems to be only one side of the picture. In my view, this fix
> is necessary and certainly has a use-case:
> 
> For example, the RDMA subsystem has the capability to import dmabufs [1],
> which gives rise to use cases for dmabuf beyond standard file ops 
> (via VFS/io_uring). 
> 
> In these scenarios, GPU HBM can be exported as dmabufs. With recent GPUs,
> HBM capacity can be in the order of hundreds of GBs [2]. RDMA can employ
> infrastructure like the vfio-dmabuf-exporter [3] or similar dmabuf 
> exporters to frequently move huge blocks of data via P2PDMA.

Ok, that explains where big buffers can come from.
I just wasn't sure.

> If we restrict incoming dmabuf transfers to fit within VFS-centric 
> limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
> it to manage a significantly higher number of memory registrations. By 
> cleanly splitting these massive contiguous device buffers into 
> page-aligned SGL entries, we directly improve the efficiency of P2P 
> transfers and memory registration.

But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affects
a lot of io) when the quotient is always 1.
Splitting into 2G chunks is a lot cheaper.

> Since this change doesn't seem to have a negative impact on standard file
> I/O or break existing VFS constraints, I'm curious why we shouldn't 
> support splitting these >4GB P2P transfers? Am I missing something?

I was only wondering whether it was needed...
It does bring up the question of why the >4GB transfers even need splitting.
But that is another question.

If you want to split large transfers into 4G-PAGE_SIZE blocks
it is probably worth having a quick test that returns 1 for 'small' buffers.

	David

> 
> Thanks,
> Praan
> 
> [1] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/infiniband/core/umem_dmabuf.c#L174 
> [2] https://nvdam.widen.net/s/fdvdqvfvj2/hopper-h200-nvl-product-brief (Table 2-2)
> [3] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/vfio/pci/vfio_pci_dmabuf.c#L297
> 

