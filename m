Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F94D7D3B;
	Sun, 18 Oct 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340949; cv=none; b=h00/QR6Z0MP+/QjquFx9TO3KQDmp9gHexpCUZdNlR7OPT32ZG/UTNkpFVWWe6C46TE6F2YY5Kk01f53jBYDCdqpLMX8/gIsN+plB28QhOEawYBnRjRePy9Gw4gKNSDCL66GEJ8T1tKn0G9P2OTho37fIlpVIaZ6w7M8xi52YT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340949; c=relaxed/simple;
	bh=4wtDG5oL2h1GXrkA6ErwjyP5E3kYpMXe4YKgQfKuXQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm0cParyItzYPBJfaPhfKUeyqD0Hn139Bdkw6c1skec8LEV6WWwrzMCRs9fClr7QAUC1cwOyvCvP64NFcDz4GebOEP2nXWlw8UOhAeov1fL7F9qYMyGmcTE0+ugMh5fY5/BpZMMt+56xSxUxg1ZoIVhbB1d3AuHTrQ0TUVIxxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTy4hGLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTy4hGLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252711F000C4;
	Sun, 18 Oct 2026 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792340947;
	bh=4wtDG5oL2h1GXrkA6ErwjyP5E3kYpMXe4YKgQfKuXQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GTy4hGLsTpE1mrOqelaPdHCtIOZ5HUrHvBsZBVfMndAmkxrsg3sHlu9ZHiVxBODE/
	 g4qXm9J4Lqa55N/8j1QA7Gcou2sI9qWUxYb+vvh1S0I1jYOp1FQ6BWOgIGlStIhsbK
	 zCyofsb/hR9B4cgwsaZxCsJOjvTrSGb7g1Xa5ay4kSmxi+VYNke5cQ41dOcB7Jc5zY
	 lpbF9FV+9j1vOoG2e/wXkHAk26gJ89CYSxzIC5KWwNAD/oIHH5Xh7mVgzVz5AuoF8c
	 GsAYzLoAnxyp2kwk05d7AbW7JjwpG9h/DHWSxVum3KYeaoV9LUKliTrwgstaR15r58
	 Pr05IEbyDrMuQ==
Date: Sun, 18 Oct 2026 18:29:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 03/10] namespace: don't inherit MNT_UMOUNT in clone_mnt()
Message-ID: <20261018-wippen-flott-volltreffer-5af06f93acfc@brauner>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
 <20260926-work-mount-fixes-2-v1-3-f357abf3d17b@kernel.org>
 <20261018043245.GF3535232@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018043245.GF3535232@ZenIV>

On Sun, Oct 18, 2026 at 05:32:45AM +0100, Al Viro wrote:
> I agree about adding it to MNT_INTERNAL_FLAGS, but I wonder if we should
> ever allow to clone MNT_UMOUNT ones in the first place...

The next patch refuses to copy an unmounted tree recursively. Copying
just the root is kept on purpose...

Becaues a bind mount of an nsfs or pidfs file that got lazily unmounted
but is still pinned by an fd can be recreated from that fd and I'd
rather not break that...

With the flag not inherited anymore the copy is just a regular mount
with a reference on the old root. So I don't think refusing it buys us
anything.
