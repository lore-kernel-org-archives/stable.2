Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F438656D;
	Mon, 10 Aug 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389656; cv=none; b=vAMF+BuF/flHlRHooxJcMA/4uFNYsBTb6/vKZ3X0iFiam/xtvmV4DpMpoFslHb7cdFJk8s89ZhP4uYEeB1BR9WQIt20ViTJitMVs0k0W4mJhqPkXgPJ+CtPamur3Uq4cdmxSJgEi8Xw3ljQ1YCYaNruWB6sq4nUR2DayfKi/os4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389656; c=relaxed/simple;
	bh=Y0Ln4riyZAJg6pVIjg3cBPhSuBTlcqjUcsba8rs/6M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBAAE7Hu3qHmJIN10vtzqhgYzXx1je9xWDt6ga74Y3jTpf/pkirMsjEeMYZjZQ//5HanEud9yYMW9UHLzHZcajt3UdnhYMmTnIHt0AftGo9z5ZUuNHsR0kduznpysLdTzcNGVnFPzVllo8OKZBaT3v+7gNRa5h3hVDxP2Of721Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om06GGl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om06GGl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A02D1F000E9;
	Mon, 10 Aug 2026 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786389655;
	bh=Y0Ln4riyZAJg6pVIjg3cBPhSuBTlcqjUcsba8rs/6M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=om06GGl68B0OgnqR2vKe6EzENf2TVd5LvD0EQQoEaWtwFxuyNQ0JzNtgWaQgrAVG0
	 TCMRcx8S/hIrwuR3bq8baQEJJUmoJ8Nb6YBAM/wecVI7PRhVOVCNOP7OcfZ4+KR08E
	 nNB8lqANnSAVybeo/lHRXdfVfdTENI/agNxacJKZwS2VIcBQSiU1gm9JH6bY3P6/Qw
	 ghwEWOIu5i5dM4VF4/PEw8nz3/4/w2qYLazRB5l9HMtrlhxfYlazA/piCYxem2KonK
	 E6YFtvlrx+qjIsKTYCRiKJAJVa01P9o+DwjLAYl4G5H0GoOrNyvsIeurGkQO4X4BxR
	 jGdRCsZHhVESg==
Date: Mon, 10 Aug 2026 13:20:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, eduard@hasenleithner.at,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: zero the discard fallback page
Message-ID: <anoklR7ptrDQwCtn@kbusch-mbp>
References: <20260730113624.1605213-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730113624.1605213-1-yhlee@isslab.korea.ac.kr>

On Thu, Jul 30, 2026 at 08:36:24PM +0900, Yehyeong Lee wrote:
> nvme_setup_discard() always maps sizeof(struct nvme_dsm_range) *
> NVME_DSM_MAX_RANGES = 4096 bytes as the DSM payload however many ranges
> the command declares, because some devices ignore the 'Number of Ranges'
> field - the Fixes: commit records two that read past the declared ranges.
> A single-range discard fills only the first 16 bytes.

Thanks, applied to nvme-7.3.
