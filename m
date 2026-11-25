Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587160;
	b=GgsXyfSR9naF17x+hYbb5GTTDh7L3OvsFhelp/+rRLbUthrMaHunTMwymsIpM+w6lf2n
	 Hm/oqskTvFZ2QlUlzTE6QL1MKhHzebaq1Xeeahe7G6qdolztim/8WZXZ3e2FlwnlEC/fU
	 sY3gEUtqDPDh6wwn5EvxsJiGifldRCf7AkWxye1PoYbJinUIfy9umzXzfowYhunfHnd7k
	 ZOyJ3cEufiqG2QVaw74QoPja4pLHdVLGhrlI7n4m0q3lrUyJUVpBZEpLMxKigLd25BLe2
	 8TC7zkiOBY7S/vyFdHsfgqeGeupVYHIeYJfTMLfyZCMLVzYUg2s0/1KyP8UenTAfMKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587160;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=ep1oh49rZmQ5+vy6+4FJpi0WCC1VzORvV3sWSagFtO7tHIdp3G3tux9zoEQbggukXeeX
	 r7l/imQ3QWjYWbCRgeOWO1MWxlHmKgGjzOqulAUONLyXVXM1y8A3rmclS07NTjMlvNysd
	 6tnBxZHRUi1bFATvuY8ySFZpsnKPGgM1dFm+fxOLxCMtBBEdtqdGnkIUfbNHJnDqM+fC3
	 t0qlTA3tlBpDUDKGyJyZ6BQFbhJKdTC/M+eHzh9gbD6yUADktZrhZj93mvTOM6rXMnuUu
	 ZefqkfwPnZxiqkAnI7m8ooZs6ZIqCJgpAhhw4Z0Sli4iFykvrFawm9eOywX4UveI6Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C606606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C606606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1607B68AFE; Wed, 25 Nov 2026 07:12:37 +0100 (CET)
Date: Wed, 25 Nov 2026 07:12:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephane Thiell <sthiell@hudson-trading.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, sgogte@purestorage.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: don't free I/O queues before cancelling
 requests
Message-ID: <20261125061236.GB20910@lst.de>
References: <20261120233508.379363-1-sthiell@hudson-trading.com>
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
In-Reply-To: <20261120233508.379363-1-sthiell@hudson-trading.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

