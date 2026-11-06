Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960961;
	b=whzsfQPimkPKu4ErvA0T59EJmh+k8qWfeMFsUGbjp/aePYcCinzDx8wZGicVmbGck+aI
	 d4cdx7A5fdCcf0s7j1yWLWG485eFt/VF2sj5EvyhKTloJMlAnyZOV7RS9e6lRNmzcxt8j
	 4QHqTS/N5SCPclNqxgx6fckrqTPpzFUCxQUacXANZZ3gB6kUHWeLjMLlBWEIGGCHiyCRX
	 lzd5FXMXGYQwS1htQlKJIj952dmQQspt+tR7M3p69JWQUAPJ162VfWHHOIif6d2V2bfNq
	 Eajg4s3BrcL4O7CZzMq8H9Wsvw6r7u0vcj3s84BB82ItJsasIToDbH/eQZyePQueiKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960961;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=JRtwqFrJiTlcH7IlUnfhdcgVF0fHLiXHFqm+d54kneM=;
	b=OOxJ7YgWbwgR5OKepd+vKRsj4Wzlc5FwpxNhGVoCrvvjCQ6B44yN90QyhwuWGX9dxAOh
	 +jNlFyyyfvrNxCUoy6Dcba12Mu4i8xHWzq68QQOClgYLhSh3kvBaqfD3E1gffQGnzZn43
	 ZAISOLjgT1/oyA8qjsROg1Ox6kUzP1ycKFP7mokkQpzgJm+LPP8Gob6RjQEGhcttDS33I
	 97UUbQmN2RMW5aS9Lvi5o2KULyNdiu3sLTv9DWTekvBhrRz4QhbaA8/GFwXrFiXfVw+NB
	 EjaOwSCvwgevtFsg3f96yNeKYUYPzRHCQGVmhiAewe6sd43RmG68/X5uv+3UVo2JcAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E148606A32C;
	Fri,  6 Nov 2026 10:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E148606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42F9D68BEB; Fri,  6 Nov 2026 11:29:16 +0100 (CET)
Date: Fri, 6 Nov 2026 11:29:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	mkp@kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: stop asynchronous event work before ANA
 teardown
Message-ID: <20261106102915.GA5391@lst.de>
References: <20261105114149.970315-1-shunsheng1218@gmail.com>
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
In-Reply-To: <20261105114149.970315-1-shunsheng1218@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 05, 2026 at 07:41:49PM +0800, Yaohan Li wrote:
> NVMe ANA work has several producers, including ANA AER completion,
> namespace scanning and failover processing.
> 
> An AER completion can queue ana_work for an ANA notice and can
> separately queue async_event_work, which sends the AEN uevent and
> submits the next asynchronous event request.  These work items access
> controller-owned state during asynchronous processing.

I think we can cut the commit log after this..

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

