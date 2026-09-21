Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7F4AF169;
	Mon, 21 Sep 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003565; cv=none; b=ugnmTl1ugxhuEM2/NrFFoQ65cQyv2E2mForeSrMdsFcjBE4rWq2KmCD+lefDeSB3f0Oxe4FDeXNXrqlTnWfM40H7dwzL1ahox6kUeUdPc/t3tayN/G6jtPSLx2vmKCthKTTPSHDQ5Ij+vlqt+Pwt12Jm5dq3lz+niRxtTYaIvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003565; c=relaxed/simple;
	bh=F723jUb4FX3wnPM8/1OM5X8MykUBmpaUpNENj61e5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz+Av/EYGziY30i8lQdpxHg6VtEy23ka2MsNZsdIOPDbu0fqWxD+FvicHGYlGweGzFHCCl3pK+XuMLxWMRxuvn0RuIvPIh4Ude7FhGAI2nbBld7h3KoYKTizWlO5qYfnGmNS+U/GDcH9K15VIACv+K3AbCfsY9SvFiYJYNM9peA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZWRhl3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZWRhl3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82271F000FF;
	Mon, 21 Sep 2026 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003563;
	bh=/EGmor+rdd8V7CS1kyIpOAdpprLtqx5XjF9/vJmxcJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZWRhl3pg8o59qzvTFx/lJ+XE1Qdrn5dXre5AL/yLwRFdIpscv9QB0esbtt/MnQnS
	 VfD1cPA+CTdjjjK1rc6vgw8LrxAdYI77GSDZcyj/HNS5+RRcQV/wFgfPFHKdWlajHB
	 ah1WepHkASgIFqUEdrhQtr+4RkbCP8A4FxwxkvQvWpCTcIcJ156AlIsybxnCHwOK7C
	 PZE97TGL5AyRMw07TEhOaSZyB/JF3rRY2N3vYZyyR4MpCRbbTgFSOQN8epZBRKvpN/
	 mxeoxdCs0NiUUb+E651qVTR9KL6JKb/4I9ru3tNmDZpLAscus1iYNUGMiacFnydlAZ
	 ZAh5+5vhAknFw==
Date: Mon, 21 Sep 2026 17:12:40 +0200
From: krzk@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: horms@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	edumazet@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	david+nfc@ixit.cz, davem@davemloft.net, kuba@kernel.org, sameo@linux.intel.com, 
	oe-linux-nfc@lists.linux.dev
Subject: Re: [PATCH] nfc: llcp: Fix socket reference leak in
 nfc_llcp_recv_ui()
Message-ID: <arFJYpnDIpY3VdAr@quoll>
References: <20260916073424.1971784-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916073424.1971784-1-vulab@iscas.ac.cn>


On Wed, 16 Sep 2026 07:34:24 +0000, Wentao Liang wrote:
> In nfc_llcp_recv_ui(), nfc_llcp_sock_get() is called to find the bound
> socket. If the socket type is not SOCK_DGRAM, the function returns
> directly without releasing the socket reference via nfc_llcp_sock_put(),
> resulting in a reference count leak.
> 
> Add nfc_llcp_sock_put() when the socket type is not SOCK_DGRAM.
> 
> Fixes: 968272bf0087 ("NFC: Handle LLCP UI frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/nfc/llcp_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



