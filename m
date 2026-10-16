Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB84D9549
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163875; cv=none; b=UmbsJOg9Ap53S53kLZxKhGG0JHlcPaNO43CP4EdZ4G1XkPISth1G4suOJJY2/mGrWuDY8KMxzV3H4CIPzs6eAiUXY4NNg7L69H3Wyq+1OuKTfj3YHcWlw2DUycg9BmVGhSaR/1x6QyxNrpGnhGqC7GNokxjFlVGiH3NOSsw4d34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163875; c=relaxed/simple;
	bh=PMOuEOnfRx5yLf8TRyl6EYO5TmT4wQO/UftAE1bIfo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg0QJs4lRSSxzfYfSUGUtB0laVH4Oq2jEXueHjC7lysprGKAj73pOdH+dtVpfsJjM09GiW7DpBOnPke/kUqy0ktx5BuejVFSclWuNBrScCgV7OIlF6gKE3ge9VXlApLDMzlvX57grIcUazTo96VPa2lZG9ZE92kAp/jy8TfyDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BHMycvXv; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BHMycvXv"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5pHr6s2hzhbr;
	Fri, 16 Oct 2026 17:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1792163352;
	bh=3256253bsOKrTJpRBMkqybzV1hV3WOY+3tdxzY2s2kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHMycvXv6aUjPsvZr0y6bpmg2aEKWZtt8xT3ZEBXHfDo6F28BBNIxPIsM7D7eMNjC
	 aLXXFP+Vqp8FgXlTnfW5e6gmEnshu8v5wjCBrk3lM8hvAZ+4mKQVj3TOJLYya9gY2Z
	 M2C1n/IRryT7PMIAIhvFGGvAqkDQz6XzTZbV/xKE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j5pHr21ZnzVJL;
	Fri, 16 Oct 2026 17:09:12 +0200 (CEST)
Date: Fri, 16 Oct 2026 17:09:10 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Fix superblock use-after-free in
 release_inode()
Message-ID: <20261016.ohj7ze0Eerun@digikod.net>
References: <20261006105847.2541190-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006105847.2541190-1-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Tue, Oct 06, 2026 at 12:58:47PM +0200, Günther Noack wrote:
> Without this fix, release_inode() (task 1) can race with a umount operation in
> hook_sb_delete() (task 2).  The order of operations in which the race occurs is:
> 
> * task 2: hook_sb_delete() arrives at the end of the function, waiting for
>   landlock_superblock(sb)->inode_refs to become zero.
> * task 1: release_inode(): does atomic_long_dec_and_test(), decrementing
>   inode_refs to zero.
> * task 2: gets woken up through some other means, sees that inode_refs is
>   zero and returns.  The caller is the unmount operation and proceeds to
>   release the superblock.
> * task 1: Runs wake_up_var(&landlock_superblock(sb)->inode_refs),
>   *dereferencing the sb_security on the freed-up superblock*.
> 
> Notably, wake_up_var() does not dereference the pointer passed to it, and
> only uses it to determine an overapproximated set of tasks to wake up. So
> while it's potentially possible for an attacker to provide a different
> value for that pointer, this only results in the wrong set of tasks getting
> woken up, and in this scenario, no further tasks are actually waiting.
> 
> Nevertheless, KASAN detects it as a slab-use-after-free read on
> sb->s_security:
> 
>   BUG: KASAN: slab-use-after-free in release_inode+0x196/0x290
>   Read of size 8 at addr ffff888103b6c0a8 by task repro/217
>    release_inode+0x196/0x290
>    landlock_put_object+0x71/0x90
>    landlock_free_rules+0x38/0xc0
>    landlock_put_ruleset+0x47/0x130
>    fop_ruleset_release+0x33/0x40
>    __fput+0x305/0x780
>   Freed by task 54:
>    kfree+0x11c/0x390
>    process_scheduled_works+0x766/0xe50
>    worker_thread+0x7bc/0xb20
> 
> The fix is to determine &landlock_superblock(inode->i_sb)->inode_refs only once
> earlier in release_inode(), and later use that precalculated address for the
> wake_up_var() call, without having to dereference through the superblock.
> 
> Cc: stable@vger.kernel.org
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Assisted-by: LLM
> Signed-off-by: Günther Noack <gnoack@google.com>

Thanks! It's in my next branch.

> ---
>  security/landlock/fs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index cab43892ec2f..0959e9f487e6 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -61,7 +61,7 @@ static void release_inode(struct landlock_object *const object)
>  	__releases(object->lock)
>  {
>  	struct inode *const inode = object->underobj;
> -	struct super_block *sb;
> +	atomic_long_t *inode_refs;
>  
>  	if (!inode) {
>  		spin_unlock(&object->lock);
> @@ -77,8 +77,8 @@ static void release_inode(struct landlock_object *const object)
>  	 * Makes sure that if the filesystem is concurrently unmounted,
>  	 * hook_sb_delete() will wait for us to finish iput().
>  	 */
> -	sb = inode->i_sb;
> -	atomic_long_inc(&landlock_superblock(sb)->inode_refs);
> +	inode_refs = &landlock_superblock(inode->i_sb)->inode_refs;
> +	atomic_long_inc(inode_refs);
>  	spin_unlock(&object->lock);
>  	/*
>  	 * Because object->underobj was not NULL, hook_sb_delete() and
> @@ -92,8 +92,8 @@ static void release_inode(struct landlock_object *const object)
>  	 */
>  
>  	iput(inode);
> -	if (atomic_long_dec_and_test(&landlock_superblock(sb)->inode_refs))
> -		wake_up_var(&landlock_superblock(sb)->inode_refs);
> +	if (atomic_long_dec_and_test(inode_refs))
> +		wake_up_var(inode_refs);
>  }
>  
>  static const struct landlock_object_underops landlock_fs_underops = {
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
> 
