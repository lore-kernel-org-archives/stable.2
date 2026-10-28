Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200197;
	b=kjJOS/ioUbhhvgmXuOcQEffHlY2pb8V/qUp8u/SSlJWVe2YgBh9QGoJG1v34eDTk300J
	 m8jUDAmOOAK8oIbi2SPnMYB3LJmbkbg4LQeclvD1EFRTODPAlbxILF9JOYuDPYuqiB8R6
	 Zv1TQ56u76+mCzfRJ+cgHD5BHz2FUfTEUM3cXy03pjoJSeMdzlILedZ1pGM3JWNFC31ko
	 k/GzYvhGOoQDPgewKrPjQq3Uu6U3e2xiTsbk7CsnPXfzbFwbhlpAG6iQAA5E5oiOEktCd
	 /tFMso7nyJJmPpxNmEwjlzthw2GDye4rEZnLFdT9skavI6iUzVm9OSQsbuJaRwrS4jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200197;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=OYZR5J6I6yQ/XGesGmnk1RIGeDwVxhb8cVv8tpf6XLPiEu9hYBYBXboJupgRgMnwzDof
	 oiCen2ibWBP5tpik9zbAx5yRObFuQfcpbs8/kFsYt0cLArRRU3Brwfsd/CSORvaOMtw1U
	 RcgmCHkSeW9Cfw8byrJE/TMdPVDgB/rAs2BDEs1VQjHxk7tOSdIFjD+P5Z2e5eKHwUeFr
	 cCkMZhekTqdizpfiAPEYLDIEoxQHJJqiHYhE0AIwu0XF5eZ7U3Lk6yG9Tmmanz1sNM1d8
	 QvYTzT6hqVhv/jyeJ850DPhMd1Y6+C3qmiCIEZ/EtL29WIb1bp7ZMwovRivbSq4zUMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89F606A31C;
	Wed, 28 Oct 2026 15:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D89F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 588E568AFE; Wed, 28 Oct 2026 16:09:53 +0100 (CET)
Date: Wed, 28 Oct 2026 16:09:53 +0100
From: "hch@lst.de" <hch@lst.de>
To: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/4] nvme: report io_uring task-work copyback failures
Message-ID: <20261028150953.GD16374@lst.de>
References: <cover.1792118770.git.x-professor@outlook.com> <4f896744665ecf7034e4c52fa310f4de7fe1566b.1792118770.git.x-professor@outlook.com>
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
In-Reply-To: <4f896744665ecf7034e4c52fa310f4de7fe1566b.1792118770.git.x-professor@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
