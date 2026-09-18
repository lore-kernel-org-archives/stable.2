Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD69304BB3;
	Fri, 18 Sep 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719998; cv=none; b=SOtFUroh5Yb+Q26VrtnJ5tM8IGBgNgxLLY/zSQU20IgRXbTLt3MeGl8Tys26c9VgbhuyOwjiUQy3rZ8WjXZ0uuHbVSnerXwdFDDO2Xgm840DXLGfo6qiOP0X1iiKkyAlCbCBK/OflXx1mWqL6Uc52lfTTxos74E0lYi0QlrbQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719998; c=relaxed/simple;
	bh=oKKEv5p15WDmezLthJSp3xgXPDQHZBUhThRT9QEZwuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCTgPhDvIGoKkpNjhKlopWibm8aXjvE+b8PvQJuKD7YU9Oiky9JuMzlzC7PUocisdoiVs5o57mW3bHK6DZC+lZUGeEWMCX5+ZE+bvyH0loSTzNgfXmCU/6aZyYuFzAbyLFXL79LD35pvreJgi5x8IAbGtCFbx5V4cDTjhXwoPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=F9QiJutJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFTO69yB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="F9QiJutJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFTO69yB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09F77140013E;
	Fri, 18 Sep 2026 04:26:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 18 Sep 2026 04:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789719995;
	 x=1789806395; bh=zXLWTmXS34ILfBWi1s0RdE2FX6OOvcd0JV9c4iX1eh4=; b=
	F9QiJutJ+aJlqrjxfJ5xrYq2tXsdqOYQy0Lb41WigoAD4Uoi8Zegh1hSjo3XVwKn
	U+TbnpvJjkF1O95LflyBNpC2ABfJ51Nuy1wWOEWplIHD7wohUFx6cDPJz8E9cez5
	Bqvg/g3M1xuf4g8HKg17ylOz6v8vDjhSIWydfEAMT3iGhYsxa5q5OQcKgNP1790q
	+GxRIBj15JDpASymAGFhyB1XBg2GxzEPXrcJYrUDfT5WdgiXgARK9EHavvrRBXXK
	NEC592tG6KX1f5deHRmUosuIosle7rTKQG4sxj2tbf/eAgZhszyQmOpOUhdRc+le
	KNRwRF3xSc6zL5fS9xV6Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789719995; x=
	1789806395; bh=zXLWTmXS34ILfBWi1s0RdE2FX6OOvcd0JV9c4iX1eh4=; b=F
	FTO69yBecWwKQscfp8Zt+7SAbBJxZDH3NTNH2qJQhIIT6FG1ZWwHPzoxmXkumdwI
	jzAXou9MBo6DEOdt1FHhs7EMQdpuG3fZPkq9RCyx6hjl4tkQARCPWAFge9/E81yj
	l5x0WOTPbHZenOPsPUzAO1jo7IxCAKBTqIAL6CUyKbk23uGLOQ9RoxNVO1pa0KfN
	c8lpt0lQ7T0BPmv6N2C5EkZj9fuIfxKuAbACeHXieYPnM7MSmZFjZbhCprJiSW9l
	ZsnuEPFL/d/5B00Fh20wxtMd0IqR9fQ4SjMUpbIdZ7gdMliBSJxpHKmToXp7a2n3
	crhJC60BKYIH8w4Ph2g7Q==
X-ME-Sender: <xms:uvWsauYr6V9AioUSzBVOZ8gppH-ji5Az12DBxOjsbi1l1kGNNES9uQ>
    <xme:uvWsah0cLVtQIOfqK32EzpUqZWV5afB8xOZNW8ViOoq29urRoHyOOPpf0w--hRoeG
    0oamF2KhVhF-_l_qBuRDyfDliQvIKkas6qFaOlYeZtWUm8XPQ>
X-ME-Received: <xmr:uvWsauZJ8T4vcp_1YYuJCqbQjjHvAlmVMbeqL7TL2bMnj6w24lSolDTXNSG3>
X-ME-Proxy-Cause: dmFkZTE3QrEhpqSHveIhRFHSUl1UZ8CTVBnbalAD6sa5w7LGOoFESM9GDnUgFYmOJSITgG
    SxFbbRj3KImLv/ErBqmWRskIyQSU1Ca5UTbTXXv1sB+NcmMAd9brnQvHcN/vJZEJiQI/6N
    feW1WR+gx0ZgcVPxQmsakREWrY+3sIwDf0eON3vCeV9XGm4jE50DA+1HN4nKdJ5Xkxx3oL
    xpgl/QTShF0KfExs2zkd8SIxTP5FQN3h9ZAEP2tFJYIKbUmHgJNaCvgpKlXvxobFaB5kKz
    f3e4XcHu4uHj0GeGIbcjdhVU4mVMQ1iJqS8doSzJ8nLJKy0TuynitxyVRHr4gydSSg8UP8
    tigT2naD3Rd+KaB9PBd25UDIqPXoVjRDjvwEpSIRW8A4avXpXnNGYATlElsZ+XYhijzbel
    yKD/u52ciRz2iQfkzNu7h/XqSnPChO2ew9+mxPTk2dgxybCzCrgLO1PZKEtYfdXn/0GZtk
    2QeSroCWItn51QBvmcSyp0i+fFa0ferzCgKvjQNV4gd20paW1m2/Ro8WAJB9DpN3Uh5nTj
    rDiDgQFkABvs3Hm91Ov+sow+HthVOneINdkvyXzcWm3LZ7L895gam0Evr328NfY7vscui/
    IUaVE5Q0+PjT11+PDSAVGtWTHwORYyFousT0sytgsfw0eIQB5sisFpgNxTEw
X-ME-Proxy: <xmx:uvWsaulxYT-5l3s2j3rp5lk0JFfQMeE7f7DL-B4_54_zZf_odciHDg>
    <xmx:uvWsatdOWJGpsq-rjPBpFLnH6qIT0AHWE9JFunpB4NmRHj-RwB510Q>
    <xmx:uvWsas3Ca28SXYOMGwHuSTZHQ2V0v07xw3BFGcsAQXixJUj2Noikww>
    <xmx:uvWsaqkEpAMCqUTV0ImerhPqYL5_94zfM4y_eX9wwmIb_9AiNYH2Hw>
    <xmx:u_Wsau4j9BkSTLDKWmovgG_MmtkzSSateX-zOFi9hi5as41-dv2ZoImp>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 04:26:33 -0400 (EDT)
Date: Fri, 18 Sep 2026 09:24:38 +0100
From: Greg KH <greg@kroah.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Ryan Lee <ryan.lee@canonical.com>, Wentao Liang <vulab@iscas.ac.cn>,
	apparmor@lists.ubuntu.com, jmorris@namei.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, serge@hallyn.com, stable@vger.kernel.org
Subject: Re: [PATCH] apparmor: Fix label reference leak in aa_unix_file_perm()
Message-ID: <2026091851-recent-ungraded-23eb@gregkh>
References: <20260917164136.2162858-1-vulab@iscas.ac.cn>
 <CAKCV-6uui82r4U3+ab=2ZFQvGQYnxfhYMHJNzLim-HEw6pRp7A@mail.gmail.com>
 <760b1f31-32f6-44c6-8a5b-991f228a327f@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <760b1f31-32f6-44c6-8a5b-991f228a327f@canonical.com>

On Thu, Sep 17, 2026 at 01:18:20PM -0700, John Johansen wrote:
> On 9/17/26 12:19, Ryan Lee wrote:
> > On Thu, Sep 17, 2026 at 11:59 AM Wentao Liang <vulab@iscas.ac.cn> wrote:
> > > 
> > > The inner block in aa_unix_file_perm() re-declares plabel, shadowing the
> > > outer variable that is released at the out label. The reference taken by
> > > aa_get_label_rcu() is thus lost when the block exits, and aa_put_label()
> > > at out is a no-op on the still NULL outer plabel, leaking one label per
> > > permission check on a non-filesystem unix socket.
> > > 
> > > Drop the shadowing declaration so the outer plabel is used and released.
> > > 
> > > Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > > ---
> > >   security/apparmor/af_unix.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> > > index fdb4a9f212c3..ecb40cfe7e14 100644
> > > --- a/security/apparmor/af_unix.c
> > > +++ b/security/apparmor/af_unix.c
> > > @@ -758,7 +758,6 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
> > >                             unix_fs_perm(op, request, subj_cred, label,
> > >                                          is_unix_fs(peer_sk) ? &peer_path : NULL));
> > >          } else if (!is_sk_fs) {
> > > -               struct aa_label *plabel;
> > >                  struct aa_sk_ctx *pctx = aa_sock(peer_sk);
> > > 
> > >                  rcu_read_lock();
> > > --
> > > 2.34.1
> > > 
> > > 
> > 
> > NACK: this exact patch has been proposed before, and unfortunately
> > exposes an additional latent bug around plabel handling that results
> > in a use-after-free if the shadowed declaration is removed without
> > additional fixes.
> > 
> > I can try to dig out the relevant exchange from the AppArmor mailing
> > list later, if you'd be interested.
> > 
> The series Ryan is referring to is in Linus's tree, so you should see the
> fix rolling out to stable kernels as well soon.
> 
> 6d25e7b47616c apparmor: fix refcount leak when updating the sk_ctx
> b1aea2c196077 apparmor: fix race in unix socket mediation when peer_path is used
> 4483efe4f2151 apparmor: fix shadowing of plabel that prevents cache from being updated

These are all in stable released kernels already for many weeks, so how
is any of this still being reported?

confused,

greg k-h
