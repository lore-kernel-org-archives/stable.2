Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273F383319;
	Mon,  1 Jun 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298023; cv=none; b=lreaqC5ZaEJ6kSw63MQfpRQr+4ltNMZSUzyBmUPiLvw6n/7nf/jJH55OC75N8L50qtqpLTpOiIqhT+Uu6UHA0s05o+b92gzB65GYrzEj60xe3sKVtuekwu1yf4febSJ27H2d8qv4XqCo6svDihVxUEQ382CWUaw+pnHVSbBoFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298023; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg039PEIa5yo696mb7CIVehr9l0FJgFPnNl9Wdp7QNixxq065UUzA/ch6LpZba+ZYsr4zCHnbbk4LxAulucYwIBL0ZjJZ5F2Vdt0CTLyXTxBlcwbcgqga8/q0dDPKUbKeU6g/tfpl8Aqy79B5bquPx57UxttTIxh2ob2jJKEOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBD2868B05; Mon,  1 Jun 2026 09:13:39 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:13:39 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped
 to per-path namespace disks
Message-ID: <20260601071339.GA7570@lst.de>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com> <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

