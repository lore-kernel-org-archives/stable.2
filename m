Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EB3C8C52;
	Tue, 16 Jun 2026 04:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583653; cv=none; b=isfl7PhuEpa0vejlmeODwgb2o8LM6B0rYFS4OT7y32gjpieiv8mFaupgyq5eYzMpx0f1YIt/CTDiir55F8s2WmP9V7WUWqHec7bDuoVU4lPewRPXNwgCVPdhja5WUJS2u14VIE8C5257PYj4TTGUzYaeDYsHKzn3ePfWCc2FE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583653; c=relaxed/simple;
	bh=kuYuyJlyFwP8rCqtF/iLW97jrlFHOoBJ1HFbaTgxsXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU2FAxNTaUOOQalwfmKP5tJezlcYdjreGfNmF0aFhqCPNua4KU16KZ9Xd/UXDb7iXIQwzaSSi/VyTdZcc0sUqekd13AjB4GZZMpldYIZb7fFOJWstoAJ/mKbbHTp+DRbklOnO6e/b5k8oxWiQuPI0t6TA1UNJDEq18LdQL0uhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLg3Kmfa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLg3Kmfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF06D1F000E9;
	Tue, 16 Jun 2026 04:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781583651;
	bh=7Tcg+1GJwXzaapcROEHo1QViH6YgQaoh9TZcwcgDtXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uLg3Kmfa84/3RSsI1lUf+rX7a8j3lgAAZZuYjSLc2q5mJoClAF27W/DR0/EQzAl0s
	 I7B3S64w4UmstIAdPeJuxqO5L/zkPaF3QNgCgaTetUuxf6mBMw4wkUuIxoGR4UOzvX
	 RVrrFG5cXVU3cpjvz6nteEyzEqAxj12Ax8Oyq5XQ=
Date: Tue, 16 Jun 2026 09:49:47 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nazar Kalashnikov <sivartiwe@gmail.com>
Cc: stable@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
	Kalle Valo <kvalo@codeaurora.org>, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.15/6.1/6.6/6.12] wifi: iwlwifi: fix 22000 series SMEM
 parsing
Message-ID: <2026061636-alike-triumph-743d@gregkh>
References: <20260615122100.137560-1-sivartiwe@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615122100.137560-1-sivartiwe@gmail.com>

On Mon, Jun 15, 2026 at 03:20:58PM +0300, Nazar Kalashnikov wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> commit 58192b9ce09b0f0f86e2036683bd542130b91a98 upstream.
> 
> If the firmware were to report three LMACs (which doesn't
> exist in hardware) then using "fwrt->smem_cfg.lmac[2]" is
> an overrun of the array. Reject such and use IWL_FW_CHECK
> instead of WARN_ON in this function.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Link: https://patch.msgid.link/20251110150012.16e8c2d70c26.Iadfcc1aedf43c5175b3f0757bea5aa232454f1ac@changeid
> Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
> ---
> Backport fix for CVE-2026-43172
>  drivers/net/wireless/intel/iwlwifi/fw/smem.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This breaks the build, how did you test it?

thanks,

greg k-h
