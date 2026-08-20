Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425D37E5D8
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239393; cv=none; b=OT+PfxcEEzbapFFS/1UtacJ1MRmsa80fi+pSnhbHigizXncdEjzZlSOeb9OucuHRL/P8r10N16p438CVIXZQeNwKPp5P9zi99Cc0ZbO8aEw6kw7ORTbedxmeG2NxiaqbZUYCE2Ki5GvQ5zhfeHsKX/A/TxhkS8hBkksKAaymulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239393; c=relaxed/simple;
	bh=47nd9056KOAYmgY4YVIc5QWABpl5hmE58f8hCzWndQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezbrvz1mpn95CactpXuvm0oY2RvbmuYK+CYQuh17mqYMvbKCFOStFTPiK7P50vR/dBdwRflDqdMvZygoilH1d2fYH/ycW59P2HwgOA60KQzmh9sQmXwBQOswWPvcyGkwJcKolRb1lFuU5CLeTn90YGwvvB0ZZ0lvfnhkAFsc3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0qS9Rsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0qS9Rsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136F41F000E9;
	Thu, 20 Aug 2026 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787239392;
	bh=KKd8910UZMHQq/I0uxLglRjAsGiypzz0OgWf9+X5MgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z0qS9RsiQWo4e6YM6pdacr8gtDpCSj0LenjW0DXWzO8upx0AVZ6OYUsOUbFEoJ1Mq
	 J/Q0uMVodCKqxF9tJPrjutyLMVZBUYtP3FGfAJX8t4rLu0dEgOHT7dqsG0BFVqfkwP
	 nAT6YlHeGMrQiULpLJEbLWKPwXbI3wrfvpZP/KWgS3sWwgUqRPIovb6fUzsDA2fUeo
	 MFYjlLp+UARNV3/MOpBqagwx4fnw2jYnoXywZxH3D52nSy3nFfCg2mRMCU52t5nk5I
	 qdINk/YJ47D+IAQ5E0NTQyqeFvWN8CFgo7J4W0dV9q2GP2BiTVRtnYnAiDKI1SMisw
	 nU5jjuoOh0wQg==
Date: Thu, 20 Aug 2026 09:23:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aocb3ogg34WWtRSB@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoX2wcyhpakryWHX@ryzen>

On Wed, Aug 19, 2026 at 08:32:33PM +0200, Niklas Cassel wrote:
> Hello Keith,
> 
> On Wed, Aug 19, 2026 at 09:28:08AM -0600, Keith Busch wrote:
> > On Mon, Aug 17, 2026 at 05:10:23PM +0200, Niklas Cassel wrote:
> > > It seems like Keith did prefer your patch, but as you said, your patch does
> > > not avoid a NULL pointer dereference in nvme_auth_free().
> > 
> > But you're replacing a NULL pointer dereference to a derefence to freed
> > memory. That should be fixed too, and I'm just saying checking a pointer
> > for NULL before dereferencing it is more clear than checking if a list
> > is empty.
> 
> I am not following.
> 
> The options is freed in two different places, depending on if the
> ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
> successful or not.

Oh, not that path. You mentioned previously that ctrl->ops is
dereferenced in other places. I thought this means we can successfully
add the controller, which means the attributes are visible, but then
fail something else later that causes the opts to free. Since the
attribute was visible, something can open it before the device exporting
is torn down, and access it after the opts were freed.
