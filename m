Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195827;
	b=elpD/KJGh3kP3ea6JJlUg+Jq3/XMhDpgYPgdU5bwyur6R21TkmBaFCakze4vu9sOF/GF
	 elA0JfGYHZU8ErB5uxoMG2+dHZ5kS+R2xtvtSpgUbS9Qr0XuWBebSrQHzdy7D1B0n6gIZ
	 5Trcz22jsWK2gniDLaangKTEko1J44Hmv55pLDRl4LGV+143/playGmsH6ycJjD/seHte
	 n4Ch22r1l6sjBqBiE3HXijhQOFnKTluzd6LNW7TzjXXrBqWcwE2/3PsCYnbKc2qfQ3tQt
	 vVRSwXqxwkDWAZl+Id5PWnsod1UDPU13LpKhI+wp7og55qn+r5P8I/lqtHtWddHUv9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195827;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=RiSZPEtb6tphJE9SU16a3toiCyFopTKRl72efvtU7Tg=;
	b=U3IXntXfqW2O29Kzve5tKAYl6uzojk+ARxNLtcK6IAtSuBIYzNScUCMtMm6Wh+N3kbNv
	 T6wGtuBsiqhw82EvPvvhHADOVzxs03B7gRkpyVC/lM+gtcKX3jYhRl+KGSL0C1nnETaom
	 nT0pwfDncjRmlKSlAjwGqGu0xINCDm1ZAy9Buhd8m+k5A7MgIYYb6ZOWS4J3yBRD5NBav
	 SVaXDApCiP0u5qekesmy2Dr2eAFkjlMCtc+NHbuZ5H5/hx5P1hdK8qnMGqkodDQhtLhQd
	 jylEoLyFEcM9ao+m4GqFjb6PClp6nVzuahAqP3ZdulAlH/1x8QtXYnLTKQfAjwjqaTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XGfTxC5x;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C760A2608;
	Fri, 20 Nov 2026 17:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 980C760A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XGfTxC5x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RiSZPEtb6tphJE9SU16a3toiCyFopTKRl72efvtU7Tg=; b=XGfTxC5xz5T4eJl3nCuBYgu0ZS
	1pyHBJHxIHD35pN9mZSvLWOovaFSv9zP20FtSPu5yurcOCAeSQqYqxpbVnacVtklUQPAI6e2HwEaO
	EdwCSIztxLVUbSyYAnHqHXe3FWmaCGz+SPgWcntveaXFv8f3C71OkXFrYLGVbDQBKBxPjdE+0yDM0
	J7CyJASVspDU7RvguKKfnemSySGDDnraQ8xsNV7r87GzQF/ff5Yz5jmmV3ZOFb3XeiS1ZeRoXiXh6
	fLD7PagyVYUGR3UlPkeSBmM1BLPP1co5oxSyr947cB+twxuB4+uGAyNfWJrdk2VwfoZK5+3pzdYl+
	bA3q3+6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSRJ-0000000FhjL-0ieO;
	Fri, 20 Nov 2026 17:30:21 +0000
Date: Fri, 20 Nov 2026 09:30:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zakaria Belkadi <zakaria.belkadi@inria.fr>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr,
	stable@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref
 tags are remapped
Message-ID: <awCDrByZa8XsTXJe@infradead.org>
References: <awBnB-55HQ54C1x6@infradead.org>
 <20261120162257.498238-1-zakaria.belkadi@inria.fr>
 <awB8OODx0fCFGc5G@kbusch-mbp>
 <awB_xd60To4UawrJ@infradead.org>
 <awCCG3FWbMHHvYd5@kbusch-mbp>
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
In-Reply-To: <awCCG3FWbMHHvYd5@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 20, 2026 at 10:23:39AM -0700, Keith Busch wrote:
> > No, the user did not ask for violating the mapping direction.  The
> > whole remapping thing very much is an internal implementation detail
> 
> Okay, fine. But can we skip bouncing and remapping if the flag isn't
> set?

Sure, as long as we make sure that doesn't break anything else.
