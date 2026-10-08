Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402C471409;
	Thu,  8 Oct 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453635; cv=none; b=Cc4mnwkKJ0lXtJlkdsmnmT94QJagygYSSfSUdg222hWVhs3E76UicLcVTLOlVVGlzMA3lWZ2q8UwVfrDF1zP5h+WD4iH/E2GuSAV/CClP5iOqYaEsRzIMQMkW++OCThfJS+S9UijviRizPIexYpHPPHeVykTvF4qQo/xuMBuU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453635; c=relaxed/simple;
	bh=4F+JopRRae1Nw5IoBGN5MbeL8Din53VKKFejTXNihZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlRm4K2FBfOden6+RKEo8XqW3C/JlgU0Bx3off2O5pLl+c4bdPy3pvxcP3Ajz+3l9FDPwPCJJP8R9CHhPGH39JuN1UMqY3hGxhGaXvPpZc2Ep1Zig+maZ3kiLHvcFl2yjfmzBhguRGL8Bi8R3pKvHq9HXn1fpLqgHxktEhyJb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MZ/vxaFf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZ/vxaFf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4F+JopRRae1Nw5IoBGN5MbeL8Din53VKKFejTXNihZI=; b=MZ/vxaFfBUGJepMFN0vZmSTi6o
	vaaoCNZMyiD5dcN2h7O5FT1dOkOpFPIdHUH84tG7b093VAbGQq2CPw+lxYHAgXjZR9tV9+o8rHYMj
	Oa/qMB3h+Q87kxC7JHc6BOgQmRhIKfz402b6l10BMkOPijTdjaGuGvpt31h+oxnMZV1czlPU3Cc9P
	fxPXfijasN62KJ3dsbVyy18w7iX8tbSSMvnBZ5b8CcujSWNgAzPAU2UPLfPXE1IOQEFUzqi0IWd/E
	42ZtgF9YnsrB8J+PeSMpgnSc720X0TdWZOYd6Xz/+dqRoKS6c2K16Ezl+Wcft4+IB1L7PWFNUEXSo
	i0pZBuUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkvR-000000043HR-020k;
	Thu, 08 Oct 2026 10:00:33 +0000
Date: Thu, 8 Oct 2026 03:00:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] aoe: pull in the headers each received packet type reads
Message-ID: <asdpwPEpGFxfLDNz@infradead.org>
References: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can we plus just kill the aoe driver given how buggy both the driver
and the protocol is instead of playing whack-a-mole?

