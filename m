Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871733DEF7;
	Fri, 25 Sep 2026 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319225; cv=none; b=O37DwcaB7Pmms8hpyZlh6PoTkqYa8H1iTAB8g+IOux7Z6dXDmnV9s+WaJ9DtnFKlAxwlGVm8ZC/HoXvdfE1dLBHHo7w8c3OYm9fviCydPEIgJdZM1HuczeU3Rsj3W/M6arN+DWMsFy4PlQjTN85qzo8pU8R+nPsJQYQSY7ynBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319225; c=relaxed/simple;
	bh=6x2a1yhRl49ahupsMxFf+DHxKjNEwShSqMLQ9tGLQgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axPvcnUsgLPvB4pp+Y6Ae3s9xcoiDL0CWP5okwBTgbP8rtYWaDwtqlsLw7hJ/5ipytyNpoj0ShzNigHRcOtZRut9dcEenlUdM6gYnTcuyVPvLREGPiP1J4GtCKXtDmvtTLrGM9HAIfL+nK5EowQPVPRipncPK768ROGof0ObzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIPhYy/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIPhYy/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDFA1F000FF;
	Fri, 25 Sep 2026 06:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790319224;
	bh=KV1kJEu9MWCxcXdqLjfpsTub2AJOESaQRgwi2TfgLL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UIPhYy/v6lOlVOrdKTETZSFGQOUQDX4VvpgoOAgfsEWsEbR0WGx6L3qbsCmdY984L
	 AXL4dg4kYZaFrLO8YGgfDtN5Qe72DWU5dDtzLq9qkBew6ZKV0UaKfWf6lVobzyr2vr
	 uH5afNmXfUs3SsmRZ2RL5i2b9JqB0ivO86CLDHtGg8X7ulkUlPO9PEUT3eTvzPRi+Q
	 ZCoJS54GVLNIQvIoKxXSXIL3rorzGMkFXrvWdV8+c8L+fVqPJ+oVIhuge680tnMcNM
	 S6B3nfh+f0adbHsBaejq3savqsC8rLoyjYcAYwDemT/IhJIoVo1b8vn4an7rNAzoby
	 qwZEyqt5ju17Q==
Date: Fri, 25 Sep 2026 08:53:36 +0200
From: Gao Xiang <xiang@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Artem Dinaburg <artem@trailofbits.com>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sandeep Dhavale <dhavale@google.com>,
	Will Shiu <will.shiu@mediatek.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 6.1.y] erofs: Fix detection of atomic context
Message-ID: <arYacJ7KdcTO7UDQ@MacBookPro.fritz.box>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sandeep Dhavale <dhavale@google.com>,
	Will Shiu <will.shiu@mediatek.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
References: <20260922200448.27724-1-artem@trailofbits.com>
 <arSoAUX4jDzgY-rG@MacBookPro.fritz.box>
 <2026-09-24-daily-reply-0004-re-erofs-atomic-context-follow-up@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026-09-24-daily-reply-0004-re-erofs-atomic-context-follow-up@kernel.org>

Hi Sasha,

On Thu, Sep 24, 2026 at 01:13:23PM -0400, Sasha Levin wrote:
> > Thanks for your effort, this commit has a follow-up commit
> > commit c99fab6e80b76422741d34aafc2f930a482afbdd
> >
> > erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC
> >
> > could you please consider backport those to stable kernels as well?
> 
> c99fab6e80b7 ("erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC")
> is queued for 6.1 together with this patch, and 6.6.y and 6.12.y already
> have it. I've also queued both commits for 5.15. 5.10 doesn't need either,
> since it always hands decompression off to the workqueue.

Thanks for the effort!

btw, just correct a bit 5.15.y also has commit 648f2de053a8 ("erofs: use
workqueue decompression for atomic contexts only"), so

upstream commit 12d0a24afd9e ("erofs: Fix detection of atomic context")
upstream commit c99fab6e80b7 ("erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC")

are also needed for 5.15.y.

Thanks,
Gao Xiang

> 
> -- 
> Thanks,
> Sasha
> 
