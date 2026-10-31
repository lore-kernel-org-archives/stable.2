Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467733;
	b=rXHPeNjaHLPIPDe8YiYU0tZUzRo9nc4zElinJxzQcoHYo4yz9NdiizBNiwVEfribBc1Q
	 K9MohH2JptAs3bS8tyO+Ii7LHuJ5VhOxoL6fbNnqsC6T6fI4l+9/ULPgKu6UgvRwyAcwY
	 udoUpkiYEfib4L1ozanclEVoJU9bmhsk9i1MQJJukwzwkiOmEdi7qJIHQAvLNlklTE+GS
	 gu3yRnL2Ls2euipQs+U/fzItVVV76d7o7kPXdxLi+hIZc37nWecx9SWLj1A9bNQhw9eXW
	 Js2TInypMxEJ4zT1J6BSEahdE5z66uuGb0L3IoLcm24+vGme/YjdbGVvAhwuuIz8ERw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467733;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fljbL493IUPPYVoeHdRJWLxY37C0tj/X+LDqheFscps=;
	b=gFywS4LE9pShvwZdoVxR1OUNdqvcpB/sMd01cfB8BgfNQfTJ19d0tiH4gz0qFeiEQxY6
	 CuYjCFprPL7xoifCqrzgHSWy0eOuKHiObp7hDuzUZcHeVHhfyAH5nF53JGixB2rOH+/97
	 ostVYc7bgJ0jTDSuEREPnWxERZOXJFQO6Puz6mFfwelCWWhB8vgeUoetukE/tEtFscxNb
	 nFOD3FPjJt7IQn0bwMGR6l4O3Deac9qLock8q+vU+UKDNEbtGo6tUgIzHodiRklItW+SZ
	 t1782MSx4iTQA14B6wbavK3KTwltBWafRRbJ+uDwDvt+2OuwYAa0ZiaBiHA625B1QdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hl2zevIo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A4606A31A;
	Sat, 31 Oct 2026 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hl2zevIo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D40D1F000C1;
	Sat, 31 Oct 2026 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793467733;
	bh=fljbL493IUPPYVoeHdRJWLxY37C0tj/X+LDqheFscps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hl2zevIo9ukOm9ASfdCuciWrJiNT2p9e5Fp0wSBpAR3zSGToUbRarVAAcYMSvG0sg
	 JE4yZy8TxdwBac733I+KnC/5teH9h88aVaJXdAgDvIb/8NQt9tqUH9dFDCQKrVLy5o
	 A9m1KDEqn1lAGLwEb4k9mje+FTIIh96D5swDIdV4cSWjyPAi7MEq8frFZWPVAg69Jn
	 zVoPtRlmE/jWM9sURuFSChGf6X7qTqaUWWqhd4ktmQyh3xCPJ3aVwVMjF4krWmW5LM
	 ynelmT4ZdaI0PcZx/VhSXrkcYSnopz75u1C+4VcWRAfs2I2xnER25Njp6VEIxo71e8
	 2ho6qd2WJaasA==
Date: Sat, 31 Oct 2026 17:28:49 +0000
From: Simon Horman <horms@kernel.org>
To: Chengyu Liu <19290937@qq.com>
Cc: khc@pm.waw.pl, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] hdlc_cisco: shut down the keepalive timer on
 ->detach
Message-ID: <20261031172849.GQ257209@horms.kernel.org>
References: <20261028032310.2832307-1-19290937@qq.com>
 <tencent_9E404EEA5DDD9E37C7F105470FDA49E36708@qq.com>
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
In-Reply-To: <tencent_9E404EEA5DDD9E37C7F105470FDA49E36708@qq.com>

On Wed, Oct 28, 2026 at 11:23:09AM +0800, Chengyu Liu wrote:
> cisco_start() arms st->timer unconditionally and cisco_timer() re-arms
> itself on every fire.  The only deletion lives in cisco_stop(), which is
> unreachable on the protocol-detach path: detach_hdlc_protocol() calls
> only ->detach() (never ->stop()) and then kfree()s hdlc->state.  The
> cisco hdlc_proto has no ->detach at all, so unregistering an up cisco
> device leaves the keepalive timer armed on top of freed memory; it fires
> within one keepalive interval and cisco_timer() writes through the dead
> cisco_state (st->lock, st->txseq++, cisco_keepalive_send()).
> 
> Add a ->detach callback that shuts the timer down permanently before the
> state is freed, mirroring the CVE-2026-63803 ppp fix
> (timer_shutdown_sync() in ppp_timer_release()).
> 
> Initialize the timer in cisco_ioctl() when the protocol is attached and
> drop the timer_setup() from cisco_start(), so the timer is initialized
> exactly once at attach time: attach_hdlc_protocol() uses kmalloc() (not
> kzalloc), so st->timer is uninitialized garbage until the first
> timer_setup() and ->detach() must never run timer_shutdown_sync() on it.
> 
> This bug was found by static analysis and confirmed with a KASAN
> reproducer: slab-use-after-free write in __run_timer_base() within one
> keepalive interval after rmmod of an up cisco HDLC device (allocated by
> attach_hdlc_protocol() via cisco_ioctl(), freed by
> detach_hdlc_protocol() via unregister_hdlc_device()).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengyu Liu <19290937@qq.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
