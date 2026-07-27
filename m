Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247142A783
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187269; cv=none; b=UhS16bXuZXKgrehTt4ggQyga31xR1DVU+DmdvK4moK6yQG8nSVdgRvSkl16LkXhnqkfpWqZgnF6dXK0ba+Ik8vdCx/DNDmB2SrXxhoDmXFBenoUNucVkQl+tA27RdiiMpToj5xxoNeRirKC890HkXSQWdQ+qX829+Ou9auWSLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187269; c=relaxed/simple;
	bh=VldxOMYU2veSSsfpZGK8zSSeUmdrJVqpD1ycf4aUvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE4gQrsD8MHMnYrPZPEa2p9Ni9k1vEvIwAvdGLn9jbavFpLOGYYH7x319hIp66vQblWfwYXylBNWgf5N1JDgBUj7Q2d/OdrfNWj9uTNTjcMHLESaanogH422AGssqVikuj/orYgL/QjK9HrVe6h6ftHwNrSMR7goP2pnKBHiVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9tAkSGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9tAkSGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90AD1F000E9;
	Mon, 27 Jul 2026 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785187267;
	bh=uTEEbtZ6DGdTSOAvGh1uDd1rycV8vXwwhuT3PaPq+kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P9tAkSGO4Ujp8DHWnJhKXif4ZcFH+bsTOXbLKvmJ8Fb0zL8jHi6uH/xqA9Edk/hQ4
	 GfGbvdSHUpQVIid0QavVZNZsR+ORvlL5aNmOrKQfoiXGc43Is0IsyXM0SrVz7Bz8Ws
	 F74KKNyy6HL6pTXQ/SH7XSpfQ89ODhGaJ8Qvm168TIyvWFxMk9FKFhLvdIQeKKkM5F
	 uiX+Pohtko2uLzf3m7jUzrwcPYdIGUV/Cj2uPy3ZsXUh+6K0tKgclUyJ8tAsrcm9iv
	 bJHlCaGYY/d9k86q63z91RdsVeeHE7vTmbQ2uJ7/7LZAzsRTD0CTpDGhd1UI1/tmva
	 dA9gAFIHKBlzg==
Date: Mon, 27 Jul 2026 21:21:06 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 6.18.y 1/4] dm-verity-fec: fix the size of
 dm_verity_fec_io::erasures
Message-ID: <20260727212106.GF1021387@google.com>
References: <2026072004-monitor-wolf-7764@gregkh>
 <20260727210011.1929439-1-sashal@kernel.org>
 <20260727210926.GE1021387@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727210926.GE1021387@google.com>

On Mon, Jul 27, 2026 at 09:09:27PM +0000, Eric Biggers wrote:
> On Mon, Jul 27, 2026 at 05:00:08PM -0400, Sasha Levin wrote:
> > From: Eric Biggers <ebiggers@kernel.org>
> > 
> > [ Upstream commit a7fca324d7d90f7b139d4d32747c83a629fdb446 ]
> > 
> > At most 25 entries in dm_verity_fec_io::erasures are used: the maximum
> > number of FEC roots plus one.  Therefore, set the array size
> > accordingly.  This reduces the size of dm_verity_fec_io by 912 bytes.
> > 
> > Note: a later commit introduces a constant DM_VERITY_FEC_MAX_ROOTS,
> > which allows the size to be more clearly expressed as
> > DM_VERITY_FEC_MAX_ROOTS + 1.  This commit just fixes the size first.
> > 
> > Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Stable-dep-of: 31d6e6c0ba8d ("dm-verity: fix buffer overflow in FEC calculation")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> 1. Missing cover letter.
> 
> 2. I was only sent patches 1-3 of 4.
> 
> 3. Missing Cc to the subsystem mailing list.  Needed since these aren't
>    clean cherry-picks.
> 
> 4. These backports seem to have unnecessary differences from the
>    upstream commits.  DM_VERITY_FEC_MAX_ROOTS in added in the first
>    commit, but upstream it was added in the third one.
> 
> - Eric

I would be glad to do this backport if needed, by the way.  Just I
wasn't aware that "dm-verity: fix buffer overflow in FEC calculation"
was FAILED, since dm-devel wasn't included in Cc on the FAILED email, so
I never received it.

As I've said many times before, failure to Cc the subsystem mailing list
is grounds for a nack, just like any other kernel patch.

- Eric
