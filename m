Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358D2DF6E6;
	Sat,  6 Jun 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780762354; cv=none; b=cnGzGFdppYBHHTGoXhrjjZnK9DqJ4yP0LLUeGCnp6SiqhV9fTHaANcLB4klLHfeE+2D0B1Ag0q6LzOUJdnnJWjYVHsmSmPfu4WQovYhhWjw6V8AyrSXiD62Zot38MCFirV4fdPVSfPZv8/9KxFQLjo7BzkFwjZMiUXve8op8hQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780762354; c=relaxed/simple;
	bh=at0kC8HDa5m8oXa2UfGcEFy83+96ESzZa8qDEaekvSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJLhl+fe1YDEaEu2lzJX6x8iIvQSasePDsTdXdU6U5Fe49KHXUaoSwgoUrp/94btQXRv8m8iLqKmP9ogwbx5nWCgCVHnR6CO/AaQiEJeV/qgMuTJIWBpePTD+GZvOEOWhmr+pscaFPCwYP9iuA0PgljqkQgtqr74C4cRQZZR94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZFx/r/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZFx/r/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979411F00893;
	Sat,  6 Jun 2026 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780762353;
	bh=3WzyYt48G4RQfAKtt5FczP1+tGEO7Yztn+HsGj1d6x4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LZFx/r/wgFyEh7r0VkW0hzkrLcZCGzQoh7wlrQEcP4oQQ8eH9+FucJGz9h6g5VhtE
	 wcAX81orLf6vRq3n1wV0WzoH0cWF9nIPYHRrKc5fDPngfDJV50X2EbKi0uYKuJjT+O
	 /w9HMfhdNCWd3Z1YGQYHtPYnrBetTPo9BKog85Zb5MMIswkLqQmqn664cfQeXR5Wh5
	 31/bSK6ZuwuqQ+NDO0gCjuKMN3LmfleyH3yMITrCX37TSrF/99MyDbKcucA5uc3Hk9
	 AhEhWh1LwZu65s9LL8rhoEpP+9ZKImelmzLXOFTfznxyJPSGyjw54Xsg8ZzKQ1lSz4
	 Y7YlIZY6ogq0w==
Message-ID: <a0b0bea4-998e-4196-a2b0-9fcaf531d9f3@kernel.org>
Date: Sat, 6 Jun 2026 18:12:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues even
 if tag space is shared
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.26 15:25, Nick Chan wrote:
> From: Yuriy Havrylyuk <yhavry@gmail.com>
> 
> Apple NVMe controllers require tags of pending commands to not be shared
> across admin and IO queues. However, on Apple A11 without linear SQ, it is
> not possible for either queue to skip over some tags and must go from 0 to
> the configured maximum before wrapping around.
> 
> If a pending command tag is duplicated across queues, the firmware
> crashes with: "duplicate tag error for tag N", with N being the tag.
> 
> Instead of partitioning the tag space, which is not possible without
> linear SQ, 

Isn't that just what the pci.c driver does with NVME_QUIRK_SHARED_TAGS 
for the T2 macs or what we do in this driver with
	if (anv->hw->has_lsq_nvmmu)
		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
?


Sven

