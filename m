Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1837F326;
	Tue, 25 Aug 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667040; cv=none; b=nULHdPRRBvWrte+LpdbUemT9VQ/upss7nU317jpDgaZnCb5eicNHoXUG4hd3EeRNgTnnPmK3/UoIAk+Vaywl+TFYCBKJRNAO6Fc4RoDuVTUYSGtClvGv+LujLxsOGgNwZzPi6ci7M7eU8StsT+HpqpoIf8mljNu0wYj+Dj4lvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667040; c=relaxed/simple;
	bh=MfFQtTT/W85KevC15gz/V9mX0Owlq+lpP7+V9ZDGvb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6+jsR2Us0gr3W35isOzsGhbR1fcN6M8GGW4HseSFBjFdUoGP1EWX4zMpWkICz2/aXRvXHf1U41VELsd3rV8vc3JAlD/11EEPddecQOk3niQQLBfaG35DYP18p4j5MyQ3qtPWh12vocQASDMRawnqCC9PDP2XxYlYy+4aJIK4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPkaLXwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPkaLXwb"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4966F1F000E9;
	Tue, 25 Aug 2026 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787667038;
	bh=oZIYoxakdDcpHnw/oiQi6XnASlXnxu1bw6B/PUp3B2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TPkaLXwbayFeS67Ap88S+Myncs5etLL85m0wtCa7ZJg2yxZrOXdsatoW07KR7yEeL
	 1u9JZg77FUiKLjKVuLE2moN/V5h/9wkcRILU8jKFxuEheMw+GTHqGbwK3Js8Q1NDQW
	 XDzRGquTcBNMdTNdwa8EZ9oH3CSHH2fNjAnlpWAOsUAYeAnGFri+GrQVWGEwoAcl2n
	 nbR9jFPY5eRCEC21OMCsZRCie60YcI4gGsk17mlZXP7We2OuQljvKhFxbsCdyC8E6m
	 ltTKfa1g7UMBd3URluY55LK418yBYWM+KcdIrmGsZgX29/2ESFhT2Oylf5OoPbrOIF
	 87JP3C62uXJnA==
Date: Tue, 25 Aug 2026 17:10:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, James.Bottomley@hansenpartnership.com,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] keys: translate request_key_auth pid for the reading
 procfs instance
Message-ID: <ao2iW6FGwphVCu3Q@kernel.org>
References: <20260821095935.1864998-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821095935.1864998-1-maoyixie.tju@gmail.com>

On Fri, Aug 21, 2026 at 05:59:35PM +0800, Maoyi Xie wrote:
> request_key_auth_describe() prints rka->pid into /proc/keys as a raw
> pid_t in the initial pid namespace. A reader can open /proc/keys through
> a mount in another pid namespace. That reader sees a number with no
> meaning there. The number can even name an unrelated task. The line
> needs VIEW on the key. So the reader either shares the key owner's uid
> or possesses the key.
> 
> The fix keeps a struct pid. Commit 4f82f45730c6 ("net ip6 flowlabel:
> Make owner a union of struct pid * and kuid_t") gave
> /proc/net/ip6_flowlabel the same storage. The print goes through
> pid_nr_ns(). It renders against the pid namespace of the procfs instance
> the line is read through. Commit ad08978ab41c ("ipv6/flowlabel: simplify
> pid namespace lookup") moved that print to the same anchor. Output
> through an initial namespace /proc does not change. The line shows 0 for
> a requestor with no number in that namespace.
> 
> Translating at read time was the alternative. find_pid_ns() can resolve
> a recycled number. The line would then name a live task with no
> connection to the key. A stored struct pid gives 0 instead when the
> requestor has no number there.
> 
> Link: https://lore.kernel.org/keyrings/20260809110202.2180410-1-maoyixie.tju@gmail.com/
> Fixes: 78b7280cce23 ("KEYS: Improve /proc/keys")
> Cc: stable@vger.kernel.org # v5.10+
> Assisted-by: Claude:claude-opus-5 codeql
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> 
>  include/keys/request_key_auth-type.h |  2 +-
>  security/keys/request_key_auth.c     | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
> index 01e42ee5f4099..464636278c4f8 100644
> --- a/include/keys/request_key_auth-type.h
> +++ b/include/keys/request_key_auth-type.h
> @@ -22,7 +22,7 @@ struct request_key_auth {
>  	const struct cred	*cred;
>  	void			*callout_info;
>  	size_t			callout_len;
> -	pid_t			pid;
> +	struct pid		*pid;
>  	char			op[8];
>  } __randomize_layout;
>  
> diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
> index 282e09d8fa46c..ed6f55b9cdd93 100644
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -9,6 +9,8 @@
>  
>  #include <linux/sched.h>
>  #include <linux/err.h>
> +#include <linux/pid.h>
> +#include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -73,7 +75,10 @@ static void request_key_auth_describe(const struct key *key,
>  	seq_puts(m, "key:");
>  	seq_puts(m, key->description);
>  	if (key_is_positive(key))
> -		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
> +		seq_printf(m, " pid:%d ci:%zu",
> +			   pid_nr_ns(rka->pid,
> +				     proc_pid_ns(file_inode(m->file)->i_sb)),
> +			   rka->callout_len);
>  }
>  
>  /*
> @@ -113,6 +118,7 @@ static void free_request_key_auth(struct request_key_auth *rka)
>  	if (rka->cred)
>  		put_cred(rka->cred);
>  	kfree(rka->callout_info);
> +	put_pid(rka->pid);
>  	kfree(rka);
>  }
>  
> @@ -226,14 +232,14 @@ struct key *request_key_auth_new(struct key *target, const char *op,
>  
>  		irka = cred->request_key_auth->payload.data[0];
>  		rka->cred = get_cred(irka->cred);
> -		rka->pid = irka->pid;
> +		rka->pid = get_pid(irka->pid);
>  
>  		up_read(&cred->request_key_auth->sem);
>  	}
>  	else {
>  		/* it isn't - use this process as the context */
>  		rka->cred = get_cred(cred);
> -		rka->pid = current->pid;
> +		rka->pid = get_pid(task_pid(current));
>  	}
>  
>  	rka->target_key = key_get(target);
> -- 
> 2.34.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
