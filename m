Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9B23FC41;
	Tue, 30 Jun 2026 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782781950; cv=none; b=N+WWY5JMumriqQIUjol8yoPv7d97EcoiehbLXmL0f28sJRsV1SFQbj0qJL9Jt7mO9MWbRJ1THDI4EmE/OqRlUztBBlhLDnl+XQlFQx+6ThN9zH/LpkxGzh6qhOssOAUBWEo7jMvQjRQRbwAX2SLODULvEFSkdBpmMz7JkDZ2D8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782781950; c=relaxed/simple;
	bh=ZDJsIauFNP4VSQlcawu7htBZBnjncVxamZAfeCrOtrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEQV/kmFb8adIYM5AAOET2loZN2ycXAEqvtPJyRCDqzvCXYdc44mj0dtU7ILF4xnvhTidzT+inWw68fdfpKa1dfp+5vuK9CYgie/mWJlTH+aC+y/0TKsSwxLSIridnCLC3fd+7ZLWj4W/gVs344Y2eYsHwkOWzU34dt3LNbrEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKBIQYHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKBIQYHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8E51F000E9;
	Tue, 30 Jun 2026 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782781949;
	bh=f4KG/X8MV7QZrgKJunvYu/eMHjk3xLJnP6aj383Xw5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hKBIQYHy9ClqCroiLhVPj/iYZ9jX+pmLL3fkbu4rZTRY36gntSHQrWj8lZiI+Rvif
	 5Fz3prlNEe6Wr6dnpFtVMFjuDzUcQSXAftL4fdj8P21ooE08n2vQTmX5pRuzHfeL1W
	 XwmNSJfJICCCktG0kna7FsdFKktj22DuRF4rXEEMfC44Z8bSGQAbNF/j2A/dohrn23
	 ZdItA1jPk0MU9gqGaERIDOQyr4L3z3m/h/twdJaJvGEncmMpSDbS8PqIKdxVcLbMob
	 wpYrjAq+eTSjAQcjE/6VfzTIZd86aUFMimvUlbO3FJSDMY5yhSyfI+/usYW8ryxL8z
	 sY7d2RY7WLpyQ==
Date: Mon, 29 Jun 2026 18:12:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, m-malladi@ti.com, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: fix XDP_TX from the
 AF_XDP zero-copy RX path
Message-ID: <20260629181227.4418d953@kernel.org>
In-Reply-To: <20260625063121.24746-1-devnexen@gmail.com>
References: <20260625063121.24746-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 07:31:21 +0100 David Carlier wrote:
> +	PRUETH_SWDATA_XDPF_TX,

Sorry for the naming nit on v3 but XDPF_TX is ambiguous, I spent
a bunch of time digging thru the driver. It should really be called
XDPF_LOCAL or some such to indicate that the frame originates locally.
XDPF_TX is ambiguous.
-- 
pw-bot: cr
