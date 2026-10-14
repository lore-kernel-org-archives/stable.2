Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15A518136;
	Wed, 14 Oct 2026 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984007; cv=none; b=ujs3zoGRXbbpZWw8wHhPkq3BM1VkxAdGhD5bsIkIv/LnhuZZkAVWGwXWvQlVHqsOQtZLtFrOK3vGXb439PZ+29mtTXa0xUQ6439zMrTRKCgYt4IQeGQaspl7HFN+PWAdGfY3dk3NgsTHh84S/jA9o+gwZk/03/irx76jmU8rGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984007; c=relaxed/simple;
	bh=c0PI4xFFoY2Ofu/8qn+CX74d3EunIVd2HRI7DK65jSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFlv3mizNX8fnD73cnt+tscuGLFxpOCWEDDEOvbJTs+aVY+mQnhbkIkYcsX8E9BHaoy2ThZGxsileKcNK1Su24ricX1TPikmcZfJF+d5JqSkZU+wujiWV176hrxke8FsF65q+vZMvGKvTZNBt2x4Y6Zu6NkSM0Mt9AsOqkm71JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5cmBY5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XUQDcmM5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5cmBY5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XUQDcmM5"
Date: Wed, 14 Oct 2026 15:20:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791984003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FpLyD2E61bMYpA7x55WQay0cIIjyZAd7xfQmMzmeynk=;
	b=m5cmBY5EkBOIf9pAyHtg4k/v7Nij0hJ8INNVtxU4Yx/70cUgDVKVs6j3wSnEfNneR/lpWk
	Z9bdq5i1fBubeqBN3OuJQLlYlLMElZa/jTdhIKHnIzpqyjntF0DCSGwbywX62g+Mv0IP8F
	B4OH8HSjy4oZtUbPYAbIrsWu3OjX+FRXEOJVlx3Ay/3U22nGxQqtuYQfBImmEhFRycitJp
	dqLFJYYU4ZLVc135bToDoUpKeoENliaVQ3Rrzd7GbQEZTRRDg2FXJj+sWyPVG4e/pUOrgr
	aDtxhLE6jha1R6Jf3CtwCvatkuryXgdiENCIQ2dWMqljscj4HT3OxYJVB+GGAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791984003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FpLyD2E61bMYpA7x55WQay0cIIjyZAd7xfQmMzmeynk=;
	b=XUQDcmM5X0vDcCR6uyqIu01cI2160NmU8WR2A2Dy9/0LykJ2fyGZcJ5ZbdfbaZMs2HmTGv
	vbFqo6E8vsePrgAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com
Subject: Re: [PATCH net v7 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
Message-ID: <20261014132001.BzOkgyrC@linutronix.de>
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-2-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009201324.17-2-xiexinet@gmail.com>

On 2026-10-09 22:13:21 [+0200], Xin Xie wrote:
> HSR/PRP add tags and sequence numbers per wire frame. GRO can merge
> plain interlink traffic before those fields are added, and userspace
> can re-enable GRO after the port is attached.
> 
> Mark slave A/B and interlink devices with a kernel role bit. Filter
> software GRO and configurable GRO_HW requests before ndo_fix_features()
> without changing wanted_features. Filtering before the driver keeps
> feature dependencies intact; fixed-on or driver-required GRO_HW is
> left enabled.
> 
> Apply the policy before registering the RX handler and reject attach
> if software GRO remains enabled. On failure or detach, unlink the
> upper before clearing the role and recomputing features, restoring
> the user's last request.
> 
> GSO skbs may still arrive. A later patch segments valid GSO before
> HSR/PRP processing.
> 
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> Signed-off-by: Xin Xie <xiexinet@gmail.com>

This looks better than what I remember from the previous version. Are
the bot's complains legitime?

Sebastian
