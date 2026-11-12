Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488581;
	b=tWUydDuWyltVYkZrDdca+qPwZkdQTBXWM9XS7P/ELXKb6H3a5VEXbDrGZM/ypN8Ech1v
	 e+vfd5/G8V/E0csxosE/P9Sc7K0dFHfXEIzPJ3v/OqbqRzNUxSdiaml5wa4jhZgb5q4ow
	 NHlozCvkBAqQ5tISWvSFk51kJIE5STC6xmxYyy1FmFzXFr8xvtY6wm8tpHqErPAfm9mRT
	 fwxGspkQjK5ShhhT8MYeCk5TqwDe/N6UBG+60z1xNmjiVO59Xnof1QzTlrHeNFY9ITWdB
	 kIJkBwV73G6Og7xmaEyB7N53xmSSNPWchjewtxfrcYMGm1v5UQt+/m+r2HG23I4I9Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488581;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=PBMXrFHASTKvrJ3Cb5b0x0+RtF3vzzYr8AtwvtbYKsw=;
	b=eBzqwnKj6nxRAs85F9d91ojB97+YahzPdIXl/RtjQ3NbF/tNRp6AAdXKGpV/pQIG8LC2
	 w6e20KzXfULHK5lQVuHGplwZ2f75fp2Qnsnxj2H15qk8blvyxVX4dyyYbO+6KTinp1LUT
	 STXee7gYvX8A8JMglOqwno0Xcr5BZZOWqruowKQ0pmtmj4bjGDKOoWtTOFxRWr6/U7gJi
	 FWjLDPi0iYdwev/wdfzc9uoY3miudsdS4g4pmpaavtRgcyj3TMURCjAATxwWjjxyD+FRI
	 QM5sSwSTGpM3sclHhtK0A8eTYxyc5ZdyAJLHXEfFGoQ+6re5KlGR8179qDzteYNYV1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRHY2zLx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE87606A32D;
	Thu, 12 Nov 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRHY2zLx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FD91F00A05;
	Thu, 12 Nov 2026 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488581;
	bh=PBMXrFHASTKvrJ3Cb5b0x0+RtF3vzzYr8AtwvtbYKsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jRHY2zLxOj7WOeDeEhGyK3iIohwoIz8uR9UPmPqVT352H9skpMuFTV9PBQ/6y/1Fx
	 GzdmrtGGqJQ63ZNgLxvdxP6/TqfDfv+pWpyJzzJjsEy0uLq0gCHvLtP2kFaPaF2gmD
	 k+82GEbMTwloLecctiZmDuG7AmYK6+EdtzWP4kHBvpz/QaP6+ggdm+v2Euvg+7jxrf
	 dZ8PsSmiuOYeuKxv4Ga7Hc56IzIDxYY5JTbQN7bguZv3KvKcNni9eKjMhpoB8uQHcL
	 gImrGD5cw+GOgZatap3BjEF7H+jbUQyRB1xDogkvH5zB1pphPHXsBWhyi9bL21hoJy
	 iD99ShP63r5Fg==
Date: Thu, 12 Nov 2026 07:02:54 -0600
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>, Ada Smith <adasmithgt@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] capabilities: Check PR_SET_SECUREBITS with
 ns_capable()
Message-ID: <avW4_r3IwLTNsXDg@shallyn-amd>
References: <20261110202811.2409395-1-mic@digikod.net>
 <20261110202811.2409395-2-mic@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110202811.2409395-2-mic@digikod.net>

On Tue, Nov 10, 2026 at 09:28:06PM +0100, Mickaël Salaün wrote:
> Per-process securebits were introduced with a direct cap_capable() check
> for CAP_SETPCAP.  The capable LSM hook and SELinux capability policy
> already existed, and SELinux forwarded task_prctl operations to
> commoncap.  The direct call therefore bypassed SELinux policy from the
> start.  It now also bypasses AppArmor, Landlock, and BPF LSM programs
> attached to the capable hook.
> 
> A task with CAP_SETPCAP in its effective set can consequently change
> privileged securebits despite an LSM denial.  This can alter how its
> capabilities evolve across UID and execution transitions without the
> expected LSM denial or audit record.
> 
> Use ns_capable(), as cap_prctl_drop() already does for PR_CAPBSET_DROP.
> Call it only for a no-op, which requires privilege for legacy reasons,
> or when a privileged bit changes.  Changes limited to
> SECURE_ALL_UNPRIVILEGED and their lock bits do not need the capability,
> so they must not invoke an LSM check or set PF_SUPERPRIV.  Successful
> privileged checks now set PF_SUPERPRIV, as other ns_capable() callers
> do.  Without other LSMs, the same requests remain allowed as before.
> 
> The check now reaches every capable hook before commoncap commits the
> new credentials.  A later task_prctl hook cannot provide equivalent
> mediation because commoncap runs first and commits the change itself.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Matt Bobrowski <matt@bobrowski.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>

The commit message is a bit wordy.  All it really needed to say was
that 1. s/cap_capable/ns_capable to query other lsms, and 2. move
the check to a concise helper.  I really do not relish looking through
a git log where every commit message re-litigates the full history of
any code that is touched or moved.

But it looks good, thanks.

Reviewed-by: Serge Hallyn (AMD) <sergeh@kernel.org>

> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: stable@vger.kernel.org
> Reported-by: Ada Smith <adasmithgt@gmail.com>
> Fixes: 3898b1b4ebff ("capabilities: implement per-process securebits")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/commoncap.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index d47ab3022343..1947128396e2 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1283,6 +1283,23 @@ static int cap_prctl_drop(unsigned long cap)
>  	return commit_creds(new);
>  }
>  
> +/*
> + * Doing anything with securebits requires privilege (go read about the
> + * "sendmail capabilities bug"), except for unprivileged bits.  Indeed, the
> + * SECURE_ALL_UNPRIVILEGED bits are not restrictions enforced by the kernel but
> + * by user space on itself.  For legacy reasons, a non-change requires
> + * privilege too.  Only checking CAP_SETPCAP when it is needed keeps LSMs from
> + * seeing (and logging) a capability check for unprivileged changes.
> + */
> +static bool securebits_need_setpcap(unsigned long old, unsigned long new)
> +{
> +	const unsigned long unpriv_and_locks = SECURE_ALL_UNPRIVILEGED |
> +					       SECURE_ALL_UNPRIVILEGED << 1;
> +	const unsigned long changed = old ^ new;
> +

FWIW, I think the code was clearer when the !changed was separate with a
one line comment above it, than rolled into this return.

> +	return !changed || (changed & ~unpriv_and_locks);
> +}
> +
>  /**
>   * cap_task_prctl - Implement process control functions for this security module
>   * @option: The process control function requested
> @@ -1346,28 +1363,9 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			/* cannot change a locked bit */
>  			return -EPERM;
>  
> -		/*
> -		 * Doing anything requires privilege (go read about the
> -		 * "sendmail capabilities bug"), except for unprivileged bits.
> -		 * Indeed, the SECURE_ALL_UNPRIVILEGED bits are not
> -		 * restrictions enforced by the kernel but by user space on
> -		 * itself.
> -		 */
> -		if (cap_capable(current_cred(), current_cred()->user_ns,
> -				CAP_SETPCAP, CAP_OPT_NONE) != 0) {
> -			const unsigned long unpriv_and_locks =
> -				SECURE_ALL_UNPRIVILEGED |
> -				SECURE_ALL_UNPRIVILEGED << 1;
> -			const unsigned long changed = old->securebits ^ arg2;
> -
> -			/* For legacy reason, denies non-change. */
> -			if (!changed)
> -				return -EPERM;
> -
> -			/* Denies privileged changes. */
> -			if (changed & ~unpriv_and_locks)
> -				return -EPERM;
> -		}
> +		if (securebits_need_setpcap(old->securebits, arg2) &&
> +		    !ns_capable(current_user_ns(), CAP_SETPCAP))
> +			return -EPERM;
>  
>  		new = prepare_creds();
>  		if (!new)
> -- 
> 2.56.0
> 
