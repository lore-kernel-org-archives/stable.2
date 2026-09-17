Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39043585989
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658794; cv=none; b=GyePScNTKCgn2+YBgFV7wna5q9FoPn+yGJMUcCbT8kG4xyS7XodjYIfEHsFloFnEPHy2z2CPYFwmf7Sl+qVxcz7ffhZSO2hpQ1XfBE/5TkAFAMBxRnVryfGSG/vh0GkU9JMX2xhmQBLexajCYc8iJiGQIF2Njc9e4Lm0b3uOXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658794; c=relaxed/simple;
	bh=8vSDyXsRqFYLZGVnfOgjW+dinaOqPIwiEvm3saSDmgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm4O7hJ+EKEu4GJ40RHIUeccltuQawASdZY0z+wiKkbcwN8dAGJ70oCiCVjyxX6tgL0AWurBF7A9l1cjN2UE88WxDG4DbQul05jCaLRXcAHBhmzRf9w0Fj5v0W03dKvrOTXjOZQHOqAXVFHiBv/Sk0iGDW4S/GcQzPPsy5MmsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Skd/Y6xh; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Skd/Y6xh"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hm02n74lfzwwk;
	Thu, 17 Sep 2026 17:26:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789658769;
	bh=JIj+TgoqfLBmJGMneZe2NlkkMytyOCZlD1ivagDWJ80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Skd/Y6xhmZ4gd1Kvbi6PP71Ql2L1JraE4wnoQOUULbMz4CQMv5Y6gpcruWy8lxoBB
	 B0kO4pft+Ylj39iuTEGHKEHya8SI4XTdSOAIZzYrCgoZ9Dlv/gW8SVEQqodb534wvP
	 ulN9Kllyy+43KNcmEgnlSHSJjiFilLbPlA8PyDHw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hm02n297qz4kR;
	Thu, 17 Sep 2026 17:26:09 +0200 (CEST)
Date: Thu, 17 Sep 2026 17:26:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Norbert Szetei <norbert@doyensec.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Subject: Re: [PATCH 6.1.y] landlock: Fix use-after-free of the source's
 parent directory
Message-ID: <20260917.Oogh7maesohi@digikod.net>
References: <2026091645-slogan-afterglow-e44a@gregkh>
 <20260917124925.227690-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917124925.227690-1-sashal@kernel.org>
X-Infomaniak-Routing: alpha

On Thu, Sep 17, 2026 at 08:49:25AM -0400, Sasha Levin wrote:
> From: Norbert Szetei <norbert@doyensec.com>
> 
> [ Upstream commit 2c6dc792538260a8087ac5b22c31b3b8e47c85d6 ]
> 
> current_check_refer_path() reads old_dentry->d_parent without holding a
> reference nor a lock on it, and then dereferences it in
> collect_domain_accesses() and in the audit record.
> 
> A reference on a child does not pin its parent: __d_move() reassigns
> dentry->d_parent and drops the reference the child held on its former
> parent.  hook_path_rename() is not affected because the rename path
> calls lock_rename() before the hook, so the source cannot be reparented
> under it.  hook_path_link() has no such protection: filename_linkat()
> holds a reference on the source dentry but neither locks nor references
> its parent, so a concurrent rename(2) can reparent the source while
> security_path_link() runs, and the former parent can then be removed and
> freed while the hook walks it.
> 
> A process can trigger this after entering a Landlock domain that handles
> at least one filesystem access right.  The process can then race a
> linkat(2) loop against rename(2) and rmdir(2):
> 
>   BUG: KASAN: slab-use-after-free in collect_domain_accesses+0x278/0x290
>   Read of size 4 at addr ffff888160bd53f4 by task llrepro2/549
>    collect_domain_accesses+0x278/0x290
>    current_check_refer_path+0x952/0x1120
>    security_path_link+0x1be/0x320
>    filename_linkat+0x342/0x6d0
>    __x64_sys_linkat+0xfa/0x150
>   Freed by task 562:
>    kmem_cache_free+0x139/0x4c0
>    i_callback+0x4b/0x80
>    rcu_core+0x7dc/0x10a0
> 
> Take a reference on the dentry selected as the source parent, using
> dget() for the common-mount-root case and dget_parent() otherwise.
> Release it after the hierarchy walk and synchronous audit logging.
> 
> Cc: stable@vger.kernel.org
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> Tested-by: Günther Noack <gnoack3000@gmail.com>
> Link: https://patch.msgid.link/E9CDD9E6-E960-4DE2-B1AC-5667D52ABB3E@doyensec.com
> [mic: Clarify the caller, reachability, and reference handling]
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> [ consolidated dput(old_parent) into one release after the hierarchy walks because the older branch lacks audit logging. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

Thanks!

> ---
>  security/landlock/fs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index dd7f0fd921cf6..8bd48f1446e33 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -893,17 +893,19 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	/*
>  	 * old_dentry may be the root of the common mount point and
>  	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
> -	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
> -	 * we keep a reference to old_dentry.
> +	 * OPEN_TREE_CLONE).  Pin the dentry used as old_parent in either case.
> +	 * Otherwise, dget_parent() safely fetches and pins the current parent
> +	 * against a concurrent rename(2).
>  	 */
> -	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
> -						      old_dentry->d_parent;
> +	old_parent = (old_dentry == mnt_dir.dentry) ? dget(old_dentry) :
> +						      dget_parent(old_dentry);
>  
>  	/* new_dir->dentry is equal to new_dentry->d_parent */
>  	allow_parent1 = collect_domain_accesses(dom, mnt_dir.dentry, old_parent,
>  						&layer_masks_parent1);
>  	allow_parent2 = collect_domain_accesses(
>  		dom, mnt_dir.dentry, new_dir->dentry, &layer_masks_parent2);
> +	dput(old_parent);
>  
>  	if (allow_parent1 && allow_parent2)
>  		return 0;
> -- 
> 2.53.0
> 
