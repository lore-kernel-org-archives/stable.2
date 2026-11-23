Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461142;
	b=o8jRfpHfPgLDGrwOueaPJSK+PZ2+KXdYkitG99hY5XNGe+4dsv0rCq1LBAv597GpDD6w
	 7iHLr2nIsbiPQoaZqe5EEIWJuYMdHjjZytABEJH4iVrajAGMfL7ij9evIbbE3jGaKxWSf
	 dBSgK+D7gLg3VsGY5mHdyO8shGMXCeJjGoZfiL1BQyM2OxJAMf90QbiPktX3nKr6rHD0g
	 gTHawPhRrh0lZV7dwKVmD0Tp9yA0uT/WEYy9KZztsNDoSf8EXDm6rR3Ug/eN7hSWgCinH
	 uNIiaqertGdaV+zHJcqcDBkGqnmM1tHDYYglSfOhjVfQADgRd3FnXGtUzezYZwTOe/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZdUQUp3LwRE1rqDIK9upCqVPp3ZoKJh9GfW0EZyBwV0=;
	b=mBEl7WCCdjJckFbyllwhjLrmaurj9amQO4uUtFEVk2d0Kr/xua8099/ZTO9oEDOkAb2o
	 Zxg8kLU1LMBsnsCdE8XnyBZ2JM6vJDZLqM71Ot3n+mSbOLb1CNyv0HEUISo3rEs27xaYp
	 3NS+gwWr3tcBVEtlEgTfwvMihiT82Vp1jwDLHy4a2qlz5oF1qjtvVN9+zHadqCidgSwFE
	 wypk1/QZRUj1E9yT0R5QI9kANpiwCR7lHd9PTrq/dmcuRZB+jUXjcafGcTS4tFoNCSVdE
	 41fWO5uQarMJTDqLPwi56Aw+l5DUjrKJd8jCRgTtRIEZL/tAMI/GqHAfUQcx/aVJi9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=queasysnail.net;
	spf=pass smtp.mailfrom=queasysnail.net;
	dkim=pass header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm1 header.b=rVs462hm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d56s9FR7;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D5606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm1 header.b=rVs462hm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d56s9FR7
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C203EC1D05
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:12:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 14:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1795461140; x=
	1795547540; bh=ZdUQUp3LwRE1rqDIK9upCqVPp3ZoKJh9GfW0EZyBwV0=; b=r
	Vs462hm3ZTTwmfJ/LANU5Bp2WK+CzBh9m+TtI+om51GmazmufwSRRu4ZJpQAKJRJ
	pzuG7hO/ZIVv3F171CgAUorHitOyaWaApdSeSO+wgxP0ZErQ7msB+RNwZUjTgsgA
	2Y4jjvFfprF2n4euSPZf8d/qE7c9UVir9lAclUKJMW6iwCktpM+Dh+obKfclvAsX
	9pmt2DSPXNeOPjTCmiLEdE2F+0XjUgdEhtZ2VLUpeNfzjN/JVNV9f1/j/EBqh0IK
	Pf8Mui7zUkHO0SLioWl/Gu1Js6mJyilXk8CUdGQdvhbdIAOzpGu2PmEFMeRMV4+z
	78VXxexbgeJnCqJ2XNUyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795461140; x=1795547540; bh=ZdUQUp3LwRE1rqDIK9upCqVPp3ZoKJh9GfW
	0EZyBwV0=; b=d56s9FR7dugRFejlNsCQauNUx4FToM+ZNfbEp7rsFttoEgbtz3G
	PNI4rTqYZsmKwrXUlhKmH4unNa7Amuh7M14RPHrMXrefR4iSAJDIM3EbD59qMGhf
	i5pV7sILDiiYEK0mCw/QkvYVkBV5kUv4I70yBYbnh2FHAfd2n5iJfUsF5g+yAOdy
	g7pXMpwtcofcMFNbiNgrH36VnQ69+zMaemyVVkDyfS7yAEI9kd29yWgOj2J+Ttqo
	j+Daicz7fgr2XlWj4aLqcuBd+mzZ4l+JYLagS2XwiRffdaNBBrnK+7wLTuwYMSlu
	Az4cKmdfFVxYO0ZmU9oTJsRvV53/Lyf3XuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795461140; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HGsWWIRVRPkJpYQ+5G3+EDIPiW+hzYSkZbxfWcUp8E8HoPo
	lndPsxb0l2v6aTM7oAxfCB6eOVEL/HIDvYabpIgQl2+cqHDRBwVe3u3sm4pdvh5M
	4S7Yx8zm86nfJ4oW+MqdVt6utXiddgqb9gOW4ZdmFeeGbrVyltcXVAq1bbD1aPhV
	NO6TbpvD89rU/UDwIchExfQj9n31NJkng8fcrZ5dSRe7kSRjJDiDRvJPTpR3f+zn
	RFGXqjfB19J9iXvBdqKnpHmqmLOKSteAumFLucQbUK6OZRRt2VGPpyfGD9E295ff
	m1lk+6qAvVpnnaqMI16HvqgL8JVsAfafUowX3TA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bufxvJwWPJL3RqRXEeaKLqgZ8ndCZ00zrZs7ISG+d64=:L++HDDslH/nMCC2g76db85vFJlKw4k4HTXdQxp16tl0=;
X-ME-Sender: <xms:E5AEa5vx03GSXAvuqpp_AQQfQgE_HnNnjB6brswKP_5wfM4OsWwxzw>
    <xme:E5AEa84uzNCk49oSKAqqoUgiiXiq9Xk9O2rzKILsxgxx84UDhK0s_QuqkP6IljLCr
    ANOYb0LcWNR84MtWMCsMKSc7PoYVe3Hh3ZHfBPau-wub_VeuqDjcjKE>
X-ME-Received: <xmr:E5AEa0SAT3W4J9u5K8WF6KahVSdlnazv1er-IZFFjPXXjsKJe1jIi2LJJRQ>
X-ME-Proxy-Cause: dmFkZTFGfMpzRIlRD0JqalkLOXufcldaW5mPKf9gnwsFJ+vDBNXu+ucuA2mHV3sG8awFD7
    TlQIpLKAlhdRZZzmHM5dzCLr9yCnlqE++1MlGQQlh2hXPAqwPuBKqVs+0+vPLr0jD3m21t
    KMWW9e6Nr1j2suHosCkXbxWML5v/2o8alliubSq4BLKdJ8hbk8S/De75gOw23JrVIkPY8N
    D1D3yW5QclrWuPlgXczruL49Qy/XefuKPG45Q8mhw3p9cd6s3zLGtXYEfumcXvrZY2eHdx
    vAfqlz0+MYyB1suAIuZNChzbjL65w1LKUjDuaCq/DRfI4jG14yihH6ToIZrLFbuh+tdvsy
    qqobtHJW75A5py4Dwv+RigPIEvPWFGHtQNxvt0r08bDNOn7mj1DClZ8etsIEQFkSAnl+Qg
    vMV3JMfnq2533Cy6XJoUhqFcZ+K/iGg66/tkCSliXrxWC7Fl1RsWmOZZlyaaPS1Z2F33Xy
    wdE6/do2ryEMjpqq6Rx41AYLp71oneCzukbKogCx7I38KcVO4k2CllfHKo94RMmgPREFEd
    URGDsBoO3+C8AbHXc+MxOfdElfuM4172gASIoAzb6NhWEwhaO5pgqVVA58YNOgZVBzX++C
    LG6HS9r9OSbFojsmNpCKDEfdzq7VWKBkJMa0WD4lFBXygFbv1mU6ghr4jywg
X-ME-Proxy: <xmx:E5AEa3vWthM5yLcbJ4PuwK6FXeCXspXymyOCLSatAfeIqEkMLwcNMA>
    <xmx:E5AEa-9zXXKTZS04cEi1yTHxkEAQsEpRqbANvz5_vqnQZZ9IEyju0Q>
    <xmx:E5AEa4whMWMSIAMMOVkPCc3ZxaJICU-VuhF8N74AR_Ow7lqu3bl7bA>
    <xmx:E5AEa49cycLdn6bpUBP4YVsSm6iVaHwCwPGgQ6iEqUuUqEJxRuCy2Q>
    <xmx:FJAEa0_5qXRsoSOClbwXanZavhmZGkTEf8_aRUPh05sz25iMpP7bxqNZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 14:12:18 -0500 (EST)
Date: Mon, 23 Nov 2026 20:12:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 1/2] tls: fix socket use-after-free during
 device-down
Message-ID: <awSQENPQBd7ogyyA@krikkit>
References: <20261116183519.3314837-1-rjethwani@purestorage.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116183519.3314837-1-rjethwani@purestorage.com>

2026-11-16, 11:35:17 -0700, Rishikesh Jethwani wrote:
> tls_device_down() pins each TLS context, then drops tls_device_lock before

pin = hold a reference?

> switching ctx->sk's TX validator. The socket destructor can run between

Please stop calling it a "validator". Those abstract references are
just obfuscation.

> these steps: the context survives, but __sk_destruct() frees the socket.
> 
> Switch the validator while selecting contexts from tls_device_list under
> tls_device_lock. The destructor uses the same lock for its context put

Which destructor? We shouldn't have to guess which functions are being
called.

> and list removal, so ctx->sk remains allocated through the switch.
> 
> Checking sk_refcnt would miss sockets whose queued SKBs still hold
> sk_wmem_alloc and require fallback after sk_refcnt reaches zero.
> 
> Requires commit f08d8c1bb97c ("net/tls: Fix race in TLS device down flow"),
> which moved the destructor's context put under tls_device_lock. Include
> this prerequisite in older backports.

Can we add the dependency in the Cc: stable line instead of bloating
the actual commit message?

> Found by code inspection. An ASan harness running the extracted teardown
> functions with userspace shims reproduces the UAF before this fix and
> passes afterward. Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).
> 
> Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  net/tls/tls_device.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Changelog? Links to previous versions?

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 4cdfbb57ecff..866193a506d2 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -1345,16 +1345,19 @@ static int tls_device_down(struct net_device *netdev)
>  		    !refcount_inc_not_zero(&ctx->refcount))
>  			continue;
>  
> -		list_move(&ctx->list, &list);
> -	}
> -	spin_unlock_irqrestore(&tls_device_lock, flags);
> -
> -	list_for_each_entry_safe(ctx, tmp, &list, list)	{
>  		/* Stop offloaded TX and switch to the fallback.
>  		 * tls_is_skb_tx_device_offloaded will return false.
> +		 *
> +		 * The context reference pins ctx; tls_device_lock keeps ctx->sk
> +		 * allocated until the validator has been switched.

I don't think this comment is helpful (and again with the obfuscation).

>  		 */
>  		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);

-- 
Sabrina
