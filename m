Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286C25C804;
	Mon, 24 Aug 2026 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570475; cv=none; b=GAGZndHQnE14TLJ0jf9xDnf2rCZS29hGOn812/QZMgxnV8eNZJFVkwTiYuLsQJhH6iljhA8PEc1cezY4e0GqTCFiDYTDv0DjGoS3naoWkRwdcLSyOA4OFccOjgQf4aS0iVyZtcFsnlx1PnMXpdzGffVS5/NO3JsQIAEFN2JLEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570475; c=relaxed/simple;
	bh=av4U54XR2rrccom20YJbedp98bXH+klkHIcB2k5RdLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSEuXRg/7GTTQbggRd5kKPRs6i42Nu7QO0VmnIuI49OLvDWgDoTjU9+OR8qUORVcBNjAqsRegZwBj00KERl+/bGY5WE3ZttW6Nee6GPPnuIv3qYAs1eZ1afmW6+JjBBz5P4XF2o/x0j1sVUIEZG7WEeCmxOGFq7HPhLOCmu/OhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7sXyiGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7sXyiGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332CE1F000E9;
	Mon, 24 Aug 2026 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570474;
	bh=QnJ5LMdcph4qD7f4K/BmnOHZgaFdwmCrkCJ06SmDzF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y7sXyiGJ2Dk6vOoD2zWYq10caZOr9OZGDzVpm7cXxz6jQz22Uxi0KvgW+GPnmL91p
	 5FHr0CGxJ+dPd2um7RRF8v533qwYIK39Uum29F772c4lgscgsdQ8uula3bxBcO/wSI
	 P87YkdgiKaRkC9OCqsags2XGMRQ72rDG0wsFb9jlaJTW5zUCw/QP5wx+zZgaFpvYEc
	 1sznY6iqGtPVKLdYZC2Z/F4sozWhRgAVT+lBkLyETHcMSPU+kYS06QyBnVHK0zy0Bo
	 4VhnmnJSJY6cV5fApgVS9xp1rkSP+hWSsdGlcVTyDfb+dH0VbVNCjqx8/jmyfFwwB+
	 +FRLIFF8xhQVw==
Date: Mon, 24 Aug 2026 12:21:11 +0100
From: Simon Horman <horms@kernel.org>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] net: l2tp: do not propagate multicast
 notification errors
Message-ID: <20260824112111.GQ265046@horms.kernel.org>
References: <cover.1787247008.git.zihanx@nebusec.ai>
 <54f48e812ca0424c47ffdb9a8182180921f7e6b2.1787247008.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f48e812ca0424c47ffdb9a8182180921f7e6b2.1787247008.git.zihanx@nebusec.ai>

On Thu, Aug 20, 2026 at 06:40:28PM +0000, Zihan Xi wrote:
> The tunnel create, tunnel modify, session create, and session modify
> netlink handlers send multicast notifications through helpers that can fail
> while allocating or encoding a message, or while multicasting it.
> 
> For tunnel and session create/modify, a notification is sent after the live
> operation has completed. Returning a best-effort notification error as the
> command result can therefore report failure for an operation that already
> committed and can cause callers to retry and accumulate live objects.
> 
> Keep sending notifications for listener visibility, but do not propagate
> their best-effort status as the command result. This also keeps the tunnel
> modify command consistent with the other notification-only paths.
> 
> Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v2:
>   - Extend best-effort notification handling to tunnel_modify.
>   - Follow the existing bare-call style instead of explicit (void) casts.
>   - Document the observed ENOBUFS and committed-state reproduction.
>   - v1 Link: https://lore.kernel.org/all/cover.1786962220.git.zihanx@nebusec.ai/

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

