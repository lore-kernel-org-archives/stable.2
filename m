Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFBC447807;
	Thu,  6 Aug 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025966; cv=none; b=uo3NtMfUnSBcZhlRYtu9etpry0WzKJI9H8B6pR/kOFQ7tkR3AFV+A0JeZ5Bff+MPdlfAYqvmqILAFlwVjoroFH9+ACn2tj80G5kK8p2fOCM0KUf19uRPz4yto955eH9Z0Mkk72kFL5vtMdL7jidguI0pQ4XQ0c1O/YoSRN4J85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025966; c=relaxed/simple;
	bh=OsVkVMqL7GgeisRwgF3b0ngZt3YdevLBO1cqm0xf8/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd3qPG2t1TuFvaP6Bg4S+uDiHA0G9HW4lR1gyUfrGCpkvig75kyhUuWiaLORsLTYqqbLKVALHIN7snmFe7Se/K+DF6rewBrWyApdfhrPMoTb6+HjWXFh+KK+ThQ/cQ6b0E2vyef20rVRCmx1CuxZZ9IS+12W+QBcDbFoc36rXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqUOrblq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqUOrblq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3921F000E9;
	Thu,  6 Aug 2026 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025964;
	bh=Aa5cl/2Rx7Dj1ZzIaTgUDlJE/+cUlRzBL156sTsSuUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PqUOrblqad3gdwSW0xVX/5SGePcA5kOde6ixpbdxu8ewb5HJaOYMbkCSLHL3ztuNu
	 B3EnH07qeIqoNhu262pl1Q9k9lBCklKVh2UAmMDmdHVrZIcOgzsryqdeIDhaEIjWLB
	 rMtd1OaAyoeRUbQoVNo2IhuUHZJPInP0BMoqnriAkrF+X6vERoLcencjm6zastXXtk
	 BiRVJ5shWmf5iMyEi+V6ZWbtYAQEEI4SpHh7Y5gf6EgScSQIKDJBKyt2YSwmL9rO6w
	 wiwajMkT9pDGWhy9rQ7kiBfaoGxJfEgef9ISwyXNWZwGLjwnQ1y+wcbl8XRSzGU1E7
	 zvAspkCFyRNyA==
Date: Thu, 6 Aug 2026 15:19:20 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] fjes: cancel force_close_task in fjes_remove()
Message-ID: <20260806141920.GE51943@horms.kernel.org>
References: <20260805011410.414431-1-fanwu01@zju.edu.cn>
 <20260805012337.416908-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805012337.416908-1-fanwu01@zju.edu.cn>

On Wed, Aug 05, 2026 at 01:23:37AM +0000, Fan Wu wrote:
> force_close_task runs on the system workqueue, which destroy_workqueue()
> does not drain, so it can run after free_netdev() and touch freed memory.
> Cancel it after destroying the workqueues, before free_netdev().
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 658d439b2292 ("fjes: Introduce FUJITSU Extended Socket Network Device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

