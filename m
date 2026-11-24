Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538284;
	b=5N3mtdyu+mLU6WhcbJH+QDyODYtrXDnwacmPV41H5b6D+gxzKYagBCYIHDI4rUjuPMLd
	 6+XohbffIiPOxsV+1+wxs0ksrVpyQEL3Tp1Mjfl5uHLn/2BSn449fZO1nK7Ckq/i+0Yx1
	 XKs3VDOpvNaRZYxJqiQQ7tf1DGJ40TU3p3uueuLP5FKlDaI5G6t+n4T6o1vBkVJeBUKA8
	 cwjOt5IxN9OenOO29Usv+clPLEmshTpIVd5oWP4xReJb0Dw+gCWRRtb+NxraMcTzd9keZ
	 82y5M8bfQciqX/IFkuYZzokH16ZA90WMJEGv3oidxfKdZ7TMVm/WpwHD0tcLW2VyULw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VcKqAindQ+wtPkjkunJkcwHZ0Zj0u+55F0mjged3HyQ=;
	b=M4lwzgHHMtvuqKDBn8ncyy+0eo8l664cAyns56wSxYReLxa+BBXhTcOtRO6IH58eMbLa
	 GimHgM6w3ePz6D6l4xoVMUpv+E+LTrDj2U7GZF86S7wMFF4I5SM/5sz6/hYj5VgXtJasE
	 qclFJo6d30omX50+eqg5JHt1WOmQ9jl6f5J1zWbiIFfAFthak1tfJWWiDyjuFjlsEv+KS
	 unJyg91/tnOfb78CBZBNTRHJ9wmdHPjgHRuZZy41S/ocWzKxUagBZwgIVHWMzA4wstcC2
	 nWeNxYJZrp/PUPRzeW5sF/uqe2Ei+dO0+wr+/YnJAJp69apRCknG9q4Rg99mY5JV8lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=AaHe7eAY;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C289606A32D;
	Tue, 24 Nov 2026 16:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C289606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=AaHe7eAY
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jYpQF6p9WzlfvqM;
	Tue, 24 Nov 2026 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795538272; x=1798130273; bh=VcKqAindQ+wtPkjkunJkcwHZ
	0Zj0u+55F0mjged3HyQ=; b=AaHe7eAYuU8vzjg7cR1Z3k75naI24NXULG++7wgI
	DLYImG5O+Q6lE0HGJ/IwjQQVs6tal314bXGukXQj/dlzsGqFUZ7e7AvEliOJ9Mdw
	iMqzZR9NzQ4tPcaDAfsJmhDhe7BE4yIMrJXWSnnig+KDgX9s0L0F9IoLHjEERY+7
	OU8yqGz/E2JfbItUw6FU1vyt2XXtWuBejLx55PbSwmJtsLdUD/8CXxRd7+PmcmVh
	JA8c76xbSiV0/7oMrZeQQDkVCox03oA8fgAyardlcqOH3RKhO9mRn6ExKndlMKC8
	rkPbNdC3afxHuJObuUQGtF1TBqXo2HfWL2xAyq6fs6Rz9Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LkaBam14LBfH; Tue, 24 Nov 2026 16:37:52 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:b87d:aea9:8f72:a6cd] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jYpQ83pdbzlkvPv;
	Tue, 24 Nov 2026 16:37:52 +0000 (UTC)
Message-ID: <207069e4-6c99-40b3-ac0c-7ffe675a0c9f@acm.org>
Date: Tue, 24 Nov 2026 08:37:51 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: fix stale dma_alignment when direct I/O is silently
 dropped
To: Tao Cui <cui.tao@linux.dev>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
 Ming Lei <tom.leiming@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@kernel.org>, Zhao Gongyi <zhaogongyi@bytedance.com>,
 stable@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cuitao@kylinos.cn
References: <20261124093342.838490-1-cui.tao@linux.dev>
 <96ffc97d-62bc-4a91-ae3d-9baa28ef500b@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <96ffc97d-62bc-4a91-ae3d-9baa28ef500b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/26 2:56 AM, Tao Cui wrote:
 > I noticed the sashiko report [1].  The lock order in loop_set_status()
 > is indeed different from 06a2ff603f1f, but I think the reported
 > deadlock cannot be reached through this code.  The queue is frozen and
 > fully drained before queue_limits_start_update() takes q->limits_lock,
 > and nothing between start_update() and commit_update() blocks, so the
 > new code never waits for anything while holding the lock.

Whether or not a deadlock can be triggered, I expect lockdep to complain
about this patch. blk_mq_freeze_queue() acquires q->io_lockdep_map and
that map is only released by blk_mq_unfreeze_queue(). Hence, calling
queue_limits_start_update() between these two calls records the
dependency q_usage_counter(io) -> limits_lock. The opposite order is
already used by loop_set_dio(), loop_set_block_size() and
queue_limits_commit_update_frozen(). This is the same complaint that has
been fixed by commit 06a2ff603f1f ("loop: Fix recently introduced lock
inversion"). A lockdep complaint is a problem by itself since it
disables lockdep and hence hides later reports. Has this patch been
tested with lockdep enabled?

 > I am more worried about the suggested reorder: with start_update()
 > before blk_mq_freeze_queue(), loop_set_status() would hold limits_lock
 > while draining, and an in-flight write-zeroes request on an
 > unsupported backing file would block in loop_clear_limits() on that
 > lock while holding a queue usage counter, so the freeze would never
 > complete.

That scenario is not specific to loop_set_status(). loop_set_dio(),
loop_set_block_size() and the sysfs store methods already hold
limits_lock while freezing the queue. Making loop_set_status() follow
the same convention does not introduce a new class of problems. The
proper fix is the loop_clear_limits() rework, so please make this patch
depend on "loop: defer the queue limits clear to a workqueue" instead of
deviating from the locking convention.

 > The snapshot taken before the drain could also overwrite a concurrent
 > loop_clear_limits() commit.

I don't think that can happen. limits_lock is held from
queue_limits_start_update() until queue_limits_commit_update(), so
loop_clear_limits() cannot commit anything in between.

 > So I would like to keep the patch as it stands, but happy to discuss
 > further.

Please call queue_limits_start_update() before blk_mq_freeze_queue() in
loop_set_status() and call loop_set_dma_limit() and
queue_limits_commit_update() after loop_update_dio().

A few more comments about the patch itself:
- lo_can_use_dio() is now evaluated twice, once before the limits are
   committed and once in loop_update_dio(), and both results must agree.
   That seems fragile to me. Please consider documenting this
   requirement above loop_set_dma_limit().
- With this patch every LOOP_SET_STATUS call updates the queue limits.
   Can that be restricted to the case where LO_FLAGS_DIRECT_IO has been
   cleared?
- Please mention in the patch description that the stale limit is too
   strict rather than too permissive, in other words, that the effect is
   that O_DIRECT I/O with 512-byte aligned buffers is rejected.
- How has this patch been tested? A blktests test would be welcome.
- Please use 12 characters for the commit ID in the Fixes: tag.

Thanks,

Bart.
