Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197131;
	b=AmnB8jbYievuZxRt+xVU7pTdbpFK+IrG+9xOIaQA/zWmOoWDpQZR2+2uT4u9SIV+CH8P
	 XWpHdm5zXTqQm/chFmYR/+Ydo605ZGP9y3OgQ5uE01XYcFW+Rm07/MlfW9vri0OBwPyc2
	 d6zoIPpUryW7qx+HTTxGXmQ5Wsj/y+zwt3T6LW+wTDTvsFrBsf+cpB121wFz5GGwRB+dj
	 BZg9q+6iKMhbpdlvdbQfNTgwxbO7sbULBPHKEBHDSVcNgrA5+AGrp+bvi+6tzhzg8+mE2
	 U/Fb3hm2JTTPlXFl8RTz+E9jIXmokfklm5JvHdCIL+wredN2gX0TLUW6vy8NPz1dI7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197131;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=Hhcs2ZeCBVVfVPQzsmMMikOl5vsDJy1YIgOoQmiUvyw=;
	b=ho+73+AnmaCV5c5K9igIJdXLn7Lm/SfQ+AAM8NVe9l6yiiBZMQwrQRenhabisBHO/qkq
	 szGeFPtFHWD1giTw6yEN6plxKPtIoKgC59gM2TNimP60R1V8aLgYSZn/hzqnOPK82hISB
	 leF8BlspSyDE1CQNeCUAHT0UJZmgjERwjrDMHuXtmZkOuLLueBNgj89ZXtj8XhJ17z4+I
	 CKEad2Rkmk2PTj8JRS6ChVI4/Q7l8xTCksYvyNB+T9wiC6P/fYGa5PnpSdeU7LtoTXsLj
	 JKrebcj+5r2I4/hl8WDooYGDNhxB7ouC4FtgwFEJe+kGj2qvc3NN2gogwjqNQ7SFbkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89159606A335;
	Fri, 20 Nov 2026 17:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89159606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32CDB6732A; Fri, 20 Nov 2026 18:52:07 +0100 (CET)
Date: Fri, 20 Nov 2026 18:52:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] nvme: decode the FDP Get Features result as a dword
Message-ID: <20261120175207.GD1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn>
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
In-Reply-To: <202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

With this struct nvme_fdp_config becomes unused, so we might as well
drop it.

Also can you look into the Sashiko found existing issue and fix it in
a separate patch while you're at it?

