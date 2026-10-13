Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F99501F49;
	Tue, 13 Oct 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902273; cv=none; b=b0U+CVcaq2lp7TtAVQ0N9awZfawx3D2Be6LEUJLlojH5E9yN8Cbxa2FuhrCnbPDqJSXQ9x3DO0lE9fV+ZmIWY6ImflmkG9K2JNfyrtjOowBItRPIIpEL6iWjx1ouo+abZDLue6tBaYWdJm/BF5DgJjk4ftsOj2qgAEuv9T9E8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902273; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbCI1Y7ijSAcRk6fC37mrPmBvBv/LTd6FbwJwhhHhu9wmWeWBqhfcCY+H3AweiEA/71f6TFuHMUo6gSuzMK799MC2h5YF0XfGrpsDmXGE1F9ZUhKDafU2JQrL9njXljJ0pbF3hg97amrHZ419iWgNnvNtA/Qr5tb2JlMS2ocKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 047B7227A88; Tue, 13 Oct 2026 16:37:49 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:37:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	shinichiro.kawasaki@wdc.com, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: send namespace changed event after namespace is
 fully initialized
Message-ID: <20261013143748.GE15717@lst.de>
References: <20261002070249.338225-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002070249.338225-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

