Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021928;
	b=WpK0/VNgMmVO+z+ejENWozPO0iImtc1kIU4DGI3Jv+sS83bjhw1BauJ5pmdvlV6CH02s
	 hqitkaiOp6RApmdNlmRlsTADzb0ppYkrkbPmIAq+ATYVh66xk2yTuSoWzfxWRxE5UyqI+
	 pF99cy/38cs/1KAA7aUdQMtIZQPLo74j9ahpm1ptFc71ucgorT57dK3at4tQXC2btFon7
	 Z2F6bm+MLGgdMUizqj7qjFGQELEGcLHmiGZJK4z7wPKjmQGmgj3DgBT3842swo0wTD8B/
	 /Rux4JhoHOKJIeiHooo6xdIbOpDzcQneS4CSN37B/fuvNLNTblRThgsJCLOfRaPvYxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021928;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gFX7NaawqsbNS11cXFXnnBm6IAwlYAmGpbTbUui7AhU=;
	b=wVU57RaBoktagKl1VdLIjDvgyqqLwtKKE6ves4gzAzJy+w0g/YAj9E1IlySYeanMCyR/
	 W9107UIjVZ7ybPGp1t0aOrhJrFeCXSNuaq1/jc4YLNBmkFXHW18EJpfjLvlOyumPgv/Pl
	 zvvLGtjOL8x3qKeWVmz6yeqDOQonGRhvnLzGzxVo1F5NddkhzJpbWfE3UPw2P7B6l99xw
	 aQMAJHPFTvSC7qb5HA4Fe+6WxLqO13G3nUn3kW80bRkSmxYMs3UguJvSFNLRG9jOaME9h
	 akCTHaBahVki1PXA5+q8lM5liiCiIK1xMGFmLvfkBf4AYUtyp6BFROUQN2N7PdIbGxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ7Vxsxc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD6606A31E;
	Mon, 26 Oct 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ7Vxsxc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD92E1F01201;
	Mon, 26 Oct 2026 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021927;
	bh=gFX7NaawqsbNS11cXFXnnBm6IAwlYAmGpbTbUui7AhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PJ7VxsxcFmyNjHFYZr2u90ra8L7rHkS9EPkgd4kX2JXInDzTgmLp4gtccMcpvcJyR
	 a4p+non0wGhtVl9w5OcsGfM+4MeNiXCjsi0x8Qx+CMwPqt4Y95G4eokv4RHozuUpST
	 /VVMkADwdpbzCmr+4688bMp6oKvKlLqtmAOCkq8MkH93eltGzKtsjrYFoM0dUi7qD8
	 HmY8Ys2GjgpYAww6wnxlbMTL7kKqCaOv0rIdz3A/bBsowZSgY1Uqn8OVVHJHO/vRYN
	 PbFXj4mWd+eVlDC9pnC0OgxhC1op0UHOMDLFa6ge/gwZcFj7IpqRF2y5d2tBL63lDP
	 vF/Y0QGrhMO8Q==
Date: Mon, 26 Oct 2026 13:38:42 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
Message-ID: <at9XoYEOWynH5skT@gremlin>
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
 <at8-42OwXk2z6-HB@gremlin>
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
In-Reply-To: <at8-42OwXk2z6-HB@gremlin>

On Mon, Oct 26, 2026 at 01:35:23PM +0000, Lorenzo Stoakes (ARM) wrote:
> /* Returns true if mmap write unlocked. */
> static bool reset_walk_if_mmap_lock_dropped(struct vma_iterator *vmi,
> 		struct mm_struct *mm, unsigned long from_addr,
> 		unsigned int *last_seq)
> {
> 	if (vma_tree_maybe_changed(mm, *last_seq)) {
> 		/* Reset walk and re-speculate. */
> 		vma_iter_set(vmi, from_addr);
> 		return mmap_lock_speculate_try_begin(mm, last_seq);
> 	}
>
> 	return true;
> }

Actually, nicer as:

/* Returns true if mmap write unlocked. */
static bool reset_walk_if_mmap_lock_dropped(struct vma_iterator *vmi,
		struct mm_struct *mm, unsigned long from_addr,
		unsigned int *last_seq)
{
	if (!vma_tree_maybe_changed(mm, *last_seq))
		return true;

	/* Reset walk and re-speculate. */
	vma_iter_set(vmi, from_addr);
	return mmap_lock_speculate_try_begin(mm, last_seq);
}

--
Cheers, Lorenzo
