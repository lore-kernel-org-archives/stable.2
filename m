Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961384;
	b=2mkAtzq4kNAwKssHUwCcCsDhs6cKjeleDl4flZcZTjKZiDf3F8PQrPe676f14jN7L2qF
	 YjkHlpQyscZK2ho6pscBFj/0DJ+ck1WWcxNnZYBRTvALDwwaqSnnNuy4aeSNpE0skhFBu
	 IdfttlTmtfCYVXRfoJv+Gf8Dh5mv8DztibpAabYdSQha9ubk+dMTspOY9DZsb+/Fvnwtq
	 BSvxYw5/tBKNFBEQTyis+BTL7ubs7uRIechyaBIpxgHqM5Z59c8zqaFUTALcPhJwX3WMx
	 sDoe4+ukl1AiX7RTUMuhx5RmYSV7N/Kvm4BPy9g5/iVhUTYuwGhlmqNw3jh5pw4btzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TvmVX8vSr+bVv958yLRdJe1gco7tiYKjCsERcZnNAd4=;
	b=nBCNVrH6S4K0UJ9MKVRwx5rc6vZ79/8OJk8lglMHwQrfMISfEDHTOO3VDxBHCJC0F3O2
	 qJV1sVeq0WnZ+CJH36fTYZ3qrM5ICkFsS+PEw8jwE2FEKuxgQ2M/bTpBPplR+73MGOCs+
	 tvz4GVxc51+kgg806oYPoonssGJmTfeHBauDzygoVnNcu4nwHXguFgBzb0eojMxXOtqIb
	 m1Rm/pUliIEefQonB5ulW91nJQXzVs6EJvFCDvNUNVI6GgXsuRuX4Fcd5Yy3/PMkeDbdf
	 g7e3VwQ8ja2M7c6dYCY0oVB63PJGXCqwoGe2LtGCHcjlYqpmcRAKxnTf5FdEjc5RfHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnWSosJk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7D606A333;
	Wed, 18 Nov 2026 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnWSosJk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801201F000C8;
	Wed, 18 Nov 2026 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961384;
	bh=TvmVX8vSr+bVv958yLRdJe1gco7tiYKjCsERcZnNAd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnWSosJkgYFKR2Pbe1O7W3jeoRpvje3nP+JeAueqWAnZ4xr7YkAjHsFp84OzA6H3n
	 iklnJmDhN4P6GbyUEhK0H3tTOsRACuhPbe81BPovNK4e9+GMw4YEd9orOO4qKUKTUw
	 lx8FltcdMFsLX1O5JSnLLq5GbfDjT276C26s1I2T/NJZN8gxshLD6hnvJwTZViW8Qo
	 LNj1quIw7D/x0pc/6OTwTckgaYA984e1J0YWWyOjKjJej8Xf8WLJ0b+22ZF35Jl/Op
	 6IaaAAWSumJGwQPV8mw2jRu80mpIBJYYOsqacreRKxSR2FDKiJlrElvRXwESxmK+uS
	 FG2A5pbVxq6Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: Patch "irqchip/sifive-plic: Cache the interrupt enable state" has been added to the 6.18-stable tree
Date: Tue, 17 Nov 2026 19:23:02 -0500
Message-ID: <2026-11-17-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABe3_aGGSWW2LrPHNtAU8Lc2NqgeOQJrZNma2WzQ-JH+vFyWJg@mail.gmail.com>
References: <CABe3_aGGSWW2LrPHNtAU8Lc2NqgeOQJrZNma2WzQ-JH+vFyWJg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20261118002302.sb-OlvFHxkJpwI2OQl4hmui5lPJPyvzStBng3doKIOc@z>

> This patch makes substantial changes to the driver and how it
> processes interrupts. I am not sure it is a great candidate for
> stable.

Agreed. I dropped it, and the BIT() fix that needed it, from the 6.18, 6.12,
6.6 and 6.1 queues. The same applies to your notices for the other three trees.

Could you send git-am-able BIT()-only backports of 0f214e5bbee5
("irqchip/sifive-plic: Avoid signed shift in interrupt enable mask"), one per
tree ([PATCH 6.18.y] through [PATCH 6.1.y])? I'll queue them. 7.3 already has
the cache patch in its base release, so it keeps the original fix.

-- 
Thanks,
Sasha
