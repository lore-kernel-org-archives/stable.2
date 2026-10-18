Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2636605D;
	Sun, 18 Oct 2026 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297971; cv=none; b=CbS28fJYX7ixP8zVnbEDJKHiZ7NoqYE6LXbE5EPBggoPU58NS8XgreRpjlJ/muf8N5Uu9q3dwhPokO42bEES69sOoDIAh+ojPelKnqt4gvy+OlOhQe1qo0snP6TYi7RynDbOQTp0QzrW9atPJMzs960HbD+Y+27ijW00PDE+J88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297971; c=relaxed/simple;
	bh=bVZDJ5fnDcQ+27ykq2jMm613QMZbUO5vRgFtNXA4QtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRudG3c+QyvUbx6yX9KOxnp21kGAI6UW1176sfPnw2mq0C4afM0nDZ7QK2p6opeit83JTdlUcjBKf/Sy0QVR7Cty8ip6IY7IdI1vluhwKztspYuNS9e4wALFwJdIwkqlAWmRs5195RS82RkBOt0e6DO/Fygq0J6LPanYkJ+Gjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MvJnVpr1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MvJnVpr1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OIxxOWWLimuiEzbQJg1L19JJf1ZWuuAuNcx8eyVaErw=; b=MvJnVpr1G32QNmtdfbsN+XYKaq
	wNqksvDCi4nibGnHCuqEFWfIl7zRkZ165k5iIf3+pekYcN84VrEC7sM+tVa69w9X67oVgxt+wt5LJ
	0bvyHEXfPLpELpcEGSE7IpRJbcjvwAIKRjiQNs/pC7+kmWkX9whxbIXsgAHRwAR4hz0dTP8J9KXzx
	pF69zVWhTFHEMp+oq/FEZNLo+CQg5o+RFItLTSGqIhLbVGvFMGpWMtrNPMZ8LIOqk/pfr6C0EM6jJ
	t1wHmAJpw5Nif7nvL9+ShHKkajTZvNg2sD0ZmPiwJ8CXHmoplQYVMSzEE0eFfgfElf3nYRKcUMpIF
	CM20u+gw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIIZh-00000004bKF-3zhF;
	Sun, 18 Oct 2026 04:32:46 +0000
Date: Sun, 18 Oct 2026 05:32:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 03/10] namespace: don't inherit MNT_UMOUNT in clone_mnt()
Message-ID: <20261018043245.GF3535232@ZenIV>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
 <20260926-work-mount-fixes-2-v1-3-f357abf3d17b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-work-mount-fixes-2-v1-3-f357abf3d17b@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 26, 2026 at 03:44:26PM +0200, Christian Brauner wrote:

> clone_mnt() copies the flags of the source and only masks
> MNT_INTERNAL_FLAGS which doesn't include MNT_UMOUNT. A mount that was
> lazily unmounted but is kept alive by a file descriptor can still be
> copied when its root is an nsfs or pidfs file because may_copy_tree()
> accepts those before checking whether the source is mounted at all:
> 
>   mount --bind /proc/self/ns/net /tmp/x
>   exec 3< /tmp/x
>   umount -l /tmp/x
>   mount --bind /proc/self/fd/3 /tmp/y
> 
> The mount on /tmp/y is attached to the caller's namespace with
> MNT_UMOUNT already set and every copy of it inherits the flag again.
> 
> That causes a number of bugs:

[obviously]

I agree about adding it to MNT_INTERNAL_FLAGS, but I wonder if we should
ever allow to clone MNT_UMOUNT ones in the first place...
