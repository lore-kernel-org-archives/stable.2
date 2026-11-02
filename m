Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640481;
	b=YwfzcTUyVv1bIizS7jPPgsTQCZyw2MkPb43yE0g0xWSXkCb6RvTsXugk16vgldR0bx7J
	 rJ/4CtmkdAnoYcnb3hx/IVy6mJzCSE5mRfM3DcNkbZ5heaNMdPDZo0mrTEkJLmS06Z9Wy
	 mNUfzkGJW8CRY2h4LBsqtDY5oUFf3I7YmAEk5vnxbLJ5P/WO1qqxymqcT9ZucUleOcWk4
	 K+owklkOw02KnKvgZHQ2ObqUiwjHnBNuF2qIBsKXk0McO29ct8siHRtAKCY1Ns9sMMbaC
	 H8GGXFXHtX3mMStaBpqbbH9QUVm0OFWO3IdXOceDwoec35GxsURV4vSRqDGBvEitCuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640481;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2czTmQ24qitbkFxmuQ6dQz7mWzFCeQOh1YnpkBLFv6M=;
	b=0BcB40kddc/CE6nUOVmbyIc6H2YJFCjpQUrqYWGKv8PJfu3ZR/IVC9OlGeS/OlvTjzo0
	 Ru73wUv6YF330kTk5ccikZElcmAQex19usErLpdx6zIEKmtpEBq0ig/30F6JEe+H64ijJ
	 sG9vkvM1SeAGtZUMBM/5TmhguiZAwy+DLT0Diow4qW2gJQQNRfMS1fwOdbwR36rVjzKaG
	 fAZ5BtGzBHYTz4UvgfEmnsUxKJKWQ5C7Gyeia5+n/b/inTBUQILHIo4bD2G/3V3LWiJuc
	 NZmLkICPBoQZxiNwVeLKBVAiTOphzcLtCpt3/BWx2Plb9jJnSTtRj26JQjsUIgZdj7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXUBMKak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DE606D82E;
	Mon,  2 Nov 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXUBMKak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4F1F00A16;
	Mon,  2 Nov 2026 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640481;
	bh=2czTmQ24qitbkFxmuQ6dQz7mWzFCeQOh1YnpkBLFv6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXUBMKakKRJ6/Un0jfLbcBn8aEE8R9HKiP3gH7Pdm1yoqlBRZIJjW8ndCHhqY+ZSl
	 EAytoP9gyhtPB6kM4V3YmYWDKuj85FPfUcC4ySGhWKJMYPRbP39quCu/4ZKxPwTvlb
	 CZl8Apki+OJmgNI9UfiB8lr59rNjaE9mpu513+8vAVwDn2brzp7gzlW+EKArCCkeQG
	 wcaTKVquJnsuVI57w3vVGwZRbJ8mNPINzvkxY2o9f0Ukk917yqgOEGKtMsH+avLXyq
	 C5UsVDuWUFNB0ZRYorc4x1DbvUzs1ohi4kCB+a/q2i1pynkurulPOrR9LQPjD4erVE
	 LiXv7qTyAzDXw==
Date: Mon, 2 Nov 2026 10:27:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: daejun7.park@samsung.com
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: unregister when pr_register() is given a zero new
 key
Message-ID: <aujIH1Kw8Ex6kYlX@kbusch-mbp>
References: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>
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
In-Reply-To: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>

On Thu, Oct 29, 2026 at 09:51:24AM +0900, Daejun Park via B4 Relay wrote:
> From: Daejun Park <daejun7.park@samsung.com>
> 
> The block layer PR API defines a zero new_key in pr_register() as
> unregistering old_key. nvme_pr_register() sends Replace Reservation
> Key with a zero NRKEY instead. The host stays registered with key 0,
> and its next registration with another key fails with Reservation
> Conflict.
> 
> The pNFS SCSI layout client unregisters this way at umount. A later
> mount cannot register and sends all I/O through the metadata server.
> 
> Send Unregister Reservation Key when new_key is zero.

Thanks, applied to nvme-7.4.
