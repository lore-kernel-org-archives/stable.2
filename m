Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2753FD26;
	Tue, 13 Oct 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906319; cv=none; b=KBdH+P73tnsd/hzdXvPR80RLx0bzkyba31uWiEdGe/+dYCk2itWV7nHvaLMm+CtrhsoK9VB1gPg9Z26QU4ATYa+z6iWWRCkyKSwjj1Q1qSY9W+i7NtUauWqXROYmtQGmnHxTs0zu5m7A4KIDPHxt3UtDEv3KI6tHPpEcAza+Ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906319; c=relaxed/simple;
	bh=J9Rkj/vri+gY7PP7i5/NeDVoDEUx6URnntw2/8mpxMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asxAotK121mKLOq/md/ZrGgpx1hRUAk3GHusDk8K6mouXXRRZRDrGAomP3Ou++1hq6/wB5+WqHXGLeVc0Wt8W5uYrTPafqTMc4HIerKoEhWoWcf0opwHmhwkQKyefc0c1O7+sYfR6NBewnKaSAAhF2fdAKX3WsJ9JJrrfOF9SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up6nr3Hw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up6nr3Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902911F00893;
	Tue, 13 Oct 2026 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906318;
	bh=b0oNPG2rhcf9mZxkt6X2VxPmRCkU8KQ8K0d4hglUL+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Up6nr3HwjKWoAv+rLOOUmunrYynGUmwYnwci5vIN9nkLKlLBt8KRdin8I5h91QzfT
	 uIBV7+J66aQcSRLRi+vLxHestQg/hKo4rGfzZ5cLMCbPq0Gv0LxVii0eMBc9QtGplh
	 BCYFJkoGNC42gnBl45sZ1b7rcr/+xr6Odnk16WIsJLJLld6qpPJ9e0ewqsBHugtVif
	 JnnZ2PNq8rC892zhksP1tebRuruQBiB5gGBuxkLaaPJDs5GJ66P+fV6YC2bwE4fHYZ
	 /7ngKJBUEXQ/b7JF68nq7Hl7sIWRhawgR9lfkvnLW9t6qgZUrqcJAqMcke7JmCQqYZ
	 UsOLu0hwh8gnA==
Date: Tue, 13 Oct 2026 09:45:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received
 buffer
Message-ID: <as5SDPfZx8Kgqjb7@kbusch-mbp>
References: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>

On Tue, Oct 13, 2026 at 07:28:12PM +0900, Yehyeong Lee wrote:
> nvme_query_fdp_granularity() parses the FDP Configurations log using
> sizes the controller returns, without checking that they fit the buffer
> it was given.  The log size is only bounded from above before
> kvmalloc(), so a size below the log header makes
> le16_to_cpu(h->numfdpc) read past the allocation, and a size of zero
> yields ZERO_SIZE_PTR and faults.  Each configuration descriptor is then
> dereferenced (dsze while walking, and nrg and runs on the selected one)
> without checking that the whole descriptor lies within the buffer, so a
> descriptor at or past the end is read out of bounds.  The out-of-bounds
> runs value is then exposed to userspace through
> /sys/block/nvmeXnY/queue/write_stream_granularity.
> 
> A device-supplied dsze that is not a multiple of eight also leaves the
> following descriptors unaligned, and the structure is not packed, so
> reading nrg and runs from one can fault on architectures without
> efficient unaligned access.

Thanks, applied to nvme-7.4.
