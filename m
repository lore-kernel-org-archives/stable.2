Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584610;
	b=vYOWGorG8ic6GaVFG7TH6FwGNBSq54yGz2Y4IHrU8m4pZHpi37mDbT12Kdkwi7aLDO4o
	 kvq3LKLLxu+Uw9afj/xN/y2kEJ1vU3g/NsFKEfB50FfiscSBSPkWCM4J0A0RL7NzHyUeA
	 M+MUTzd7RsQREzqEYhj45ozc0BhNEdn98g9fGtKnWmF8lyl6MGE+XbQk1a3sx9M7Q5qxl
	 dds0L1BcUzz1/wO1D3w2teLZxfK1PF4nkF+j1+YNbDg3z+ekpW7EQoCGvzXnfxwJo/nwy
	 U2yUYSif9UPTNwoFGZt8Sdu/DRRgxNs4irC8tWqAAGeBydPI3d4YXCLE0a5luiXWqqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584610;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=miCBQnRmTvQuzsLLmOQbLVMfDtzKwS1f8Q5H0xzXd5/wDafuMsIVIHB2LiNTg9SbI6b8
	 tSSfxBsDTs99FFDNxLbHvw8G8r2Hue48aw7geoqLwXCjBdiF9rpECr5XuG0fmarPmM7KR
	 3m8SofP3RkLfVT7C+vZ1gVoLZqtfLkdMbS9p/6DzlIZXM5PPhcAb9rJR92CH6zS19gKCm
	 awvYObCmsf3CwCb91x2sRBD8FPxfDHbsyzSvITS/5erETBVQZslEsWzTO2G8EQ8p4holn
	 KdGsfuLdS7UIAqg67iRj7uBYQ0/IDc/m/VWqeBdpEgzgxL3ChW6wvtXH7aCYq6CrkFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1C606A321;
	Wed, 25 Nov 2026 05:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B1C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C79E068AFE; Wed, 25 Nov 2026 06:30:05 +0100 (CET)
Date: Wed, 25 Nov 2026 06:30:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Edward Adam Davis <eadavis@qq.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Tao Cui <cui.tao@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+2e5cf2352e9f69ebf172@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] jfs: set lbmDONE before dropping LCACHE_LOCK for
 lmPostGC()
Message-ID: <20261125053005.GC20286@lst.de>
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org> <20261123-work-loop-backing-file-v1-2-48f83eaf2499@kernel.org>
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
In-Reply-To: <20261123-work-loop-backing-file-v1-2-48f83eaf2499@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

