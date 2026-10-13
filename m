Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6D513561;
	Tue, 13 Oct 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901882; cv=none; b=LE1NAGkhy+z4jcz+pkbrKo/SVFTSodY66Z93KM2LwN0BHir4J2WqiN7SAhBNc4pxdlAudUOOZzMXtGtqFRqk6K3YXcu20uT9Q3WNKIVeSRPuqpDeh/Cmb/R4xNUEXiTOM78cDXi2+suzzowGVvzusB58e3CuXQG6sKH0N0cPEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901882; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slx+Ov2AqhNV49LB0jpaV0XlTxC5Jsa9+ixLX2M1CjyePOXxkEbUHd4QV9utmPHct/sUbZLjH5I4K+s5k3dV2ML8PfQzwnLgbz9bW47dPkGb3w1/CjnHxe9ILF2+a8qwgSEJedhnet3ZCu1LACjxsmUzrv0u+UDWcDJu+s/jR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40E71227A8E; Tue, 13 Oct 2026 16:31:18 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:31:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: fail when the controller does not
 authenticate itself
Message-ID: <20261013143117.GA15395@lst.de>
References: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

