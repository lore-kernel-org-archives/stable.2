Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93F44E67F;
	Wed,  2 Sep 2026 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345076; cv=none; b=UiEeBdki3swoIZ8iwZiJKvTXHPXIKdu38OCfK063ru7K2VDJIWmAN20HqBAJ9GvfXW6S0rHWG50y1hBx+cHfqMHFS2NlWVKIVeiiD5SpAZo2AcaQ4v1IWAw1FzURvz4GexljXnr10vVAh0n7uVTIj5k5MSLmrIJt47MPMh8m4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345076; c=relaxed/simple;
	bh=rrtrd0IT8TCm+/LtrvZd5MMtsuZoLdXYiqnizgIxvao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTfdpMaaUiV9f+bEZZP6gp87XAay2hPPfQfSQfFgR8jrXcUMEv6F0nn6h7naIwGipADjPM2tdSaezYelX7alAtjsnAyOf6dDrlRIQiMyAmEpuxAkVohsYGZw2vImT6JaUxs/l/mJzpIB2duamd/np4SvYRxSTpneEV+q0AaHNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F097A68BEB; Wed,  2 Sep 2026 12:31:00 +0200 (CEST)
Date: Wed, 2 Sep 2026 12:31:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2 1/3] fs: configfs: add helper to identify configfs
 paths
Message-ID: <20260902103100.GA8095@lst.de>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 19, 2026 at 11:52:26PM +0800, Runyu Xiao wrote:
> Several nvmet paths need to identify configfs-backed resolved paths while
> already running under configfs callbacks. Keep the classification in
> configfs itself so callers can reuse the filesystem-type test instead of
> open-coding string comparisons.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

