Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725722;
	b=vasm7OqG4TXz3ggCxBWbPOJLmnYdqdLjkrqx78OIDaOPFltVSNTyglJL94IYn8uXy6xN
	 IXrbvqM/kO+K4PdePPik1QCIyDsLZiEvSy3GLiQsI3ORIYIgHa3cuJkGykMydqizEI49O
	 bAyEKP7by/ep5Zd//xxjGX8tvdUpLjhQEQO9bNyr87KISv4UnwNOlgxqVKWXRnpYOPIo9
	 KmqXOXv/uMR5PcsWdKxCffKe9uKQTMnhiBePPc13yWg7FmT7pd66bDJGaPqXyTaAOzcg1
	 TSOzGdYm8R351Pvk99rDE3SsjNIKejNbOwU2nmGW33Q6y85/I/vo4d253PcJKa3pScg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725722;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V7jHONApKXuey4v7nx6XCIFygslwSlplPa3Z67ffUE4=;
	b=QZzmo2cmCQ30sUBwBF9bM4kaODLgU40PmTJ8mkFe3GPoQb21PRiU6Q1zvzcQRxlzBENT
	 w89hTXyOVXmUmZ/oGzesLvUZfW4woV530JInj7GRHwWJLvLhySn08FWme7aOGC9rXgO39
	 M29mtFeV2VZqjtfN0PbWqzCCByTjza9Art6UTcJ2b6pkDdGlgIVj+SKoFf5nlwmPPyvFS
	 XEdIGXWO/RM36TIrdss0Mu1I/6AHnGLi5TJ+RMap+iKgf8KbbZSmg6fSWWMzc1ksS+mfi
	 K4ma6mE4M9zMOxeL6Hlfjm2AxyZS1sgl1hU0LxfBfpRDZf6N1NwcY050yCxgl7S6J1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/7f0ErP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6604F606A333;
	Thu, 26 Nov 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/7f0ErP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B07711F000C1;
	Thu, 26 Nov 2026 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725722;
	bh=V7jHONApKXuey4v7nx6XCIFygslwSlplPa3Z67ffUE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m/7f0ErPFwEn+1Q+1P8UHYRCw4nLmhAQtQsuQK8p/N+Xd1w/97APxRc47JHanfsSx
	 sDN89lO7hjMnvkz0KGkPILv0pHsZTI31ic2SbhtzRlN5rLrX7wKE4us6enqOVqY2ks
	 3M8hq7w0Y8O3uVORo8/znaUxoZKURL6MalNRbY+0dGC9MWwr7PDVw4lI72pt/Tlt2j
	 6DHMLHK57eIOzHaG3TWJ48oMorP3zVJb85rwBACwKKZr173rEVCKYv0cH5JNUZbnvt
	 v9NEPw/s12WChPKKMHwtNXcnpF8XiugdzHWOh+6kSDDcGSQe5zg3LJZE4VHsVPcoZw
	 a7rQ2OdtpCFyQ==
Date: Thu, 26 Nov 2026 22:41:58 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Zhenwen Liang <zhenwenliang@google.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KEYS: encrypted: Wait for RCU callbacks before
 module unload
Message-ID: <awiZluP9XVZrtDe9@kernel.org>
References: <20261126200103.2806716-1-zhenwenliang@google.com>
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
In-Reply-To: <20261126200103.2806716-1-zhenwenliang@google.com>

On Thu, Nov 26, 2026 at 08:01:02PM +0000, Zhenwen Liang wrote:
> encrypted_update() frees the old payload with call_rcu(), and the
> callback, encrypted_rcu_free(), is part of encrypted-keys.ko.
> cleanup_encrypted() only calls unregister_key_type(), which does not
> wait for callbacks that are already queued. If the module is removed
> shortly after a KEYCTL_UPDATE, the RCU core later calls
> encrypted_rcu_free() in freed module memory.
> 
> No new callback can be queued once unregister_key_type() has returned:
> key_create_or_update() holds key_types_sem across __key_update(),
> key_update() checks key->type->update with key->sem held, and the
> garbage collector switches every remaining key of the type to
> key_type_dead under key->sem before unregister_key_type() returns. An
> rcu_barrier() at that point therefore waits for all pending
> encrypted_rcu_free() callbacks, as Documentation/RCU/rcubarrier.rst
> describes for modules that use call_rcu().
> 
> Tested in QEMU (x86_64, TCG) on mainline (7.4-rc4+) with KASAN,
> ENCRYPTED_KEYS=m and CONFIG_RCU_LAZY=y, so that callbacks are deferred:
> add an encrypted key, update it 20 times, then call delete_module()
> right away. Without this patch, the rcuop kthread hit int3 at
> encrypted_rcu_free+0x1 in the freed module text in 5 of 5 runs. With
> it, 5 of 5 runs were clean, and the unload took about 30 ms longer.
> 
> The problem was found, and this patch prepared, with the help of a
> formal analysis tool we are developing that uses AI assistance; I have
> reviewed the analysis and the patch.
> 
> Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
> Link: https://lore.kernel.org/all/20261126023538.4160950-1-zhenwenliang@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 63f0245e6f74..fca809819f8e 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -1000,6 +1000,7 @@ static int __init init_encrypted(void)
>  static void __exit cleanup_encrypted(void)
>  {
>  	unregister_key_type(&key_type_encrypted);
> +	rcu_barrier();
>  }
>  
>  late_initcall(init_encrypted);

This is obvious enough. I anyway decided to go these through to get
them out of the way.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
