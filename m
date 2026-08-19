Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719234F483
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164360; cv=none; b=CKikrFzboZSV8lH5AtfntrvEZHehh5ezEiG57g+fTeT/CqP/2J3c0qLa17FHgEcYA6O15zyw9yuLpxmWtQ+Ck9nh/wragCgluwjffyAHMY7Yor0nQVcVDG4P9t0Dj9lcoelkoR39pdu7cMAqPxZLSCPlfe0VbIPV/z5FNuv/9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164360; c=relaxed/simple;
	bh=+xsh9VZScT2apqnlByeqSkTDHL0o6qr6l1v8RjmWur8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6lD4WFr26xz6BdT0aybQ8MUePuoDOF31CNZM5BnEA0PFLrh11ALXK/y9+btx1GNOBEea3TmkbfujZ37MhlxT3F+n2wUYiBiHYDg5+j991rN94zz4qT01pV1kqol6wVcJC4mHyEfNb37gXpc8PdJ7DYipIQPIIuv3Bmhr/X3Mv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPHry27Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPHry27Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D12F1F000E9;
	Wed, 19 Aug 2026 18:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164359;
	bh=XuK/2TYFRr/k7ksufLToFfpbpuUiwIVt1IGE+TxZcFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RPHry27Y8+JRRcJnXao4ZDp90QM6dkopKJFvp57UKfDjTm7QHgBVDYlrOqMfij/c2
	 Y2ONY6lRoY9CJw6fuQzgU5GuMhBY6AJA9MmX7SzU68qMn1ayw73E5sCgyTMLCm5fC5
	 b47XzumAQ/loI9U+o/pwiax9IgsU0xoHb8GtgiaxwBcuADMItbqLOUGyhC7WDI+o8s
	 pvL9EEE3xn6GSngNOQdBnuS0pwq2TKdEMUYOWC9bthMBsh769nZi4oFkmgbiIMaxlE
	 dTHnnwXdhhHq4by+Ctf2vmGmbjXYaYr0vGSaZLo879k8lK7AMA3rAUXkbysCJ7MIlF
	 SPD/pI2PObnSw==
Date: Wed, 19 Aug 2026 20:32:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoX2wcyhpakryWHX@ryzen>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoXLiFruG5s1nKch@kbusch-mbp>

Hello Keith,

On Wed, Aug 19, 2026 at 09:28:08AM -0600, Keith Busch wrote:
> On Mon, Aug 17, 2026 at 05:10:23PM +0200, Niklas Cassel wrote:
> > It seems like Keith did prefer your patch, but as you said, your patch does
> > not avoid a NULL pointer dereference in nvme_auth_free().
> 
> But you're replacing a NULL pointer dereference to a derefence to freed
> memory. That should be fixed too, and I'm just saying checking a pointer
> for NULL before dereferencing it is more clear than checking if a list
> is empty.

I am not following.

The options is freed in two different places, depending on if the
ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
successful or not.

If the ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
successful, the teardown path will be:
core.c:nvme_free_ctrl(), which calls nvme_auth_free() (which will use
the options), nvme_free_ctrl() will then call ctrl->ops->free_ctrl(ctrl)
which will free the options (since the ops->create_ctrl() call was successful,
the ctrl will be on the linked-list).

If the ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl()
fails, the teardown path will be:
core.c:nvme_free_ctrl(), which calls nvme_auth_free() (which will use
the options), nvme_free_ctrl() will then call ctrl->ops->free_ctrl(ctrl)
which will not free the options (since the ops->create_ctrl() call failed,
the ctrl will not be on the linked-list), fabrics.c:nvmf_create_ctrl() will
thus goto out_module_put, which then does a goto out_free_opts, which
calls nvmf_free_options().

In both cases, nvme_auth_free() will access memory that has not yet been
freed. So I don't see us dereferencing freed memory.


Kind regards,
Niklas
