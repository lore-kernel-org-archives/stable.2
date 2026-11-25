Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584281;
	b=ZVhJR7hMdlZBtj9ap1VPXbX5LO4PfxDGtAW0u2SK5HO+FgCRhVUPWQNBoYV9RxcVaVz5
	 SgNuvY08MFrgE4iaDbsj/okhsa+/0oJa+h96gPg+A4eW2fKB2Th02wHzd343I2a8IsTsV
	 RGP9uQTqlACuYZqIutwY4HvY+5eI5xD5zR8bfN9rFDww+QSJ2CFj03rk5b9xoD8PDn91K
	 98EnsF50JFaS/wxX6u5nfDFpE3oITTr5236iDGPgQuEB2t0CcJWcLM+jXhuw26c1o4/YB
	 BnWWS8P2gwMxsRISNVM6t+ukq8nsimwYb4y9J6P2ZCB2AsnBRop+8rfedSEq+3zVvNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584281;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=PonlHCCNLoS6417Es3Ao3GGEnjQRAMvuPVa+2UAkUV0Hd85VMJifsYPF+95hw4deWEbP
	 Y7NkdOuL4oYeMmsxxUBRoFbO0QQYA5xhpPnQqjfLsGUqaiP6x05DfmwLzAn1o8eQsNNw1
	 JEX6Lv7arhlf6Z8OyG3WyusKReuUxAY7j6dk2680CcZuPV24f1106yPk+oSqPchlcMgmz
	 qoWkn0OjAlunE7In5R+XOeB3ygjWA/s5/EhCtzYC5sA/uz5lL29JO/ixahvLDX4XBPb5J
	 43TJroDY0E9oKhQbnseSo+zyIfeYx2ScTWwY4E6gG7Ms3+hWfAhD8qz4pdJMhKwcS2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB61606A31E;
	Wed, 25 Nov 2026 05:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB61606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F31CE68AFE; Wed, 25 Nov 2026 06:24:36 +0100 (CET)
Date: Wed, 25 Nov 2026 06:24:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme: zns: reject an out-of-range zone append
 size limit
Message-ID: <20261125052436.GA20248@lst.de>
References: <20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn> <20261122224831886ognkZtXtygomcSayJJdF8@zte.com.cn>
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
In-Reply-To: <20261122224831886ognkZtXtygomcSayJJdF8@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
