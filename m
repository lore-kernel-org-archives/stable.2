Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640459;
	b=KYaiNiAADUA56yQxLlVe+2Nkxtmhl/zqGTPkQf21JUcYO3P5+Msw+glz4xqZ9E+Tgq8d
	 9yWEfxWjYli9jjelmh01LZ31EO3T6ssbxK+Sgd4q/ouTHxli9P195rPLKLSnh3Mo27VNn
	 M1Ga043r/nPlw+TJAxOYXsS9kTFKLWc3XLs8gHSxjBKdiWhZ0mmPz/YRmmuRcprY7OrtP
	 Mgj/yREnLle67WjIluROeXv8ql1foZe34ANTt54ahf2jvc6pXiXVDJhiwhPi/Wl8y1qzP
	 iKkeFW8V7svF6G73HD4u5d7Zsa1oc2M9i2MsDn1Cxe/S99Y7GC4gRw2/QKC4e0ALZ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640459;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VwRipOt2v1Wu+ih94hGyTqjHldEuWpMzFu2G96qaATo=;
	b=vQvpSQsWLJp+RcC0oN9V5tNfYlH7lHPhPyBpEDL8O4J80c9P/6JpHLSS6VF2tnjAJouM
	 o7v+cZqx4S5E48J7uui5r7AXVSg5cD06CYGKuds2fmSIevb+o3FG7IkxCaTAceCbPH4kY
	 mK8RQnSEr2iK6ty4aN/k9zfQr+/BvA0GgFn03GBj6IuiAil6WY7Gnua00gP7IBvrceQ1V
	 deevb0MizHz6pCamhlOjn4YLwKZdA4zCiYeiI//6yUU0lrTb83TiNaefBkvj+wuq7+jdI
	 FXBpD8Q5gf0hp+nUzeehFQK/8spfE0krNtpqJ4kq5AaUBxhxyZvqP7ETiCOiZjanwww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jObjKbD3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2751606A588;
	Mon,  2 Nov 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jObjKbD3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2991F00A16;
	Mon,  2 Nov 2026 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640459;
	bh=VwRipOt2v1Wu+ih94hGyTqjHldEuWpMzFu2G96qaATo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jObjKbD34vnvxMS0T0D0vyB/Pv2KKp0hTIAL3hJxf61hVwja4ydGnk5qaeW/gR1Du
	 g/XZhnzftPadlZ2CaCVFmBjSNGXLUV4RJXQU4EqFyEWVD8bwxKqivbE5iXImTY7uMd
	 ron9vQQWxNoBU8/NQdzeLkOA1Yt1JQN6janbV3g/fktDb44I7JysFhfVRo9HQBRuav
	 qcS+Ded8BMTmA/k890UqA61yiryAwHPPc5edOie6G1L03r7ioqOjHdrRM2L1tHqvJy
	 eDhd4ou2qhP1NGtDTqk2mghyXTOHVKzGirN2lLg/CvbM/LLfrtrhQjaJPFF2MAQes3
	 /CyS5hisUPGxg==
Date: Mon, 2 Nov 2026 10:27:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, sgogte@purestorage.com, hare@kernel.org,
	nilay@linux.ibm.com, wagi@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme-rdma: fix NULL queue->ctrl dereference on
 reconnect
Message-ID: <aujICaAOXU_yx8K7@kbusch-mbp>
References: <20261029141957.2068907-1-christian.aurichzm@gmail.com>
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
In-Reply-To: <20261029141957.2068907-1-christian.aurichzm@gmail.com>

On Thu, Oct 29, 2026 at 11:19:57AM -0300, Christian Aurich Zanettini Martins wrote:
> Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
> and startup"), a reconnect that gets more I/O queues than before grows
> the tag set before the new queues are set up. queue->ctrl is only set
> by nvme_rdma_setup_io_queues(), so I/O submitted in between reaches
> nvme_rdma_queue_rq() on a queue that was never allocated and
> dereferences a NULL queue->ctrl:
> 
>   BUG: kernel NULL pointer dereference, address: 000000000000034c
>   RIP: 0010:nvme_rdma_queue_rq+0x52/0xb90
> 
> Set queue->ctrl for every queue when allocating the controller. Such
> requests are then requeued like on any other queue that is not live.

Thanks, applied to nvme-7.4.
