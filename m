Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518577;
	b=5kAgT8+puE0x4g/ELgucO/16o34z7gchbgh5qnOl7qjoCtrvuUiF3qyEX82psokVKC1n
	 WeGdwv6yC+CZcARdfz5SCy2QwQtn7u0XdqWhAUV9fB0wQDuWbfNu7BorRZ74z4xNVq9EZ
	 dUa4O4UAQpOqlTH0kC0Y7NY7e6LRoNCebKyKT7pxyXUNhNJrdJpY0tTMYYy+DW/nP2Xr6
	 8JCyAyP2CAY6AFZG7BM7bWfvZ1lYrMlojCGEfvynWJdr1spYHE1dGXKPppeO+SqGlUGmV
	 wCEBgOxEKCwZwfZGAIR5zxCpy93NuGjiitpVqTXxjpm7T0G08pxAtX/Okre9Em69CtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518577;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=pQVYxY17XvtOHE8I1DxKuXnm1mkMDBAIa8OKjLrFkUSWsG3XvJMWHRIkpU9//BJz3uIm
	 0DKr/DWlAHaUh5qGfYpByHnKygZth57470hyiUiE6jyxwYDvikaIKfib+7ehsI5pHj71D
	 FRv3DaHl2h34orrzGg2Jxsw0zi+B3wBW3hQnPPg3FZW69hy1ZfaAPyNBf4sNHLHnhCYmT
	 zX+l/igT8rlMEa6CCEAmc+UGXsPBDVPIbyY6V6WfA0pxKFQrMSFmsPF+ZRYzcoXq2Y5Ze
	 Z12yn3c1aokJ409s0H81xn9x54a8CuRK81FPHSTtnJNYM/YeAmC1MjtZmih7RArEkOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE21606A89D;
	Thu, 12 Nov 2026 21:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE21606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C28768D12; Thu, 12 Nov 2026 22:22:54 +0100 (CET)
Date: Thu, 12 Nov 2026 22:22:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmet: zns: return the namespace lookup error
 for Identify
Message-ID: <20261112212254.GC11411@lst.de>
References: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn> <20261106230020595sdtR1cTOchAJ3lWjuD06g@zte.com.cn>
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
In-Reply-To: <20261106230020595sdtR1cTOchAJ3lWjuD06g@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

