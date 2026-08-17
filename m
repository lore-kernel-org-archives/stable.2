Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215273B442B;
	Mon, 17 Aug 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952222; cv=none; b=RZVD3rBe+LZpNlzDAvInf/bV6jb5PztIryQ8JtMmaSmLDn6ScbTG3gfgdNFHXzW4V04W5O7w74qAZ4vcomq1MwpnvIC7LukpmoaBR1d4tKcG4h4B0u4josLmSxpEQ/dy7ME5+ab9YCD+2KzeZLjmBceCbjrfic79nl9vV+bvMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952222; c=relaxed/simple;
	bh=Y5VJtDTcGlpXm+nQYTukDhxm2/aYr+vQaWlYyJfV3UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhVMppeljz4YelXooY/mPJgxy1HGzCSoiIZooRp7y6HsyQVMCMUk73rpdnx83zI+RNR9OGxIpCebZCr5Hb8v/hRiQytbE+8msvLys++ry3Wi5IFT728BLM7jYrZi+zlqkZafGOlVOnyigke+HjEUQ8MEUnNxus4bd6ch6VbMnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FE7068CFE; Mon, 17 Aug 2026 09:36:56 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:36:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure
Message-ID: <20260817073656.GA19508@lst.de>
References: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 13, 2026 at 04:31:07PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
> with match_strdup() before validating the DHHC-1: representation.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, I think the size and structure of nvmf_parse_options helped to
get to this.  If you are interested in a little improvement project
in this area, it would be nice to add a separate helper for the parsing
of each option so that the strdup allocations are limited to that
scope (and don't reuse the p variable used for the token).
