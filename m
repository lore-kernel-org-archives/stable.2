Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6903CEB8A;
	Tue, 13 Oct 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901209; cv=none; b=dVdnu9bnDN/imQBf0NeKy7dkV9+xgvb9gcpimFZqahDmlR8TnPcS3A6LtEeotx42EpbnYS/3c6DY39z8PkS9cqSWpn2ZErIULD4ulreSWREkqK835I9TgFcQdbb2r9Ugh4dFaNW00iIfDM8aCWLpHBqCVdbvM5GhdUQ8DIdPvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901209; c=relaxed/simple;
	bh=NxBdvSRldggecq/rFiqUTEMYXKC+sFJ+J9acL96OkFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DowfF2HbT7xIjciFsMtpPp38YS2d2xUQzSGWjRB5LUuSCojHHS1yO9EG0dck3xiu56U6wZPnrggrgvFzQltt5rfnhgwO+4Wwqg+jgEd5IU//E7M0KDc8ZymWBkJAb0YV0O4YOIKj7r5O2RrCZSHc12mhvB/1/g4SaznxL85mEUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB517227A88; Tue, 13 Oct 2026 16:20:03 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:20:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received
 buffer
Message-ID: <20261013142003.GA14422@lst.de>
References: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)

Maybe we should cut the long trace in the commit log, but the change
itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
