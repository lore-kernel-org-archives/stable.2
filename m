Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822D38E121;
	Wed, 19 Aug 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118745; cv=none; b=HB+crvUT0TECa99z8MxHJ2Cj0egSvAzTthiNedtqZKAyZ9Lx/VB6m6llkjr3VV0ytF6+4ON3XfQfIZo5MS+bMXL59OeV3QGk4RAoTX46g1eHnDjac1JyK3ZaRKeL3D0ltpiZ9K0+m3Rd6BP/ZT2xRyaswM0yGmuWAhGVKNKfexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118745; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3TVJv5bT/eCt9YfwIWYHrM3tkiWCntV1ws/rupd643j4mxCMaEaNspZvQ/vp0KUNzklKGtjdacvwRpK7dwrgxRAZwKjjxT0FSNvjqKFFvP9Q0ZCSQOsvIotbv5XRkfTJT/iqkFmfo3lhbGEewERhr8dDRlzuEblRPy2yRwm7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2AEA68C7B; Wed, 19 Aug 2026 07:52:19 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:52:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	dlemoal@kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v3] nvme: skip the zoned limits update if the zone info
 query failed
Message-ID: <20260819055219.GC326@lst.de>
References: <20260817175859.2966055-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817175859.2966055-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

