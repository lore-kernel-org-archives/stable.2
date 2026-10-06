Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EA49E5FC;
	Tue,  6 Oct 2026 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305763; cv=none; b=b3v4lZfUra2AZnNoIokBg54Dv64nyoO1ELcpscGCBO+ZbfCZmgD9aWywEYB4yQK24ip+l9/P+6YpLknCu+KasTHD+BfnLWHn0TMxs3MkCzieqU4S1VOpJJlU6jdJtaT1veJzGQ1Ft7dZ6tfUFKZ6nCkgUctkFtJU4QY8RXAvYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305763; c=relaxed/simple;
	bh=WUCP/4/zGityBsWzSoht4YsUy3nzQK0grZI9LxwM5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrLuZGJaXvAsSb+IsWo4S+OwUQloeFBBDXNi400WWk4pENkyDrkoM6MjSmsqJ2Bs+KtHcCxFst4+vYfRLC146x15vKjkt1NvHTjgu2pgXH/FStU8Z0SljeJrOghvEUUb567N5jBvAXuLsPXLE47HO20g9yr0wZlvdykFKUoTpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFXmK0Tt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFXmK0Tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0801F0089B;
	Tue,  6 Oct 2026 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791305762;
	bh=L+Xx6TwJDUdsJnZhVKorFUpEpCyoXOB2nqXNRP53LHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AFXmK0TtTCMU7MS7ygHr1+fo2M7iyPr5USAb1NS2aV/FSlwN0hMRa1cds3fe5qYGS
	 qwvhPywOpPD/SCQ7+Ra0w6vj3P1LhePOdE86xDWSlj9HUKVbe0RzfJ8a44PQjtXi0G
	 7bn96EiQf4BMsonyHNlz0N3zVNruLKTfb5miqmGQMISnTEcL8TfvinMDK/8rl4LLOO
	 zapbb1csB/n2Fd18Z7uwTfefbPBJ9yjN42l/pboJtV/3PMDn1Bjkq5JMgdecx84XC+
	 nliNIfpoQd/35pAoB3Osxt4Qi3y7BQt+Rr6v9ANhL79uv4d0uPScUPa5zq2GYnyqaf
	 W0YVIrqDNjfHg==
Date: Tue, 6 Oct 2026 17:55:57 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] net: atlantic: only free the PTP IRQ after a successful
 request
Message-ID: <20261006165557.GO83879@horms.kernel.org>
References: <20260930074023.2943213-1-runyu.xiao@seu.edu.cn>
 <179075425701.31693.17457011245131119734@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179075425701.31693.17457011245131119734@kernel.org>

On Wed, Sep 30, 2026 at 07:44:17AM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi Runyu,

I would appreciate it if you could provide the information suggested
by the bot above.

Thanks!
