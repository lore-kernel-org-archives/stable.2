Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9B1E0DD8
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715892; cv=none; b=NSfiTWSyA/WOzI3k4D8h1z3wWVxz58hrmPSEon2MjvCFZVJKooV9OT8RPPqnx9+Fr/6wsXwboI2kLBLxlcE76onKvMP4/y2HlNqTCP1v2R0AtTa//NOi/ZN1crjhtwurhJ4hyXtJ2hr7j2Qw8vCzgnW/Q1vUOi8COHgP+43yQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715892; c=relaxed/simple;
	bh=X873Smxgg7yEOz1CRY3fZsTB5+KmEHA2jAUS7ir0A3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M15laz+4YxSWmX/p7+0hokeUe45l71smd6oEa8/XR4e/PbnnrOEwXqK+lNd4UGSX62+hMVJ0rRsVfrr6rq4z4VyEFKCzedL6JlLmP2+hZ8RSESOBhTU1bFDzurdeMl/lQT6E2SeLRozA7rHO6xppwnQjuBkqX/8AphNYPjKdBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYrP9C16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYrP9C16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578DF1F000FF;
	Tue, 29 Sep 2026 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790715889;
	bh=qB3+Bk+b2Sg5RC7EHY2qeNRyoIrNMfCc7nDn4zZz5Fk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=XYrP9C165lAI0fu79Mmw0Tvl1tHDdzfBGzdCP/2o29yrqnH2FOdvOog30rquBstFq
	 g6dQScMOwrv/KTNLWPEI7/w/u8ebGqvgbAHgZpZb2pyqhWUh3r3lkLS2Rc5zUQYFju
	 6C0pM+ypb3k4qFgQX+iVCwXy+o5ACVd67sKlmsHwJF58vZTsLeV7J7DHSi+5VhzfFI
	 T2cv41k4HYG3Gr0rMHET84yPC91iG5Hg5cMJKcsZPpPHC9oUboQnGh6dsIrYOxuDGK
	 FsQz+zR29mnYKEpkwq3nwsB3wTO1odyQymY1ar/5EsjlFh+qOBPVIeFLDrk9JIbypF
	 EX0TDFnnvlyog==
Message-ID: <0533b0b3-160e-447e-b5e1-ff1b3778471b@kernel.org>
Date: Tue, 29 Sep 2026 14:04:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] ipe: fix use-after-free when auditing a newly
 loaded policy
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <2026092955-retrace-denial-b8a2@gregkh>
 <20260929124623.3453618-1-sashal@kernel.org>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <20260929124623.3453618-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/2026 5:46 AM, Sasha Levin wrote:
> From: Fan Wu <wufan@kernel.org>
> 
> [ Upstream commit 9814077275eca36ebf8d510d2f076d235ff9f51a ]
> 
> new_policy() audits the policy after ipe_new_policyfs_node() publishes it
> and drops the new directory's inode lock. A concurrent delete can free
> the policy while ipe_audit_policy_load() is still using it.
> 
> Audit the successful load under that lock.
> 
> Fixes: f44554b5067b ("audit,ipe: add IPE auditing support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> [FW: remove model name according to latest guideline]
> Signed-off-by: Fan Wu <wufan@kernel.org>
> [ adapted new_policy() changes to the older success-only auditing implementation. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  security/ipe/fs.c        | 4 ----
>  security/ipe/policy_fs.c | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
> index 5b6d19fb844a0..d6f90235d6142 100644
> --- a/security/ipe/fs.c
> +++ b/security/ipe/fs.c
> @@ -155,10 +155,6 @@ static ssize_t new_policy(struct file *f, const char __user *data,
>  	}
>  
>  	rc = ipe_new_policyfs_node(p);
> -	if (rc)
> -		goto out;
> -
> -	ipe_audit_policy_load(p);
>  
>  out:
>  	if (rc < 0)
> diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
> index 3bcd8cbd09dff..5eba2bb93276f 100644
> --- a/security/ipe/policy_fs.c
> +++ b/security/ipe/policy_fs.c
> @@ -12,6 +12,7 @@
>  #include "policy.h"
>  #include "eval.h"
>  #include "fs.h"
> +#include "audit.h"
>  
>  #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
>  
> @@ -463,6 +464,9 @@ int ipe_new_policyfs_node(struct ipe_policy *p)
>  	inode_lock(root);
>  	p->policyfs = policyfs;
>  	root->i_private = p;
> +	/* Only audit signed policies from userspace */
> +	if (p->pkcs7)
> +		ipe_audit_policy_load(p);
>  	inode_unlock(root);
>  
>  	return 0;

This looks good to me.

Fan
