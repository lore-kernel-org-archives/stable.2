Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6523839AA;
	Mon, 20 Jul 2026 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561648; cv=none; b=IJ0viwO/PLfvHu/qZh2r8PJ9P0tAUnluWKtke7gvvJGpHbqAtGnJmuCtLqdRed4ymux03Jors+V+vtiCvo5FWOK200dL22De6DZP1UMslfKCDOYumiWhmMy6vaF+jgqcqeRFdkg5/lDvbqII8OODIchiKVVXAnPb2A4qqIGQU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561648; c=relaxed/simple;
	bh=R7YYkQya2fXroZPaaL15FfLVwdiawg+Vc1Dvfy8mxos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITAy13ZLqdRM5zo/hgY7NEqMdiiNCLYNwKk+Qkxko9S5vFPUbePaQCOjZvX2bib0+ZFrvM0RZn8cDcJ5hdNPDjEoD9KsouGhrpWKMnTWnstyjZezlXjnya5IaaqwLilCBqYWwqv3y7BUp4j1Moi7nO5cTKiYYNuAN0a3h0jRRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+LOaHZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+LOaHZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCDF1F00A3D;
	Mon, 20 Jul 2026 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561646;
	bh=fLXVycmgEZJPqqHtGAfdNJOQIM3j4a/vYkoSH+ybPfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+LOaHZKDhTxNgMaDo+M/kz+mmnSqjwJYNcRec6vJuwyVRgVOvL6tVG+0CzKHePuO
	 qVZaFze9tKOTQAX2PTa8uePlHc9b3BSyto6zJhW8HAMtXwJ+JjgpXlPJ5D97ydcIW4
	 BHLySIYGn7tjxAZaiLz4l1lbXN/tH6V/NqTsUQVgx17+Eu+jDnDVyAcdpdvCJp7ciz
	 iIUuhq45ncEwKr7/vLJYVCCMdPXqxsDWDOMZIF8qoW5CBbk30k0SdFnA1T4GrUQn6B
	 lPMPExoewJ+MjMNWl4VJKJFZWKzYKthHD/psBaL4BtX+vp/svUHex0t27nWnIfjFwp
	 heEyQMb/SOTYQ==
From: SJ Park <sj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: SJ Park <sj@kernel.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	yikai@z1k.dev
Subject: Re: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Date: Mon, 20 Jul 2026 08:33:57 -0700
Message-ID: <20260720153358.83836-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072053-silliness-slacked-8997@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 13:53:10 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Jul 20, 2026 at 07:02:32PM +0800, Liew Rui Yan wrote:
> > Hi Greg,
> > 
> > On Mon, 20 Jul 2026 11:59:03 +0200, Greg KH wrote:
> > 
> > > Why is this a stable-only patch?  Did something go wrong with the
> > > backport of this commit that is not in the upstream version?

You are correct.  The typo was introduced by a mistake during the porting.  The
upstream commit (64a140afa5ed) doesn't have the typo.  This patch fixes the
typo.

> > 
> > Sorry for the confusion!
> > 
> > This is a stable-only patch because this specific function was removed
> > in mainline starting from v6.2.

It is true the function is removed in the mainline.  But that's not the reason
why we need this patch applied to only 6.1.  The reason is that the porting
introduced a bug.

> > 
> > Therefore, this bug only affects v6.1.176 and v6.1.177 stable branches.
> > Mainline does not have this function anymore.
> > 
> >     $ git tag --contains 2f54908fae21
> >     v6.1.176
> >     v6.1.177
> > 
> > Let me know if you want me to resend with this explanation
> > explicitly noted in the commit message.
> 
> Why can't we just take the same commits that are upstream that prevent
> this issue from happening?

We can't do so because the typo is only in the stable kernel.


Thanks,
SJ

[...]
