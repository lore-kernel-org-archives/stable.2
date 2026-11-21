Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795267712;
	b=X4wvVm8+x3s65wq1ZRTvBpp+d+jyitTGtPPn+enGJobw7b4IzRP3pj/en1GP8QHNubN9
	 3lBZ0pGY1iFZ+YtZB5PQX0mbx2Fppth9x2Y2owH70THl3mKpqJ6DkwgzYTCF3PzpTk4H3
	 CP9rePbk5BNyKHtAs2MVt/OLV1pIxddxYjOMDIoag3EOxLkRcjemr4ydiTpfkavvHDMZl
	 NzzAzG1/y0pIYfTFzfkuk3rk6o+11bLPuXurmWhiHRmyYI87L4WPB1ByWgdIBHR2Cmdl/
	 QeBpkOX2SfJTH/PlU9zE3Km/zFCEemY69RSKI3vL9nDJ0aop+mP8v9QY5x/a8Bts6Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795267712;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kDNbZxXOaisBTyYZgGVkrcz49v41G3fPzDPbhhCuzWk=;
	b=0tDzH3XbF4aMqGFaZz36hifEHk+yYHh+Oh9xny2goOcDmB96mX5F/yprR0HZJ11aBCAs
	 4EV6bhMjXNj7MNNjAw9x3/MF3dSILuJawiPwd5m1jdyWlKXbYMnrd4tRmNgaxQXhRlTbd
	 7RvHnG2qev6d0abIL1pVwIcRNRjCXXu1RwtZ0WPrDVDVAle/PWmEQwz8Qaw7u1F2N8hDa
	 HE7rs2jMeYicwd+wFj5wKVA7bB0LTtJgJFQCm+5aNOoYZpjOPJHY0Oekd+hCIaiCsmWtd
	 Bp9hj6ul5hapjIo1ZWAjve9UevDhCSHafgWo+mif+Ll4uEQbJ5b7xOCMYuOai/ilzHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2qtp1le;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A9F86606A320;
	Sat, 21 Nov 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2qtp1le
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E69F81F000C6;
	Sat, 21 Nov 2026 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795267712;
	bh=kDNbZxXOaisBTyYZgGVkrcz49v41G3fPzDPbhhCuzWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f2qtp1lemvblFmUy2qlArDDs1OdYxtd6qgLFU5qNkY4MgBdEMsuT0pCFq/dctZC+c
	 S282KNo8jmbO6TSh+OD0AwTij4ZYtFprDCbEJ59U3lFi1YHKA7FrOIsOb7EuweIGrT
	 qjv1XrslgPf4prUqreGjp14tRs5h1rX0TFVQXMenzaiWfrfrfCpwcyomyDqjPIE/Ej
	 sI2kaxAXuqtkh53gyt1+EwYRDYv6eBGWiccrLean8ME1u/sBuA8xpqyZ9hpEOTfSAj
	 wZvo/qlWIW9T2PhU8zNuO/qNSZq/t5Hs+CR8aDfM3kHaEc7KTNMJq4CG0dyRfYKClX
	 vGnBU5uFh9Jcw==
Date: Sat, 21 Nov 2026 15:28:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] keys: serialise key instantiation against
 keyctl_chown_key()
Message-ID: <awGcfFldbGuXWBJL@kernel.org>
References: <20261121111246.3478-1-enscrpt@pm.me>
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
In-Reply-To: <20261121111246.3478-1-enscrpt@pm.me>

On Sat, Nov 21, 2026 at 11:13:07AM +0000, Sinan Turunc wrote:
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
> key_reject_and_link().
> 
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>
> ---
> In v3 I removed the tool paragraph and the two lockdep subclass sentences.
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

Thank you looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
