Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3CB43F09F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428053; cv=none; b=sM1De3u0e+hK/nLT5Xh9Qk1V6wrtgppunaD/mfmnwgDh5mrIS6dT8nhGusJY6/ioBXIWrK59rEInoyb0JsaUso9jWgJAxsauAjRI5YbeMHmqUQ16uKJdT1+MGj34AkTrCv/CyNJ2n33Y0oM7s1Rza5dMgDR/5QXf9HZfTzBwtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428053; c=relaxed/simple;
	bh=lq0ZQop5uWHeKrka0zWnetjzeh0ojChl6t0oFIEuZw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/QLDGGF9GBTwSOtrXv5Ru4nhAqlotVyWJil/Bb0eUKXoWJhLIcQ5A97EGIS+6WBo5hBc/wlEA2c44aLSInV8j07z076pA9jkC28Hq3cIw9LwhPxoEqSF2+peemtVyGIW/X/SaoD8j2QcHsQETjBmoZhJqHvkCylsQgZTq1MfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKiILvcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKiILvcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E85A1F00A3F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785428052;
	bh=UiD/QWdym9NjT5dGSlgoWYwu8vBcbIdq6wH+JV80kWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GKiILvcPJ8KEFglfwJpAHdZQbQa3I3y2b63uGAgz9Vsa0UOEPRwhqdZv9NlJkaBuw
	 qr4TAmJBYyJHK9wpHYKiBiaMzdPyhfl1R+F4AEpX+Bgil0FyWLICUAd7En7dpPNzIf
	 8lzd0ZMAZ75CETnMSw1hq3nYtJbf3uJCIrdNtPTJf1pkPP8sS/fYWzWVvqNSfgQqSP
	 kM4U5vw2aH9hMWmbYgsULTFnVyHe+AYl17rFDhYA2ZFS4EKqNvEdWDHz8VtpgfY47J
	 2rEYuAdjqXye5dFebeSrIpwtuIu4abBqw52Ds8qP2Vtu4kMR26VwTD164hDMeSl8ou
	 hXcepKkcGeY1Q==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e03c2763so195929166b.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:14:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqafZy1TtV31kt3EZUbpk+AsIYfJafGK2HdKJ5u4Kf0dscJ75qdN6+hQU7KpUtOzek3FQIySOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNowTxhZrkbFcRrRhScQ/D707q2OZtrQSZREhBSfQ3Uw42v4Mq
	ufdnf0qg/q8UBsLHcZy0bs/Zqun56eDXJyyztT4MacF9bkbX3/fnpj3KFXqyYJKHJiRaHROPw+N
	sk7ffIYLtKCT88Lt5gThYTb4k0t+dS80=
X-Received: by 2002:a17:906:af4d:b0:c1c:2c32:1159 with SMTP id
 a640c23a62f3a-c1fbd95431bmr37684966b.26.1785428051242; Thu, 30 Jul 2026
 09:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com>
In-Reply-To: <tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 30 Jul 2026 18:13:58 +0200
X-Gmail-Original-Message-ID: <CAMZ6RqK4CAtqAxHFS2a4e+kwJvRYyeo9EOM+_fV=n1Yjrcj3ug@mail.gmail.com>
X-Gm-Features: AUfX_mzL6HsQQwCG3cXWhI4j1UtKfXOw3JIBuG1alrBD8PgmPX2kBP54BAGXlpM
Message-ID: <CAMZ6RqK4CAtqAxHFS2a4e+kwJvRYyeo9EOM+_fV=n1Yjrcj3ug@mail.gmail.com>
Subject: Re: [PATCH] can: dev: can_put_echo_skb(): free skb on invalid echo index
To: Cunhao Lu <1579567540@qq.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu. 30 juil. 2026 at 17:03, Cunhao Lu <1579567540@qq.com> wrote:
>
> can_put_echo_skb() consumes the skb on all paths except when the echo index
> is out of bounds. This leaves ownership with the caller on -EINVAL, unlike
> the other error paths, and can leak the skb if the caller expects
> consistent semantics.
>
> Free the skb before returning -EINVAL so that all return paths consume it.
>
> Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
> Cc: stable@vger.kernel.org

This branch is just a safety net meant to never be reached. While the
fix logically makes sense, this doesn't strictly require a backport.
That said, I am not against this being backported if the stable team
is fine with it.

> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

> ---
>  drivers/net/can/dev/skb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f8..44ebeba99837 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -54,6 +54,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>         if (idx >= priv->echo_skb_max) {
>                 netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
>                            __func__, idx, priv->echo_skb_max);
> +               kfree_skb(skb);
>                 return -EINVAL;
>         }

Yours sincerely,
Vincent Mailhol
