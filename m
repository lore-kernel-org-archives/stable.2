Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415321;
	b=cMm7zg8YJqafyeIJ1iBQU5Hw0JtQL1+Yws83Av58IwmiyW9vcQZzlppem5bkDU1hxC+X
	 MEtkCD9o7mGdIGAeqWoMs3Pufv3V1lFBbOwa7rSCSnq2DUPhpl5dOPflm2Yjq4pAdwoEq
	 OoRdLOCaTKzxhndV4nGanFLp/tQs9y8BrXvcF2jd/rBfL4RBIpAxndJcYj+KAm37NOVcS
	 DeMfmT05c7pT/fK8s40kK8L9kNAwVUf6ayAz/mSQ3A2NrOKqXNMTe4Z0pKePchY2/3OVt
	 p1hQuikFgVCIZ+PzEoLK1jQO+x927yQETHiyuWCrwJEM9MAGH1dKmtlsn1PaSK62Suw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415321;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=agAh6W8NRwdrqgXrhUoaM/oSp7OIFCK5if3yJd8aN1HJ2v5HSbbkT7KrmPpF3Cff4HEq
	 b9Z2cfRjAuC4B+L0QA8QA9J87MCUp8YAtr1JL/cdeM+ZsJ6x2afzRksLOz8fdu8Ne4ep+
	 TTkaJBMEvua2+xsA9ZisFK4ad3Q7miPvwgGm5+xpI5lnZ1owgvmW7h+WrL5FiASkFq6OD
	 2ov47uSViQE4b/Cn7j1ACecqrVhenHqaacirFPYW9fas+uR+zAjpGcbKpBiMn85V9I0Sy
	 /7SzPfl8o1kTXu/UdBQ9CuXadot4ioGP9mkRCmJA//X34DwqGtEe0YtSYksQHGrQJfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF341606A31C;
	Wed, 11 Nov 2026 16:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF341606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA37368D1C; Wed, 11 Nov 2026 17:41:55 +0100 (CET)
Date: Wed, 11 Nov 2026 17:41:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmet: handle short reads and writes in the file
 backend
Message-ID: <20261111164155.GA18076@lst.de>
References: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn> <20261111224245786kBVGPR0wSFFqHjmtHwtAJ@zte.com.cn>
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
In-Reply-To: <20261111224245786kBVGPR0wSFFqHjmtHwtAJ@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

