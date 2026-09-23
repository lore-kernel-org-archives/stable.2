Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45743DEDA
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149633; cv=none; b=E6x8AMluDH8ZCiUI/Q9xHiYgMv2rLpAJH3atVx+yk1dR2IaAxbC+H5VHgQBPkSNTEzTCsyXJpsTXbLm8Ih/5XGCeOsSmxwnUmuIWexeubpUvE9VunsuuxzFReaWx381pnkxlFxZbmoVnUyvErglPSueMW0+ChBu2pW27QBQms7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149633; c=relaxed/simple;
	bh=dCbpOl26LU9z0amwhtVS4SJ4Qu1ymw2H4Pcurb6t1Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keFpPVQmWjvmjDfRQyjbVQoR40QDIwXJ8GUpbRINfvC3Qc3fWgC9o2Wi5NsY2aJvJwNvpDuXgmh7BSGY0gOyO8gKNImSRVDymoK2NpDUAzZUC+lwvjralCK5gzhCTDrVvkMGVAX410DrDeQVEZwa4piH0gYHLi7lsjJx8y8JEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xmoZ/ZvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xmoZ/ZvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783801F000FF;
	Wed, 23 Sep 2026 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790149631;
	bh=uBVKB2lre9MFwfa0J+bff5NEiQpv2Dq5HF/eetfA5Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xmoZ/ZvQC57SW+o+IPqyflHHMUJQYdmBrQCCvTf5lVKrMivYfnLyTj+FkrBVUyzyV
	 vLTjLCO1OCtjKunVq2xhKXCKYZMp4sE+ulRJI3uFVpJF+DkE+e0dmcoG/hH7U8eaqf
	 uASZiU/gEbrN+44XPXqhINt8ty/oVJkyLxCIz8gw=
Date: Wed, 23 Sep 2026 09:41:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vadim Nikitushkin <bub4z0r@gmail.com>
Cc: stable@vger.kernel.org, christian.koenig@amd.com,
	thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
	skainsworth@gmail.com
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
Message-ID: <2026092320-reentry-lyricist-330b@gregkh>
References: <2026092253-dimness-unethical-2515@gregkh>
 <20260922153334.136648-1-bub4z0r@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922153334.136648-1-bub4z0r@gmail.com>

On Tue, Sep 22, 2026 at 06:33:34PM +0300, Vadim Nikitushkin wrote:
> commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8 upstream.
> 
> ttm_tt_swapout() returns the number of pages swapped out on success and
> a negative error code on failure; for a populated ttm it never returns
> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU
> walk on swapout failure") moved the bulk_move bookkeeping in
> ttm_bo_swapout_cb() under "if (!ret)", so the
> ttm_resource_del_bulk_move_unevictable() / ttm_resource_move_to_lru_tail()
> pair is now skipped on every successful swapout. The equivalent change
> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink()
> infinite LRU walk on backup failure") tests "lret > 0", which is what
> was intended here as well.
> 
> Before b2ed01e7ad3d the resource was taken off the bulk_move before the
> swapout; since then a swapped-out resource stays inside its BO's
> bulk_move range (and on the manager LRU) although it is unevictable.
> When it is later freed or the BO leaves the bulk_move
> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
> ttm_resource_del_bulk_move() skips it because of its
> !ttm_resource_unevictable() guard, so a range endpoint in pos->first /
> pos->last is left pointing at freed memory. The next
> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that cursor
> is a use-after-free, seen as the resv WARN in ttm_lru_bulk_move_add(),
> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
> dereference in ttm_resource_manager_next() -- minutes to hours after a
> hibernation, or at process exit / reboot following one. Samuel
> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
> dangling cursor; the missing removal at swapout time is the reason it
> dangles.
> 
> Testing the condition for success restores the removal. On an AMD
> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate on
> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
> crashed 5 of 18 hibernation cycles; a function profile of one
> hibernation showed 336 ttm_tt_swapout() calls and zero
> ttm_resource_del_bulk_move_unevictable() calls. With this change the
> removal happens for every swapped-out resource and 12 further cycles
> were clean.
> 
> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure")
> Cc: stable@vger.kernel.org # v7.1+
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> Link: https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Link: https://lore.kernel.org/r/20260909205028.13799-1-bub4z0r@gmail.com
> [ Squashed with commit fcfe64715b425262af1b36f498f9197f3537ceed

Do not squash, send a patch series instead please.

thanks,

greg k-h
