Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6911F30BB;
	Sat, 17 Oct 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792269566; cv=none; b=IrXiNlxxhvdq1SsHceyqiWqI1Q0qSu+hZaqNZvVoS41y5GFsNKWLx6KJwc7iinHZ2+cxXx433HV0empg77E86eI5Zbe0MfIb+wMzG3qxArTP1l/Ibfx6CVzEY1WPr/gnTrjph6sBschQ17Kjk/wm1GFl3JXLnJ3aHYt145tz2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792269566; c=relaxed/simple;
	bh=smM3CHUs9M1sqKEz1ShH+cXz9rl6NKZz2SUXLAExoLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBSZT6rZfIVHCAaSMIEydc3i1DJcsAYVRPll7MyAuQOvRkffNfdsF3m0D2QrzcddNhuNp1gS8EPY6o8gC2iq/CG+2cIYkMWPe8fx/6vaAlTdQ3KfyNSzdbjYLnjzj37N5xgink4grFLzoDLdfGV0Jgz4SDSJjpJrHXYCn+lJPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN7nYibv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN7nYibv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706551F000C4;
	Sat, 17 Oct 2026 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792269564;
	bh=1+zVta6ZRFT7GXOMcKiGSvwMYmCClLq2D4/Bh2F8bmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VN7nYibvvQdZ15HO/WXBgyMlhHtL07VUIbDxKJlcDiPiQVbmPQW6EG1U/uZxGDQHa
	 YdVlztMimUphjaIZd946qtgxw00MNk/OVZnzMPW75mbcYudUuTUuWVO8Ksb9TvWwR5
	 gLXc5oS2HgZSkLJEL72qaLK3vUOzM4sfYPAwWV5VS51ZFG3VzVHeTm2efrCCUX9PgB
	 RB1/sEEFWuTDtcE93sEr615NCH089cp+gCiq1Mg9Vby47FI2bmGw11HXIE+3eMVmEi
	 +yn8CnUIM5/qIweesiUzXT4kAUo9L+S9Tsp+XySe+bActcWXUUthvrqXMPOOABK74J
	 11ZCv7ov7icAw==
Date: Sat, 17 Oct 2026 23:39:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] keys: big_key: Remove the redundant quota reservation
Message-ID: <atPc-K1wZtS3lP29@kernel.org>
References: <20261016040004.324286-1-4ncienth@gmail.com>
 <atK0MnGM2h9IH6FD@kernel.org>
 <atK186hMPBhYyPCN@kernel.org>
 <20261017152123.1200429-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017152123.1200429-1-4ncienth@gmail.com>

On Sun, Oct 18, 2026 at 12:21:23AM +0900, Daehyeon Ko wrote:
> A big_key is charged a fixed 16 bytes of key quota, regardless of its
> payload size.  big_key_update() nevertheless reserves the new raw payload
> length before destroying the old payload, and generic_key_instantiate()
> then reserves the fixed quota length.
> 
> For an update shorter than 16 bytes, the first reservation temporarily
> returns quota.  Another key operation by the same user can consume that
> quota before generic_key_instantiate() reserves it again.  If the second
> reservation fails, the key remains positive after its old payload has been
> destroyed.  Reading a buffer-backed key or revoking a shmem-backed key then
> dereferences a NULL payload pointer.
> 
> On a KASAN build, reading a buffer-backed key reports:
> 
>   BUG: KASAN: null-ptr-deref in big_key_read+0x110/0x310
>   Read of size 64 at addr 0000000000000000
> 
> Revoking a shmem-backed key reports, with oops=panic:
> 
>   KASAN: null-ptr-deref in range [0x68-0x6f]
>   RIP: vfs_truncate+0xa2/0x730
>   big_key_revoke+0xbd/0xe0
>   Kernel panic - not syncing: Fatal exception
> 
> The first reservation is unnecessary.  A positive big_key already has a
> 16-byte reservation from successful instantiation, so the reservation in
> generic_key_instantiate() has zero delta and cannot fail after the old
> payload is destroyed.  A negative key has no old payload to destroy, and
> generic_key_instantiate() performs the required reservation before
> publishing the new payload.
> 
> Remove the redundant reservation so that the update path adjusts quota only
> once and cannot expose a temporary quota gap.
> 
> Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Changes since v1:
> - Remove the redundant first reservation instead of changing its length,
>   leaving generic_key_instantiate() as the single quota reservation on the
>   update path, as suggested by Jarkko.
> - Verify full-quota positive and negative updates separately.  A positive
>   update keeps a zero quota delta; a negative update can still return
>   -EDQUOT before publishing a payload and succeeds after quota is released.
> 
>  security/keys/big_key.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index 268f702df380e..ef707f2a81a98 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -193,12 +193,6 @@ void big_key_destroy(struct key *key)
>   */
>  int big_key_update(struct key *key, struct key_preparsed_payload *prep)
>  {
> -	int ret;
> -
> -	ret = key_payload_reserve(key, prep->datalen);
> -	if (ret < 0)
> -		return ret;
> -
>  	if (key_is_positive(key))
>  		big_key_destroy(key);
>  
> 
> base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
> -- 
> 2.55.0
> 

Well, that made a difference. I've started actively try to look
for eager tactics, and in this case it turned out to be worth
it. The first solution was exactly like weighted answer that
cut the search too early :-) 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

PS. Not applying til Monday.

Br, Jarkko
