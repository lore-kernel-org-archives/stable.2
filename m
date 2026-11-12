Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517760;
	b=XwSFtiHAHqG/TmQzub94M5qmVclY40E9Sclpn6LdNu8y0HdGRaEkk/4gtYzh1IdLGeeW
	 K62wsQns2ARGxy6yXzdMMQoLfyPUGLCACw4gvQN/47kSlk78iPv3Y0LYpMQ7aCUVIgZDE
	 HHuEJ1HWnNQwhvI0E9BLYdIaVX9HYbYWs/RgDHltizTW97NX6/yr3cHX8ERzfOg9ks7tS
	 Xo+dKnZBMvZI2Kxf06F3Taj0eRgFFr+gdiltRWpVL73OqitaTaasTGIc5XuOVxuDs5rlb
	 Ztvk10kjcES1XRx9PkIGztZCfWbOV/FRTCNveJODTgk8bZ5NerSuRVYF74d656w10vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517760;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=XLX7xUN0STtbaswLUVy039LSW+Xs+KrNDznhT2Gm/LE=;
	b=ik43YW/WgrwdHkpREXKXFqRG4Tz9HpZZsOPoTPHW/Y3UFmkfkwc+klax5ngPngWw3fGt
	 pfHd1/YB4eg9suBHGmxiRsN04hHHyQznpHJ6Xyt9wEcMcT1uhi44fydc9PVZoO54vH0lt
	 iDcytvNjJ85fSMt0gxfTa0Tjic5FZTkjH1cN26J3fxsEgwm+xGH0Dnf8sYvtZ+CVm53o9
	 gj2mMZwpL0Nzfkv5PQdM7zBexFVolLaV9Lh5qEd0NELFeG3ToPjvsXloIyYRI1OcPgArT
	 tIwwyG50aQUq0A6Vj4mI5WjvFYXKuAobHoeV+XYELh7Opi3IgpJAmojEniOY3fa3BPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF67606A31C;
	Thu, 12 Nov 2026 21:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF67606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A941B6732A; Thu, 12 Nov 2026 22:09:16 +0100 (CET)
Date: Thu, 12 Nov 2026 22:09:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvmet: handle short reads and writes in the
 file backend
Message-ID: <20261112210916.GB11078@lst.de>
References: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn> <20261112220105340AIwfaxoF7-iONJ2bZlEqI@zte.com.cn>
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
In-Reply-To: <20261112220105340AIwfaxoF7-iONJ2bZlEqI@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Still looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

