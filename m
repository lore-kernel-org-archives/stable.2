Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703B4499AA;
	Thu,  3 Sep 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467014; cv=none; b=SKYy97mzG8sGSSNQGNX4hNgpMn5RbahpJXROOdfslZ7BfCCSYJJyjM3gnF3yL2vonnbsn2WADVDxQUGBsexg9jRCnBwb76+Rp3EObZ7BZR4HShWoEHDnMfWV/3GuBJnMUt3z377r8sBIovTPWSJ3Co0p9xUG+w0HOHYgwe02xMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467014; c=relaxed/simple;
	bh=j+pvwsdyhzjCX1eedu9mc60L+kRl8XJVqBWhSIgjcok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz/jwLdzNzhCZUdC+YsPWvuiYRHLnQLVmiFEP8aWMRe/kJwj/QRZcQpn0/P44GZTmxGO5RgNX8dm8w+diLsExMDUF5ZzH/xdDIFTo0MwcE7mTgGGS7mNHIXNuqM3k1CM6RtDETft2CrNA9HstfhX5ZJVT65H0knpCX1mJLEgmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipuvEXVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipuvEXVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295051F000E9;
	Thu,  3 Sep 2026 20:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788466996;
	bh=3hcY7l/WLZ3KeGR9R/3IfG9dtd2405bpZ6BhoNotYLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ipuvEXVgU6AwBhz1wpX6a8Xi40JbzJY8+06bwVpgqIGrWFD5zRO9gneYV6BCR6POf
	 URRoYyao+8PGv1+P+kYAsRKIsO16QwOdz9wxwKV8XD8JND69IDvgYvQoOK/hj9ozvq
	 Tk2BWAIOEP/7H5oHgk0o13EzP6NTo+k342C9N/clp1BTRtEsQtEK1wewdOcGt1H4X3
	 +BjIQbDRxAvhsFaroWiT5a0viUlO3mnwYO/obbXGYFTYsMNPLJ1iZ1/DJMvb59qUa7
	 jGI7/UgFfb7J3JiPgCf3/up3dyVkBEIEXQpwlTAT0TwOO4mDEX7zRpaxFXyKzBsna4
	 TD7Q8zOla5o6w==
Date: Thu, 3 Sep 2026 10:23:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Meta kernel team <kernel-team@meta.com>,
	linux-kselftest@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] kernfs: don't lose IN_DELETE_SELF when decoding a
 file handle
Message-ID: <apnXMzZO5wcFIInw@slm.duckdns.org>
References: <20260903040253.670020-1-shakeel.butt@linux.dev>
 <20260903040253.670020-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903040253.670020-2-shakeel.butt@linux.dev>

On Wed, Sep 02, 2026 at 09:02:52PM -0700, Shakeel Butt wrote:
> __kernfs_remove() clears i_nlink on the inode each superblock holds for
> the node, and finds those inodes with ilookup().  A lookup that has
> pinned the node but has not put its new inode in the inode hash yet is
> invisible to that pass:
> 
>   CPU0                                    CPU1
>   open_by_handle_at()
>     kernfs_find_and_get_node_by_id()
>       pins the node, still active
>                                           rmdir()
>                                             marks the subtree removing
>                                             ilookup() finds no inode
>     kernfs_get_inode()
>       hashes an inode with i_nlink 1
...
> Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
