Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230984;
	b=y5rK9e8rHrC+8lFKcAanE50tuLeFK6z8ctNj0SSOtdyM8zmO+aJ6cPTy/1zb/dpdjOqX
	 AgB3LOqgFOr0+GLyNoiimOupuYv8FIoY4bYrVLpxe/+Ij3iSJEGwpg0V53UPKGUQ/DsJ0
	 mNl37V9zb/hlqeBXfuMyfsUEx/UGEvxqXRoOj5WLUxIYTV1fFMDP4hTrcBR3wft3+rs4e
	 EIT4wPnAC3jIG+6odK4cU6LRsMtn6uKW7iriE/zCAxsI+za830xUpbxoyDKXeCGf5keBs
	 928KSULuJC9RZtrjNrY7Hij2wa4uOdqnmEyGGuk2sosVDO26pNbaKCNZhV/7oS/TIrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230984;
	h=Received:DKIM-Signature:To:Cc:Subject:From:In-Reply-To:Message-ID:
	 References:Date:MIME-Version:Content-Type;
	bh=z4JmJpyrRgzHu+3G8EmT55HXsSsi7vTo1K5T+x6DQvk=;
	b=cmeUj6dx8MsLxMqU1t4ILQc2WrjNGX6VLq6HBbxnjszX74yYJfNEgRKcTCH1O2qykphp
	 sYgR5/R+k7GMx+TjbT/pEGwYCP6eqhvfCoC6qo+kv93LeIEKGeKHcTFhEcNNPHKclnFT/
	 taM6w6N3XSm1lYdBJzHmpNGBmm+1OJN/5V8pybDPr+aZXze+Bi90gZN5xoADRCQHUovCp
	 rvHzOBZlOtoLmjqyNZ2sHIAfdLXhE0FxiCVy2X1ipXMxXwi9d6dk3qeJ+ZP1p0VdfKWNH
	 GUpCywO0THKrZN0H0p1Dv347j3jycC5geBEjneaXeNM5ztZyUl16mjRBFXrRacjU2tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8TkIUNd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C56606A686;
	Sat, 21 Nov 2026 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8TkIUNd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2411F000C0;
	Sat, 21 Nov 2026 03:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230983;
	bh=z4JmJpyrRgzHu+3G8EmT55HXsSsi7vTo1K5T+x6DQvk=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=N8TkIUNdBjoIgoAZXG2QMIJWPYKV4e9UvXLzUikCGzrq/VucMz3oE9+QOlOp+aqpX
	 JyU7p+gM8HwKpLyWoDxI2kg3NdeJ/a1BjOTTp8t/n1QS4nYULZLw9jNVxZom1ucpI3
	 BuMzk6LZUy/X8kQwXoPEfqkWNqUxwsIi60Tae3aCN99szrtI36d7YT/5ishifSV5PP
	 lvaj01d0eBzt9cCRpM3m3KGkeLb/43VU/q0tbcZ5HkQLmyJsN8QMu44HSpOIuYvsqN
	 3zgH7oFatVuXwWP+BLv0+3uAbeg7oD8rVXdCkChR+itHov8j6Zo39MsmHXXEsNnw2H
	 l3ugl9wpLcE6Q==
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@infradead.org>,
  Caleb Sander Mateos <csander@purestorage.com>,  Keith Busch
 <kbusch@kernel.org>,  linux-block@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Kanchan Joshi
 <joshi.k@samsung.com>,  Anuj Gupta <anuj20.g@samsung.com>,
  florence.schadle@ssi.gouv.fr,  frederic.tronel@centralesupelec.fr,
  louis.rilling@irisa.fr
Subject: Re: [PATCH v2] block: bounce user PI when writes may remap
 reference tags
From: "Martin K. Petersen" <mkp@kernel.org>
In-Reply-To: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
Message-ID: <yq133sunac9.fsf@mail.kernel.org>
References: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
Date: Fri, 20 Nov 2026 22:16:22 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain


Zakaria,

> +	/* Reference-tag remapping must operate on a private copy of user PI. */
> +	if (bio_op(bio) == REQ_OP_WRITE &&
> +	    (q->limits.integrity.flags & BLK_INTEGRITY_REF_TAG))
> +		copy = true;
> +

Reviewed-by: Martin K. Petersen <mkp@kernel.org>

-- 
Martin K. Petersen
