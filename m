Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518270;
	b=ve/bhkXN2aYFmnDurom/cRA7uTuU/+sDa8vZnxkNIUghAtl0sWv09wlLzaUxYXtVWgG9
	 6+lDwb2r2s6+ffawSrzfxeZEicsciW3WdOeAbduzvB4Rxol9ZIhVc7U02b22ZVAm2VtEt
	 lR4+SBHvvAe2mVFKjc3skAplNM2QhA+1BzIrynwPNwxjlr6p0L4FU1xGTpmlf/+HdTeUt
	 CKpwEr837if/i917Mt+U9yWvjX1Neap2UoBMJNb3xvdZ3yZHitdAJY4ekMar4I1qWv+Db
	 f6R7W07hWmbAZKdZlyEZ1IEYNrH6YR0AtexLhyVSFjxkCdiLt7+ok3d3usxogx5tpwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518270;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=WeEUHHSAKKSSX6UWTJRRi/HIPz2YfDKRRG8SH80QCKIUWXhg3IvFdq8oDbroW54OGmYP
	 ICdSbBfQ5kR1/2JGYPtI+h9BvErB49Pp/4wQK0rbbhxmZ/kvcbdI/OeF5x4eztSRq4f6i
	 IfdbYO8smj/NxzqPHq+bdk+bfpr6ISxwCDQk0AlVZa0ompwsL7KVTtksF1MuKBgId4i1J
	 tOI+zcswWF+gJvzRqONaQisD9Ls2KI2e9Kw5zBixTM+zlIPjqv6ixkZET7w4FqlVOw0o0
	 fnAc8CCyl7GhPiUg60wufAlsVqpdO/5ujj7sdmKc4Zdky8tJX/7RpMWQbMIjb1B1FtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED0606A321;
	Thu, 12 Nov 2026 21:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69ED0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 322BE68D0E; Thu, 12 Nov 2026 22:17:47 +0100 (CET)
Date: Thu, 12 Nov 2026 22:17:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, hare@suse.de,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-auth: use the parsed offset for the DH-CHAP
 key
Message-ID: <20261112211746.GB11315@lst.de>
References: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn> <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

