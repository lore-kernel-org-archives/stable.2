Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911893;
	b=0Z5SOKFqgsicIyiP+GhhEuJWaSTFdY6lxGFzNt0LOvVA6qBQb+LWcp/ZyZdKI8c65cR7
	 UzsOMWX0q58uJ08zGQ5WkX5nj77SKTHPJ4LM98vh0s8fDuUqBbf69yTsaMbp7QQ8uhims
	 Fcc46fOqRuWIHFNX8BXipay1wfxGaddngrmZOaAcA1OhfyUlPO3DgXldJ0gdlIIg4Tadv
	 SdHnrOdinMZQuwzIeqT2wy4H8U6n7D0iV7YWSvu7TVOb9I7BcotE8/fuf82DWvPt6NH2r
	 L2VTRnDMMddbvc5mNvwu1mDsucJOvod9EBK48uZi8/MTlpuj1Sm4DSC+doEGftgda1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911893;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7202iUUeJFzO7dVxNuLr9HJTalRIPdZN7YVII+M8HyM=;
	b=zM96NvAyXZm6sWgSOkYYqog91GFF6h6G+sIi7pU8ZsqlTR533BOG/BsxWKCgrw2eOx7O
	 hQy+ba5+NCwKuNU0HQnKyme8GP/5EDdr7q8CZ1GRUv9PT3bB+Q38Ucf22w03LY8bHJEkl
	 I7ylLgs85C3u5JY930ej1Q20Rv0AxmscIot6NKas4m2q058FapLfE+/QfWWZ8MwzEc+yB
	 i477+L4Ds1QQ37tMFm8pId+ReK2riQC+okt8Kpz9GpqrwAmf3HERIKQn+X9mqpliOoDib
	 Xu+w34LAJ65jcv/8YgCoQw1frsZSLBwDQ+/UUCYVvUrIYMA5U0rP4hxgS3TJXjIiTdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6HC+ez8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2D606A339;
	Tue, 17 Nov 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6HC+ez8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181B21F000C6;
	Tue, 17 Nov 2026 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911893;
	bh=7202iUUeJFzO7dVxNuLr9HJTalRIPdZN7YVII+M8HyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T6HC+ez8jQSbFFN95ChPYsDxVEDS82+Ommpw8T8CIVFGq7+x0rPemxnxefnoEwWNf
	 VDXXiJv7183eJyklQkSlYSa5lWQc3tROtkbxCeM3X+aF9ifxH0F/Oft3flohPd/uR3
	 UexDyD2A6E5W4fHWcGt/8eN5eUYRJXQ47teQv6GnUEB2GZSsImJYbPiArjUCWwP0bc
	 PYdIcXzrRTfbM5bAWmcGJPHllVK82kiB/jRsd7+ksRrblVMfdyGH5OBuMxKDxcEkMT
	 3Iajo/CMqQaj8uu4FjSVF5R5CLWuZZyglNkGgzqGZhUHf9BXiFqtgwoyiWZd5v1aA2
	 bKitR31QFwV9g==
Date: Tue, 17 Nov 2026 10:38:07 +0000
From: Lee Jones <lee@kernel.org>
To: Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Gary R Hook <gary.hook@amd.com>,
	Philipp Stanner <pstanner@redhat.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/10] dmaengine: ae4dma: Unregister DMA engine in
 ae4_pci_remove()
Message-ID: <20261117103807.GA64850@joneslee-macbookpro.roam.internal>
References: <20261111215349.1983909-1-lee@kernel.org>
 <20261111215349.1983909-3-lee@kernel.org>
 <82163263-ac33-42e9-86d6-9b1cebd287af@amd.com>
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
In-Reply-To: <82163263-ac33-42e9-86d6-9b1cebd287af@amd.com>

On Tue, 17 Nov 2026, Basavaraj Natikar wrote:

> Hi,
> 
> 
> On 11/12/2026 3:22 AM, Lee Jones wrote:
> > [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > ae4_core_init() registers the DMA device and creates the descriptor slab
> > cache via pt_dmaengine_register(), but ae4_pci_remove() never calls
> > pt_dmaengine_unregister(), leaking the descriptor cache and leaving a
> > dangling DMA device registered after device removal.
> > 
> > Export pt_dmaengine_unregister() and call it from ae4_pci_remove().
> > 
> > Fixes: 98f5a4432622 ("dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register")
> > Closes: https://sashiko.dev/#/bug/linux-10d41112-e133-4bc5-8e53-b3e96592c70d
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >   drivers/dma/amd/ae4dma/ae4dma-pci.c     | 1 +
> >   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 1 +
> >   2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> > index 2c63907db228..8712f4f65e28 100644
> > --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
> > +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> > @@ -132,6 +132,7 @@ static void ae4_pci_remove(struct pci_dev *pdev)
> >   {
> >          struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> > 
> > +       pt_dmaengine_unregister(&ae4->pt);
> 
> The cache must remain valid until completion processing is quiesced.
> pt_dmaengine_unregister() currently destroys it before ae4_destroy_work().
> 
> However, merely reversing these calls is insufficient: the existing worker
> loops indefinitely, so cancel_delayed_work_sync() can hang. We need a
> teardown sequence that safely stops DMA/completion activity before
> destroying the descriptor cache.

I'll look into that.  Thank you.

-- 
Lee Jones
