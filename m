Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241261;
	b=s/7OE4ipsEOx1cewNzYI04O+mGI7Ez0BHUl4lVCc2H14mSFuQ+4TMCzmeac9crBR+aEe
	 BSEXyz9i6LBXTPHT3WGmEqoSHE7oEeOST50YMS5oTskH+qB7YdfMQaz5DEBQxwtLFla40
	 q01l+G5oyDfTUkGKH7w5d3CRpc2nq0Go98IFSZR3tDC7fYwgZZwF4s055z9kbPUjlzaxg
	 1L7domxFBpBeO8QSb8qbtHsTVX+QuVbLGru4BBvm7rGd9FTm3kgne8Kp6tW/BB4qYFAfG
	 t4jBnAlLzqjeEBxbiHeawxBMHW2GkWmgg6LmsTpRZiaUl/QF2paRF2dpYRQJYwa1JEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241261;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=TEnvEAcokuLSsHN0hVns+uM/UQP9Fe9jjYNoxn21KTE=;
	b=c5aJ/eYjAC/xfB+SJG8F49bTEm4LYCHF9OX1dsAloQlSZ9QUAM6D4C/tN3+HO08gzK2V
	 yazTpk8X4lj0t+wFM3I/vC7zVVltdPWXdBGBIcuA1Ba98nNagEiRsOgA9tKbh0nZ3CN9T
	 Spcle7wT4qRlGYL09fVNYjkledLicdvrXVAyIrwdWwNqwNXk7GfQ0vNHGVdKRTzMEbanL
	 yN8mGAtDa0ZGA3O4+VStoqTEV3aSdswMh+0OBRK5QqLtdXFzfQaBcW9RJyhN0qkKNbrvs
	 aAMXvRs6LnBMQ/TIvF21eWenB/81+lLeXY8mUz/28PA09R2YLPjhCvOImW3IqOMZ8hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lvm4tLdA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36F606A33A;
	Mon,  9 Nov 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lvm4tLdA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656811F0089F;
	Mon,  9 Nov 2026 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241260;
	bh=TEnvEAcokuLSsHN0hVns+uM/UQP9Fe9jjYNoxn21KTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lvm4tLdAw3nEtB3OjVEzOvRpF21rcHkBO0tZkdgerzpvPIDlZQvB0i1wpqcg6/8eV
	 m1adc1CwBrlSAuyc/7VAelRwTzz3IObXqMfuHMnyPq1cvJo8l9ut4OFcNVXh9PVAmD
	 kzbsVW+1+XcdB2kmnZokDPBCpcO9dN85mw4cszqrHJHbpLQFug0ChrT4ajMLzyfUL9
	 KcA5fKHNUtVDKFEfHShGUm4Ih5hzR13e05lgK/Jv6daOipKpK0TgRCpVRrTHlQl/Tt
	 i1h2qOBgiPXdosEuBCikSThFTaQq3w1EiGKaxPcTMhthOqxNRIgHIn9c2MlCdQgGBJ
	 v1QpKkJOtNpbw==
Date: Mon, 9 Nov 2026 16:20:56 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, shawnq1@163.com, davem@davemloft.net,
	edumazet@kernel.org, jiri@resnulli.us, kuba@kernel.org,
	pabeni@redhat.com, victor@mojatatu.com, thomas.goff@boeing.com
Subject: Re: [PATCH net v3 3/4] net/sched: sch_teql: reject qdiscs from
 another network namespace
Message-ID: <20261109162056.GO18859@horms.kernel.org>
References: <SER-NSBD.v3.r0.20261103064310-3@mojatatu.com>
 <179406301946.994134.7212801896124135602@kernel.org>
 <CAM0EoMmZ6msUa_HDx5511GYPpKiaWFw+G9OAJFB61hGvVm1D3A@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmZ6msUa_HDx5511GYPpKiaWFw+G9OAJFB61hGvVm1D3A@mail.gmail.com>

On Sat, Nov 07, 2026 at 05:13:10PM -0500, Jamal Hadi Salim wrote:
> On Sat, Nov 7, 2026 at 9:50 AM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 3 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 2
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [Medium] The fix checks that the slave device and the master are in the
> >   same network namespace only once, in teql_qdisc_init()…
> > - [Low] The commit message says only that a qdisc from another netns
> >   could attach to the init-net master "and change its MTU and flags".
> > - [Low] Moving skb_queue_head_init(&q->q) to the top of teql_qdisc_init()
> >   (sch_teql.c:203) is presented as groundwork for the new netns failure…
> >
> 
> Again, cosmetics i will fix if i have to resend.
> The netns_immutable gap is pre-existing and needs CAP_NET_ADMIN in
> init_net, so it stays the net-next follow-up.
> The reorder keeps this patch's Fixes: because the namespace refusal is
> itself reachable through qdisc_create_dflt() -> qdisc_reset() ->
> teql_reset(), and if i have to resend then I will state the
> interception impact in the body...

Reviewed-by: Simon Horman <horms@kernel.org>

