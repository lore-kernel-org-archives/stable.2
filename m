Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3923E3C73;
	Wed,  2 Sep 2026 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388285; cv=none; b=ELfreTqb8Ue1GymeHN4IQ/D/fSh2GwqIJb20RfvqlcVMaG8BRRaiHNUbvFLhdAgIV4kwbpOtFZuo9CU0AqgFSMWrhBcViT0e84xZEY9RMZBvtvIvEzIFWoVSBWQCZbTg9RvrAqS4ysZv6l1ZGUJGOqL5jw72syaAcket6d46HyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388285; c=relaxed/simple;
	bh=3h61/PMDRoSTgUmzETCj9RPKM0wmptotcqCnLtX79vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3IWFFstFVJ8EJHqzMR5U/7jzR23heybxygVrpAo5IFHa82cK1RECfj540GQI3OVnv+ZSuLTWLs5ocxAhIKEioqBVXSATfyNUG6nCREl24h1d95JNax2ocE4+RUfcsJOS06Qp2YZ2EScWCOXXmE5C0tiT8Om+WmMFALqNPHxA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxQBpnVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxQBpnVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34CA1F000E9;
	Wed,  2 Sep 2026 22:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788388278;
	bh=Cg5o8lgTg5b5bmSjw4v65pZmgf85sugm017ebHjuk5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kxQBpnVYXvPtsrCaVcLec4+Ao5fczBjnX9kVV7ZEwTbIYOhIyTZsslbgbeSHwko6Q
	 4E4NFoCnhnXR6Kp/DQgLEI0M6qsaC5wl3CUldGZVmri5typu20h1FZ6uHC4ZCJbYw1
	 qUa+EO/8aTKvjSD7LBIkwDajwSyYYTn7jTZ1D3KfbUjB/9iAjho50RN2u6XUnzc0kY
	 u8uqVyeKkCVC3PKKonJ23m30Ak3WGm+TF39XuyN3oBCYYaLLt4ty1mMulxlpnaOF3n
	 FjD9wNc+P/cVgehpyXixE1i7sllYpdTOi/6R/b8wpeuriM1VKvROrrezVVkTFwV2Cj
	 Q/1WfPmG3WJ1g==
Date: Wed, 2 Sep 2026 16:31:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
Message-ID: <apijtLJ-5hU2MahC@kbusch-mbp>
References: <20260830131105.680566-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830131105.680566-1-hnkz.64@gmail.com>

On Sun, Aug 30, 2026 at 10:11:05PM +0900, Kazuki Hanai wrote:
> nvmet_auth_sq_free() cancels auth_expired_work with
> cancel_delayed_work(). If the work has already started, cancellation does
> not wait for the callback. Transport teardown can consequently free or
> reuse the queue containing struct nvmet_sq while
> nvmet_auth_expired_work() still accesses that SQ.
> 
> Add a teardown-specific helper that synchronously drains the delayed work
> before freeing authentication state, and use it from nvmet_sq_destroy().
> Keep the non-synchronous helper for in-band authentication state cleanup,
> where the SQ owner remains alive.

Thanks, applied to nvme-7.3.
