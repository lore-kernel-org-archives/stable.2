Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517864;
	b=AMqe1PLd2deXe0w1uTTl5W8U7f/0v+fd18NNjC0r0W36WprHirDJjTMmAYa5257tXSx7
	 hAhnZYPBqUQfEYFV16KtY7VgPVAaPMlAWHzIJ0gnyi/hQBuORqZ9aYnW6LQA62g/muNPX
	 KR6dNCcL3Gq0Kiuq9FaU7lCGJG3bFDcHbbeWyFVIPLrNYhoIovFQQx8a4ARWbiZo4J000
	 cnLNoXl/jLF3s02Mhez4UhLW/WqKi1/kZ2KiVqf/2fYP8yM5vck8oxPbWVDKMCkJS3h0O
	 rEpHxKNefq1y+mHJ88LeKVUVIycuH68qUCkyyYGiuYGYNyJLCqrzR2DVEcd88IxT9dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517864;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=OChWjgIZZETeE6wWBgToDVYJqDeEKzhMypDvwJDGUpCNyT9Domh0SBNKHo+LoYI0iJrv
	 d21wG4MhAjWlRnNLEm/qu34yTLwGQojUeXIgouPvHuPeZqvcaB1y/pkN6EEMjuOxMNBtP
	 Ukcw4+V2RfHsQ9oHR8EneeLB8gsZaTmD0HHVxxyJw+UINjp74JxhOPqMU3Yhfuemsi5jT
	 rr1nPWbe6Ys4MeyLEBlF9m6ySSgMoLmwlnai0daIIYAxyCt6YF3c0HQ4lT/6OTyv+aYiZ
	 Fp4+/wQWD/4U9nqHQ2OQJX2p6puceBtZKT4inIG0qiuaNOGEzkQUvwPkne0Yq+qwZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72C606A321;
	Thu, 12 Nov 2026 21:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD72C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 219CD6732A; Thu, 12 Nov 2026 22:11:00 +0100 (CET)
Date: Thu, 12 Nov 2026 22:10:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	kch@nvidia.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] nvme-loop: release the target request when SG
 setup fails
Message-ID: <20261112211059.GA11126@lst.de>
References: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn> <20261110230309524NeYut_cyzQcD3jcjj_beq@zte.com.cn>
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
In-Reply-To: <20261110230309524NeYut_cyzQcD3jcjj_beq@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

