Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804517;
	b=X3Onmo/tTXlHr8pYRmGeY7YfzOcEwTodq1OPCwsgN6uZnmIVHGzfQ05zIhjA0zM0Xqd7
	 IdaIO3gWey5pGyLMIhByiMhporCJxkERn+O5fXiG7XfF69o08yNmtoCtJKuRPsQcA/1LP
	 Lt7NQi2ngJjgyh82L68oRs78y7voAQqig3aY7TCP6f36TRoUHPUCM3QTTpvZBKONfKezy
	 LqKU+iBV9nOQbQud3dVFewOmnquvyE2l3pHIxK3bzc8/tKsQNLyI/YYnO+JgM4vQbNwk3
	 FY/cw70vYVozGRcvODPkRhEH1rhfHEqMFCylxi1yUYAFnFvCPcKcxX6wtm+bj5JmE5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804517;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VHzMiVyExLKNox+s2pz5emim2KQtzbhGBZ3vM7xAkk0=;
	b=EjRmjoccvgRwtgnmjEwp5YFQHJ1osJp3Bs27iUCfuAjZ3cpZQYoF7wlzQ2LMhCvDT2Ox
	 Mc/pwSssvZk1P9pXi4LVcx9i68r3VdzU9v5VpWO9j9Y30RNBaSW/gnPTJ2GX4+U3nqe/W
	 FW0Ya2BByJTLDgAVxiLj1vtVtN1IfKETWziKgsbTQ6xlQOb7RzBi+7ehYFG8WTTxU2WsP
	 tEFtgWy3PA9ixWOC2q+5GaRw7HxDDKg6EQe0KLu8T21q6G+1jriT4iggu6qRfJJ0vX8HX
	 vqPFYkJUsvzkT0MqTb9hQZmjFY0Pp4JwWGXoDDULaNMqo6+ZRqppTqp4PZPT0sj6XFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE0Kqgw2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 06E25606A31F;
	Fri, 27 Nov 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE0Kqgw2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E68A71F00893;
	Fri, 27 Nov 2026 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804516;
	bh=VHzMiVyExLKNox+s2pz5emim2KQtzbhGBZ3vM7xAkk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aE0Kqgw2SJzqjut3kj5bht3xHrxhvGAUzV5tHRvZvlTR00qTJn38BWF4h+OoCTb9t
	 bd9yWalblH11fl2BbrmI6fcHXUZGyoei3e+dwK+D4O1Sq1J87Z8bcJ3lr07XOXBHSG
	 83MF4lRJEHFahf+TFYXcuT5ltwq4iTRfkCVo+gV07D9Tgpq6AydH3NqyuuQ4BUYCOT
	 quSli1FzTOK+ybT2Ymv3ttvbbWluXForYW0+T1cO4fpZ83lCZxGCwG9dsNECIXCbc4
	 E2kiaGoEDt6yo8yVEJV2bBksjbJ0wmWgb2RSFLWKKCFf/xSL0DOs8CShPPIwLx9GRB
	 E7qascnNxHXtA==
Date: Fri, 27 Nov 2026 20:35:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Zhenwen Liang <zhenwenliang@google.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: trusted: Wait for RCU callbacks before module
 unload
Message-ID: <awnNYPFsGQazUMXu@kernel.org>
References: <20261126200103.2806716-1-zhenwenliang@google.com>
 <20261126200103.2806716-2-zhenwenliang@google.com>
 <awiZuKwNUP6mi6Yg@kernel.org>
 <awiaH6sIiISN19Q6@kernel.org>
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
In-Reply-To: <awiaH6sIiISN19Q6@kernel.org>

On Thu, Nov 26, 2026 at 10:44:15PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 26, 2026 at 10:42:36PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 26, 2026 at 08:01:03PM +0000, Zhenwen Liang wrote:
> > > trusted_update() frees the old payload with call_rcu(), and the
> > > callback, trusted_rcu_free(), is part of trusted.ko. cleanup_trusted()
> > > calls the trust source's exit callback, which unregisters the key type,
> > > but nothing waits for callbacks that are already queued, so the module
> > > can be freed while a trusted_rcu_free() callback is still pending.
> > 
> > +1
> > 
> > > 
> > > Add an rcu_barrier() after the exit callback. As for encrypted keys, no
> > > new callback can be queued once unregister_key_type() has returned. If
> > > no trust source was found, the key type was never registered and
> > > trusted_key_exit is NULL; the barrier is then harmless.
> > > 
> > > Tested in QEMU (x86_64, TCG) without a trust source, so only the
> > > trusted_key_exit == NULL case ran: trusted.ko loads and unloads cleanly
> > > with this patch (5 runs). The trusted_update() path itself was not run,
> > > because no TPM was available.
> > > 
> > > The problem was found, and this patch prepared, with the help of a
> > > formal analysis tool we are developing that uses AI assistance; I have
> > > reviewed the analysis and the patch.
> > > 
> > > Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> > > Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
> > > ---
> > >  security/keys/trusted-keys/trusted_core.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > > index 0509d9955f2a..5efd1e6ef111 100644
> > > --- a/security/keys/trusted-keys/trusted_core.c
> > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > @@ -401,6 +401,7 @@ static void __exit cleanup_trusted(void)
> > >  {
> > >  	if (trusted_key_exit)
> > >  		(*trusted_key_exit)();
> > > +	rcu_barrier();
> > >  }
> > >  
> > >  late_initcall(init_trusted);
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Pushed (to master for the time being).

Pushed to for-next-keys i.e., I'll piggyback them to a PR next week.

Thank you.

Br, Jarkko
