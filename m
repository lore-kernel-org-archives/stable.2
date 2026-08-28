Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F73F4831;
	Fri, 28 Aug 2026 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910593; cv=none; b=UKF3zrT1dufwyO6eVtLU86510YVhE5zDps+5tmzaobaLaOrDGRyA7V3LuaBiL6okYp6FmwBzL0RA6Pa/0zO8YZK+SLQ1tXAUYRNDhtORrqmNiO5pvlJgIasJ7a2L2rFtABxGKRJO+l895ZHxEypZmbZKSI2/d8PbGjsHzL381sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910593; c=relaxed/simple;
	bh=NM9S6Uj2ZfEHJE1FRAkIm9KVbapZUDZeiPPRsl6D7Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOVrAKkePabpa+HC7MvpAK1rNg+MOeplEmLJrIhKXuPn4rrrq+U2eyhKEHlBDpt7jB4bq6s8dQv4N/ZDvUXk76IdrtHgzfK+Lluwj1vFjiLjSN/8H4C8niXFL1P2iDivp7Tr7K7kvfi9CyIxjyfcZBLJJTO925XkBBKFbkrAKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=glUpRJ69; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="glUpRJ69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5IlS3j4hPyerrjvnhcEsksANItIXaok3lxQaoJDREMY=; b=glUpRJ692ueIC28+qK3ws6LBIJ
	suhAPId1bWjXzAqM1qS64aD8ZYfh5dwKg4OJaLpfnATi/wLsOw8p2inE2IOKTplZ7MNHNy9USlJ0i
	Gkx80Ygv7K1sm9YnOmTr/4JtYmlmjv4o0VSQ/ZEYWRTdFgegKNJbSozDkBRYEuPWCItSGyzkvJOkW
	ub6M0hTlNXeIei3ou5rzC9NH/QdDvPTHnOGeWZ9yFIXBm07y9ndoyB66LvnKHFvUO9c8yqt40JrUo
	5vB7GgJp5CwTTO4Yg+w+xqe7XpJn0ocsDt4PsJm7AymZZhsxvRSV38Xihjg1kE3cTU/2gL7qtACqM
	B4VSBppA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wztD4-00Ggir-22;
	Fri, 28 Aug 2026 09:49:18 +0000
Date: Fri, 28 Aug 2026 02:49:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tony Zelenoff <antonz@parallels.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] atlx: atl1: cancel reset and link works on remove
Message-ID: <apFZbMGEnfRRz2IF@gmail.com>
References: <20260828-atl1-cancel-reset-work-v1-1-9a2140dab074@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-atl1-cancel-reset-work-v1-1-9a2140dab074@cherr.cc>
X-Debian-User: leitao

On Fri, Aug 28, 2026 at 03:48:55PM +0800, Shengzhuo Wei wrote:
> atl1_reset_dev_task is scheduled from the interrupt handler on PCIe
> PHY link down and DMA read/write errors, and link_chg_task can be
> pending from link events. atl1_remove() tears down and frees the
> net_device without cancelling either work, so a work scheduled just
> before unregister_netdev() can run after free_netdev() and touch the
> freed adapter.
> 
> Cancel both works before unregistering the net_device, as atl2_remove()
> already does for its reset and link works.
> 
> Fixes: 03662e41c7cf ("atl1: fix kernel panic in case of DMA errors")

Is 03662e41c7cf the right commit to blame?

Both works, and the unregister_netdev()/free_netdev() sequence with no
cancel, came in with the initial driver in f3cc28c79760 ("Add Attansic
L1 ethernet driver."), no?
