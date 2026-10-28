Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200213;
	b=UOzADLWRfj6oyskP13cvjjkbSBrYVw616986/+GlY7VoyYXy5mSTcBrmiWs6VSGK72Y9
	 OaxCZuJYEU1sb7wRVoIWBkG8lHqYNOSWVp2585DaXFLskV+a4mgNkstqatS6Z/SH2aJ68
	 /LObNomo+0uFwDIJpvIS/nqgMFZkEbDxWZM+LruONuhGQJecnP1/m5/AohtesO09b4VOL
	 as16wvHz2bhXbWcaVzVgqV/wu/oAF8DOPqeoEpmp46RrkeYQm8kkP3Xk7EoJpbNuWEk3Q
	 5PK24/wrsEC4V7PZzTuvkif78NuEHG4vD1yLRrWlbU2YRzRxBFrRda1H5FM4RhJf2lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200213;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=ZdJWV3t8LbVsS8z1QdNrQoXTFz48RiHusiJLF7WzVfkNq31gxH+U8mdJ3vyB+CB0dNgo
	 +kOB8xteWtwGyRnCe/vGMVvkmeZvzx6//gBH3NitT1THaQgjs5MxQ2P7BzbZIu5ic7EPh
	 AXY92PSfaAFMyLFvVT0Y3jJdf0Jy+ko7ZeKFixuPw7yclIahYV6LS3bj5ZZxrgb38k1Yb
	 wtcmmQZ2mgvgHEnFXRhskcyGwOtdfN3T8pbGecBK5tjDPQ5kDNmf7BDGlNYDjNnGXKe63
	 WkhLYdyPX2TzmNY2xkJ4syH53qg2i2spYJKW3LrROwhMdBY2SzIO1HOKn0tgmqr0yVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BF606A327;
	Wed, 28 Oct 2026 15:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D1BF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BB8268D07; Wed, 28 Oct 2026 16:10:09 +0100 (CET)
Date: Wed, 28 Oct 2026 16:10:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/4] nvme: harden local IOPOLL user copyback
Message-ID: <20261028151008.GE16374@lst.de>
References: <cover.1792118770.git.x-professor@outlook.com> <c8989c0d71a640349f4dc483aff0a3de6731aba7.1792118770.git.x-professor@outlook.com>
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
In-Reply-To: <c8989c0d71a640349f4dc483aff0a3de6731aba7.1792118770.git.x-professor@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

