Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B646D2B9;
	Wed,  2 Sep 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356069; cv=none; b=UFtSAUYxySmi1fb2SA/YaMm7eYrBbA0xoYYRWNoRULYQLR52j05fw6gKrGQ8GHENBr9O96yv4ohG2Jf9kDUERtJGUiRumwwowKIIqupVErpWfwaNo2Mkk8ioOixKNWjqjzGx/7YjKFxnze5WG0L2Rle94Xte/P0IhRcY1irIQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356069; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbVMz5mOCOc0k/GToMFARvsR23MXBFZ5/tYuc7l9emS8FFP2vhGov+lb/mRtk4WuW/zonGTM+/+pVFRxNHArkq6L2o90lJxq99rGtVm76Bbp1HBKW0fDiOEaeU5ts2LHX1FOzp7hCf+x75yzXv92Przxm2lJ24vu7BTyG3iUl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1EB466732A; Wed,  2 Sep 2026 15:34:21 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:34:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
Message-ID: <20260902133420.GC21167@lst.de>
References: <20260830131105.680566-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830131105.680566-1-hnkz.64@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

