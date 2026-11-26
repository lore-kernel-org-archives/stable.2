Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725859;
	b=PXFPwEclBUYzS4twFm+FyvnggINVU/yS/IFsbd+pI4DYmAcIU1c5aaa+yx9zf5eYVTP4
	 alu+ARCdWjFDJHOjz5OjdIY3SeyJjYaU6TJcbPM/TsVokL/rG8zJY840AgFKMmmXhStHO
	 KiAncSX4/hqER2qhbzNWt3NQlCNGlezf8QAPm0h1VmI1ZttI8UyhRtBDykUlfbEBDgmxu
	 LrPyU1HNdpJF/1hgrlYD2cMtjwqgvwu2cm8Z7KC2McgCUUwqafDJ2o1a0diA+XOJu42r/
	 ZLpHOWJ7AgXp/ephSdZxj8txMGf3NfpY1V0fAZydXhwFWOnwPnIUIB3mjyJW+ZhBiWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725859;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hp3/hJmzk5v6xtIusZ/nR0FAq2ig3bagFENmxgEfR3M=;
	b=cPgMo7WCn2JB4iEV4D0f1r5FR+oagHvQA1uR5Y2DTzk/EedbVC3TgcIzjN3NrVn77hlr
	 CsftbsCbyEG/VPvwmZaSj+xMrkI++UA1nechd5FwBhxtkQ2R+YxlAYOGxBoGAHDPpdBkE
	 UE4khFsmJUIPpe8bRQRI/1nxSF31YKZoilOiG6by/1AlbFXzYufGSbSuVMPn71Sh9n86S
	 q3ZeYNGLcr3f/qfp2dV+fj7SN3wE7Lv+/39oeHOASDU7xMniDciOcJGh7JvujIerP0tQ/
	 wXZhJ41QDtixb3Aous9Ux6SVrANEhzVOle0a+eyJKC/6WSwyCiwLXraH2t5nFYKF1+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e+SBZ/2b";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 004E8606A6AE;
	Thu, 26 Nov 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+SBZ/2b
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4970C1F000C1;
	Thu, 26 Nov 2026 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725858;
	bh=hp3/hJmzk5v6xtIusZ/nR0FAq2ig3bagFENmxgEfR3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e+SBZ/2bJTBK0hsBrU8a2HI9sqA/rJErXZ09Szgh6JmPc4gfF751kn34YG3N6ik09
	 PI7oDRjJ9h49DHjPL8gSW+ZQb2CIZNVCISwo6byQF2uTXOke6omF2+3ubnpYOaVTTn
	 kF+ldKwAfOamPokQFBcJyxmtqBRUcpzxo1dWWIKIzHjiSEG8zTwCQdvcNkH0JITxO/
	 /xKeYziz295jhNBsiaJQKR0hpPp1CI/h+yCC5J4nWWeYsbarWWbdbxzcJzzjsjLnBq
	 6n53IZFq689sjuLjqj9pwoQ8uRASp2U8BMpizN8tHkVzENdEDkP+Ilxd8S2NnY419B
	 NlO+sgPuucgmQ==
Date: Thu, 26 Nov 2026 22:44:15 +0200
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
Message-ID: <awiaH6sIiISN19Q6@kernel.org>
References: <20261126200103.2806716-1-zhenwenliang@google.com>
 <20261126200103.2806716-2-zhenwenliang@google.com>
 <awiZuKwNUP6mi6Yg@kernel.org>
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
In-Reply-To: <awiZuKwNUP6mi6Yg@kernel.org>

On Thu, Nov 26, 2026 at 10:42:36PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 26, 2026 at 08:01:03PM +0000, Zhenwen Liang wrote:
> > trusted_update() frees the old payload with call_rcu(), and the
> > callback, trusted_rcu_free(), is part of trusted.ko. cleanup_trusted()
> > calls the trust source's exit callback, which unregisters the key type,
> > but nothing waits for callbacks that are already queued, so the module
> > can be freed while a trusted_rcu_free() callback is still pending.
> 
> +1
> 
> > 
> > Add an rcu_barrier() after the exit callback. As for encrypted keys, no
> > new callback can be queued once unregister_key_type() has returned. If
> > no trust source was found, the key type was never registered and
> > trusted_key_exit is NULL; the barrier is then harmless.
> > 
> > Tested in QEMU (x86_64, TCG) without a trust source, so only the
> > trusted_key_exit == NULL case ran: trusted.ko loads and unloads cleanly
> > with this patch (5 runs). The trusted_update() path itself was not run,
> > because no TPM was available.
> > 
> > The problem was found, and this patch prepared, with the help of a
> > formal analysis tool we are developing that uses AI assistance; I have
> > reviewed the analysis and the patch.
> > 
> > Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> > Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
> > ---
> >  security/keys/trusted-keys/trusted_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > index 0509d9955f2a..5efd1e6ef111 100644
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -401,6 +401,7 @@ static void __exit cleanup_trusted(void)
> >  {
> >  	if (trusted_key_exit)
> >  		(*trusted_key_exit)();
> > +	rcu_barrier();
> >  }
> >  
> >  late_initcall(init_trusted);
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Pushed (to master for the time being).

Br, Jarkko
