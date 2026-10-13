Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0054FC329;
	Tue, 13 Oct 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901560; cv=none; b=KCPGiqiWxiHhLaqOxuSp+AANvmkLy4g95L0meWlXWK5XiPfThPvure2uCmfgR/TLGZzmKGTYNDs9A9WTkEb9QNwpukatTojNeG1CqvjIO5oWRCgIURsqcyv+a6NHITn3G7B9Mwkxb024GFKoT1P/vjNKYQanIJI8eGGuCE4TGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901560; c=relaxed/simple;
	bh=ZRZYZOB9FEwIzXDvuVciZI9sqe7j6gZwgAGNjQ2MD3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRI0hoYr8ZZX71/Cvd73dVHLw2KpXGw+sirmNaAYFbsOVZX+WpscOxXN0LyJE/Vkqr4/R4s+I9HmfJy4S7gRheoej43euSznpQehYlmo9kOfZTITkfgUjlCAgm9DdnalC7TiEQzuX4vIbdW8+mAGqz0slTa2Zg38k97QCC/gVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D200227A8E; Tue, 13 Oct 2026 16:25:55 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:25:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone
 management receive
Message-ID: <20261013142554.GC14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-3-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-3-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 12, 2026 at 04:12:29PM +0200, Andrea Parri wrote:
> Tested over the loop, tcp, rdma and fc transports with a zoned
> null_blk namespace: before this patch, zone reports carried stale bytes
> and a data length larger than NUMD was accepted; with it, reports are
> fully initialized and such a length fails with Data SGL Length Invalid.

Can you wire up the reproduce in blktests?

The change itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

