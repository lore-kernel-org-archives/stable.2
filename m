Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201874;
	b=xWomvN+ZM9if+MMHukNrbwzezHfHGWcSEwdTP/tPNNmeb7y2598XIxt+VO1wNntDdOyb
	 517NnriJxZAvRxhfz6MPZxvl/m7umTI1padPrUVUyc+kQZnU/f21UcSic8Luso7322Fc0
	 w99ijVfYHaEV7G8Rn/apPLfMfFOvmyk7Ziiss1o/90XIhkh7wqbt4ntqZ8TNJe4mAXaAE
	 CqehJtMQUczmUppV0d7XsvxyNoPkl0iuynGmxZRf/QTxDd939PNDKPP6gy1Ht0yf5OVTy
	 ClRms7EpexQN+LxavqQUpvbkH7Lpbb93ZahEGTFOJ3u8JFRQK/OzASswYHzHgvd0psg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201874;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lBVErfdaD5I5AYIMyeYZ8mUmOaA4TcHGsRCFrhmCtDY=;
	b=Med65AkkTXiDMGh8T3CfvJMl9r0QUepDmU5HAQNd0MDhuMBrr2Afmd9spIvlk6IfEWVV
	 tOn5LE+ua9gB3xW2rDqyAoeuHmRlmpzPO0v0tLbtAPr7/xPHxOBRBh/fbnPTQL4AMpYDo
	 2FJ0jM8yK2ABOZjqPqp5CCtW88IUYgmz5pYH7akpoBhevjj/uz5ZJjs/Ap950144jaLi4
	 jSgnFPfwd8ynAejTAtCaZiuwNIr3nWmKkUw1CFcAmS6yqjFgeOPs3jT3rfpigVLFC9Z7u
	 GHBJ2Jr5MwXjun0C7FfBlk4r5j5AauRGTKSxqdXxMBvOmY+owpBXHhNFzl4JWzlcuaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0odHC5c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA93606A31A;
	Wed, 28 Oct 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0odHC5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B2E1F01825;
	Wed, 28 Oct 2026 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201873;
	bh=lBVErfdaD5I5AYIMyeYZ8mUmOaA4TcHGsRCFrhmCtDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q0odHC5cdHs7S4S9WvYGAyaVxd0JegzvuCgXuI2E+RBR+CX3/N8LbO9G7S3Cza0b6
	 AvZ8zeVPuhc9vbWPD5PAV6Dxx+Xlggs4dIoQDGHOYi5KYRSNpmH2J8Wq+Ct6raBwbI
	 OYxwCblXb75ocwNYFrh2FLxvx7dH10cmTQw3AGWmL2g4iRwdOBjvb17zASV43M6CUo
	 vN4aprO5tOwxX0cgr7KX2qSj8HiDzZz4F1hlb7tQkxDFFJBHBGp4SjATBYv58/GVSE
	 Ekq4qP5SzL7WNAtOmaDp2s4ovOObXCX+1CHpV+IviUwisTXchhVYm6Tk24ArBKBZpR
	 aNUVkDyufySNA==
Date: Wed, 28 Oct 2026 09:37:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Seiji Nishikawa <snishika@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex
 is held
Message-ID: <auIWzzvH28ubRoF5@kbusch-mbp>
References: <20261014064524.4015025-1-snishika@redhat.com>
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
In-Reply-To: <20261014064524.4015025-1-snishika@redhat.com>

On Wed, Oct 14, 2026 at 03:45:24PM +0900, Seiji Nishikawa wrote:
> Commit f42d4796ee10 ("nvme-tcp: fix I/O stalls on congested sockets")
> added a check in nvme_tcp_io_work() that sets pending to true when the
> queue has pending requests and the socket is writeable. The check is
> placed after the mutex_trylock() block, so it also runs when
> mutex_trylock(&queue->send_mutex) failed and io_work did not send
> anything.
> 
> When .queue_rq sends a request directly from its own context, it holds
> send_mutex and can give up the CPU in lock_sock_nested() when another
> task needs the CPU, for example the io_work kworker of the same queue,
> which runs on the same CPU. Then io_work cannot take send_mutex, but
> the requests are still on req_list and the socket is writeable, so
> pending is set to true. io_work loops until the deadline and queues
> itself again on io_cpu, without sleeping.
> 
> This is a priority inversion. io_work runs on the high priority
> nvme_tcp_wq and cannot make progress until send_mutex is released, but
> it keeps running. The task holding send_mutex runs at normal priority
> and needs the CPU to release it. The scheduler keeps giving the CPU to
> io_work, so the task holding send_mutex may not run again, and the
> requests on the queue are not sent and time out.

Thanks, applied to nvme-7.4.
