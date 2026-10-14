Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600273438BE;
	Wed, 14 Oct 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977662; cv=none; b=bw7JTwki2RcseTfcysc/vr8iAeSUKKqfoLqKQCV2D0sd7mxK4jvR45QS0/HqaVLJe+gMzzXjV0qp6t9M7QhaUcXV0ruXOhBUJgCND13eEszUXpAuUW7NJC5iKE6Z9lZ+fOwJosLT4k9UER34ZtWyhpE1dxS1MTd9Gjdgs5K0DBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977662; c=relaxed/simple;
	bh=pgBcEKmkG9yAvAmi8qqEB7pPavUOWQhsahKt8f4vYO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roHz8490mZPRapPDcTKzTmKxa6ydlYhjf0+9jDxN3R9+bomNtl0/kiGQWKeSkNjOpydvpZYR+vUvaoc7cRHx5iBr7LSmLeZO6UYcuH/qZSuoXxHC0nKv3p+A8yfV+Ilbm43JFw3/ULoLWzp5IRvhb+hQc+e61BR77qSRsAYqQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlDu4ow4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlDu4ow4"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 578D31F000FF;
	Wed, 14 Oct 2026 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791977659;
	bh=jxrFaoqkYIedRaaeR6zxDyjEquhjlwc+5JkmGCJ+eMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlDu4ow4he/1o8eJ5INjeDUjYrvQB7OR5kY1bzt4b6nQURke6Jaa36NsFUm+aodWg
	 TxQ/3semYNqMMKBNGMiUWcW1xLJOe8EMi1jXXkJXOclZdFq4LCsvb+OHCw7aw/dmRu
	 7fPH3fD5O6g6WERcC6gmMbtj4rKJppGOdOkdiL2HyPGV29vTFnpKRT0/lY69XXY9Rk
	 xWO+xvXWHtXhoHHKtPgPtOfcZFLZ5uQea/PC8vhImOyHiSEzfx9M0apde6vMYbjiD6
	 OWVd+Q5bnPhcGDzXQb0Uucl+vsDMyQcGwrq8b4/HXtTAEhl7iA4ArFdmGis5Hfkc8C
	 F1w9VH3K5bfVw==
Date: Wed, 14 Oct 2026 14:34:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] keys: Protect quota-owner reads in namespace
 filters
Message-ID: <as9otxVeOLbhkIMy@kernel.org>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013090358.1178367-1-nicoyip.dev@gmail.com>

On Tue, Oct 13, 2026 at 05:03:57PM +0800, Chengfeng Ye wrote:
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

Last night I missed the text below.

It is somewhat messy to the point that frankly I could not read it, or
at least I did not understand it. Have you read it yourself?

There is a whole eassay and I can only see that key->user can change
unless key_user_lock is taken, and READ_ONCE() is required to pair with
the writers.

I don't understand what is going on down there, and what's your goal
with it?



> 
> Take key_user_lock explicitly while /proc/keys and find_keyring_by_name()
> copy the owner's UID. find_ge_key() is the initial/seek lookup reached
> by the reported proc_keys_start() fault; key_serial_next() applies the
> same UID filter to subsequent entries. find_keyring_by_name() reads the
> same replaceable owner when looking up named keyrings.
> 
> key_serial_lock and keyring_name_lock protect these traversals but do
> not exclude chown. Taking key->sem would sleep under those spinlocks.
> The embedded key->user->lock cannot protect the dereference needed to
> acquire it.
> 
> key_user_put() already holds key_user_lock for the final reference
> decrement and tree removal. A reader selecting an owner before removal
> blocks its final release until the UID copy finishes. After removal,
> the lock and reference-count ordering make the preceding owner
> replacement visible, including when another task drops the final
> reference. Mark the pointer loads with READ_ONCE() and the chown store
> with WRITE_ONCE(); the existing lifetime locking provides the protection.
> 
> Retain the quota-owner UID rather than substituting key->uid, since they
> may differ for thread keyrings.
> 
> Other owner accesses already have lifetime protection. key_alloc() uses
> a referenced owner before publishing the key. Final key_put() cannot
> overlap chown, which holds a key reference. key_gc_unused_keys() handles
> unreferenced keys: serial-tree removal excludes /proc/keys readers, and
> keyring_destroy() removes named keyrings under keyring_name_lock before
> the owner reference is dropped. /proc/key-users already holds
> key_user_lock during traversal. Quota reservation and instantiation need
> the separate accounting serialization.
> 
> Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> Cc: stable@vger.kernel.org
> Assisted-by: GPT-6-Astra
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v4:
> - Move the quota-reservation and instantiation scopes from v3 1/2 to
>   the complete accounting fix in 2/2; retain the combined lock coverage.
> - Isolate the namespace-reader lifetime fix and make it independent of the
>   accounting patch by relying on existing lookup/final-release locking.
> - Pair READ_ONCE() pointer snapshots with WRITE_ONCE() in chown; explain
>   lifetime ordering and preserve the quota-owner UID filtering semantics.
> - Include analysis of of the other owner access sites in the changelog
> 
> v3: https://lore.kernel.org/r/20260927162528.943886-2-nicoyip.dev@gmail.com/
> v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/
> 
>  security/keys/keyctl.c  |  2 +-
>  security/keys/keyring.c |  7 ++++++-
>  security/keys/proc.c    | 15 +++++++++++++--
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529c..c89a4d6efed40 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1039,3 +1039,3 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  		zapowner = key->user;
> -		key->user = newowner;
> +		WRITE_ONCE(key->user, newowner);
>  		key->uid = uid;
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f2821..4a13749bc54cd 100644
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
> +		uid = READ_ONCE(keyring->user)->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (!kuid_has_mapping(ns, uid))
>  			continue;
>  
>  		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 4f4e2c1824f18..aa42ea4becec7 100644
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
> +		uid = READ_ONCE(key->user)->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (kuid_has_mapping(user_ns, uid))
>  			break;
>  		n = rb_next(n);
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
> +		uid = READ_ONCE(minkey->user)->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (kuid_has_mapping(user_ns, uid))
>  			return minkey;
>  		n = rb_next(&minkey->serial_node);
>  		if (!n)
> -- 
> 2.43.0
> 

Br, Jarkko
