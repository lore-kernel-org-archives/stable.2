Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622028;
	b=G2yObQnMW+z9+y4SScfuwHSLk2Pceyqyax9hjthlhDtZKvzuNroF3qU5yEuTA6xb+epg
	 V9ISavLfA5kZo9zRQ1hoy/c1XqkVoanNh6pXLJPvgmqOeiwK6wogAXqxbw0tJrlR95gqK
	 xPNc7lprYjPXmWSGWUrtAUEf2fghLlctM6pSRZ7x/CjvrTGbSgeDR+mmLDMNnpLEsFzXG
	 E2NeZQytZ+DSrMwYtOywO5NeefJuEPXTmtmW+nwSkMdV2XBU5717Q/9sYIQBwc3dvKUWe
	 KT2lZ/gleucdo32rPuX6AcNZJ9ZIcj79Q68Z2KidAFpENDRnT2N/YBOKDDsSapKcNkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622028;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TL7mbe/xtrzGTO0Hy7xZjUjaYdh2W2uKzcx2I9ujOoo=;
	b=HaBee1riO4U8WYo+mym5uw/9URYqR8TBJOiNjv054e6SSRgWSSQZ43O7N7Ehr9C2LI73
	 IGTB33d7E7EQtgtZdG1IGJiz3i4jcv83eyxRHgUCrTmUstOF8lHKfCjgbFL1Q3ArVdBJF
	 q2OuAnlPNzGdh/Un6hIkdz+NbmoPc+UCKOcbBme8gu4gH5K7smdBFblTflp0es4mPr5Na
	 4T9p1uFJ4iN9ZpLVNQa2cXM9WgeR8gWJFxP51s5nMTAVpJwyhFW2ZWZr0XqNSok0A2yft
	 u7emwCEdNynTLVPzSRz+Kzv1wTPCCqCcxKOuEp1U9EOq1oLtNxuDclUtndJ1yq1gQPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzTk+MVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF73606A31E;
	Wed, 21 Oct 2026 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzTk+MVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA411F000C1;
	Wed, 21 Oct 2026 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622027;
	bh=TL7mbe/xtrzGTO0Hy7xZjUjaYdh2W2uKzcx2I9ujOoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mzTk+MVdz2r4GfSPYAI3Vg9+cRuW3fDzsVozID7ZKDuEYZ3deqegkdbc/pAFG1crA
	 29acM8lr0vRXc1pyyqYpqQSd7hQZbIrZFpnlfjrdSJl1jNGR/tgbLVA9y8x7l5DfLE
	 dHvmW+IDQzKpzkHpFlRsN/wzSOeChJvzWXfJ6VC47M8im1ktIIsk1ORMqWfuEoIfrd
	 MQaSv6PJIwIxn3jTlMCLBp1Ukqhj1ley9UAi3PFaPIPsFbMXB1QYXF76Wd1yHnHw7e
	 81960ZtKbA9kEY8cOg2Xia8yrEC6uc00H9hGJIV4R24WMm4fxVfaaDf1Ra5g5xV3VV
	 sD4Z+05e7+wVA==
Date: Wed, 21 Oct 2026 16:33:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Bryam Vargas <hexlabsecurity@proton.me>, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-rdma: fix out-of-bounds write in
 nvmet_rdma_map_sgl_inline()
Message-ID: <atk9yQvt7KN_e4nq@kbusch-mbp>
References: <166ea8e3-189e-4212-a457-e0b6e2e678f4@kernel.dk>
 <20261021050748.32491-1-astellman@stellman-greene.com>
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
In-Reply-To: <20261021050748.32491-1-astellman@stellman-greene.com>

On Wed, Oct 21, 2026 at 01:07:48AM -0400, Andrew Stellman wrote:
> nvmet_rdma_map_sgl_inline() bounds the host-supplied in-capsule SGL
> offset with "off + len > inline_data_size", evaluated in 64-bit
> arithmetic. off is taken straight from the host SGL descriptor
> (le64_to_cpu(sgl->addr)) and len is promoted to 64-bit, so the sum
> wraps: an off within len of 2^64 makes it small and the check passes.
> off is then used as page_idx = off / PAGE_SIZE to index the fixed-size
> rsp->cmd->inline_sg[] array (NVMET_RDMA_MAX_INLINE_SGE entries), so a
> crafted offset yields an out-of-bounds scatterlist index that is written
> through in nvmet_rdma_use_inline_sg().
> 
> The mapping runs while handling a received capsule, before the command
> executes, so a remote RDMA peer can reach it (the Connect capsule is a
> write and takes this path on a queue that has no controller yet). The
> host controls only the low bits of the resulting displacement, so the
> expected impact is an out-of-bounds write that faults the target
> (remote denial of service).
> 
> This wrap was reported, with a KASAN reproduction, on linux-nvme in May,
> and the check below was suggested in that thread. The fix that was
> applied, 48c0162f647b, reworked how the offset is mapped but kept the
> original check, and its page index turns a wrapped offset into an
> out-of-bounds index into inline_sg[].
> 
> Reject the offset before it can wrap.
> 
> Found independently by static analysis with AI assistance, not
> reproduced at runtime.
> 
> Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
> Fixes: 48c0162f647b ("nvmet-rdma: handle inline data with a nonzero offset")
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Closes: https://lore.kernel.org/all/LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me/
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Cc: stable@kernel.org

Should be @vger.kernel.org.

Thanks, applied to nvme-7.4 with the above email fixed.
