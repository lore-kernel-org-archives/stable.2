Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194824;
	b=N0YH0GmS6JBSl2OTkNgL8q5Izlopatiob9M3uSmkOakglYpqNfq8mpRcbOJWdxgdWWwO
	 8ZWTJ6bHfrs4sZ6VTE5garUPhIenoi6+/7dGQ9EYU/tLMNc4nHEzAUlZ8QvcyRnihibpP
	 6MZ2r1EGx/bHlOeT/H1/2+2ahcEuuENCkOWW7tBQ2gvriF1ZiAESAWkxD+4Uy3DeZjFWe
	 K3ZI4qRcYnpPSYwLKglK2hxjVvPQHDAhvEenPb0xlcSIs2k6XZvsZlrzdvtPj0HrQsjPx
	 enh6dpxBcA2KASJ5N1LNifQgIM+bMfysl3/t8jI2MoN8zcpNt9DeHhh2UFzWYt2m+ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194824;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=Y4FSJdFJ9FJTRu2HiS/qdhokJ359mTa41Gazn1t58H4=;
	b=gFGlbxLEl/KGHRNK6N0jNMdGT4l654K5g492eoxCNNklhYaaIrGgn3Eq4lvkxBHe7Qy9
	 s6L/5KBKOeQtJIGYe32PuEbcwsG70Wko2YUDBRlOIqs/867E3mYpu3uBIa50y2K2eMfcO
	 RPUW+k7RWH3P6yiwJcc7vqb++FCdEExTLWLKnXkCbxpzt1jpVSk5VDM1KHJ/i5/kueMuU
	 +wOhjhNcfeuRNbfbzh9ONzGE1wJLjJKOQxX2aoBtH5V6JXo63C1w4Ivyr6V29Dmxiuzb5
	 xGB2rQgFj2V0K/xsCmbqwWo5PZ7eUdNwhCUQWVVc78aj6xLreaFlzncybBLBYIaNeSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K1Lihill;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2A606A32A;
	Fri, 20 Nov 2026 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF2A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K1Lihill
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y4FSJdFJ9FJTRu2HiS/qdhokJ359mTa41Gazn1t58H4=; b=K1LihillO3xvKHypPocoMqMNhb
	78cyBGR38TXdZp6RCL1a5hxOvNEhaSQxGJBfUQy3MyhPYoiw55mTtPrl3n6ahwi0Wnb3gP/oNWkZn
	havHp+ZVTMg/zn1VtXZvO9L+yTEERkD4o6WPPDEAiyBNmSUe9FZz218nLDTWu/t5essUqXhw7bZvv
	kMVXhAPEGuh6UBTXx5jEE+LPcwPSEsndZCExjHoa6jtHTCwPFQGaHCtbjVkQ+7PyIsNhD+GS0eUxV
	MpgjHIdvnCcLcQhEAvYijMWgk0uC+SDqDZ2jbCkxlzkvJCmdroVBkwkEZ63R+5OH2eAzqb3khyFNQ
	HJ5lZ1Gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSBB-0000000FdoL-0GwL;
	Fri, 20 Nov 2026 17:13:41 +0000
Date: Fri, 20 Nov 2026 09:13:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zakaria Belkadi <zakaria.belkadi@inria.fr>,
	Christoph Hellwig <hch@infradead.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr,
	stable@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref
 tags are remapped
Message-ID: <awB_xd60To4UawrJ@infradead.org>
References: <awBnB-55HQ54C1x6@infradead.org>
 <20261120162257.498238-1-zakaria.belkadi@inria.fr>
 <awB8OODx0fCFGc5G@kbusch-mbp>
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
In-Reply-To: <awB8OODx0fCFGc5G@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 20, 2026 at 09:58:32AM -0700, Keith Busch wrote:
> > Agreed. I'll keep the PI iterator as ITER_SOURCE. In v2,
> > bio_integrity_map_user() will bounce the user PI buffer for REQ_OP_WRITE
> > when the integrity profile has BLK_INTEGRITY_REF_TAG. That way the
> > block layer can remap the tags in its own copy.
> 
> Can avoid bouncing? I think the remapping flags can be tied to the
> user's reftag check request.
> 
> If BIP_CHECK_REFTAG is set from the user setting IO_INTEGRITY_CHK_REFTAG
> on a write, we can map the PI buffer for writing. The user explicitly
> asked to have the ref tags checked by the device, and partitions require
> remapping them, so they've told the kernel to write to their buffer.

No, the user did not ask for violating the mapping direction.  The
whole remapping thing very much is an internal implementation detail.

We could fine tune based on if we need remapping due to partitions,
if we limited remapping to partitions, but I think Martin last time
voiced an opinion that remapping could also be used to pass in
arbitrary tags (which always felt a bit odd to me).
