Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197047;
	b=ULEcUVXO/Il4GgKdh4Gog2WXaTL5oXMlaQNWWfN+3oJOsi7WxFx75KhIkT52Wu2lVu8b
	 TCAEW2IrbtuCB5eXclulru6JewySTX8Na2W0D1mGUPtfciqiAhmzaH+sBtG6MH7Lbn1zb
	 Ee60YoTQ7wf59fXCuR2jkraaTjI9XCBnCCMezgrqB1reRxNlV5VRwCt1kWYjuPBEej0Yw
	 ndpjwkOtZSE+4UimBEenmaOyjpn102Uo3pp+gwJR/uU46rcJDbZHqxZ19rJu4a+P/1kxG
	 cHqgQomiMNSVbHSNWG5kagt93lMrnR2V5yGNe0EifPX02Q21Tbu2FhcvUhkaQdOaSww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197047;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=G0vM4qdT0TqdjMd7yRy0KqBKGRkDDGN46Z5oqriahsSMc8BtB7BUm75e3M5DBbgUpf+J
	 vhQSzO0NBbozJkHSwu3ySaZrJuALcwS2l9O2Y+KkfZx8MphhviVBbuuDam7vEHcJhAqNa
	 KnvNpmWSsfX5Vtko5rQ46F7+Pj9qfqnoq74orvln9W19VUmJzAko1m7EBxkAkUzUTnnbP
	 CMzszVSfQc8nhgLIV3/Uc3Rf/A5qHf2jyC7f44nGahjwkZaLTeMhjLPV5SuZ8K2EPcIFo
	 i7HhDpOZ7TEjOEPkg1I7G4m+eXBAWVqNAvKxPfqn01Pra9S+jWqAxXoStTNnaNw2m/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92060A2616;
	Fri, 20 Nov 2026 17:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D92060A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C392D6732A; Fri, 20 Nov 2026 18:50:40 +0100 (CET)
Date: Fri, 20 Nov 2026 18:50:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/5] nvmet: validate the LBA format count of a
 passthrough namespace
Message-ID: <20261120175040.GC1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <20261115012755704MxVgLMp__EddTP_3H7nCd@zte.com.cn>
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
In-Reply-To: <20261115012755704MxVgLMp__EddTP_3H7nCd@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

