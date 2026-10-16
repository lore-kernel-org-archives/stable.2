Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E643A0B2E;
	Fri, 16 Oct 2026 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792193591; cv=none; b=cozP3ywyafrYtj1rjhYZKNPp/g440wutePYtfJULJCF3/Bi5hDVahBY3ESdzw9Dg/bakGIEzIIsKtJOCsdXu3DUoZ+QCimMjV4GRDe2wBtSWXZoJXBs4+aBJ6yMik5oPphhzIqbfA6vExo3hpJ8IVukGpdI89UXEOVs6Q+xL75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792193591; c=relaxed/simple;
	bh=BOGxqdgsDCUDl20pQ+ZvlEhv34ww0TCR3mML+kfHUoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3B7AShNJvlh3vxTC7uunl5qyYZqT0ZQ5LMV789PPQ6MWy7WA82+oPDieTXXOUtnndTaKgD17AXeYpYfddgdTUDSHcP7PbcfZ0sECThISaMqnwyl+29ewthDmGI00S5eURPmkZ5u+Tgl8WWiZh0lQ7zN8XsN56bbbzHQSTRJOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6GbtiYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6GbtiYa"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 80DCC1F000C4;
	Fri, 16 Oct 2026 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792193590;
	bh=p/DyLjuLlza0Yq/USRLh1C7+lKfMs/2rmZyYZJtT2oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6GbtiYa9tOS0tk+4Gwb2sVZi1lZGmTMjdX5KXxEvaTwRb1inghr24JIePnU10Nbg
	 SyztWUMwF4FoNOTBc5RTaMdJeYwY5XMt74DazNh0lnhuzZarN7I6dgQdG/cIpvKZ3Q
	 SysxMWdZ57TN6WZJ6YitndwRmOsmcZtm2NbM4+0+7mlnqvrM9M6nSs7aF1uZq5pTG6
	 BNBh8Y2C7Iaw0HgfThJrvGHXgUbg6Mizkh8bjsr95RQ2LGq4X7kZ4frJCOqY/xp02k
	 XKRkBqLh5SC4+znW/vtd1Ewz0OJzJvxe3VBgO+hBi1VI68GVKiCV6Sl5ydSDNhrwor
	 tgdPS07Xpc99w==
Date: Sat, 17 Oct 2026 02:33:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] keys: big_key: Reserve the final quota before destroying
 the payload
Message-ID: <atK0MnGM2h9IH6FD@kernel.org>
References: <20261016040004.324286-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016040004.324286-1-4ncienth@gmail.com>

On Fri, Oct 16, 2026 at 01:00:04PM +0900, Daehyeon Ko wrote:
> A big_key is charged a fixed 16 bytes of key quota, regardless of the
> actual payload size.  big_key_update() currently reserves the actual new
> payload length before destroying the old payload, while the subsequent
> generic_key_instantiate() reserves the fixed quota length.
> 
> For an update to a payload shorter than 16 bytes, the first reservation
> temporarily returns quota.  Another key operation by the same user can
> consume that quota before generic_key_instantiate() tries to reserve it
> again.  If that second reservation fails, the key remains instantiated but
> its old big_key payload has already been destroyed.  Reading a
> buffer-backed key or revoking a shmem-backed key then dereferences a NULL
> payload pointer.

Even at the risk that I'm saying something stupid, makes me
wonder why the call exists in big_key.c? I.e. why not remove
the call instead of doing what the patch does?

If I'm now missing something out, that's cool, just correct
me.

> 
> On a KASAN build, reading a buffer-backed key reports:
> 
>   BUG: KASAN: null-ptr-deref in big_key_read+0x110/0x310
>   Read of size 64 at addr 0000000000000000
>   ...
>   big_key_read+0x110/0x310
>   keyctl_read_key+0x2da/0x550
> 
> Revoking a shmem-backed key reports, with oops=panic:
> 
>   Oops: general protection fault
>   KASAN: null-ptr-deref in range [0x68-0x6f]
>   RIP: vfs_truncate+0xa2/0x730
>   big_key_revoke+0xbd/0xe0
>   key_revoke+0xc0/0x1a0
>   Kernel panic - not syncing: Fatal exception
> 
> Reserve the final fixed quota length before destroying the old payload.
> The reservation in generic_key_instantiate() then has no quota delta and
> cannot fail for this reason after the destructive step.
> 
> Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  security/keys/big_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index 268f702df380e..6aff1a73c7b38 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -195,7 +195,7 @@ int big_key_update(struct key *key, struct key_preparsed_payload *prep)
>  {
>  	int ret;
>  
> -	ret = key_payload_reserve(key, prep->datalen);
> +	ret = key_payload_reserve(key, prep->quotalen);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.55.0
> 

Br, Jarkko
