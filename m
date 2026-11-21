Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220150;
	b=K/ESx849LltVTzlXxjqJQT0khtc/QcWb1h+164RHPv8/KMVyO1XusnghRAVYwLaitTAo
	 lYSK+sWxoJk/nRLNcgoVP75MxI3qIBOG+86d4JgUktVt2BO0n5LQDBGbAAsCmWA5n7fAx
	 hVeuOTag4hr5erm1XFeZiKMCK/wVx//renzoFZxfDCi2XpsCSp+PkaLYqDaTLOqjtxV3R
	 l2s5EXouRVWfpVTgxlyB0IOiWtua0gcaD0+rPAsrXpowcT2ZBgbbPLINx90Sviu+9BYuY
	 pHiLHqki8DGC6IS+bUxXROwdSIqeAHaUcaxbLYy1RYKO4cv4UsUrA9IM8A9xvLEltng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220150;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=RJQyZ905Y2hzaz0uGQvFSdCQuFF9WXD7l2XVXGvoEC5UJJyX/QCdgTIgci3T0sZufs6X
	 PsfQvKbM0Xp9Bdkq4AIHzMNjPGRnnfjAYTNME3yuRXn4Aszo5kItNdGacq6n7HkGWDrRt
	 SmMJ0rUECgDIuJbS1xdyAfmiFZXx+7Sc4+n3KyAhVQydNy3vnXAzruC72fvLKqVkRhMSQ
	 4K2xWFOzqystL5XnPMNgIccqdR9rDizvt24aTmhZtj42Dxmf/uPfn3rbWqzMehJVFCCYc
	 A7jrVRs7StfsfnQRYg5p0s9AiUw+0UXsj3e51WgLWhe2dwhcq4iykA96Qm6gvAkbnsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RWmai70G;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EC606A6A9;
	Sat, 21 Nov 2026 00:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 512EC606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RWmai70G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RWmai70G3+RNrvm1FC4pqG+E+v
	PZMwRIf92iDHgH+5Og71XVk1TNkK8ujUR0OMfE0TlFNuIJfq1/nsF2KesJRGF9fBgy2hpAOSVSiyS
	rzETyWX5vvCRKht/Vv+5+4RtOGIzaz0Dcawd8yvj7sHUJJnBTdiYtcOaeLJvuED7nPGChXcBeM/O+
	dNcweeTHE//gs8f6aHk177Yn9JkcUJBy4eoSofamJE6dqFcfWpxipmTLyJvrNz0tXcpSuYindzLQu
	faUpKNIQWvkT6yig16nNpkplVg/r0kpUzAzcCdMC5yBPgQtfmmIdeBHKLb4jgq0mQCsf76ZOmw2lJ
	7SvtA9rQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUYlb-0000000GUKB-3jZF;
	Sat, 21 Nov 2026 00:15:43 +0000
Date: Fri, 20 Nov 2026 16:15:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr
Subject: Re: [PATCH v2] block: bounce user PI when writes may remap reference
 tags
Message-ID: <awDir_gtJsYf7z2A@infradead.org>
References: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
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
In-Reply-To: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

