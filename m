Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518437;
	b=dyC1lZEwaRutDrIed7aRmv0F+AQvQdoB4m0bmAputgx0DQEGJF7gGH8ftmjDhJiefksm
	 rrL6LbqDJSz6ZFI3ihrXQXJ+i51o9PbDh0B6+KjYwQHErXxQJTKqEnZqCes/LWb7VPa7+
	 3kV+8oUMcfol4/vMoYM3wepiVsoQSkx63cKbrdr5GnsNMEotQSTFEOVcgSwEPN1+Kqzx6
	 tSr1Uy0F+7lzC4c6Oh0zk4Ws5AI5WYhBt7Y0gZNzE27snI0sEevPn+9V1oG4CWxai4JKi
	 s55qd0FZqKN2Ij1Ud1wPYp21imjdfuHYvwQKyzaAwfUQbN8//t4F35ny4ZXEM5dMykQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518437;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=l2VvP4LHg8Po3HXCu6urk8mTJze7P7tLOQrM8DT+v/Cq+ThLSR/zUSprblQONdaqkQPy
	 t46NM0Ww5+Lg6ADD3uKGYKyqKAHAdGWfybwrxM7D5X4dbOAa/ZOI0/f3a8fMKsFYriExx
	 CdDy4DMXb6nfTXvvqHkE5OatDOc8ctR+K2WXsigL4fU4sqbV9FYgxb2tfZz5btfLYliM1
	 6qycOi2LmgM4yvzvo2R6cpdoaFmYJV/F35BCwMlncF1nzDMNt1WAGFlGjmTZiDhwj+HqB
	 DC86hyjqcKSA3XZIoP++kis3tOgAkHK8p/kMRru64tLmsMUEQZhgeaoQWB6216UTeqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C40606A31C;
	Thu, 12 Nov 2026 21:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C40606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA2D168D0F; Thu, 12 Nov 2026 22:20:32 +0100 (CET)
Date: Thu, 12 Nov 2026 22:20:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: mt4022@columbia.edu
Cc: Jens Axboe <axboe@kernel.dk>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, tz2294@columbia.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: take quiesce_lock when removing a queue
 from the tag set
Message-ID: <20261112212032.GA11370@lst.de>
References: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
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
In-Reply-To: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
