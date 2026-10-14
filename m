Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6251A15C;
	Wed, 14 Oct 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983082; cv=none; b=Shde1nFasXZjqEileL9jefrTFhEtmTHfbsnT0KBKda4xsSg5znKTCvQ1Q4O4DR63QzyLO+D+jGWmvtQ71MJU1BvAKjBwHRt8yPEACf4vijcctL8BEXpXmjXu3hWiu3Owp//3Xw8p93yZw5rxyJ/aliObbHhNrOycKkcxMEsITo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983082; c=relaxed/simple;
	bh=gBjlekfpMc4N91Ydpew9O0OccHaYqyn10sO1zmjnbMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj+f7Xtx7iMsoWBhtqS4mzvmldFKZSfAU7WUufx3j9WQTNhPJfMLpR825PkT0r4gQMjS18DpU3ZCOUxIDoOMTp00KV7ouIglm2aistyDuoZkEIC5q6/uiP8EHkmtHftQguhMPaeVYsm17pfFQkpRQFfxFUBUdM3g0F40Hwi5djE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28EE868C4E; Wed, 14 Oct 2026 15:04:32 +0200 (CEST)
Date: Wed, 14 Oct 2026 15:04:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone
 management receive
Message-ID: <20261014130431.GA15622@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-3-parri.andrea@gmail.com> <20261013142554.GC14759@lst.de> <20261014110001.95212-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014110001.95212-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 14, 2026 at 01:00:00PM +0200, Andrea Parri wrote:
> On Tue, Oct 13, 2026 at 04:25:54PM +0200, Christoph Hellwig wrote:
> > On Mon, Oct 12, 2026 at 04:12:29PM +0200, Andrea Parri wrote:
> > > Tested over the loop, tcp, rdma and fc transports with a zoned
> > > null_blk namespace: before this patch, zone reports carried stale bytes
> > > and a data length larger than NUMD was accepted; with it, reports are
> > > fully initialized and such a length fails with Data SGL Length Invalid.
> > 
> > Can you wire up the reproduce in blktests?
> 
> Sure.  Following Documentation/process/security-bugs.rst I had only
> offered the reproducers on request; since you'd like them in blktests,
> I'll post them to linux-block shortly, unless you'd rather have them
> off-list until the fixes are merged.  One test covers this patch, and
> two more cover the fc and NUMD patches of this series.

I would not consider anything relating nvme except for userspace API
a security issue.  The protocols are clearly not designed for and/or
advertised for untrusted networks.

Just to make it clear, that's not to say we don't want these fixed,
but they are considered robustness fixes and not security issues.

