Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620E388360;
	Mon,  8 Jun 2026 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947917; cv=none; b=eGriTXxF0ejAkT0ZGf5FdyfRMOruQIW0BIY0uPdb46BMiDk+oLackeLjk8smvmUspV1K9TFoAh3ak1HabNjfaPHd8gozbyTOzipH8BK7enHlT6aCqVSsIYuqxsjVdz/N7poap8K6FjJmwdl+AwqjHfu1rT9YFvLlFWGoXIJ+psQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947917; c=relaxed/simple;
	bh=XQ11Rq1e58nQgzUhJEvKxGwl+m9/K14suhoVGq61YTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs3buC3oxQPnN80SjiQxp3gANqw+2ZxZ6Fqt7UFfSGMbEv1nTcQWy4qFYP/bC3HF+Yqty97rDdpr4hkEgjjc5Mic5tAovLlgnynje56Okj+SNNqY5g9fX69fWTCLdsapLlurXFSnVViTcFSewuLoAe7/BAgzha/9ZsBId+osK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijWIg8hE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijWIg8hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51AE1F00898;
	Mon,  8 Jun 2026 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780947916;
	bh=nOUM233BkDBWLACgplH8WA444SMzwf33kfGfAapuszI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ijWIg8hEXUjPIsGy30fNPYYxzPq3N1OHeiab4V3QfTyUN7SmS+ddM8BHST4psVUw8
	 JVd48+84OrFEkT/Wmd1ljv6pgmk/szWVRlpcquySAwMCwo1GU37BvOVV+HbczSeDS3
	 DqfgkSH5G/IGDA3y/m1HT1BlIMs3jSDrJbhDh5wo3IIQ9wsiWCUmqH/C3qODLC1JRi
	 juw2KI2WBY6ye8L7hAZUTl7LWXJ2u2Iw7CIYbxGLM772r/CjqUarLmZNXqHyxc2O2y
	 nvnRuz1ERBMws+VH0h2/bX37JVlNDrqChe8+Excwz7iLUPgP7N2mIzY06PNaNSuErd
	 qbEQsmgnVFSSA==
Date: Mon, 8 Jun 2026 13:45:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme-apple: Prevent shared tags across queues on
 Apple A11
Message-ID: <aicbyoYG_XFUkocj@kbusch-mbp>
References: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>

On Sun, Jun 07, 2026 at 02:10:58PM +0800, Nick Chan wrote:
> On Apple A11, tags of pending commands must be unique across the admin
> and IO queues, else the firmware crashes with
> "duplicate tag error for tag N", with N being the tag.
> 
> Apply the existing workaround for M1 of reserving two tags for the admin
> queue to A11.

Thanks, applied to nvme-7.2.
