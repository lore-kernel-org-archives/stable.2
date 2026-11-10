Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323305;
	b=lfo2Q+HG3QkhUhYyDJqTHg6WRgw86YYyhDTIzf8KzGnh5Rlv+LdbOhO7i44vfvCCmZxy
	 Lvze39yJMcvUFzzgNLdHMPu3Y27ztmCasDr5ADd+vZexRxyxfuVIg5Vgz11DzAQwNnLiM
	 mE+Kv3Im8Xu0KMn9H2gBqPABJtJ3xFadHvB7eHc8st+kWFTm1eWvWPKpVQd1g7GHSmwu6
	 8Pc6ituv7vbC2flLsn9jKjNSlpO5rS3B1VRMHaOgbt8ziDF6xBaSIitpxJ0c4qFje4CyR
	 hGUbRrsa0+Io29KuLXLrDqIL4eh/5FdvtYN7suU5Fa5UlpqMB9maJpq3FBbxr2I673w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323305;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=oNJivVoyu72FnMBjVSxRk6wu/Gu0bKPbs3QhyQ9DWfg=;
	b=BStRR1mFblwqh03zGoPPtTD0O8/LPhNdwZ97bZ81mPxoKoiijF/v953Ll8+ep7LVSYr4
	 GoJIh9bYoVzUrWnH4Jytk3HjdWhGn06vjLi7A02X2TflLbFbKY6gHZud3ODpe8jlpze6k
	 qzJTjYBfjCSBbjTrg69HsIl2zbDU6ufvX5xfOXcUglI/YJTi7YGXkZh+qA50e8SWtwRD5
	 2tpjRk5z8Oxty5Cjxq3bj9/Bn3NG8gKAYIq/plxs4NlfYNZ9p4HbM+x4ucrQK3ejJu4bi
	 OldDHABWoSU4zo/6IyBz04A1XN/8KL+LCYTonRNACV0s4xatHnTylsVAfrmEpj555LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=HWgPx+fv;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC160A261D;
	Tue, 10 Nov 2026 15:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CC160A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=HWgPx+fv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794323295; bh=Qz+w3E0S12c7+sHbC0P9fK29CvHuxPv8rvnaxSZT5zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWgPx+fvvfFib1CNriCjnI36iA/b84xCbNNyxfpT6hVh0vsn7OiCK/EyxreyK9QNk
	 /dmakTsTu2cjWkjKMxpAEIUFwSb+AnMvvICwuJFLB0GMHjo0p+SUFvFG/StwDjQGN7
	 19Pg/xCnAJY2pzId5Ag5DIBsTvWBDmENz8aGFaqp/4PBQ6rnexOEfHbiaGc58cQu19
	 M2Y76k/E3ckIgp9uiyuMeps+EzlTU0TPZPGR10GLTvFmD7lOYD8ZFMWVxpfw6cZPpr
	 M/RFMXy7uZcOEGWwrqormEB9GuIBA5mhlviGToUfBki47triargnIqDNAjD5B21CL7
	 Yy+tDYdTZJbEA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 9907E800; Tue, 10 Nov 2026 09:08:15 -0600 (CST)
Date: Tue, 10 Nov 2026 09:08:15 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Josef Bacik <josef@toxicpanda.com>, Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
Message-ID: <avMzX2WfnUK+wBxj@hallyn.com>
References: <20261110144205.2404088-1-mic@digikod.net>
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
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>

On Tue, Nov 10, 2026 at 03:42:04PM +0100, Mickaël Salaün wrote:
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
> 
> Use security_capable() against the parent namespace instead: the
> creator's credentials still belong to it at this point, so commoncap
> returns the same result, and only LSM denials are added.
> 
> Do not audit this check: creating a user namespace does not use
> CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
> that later fails has no LSM audit record.
> 
> Checking CAP_SETFCAP when the map is written would not work: the
> writer's credentials then belong to the new namespace, where commoncap
> grants the creator all capabilities.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

I wonder whether parent_could_setfcap should be renamed
creator_could_setfcap, as now, years later, the name makes me think "the
user namespace's parent ns could do it".

> Cc: stable@vger.kernel.org
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> This is independent from Josef Bacik's series, which reworks this code
> to close other ways around the CAP_SETFCAP rule:
> https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com
> 
> That series still computes the creator's CAP_SETFCAP with cap_capable()
> and cap_raised() in cap_setfcap_level(), so it would need the same
> change.
> ---
>  include/linux/user_namespace.h | 5 +++--
>  kernel/user_namespace.c        | 8 +++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 91232053775d..370961fde45f 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -86,8 +86,9 @@ struct user_namespace {
>  	kgid_t			group;
>  	struct ns_common	ns;
>  	unsigned long		flags;
> -	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
> -	 * in its effective capability set at the child ns creation time. */
> +	/* parent_could_setfcap: true if the creator of this ns could use
> +	 * CAP_SETFCAP in the parent ns at the child ns creation time.
> +	 */
>  	bool			parent_could_setfcap;
>  
>  #ifdef CONFIG_KEYS
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index cd748e1cbace..57b7f10be74e 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -128,7 +128,13 @@ int create_user_ns(struct cred *new)
>  	if (!ns)
>  		goto fail_dec;
>  
> -	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
> +	/*
> +	 * verify_root_map() relies on this once the creator only has
> +	 * capabilities in the new namespace.  Let LSMs deny it, but do not
> +	 * audit: the creator may never map uid 0.
> +	 */
> +	ns->parent_could_setfcap =
> +		!security_capable(new, parent_ns, CAP_SETFCAP, CAP_OPT_NOAUDIT);
>  
>  	ret = ns_common_init(ns);
>  	if (ret)
> -- 
> 2.56.0
