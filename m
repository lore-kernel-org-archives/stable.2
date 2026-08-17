Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563F14AD0D;
	Mon, 17 Aug 2026 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949645; cv=none; b=Qsg1OLg6NUs9V2KpdxSXxZcfySqDMiOqeAKMrpaZnGJ8Vn+sSoluY2yxK5HDguRIQTzXve31r9mv8Ez1hEM8/tSiGpcti/7fLFu+Gx8Qe777uZ3IA8hBn9P2ixrJTF5l4yho/WrP6rFPk6BhZ0fdQWYlZ06RBKRcLAiWR+9X/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949645; c=relaxed/simple;
	bh=zkLMlKqx6UdWmcwGTVffv/zwol7HPmsTt1tGG0dusBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMjykSdbfNpuGIaidzXXdzovLIxqhfNs8DGY6tohQLdm83cyvFlP8KNCcUHE6ud0a+IKDClt8o7leZq9/neKaOmODZ46cu6Uv9fqm48HHhx9pzXmXzW4/k2JgtXT/Sdy+TMP6E7j9+XBwUBezFQKxdkNPY3llTcgBAcA5dmg+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3730468CFE; Mon, 17 Aug 2026 08:53:52 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:53:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
Message-ID: <20260817065352.GA16255@lst.de>
References: <20260816191729.2865523-1-coshi036@gmail.com> <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 17, 2026 at 03:17:22PM +0900, Damien Le Moal wrote:
> On 8/17/26 04:17, Chao Shi wrote:
> > nvme_query_zone_info() returns either a negative errno or a positive
> > NVMe status code, but nvme_update_ns_info_block() only tests for the
> 
> That seems like a bad design of nvme_query_zone_info(). Why not fix it so that
> on error it returns either negative values OR NVMe status code? That would
> avoid the pitfall of the error check that you found.

Because in some case the difference matters, and this thus is a common
pattern in the nvme driver.

