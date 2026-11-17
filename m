Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919803;
	b=5gp8HA6v0ho7HQwUIi4M0oqtcXVHFEEaQbRkI8QLzXeUzqqk3MhCL6hp9BH67YVmXJEx
	 z+aS1vIU1y+5qbrDqG4m+FYH5fPuT11ASg41DCwDPKMaBvmsld0UU+MOEJp7sM1yR/0tW
	 S+E9YoAZjJ7fijAn3RHT5mBjVose2/dVlVKL03KE09ycByyIsDm3Jp6FKLGNXyHj2sthL
	 IGHkY4BA7M2wOvJvSfiSQgcHttPxK6Sw1F09SsHGiD23kY98alCn5FVVH9HmX+vqXwfSH
	 9TdUB9w9gickMB0z4aHdc7RSMkL7fVxiAYrGou8oQH4Z8EayddUvuh69B0L+Wl8gz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919803;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4HuiIGauS8osGSZRga5cuuiCOITNVTElI86TFrKDufU=;
	b=jKb7z11cQxwbicKLXqz/pNgi0qnjuP2OMm9xRpyrfiusuNHAcrmv/nNQT+5iSP2FcpMj
	 FqYOtH+eAW+mq7/YgTW5RGBNXtFqfW/oPgKP2vi7b/bDsGUzRRUdYmAdVzENKQbmSSSjW
	 Id167KWx8YEB1oYzvPHzE/4mMii8yga4KKVCQP4Rr9umD+DC5mbU6pCPtSLjy0XKs9EGZ
	 pa8P25ILU/M5MzktOgChtpGYDWyvExRWKt22AFzJn9Lps+qDYsffGBPxJpk9eFpBW3ti8
	 orayNRoO1Lb2yrhlCbeIo7IBf1p6ztE6EfEn+N/C7Kab3ehumhzNsJcgjzHPHHCsYng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHHNdnzE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 73D94606A333;
	Tue, 17 Nov 2026 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHHNdnzE
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A2BA51F000C6;
	Tue, 17 Nov 2026 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919803;
	bh=4HuiIGauS8osGSZRga5cuuiCOITNVTElI86TFrKDufU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PHHNdnzEEQ0vmDGKuDhTjy7Nt5refP6ttZ5zH+Ji+iEvqr0mJebFyQrvX3RL8eHYB
	 oTMKRNfofR6rUGHi1C8bWjmtX96Uw+UX5SRTzbdpLFg8UkFLON3fr4rpK1LWrsiRfi
	 AXvX9YFO2FopNO3cUvb/kzJnWZ0zBATtIXl5HH57TAZB8qG08auMYWm0S2rqA443CY
	 LkBUPJ+R/sLFzTRTmkeTFqP9qFrRUNHACs1yfmoyASO1EYzKep9/HkJGA+fN50lHll
	 CRUSfOvW/UQ3Mk0GxnCC+ZflvV8LamLMuC4K44GRGaJzn0FHyyw0r5tVwd8WPIugz+
	 eAwpWpmGAAahg==
Date: Tue, 17 Nov 2026 14:49:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] keys: serialise key instantiation against
 keyctl_chown_key()
Message-ID: <avxNd7uCbLiUAi3A@kernel.org>
References: <20261117123353.1822-1-enscrpt@pm.me>
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
In-Reply-To: <20261117123353.1822-1-enscrpt@pm.me>

On Tue, Nov 17, 2026 at 12:34:12PM +0000, Sinan Turunc wrote:
> keyctl_chown_key() looks up the target key by calling lookup_user_key()
> with the KEY_LOOKUP_PARTIAL flag. That flag lets a caller with
> CAP_SYS_ADMIN change the UID of an uninstantiated key during construction.
> When the UID changes, keyctl_chown_key() replaces key->user under key->sem
> and drops the old reference with key_user_put().
> 
> __key_instantiate_and_link() and key_reject_and_link() hold
> key_construction_mutex during instantiation, but neither function takes
> key->sem. Both functions increment key->user->nikeys, and
> __key_instantiate_and_link() also calls key->type->instantiate() without
> holding key->sem. When a key is in quota and its size changes,
> key_payload_reserve() reads key->user seven times without key->sem. Those
> reads include spin_lock_irqsave(&key->user->lock, flags) at the start and
> spin_unlock_irqrestore(&key->user->lock, flags) at the end.
> 
> If keyctl_chown_key() swaps key->user between those two calls,
> key_payload_reserve() unlocks the new owner's spinlock and leaves the old
> spinlock held. By source inspection, key_user_put() can also kfree() the
> old struct key_user while instantiation still dereferences it. That struct
> key_user use-after-free was found by reading the code and did not trigger
> during our KASAN runs.

OK now this is stating to make more sense. Good job.

> 
>   =====================================
>   WARNING: bad unlock balance detected!
>   7.4.0-rc2-g23c62304dde2 #3 Not tainted
>   -------------------------------------
>   request-key/163 is trying to release lock (&candidate->lock) at:
>   [<ffffffff82698fff>] key_payload_reserve+0x29f/0x370
>   but there are no more locks to release!
> 
>   other info that might help us debug this:
>   locks held by request-key/163: 2, on CPU#3:
>    #0: ffffffff871c10a0 (key_construction_mutex){+.+.}-{4:4}, at: __key_instantiate_and_link+0x38/0x370
>    #1: ffff88800de4a8b8 (&candidate->lock){..-.}-{3:3}, at: key_payload_reserve+0x160/0x370
> 
>   Call Trace:
>    lock_release+0x286/0x2e0
>    _raw_spin_unlock_irqrestore+0x1a/0x50
>    key_payload_reserve+0x29f/0x370
>    generic_key_instantiate+0x42/0x230
>    __key_instantiate_and_link+0xd7/0x370
>    key_instantiate_and_link+0x40d/0x4b0
>    keyctl_instantiate_key_common+0x2d2/0x450
>    keyctl_instantiate_key+0x167/0x180
>    __do_sys_keyctl+0x391/0x550
> 
> Take key->sem for write with down_write_nested(&key->sem, 2) inside
> key_construction_mutex in __key_instantiate_and_link() and
> key_reject_and_link(). Subclass 2 is an unused lockdep subclass that is
> only ever taken inside key_construction_mutex. Subclasses 0 and 1 are
> already taken outside keyring_serialise_link_lock by __key_link_lock() and
> __key_move_lock().
> 
> An AI tool assisted with finding the race, writing the four-line fix and
> the reproducer, and running the tests. I reviewed the kernel source and the
> test logs and wrote this commit message myself.

Irrelevant in the commit message as metaphorically it is now a tool just
like text editor is a tool.

I can write a horrific 4chan post with a text editor but if I send it to
LKML and call it a kernel patch, I don't make claims that it was assisted
by a text editor and reviewed by me.

But yeah, I get the commit message better now, thank you.


> 
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>
> ---
> v2
> Drop the inline comment changes from v1 and rewrite the commit message in
> my own words.
> Use subclass 2 in down_write_nested(&key->sem, 2) so instantiation cannot
> form a lockdep cycle with __key_move_lock().
> Update the Fixes tag from the initial git import commit to commit
> 5801649d8b83.
> Tested with the reproducer and the lockdep stress workload on 7.4-rc2
> (23c62304dde2) and on for-next-keys (1dbbde3bc4).
> 
>  security/keys/key.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 3f1f0fc..df31d10 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -441,6 +441,7 @@ static int __key_instantiate_and_link(struct key *key,
>  	ret = -EBUSY;
>  
>  	mutex_lock(&key_construction_mutex);
> +	down_write_nested(&key->sem, 2);
>  
>  	/* can't instantiate twice */
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
> @@ -473,6 +474,7 @@ static int __key_instantiate_and_link(struct key *key,
>  		}
>  	}
>  
> +	up_write(&key->sem);
>  	mutex_unlock(&key_construction_mutex);
>  
>  	/* wake up anyone waiting for a key to be constructed */
> @@ -609,6 +611,7 @@ int key_reject_and_link(struct key *key,
>  	}
>  
>  	mutex_lock(&key_construction_mutex);
> +	down_write_nested(&key->sem, 2);
>  
>  	/* can't instantiate twice */
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
> @@ -632,6 +635,7 @@ int key_reject_and_link(struct key *key,
>  			key_invalidate(authkey);
>  	}
>  
> +	up_write(&key->sem);
>  	mutex_unlock(&key_construction_mutex);
>  
>  	if (keyring && link_ret == 0)
> -- 
> 2.56.0
> 

I think this is right but I will re-check once I have bandwith.

Thanks for addressing my complains.

Br, Jarkko
