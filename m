Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517989;
	b=a0HZfDl7AOcto5ueWlLH27BHwUVbPabScVqcm3k+p8gN2UK65VNY4pc9eVsPYS0oBeiQ
	 +kXVMKxXTkn3DYq9GMr1ZO1bJP+5MGPHB+aLxYolFQZAPekuJbV61WNV9GgvuQliHBFzf
	 3oNk7xaBLvQUUPoaQgxrx6psvnc70FZMl2DQmcs+fxI2vuSIx6l+qsGqi5MKVCI+x3xno
	 h03sVWkrRIZicNlITHVRmaGtfcm8fTmkEb5Fwuhg6XrzDLC+idsSBgDNZ+GMCxvWkdiGN
	 MKqHjCjAIPQtjEJAWlG2p8JWFw8u9zTjswbz36jwtKJW2sMZnXHPGA/1qr476SynpFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517989;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=dLjFhyfTWlTsLfdbe0Zz+4a9KGoTqlFxKKn0rVgZXeeQa/0kxckbsXQ6+Jm/SZJAg11y
	 fnIfvX/ayg2irMHNxFKTDFulw0fVidSkL3CXKfC6O0gjxP3I8MXQOWaSy8f2npDkU5+jl
	 unO+Ku+0Fb5kXHMnCnE5UVhXLaDuH6OBs4ctrGDuxvMBXEdeTpsC5nrDzNwEs68V2dgFo
	 VSYiexvMPya7+ptRuelDTqNuPav9bf6zUfvNxIeo0Dah0f5QTllTVnJ6flBq4AHXozG7n
	 +HDvq++vBmu1+8T/at5tdCfnKiwCqW6pfufaZrOI2qG6ZgZHy3VBKNn/qssdiPr+IZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A68606A31C;
	Thu, 12 Nov 2026 21:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E0FA96732A; Thu, 12 Nov 2026 22:13:04 +0100 (CET)
Date: Thu, 12 Nov 2026 22:13:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	kch@nvidia.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/6] nvme-tcp: require the R2T offset to match the data
 sent
Message-ID: <20261112211304.GC11126@lst.de>
References: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn> <202611102303123637sawEnPImm3RHiCLaBc7X@zte.com.cn>
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
In-Reply-To: <202611102303123637sawEnPImm3RHiCLaBc7X@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

