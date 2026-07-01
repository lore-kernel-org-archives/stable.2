Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CA48C3E7;
	Wed,  1 Jul 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912974; cv=none; b=NAd/yLkstgyUyLOH2ma6ehoZfjjnlo9BAi0OOh8BwyXFNRsXB2g5cEIM+VdawvgY7O9iAbmAX+SgHoFYTt2KgXeryxP8aLFqPzijhBzrqWYOub56SaUOxjKdgvLmF7l6HkxztiXaqAghOwKdjknHWrLbvVO2GbNOyYJL3fQV2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912974; c=relaxed/simple;
	bh=hO+/gp7WrezSDDsLfhLEDtXWDsJoutnUWbqG8JbSQdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA3da8gUqlLm6KJPE7Ndcz3Wfugclu6F+Of1byFSGivS+qVJRc/tSIa1NvYA+qCOtRgRbotd3OZKTTKEbQ34KIee+8ZfmMF0FAUi7vyusPhyD1MqCGe1tX4tbp1Mw2e3sIIXU5lOtIyhP5ApuI/uW3Hr5gh9aTItqEd124UPVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GBtb2Zzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GBtb2Zzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EC11F00A3A;
	Wed,  1 Jul 2026 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782912971;
	bh=8lnIxaO5JPG4K++qy5BqYmOKqzqCMVf8bRVcsPo+ElY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GBtb2ZztAoVB1HNhbj4/EnF2ArhDTFuZU06JABaF6ppgDdM4+Z0wy/0fs1rEQqdSY
	 kvq8lXwcjHiIuM1cQ+cU31ZdyD1zuyvJAK6I5gS3bbKHGr2uiAljnDr+iLRLIglNhs
	 ExbHer/oGyJQgTzsF0qTBhRZ5GcxwKSKelonPcII=
Date: Wed, 1 Jul 2026 15:36:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sdj asj <sdjasjbuaa@gmail.com>
Cc: stable@vger.kernel.org, ntfs3@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [stable] Please backport ntfs3: reject direct userspace writes
 to reserved $LX* xattrs
Message-ID: <2026070140-segment-schematic-0a38@gregkh>
References: <CAFTRC0=hdHvug9=JyiZ=XYowdpqp9TAgXbq0YpDOEnzmQUWxzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTRC0=hdHvug9=JyiZ=XYowdpqp9TAgXbq0YpDOEnzmQUWxzQ@mail.gmail.com>

On Wed, Jul 01, 2026 at 08:27:36PM +0800, sdj asj wrote:
> Hello stable team,
> 
> Please consider picking up the following upstream commit for supported
> stable trees where it applies:
> 
> 5b08dccecf825cbf905f348bc6ccb497507e28e2
> ntfs3: reject direct userspace writes to reserved $LX* xattrs
> 
> Reason for stable:
> 
> This fixes a user-visible security issue in ntfs3. Before this change,
> the empty-prefix xattr handler allowed an unprivileged file owner on a
> writable ntfs3 mount to set the reserved $LXUID, $LXGID and $LXMOD
> extended attributes directly. These attributes are later trusted by
> ntfs_get_wsl_perm() during inode reload and used to populate i_uid,
> i_gid and i_mode.
> 
> As a result, an unprivileged user can create a file that becomes
> root-owned and SUID after inode reload. The issue is reproducible
> using normal syscalls only and does not require a malformed filesystem
> image.
> 
> The upstream fix prevents non-privileged users from directly writing
> these reserved $LX* attributes, while keeping internal ntfs3 metadata
> updates working.
> 
> The original issue no longer reproduces with the upstream fix applied.
> 
> Please apply this to supported stable branches that contain the
> vulnerable ntfs3 code.

What branches are that?  I've applied this to 5.15.y and newer, but it
didn't apply to 5.10.y.

thanks,

greg k-h
