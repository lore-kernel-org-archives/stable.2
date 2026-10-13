Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EA3F9F25;
	Tue, 13 Oct 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901715; cv=none; b=EVL4bDYBxT5/XPrHnitlRvjMOkwvVYad2s37gsDJ8Ciyp4A+YuiW7oBWuf3P7cKpYtQ7j22rbjuTNysez4Og4YG72FR7+N9dxx8owF9aBp5rZVyCD5F9lh2fT7cS5MW1/ZkcQKewJQHBdZNjsBTaSp/wibD2V0ZBwpkhkcg0U8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901715; c=relaxed/simple;
	bh=hxhZDoVnZ5TSX2yFqVgfzfGycY1th3e6f+lJECnx3+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+Pv0k2pAK6RmcXl/IehsyIvF1f+sA+Qs9lflplLOJ0WHIcyqpctPj5ybtWfhsmpkYIu3saKHRTcRq+1X4qV9KnhGdQPeibx22LVy3gV2QgPRw+7rGKIcKoK1iCYnDjvK4EVQy8awrgbRd3zF3zWXiYZqP1OfQiteN9I1RSu05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 170A0227A88; Tue, 13 Oct 2026 16:28:31 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:28:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] nvmet: pci-epf: require SGLs to match the command
 data length
Message-ID: <20261013142830.GF14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-6-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-6-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 12, 2026 at 04:12:32PM +0200, Andrea Parri wrote:
> The PCI endpoint target sends the host every byte a read command's SGL
> describes, even when the SGL describes more than the command transfers.
> The excess is kmalloc() memory the command never wrote, so the host
> receives stale target memory. Any successful read can do this,
> including Identify.
> 
> nvmet_pci_epf_alloc_iod_data_buf() allocates each segment at the length
> of its SGL data descriptor, but sets req->transfer_len from
> iod->data_len, the length the command implies. Once the command
> completes, nvmet_pci_epf_transfer_iod_data() sends every segment in
> full. Nothing compares the descriptor lengths with iod->data_len, and
> the MDTS check only bounds iod->data_len.
> 
> Fail the command with Data SGL Length Invalid when the data descriptors
> do not add up to iod->data_len, before any segment is allocated. The
> tcp and rdma transports take the data length from the SGL itself, so
> there most commands already reject a mismatch in
> nvmet_check_transfer_len(). PRP lists are built from iod->data_len and
> are unaffected.
> 
> Found by code inspection. Build-tested only (x86_64, W=1): no PCI
> endpoint hardware was available to run it.

Looks good, although again having this validated on hardware would
be really useful.

