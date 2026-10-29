Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276182;
	b=dj2ojHOEOWBaRSjigWjZNQEpn+DwNWfAeEFhGATM+QlDn4KlqWAN6ax+uEQn9HLTkPD9
	 OlyQtYXSvZ4Adkf7K8vbxi728MKjLckfZOLwcfpxjGu7WA/zwb3ZOkGcgNpBH6KWt6v/9
	 HEhV30WUS+e6+ohwhJqGuKukM7RLjB6dBIBqeIYspMX5OLhPfoUCeUBRrCxa0Yd5Qiih+
	 MWifjjg/ThrDhXRbf97g8kHAj8k7XQ7id6qQ2HGT/wxon0ZK4zbKZDIqQHZXRz9f0pBCJ
	 poHzNh/WOGM/E/BhY0x6we1QhI2d/eiAARm0g00RlGTgaPQ1XCj9R+eerd9TkkK2xXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276182;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=OOEOujoQLjSnEQBW3lyjWkE1Op5wOMsI1h8MP2w4oRpC2+dUoZ2t7BnzAghgbz5k72dj
	 v/IriEwxDti84Da6Nm1Ag2AdNZQJaB7FxpQWA5funsbMeLptrzkg6rNkxqPWiyFdZg/c5
	 yAPnWWzbUq9vK+DNH9MrVpEdAucT/1C8WEtqkkR0Rcz5XNniOVnL9vBCNYRGtA8h0bfmE
	 SfRMx4mR4AQNsQIp3fZIaPn5E5W2qTID7dWe+ELGTTBWF9y+9dPefCuKly62ertaN7gxj
	 qQ6+StY06QS8oWzjPZdH/9Y3aAvk7ZYZZqmw6NSDHq2CIqM51SsJ6EaXCstf54xDV2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53831606A31A;
	Thu, 29 Oct 2026 12:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53831606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D83E868D07; Thu, 29 Oct 2026 13:16:16 +0100 (CET)
Date: Thu, 29 Oct 2026 13:16:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, sgogte@purestorage.com,
	hare@kernel.org, nilay@linux.ibm.com, wagi@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: fix NULL queue->ctrl dereference on
 reconnect
Message-ID: <20261029121616.GA24651@lst.de>
References: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
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
In-Reply-To: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

