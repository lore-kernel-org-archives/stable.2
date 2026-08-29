Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6D3191D3;
	Sat, 29 Aug 2026 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788030402; cv=none; b=k2Fx/ks04HDDBdLbNkvZuK4vLh4bqQe5s+/RnZKKvqEXbuqXBlW+Hdv6GW8Ka5APFyBfrjtfNSshoUs0BZLGEztwaNNqXQHQZ3/6OSJhkPN2M/Y1l+Mh8BbuCMh+G1uMKuR40xq6jFne48UsV0x4bwok9eEyEotp/3CmgYrzE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788030402; c=relaxed/simple;
	bh=niY9tu8qK+KEPMSNfwVK0qAi38cIvhSEIq+xT3D9XSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpgFKoQ3mTFzIak7Wl/Xjal/a1xRgPiZ0kglDdJD3OqFn8bg2oQVbrNqvDRKl6YCDjXdH7RMAOBN/fXN3U6Wvf0xgvLjuLcqULvWUSNTZReG9ysCXTfMr5B//IEY99aMaKYD1orrIeWblrdtgv7TbpOKYAqcrxs8Fmryrh0pvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSw4cO7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSw4cO7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033D31F000E9;
	Sat, 29 Aug 2026 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788030401;
	bh=Tb1BLYUfh/d3GZ4bIUl8P87FLYmUhsHXohmvEC9YFSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YSw4cO7Ju5ggo2YsaA4EZbDOYr21Q5mzK/WESAQASnlugKdSrCSYr6DqHvqud4k5g
	 zmfgdG56YuKAfpXaNSaQGZ2yLCPEFYb8fFqqi17d0B3BGUH2nfTT7wwTMDppLo0AcV
	 W4QjjdhH5ONSE9O+ceOL7Q2lDd6Nl4hwGZTjgQYxpruQY+6QdOdIdPnN1HiioTxp/V
	 0Nn03Y4x8h0bPIQueuhCcnVQJfUUSZwIa5/xRvu8pIlMmwJmeZjjax6xooOROdqSd7
	 IrrTOfd6lB3v1mU2wIuiIwHLxVN2tmVFCOEhDUzJwYkSPEQVwSb/F2wC5R6svX4rnm
	 87eFjlt43aA0w==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Date: Sat, 29 Aug 2026 12:06:32 -0700
Message-ID: <20260829190633.4576-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260829190327.17400-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 03:03:27 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sat, 29 Aug 2026 09:15:08 -0700 SJ Park <sj@kernel.org> wrote:
> 
[...]
> > Let's not add new topics.  We can discuss this on your kunit patch.  Please
> > ensure it covers at least the corner case this patch is trying to fix.
> 
> Okay, I will ensure that.  Should the test be sent along with this
> patch (as part of the same series), or should they be sent separately?

Please do separately.


Thanks,
SJ

[...]
