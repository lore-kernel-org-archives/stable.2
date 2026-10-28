Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199035;
	b=vpEjQzCJ7Wbd1MVVivOyL2mI71MQN1K9jTAoHKQtZBCIQpgu2N06MGMqinsgT6KdcWWl
	 GE/PRrUS09sqFiOGZ/avM1z03wjJ6TGtZvwyV6AMYmUbyeBvVKp/yYUhDraO7liKHlXaR
	 IzDp8FSUZeD+B/dS7SC8IkBOoFESP9qD1/MkK8bCJB/rARJQtP1r5n7UG6pbqX3fTKDaP
	 gyPcBhacCOBr2Oy+gzYOeTWwwzoTrE35j/VWYcBaTXfDM98FYsB8R7cimCRPpZ+dmsB0h
	 4j4Gk1Sf2C/PsMvJPdBMs4mLtJkG7XuM0XtM3In6eTck4fYo3dUDwJoPP3m8RPA1fJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199035;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=v3CdbLOzPFVaMxC5QlxKr1BBsGFx2j92VIZopF8U7/+m/QNuuinSOCc5sxY0s/lspshX
	 Nass9MbzhL0PVn8c6cfm+q+atCKUoiRRdwe2gziPw9gRyMW+QVweXPwSMguOCSJcljX1x
	 GPJ2d7wDlpIRPvwkKdNqTHQTP+KCLvLDHTtH5Rcdg30Tfy6iAsqX5DP1Ek1DHs71mYcv2
	 plCUxpCKj6O5hsdIeOm+PJ3K1cmoqTrLEZ8Q8Rr+Kh6ZgN6o3q+CKkk4NkNY0JjG4IrU6
	 QG6lJskBJ0APLZV95nbXqD9R/k/fg/ZgEDQBun9WphlWcsZiVjru7bDbasdViISqy7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A712606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A712606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAF0F68E0B; Wed, 28 Oct 2026 15:50:29 +0100 (CET)
Date: Wed, 28 Oct 2026 15:50:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: bestswngs@gmail.com
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, xmei5@asu.edu,
	stable@vger.kernel.org, co+e015e82956da641b@bugs.sh
Subject: Re: [PATCH nvme] nvmet-rdma: reject short connection requests
Message-ID: <20261028145027.GB14583@lst.de>
References: <20261016172336.286341-3-bestswngs@gmail.com>
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
In-Reply-To: <20261016172336.286341-3-bestswngs@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

