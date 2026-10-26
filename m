Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027264;
	b=Ps7h+jRRg+4Xv45tADjHsKyGLi67/tBmjXBNGY0kOGmFCRZLjL6KyLBu7+zCiZLW7Yc2
	 f/468m09ZKBQiEuH4sWQ1+sdchp20LLHh3xictxoIgkBSwaW1XO9icHXsQx7nJ+Dd6zJ6
	 G/V+NFzPo8fuCuAa4OrQas7873jteEHPac25XsfVLJ5JOp6R9lF/YBwlFx9VMEfavDoaJ
	 JYVJHFUd4lgcpRO1DdXfBrgW6TF03/Udq3rvJCAxJfwvDv4CQWVHlg0Z3t0+wSuFedL+w
	 Y0Mnx5adkKFmQwc2RVO6QJhs57EPi16GyE+Ho8RVfv5D6TJFLwqKt//nyl7p6N2A6Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027264;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=g/R4qcdGAOKFBxRobAFKkRUzmVd4fugkXPdMQsoytF0=;
	b=owKJMuUvFCHBDWlDt9olxPwiQSh2dajMiW0T4G1vGtkTO9J/6OXzqawAOubZnjEMgLaB
	 6AwZJ5NcY8Fm9dyXaeFGS71f/WNd0T0wFNYQeAmEyhIUPlK14eisfrzUyk5h074fQxL3M
	 Pg04JqqbsmjdBHXs2oRpgDSm1K5cxCCa7to+TYqcvxY0+Adr/vsVNaHdyd3vfkhjEKles
	 ubbH9NI9et30BsXM3oTx1X+CwEal7Ap0Y9CACgg7T/B4LKmBB6z+2O+lJ/CVbYurug+Vz
	 YSMSSHl0+qGzw25z3CojqXgN7ftG636KKVEY5Gm3C2Ofvllh0jhVrF/qTQokF3gtRWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRt+H3T7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4B606A33E;
	Mon, 26 Oct 2026 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRt+H3T7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE3C1F031EC;
	Mon, 26 Oct 2026 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793027263;
	bh=g/R4qcdGAOKFBxRobAFKkRUzmVd4fugkXPdMQsoytF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KRt+H3T7XePbH45MV71itXUsJ+b60jVyZRmeEdhmhSN2k5W3zh9skQXFRpcbCr5uc
	 6MMLI2TlRhJNtTrBA8MXlkigYluBWAzb8KIDuDxNMkYEI80UDt6fLrLgya/KCikINj
	 xayZbXRipqXTfn5Ha7dsKVFFWIGgn/jT0PTH9E8FAq7q4x2t3qCoxeyH9WnLslg1Bm
	 ePcNC+6T/OMODCXcEcJYyHx0VX/Xx7nioEo7S+DvytMS+xXQBQS5N6/oVf7cWmlATZ
	 jy1sMgtIAWnRvrMz5yBLufocbYj29KvliPR+KVItncZeXB7zhD1PHox7Pw4nE6qEeN
	 rjl+Z/LbUIBGw==
Date: Mon, 26 Oct 2026 16:07:40 +0100
From: Antoine Tenart <atenart@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Zhou Qiuyue <n0ps1edzz@gmail.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <at9sKRSEJLVGj9OK@kwain>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
 <at7uk8gXtzNufuQF@fedora>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at7uk8gXtzNufuQF@fedora>

On Mon, Oct 26, 2026 at 02:09:23PM +0800, Hangbin Liu wrote:
> On Mon, Oct 26, 2026 at 12:48:08PM +0800, Zhou Qiuyue wrote:
> > diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> > index b965258cf..bdea82543 100644
> > --- a/net/ipv6/raw.c
> > +++ b/net/ipv6/raw.c
> > @@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
> >  	if (unlikely(!skb))
> >  		return 0;
> >  
> > +	/* l3mdev_ip6_out() may have replaced the skb dst. */
> > +	rt = dst_rt6_info(skb_dst(skb));
> > +
> >  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
> >  	 * in the error path. Since skb has been freed, the dst could
> >  	 * have been queued for deletion.
> 
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

Doesn't this change the device seen by the nf hook / used for the stats?
