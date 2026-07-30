Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD412489873;
	Thu, 30 Jul 2026 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391000; cv=none; b=tlhkc3Q/m/g1JdcEqjprLeoGo5tXCHZg2fk/b9DqXPWXpek+U2uOr6DBWBZpbniUVn/z2o7NLZuuXTPSacWe4BbHxSDwp3REOta0TNftZrX23eXBwiri2eawL12mCyyaJioIUTsP5+xdIwu8Typ8rnF4xgMrj2tSuEqDmPABD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391000; c=relaxed/simple;
	bh=6rpYbumtMMnVXrB4EhijlWqzhn5iqyx0+LGV6qfFdP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBuVzZGC9P1B4rMeil/doBsg6dj0rApLyH5COZp+yKdIdlPrZVM8g7/obXbSs2WAA/4Pnv3nrsqiuu9nocz4jVepBiGX9UVg9Lb16yPGEAnNIurEVeQNiE2X43DaZztDtEx2d5NP+AYaH5nPnAox0HbVo5pNp3Q0LxfexclZIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2oOTcjeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2oOTcjeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9623B1F00A3A;
	Thu, 30 Jul 2026 05:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785390998;
	bh=UyKL5M0dMM5vyBKfscrfqtuVorlI43FZMaFIvbE4VSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2oOTcjeM5gAbd5cw5RB4cAdU12TbMA0h5ydtm1eZnjqLDZUlFKat2DjZ6zX9OTavn
	 zLDxBoROoOxwu3xA8CTC09RUJTG6tRpLhNyRTa0tGKjCfDEABHScZCkBOhK6p8M+1L
	 Uy92elQoaHnl4KEmj76ctA0QrItF+PguXrOk2p+Q=
Date: Thu, 30 Jul 2026 07:56:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: WenTao Liang <vulab@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, carl.vanderlip@oss.qualcomm.com,
	ogabbay@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] accel/qaic: fix GEM object refcount leak in
 qaic_attach_slice_bo_ioctl
Message-ID: <2026073052-salary-art-af19@gregkh>
References: <20260628115119.44215-1-vulab@iscas.ac.cn>
 <19305f3f-7567-48d3-a0b2-6597fdc3c314@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19305f3f-7567-48d3-a0b2-6597fdc3c314@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 03:19:38PM -0600, Jeff Hugo wrote:
> On 6/28/2026 5:51 AM, WenTao Liang wrote:
> > drm_gem_object_lookup() acquires a GEM object reference on success. All
> > error paths correctly release it via put_bo, but the success path returns
> > without calling drm_gem_object_put(obj). Since list_add_tail does not
> > transfer ownership, the GEM object reference is permanently leaked on
> > each successful call.
> 
> NACK.
> 
> put() is specifically not called in the success case as data structures
> which depend on the BO are not released until detach_slice_bo(), which
> happens to be where the corresponding put() is.  It is also not possible to
> successfully call attach_slice() more than once without a corresponding
> detach_slice_bo().
> 
> The get() and put() operations for the concerned paths are currently
> balanced, but this patch will actually introduce an unbalanced state (extra
> put() operations).
> 
> As far as the impact of not having this patch per the commit text (memory
> leak) I'm aware of many memory stress tests, yet I recall no reports of
> memory leaks from attach_slice().  You will need to provide proof, from
> actual testing, that this is an issue.
> 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> 
> This tag seems wrong, as there was nothing I can find on V1 in Lore which
> indicates this tag is appropriate.

Yes, I did not suggest any of these, and the author should have
withdrawn all submissions as they were obviously not correct.

