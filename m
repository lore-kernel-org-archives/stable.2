Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030284;
	b=JBFWDHh5KaeVGtZ8/srlYbN/vchHeWMf7JEsV4gzg5VwSgpfab1lxZp9ClGWaUf7/6sx
	 +S8XplqtcIy9eXvrBTvUEkEZFaknL/NfMs+tB9qwEMU/Ek3fCOR4PZfKaz4v/iYwEpHVs
	 h6py/FRX8xnpSMnoktgE7nLaOPxU5v7Y264x7aNGGvrnF9BBPDUt8U/6extlecE4s5gpt
	 A3p03DUgWbV9m1o4g3pE2DtcSsjhdUU5Jw1NztQyP319usSyb3i0xPxy9RQAFefmIOLlz
	 XaYzEbjf2lrE6+oI3Y+Mt/LdH4FTL59t3b70xTJ/lMjt1skDpGzeKXU0RlHEKdGSjQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030284;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vDe8CRpYtfnlmiKQSVOlxcNlMy5T26XfLimRRniHF+0=;
	b=LF2VNBTf1vyy7M7FxEYxI9WpLIvvDS1GMn8gtHm+uZvENmRzG+OeuAe88yqxdSAzIH0d
	 OxSqSs6XiQkpV6eFt7DuBMNyAbS07bv2r7XniUdgTOexedDwsvG7cdSLoY2Me8+zPf8Mg
	 6QbL4ZJWGvGGw3ZV9Ad5wTUTB8e5TLY1mgMrJ5HXH3q3t1ca1w9DC4kyJ/iONcQr6i7l8
	 OKE2UdiKseylVRamvO4WBLz9kD6p7TazRE+q7zyd/5Pm6ohYza4rKpRODaCugN85q4GxG
	 n3ZrHt7tfS2Ql9dzdvm6Llvh43B9GIGYRl9NSegqyV9AaY3QQC0CNunAlUurwZ6zscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfGdENv1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847CF606A31D;
	Mon, 26 Oct 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfGdENv1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1081F01825;
	Mon, 26 Oct 2026 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030284;
	bh=vDe8CRpYtfnlmiKQSVOlxcNlMy5T26XfLimRRniHF+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RfGdENv1KO6WGultc5JBQI30mnFo6lIKcY9IMNm242LLG++yypD0knxji/25b8PHA
	 KWUyeaY+4qcol3KBKeNo/GMw23xHfVVKzB402sfacJYzvNeFe0vZy2sQNkMTR4sBTA
	 aS24MMu0Ia1VzOQuVdZFCc+ZaXidM1CweyLxsyn4wzGVxu8YYpmOW2gjBQ9Z6qCaSb
	 N5LRLymxHHOcSDK0YF1Oa37aZCvH6asL4lEb88PKQ34ncvLwNfAQNWCB9f2nPYsiyM
	 cX9YDggdR5JCxlrTsVUznB2IBeWahvXy3OARhdTDh0GYMww/mQKO50oK7pU4vvBbOz
	 mWdsfHDrHsgeQ==
Date: Mon, 26 Oct 2026 09:58:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, sgogte@purestorage.com, mgurtovoy@nvidia.com,
	israelr@nvidia.com, wagi@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: fix NULL metadata_sgl dereference with T10-PI
Message-ID: <at94ipr6nhBIMBK2@kbusch-mbp>
References: <20261024213737.506824-1-christian.aurichzm@gmail.com>
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
In-Reply-To: <20261024213737.506824-1-christian.aurichzm@gmail.com>

On Sat, Oct 24, 2026 at 06:37:37PM -0300, Christian Aurich Zanettini Martins wrote:
> Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
> and startup") the I/O tag set is allocated before the I/O queues.
> nvme_rdma_init_request() only sets req->metadata_sgl if
> queue->pi_support is set, but pi_support is only set later by
> nvme_rdma_alloc_queue(), so every I/O request is left with a NULL
> metadata_sgl.
> 
> With an RDMA device that supports integrity and a namespace formatted
> with protection information, nvme_rdma_dma_map_req() then dereferences
> the NULL pointer on the first integrity I/O, already during the
> namespace scan when there is more than one I/O queue.
> 
> Queues that a later reconnect adds for the first time have the same
> problem.
> 
> Check queue_idx and the controller's max_integrity_segments instead,
> which is what nvme_rdma_alloc_queue() derives pi_support from.

Thanks, applied to nvme-7.4.
