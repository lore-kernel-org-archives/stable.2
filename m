Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725756;
	b=f5xHpnCOrkl2T3Xq41k9uf/D1OOvVk/H/tLI1hO37pL2S8A/Bdmylt8D0OxApacJOcdU
	 tXqMTwl7fDyeSYYw3tKpjuuC4Pv2UoIMUahHQv3uftF9lyi77cY09n2MvX7094ClVuNrZ
	 LFobxzlnrUcqXpdiybNkD0uLoVFQ633bhu4rHdYdsgSmoYfJZq/TrDfB8rqSu/mjtjp2U
	 hjqqp04d6klZQKY8tRUKYfWPLQberaJ576m+BGMBByBi4By5lyjE5exLNWkk88eDXTWdE
	 S/rCVcJSUSk1LU9ICK/ueaVjqVMgRNtby6X7bIFFphNKQ9uxHsopaZEH1MXhRLeLjTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725756;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8NN+B8u+RFwzaRv8suS/udVP1QrYK0wYS6hWukeedGk=;
	b=A/IUWjsAlBzXWiMRKt6MYb5K86XGc92ROyNyfQeazYPH4fCppgGHT/XqJbS5TXDGyiAT
	 tdMPNyPsodcBTTcDfpCgKQKb/zOKzJFpWk0uWPznZIcCvjQt98p6JowrFzOQC53wFXsgx
	 bF1ZlcLTp6lK1h33TdCNcO+Uq9ffm/1yCv9KMpbPCP9z95JatXK2IG0eVK1CXpFABg+aw
	 7X4LOqtOtRPeDOoNCaczTJi7uLHibwa3Hqj4opkB6bx/f0dagIwRkiekMOO8I2gZcVNON
	 RwLcFF+9QTIWBe/9yGkx+yA7pTPx9kQygHUYhyWzl4V/i1t7lyPIGB4azMYlhgeIhWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVPEuSAL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 59DD2606A333;
	Thu, 26 Nov 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVPEuSAL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 58DA21F000C1;
	Thu, 26 Nov 2026 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725755;
	bh=8NN+B8u+RFwzaRv8suS/udVP1QrYK0wYS6hWukeedGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AVPEuSALgJ5pMqmCet7eCzFb9mn1DqNe+pwImMk5lAYTdhwcj3Z4JWY0CAfPmm1uD
	 2V/2TN+prMd6DQ/klKH+XMeBkQ1k2zWLDShJAyzdRFdOY5XpmohVRgmeZMzWY1/1R9
	 kD7RAXX37MYZqBuKAATSC7+sLI5PnC/XbKeE/+AVJ36HhWa2erQ0Zk7YnG9nDySOPJ
	 XNU3Pun2pPC7N9QPftj/91GztwuEwYzZ8X892ZBkjzo3NI+veRxRMaKGmA1pWoIcHb
	 O37SSEKnBWizlFT6rB3sQCIzA+GMvx+lovPKtIVwWDDmOqqFc/U59l3O3+u0aIyh1b
	 xmWSp4pIsAF4g==
Date: Thu, 26 Nov 2026 22:42:32 +0200
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
Message-ID: <awiZuKwNUP6mi6Yg@kernel.org>
References: <20261126200103.2806716-1-zhenwenliang@google.com>
 <20261126200103.2806716-2-zhenwenliang@google.com>
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
In-Reply-To: <20261126200103.2806716-2-zhenwenliang@google.com>

On Thu, Nov 26, 2026 at 08:01:03PM +0000, Zhenwen Liang wrote:
> trusted_update() frees the old payload with call_rcu(), and the
> callback, trusted_rcu_free(), is part of trusted.ko. cleanup_trusted()
> calls the trust source's exit callback, which unregisters the key type,
> but nothing waits for callbacks that are already queued, so the module
> can be freed while a trusted_rcu_free() callback is still pending.

+1

> 
> Add an rcu_barrier() after the exit callback. As for encrypted keys, no
> new callback can be queued once unregister_key_type() has returned. If
> no trust source was found, the key type was never registered and
> trusted_key_exit is NULL; the barrier is then harmless.
> 
> Tested in QEMU (x86_64, TCG) without a trust source, so only the
> trusted_key_exit == NULL case ran: trusted.ko loads and unloads cleanly
> with this patch (5 runs). The trusted_update() path itself was not run,
> because no TPM was available.
> 
> The problem was found, and this patch prepared, with the help of a
> formal analysis tool we are developing that uses AI assistance; I have
> reviewed the analysis and the patch.
> 
> Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
> ---
>  security/keys/trusted-keys/trusted_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 0509d9955f2a..5efd1e6ef111 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -401,6 +401,7 @@ static void __exit cleanup_trusted(void)
>  {
>  	if (trusted_key_exit)
>  		(*trusted_key_exit)();
> +	rcu_barrier();
>  }
>  
>  late_initcall(init_trusted);

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
