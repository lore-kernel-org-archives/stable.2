Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518038;
	b=fpFpVe/SZWdj/El6k0XmeKowrwiT1Lw/hzhkHOMI57zLnvm9uk5OBSQnKDlm5SDn+Xae
	 zAiuH+7fmh7vIjHxDBbK09x2PePP2kiNiWYYzCyQdCTryTbthh+JqUVdTBUbTXZxlmM/e
	 SVGPdizzcRRseImIDOoUq6GsPoNzJ+WLZjZiERks1FyIdAEQKBvF/BO887l8eA5xbX6a3
	 5QY/Qk0EG6aeUK9YVPkvNh7UprFdFhRbtktjfiXJ33YprKPuceg6Qg6jVyrKrOWEjEKkD
	 O7Ttjw/+DvFYP/O44YFGAqq+7EN8cGEExvBfD3Xuj19IXONrkE4yy1zMoeyhf39Adnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518038;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=iuje4CfWW+kUn+cBrldDzzJ8/X5NaLWo9LaLd+m6c26W0WaJsvVDnfYYldPm+e0Ib1L1
	 ZTqYUN1LeY5pNTojWHDIslpPtVQjL34GVAObgH+5tt1EJnlv8gjgiI0XpM9WEvxvtj64B
	 uO9QT+GNK5slHIODjAN+NdiMaFTaTLtwqKxGMnf38bg9vl2w5+Qn+nrJP/VB4i5v7UVR/
	 WDNUwvJAw4Aw0fFwWETst3N+zFEM4nzjzZJLXKslIX0l6EpOg85tUupftmUR/7BoYvpTT
	 XF4ktJy8iHk3hWJDevoYW795HOJiho92qrFVRGyMJi3r/NCrfhG9mBaecAgENSa5ezA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B13606A330;
	Thu, 12 Nov 2026 21:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B13606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5DE9768D05; Thu, 12 Nov 2026 22:13:54 +0100 (CET)
Date: Thu, 12 Nov 2026 22:13:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kch@nvidia.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/6] nvmet-fc: reject duplicate queue IDs on Create
 Connection
Message-ID: <20261112211354.GE11126@lst.de>
References: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn> <20261110230315189Lj-_xOlluiUEy8Ui7ZA4D@zte.com.cn>
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
In-Reply-To: <20261110230315189Lj-_xOlluiUEy8Ui7ZA4D@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

