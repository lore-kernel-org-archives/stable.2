Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD3547073;
	Mon,  5 Oct 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791161943; cv=none; b=qRfKKktJ0Cb3czv/qOCKQRORAhgP6iJWSZ/RgwGoJ0Sb0KgHMczBMI9jxgqLl5zki05BLIesNA8L59QleDRcSPSI2PNZ3Py8UrJE6k9lg6ygEWVQSP04XoE3GsEQymkINB8nyTuIhruCuhZYuTY4wuzz236ja/LLvU9EYVne3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791161943; c=relaxed/simple;
	bh=M2+TvvQC1xeBQe1EBP0Mj/6nPJqDm5DZDX8zZN8hAVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsU3o9fHNGnfarSCwxG47uFsjf2MoJtLRpm+qytkmoz9fuaJ+VpXiENJjJqw3qi17TGZfZ9UN2pQe14UPQtBFGyacESXuAPIQQnjwl6sJ8LEEvr6vUXvy9rJUAngeZgJyT+UvcdTvTam69saQnw1nNxT7hG8E/ECHQXx356P2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+MGEhBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+MGEhBq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 520A71F000FF;
	Mon,  5 Oct 2026 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791161941;
	bh=GvNRAx7nbNSFO/BRLKhYAnDBuujlG6qX3d+ce8CaBII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C+MGEhBqmGXrNg6ldjGnUOH0i6huNVsUTFBhv6OpQp/RTpViZMmj6bEnREYkvOu96
	 MbDZ9FT8tY+5RqiW3Q19lFJlV9jetRZnTERXpIq2QQIS++Vl74od5F9WPhDVWgAv5z
	 dZ87ZWEF7esSw6f7YLF5BWMz1mnliOmuYF6QwSpz/pMhSG9sMFge77+vCMAwHtIttC
	 syI3kHH9YKNMM5g4fL37lAKv1HdBJMfiLHMpeXHVN67MvmxTbweFgC+eBmyLkKpDSC
	 FFhWg53EjlB50HvLxn2te0BEbAABLUQpl4O8DD7aKPdPnS6g6/gGET7jADHBE0qa3S
	 JB1+ld/p12Z6g==
Date: Mon, 5 Oct 2026 03:58:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] keys: Protect key_user lifetime during ownership
 changes
Message-ID: <asL2UQjYCxt9SF9K@kernel.org>
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-2-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927162528.943886-2-nicoyip.dev@gmail.com>

While preparing PR some changes in this patch started to bother me so
let's do a sanity check.

On Mon, Sep 28, 2026 at 12:25:27AM +0800, Chengfeng Ye wrote:
> keyctl_chown_key() replaces key->user under key->sem and drops the
> reference to the previous owner after releasing the semaphore. Readers
> which do not hold that semaphore can still be using the previous owner
> when key_user_put() frees it.
> 
> For example, namespace filtering in /proc/keys can race with chown:
> 
>   /proc/keys reader                 keyctl_chown_key()
>   user = key->user
>                                     key->user = newowner
>                                     key_user_put(old)
>                                       kfree(old)
>   read user->uid
> 
> An earlier instrumented run reported:
> 
>   BUG: KASAN: slab-use-after-free in proc_keys_start+0x353/0x440
>   Read of size 4 at addr ffff8881128abbc0 by task poc/88
>   Call Trace:
>    proc_keys_start+0x353/0x440
>    seq_read_iter+0x25d/0x1190
>    proc_reg_read_iter+0x19e/0x260
>   Allocated by task 86:
>    key_user_lookup+0x1b4/0x540
>    keyctl_chown_key+0x3cc/0xbf0
>   Freed by task 87:
>    kfree+0x149/0x330
>    keyctl_chown_key+0x7b0/0xbf0
> 
> Serialize pointer replacement and the affected readers with key_user_lock,
> which already protects final key_user removal. Take the lock explicitly
> while /proc/keys and find_keyring_by_name() copy the owner's UID. Retain
> the quota-owner UID rather than substituting key->uid, since they may
> differ for thread keyrings.
> 
> Also hold the lock across owner accesses in key_payload_reserve() and
> across the instantiated-key count increments. Instantiation need not hold
> the target key's semaphore, so these paths need the same lifetime
> protection. Leave key-state publication and the chown accounting transfer
> outside the new critical sections for the separate accounting fix.
> 
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v3:
> - Split from v2 as patch 1/2; see the cover letter for the full split.
> - Rebase onto current mainline and retain explicit reader-side locking.
> 
> v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
> 
>  security/keys/key.c     | 13 +++++++++++--
>  security/keys/keyctl.c  |  2 ++
>  security/keys/keyring.c |  7 ++++++-
>  security/keys/proc.c    | 15 +++++++++++++--
>  4 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index b34a64d81d47..d0d583194b05 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -21,6 +21,7 @@ struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
>  DEFINE_SPINLOCK(key_serial_lock);
>  
>  struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
> +/* Protects key_user_tree and key ownership changes. */

This type of extras in bug fixes do not make any possible sense and set
an extra backporting cost.

>  DEFINE_SPINLOCK(key_user_lock);
>  
>  unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
> @@ -380,9 +381,12 @@ int key_payload_reserve(struct key *key, size_t datalen)
>  
>  	/* contemplate the quota adjustment */
>  	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> -		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
> -			key_quota_root_maxbytes : key_quota_maxbytes;
>  		unsigned long flags;
> +		unsigned int maxbytes;
> +
> +		spin_lock(&key_user_lock);
> +		maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
> +			key_quota_root_maxbytes : key_quota_maxbytes;
>  
>  		spin_lock_irqsave(&key->user->lock, flags);
>  
> @@ -396,6 +400,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
>  			key->quotalen += delta;
>  		}
>  		spin_unlock_irqrestore(&key->user->lock, flags);
> +		spin_unlock(&key_user_lock);

I don't understand the necessity of key_user_lock here.

>  	}
>  
>  	/* change the recorded data length if that didn't generate an error */
> @@ -447,7 +452,9 @@ static int __key_instantiate_and_link(struct key *key,
>  
>  		if (ret == 0) {
>  			/* mark the key as being instantiated */
> +			spin_lock(&key_user_lock);
>  			atomic_inc(&key->user->nikeys);
> +			spin_unlock(&key_user_lock);
>  			mark_key_instantiated(key, 0);
>  			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
>  
> @@ -604,7 +611,9 @@ int key_reject_and_link(struct key *key,
>  	/* can't instantiate twice */
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
>  		/* mark the key as being negatively instantiated */
> +		spin_lock(&key_user_lock);
>  		atomic_inc(&key->user->nikeys);
> +		spin_unlock(&key_user_lock);

atomic_inc() is wrapped under spinlock in the two changes above. Why
is that necessary?

>  		mark_key_instantiated(key, -error);
>  		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
>  		key_set_expiry(key, ktime_get_real_seconds() + timeout);
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529..c17924609317 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1036,8 +1036,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  			atomic_inc(&newowner->nikeys);
>  		}
>  
> +		spin_lock(&key_user_lock);
>  		zapowner = key->user;
>  		key->user = newowner;
> +		spin_unlock(&key_user_lock);

This is where I get it as you swap the key->user.

>  		key->uid = uid;
>  	}
>  
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f282..5943e8b48c0f 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1148,6 +1148,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  {
>  	struct user_namespace *ns = current_user_ns();
>  	struct key *keyring;
> +	kuid_t uid;
>  
>  	if (!name)
>  		return ERR_PTR(-EINVAL);
> @@ -1158,7 +1159,11 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  	 * grants Search permission and that hasn't been revoked
>  	 */
>  	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> -		if (!kuid_has_mapping(ns, keyring->user->uid))
> +		spin_lock(&key_user_lock);
> +		uid = keyring->user->uid;
> +		spin_unlock(&key_user_lock);

In this and similar site I do not get it. Why key->user->-lock could not
be instead?

> +
> +		if (!kuid_has_mapping(ns, uid))
>  			continue;
>  
>  		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 4f4e2c1824f1..e507c500c068 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -68,7 +68,13 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
>  	n = rb_next(n);
>  	while (n) {
>  		struct key *key = rb_entry(n, struct key, serial_node);
> -		if (kuid_has_mapping(user_ns, key->user->uid))
> +		kuid_t uid;
> +
> +		spin_lock(&key_user_lock);
> +		uid = key->user->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (kuid_has_mapping(user_ns, uid))
>  			break;
>  		n = rb_next(n);

Isn't procfs change at least out of scope? It

>  	}
> @@ -80,6 +86,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
>  	struct user_namespace *user_ns = seq_user_ns(p);
>  	struct rb_node *n = key_serial_tree.rb_node;
>  	struct key *minkey = NULL;
> +	kuid_t uid;
>  
>  	while (n) {
>  		struct key *key = rb_entry(n, struct key, serial_node);
> @@ -100,7 +107,11 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
>  		return NULL;
>  
>  	for (;;) {
> -		if (kuid_has_mapping(user_ns, minkey->user->uid))
> +		spin_lock(&key_user_lock);
> +		uid = minkey->user->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (kuid_has_mapping(user_ns, uid))
>  			return minkey;
>  		n = rb_next(&minkey->serial_node);
>  		if (!n)
> -- 
> 2.43.0
> 

By putting global lock every possible site the bug does get fixed but
nothing really makes the case that this is ultimately least intrusive
way to fix this.

I could fix almost any possible race condition if there was a preference
to use global lock for everything. I'm neither sure whether this is a
superset change that covers the bug fix or not.

Br, Jarkko

Br, Jarkko
