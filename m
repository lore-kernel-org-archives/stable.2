Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF84343D85;
	Wed, 10 Jun 2026 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068313; cv=none; b=Xztph1nykDtANRP4A6bnYDSCUFlrFTBrTKuX3rIHiMlyLGvsJ+3lhkNBmHWvdBTLiSjfEMiVSL0W1pIGgM1Kxg+yuAGZVt/pLh4/t/2yv6VWQ3JpTXffDwVkHe/RUQLz3bzrdRx24XuFWDK60eMTI5AIkM5r7y2aM0Nv1gbsXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068313; c=relaxed/simple;
	bh=w0nJky1C5Kf2ZTd5GGL8XSB7SoINzUVyPTgAQJQ/8rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRpQqHGfP3UDqhD9BdStnSqO8PnPSRpxuRqSBPpsCsgh2D+GbicDAuARcuNogfyYFZt6gfTaqCLpSME7DZXCmgbPR4lZ6zeMQAL+403XrbMn/UXvC39ofEZ8tD9HWmBN6He3baLlSPQgUa3x2184b7sl2nd6dtGKwKHDMgmy26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6F1168BEB; Wed, 10 Jun 2026 07:11:46 +0200 (CEST)
Date: Wed, 10 Jun 2026 07:11:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-apple: Only limit admin queue tag space when
 with Linear SQ is present
Message-ID: <20260610051146.GA559@lst.de>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com> <20260606-prevent-tag-collision-t8015-v1-1-93ccf4eca550@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-1-93ccf4eca550@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 06, 2026 at 09:25:25PM +0800, Nick Chan wrote:
> Apple NVMe controllers require tags of pending commands to not be shared
> across admin and IO queues. However, on Apple A11 without linear SQ, it is
> not possible for either queue to skip over some tags and must go from 0 to
> the configured maximum before wrapping around.
> 
> As a result, in order to prevent tag collision, dynamic tag reservation
> while a command is in-flight becomes necessary. In this context, there is
> no reason to limit the admin queue's tag space, as it is not helpful in
> preventing tag collision.

I'm not really into these Apple specific, but what does
"dynamic tag reservation" mean here?

