Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8B1D555;
	Thu, 23 Jul 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765900; cv=none; b=YIiZ2FdiD+azCr6OAGJdtvrtVmpMF+FgKxVSgwTW3pJSFGSXzVi3AXxRGEtkGnV4tpuFTvpPEIJWxhGszMcJU7mjil8grR5iKuO1CxR3xRi7BUtyAKl+dTfVarfKPROUeKEzfUq7rh18vHSkr0g0VpyFXFz7oSa5znZ3s6+C3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765900; c=relaxed/simple;
	bh=G3mP4IvjEKVXHgRz9nZ8U5J1R8Ygc0LSSXsoUe9kTwo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IKyGuWWhM7gdzzF7Q9KLu0ecjsgbsFQ8DASyJKz7o9MeLELJimDyc/wOTT4N4UUWr47If6LMDAsOOgbWtZYuxUwkGJWy45eb/CJmQ35R8+ctxsWzHCGgpfOgeUMgENDPBnWgsZqh3Zi4xDdsgGepyeWftkg7PdEekt040RPKQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jf540uBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jf540uBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159121F000E9;
	Thu, 23 Jul 2026 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784765895;
	bh=ITe5+vZ44fuYRKBuv4OeAZV0DfI2qgHnzzw+1hZjQoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jf540uBg08dRdkeRKoAF6b+7sC7PMgtXZ3nhFERH460/+nZ7d/Dek30It05G+FCY0
	 c6kDa8tapTM5sdOh8sAe8WglwhxTOcis+b3apXjQpLDI8WfAqIl4On5GyhPhoJheRy
	 o20da6dbrJIhrrAsIHgzlzA6fTtQgyhmf0DgU3Lk=
Date: Wed, 22 Jul 2026 17:18:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Kim <james010kim@gmail.com>
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org,
 alex.bou9@gmail.com, dan.carpenter@linaro.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] rapidio: mport_cdev: fix use-after-free in
 dma_req_free()
Message-Id: <20260722171814.8faf85a64f3bb5e91968fb17@linux-foundation.org>
In-Reply-To: <20260615070530.371640-1-james010kim@gmail.com>
References: <20260615070530.371640-1-james010kim@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:05:30 +0900 James Kim <james010kim@gmail.com> wrote:

> dma_req_free() drops the mapping reference under buf_mutex and then
> dereferences req->map again to unlock the mutex.
> 
> If kref_put() drops the last reference, mport_release_mapping() frees
> the mapping, and the subsequent mutex_unlock() dereferences a freed
> object. This is a use-after-free.
> 
> Fix this by caching map and md before kref_put() and using the cached
> md for mutex unlocking.
> 
> Fixes: 4b0986a36 ("rapidio: add mport character device support")

12 characters of hash, please.

> Cc: stable@vger.kernel.org

Is this observable from userspace in any way?

> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -564,9 +564,14 @@ static void dma_req_free(struct kref *ref)
>  	}
>  
>  	if (req->map) {
> -		mutex_lock(&req->map->md->buf_mutex);
> -		kref_put(&req->map->ref, mport_release_mapping);
> -		mutex_unlock(&req->map->md->buf_mutex);
> +		struct rio_mport_mapping *map = req->map;
> +		struct mport_dev *md = map->md;
> +
> +		mutex_lock(&md->buf_mutex);
> +		kref_put(&map->ref, mport_release_mapping);
> +		mutex_unlock(&md->buf_mutex);
> +
> +		req->map = NULL;
>  	}

lgtm, although rio object lifetimes aren't exactly my strength ;)

It might be safer/saner to do the `req->map = NULL' inside the mutex?


And....

You made Sashiko AI review look at this code.  The results aren't pretty:
	https://sashiko.dev/#/patchset/20260615070530.371640-1-james010kim@gmail.com

It claims to have found fourteen pre-existing flaws in there :(


