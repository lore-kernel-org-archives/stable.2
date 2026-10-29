Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276017;
	b=pIzu1W4H77tn7xunai3oj7v+JMek7N1YK4io5wv0EZz1H6Zx8zlW0IBEt1ZMsmGrF9ZE
	 fk+4uk0Nfk4te+fvx0YSuU7AwCs0u3XDhg4sl+uEW5fgeBKb83AgOyomcyf9a6yqMv4sG
	 oHaWywmUWZMDceNjVBflHGaNA7j+qV8avSC2NjeteNvaVTkrUoa+imhCiD92XA8gU0TfL
	 j2BEWxlbypt4YEsJM77huLHY1xl6YfrJp/Ka73BIvN86YHF2DdFbsrTX0fbF1NQx2YcoD
	 HYp0ErWUDf0DKF0pHsMdwx/xJW8FxIvlwCj8MlNCmoU8rzngSc2yEC5oCnbXmDkMEww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276017;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=wTfRhXx4INKZU5RdD4TXcdMA6yHGfmG6Y68M4u7sU9J8waXP/yW6pySPTdQIQOsDLufk
	 FK0i+f4VLDyVqeXzBLJLDuGP12hiNs0Hk7rdK7ha1X27jHFBPa53dgcBOqP+b7nXYM1Pq
	 o/YZAlMmvsaQFCIoYUnS1KVhio/B4vj9V4zUfy18LdFzrSKngJKiYiJ1E8pLdlAikN2sO
	 WI0vo54nzL7yjCgN3C1+SjiJN/kxBVVi4jzPRwYCZpikXfeIY/lKsHbYXKS+0V2690s0h
	 9NQ4dvE6cOjkBuQIetk5MHQ2RaJucIBQ0V3NRIouLdfGzXrbFloDxS36dcSaU/syK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE08606A31C;
	Thu, 29 Oct 2026 12:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE08606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA57C68BEB; Thu, 29 Oct 2026 13:13:32 +0100 (CET)
Date: Thu, 29 Oct 2026 13:13:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: daejun7.park@samsung.com
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: unregister when pr_register() is given a zero
 new key
Message-ID: <20261029121332.GA24375@lst.de>
References: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>
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
In-Reply-To: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

