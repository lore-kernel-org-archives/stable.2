Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD83A838A;
	Fri, 18 Sep 2026 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734683; cv=none; b=NNP3XD0vTbvc0buM7Y0swL5fr9xtYsRpS1ycqHoA9qN1YE28PTrT2guHy6aY4uxCejJy+hW8uki10FiDIGUdG3LVV01M3XhQR/063k8H9bqjPlp0IPez0g/mQcuv1JHYUt3yhFPaKcXR2By5ccqhIGbfEA+FZyEk0394snCqsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734683; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HisQ2LrRuhuPNA5+ZXKg4zCI2qK2mgO+/zYmrjyMvxKJz+mIeHDLoQbsPEpZWbTDLrtJZo5QneMk2hcnKVk23UqrITCEVg4pELxWc0HcmEboXdGs1nCeXaRn9kHvc8C4n+ltasgJZzVPJB5k8A1f/7DoM6O7hm67SR8B6bxWyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06D4D68BEB; Fri, 18 Sep 2026 14:31:15 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:31:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	co+77553a7fc66ac133@bugs.sh, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: fix out-of-bounds write in
 nvmet_auth_challenge()
Message-ID: <20260918123115.GA17110@lst.de>
References: <20260912171009.1513289-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912171009.1513289-3-bestswngs@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

