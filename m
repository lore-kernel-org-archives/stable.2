Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616388;
	b=NkIFKX1ab71aoOBMneb1kpFX5hzqyBw6RmQc7K5bS3fbkwIVBzv/WCTv6/mN9ibkafDg
	 0ovbS/TXS+ZqHvNvSwHUC7/Zs+zAqpmRINS9BSid/OwtXcXAQBTPbcDL5YJx7P/CW5LCW
	 7XahWIOuXgBmfgjVsYSl6k6rNluS9nhD1StF5m9Kuo6MkuioaAbbC52pEoJ9oRDS+ywOK
	 rrMyG1hSmmQljKYsfQeFsFqtx4PTD5ZqmJNzGjjGzXCXPfQIkiVmfhVyPFbZbQdS06zTm
	 4mMMdegVIPaIJ/wbUxSKv25nqzQ6JAsfuLk8IMGH/usrlPgdxhizh1klvsgmwbhTg6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616388;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dQkMQtrYlohUdfpg8lbIStksMCRKnqn5TqyhsBWs7Ug=;
	b=OD0Jm0e33Vq1wnqyT6RS/C0NeYgVdZ8wYVNcWDoS2IHIciuM/1DMSxe30ZTDEFRT51it
	 MNq8eM7GqIWseXBSqLnyTuOrILdqQK8pQCoWVk5ELtH/zDWd9hcpqhYJ5qP3zdpda63Mx
	 B5Iw3fkKYlVtr+mzDGTgpnQ97hZR+zcBjWkbwNg8SmfIUu/SmxLBJHF7TWe7C7ow0QY+g
	 8IjgvGudxlFvVD5ryl4KZho0h4b7DZfvOZevj1uqqDBOpB/wLBKgO5pgyKDZAl/pcbISu
	 xDKiIDJx1xB/32mzm4fr7mHxxAFgjdNTP8XmlmFACcP/VDpXRRrHeUW2VRIt037Upfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntcLL67D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94193606A319;
	Wed, 21 Oct 2026 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntcLL67D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF0D1F000C1;
	Wed, 21 Oct 2026 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616388;
	bh=dQkMQtrYlohUdfpg8lbIStksMCRKnqn5TqyhsBWs7Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ntcLL67DA3ZiXOfMJVyz8TH5b6lcoTMWYE4+WyyBxQODcU6/u+/n9YoxsMJLl9Sic
	 P/A8NuUUjjYG0tibijD1UX11MX7yoxu/pN8//Vk9JUehodQo6EdNs9+3VtISmctStf
	 WB6r0152ZKLHQEB25IaLMvqQo99zyjkgjcEGJPvS1C64OQKj77EGkavJXIdzFKMtZA
	 KQi01Fw7QUTml6hz2US14hj4zII4jPC0zXTj62ITNVEwR8idKDiuxlbEcXRIQ2enVT
	 lcNFA4mDR1IWWXuE99sNtnL54YNRLl1fi3Q+mpUiJ/oONoWbjJWtv9u62ERVtjlJip
	 Za6TUygbkIINA==
Date: Wed, 21 Oct 2026 14:59:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: take subsys->lock while force-reconnecting in
 nvmet_subsys_attr_qid_max_store()
Message-ID: <atknwrTGQ6GqNksl@kbusch-mbp>
References: <20261014054727.53183-1-yuz08559@gmail.com>
 <20261020025047.88297-1-yuz08559@gmail.com>
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
In-Reply-To: <20261020025047.88297-1-yuz08559@gmail.com>

On Tue, Oct 20, 2026 at 12:50:47PM +1000, Yu Zhang wrote:
> nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
> subsys->ctrls to force every controller to reconnect, but it holds only
> nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock:
> nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free()
> removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
> The free path takes no nvmet_config_sem, so the two locks are independent.
> 
> A controller teardown (host disconnect, keep-alive timeout or fatal error
> -> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
> therefore list_del() an entry while qid_max_store() is iterating the list,
> corrupting the walk.

Thanks, applied to nvme-7.4.
