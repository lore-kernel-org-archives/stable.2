Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B7485CE6;
	Thu,  1 Oct 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856411; cv=none; b=isK8MD5xz3EqcZD7AxOzp4ItxZTomOnmXkMD+ywi+hDF4GOGSWNcZBUgyTeSXNodOxie/F1shVO9Wr2vR3+AAQ4aJNZW/E0uIIMfntk/CzsJ0NhwQvkQv+XZQRFNCRdQgOOQ6LenNC+mNuQFPJBUJbLD2y2ZxGLte4QXALm7cVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856411; c=relaxed/simple;
	bh=oEZFsCYV6JWgG+iVZztP4Wfg9VRizXirpYQjTWvVezY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6hsOujCO+d4UZ2DdmQvsRgc75FwGtPS/zfQrku1BuN0KvFaGQu0QHl8yl0jXuuh2Yp4u0dKg6H0B1i22NZybngwipy+yAoc8R9IN+Geabg3Ibysf02oq43x280Gwb1E2Up7x0LKeuw1TQNyPAaoKQKZe99+RidaKPIPLX10a+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPe6O7B3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPe6O7B3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225081F000FF;
	Thu,  1 Oct 2026 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790856398;
	bh=oEZFsCYV6JWgG+iVZztP4Wfg9VRizXirpYQjTWvVezY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZPe6O7B3nc2qxfrhCKN6wd5qz1/9G4usbbRWcXLFNHhbKIu5gcLoRBYLI3fP0yyvP
	 X4qXbkR90yOlmkJ65kf1qxfu7qCg9Kqm+0vkUMjeupkEKyO9oZU7KhfCB2++f/p1zc
	 Kstuy3ii8cXijr9TA1RFp4vYUG07MaUCzJP2pXZfCmLoVm3tOY+jM9PMahppmpLNKv
	 dWZ5BxqtqyR/ltGF2nibqNR/xSvexyo9FjZBdJgNrkOZKm3Bllhfw28fyPJFpqe8fF
	 M6rwGIFXypU9ZgqjSaIs/Yt4XgclADqUA1x8fRr1sx28Sst1ti1FDMbR8ExDUd9b77
	 bUDH6Vjo4Cx3Q==
Date: Thu, 1 Oct 2026 14:06:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
Message-ID: <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
 <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
 <CAOQ4uxinQiXn=F8p92rCTzwX5AcBiN0abWW7jE9jKE+zqjb1_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxinQiXn=F8p92rCTzwX5AcBiN0abWW7jE9jKE+zqjb1_g@mail.gmail.com>

> Isn't the inotify problem described in the commit message already solved by
> 669bb5af15d41 ("fs: make sure to call fsnotify_inoderemove() only once when
> inode is dead”) on vfs-7.4.misc?

Indeed, I forgot this patch existed. Good, then we can drop this.
