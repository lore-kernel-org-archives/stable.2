Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD1280309;
	Tue,  6 Oct 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305612; cv=none; b=m9lJPeb4xlYlkCMpMsBYDw04qdWJ0cqQ9kumjanInnjuRNjay+uhP+UihTs3OZDtyj2IvTFtWJ4j9t9ltdzbfkgDANA3GMisGXnlly3DLoalQTOF6RZAxJNybJ73tFUVOCkbfARo9II2BFjZh7bRJWK8LKAB9uDe6qLhM/kENOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305612; c=relaxed/simple;
	bh=bq/nac74ebDqycZQ4KMhwjumBYKYIHREL/q7FV1UlN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihccUAw54hBCy5K2rXH67RtpXMCJjC0ilvQiBPunqXhX+IGzANbFEO6V3Qd7Z/Qo+Zde1NaII2MWa1KRmuMswK4phNG1ljPmAQD//PxGXu4K2GNniswfD8RwlCHPyqVGji5tq6y87y8EI5HLfVbAO9uimbWFwUJgApoFV4ZqtD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org; spf=pass smtp.mailfrom=xenproject.org; dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b=GpXwiAbt; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b="GpXwiAbt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=kOlS+lL1hkPrA+M+rforELABkTt5NUaGOO8i1B5fYL8=; b=GpXwiAbtFyf1k/eR8dnrCFI3Nn
	W2cx9MDoU6bHdFiUSJxufc4F+qJB0+P5hJ+xkZ7Xx0OQGcf7noud9pUdrcLINKGBf9mbkfmPihhpS
	SkO6gm9ve4wDfIkRj4z2bshFvSw58sIowSp/JTz51tdBhkjugiMS/1yX+y+NasuYWBFA=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1xE8Pu-0007qv-21;
	Tue, 06 Oct 2026 16:53:26 +0000
Received: from 224.pool85-54-217.dynamic.orange.es ([85.54.217.224] helo=localhost)
	by xenbits.xenproject.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1xE8Pu-00EIBy-0t;
	Tue, 06 Oct 2026 16:53:26 +0000
Date: Tue, 6 Oct 2026 18:53:23 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger@xenproject.org>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [PATCH v2] xen-blkfront: Fix IO race during unplug
Message-ID: <asUng9P2n1duQLrO@Mac.lan>
References: <20261006163411.2583538-1-ross.lagerwall@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006163411.2583538-1-ross.lagerwall@citrix.com>

On Tue, Oct 06, 2026 at 05:34:07PM +0100, Ross Lagerwall wrote:
> During unplug, blkfront stops the hw queues and marks the disk as dead,
> then later during removal calls del_gendisk(). However, IO issued after
> the hw queues are stopped but before the call to del_gendisk() will be
> queued but never handled. This causes del_gendisk() to hang forever
> waiting for the queue refcount to drop to zero.
> 
> This can be reproduced by issuing IO during an artificial delay after
> stopping the hw queues.
> 
> Fix this by simply not stopping the hw queues directly. Marking the disk
> as dead already freezes the queue which prevents new requests being
> added and it synchronously runs the hw queues to clear anything pending.
> If the hw queues are stopped when calling blk_mark_disk_dead(), running
> the hw queues is a no-op and can leave queued requests unprocessed.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Acked-by: Roger Pau Monné <roger@xenproject.org>

Thanks, Roger.
