Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAC3D3327;
	Fri, 18 Sep 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744687; cv=none; b=imGMja+aF4DdX+ClIMD4vZZ/5g28CXb3z23TIOLzPcUQX/r1oViCUNkK32+hVcy0FM6QQ6G969fRHQ/03dt38OIHMz9JlGZIebANfo1BJWJeqv1az5kewr6+KDQ9oH0LgI7Jv4kRGKXoBbWHbGSMWWrRgNAWBBt7rl/3dpPUx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744687; c=relaxed/simple;
	bh=e7u07P5eoA0cu9MO4I2ALjAlEavOvdWZxVOMRUfqUUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak/SV2T6UdfQlIkugR+W2c+cU/KHSlWoOHHkVkk1E78YgxlBbmsskXqTquLCSj3frYG5s5eevH0nzxG9+/RjUpJPv4vmt4MU2DJJ/xcXtMrAiIo/6egs/r/sPr05WDDpY1fRGGJvF/U+MW/uRd6XgvfdBFpsT/tPT3gZT0Q7N0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivgqK9iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivgqK9iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD981F000FF;
	Fri, 18 Sep 2026 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744685;
	bh=S82gNLURUVEd42qKqLAV6CWU9l2uRU5gXjuBbJpx9XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ivgqK9iwMqXIMmVpjbsKaKPtRWJEamrW7bFCVQh8ISq9Co3a+JtxzefrAnXhj7PuF
	 wLzqRYsz4EnP0ycCGJzXkXw9psQOxzb0dvX3wTln/sxHrU/v/XWWr2PqidO81CAF31
	 cs0DH9QaEV4LUJapntbecmD75jkOoSokGNQ2h1+6eivNmLnIgIZjnJeWXeGVsy7KRL
	 OdIj6s9QBpoPd46eFAV41TFFi/pek31MZmNkml279cackF44BwaRLRGZcsB+qRP9n1
	 TceE7YfhvXi8AtQBCjNGPkmGAN1+r9AracXjL6Ua5gdoJ1uExcqekY2jRS8v5c/v6k
	 hHI0Sp9lwZCfA==
Date: Fri, 18 Sep 2026 09:18:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	co+77553a7fc66ac133@bugs.sh, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: fix out-of-bounds write in
 nvmet_auth_challenge()
Message-ID: <aq1WKv3UKpNf_3rL@kbusch-mbp>
References: <20260912171009.1513289-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912171009.1513289-3-bestswngs@gmail.com>

On Sun, Sep 13, 2026 at 01:10:11AM +0800, Weiming Shi wrote:
> nvmet_auth_challenge() receives its output buffer as a void pointer.
> sizeof(*d) therefore evaluates to one with GCC and undercounts the fixed
> challenge header by 15 bytes.  A short AUTH_RECEIVE buffer can pass the
> check before the challenge is copied past the end of its allocation.
> 
> Use the typed challenge pointer when calculating the response size.
> 
>   BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
>   Write of size 32 by task kworker/1:1H/64
>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
>   Call Trace:
>   nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
>   nvmet_tcp_try_recv_pdu (drivers/nvme/target/tcp.c:1119 drivers/nvme/target/tcp.c:1243)
>   nvmet_tcp_io_work (drivers/nvme/target/tcp.c:1350 drivers/nvme/target/tcp.c:1382 drivers/nvme/target/tcp.c:1445)
>   process_one_work (kernel/workqueue.c:3322)
>   worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
>   kthread (kernel/kthread.c:436)
>   ret_from_fork (arch/x86/kernel/process.c:158)
>   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>   The buggy address is located 16 bytes inside of
>    allocated 33-byte region [ffff888000554e80, ffff888000554ea1)
>   Kernel panic - not syncing: KASAN: panic_on_warn set ...

Thanks, applied to nvme-7.3.
