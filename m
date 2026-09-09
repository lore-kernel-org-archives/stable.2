Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35E559C98;
	Wed,  9 Sep 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958664; cv=none; b=X31Akpt7BQCV3ULesFhSlae++oq4CY1JgS+h6pVlvZiQ40tEUNbZ8YyTrQSCUhv0Mn95HCFB7hlAdKVXchyHWoZ4sGE/TLQZ6JCrnIUDKq5sIhjcs4awZgiF2rweCb+Vs6zO8giF70i6k9PmG75MwlyH0LbDW9Y+TSxKU7CYvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958664; c=relaxed/simple;
	bh=HtrJiuO9uCS7o0/8fb1jVedRJFYPQIQOiTtqCJOco64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlR4pnq74l8B4INGvLwpowBRj/aPCE+96VeMzkZz8Cx5XhACKAE8q5WjK+ouvvGza3A4aFpKkmMqZSXJ1n3m9h/UstzWJKd5nOPnnplfqaFU8yl9tHfpbSULFVMMo5Md55kTNH0qnXNqUDSZYAA5lMfAYnKzGxa06ZPC/VI3Emo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsD5Se8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CsD5Se8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F351F00A3A;
	Wed,  9 Sep 2026 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788958662;
	bh=mS9s8n6FRlFBWbu8GsvJSTIhWvNlo+LzthB+eG2OI+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CsD5Se8mXuzH5BWRqnf4Y9lI1fB3rJVfHrmCnNPPwdpNQrotAdjx6/gw1M+DVPxVM
	 6rzxZj0cbBVtbN5HpUBwUgicIqO/i1gbvv7rtcEVc71jbUDxnYUUEFFhk7kMA0nuxA
	 4sYCsQ3Ks6D1/iN5J9yS3BjGHeO3SDM+1NwC3cRE=
Date: Wed, 9 Sep 2026 14:55:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: stable@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	netdev@vger.kernel.org, phaddad@nvidia.com, Paul Saab <ps@mu.org>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y 6.6.y 6.12.y 6.18.y] net/mlx5e: xsk: Fix unlocked
 writing to ICOSQ
Message-ID: <2026090941-starting-coveting-d93a@gregkh>
References: <20260909100310.1941561-2-dtatulea@nvidia.com>
 <2026090925-myspace-precision-c68e@gregkh>
 <6a430d55-72e8-4333-b369-af215c9f0c3a@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a430d55-72e8-4333-b369-af215c9f0c3a@nvidia.com>

On Wed, Sep 09, 2026 at 02:47:16PM +0200, Dragos Tatulea wrote:
> 
> 
> On 09.09.26 14:21, Greg KH wrote:
> > On Wed, Sep 09, 2026 at 10:03:10AM +0000, Dragos Tatulea wrote:
> >> commit c326f9c68921e2f14dfcecb2f6b4216313d50248 upstream.
> >>
> >> During napi poll, when the affinity changes and there's still XSK work
> >> to be done, we trigger an ICOSQ interrupt on the new CPU. However, this
> >> triggering on the ICOSQ is done unprotected.
> >>
> >> mlx5e_trigger_irq() is called while mlx5e_xsk_alloc_rx_mpwqe() is
> >> running from a different CPU due to affinity change. This can happen
> >> because IRQ triggering is done after napi_complete_done(). At this point
> >> the NAPI can be scheduled on a different CPU. Like this:
> >>
> >>   CPU A (old affinity, NAPI tail)    CPU B (new affinity, fresh NAPI)
> >>   -------------------------------    --------------------------------
> >>   napi_complete_done()  clears SCHED
> >>   mlx5e_cq_arm(...)
> >>                                      napi_schedule_prep() sets SCHED
> >>                                      mlx5e_napi_poll()
> >>                                        mlx5e_xsk_alloc_rx_mpwqe()
> >>                                          memcpy 640 B UMR body
> >>                                          advance sq->pc by 10
> >>   mlx5e_trigger_irq(&c->icosq)
> >>     wqe_info[pi] = {NOP, 1}
> >>     mlx5e_post_nop() advances sq->pc
> >>
> >> The obvious fix would be to lock the ICOSQ. But the ICOSQ is expected to
> >> be accessed only from the channel's NAPI and has no locking. Kick the
> >> async ICOSQ instead which is always locked.
> >>
> >> This issue was noticed in the wild with the following splat:
> >>
> >>   netdevice: ge-0-0-1: Bad OP in ICOSQ CQE: 0xd
> >>   WARNING: drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:826 [...]
> >>   [...]
> >>   Call Trace:
> >>    <IRQ>
> >>    mlx5e_napi_poll+0x11d/0x7f0 [mlx5_core]
> >>    __napi_poll+0x30/0x200
> >>    ? skb_defer_free_flush+0x9c/0xc0
> >>    net_rx_action+0x2fe/0x3f0
> >>    handle_softirqs+0xd8/0x340
> >>    __irq_exit_rcu+0xbc/0xe0
> >>    common_interrupt+0x85/0xa0
> >>    </IRQ>
> >>    <TASK>
> >>    asm_common_interrupt+0x26/0x40
> >>   [...]
> >>   ---[ end trace 0000000000000000 ]---
> >>   mlx5_core 0000:08:00.0 ge-0-0-1: Error cqe on cqn 0x548, ci 0x2022, qn 0x8f4,
> >>   opcode 0xd, syndrome 0x2, vendor syndrome 0x68
> > 
> > Why does the changelog here differ from what is in Linus's tree?
> > 
> > Please don't do that :(
> > 
> Apologies. Will fix.
> 
> >> [ Backport to 6.18.y and older: upstream commit calls
> >>   mlx5e_trigger_napi_async_icosq(), which was introduced by commit
> >>   0da1dba72616 ("net/mlx5e: XSK, Fix unintended ICOSQ change") and is not
> >>   present here. In these trees mlx5e_trigger_napi_icosq() is the
> >>   equivalent helper: it takes c->async_icosq_lock and triggers
> >>   c->async_icosq, which is unconditionally opened, activated, polled and
> >>   armed for every channel. Race B of the upstream commit message does not
> >>   apply, as it concerns the sync-ICOSQ variant of
> >>   mlx5e_trigger_napi_icosq() that only exists upstream. ]
> > 
> > That part is ok, but changing the overall changelog text for no obvious
> > reson isn't ok.
> > 
> Do you prefer that I drop it in v2.

No, that's ok, it's great to have, thanks for that.

greg k-h
