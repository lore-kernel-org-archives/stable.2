Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710016;
	b=Tl1Ds7tWQgCCvqgH/mDPc/kvMPgq+LsZNkxhNVUY8e0zO/6dGxA8wW5XNiU1e3B4McTy
	 xM1EMBC7X1S2Yu6F9s6VYv26G5wr3ZbrDd8OQcEfvvoZjoA4dlEr1gb2idxs7N95krLSP
	 UADUAitKT/RgLDYVTt9aV5496fBAUB/HH9dD1InT/ezTBIWRDUk74T26xie8IGPpxjKwu
	 IrIP+rIRzSPzyM8m+qhF8WhXXS7ebVr/R78NX7sMI95IUvxFFi9Ovnm/klOwNxtTSCtGy
	 y2qqEqvT8XG+LL/ySobmOtcxRKCfkREJygb9ky40Rfm671+TgnTbYMEbeQFD34n34nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710016;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DASIdY7ozb8QRWdAKjgC8Qe8mgAnSZ4YQR5TtXOmDG8=;
	b=Y5dsdbRvLDu01KZijBpMtgfC+ndkLXseLQlNwUIZMz7iVjD7YwvSiCLErGgYTgtylWKw
	 +QJKmo5ldJgiB5VrViGE992UzeJ9/4vws1gUVcQw3It8ZharOXmnhN5cMC5TlsyrIYkH4
	 1ODajQU79FDLe8ypL3npTpUSkTFmkGB3RNIaT+RRPmeYp+y08J/BgzEAmRXRQ3VhTYIW9
	 lh7QGO+aHzbviMV3DgnJFDeOsLYxdq1gLXDDcufCY3x6+0Lmj7Ww1BWdut6MDVM1fjXNG
	 nWZtyBZM8aoxrDH85lbibpbVv27XsRgDHqoJNfcx39YZqWkGnIIRYjr6etQXsGzLsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VVkgiP4x;
	arc=none smtp.remote-ip=91.218.175.90
Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F66606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77F66606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VVkgiP4x
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1XWvcrbaywo/oaZGKtDEjEZr71lw+5bb33eZFqUboxI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793710013; v=1; x=1794314813;
 b=VVkgiP4xzRv9UgvySsIN6NNxQKs56Z51mdPRm6ffqkW/h++z6vTPj/11Q0HLqZxbxNnBGOC1
 L2OJ4kiSVEbTG6Z5l2P05qx5tmgAaQi9Z/CcZunI8n3YrP1mA6h6I2NM8sMx73xb2oFhIScUkYd
 DmNaW7ZLoyn5d1u7m/I/XvW0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 458b8aa09961ad92;
	Tue, 03 Nov 2026 12:46:53 +0000
X-Mizu-Trace-ID: 458b8aa09961ad92
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 12:46:41 +0000
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Daejun Park <daejun7.park@samsung.com>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <dgc@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Sergey Bashirov <sergeybashirov@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 5/9] xfs: cap the block count of
 xfs_iomap_write_direct() at one extent
Message-ID: <ap5wwux6rmzcq4uf4tj4nnsv7h3sdriolux5h4rqo4evy4tpdm@qj6gfmix4fu7>
References: <20261029-xfs-pnfs-batch-v5-0-ef8d2eafb7fa@samsung.com>
 <20261029-xfs-pnfs-batch-v5-5-ef8d2eafb7fa@samsung.com>
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
In-Reply-To: <20261029-xfs-pnfs-batch-v5-5-ef8d2eafb7fa@samsung.com>

On Thu, Oct 29, 2026 at 11:23:02AM +0900, Daejun Park wrote:
> xfs_iomap_write_direct() reserves blocks for the whole count in an
> unsigned int. For a pNFS layout the client chooses that count, and an
> RW LAYOUTGET for 16 TiB wraps the reservation and shuts XFS down.
> 
> xfs_bmapi_write() maps at most XFS_MAX_BMBT_EXTLEN blocks here, so cap
> the count at that. nfsd asks again for the rest. The other callers get
> the same mapping as before.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Link: https://lore.kernel.org/r/20261008154017.GO2705364@frogsfrogsfrogs
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20261015060932.GD14035@lst.de
> Suggested-by: Pankaj Raghav <p.raghav@samsung.com>
> Link: https://lore.kernel.org/r/atoImJxtg70XcIjS@quentin
> Fixes: 527851124d10 ("xfs: implement pNFS export operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---

I know Carlos already merged it but:
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

-- 
Pankaj
