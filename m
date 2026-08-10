Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0442643F;
	Mon, 10 Aug 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383276; cv=none; b=cK42iBsJot2tDuwdwPhzlT5Lge2RLv6WBtAmsuvASwvqKkBIGco8biL1Id0Fo83R+Dc4TUF0TD8iIpok6FWmLl7ZbhiB+68FxMkz8zFHyrwQ+3vBCDeVUEppW5VEPoHhVH4cEUCwSqeLmgKlnkWMMnxQhu6TGNbteCI0LE0i00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383276; c=relaxed/simple;
	bh=Sqa+CzardFgcHM/fUT7Ot0ptfGnY6xU2WkYf7CKr7V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKHm9YB5v1aaM2R4mT7Jzr14YhzsND5EJ/ZdZ4ZcHqs3WXVBZORIYRAlYJ4OYvNJyJ7QkqjuIcmFuah28osaIxJ/lmnT7gCOGmRymep+b2X9SMdxiT0vlDg1QOwbn5SSVOhWP2foMhAvdi3TEP+SpNUnTxDFNARt1iqQgWmU+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1gdsBt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1gdsBt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA91F000E9;
	Mon, 10 Aug 2026 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786383274;
	bh=Sqa+CzardFgcHM/fUT7Ot0ptfGnY6xU2WkYf7CKr7V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I1gdsBt06QDRjinAEnXGUKyCR6grbaV+2av9cLHJB1BsErwQ7cm9PZ9L8KexFTZjV
	 842+C0MvL5b79Edq3pzN3V2ui03bBleJPfWhPHz3mu9YP3/ZihHdIBTqfvEnJEZn8e
	 xZ8pXzodOLnxUmMQ/1B8qfySOpT4J03RSxWMfs8I3/P3UGrbJOhbTQaVyiljMe2AXr
	 754GlY6Id4XYJwvh+4v3nUguxvd786m9wgRQKCNOHHAIs+6qm1vFjhns1IVkqVYELk
	 3c12g+6fa7Cmh1r/Zszov5OVYejROsjSoJ5toXVUTpNobNdLHr/ODWnXrDH8MqiQJm
	 P0rVqYI3D81cw==
Date: Mon, 10 Aug 2026 11:34:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: bound SGL data length before allocating
 command buffers
Message-ID: <anoLqGHdyesTN0IM@kbusch-mbp>
References: <20260709132533.44195-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709132533.44195-1-security@auditcode.ai>

Thanks, applied to nvme-7.3.
