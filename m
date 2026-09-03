Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274F3CA49D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468538; cv=none; b=IYTdRgDKhY0Q/b0H7JMGR+LYHqFUmnm9j1baPVJ/yN4kEYOajq9raBpHGFn0I7sNM5aEGMfnpwEbbDzmuzreaoMfbZsOmeEX4Gsrem64OaIfqVjbOZbT7VwaPzbM9f51I5bLmvhlkldgSlPEx9T68xepCCAW/AY4heRjc49PLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468538; c=relaxed/simple;
	bh=ie5Geds7gfqDo2c93RxlOINBsqBWxFt7276Yrb1DkP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roj+Eu992M2xDh4mWEyOfDAyZMa4Jw8rnrUIoRKqdz4WZ2GwjSwCFambVBJQt+kHDaOO9UtD7woSbfHmHYTcRzekVNk2FEv61NydRkZkLUf8w9okGtk1L8Se5eVKLIY2/M5OK89mtHS+Wt98rwArmWIiI0kKESCDF00MeLBdKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS880ZAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS880ZAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7661F000E9;
	Thu,  3 Sep 2026 20:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468524;
	bh=Yy/m9qUkPnKb2IqHarRQw9IRMmuVUyDnrHRZIhVLsHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cS880ZAQJ0cVoZbTJpE4Zq7OiqRmyJpaBhvtBz8oeAZzvE7+tWo7esUbKeRjaM11C
	 hMEbxkZE2TG/1cMy/RIxqZzZbJFX5Ys7fnbd1IoMtBLCaBAxxNPMDxXNSpHm0snHZ6
	 mWe8jSTxFKMCjQ9DM2ZPWaz9lem5PSEeZEwUl7h8FTc124FlGIKX1R9+1XGrY2p4lS
	 mQ3MeLW2fKimzSOtNWjB5flNAMPGUdhyhXIBeUn0oKULntV4miryglkhRg6uusursQ
	 2/8H3tJz0xVmIf2bNWnC47lj1t/+1NjYrr522h1kGsQwc9oTmuL3UZYHXPl51cgyYK
	 X5ZKRnDN6cGYg==
Date: Thu, 3 Sep 2026 14:48:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <apndKgstmfG_9i5s@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814143833.1953415-2-cassel@kernel.org>

On Fri, Aug 14, 2026 at 04:38:34PM +0200, Niklas Cassel wrote:
> nvmf_create_ctrl() owns the fabrics options and frees them whenever
> ->create_ctrl() returns an error, so a transport must not free them on
> its own error paths.  nvme-fc tracks this by testing ctrl->ctrl.opts in
> nvme_fc_ctrl_free(), which requires nvme_fc_init_ctrl() to clear that
> pointer on every error exit.

Since the race condition I was previously concerned about doesn't appear
to be possible, this solution matching the other fabrics drivers looks
good to go.

Thanks, applied to nvme-7.3.
