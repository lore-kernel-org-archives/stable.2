Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D1431A42;
	Mon, 10 Aug 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383838; cv=none; b=OcX9rRySnaHDy6PijmAXkRYk9dzHwwbgaUNZeqxaN2lzHutXm7VTALTdyxWXNyt+gEhaR01r2k3CDmgQrRA1BPGbG2S4ERSoEE+6J0hTWntgm0zjuEWv+wuIBpGwJzreNxZdhsHec7mpeDQP0lGBvr32A8TIMvd7OINrQZc9iKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383838; c=relaxed/simple;
	bh=oX+hz6JPCSPWafRrsPbgV0IU2kXMTNJdcF/d+UPcdOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmG9cSNIoruWH8OBxwfJgWSnJ7V2Wm9ELHIxcsCvzA5q350KGF3i3n6jFLMDUCtGWeFaZyiwemLS6cb3tOlIrTa2IbosGu/xPjmTrc0vFBCqAJrqjOthrdcc26C5cEnwhXRAFeAGcLW0Xgv27ZSbPgz+7Wow0iDKKUYgsNpl1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEN66RmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEN66RmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6C31F000E9;
	Mon, 10 Aug 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786383837;
	bh=8GewiwB3cD2S9Pj1CPghjzYqUEx5Va4tcS488slPahE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEN66RmKw3F66RKHCksMqdMDSst5iEy4V+6tvzBfdkJkxWVjO5OaC4y7bypU1IUk9
	 pSW5bYeDtg6teSWpmbCUOJ9ZalptlbI3oZIVhIF3yVq73jAsUvV6qzrX6jhft3YwrS
	 KA9KxuwL8TdLHTbzAnWpE+9gmhacJQgQUqV93YuEajiKwbJmkMv4Bk+EaaAZRdq5vo
	 Ntjp7+8FQHg10+318e00WtZkP33DkPF7EEUMi2k2f1NVP1048XQ9ICixsCqa6Jmf9F
	 cUen0PjOOv9NqRmdBOS5WowSv8JBOtRn/E4eqSl/4S3L+X9J6rxq/+KiT6StAeEGj/
	 3NywW7E62BVyw==
Date: Mon, 10 Aug 2026 11:43:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yifei Gao <gyf161023@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: pci-epf: put CQ ref on create_cq mapping failure
Message-ID: <anoN25Z3HHIpijuL@kbusch-mbp>
References: <20260804213626.3410403-1-gyf161023@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804213626.3410403-1-gyf161023@gmail.com>

On Tue, Aug 04, 2026 at 09:36:25PM +0000, Yifei Gao wrote:
> nvmet_pci_epf_create_cq() calls nvmet_cq_create(), which takes a
> reference on the controller and installs the completion queue. If the
> subsequent PCI address-space mapping fails or returns a too-small partial
> mapping, the function jumps to err_internal / err_unmap_queue without
> calling nvmet_cq_put(). The matching put in nvmet_pci_epf_delete_cq() is
> gated on NVMET_PCI_EPF_Q_LIVE, which is only set after the mapping
> succeeds, so teardown never releases these references. A remote PCI host
> that drives Create IO CQ commands with a failing PRP1/pci_addr therefore
> leaks the CQ and a controller reference on each attempt.
> 
> Drop the CQ reference on the mapping-failure paths. The err_internal and
> err_unmap_queue labels are only reachable after nvmet_cq_create() has
> succeeded, so this pairs the create/put correctly.

Thanks, applied to nvme-7.3.
