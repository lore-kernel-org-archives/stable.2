Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B539B97E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978324; cv=none; b=BelD/LTOgLqFV96U3pd1XwmZQCy48/HyPihOkHarPkgAm/M4GzfKYWB68ME8pM10jiF8RI1wXS/qiIby3Gu6KDFXaUuzYexGzqoDxrHPSICGWJbdzrYNS48Bw/dz3LcMwUe8artV0JA7xhbr56TRQcVf3i2K/5f/wjCJFd8Cac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978324; c=relaxed/simple;
	bh=WQygSbcyx2B7tQLKe69QRsO6hKdxbRbuwyqNBvNytC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2wvaaJZvNqS5BSCC8ywmwXItvvnDuliBs2kX6BEU5TdwxHks0w0RtLY4oiQv77yMVFEuP5vgF0a9vkrm3Uo0fO0ByxuiulSo7GXO/K5AKS3YmRweZEcJRe96O5fBRNIVfAW6nzG6Vuv2qoQypRz51UtYhpfkaWLisjyXwYc0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=X/A9A1CJ; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="X/A9A1CJ"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hg8G41lq0z3Cb;
	Wed,  9 Sep 2026 20:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788977948;
	bh=e/ySDyuMb+hF+2ti4wzPq97smHKiwAsXDqy32m4tBCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/A9A1CJA5BHM9o/ewLgtyXaDEyKyRBgcF8NxeCB3GlhOtDXO5QEmzeQd5WNaGKX3
	 X3JWGsQxJbGVi7iym0p0XJ3MYD459bSRwvxz99MadqVvWjsMSZu/EY+oK4qkPcKYqo
	 fNq3UgRemjXPGp6Y/iYLqJ7wNPIiL/i+i+cnVKxw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hg8G347Trz5LH;
	Wed,  9 Sep 2026 20:19:07 +0200 (CEST)
Date: Wed, 9 Sep 2026 20:18:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH 6.1.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <20260909.Co6Phai8aKoh@digikod.net>
References: <20260904185816.343078-2-gnoack3000@gmail.com>
 <2026-09-05-daily-reply-0020-landlock-whiteout-6-1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026-09-05-daily-reply-0020-landlock-whiteout-6-1@kernel.org>
X-Infomaniak-Routing: alpha

On Sun, Sep 06, 2026 at 09:32:50AM -0400, Sasha Levin wrote:
> > Whiteout objects are used in the upper layer of an OverlayFS to
> > indicate that the file with this name does not exist in the unified
> > view, even if it is present in one of the lower layer file systems.
> >
> > For the userspace implementations of OverlayFS (fuse-overlayfs),
> > whiteout objects can be created from userspace as well:
> 
> Queued for 6.1, thanks. Note: 6.1 is missing 49c9e09d9610 ("landlock: Fix
> handling of disconnected directories"), one of the two prerequisites this
> commit's own message names -- 6.12 and 6.6 already carry it. The whiteout
> check itself is still correct and worth having, but if a disconnected/
> bind-mounted directory is involved on 6.1 specifically the enforcement may
> not be reliable yet. Could you send 49c9e09d9610 as a follow-up for 6.1.y?

Hi Sasha,

These dependencies are indeed required to properly apply the patch, and
they are in fact fixes too (that failed to apply without changes).  I'm
preparing a few backported patches (including these dependencies) that
I'll send this week.

 Mickaël
