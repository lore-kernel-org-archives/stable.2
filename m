Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0328E56B874;
	Tue,  8 Sep 2026 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882716; cv=none; b=DFQhBC08Y7fbVoZcKF8n/QLshNPuTzkxCZ4IlWIW+cIfphlDDsz7OGz5W7QqneC/j7DRDTHDtV2qYWytr2FWt9wYAt/Aaa+ljrtq91Q3k7Rb9yk5dLyYLhcynd9z07Ylsfjq4jSHe1uWDk3vYeHGTwgCIxAtShuYKem60481eO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882716; c=relaxed/simple;
	bh=LADX1LOYxidyceOkWyTdwp3fIcxAaELyMRJ+gR7O/jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMTXX/aw/xg/szc9I/+bdzZ4JHwxFY0itGrV4xMlKZtDr0YzAtvX4t/fO4HP5bIJ/Kno4Duq2doov7ARJCiKqcdes96GXIQ7b+IyS89DTKP9qSXpZd4+soNa3NiD/ELJJzD/2cfDGJ+4ygNuFUsGCTAtkWoc/prBeBEcIbNZ46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHbmCl33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHbmCl33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511561F00A3A;
	Tue,  8 Sep 2026 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788882709;
	bh=J7IuGhb508liIcPeUwBt3LGV28Z4yFIP49GkZYF+YnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BHbmCl33hPh0MaXf3UUoNCYd7Q9ne41NaI1NrXSYpVMkOo1eL7Pw0IYeOQmtHzgp3
	 6PYcTe2DjTy6kkMH3BLN5luMGTQFl5+/a8ygP0xvdGtk6wz1OoOoO5TXMr4xGlfUVg
	 uqZvLn6/l2Tf/U60M6IE5JrwCDfIE4di8NOFJ0EdHydatPUckZbirFKr2Xk5PqSefV
	 5MnaHyKlOjqL30+ck0DK8Q03P/g+V3GnZmXUO0PoSc638pD+4RHm3wx2WlcaJ6jlA0
	 5UQmRITAepUwy6sVo5de31ODpnH/waj5hbdVk+nSWQiiJcbamNjOGiDKKz5s4zA+MB
	 tTrtu6qjhYfNQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3y6s-00000001lQc-3sYM;
	Tue, 08 Sep 2026 17:51:46 +0200
Date: Tue, 8 Sep 2026 17:51:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mmc: vub300: fix use-after-free in vub300 teardown
Message-ID: <aqAvEi0cxbT7Gk6j@hovoldconsulting.com>
References: <20260908150901.58915-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908150901.58915-1-adrianox@gmail.com>

On Tue, Sep 08, 2026 at 12:09:00PM -0300, Adriano Cordova wrote:
> mmc_host_classdev_release() reads host->parent->of_node, but the
> parent is not guaranteed to outlive the host. Instead, store
> host->index_is_alias to avoid reading the parent at release time.
> 
> Also, call kref_put() after mmc_request_done(), as the latter
> dereferences the host pointer.

These are two separate issues and should be fixed separately.

> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")

This is not the commit that introduced the of_node issue.

> Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
> Assisted-by: opencode: deepseek v4 flash
> Cc: stable@vger.kernel.org
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  drivers/mmc/core/host.c   | 3 ++-
>  drivers/mmc/host/vub300.c | 4 ++--
>  include/linux/mmc/host.h  | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)

Johan
