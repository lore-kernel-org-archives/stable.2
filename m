Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA740D570;
	Sat, 13 Jun 2026 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337098; cv=none; b=ISg4eNH+iv3Oz+cOVoF+BSVO8frw8L5ZSc8Mw4Ea1V+S7QrH3kjO90PfFK1ISMJMmTPEzKHxMGa01AQFjltnk6zEmJF+3/NVkLxz9Ag9jKKQR1ufbGmk2a1Q8b2a+YxDAzGWHZHqRb7oWme+6JXBOBJnA5PSWiWIfNEl8DMz6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337098; c=relaxed/simple;
	bh=256uR4LpM4e7FNyzKBMHR40z/KoZybpWCGfIh/RgVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAOqbH7rlLV72L2GtOvCevlMQIy5AomkPmvlbC0uh17V3A0pKrXWH65DG2xanoqs7AYwXCj7UM/PhnlkIQSPTMNstp1l6JWR9/jsHf8Hdmw+d+ydO9oIjCT8pf6sgHLdguTWGsSEwlGX5x0PhV5wkooAT2ZQbkfSjy+Kyu7T39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJUQHIQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJUQHIQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0FD1F000E9;
	Sat, 13 Jun 2026 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781337097;
	bh=8PPuCzndMKQxvDY+EgCOLrct0Wvkm6BGNBJySAqFSMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AJUQHIQ3zY/9D9uxA/4HAAUkQV2yV89JU2YJYsW7w+Hy8TZZ5XCJC5heLXmFSJDID
	 Vy2IgoRi6Jux22x49sgGWTvykA+pJnizvy04/aVDjpcVt1lCmSgbfnE6USIXV7M3km
	 AJoYMpwKb3uCrI1qQwYIUwv8JW2uBqoccTOS73ooQBIjouJJSlHCBLUX/2igvyazsO
	 tpyJ5K6VTNZkC4lWuIcIMS08+dwWFH+f/4QqH0iUjXcUcdUncdCDWvdouxAvMayN7B
	 Lr/hgHN3YUt3maHxp40f/9U3boyYJKC5+1uJa0UjeFR0cryO0GJHyW0eNl+FVYmhzY
	 4odd2ZKpektcw==
Date: Sat, 13 Jun 2026 08:51:32 +0100
From: Simon Horman <horms@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: fix refcount leak in qrtr_send_resume_tx()
Message-ID: <20260613075132.GC712698@horms.kernel.org>
References: <20260611170756.3590-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611170756.3590-1-vulab@iscas.ac.cn>

On Fri, Jun 12, 2026 at 01:07:56AM +0800, WenTao Liang wrote:
> qrtr_send_resume_tx() acquires a node reference via qrtr_node_lookup().
> If the subsequent qrtr_alloc_ctrl_packet() allocation fails, the
> function returns -ENOMEM without releasing the reference. This results
> in a reference count leak.
> 
> Fix it by adding the missing qrtr_node_release(node) call on the error
> path.
> 
> Cc: stable@vger.kernel.org
> Fixes: cb6530b99faf ("net: qrtr: Move resume-tx transmission to recvmsg")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

This appears to duplicate
3b09ff541145 ("net: qrtr: fix node refcount leak on ctrl packet alloc failure")

-- 
pw-bot: changes-requested
