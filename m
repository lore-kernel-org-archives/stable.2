Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7251B196;
	Tue, 13 Oct 2026 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906448; cv=none; b=fyBcNpyeEmbNIQRbge19C5YPtP1I4zcbcXVaDrGZ4ginBUMOSsOmQwJOjzUT824Bd8Dd4vV9repMMN2Mibd8aneDnqxv0Vzg8q5cJQ68GzwLNHXO6b4274/jAsfrqQex21NVsGLPr7jCUr944ecdArtFD2dU7gWcYZu0bUxuKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906448; c=relaxed/simple;
	bh=ob7GTIuPVcPIbSLX+C615I3xh+8uhgOZpfkPsBtUX5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuo+H6A2ARk6WKYd5l3gDoA54BbWHCty9rcR9ljrub6i7pugPGbOaOFx/iBqLyX5rWAXcsGX67F6MAxa4jy1lU1Uv/IRY9xVywzZVsd0MRxsAgb3Zm7zzPZNeL4xktrxYcYL0EOxzCiClVjJzzT9CXUuJJChRqetQ9+dxBVJpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miZh4p7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miZh4p7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513F31F000FF;
	Tue, 13 Oct 2026 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906447;
	bh=5KZNzT4r8hymYNyVXxSZkyth4lkx71AbAsXvrU7ChYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=miZh4p7uObohzX7WzJhA+5wxdaxV1bOipgn4upKPIBUdPNu1HQcq2AS35CRJvrcLT
	 4GXp0SJrwh4zKbFYyMnsdOWr1wsHDJd2LkBYXcW7mBk8TMhgDFWbQ7UheE4VBqlijA
	 9Cm62rHqBdIC5vZorRUB9MwsgPrSZCpW8J9oesKjGAvL9XAa65TJODSTDQyOyhKsx/
	 qsWn7RFAgHiSpC0WHJ6RR6gigbbggwBVH3HHyD3wflagEX+fAjTLTc5rdtxqrgbt2m
	 10iU63oZXKqUNmzLIc/IjUkehHTXb5Ip0Z8SvQrTZFr+vADQ4A3zo4V6T/XvHtL6t7
	 2VEMHe7TouRyQ==
Date: Tue, 13 Oct 2026 09:47:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone
 management receive
Message-ID: <as5SjbytODSvl-DQ@kbusch-mbp>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
 <20261012141239.156408-3-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-3-parri.andrea@gmail.com>

On Mon, Oct 12, 2026 at 04:12:29PM +0200, Andrea Parri wrote:
> A Zone Management Receive report returns the full buffer the host asked
> for, but nvmet_bdev_zone_zmgmt_recv_work() writes only the 8-byte
> Number of Zones field and one 64-byte descriptor for each matching zone
> that fits. The 56 reserved header bytes and every descriptor slot past
> the last match keep whatever the buffer held before. A 4096-byte report
> covering a single zone leaves 4024 bytes unwritten.
> 
> The tcp, rdma and fc transports allocate that buffer with sgl_alloc()
> and pci-epf with kmalloc(), none with __GFP_ZERO, and on success each
> sends the whole buffer to the host (nvmet_setup_c2h_data_pdu() for
> tcp), so the host receives old kernel memory from the target.

Thanks, applied to nvme-7.4.

This one looks good on its own independent of the patch series, so I've
applied this one now and will wait for the comments on the remaining
patches to settle before considering the rest.
