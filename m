Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197176;
	b=iiFtGuZzzONzNSe2Q4YZ4ovlOiCa+3w27bxHcQTifwrUXvgMxPqt8kXZV6Zrs1OTw/G7
	 O2tuXyqcC86e+w9t62IHpL0/VxoLw42oJ89lmHHOuwie1PMWOBhq0tzDiyCxCsJgVxFE8
	 VAGAVgny7HcFLt/LQFhwDrYlPsD7PslHGBYVQumQYTjPOrMEo9f/cEKl7nmHIhw4pIP2B
	 ed8Huh4PebyP28Dp2VlG0wW3bkQmsQNLJsvA5B8PC9Wh1CbNeadPBh37WmjgsUjZ/4iXo
	 SyJjdKMWpjqDVyrDliDM3gXCWb0eSxjEzuv14LfcoSS5yMoJFpaxXxl34PCtGeoEiBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197176;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=dxPAjZGTbx84isIGff5tCQRPeIt6TGBEEevDUF9lViav8ZC59BEht1FG+muInUpeGGu3
	 Z/OkMZBXrvH01ZQMSCsEVgjTrXhjBndjgPZld7AHf0uYLv+tfjGWSaWjp+0FJ1iVx++Rf
	 F5jrhodvf1G7ynmomzIfmPJSjsRwOUlWIlUj26258WOM+M4LQTmtb5ma0wu+Xquhh7RsD
	 LcYUe9vRfW3ivUEN+9AqAxM9cJValpqOb4Y15mxvxbuAkKlQzCU8SE/WU+Eut/+1kpMT2
	 QgYuFQSPt17WWpol/39Lzr1x0bO+kcF0Vsbf7oIQ3tV4tlTvk5XouYgbYbsUm/gC+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EC60A2605;
	Fri, 20 Nov 2026 17:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 592EC60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E8806732A; Fri, 20 Nov 2026 18:52:52 +0100 (CET)
Date: Fri, 20 Nov 2026 18:52:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] nvme: bound the reservation report retry loop
Message-ID: <20261120175252.GE1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <202611150127588115YPbE0vZGI-FTHIHXJTI5@zte.com.cn>
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
In-Reply-To: <202611150127588115YPbE0vZGI-FTHIHXJTI5@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

