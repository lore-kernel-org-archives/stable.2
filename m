Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748531AA9B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067509; cv=none; b=O2L5bjm+GR+MRLac6IA9/W773s0QAirXwd0QW9IXVsBdG6kYja4Pi5vPkD2sYzqIM9pzhWFRjG/Maws7P5UfnkIjBZjtoox7nrPtHc332m1/95gLIUoLguBwPswweFjCMY7xO9dC7w3V0GTsk7YmqT72fwbWlziLJ/hgpDAI9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067509; c=relaxed/simple;
	bh=6K8D2vopIAB3r8IWN30DgjYRVY80h1yLRAdA8pQnL5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5n2rGvIXnMjW2HKcS4dN2mKqleXLGnqd4FG3UVzw/j1ZMuyZJ7O8CJ7qtL7e3aeLOI89Y/1RzgnwS4lI7n1R33H04Eb9e0ug53Ng0cgNTdZ3E/15kARJB+aSOhC9dSgg5PyItLEBZ677z/5ubtZxIrvRC0tjWHrsU1PGf6tBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot+pZ0yu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot+pZ0yu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1C21F00A3E;
	Sun, 26 Jul 2026 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067508;
	bh=Iv135MTdSimsQCQJCBvM8SOICHPNETxwT/oGqNxUlqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ot+pZ0yunbH+y3+7qj4xdFWYx0ncdsMGzUjDYnswMWqc2Zhrp6LXIaIaYN6QFUyQo
	 T/XhdNuSOAipItWr0lhi5MTZbghzFyPqY+/4UTy9/ErYj2Prd1DTfsjJqYmq0yyx0U
	 +co/7PMv5BqPX4mBlvuSxiIQ6XVaqXplKJ2t6j6tnaVS3YNDJr2pccHh1/vTJKndJW
	 T7fARHWt3RqFlj2xbfOexaLX+4A3ucQycndLmjXB7YyU62qC8tL6X12KLPZu+3699h
	 tnq2M2vlvgu2Ti/AUQspjDHuWCbtVhkVOnmptjLtK53WfQgphmv0dgqZ5eKWIWgAyt
	 98M5b1Hj6Xegg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 6.18.y] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Sun, 26 Jul 2026 08:04:50 -0400
Message-ID: <20260725192000.stable-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724125909.2967032-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260724125909.2967032-1-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 731712403ddb39d1a76a11abf339a0615bc85de7 upstream.
>
> Once the interrupt is requested, the interrupt handler may run immediately.
> Since the IRQ handler can access channel->ch_base, which is initialized
> only after requesting the IRQ, this may lead to invalid memory access.

Queued for 6.18, 6.12, 6.6, 6.1, and 5.15, thanks.

-- 
Thanks,
Sasha
