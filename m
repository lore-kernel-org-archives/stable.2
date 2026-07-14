Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623638B146;
	Tue, 14 Jul 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041242; cv=none; b=Q2ud8/s/M0BynnEr254ZoTuuzA0ROb42Yt1Yr/29xsV2EtlT9V8lJbPtO35zZF+9k1HloiUkOyaLZsfN3h2K5HcPJRWVwwA+kxTIanY4/jl2x/XT3oqGhVFwiwybLg4/3/F1HqsHgHVBOreJcC/HPyqgu/Ood+MpPl4fHxvwIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041242; c=relaxed/simple;
	bh=84YDv+UpBD/I6YrK+e12b/0UjsQw0Y646XLkvhcRkMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+SB2cv/G7vmYqIuda1xGjB+3HZmHd6PBX+Oo7x9LliovlFhFB7v1D88FP7uI5UU/un/drTxQ47j2XUaSR+04E9H3vjsmHBI49zBh6y6sg2Nufo9+D4lJOEj8YCAEBkaCYgr2VJXHTfEhUrQEUK/EBoawH9lXeVq3ovR7GS5zHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBxoa8DS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBxoa8DS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFFA1F00A3A;
	Tue, 14 Jul 2026 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784041241;
	bh=jvisue5QPH6gBWf5Ajo7QVKxcBk4AHOQBMnbNhZWhMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JBxoa8DSQH3dpepqMHLAFDRVZiLzaaF39XmBG1J8hvUs12cUW011ITxT4xIw9xFlF
	 bGRjv7XLDolkfJDY79GoMM9bz24P4Kwi2dMjraXCYb2xAwqZKYYByq13HDq2VONymU
	 T55vX9YJ3N/1XeidPaZat9jp3w3WQoYikNLQxAk9i7c0wpzzZD/dzgb+OQoKaSU4HD
	 77Srfg+kpG7BOf0QxyxvOxhpOQBTVCXX6DAL46w8pbDne9PbUhL6hG6VQeWvkK+bmX
	 PAVm6a9aCXMAuBanxihaD+fv7XpgO1Y0wBrEStVuWurga+GYp9fj4spJ1E0YEa/kOm
	 KZ4eghKGkz2Kg==
Date: Tue, 14 Jul 2026 17:00:37 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Wolfram Sang <wsa@kernel.org>, Kaushal Butala <kaushalkernelmailinglist@gmail.com>, 
	Shawn Guo <shawn.guo@freescale.com>, Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Carlos Song <carlos.song@nxp.com>, 
	Stefan Eichenberger <eichest@gmail.com>
Subject: Re: [PATCH v3 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <alZO9GNx51oPBQuP@zenone.zhora.eu>
References: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-for-upstream-i2c-lx2160-fix-v1-v3-0-073ac9e103a5@free.fr>

Hi Vincent,

> Vincent Jardin (2):
>       i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
>       i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)

merged to i2c/i2c-fixes.

Thanks,
Andi
