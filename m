Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE266412C14;
	Mon, 10 Aug 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375562; cv=none; b=GNNC0I1PhFYlJNMZOv4FgqTrS4Akudcu6EU3iJMdSL7Q4dx4LRv98lGWyGlrFHrZxrwikQRo+jMmn/z6u0oqcAIcyjrE7payVitDAQCMt6zpVv9bpth8nXAwRue8kEVJ0zajp9rCcECsZU5mQDAh2O/u5Y2su03kiwVaddqPOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375562; c=relaxed/simple;
	bh=cBbEuBXDYGfvTczhgMtrEgmzqHHgNaR3v5+5iJE1Tvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2z3Wg7/JIJLdJGgJnU7LwwUgvlFfayoiPjlU6DeiV5KrqLP/BWcU6jlH7+GmqqGMU+pAa/wrdSi0wpDtXuyklFQbbODBIOxUAZJTfidotMWJ2jZE7vDIvMLsqOHGSLqaI5qi8xWLi3J0C1M36mmj2bDKitC3EseQJp8SNqNLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEVVy+Rl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEVVy+Rl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E48D71F000E9;
	Mon, 10 Aug 2026 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786375561;
	bh=R6XGNIoHTxlsz/t6Ux5E4FYc5dcadC245O5UcI4QIWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lEVVy+RlGR7iKBSWGUV0tR0j3SPbLz2UPic+KDLB9+hCAMXYa4bF596SqhJz/iijw
	 Q1n1ucMYrlWNV22lXhAyiuOxe6pXyVTO48Whqq82x0+hnRJ2NKRdSdJsFiKYNfwf6w
	 MBx+a3KlQutMvZd7rDbjqKHmyfucbBNfrGdqwH5uXY322BxTpjYcpwhzh6ip20RiDm
	 RgSCnU8Zij5jIWb3igScPdhoBgW+AMWVOF064FFU5+ua3NVq/RmR3xUar5cAdB6DIF
	 IxgJwnDZwyV812DRjRxmzq+ZBRAllmrjwI7k7d94iSDyJAtROADXPPYwtBqz5MUk59
	 CW+G3FveO6n4Q==
Date: Mon, 10 Aug 2026 18:25:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix TPM teardown ordering
Message-ID: <anntgVGE0cUzQxjJ@kernel.org>
References: <20260731140925.2973492-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731140925.2973492-1-nicoyip.dev@gmail.com>

On Fri, Jul 31, 2026 at 10:09:24PM +0800, Chengfeng Ye wrote:
> trusted_tpm_exit() drops the TPM chip reference and frees the digest
> array before unregistering the trusted key type. key_type_lookup()
> holds key_types_sem for reading until the key operation finishes, while
> unregister_key_type() takes it for writing. It therefore provides the
> synchronization point that must precede backend teardown.
> 
> The current order permits this interleaving:
> 
>   CPU 0                              CPU 1
>   trusted_tpm_exit()                 key_type_lookup("trusted")
>     put_device(&chip->dev)             trusted_tpm_seal()
>     kfree(digests)                       pcrlock()
>     unregister_key_type()                  tpm_pcr_extend(..., digests)
> 
> CPU 1 can consequently dereference the freed digest array. The chip can
> also be released before callbacks stop using it.
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in tpm_pcr_extend+0x1f0/0x200
>   Read of size 2 at addr ffff88810872d000 by task poc/89
>   Call Trace:
>     tpm_pcr_extend+0x1f0/0x200
>     pcrlock+0x42/0x70 [trusted]
>     trusted_tpm_seal+0x1b6/0x570 [trusted]
>     trusted_instantiate+0x293/0x340 [trusted]
>     __key_instantiate_and_link+0xb2/0x2b0
>     __key_create_or_update+0x61e/0xb50
>     __do_sys_add_key+0x1b8/0x310
>   Allocated by task 88:
>     __kmalloc_noprof+0x1a7/0x490
>     do_one_initcall+0xa1/0x390
>     do_init_module+0x2df/0x840
>   Freed by task 90:
>     kfree+0x131/0x3c0
>     trusted_tpm_exit+0x59/0xa0 [trusted]
>     __do_sys_delete_module+0x346/0x510
> 
> Move unregister_key_type() before releasing either resource. This stops
> new lookups and waits for in-flight key operations to finish before the
> backend state is destroyed.

Thank for the great report.

> 
> Fixes: 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 13513819991e..8f57c6111e7e 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -987,9 +987,9 @@ static int __init trusted_tpm_init(void)
>  static void trusted_tpm_exit(void)
>  {
>  	if (chip) {
> +		unregister_key_type(&key_type_trusted);
>  		put_device(&chip->dev);
>  		kfree(digests);
> -		unregister_key_type(&key_type_trusted);
>  	}
>  }
>  
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
