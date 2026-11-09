Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268504;
	b=YBl3BBkaJvAvzQdeRzmTG9+BaFpznyJdOXk4li9NBqvPbiN21a+pbWKx6B3oh2vGTnLS
	 pxwB1wetsumTP/SvbWXU8UI340XMUf9oRx+XTclk5SB12LoyyxUUM6OW4bwAoDBhEA7MM
	 tR3foFvRD0MWUJc0OdR39NXLLP5peilS0NhrLHYRuH+o66hbnOBs74OMxTbu99Xwim4ga
	 WG5/qJc4Dxu//zog8nQmJzO9EYWNf6n3iAps76BtNwsDiEQXE/83OiAkLZFx+1S0jB9kr
	 osMfFa/k1lDOb7SI0SIFvOULDoiSFZyndB3sDrtj6DsQB2pmkMgiROpwP3Y7+6vmc3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kIJ01WjKF4qVqwq81p6btzLmnCuxRCA/5psrgXlQwZA=;
	b=dlD9BMayOuVxt7XR9Z1oN1lrfVB6kA+UEL8lak3TOiiUI/5Nx+psnjHqVP8gd4CEDvWR
	 +TMfMImXWjTm24i+k3beSz7yYDRkUT2jOcs6SjkKkI5jRxz+G+3PhUyTrWar8k4Z3No5R
	 ynk3tF0E7bGCUrjgS5Nh85sbFZQd3xINYi+13jY5yUcKgvYtzvKo/CZSHpBKaqFWr0RaQ
	 I+twlCLcuNwCLHf1W6lxtnpn6q8knR3WX6DiR/DajRhZPOFrwcVxj3wrqfDNMixuEskjv
	 bFYUdlF86Jf+d63w1hUMEWcUwdftK49xBwdNZk7ni2IKGSeAQWhvHgkaY3HWeQpG03w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqCRTBdd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 13C02606A31C;
	Mon,  9 Nov 2026 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqCRTBdd
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 82E5B1F0089F;
	Mon,  9 Nov 2026 23:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268503;
	bh=kIJ01WjKF4qVqwq81p6btzLmnCuxRCA/5psrgXlQwZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SqCRTBddb/UNEkzoxynPKJ31PXuMZduv8yRRXREk+VFf7TTQVucKZw4WFjse+MDYZ
	 BdteeU0mRcIvXYFVw2NUDAwjZmvpEqYL4LJAdPGusZFQNj6fNgPmx9P/B/n9Lh5edl
	 8dVy6csb5Rz7dkYJ5/BHn5sRMg+QD8gLrHX3VjWHHU6Ag1jqbrhDHjfaXGH+3VQRGR
	 pojBAxjM4P1F6o+1/1Lhy2AM4k+e919w0Cy8Enj43sNfRDk0LQm1eYMxSLuHSYURwP
	 CK6StWxgWtcsuABufaKYxlUUNF7w6K9/2rphILfhFPPUR/fZaiQBfoir6M0Z6MUe7m
	 tfl9o1SPuvsIA==
Date: Tue, 10 Nov 2026 01:54:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 1/2] KEYS: Return user session keyring on lookup
Message-ID: <avJdUy2fYGv1QwDM@kernel.org>
References: <20261105220050.1421842-1-jarkko@kernel.org>
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
In-Reply-To: <20261105220050.1421842-1-jarkko@kernel.org>

On Fri, Nov 06, 2026 at 12:00:49AM +0200, Jarkko Sakkinen wrote:
> A process without a session keyring looking up KEY_SPEC_SESSION_KEYRING
> without KEY_LOOKUP_CREATE mutates the credentials. This causes struct creds
> instances shared with other subsystems to become stale.
> 
> Address this by returning the resolved user session keyring directly
> without installing it into credentials.
> 
> Cc: keyrings@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: stable@vger.kernel.org # v5.10+
> Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
> Suggested-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

These patches have zero Sashiko remarks and are looking pretty good
overall.

Is there any reason not to apply them?

> ---
> v3:
> In keyctl_session_to_parent(), check the resolved cred->session_keyring
> instead of mycred->session_keyring.
> v2:
> - Added mandatory tags.
> - No code changes.
> - Link: https://lore.kernel.org/keyrings/20261019145624.309790-1-jarkko@kernel.org/
>  Documentation/security/keys/core.rst |  6 ++--
>  security/keys/keyctl.c               |  5 ++--
>  security/keys/process_keys.c         | 44 +++++++---------------------
>  3 files changed, 16 insertions(+), 39 deletions(-)
> ---
>  Documentation/security/keys/core.rst |  6 ++--
>  security/keys/keyctl.c               |  5 ++--
>  security/keys/process_keys.c         | 44 +++++++---------------------
>  3 files changed, 16 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index 37ed42382f16..e3a215e55f81 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -165,8 +165,10 @@ The key service provides a number of features besides keys:
>       When a process changes its real UID, if it used to have no session key, it
>       will be subscribed to the default session key for the new UID.
>  
> -     If a process attempts to access its session key when it doesn't have one,
> -     it will be subscribed to the default for its current UID.
> +     If a process attempts to access its session keyring when it doesn't have
> +     one, the default user session keyring for its current UID is returned
> +     without being installed into its credentials.  If creation is requested,
> +     an anonymous session keyring is installed.
>  
>    *  Each user has two quotas against which the keys they own are tracked. One
>       limits the total number of keys and keyrings, the other limits the total
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d6b10fd67627..b11716f88ded 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1682,8 +1682,7 @@ long keyctl_session_to_parent(void)
>  	 * there's no point */
>  	mycred = current_cred();
>  	pcred = __task_cred(parent);
> -	if (mycred == pcred ||
> -	    mycred->session_keyring == pcred->session_keyring) {
> +	if (cred->session_keyring == pcred->session_keyring) {
>  		ret = 0;
>  		goto unlock;
>  	}
> @@ -1701,7 +1700,7 @@ long keyctl_session_to_parent(void)
>  	/* the keyrings must have the same UID */
>  	if ((pcred->session_keyring &&
>  	     !uid_eq(pcred->session_keyring->uid, mycred->euid)) ||
> -	    !uid_eq(mycred->session_keyring->uid, mycred->euid))
> +	    !uid_eq(cred->session_keyring->uid, mycred->euid))
>  		goto unlock;
>  
>  	/* cancel an already pending keyring replacement */
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index 3af71c6322af..cdf03b8124d0 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -356,31 +356,6 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
>  	return 0;
>  }
>  
> -/*
> - * Install the given keyring as the session keyring of the current task,
> - * replacing the existing one if any.  If the given keyring is NULL, then
> - * install a new anonymous session keyring.
> - *
> - * Return: 0 on success; -errno on failure.
> - */
> -static int install_session_keyring(struct key *keyring)
> -{
> -	struct cred *new;
> -	int ret;
> -
> -	new = prepare_creds();
> -	if (!new)
> -		return -ENOMEM;
> -
> -	ret = install_session_keyring_to_cred(new, keyring);
> -	if (ret < 0) {
> -		abort_creds(new);
> -		return ret;
> -	}
> -
> -	return commit_creds(new);
> -}
> -
>  /*
>   * Handle the fsuid changing.
>   */
> @@ -720,20 +695,21 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
>  
>  	case KEY_SPEC_SESSION_KEYRING:
>  		if (!ctx.cred->session_keyring) {
> -			/* always install a session keyring upon access if one
> -			 * doesn't exist yet */
>  			ret = look_up_user_keyrings(NULL, &user_session);
>  			if (ret < 0)
>  				goto error;
> -			if (lflags & KEY_LOOKUP_CREATE)
> +
> +			if (lflags & KEY_LOOKUP_CREATE) {
> +				key_put(user_session);
>  				ret = join_session_keyring(NULL);
> -			else
> -				ret = install_session_keyring(user_session);
> +				if (ret < 0)
> +					goto error;
> +				goto reget_creds;
> +			}
>  
> -			key_put(user_session);
> -			if (ret < 0)
> -				goto error;
> -			goto reget_creds;
> +			key = user_session;
> +			key_ref = make_key_ref(key, 1);
> +			break;
>  		} else if (test_bit(KEY_FLAG_UID_KEYRING,
>  				    &ctx.cred->session_keyring->flags) &&
>  			   lflags & KEY_LOOKUP_CREATE) {
> -- 
> 2.47.3
> 


Br, Jarkko
