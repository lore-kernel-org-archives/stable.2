Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE581A6815
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297995; cv=none; b=CPJh4bM95sAPOaGrXTeWQm2Fr6nAzMiLzTMDwbRCfO3IMxk0/PxyhXZUJnSEHgD7bDeGA6rLrMDfqw1OXM9YUyRZcZqnjgLCnIyncL4oLpZ1OV1C/jK+fPp7Gc8xw0JLTD2lIBgtJojzqVUxDWE18H9HTNKU+bWf52im8xY+I4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297995; c=relaxed/simple;
	bh=p1SJzXxY2u9L5GvhpaKSoycutsl+0AYMgIYio8M5mH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EruC3HVKmDpdhGSPhaDZZjPCBG2po9QLzeisaFckz/b0yeT8yPjF/EducjejBGS/8q6L9GR3KR3SgrdBlHYzOVMDooF/ZBbpabYGr/CHDcrz9pL0x+bQ6MBtp3yJaMcHqQ8LtWKFngYw/if1gaL4ToGYV5xf0f7I7Kl1xmNhP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7797A68BEB; Mon,  1 Jun 2026 09:13:11 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:13:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: hexlabsecurity@proton.me
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Greg KH <gregkh@linuxfoundation.org>, sagi@grimberg.me,
	kch@nvidia.com, "bvanassche@acm.org" <bvanassche@acm.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in
 Discovery Get Log Page
Message-ID: <20260601071311.GB7533@lst.de>
References: <Q8CVAA098pa1LIPOSNGvR2qrzqdOBQqRTLK54O4KsGMzSh4IOT2Ucrlv87C0ULvpILYim-FotD-OumzPcjFauZM2iyjJ4tjzaMRsXE7G_3Q=@proton.me> <20260527132353.GB11071@lst.de> <QQhn1zPqAyjwS7XXM_jeFtjpyW7pXcVTGMP38boMl6zWR5ehel-nsdJdksZf0ASO03qt5pX1B5UAnlANuO7KZISSgggAjnjLruly7nAjJ2A=@proton.me> <20260528083537.GA7590@lst.de> <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 04:02:17PM +0000, hexlabsecurity@proton.me wrote:
> Suggested-by: Christoph Hellwig <hch@lst.de>

My only suggestion was for a slight cleanup to the flow, so I don't think
this tag makes sense.

The patch itself looks fine, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>

