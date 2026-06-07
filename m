Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C017BED0
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780816838; cv=none; b=RY2KSYZvsz8AlPRPb4swvPNN6ZLx32YqA6OcjcJEE+XNYTsQsPD1FNJZDJ3eKwSG7bYRH7gM5d5jGOfJX9bmrE5WNmH+NlCOgwk/mj102VQfxWpF/0HwBQKSf6dpPyBSYCTawRn8waO07eRgDUxsABr/Y2bWFPlKa18BirFYo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780816838; c=relaxed/simple;
	bh=wom8k7mtImUCIvYkSdCdnuHKKp+gvHiiNw423y1zwE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVR6tQF7GEebU9F6TOTq6QUUSLRPGho60uGqqU5p1nVMkc3bpCcGMlnqcwKcmXrHgyaCtmJ5LT7zyV+AfKCRMOQ9ms/Zp6ovr8ZAIX8tR2f/K+YStqJJNyKSdtPmBcLDoO7lHXNCo8IIoUoqbZFjnKvDn3StJ8RA/PpyKS/qfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=kwlEChqL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDqxnH8J; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kwlEChqL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDqxnH8J"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20EE37A00D5;
	Sun,  7 Jun 2026 03:20:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 07 Jun 2026 03:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780816834; x=1780903234; bh=fWUklyPPU/
	d8oRvkJAAYQ7OTLLci6NlYzw82FeLhHXs=; b=kwlEChqLi2bww38zjsn8tZ4whs
	kg1fgqIfNvSUeXjIgqAdYL2qMvHI5gCjVNMqOesnFAWrYPLeuWka0fS8vJybyEuh
	44lVjeh7czzKrgtxfufvJLo68JBNFApVr4gPu3TxW+f4JaYhHaF4A+FQwob6l55E
	vvzqgc8YESZZZfr2g8P8rGAWW70jPhEnjY5ChcQoicv4qn5op97qJN+80CiRfCQG
	I0UMNUeufClzphcpY92vX/cBe+roAJ5PXo/fIjCWUC6yYEmYN6d9GRuBEIPzn7gE
	bqVx1S/jxhxjczKbzQlrCvZuGY6p2D78o4u0Df3ym8/HFP+CSvGA17SxphVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780816834; x=1780903234; bh=fWUklyPPU/d8oRvkJAAYQ7OTLLci6NlYzw8
	2FeLhHXs=; b=HDqxnH8JTwYniVpVKudiyJh1Zolr5pbUpBYsFGAO7i/sTe18rJE
	ntofDV/b51HW6s+DBUTOLiXBkEaxHLiBtv3mJBB9raA9fkZdqAM+cinIH+sXOYH4
	bbm3gapM37FPCz2vtSWsRBdGT+adR4IrbjqloJv/+0+EyivSPaVlh42TZSbAP6pX
	rneDk+tJpFFgoE4nxDJQc8Z75peM/qowawWjxeuyXWCbmLNWM0tfqe14eiJm6Cdr
	FNssf1pPOV1vavigyEWPkSVzqbBsUc6HD47mRIE4gycy8zzNknlky79S6euXT1x8
	brk7mPdYqe4jdtu8cP32kkfmGtULH32pkyQ==
X-ME-Sender: <xms:whslapYXy5RSHyEvT7Cx7gWwOvxZFVf6oieeVdceYphwRwlNmtxDWA>
    <xme:whslajfQZtRHbcgv_ons-Oo2ZCr2DC_2fn5B7IFTwUL0V_I-6lXOkJgiDhrun8btf
    3XIcBOyxsNuth4Ea_7MHGzInM-5cK_fdsdzRqcRkjHwWvvAtg>
X-ME-Received: <xmr:whslamnpqc-m258UGpgn_5GHJkNHhVo5KfvFg5ryIjus4FjKhQec_uTpkdyfBiYV6zFhoySDbAH_nCm2gA-mPUF7>
X-ME-Proxy-Cause: dmFkZTFbfCZ5L0lQ54C/oTDacDNZWG3Fh+Bi64YzWTO72+7ImUjkH6IfVvt4AcOlFY+6rq
    6IKzXdJuKYuhomWfLN53LuPpGoDLiqBW4omx+XlzcOyV99F40NX+3PfHrHM+P0dz+KF7TM
    d5ffKggWDuIyxdVQHZ+UHXRuan616nD1QyKLLDjtpUfWA+stz0Qb+XSWxd+bNz1l3cnPVK
    RhPrGrQZcpkxra7C0rKbdBE9IOuFQW6kHI6yNhPohRT+DdTKlRcWtURhxZ0vEiXMOTGKRw
    Hs7KVX3/lPWMJXPP9/BNsVkXS4Q1eumztvgBqTNv0AQFzY1/cTZQOj7Ucdc0epm0hfPikL
    ghGQWlZQE8GxoRo2AIyoSkgQ5mjxoB0wwRxRdqQyQ+Ly2K9NXenrTOTdYJIqXe5vZW6j6X
    IWHVdffeGW6Cxa65jLi+HquZOlUvUxB8sZrJz/i3ehNoUIDemFPZ+RpbmGFgRNncmT1ZQX
    HiNGRl78xxYto2QhKf7+Vx1QTnhW3ogXK/pPYOBSDr4GmxdZxVYgG1sWGuaJZ0FHHCV/PL
    4FLI3dGKJRcjP7R4QCGmwQfJWIY1MX3he5Q0Yeb7NdLnCbLeG1QznI7vaxArJJezoLUHUJ
    Bd4YQs5KNTV8LhcG76kiJ+dCz2zXsdVDaUvDM9z0eEhu1zMsOyRnlxRx6XhA
X-ME-Proxy: <xmx:whslaj0v2yZhmeEFbIIa9sOAZqYhui5zKI3UdGBe3y6yCwo9NvCRqA>
    <xmx:whslavdTwH0vjoFYjW6fQmnXFKKHU6UUNKJou6ifg97s5Tqd2kDCPA>
    <xmx:whslata6ebIbiuzcF4In9fA5s6XNqFyOBZisMFAHL6EXaAWoYZoEfA>
    <xmx:whslakGTc7Yc50w1GznTCjhphRl8KgScWII0RT3MqB87AxI0ICPiUw>
    <xmx:whslavbURLrcZtR51BoFC5LBCmZWEYP8UE1IT0puZdDbdnpRvf1u7IGG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jun 2026 03:20:33 -0400 (EDT)
Date: Sun, 7 Jun 2026 09:19:37 +0200
From: Greg KH <greg@kroah.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH 7.0.y] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Message-ID: <2026060758-democrat-wipe-0671@gregkh>
References: <2026052819-liberty-cramp-97fe@gregkh>
 <20260601003905.84041-1-sashal@kernel.org>
 <bd2ea2a2-5ec9-49f2-90e1-5551c4f5c3e2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2ea2a2-5ec9-49f2-90e1-5551c4f5c3e2@kernel.org>

On Mon, Jun 01, 2026 at 10:50:33AM +1000, Matthieu Baerts wrote:
> Hi Sasha,
> 
> On 01/06/2026 10:39, Sasha Levin wrote:
> > From: Gang Yan <yangang@kylinos.cn>
> > 
> > [ Upstream commit 3a543ae0e2092d5c2085d5f21f7a7dbafdffea3c ]
> > 
> > Add __mptcp_subflow_set_rcvbuf() helper to write the subflow sk_rcvbuf,
> > but also to call the recently added tcp_set_rcvbuf() helper to update
> > window_clamp. This is needed because the window clap is updated when
> > scaling_ratio changes, in tcp_measure_rcv_mss(). Until scaling_ratio
> > changes, the subflow is stuck with the old window clamp which may be
> > based on a small initial buffer.
> > 
> > Use this new helper in both mptcp_sol_socket_sync_intval() (setsockopt
> > path) and sync_socket_options() (new subflow creation path).
> > 
> > Note that this patch depends on commit b025461303d8 ("tcp: update
> > window_clamp when SO_RCVBUF is set"): it fixes the issue on TCP side,
> > but the same fix is needed on MPTCP side as well.
> Thank you for the backport. I guess there is a conflict, because commit
> b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is set") has not
> been backported to 7.0 (nor 6.18, 6.12 and 6.6). See the note above for
> more details.
> 
> In other words, MPTCP is imitating TCP's behaviour. So no need to
> backport this patch if the fix on TCP side is not backported either.
> 
> I think it would be better to take both the TCP fix (b025461303d8), and
> this one (3a543ae0e209). But maybe the TCP fix has not been backported
> on purpose?

It was not tagged for stable inclusion, so it was not applied to any
stable trees.  As the tcp change isn't included, I'll just drop this one
too, thanks.

greg k-h
