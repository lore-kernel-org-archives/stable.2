Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1A4F4758;
	Wed, 14 Oct 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982068; cv=none; b=i4njcv0NXB+0X9W8gB4MwdAtrTdeoMuorgIDWGmvj9pAxdrM4SYXxR2tHC1vRmcPrZkfY5f4UjNhCCFtjUV/M2R+cO22YsRKnltVkQJe+hhbWZ8espDo0n6G8WxUW3YdkzQxbPKZDvbaUI7T2EE6EySwAs8vF7n4BlkczyaR4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982068; c=relaxed/simple;
	bh=l4f8jXXvxpyuMzMQBueD2Ovin05FrHLyIXfZ+jgFwJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJOVu93tPzSUBEcJ1bsGPjKnDK91b3Y2zfFklefvK6iNnCE8NLNgJ1u4bWIRfCsAf71GEo3zTEBBXCm6AO2CGTay2mXJGIgGTMfp7vv1Zx34beIgEmoVcoS9cohRxxYGrNu7S5Pyhdr9Rsd0g7NFxqoxq7Yf+q4dJ4tJUkVoIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfZgzP1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfZgzP1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89A61F00893;
	Wed, 14 Oct 2026 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982035;
	bh=Mj8eaYaIpXG5aOowSDKXmEZblE5fqC4gitnzcNXoRwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lfZgzP1ZzwxxvqLRWp7aN+tlYKAO9q0U8aeBmnO5DFPSx5AbKmtFTooWNWZopjIpr
	 +UmAYGtVVqhUl7sQ1/VMHa6QUlPju6VVK8mkCm0XME/iaNCvnS7kQmfqEJjupm7xcT
	 XbXY89okp9BUPg/GLIOG2lMBO2FedX01FlkOnbahnEfxfVQmUfVriQcS7rkwcCF1id
	 Zkl6pzOr07ZX0JiV4sOweiiG7u7ISm+bjTNw1v9uDINDYAfyqFdEm98fKvTggBOTEm
	 LrMCrtO8CDOHq/dSVMvegJ4LKzn+IiBUFUOMUEkwRzA+932qnLxaj5pSpGipH0huTZ
	 AcIiiiboXFNhg==
Date: Wed, 14 Oct 2026 14:47:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmet: pci-epf: require SGLs to match the command
 data length
Message-ID: <as95z6cPBLnPRgbv@ryzen>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
 <20261012141239.156408-6-parri.andrea@gmail.com>
 <20261013142830.GF14759@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013142830.GF14759@lst.de>

On Tue, Oct 13, 2026 at 04:28:30PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 04:12:32PM +0200, Andrea Parri wrote:
> > The PCI endpoint target sends the host every byte a read command's SGL
> > describes, even when the SGL describes more than the command transfers.
> > The excess is kmalloc() memory the command never wrote, so the host
> > receives stale target memory. Any successful read can do this,
> > including Identify.
> > 
> > nvmet_pci_epf_alloc_iod_data_buf() allocates each segment at the length
> > of its SGL data descriptor, but sets req->transfer_len from
> > iod->data_len, the length the command implies. Once the command
> > completes, nvmet_pci_epf_transfer_iod_data() sends every segment in
> > full. Nothing compares the descriptor lengths with iod->data_len, and
> > the MDTS check only bounds iod->data_len.
> > 
> > Fail the command with Data SGL Length Invalid when the data descriptors
> > do not add up to iod->data_len, before any segment is allocated. The
> > tcp and rdma transports take the data length from the SGL itself, so
> > there most commands already reject a mismatch in
> > nvmet_check_transfer_len(). PRP lists are built from iod->data_len and
> > are unaffected.
> > 
> > Found by code inspection. Build-tested only (x86_64, W=1): no PCI
> > endpoint hardware was available to run it.
> 
> Looks good, although again having this validated on hardware would
> be really useful.
> 

Tested-by: Niklas Cassel <cassel@kernel.org>
