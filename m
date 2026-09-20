Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7B3264D9;
	Sun, 20 Sep 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789910411; cv=none; b=DQb/66DMhTx6ZLvgVAWe39nENxd6zGR6FxXtQFunBY70AnDU4wGhh+3g8YSRps21kW30+VrYP0eQjVo7c4QiKbst6O+oBmU5X6fWfyhZ9LCDvh96C4JXhcX0nxHJ5ApTOzIbUnOrNoy4YX6Ms+qEZCwXVpyosxpTApO+02nQeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789910411; c=relaxed/simple;
	bh=T+VFsNEimWOmCWeQN2AvdPJYneHU6r5Lgh7xEdroxvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNWFJ+5KxJHxHQU/F/cLqJ8xELq63WJKukDN/LKcr6Om7AHpwsJ0GqhVyLV8qr4InjhTJICGG7jNSuvLTrHafpUHSdvkT07yTaa8rksQmC1EZx2wlHeTTzNM57im2OoipaYJ9bF3GlpvQS3OLzdNlOjJBTCQbHtc7zFgGD9Iwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=utCv7/H+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="utCv7/H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48BF1F000FF;
	Sun, 20 Sep 2026 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789910404;
	bh=pPFVXIeyUzoKPDgRYX7SBIEkwWiNuyzRuLcAvRm8EJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=utCv7/H+2eF280Ci5OigggL9Vfd23kpmDIoYr3S5lSN1GJR7Sam27oxd5f+a41Arn
	 +ezjtetiWSqJyndy9WseoObXg/djoU5VX7oqViolnV1SbBpGezDBKbISIBDCqhCnBI
	 yETjpj9x+kLA4w9Csm3Rrr7H3RX3wio1WGgDpqvs=
Date: Sun, 20 Sep 2026 15:19:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.12.y v2 0/3] mptcp: fix recent failed backports
 (20260919)
Message-ID: <2026092050-wisplike-trustful-6c97@gregkh>
References: <20260920094135.2431797-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920094135.2431797-5-matttbe@kernel.org>

On Sun, Sep 20, 2026 at 11:41:36AM +0200, Matthieu Baerts (NGI0) wrote:
> The following patches could not be applied without conflicts in this
> tree:
> 
> - 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
> - 42064de57fb8 ("mptcp: close race between scheduler and state change")
> - f3ef03357396 ("mptcp: fix bad accounting in __mptcp_subflow_push_pending()")
> 
> Conflicts (if any) have been resolved, and documented in each patch.
> 
> v2: Drop these two patches that have been already backported to this 
>     version, but git didn't complain about that. Instead, resolve a 
>     small conflict in patch 1 ("mptcp: avoid unneeded actions on subflow
>     reset"): decrement the '__unused' variable.
> 
> Paolo Abeni (3):
>   mptcp: avoid unneeded actions on subflow reset
>   mptcp: close race between scheduler and state change
>   mptcp: fix bad accounting in __mptcp_subflow_push_pending()
> 
>  net/mptcp/protocol.c | 13 ++++++++-----
>  net/mptcp/protocol.h |  3 ++-
>  net/mptcp/subflow.c  | 11 +++++++++++
>  3 files changed, 21 insertions(+), 6 deletions(-)

Now queued up, thanks.

greg k-h
