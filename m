Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB73CEBA9;
	Thu,  8 Oct 2026 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446649; cv=none; b=LuplKvT3iRvltjXyUS5rOsTH2KOADqPaMYJt5ZL1Ccwua/WCa28pjcv13KWI2pRpWl78oMlhRqOug5OS/COY4w+pmFp7B91OfGaUQe6TVXhCHeiNsHJJpM2YVL0QcOTY9uqBAdbB+X1m+jgmVsXn4oZxId1un0zUjCBhS+rhyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446649; c=relaxed/simple;
	bh=oytHofmUsmOmYjWHOOvTsgnG1UiObfAk8X2HNycb7pY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAVMGOHSkJcAzmvcKanxLyoxV1MHOk3sr2BMYBbONgKbuif/BPqnuN4ugSCn/9Pqu+x6BB+twHz14bu0lFddwt2u54BeRmxQZQJnCa+DWCnb94e//6xKwxmlgpfKhkY0eE6rYsAwjHcd2KSbh5mCzn+vlttiwHDPFSmwKtUKOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fMr/M945; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fMr/M945"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1791446158;
	bh=oytHofmUsmOmYjWHOOvTsgnG1UiObfAk8X2HNycb7pY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fMr/M945EQAvKNpaZfjiq3lkEcl9RypSRzLM+p+FZvRUD22i3eZ02dTGoZVszwQob
	 n/mjGJ58RK0DddanS5RKROKbgHRExS4FQ6ULlVLJhst5kyQ+a5rwmRrKuiuHBBHsAO
	 ZB7RYcg8i/CqgeRrDNkV3VbCpxoFOWubk6Jwrl3tcWX2Nu5fS3Tyo3zSdJUpxTyoxB
	 FJqvhR27juW7ceJywgAi9/qpmLjIdj/w1lLldz9Rg1Z3IENQZG/nTVqUf65gNoIMUU
	 dAT/ol25HXGhsqdQcGLvWEbdrWNfAFWkOJ/KxHK/ZVJNhEkGSQMJW1BmLWpJ7rQEX+
	 /tfu0qwwrxkqQ==
Received: from fedora-61.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C0ED17E0371;
	Thu, 08 Oct 2026 09:55:57 +0200 (CEST)
Date: Thu, 8 Oct 2026 09:55:11 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Akash Goel
 <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED
 check and erase
Message-ID: <20261008095511.70710ea2@fedora-61.home>
In-Reply-To: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
References: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 20:12:19 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
> xa_erase() without holding the xarray lock across both. If the handle is
> destroyed by another thread in between, and a concurrent GROUP_CREATE
> reuses the freed ID, the first destroy erases and releases the new,
> still-initializing group, leading to a use-after-free in
> panthor_group_create().
> 
> Do the mark check and erase atomically under xa_lock().
> 
> Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")

The fix looks legit, but I wonder how the bug was found. If this was
found with the help of a tool (AI or static code analyzer), this should
be reflected with an `Assisted-by` tag (see [1]).

With the relevant Assisted-by tag, this is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

[1]https://docs.kernel.org/process/coding-assistants.html

> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0493858e55d7..a343c5180e01 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
>  	struct panthor_group_pool *gpool = pfile->groups;
>  	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_scheduler *sched = ptdev->scheduler;
> -	struct panthor_group *group;
> +	struct panthor_group *group = NULL;
>  
> -	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> -		return -EINVAL;
> +	/*
> +	 * Check the mark and erase the entry atomically, so a concurrent
> +	 * destroy + create can't make us erase a group that's still being
> +	 * initialized and happens to reuse the same handle.
> +	 */
> +	xa_lock(&gpool->xa);
> +	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> +		group = __xa_erase(&gpool->xa, group_handle);
> +	xa_unlock(&gpool->xa);
>  
> -	group = xa_erase(&gpool->xa, group_handle);
>  	if (!group)
>  		return -EINVAL;
>  

