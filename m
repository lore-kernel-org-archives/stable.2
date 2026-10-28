Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198358;
	b=U87t7xMwKkUhSwTqEG6BMospACwMpViE6rP1OCLr1wdCLocFl34j2JZeO9+PVRiATMWT
	 NW5Uvz5cKTzCUhUWVUAOIZVIdfrvzHrfKlUp2GI/JeKf1N55fqw8zBtEHSzt3KSemrvCX
	 P7NtmNA0wFWaZQtxRZc9ZWGhRylx7ON7E96+pcm5A7w9l9EDZxEaq2cNQqEW+zuEE0iJo
	 tIwV3Z60xTTpyAupjAT1UvCNfNo/1isjB/CWznyvS0pI0udpHM7a2gCcIeJGtgifY3P5i
	 r1gcunsJ8gCle5CWXaF8KnIbqFaRLyfuaRMMR4aHk502+eH7jEHDid9dDMNHPbYwPJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198358;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=7C2dxR+nSVKI6ig9BzzXD4gecQSomoKQXcjtQPbdAnY=;
	b=I0lXe6kMuGxKb8YEcL/Q18QjTLwy3TocDr0BtUB+kIu9o/9j++UGtlA+FtSXlT724PhD
	 Q8ymggzWHiIhEdDGsjjp82MWXO725CfQweKjmxoWiqr9j5OyriRTrywZtS2MR0YmZfZha
	 tQG3yV3LZ39NMNr/5fww6qPZf4/W4+zxLNnwMqXGx0NuORI1ld9SFc/tNSdwzJe5yHde1
	 auFsQfdJr/YehflqG/qKDbOG/kCbPV+BvkTphR2KD0uR6bqxbzuZf2n/Etw0+u3/R+toa
	 sjDkCLWFd1tn46zXys+hRxgd8hNBFiWSs/J54cFcJtJa+7vQBJ4KXcxiov6ckFzbnuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAF606A321;
	Wed, 28 Oct 2026 14:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BAF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3620668AFE; Wed, 28 Oct 2026 15:39:12 +0100 (CET)
Date: Wed, 28 Oct 2026 15:39:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiale Yao <yaojiale02@163.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Armen Baloyan <armenx.baloyan@intel.com>,
	Jay Freyensee <james.p.freyensee@intel.com>,
	Anthony Knapp <anthony.j.knapp@intel.com>,
	Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Max Gurtovoy <maxg@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@nvidia.com>,
	Aurelien Aptel <aaptel@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: serialize port attribute updates with enable
Message-ID: <20261028143911.GA13737@lst.de>
References: <20261028051329.149005-1-yaojiale02@163.com>
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
In-Reply-To: <20261028051329.149005-1-yaojiale02@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 28, 2026 at 01:13:29PM +0800, Jiale Yao wrote:
> +	scoped_guard(rwsem_write, &nvmet_config_sem) {

Please use normal locking primitives instead of turning the functions
into a mess with the guards.

