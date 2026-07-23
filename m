Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD73E1682;
	Thu, 23 Jul 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790938; cv=none; b=b/YKHCSCKltXlBzJYXICl1Upo7TPLIQtpqoJFMhHcCi5hctrOgKDaG+7iCQfhZR50GTVw+LXPrWPveZOfvnTLGPg/oL7MHiVqyw7mLQ7vPAZy6tHwRixn1bofUTR5cK9MF/fVEd7C5YIrSotxzd0qP6OhZFZA3irS8s2madvrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790938; c=relaxed/simple;
	bh=f4+ZkgFuufXkzL4t8Q0FyObhg+cxnW6oWlOqq2xYuaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0RWV6oaGTh0ws6DcZm3OiBAY31Ff77HobiX5yq2AB2RRv8caZgoKQAFNYZJoBu7tfSNbF5HehclG4XzAn4s4fUSiWTz50VsX+ZFb83o5gDfWGBElk7l4h+HC7S3St4QBgsXSGF6m6EbqdS6amUee2zl/38MsEMdUWO5k69tOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQjPdzYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQjPdzYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734F11F000E9;
	Thu, 23 Jul 2026 07:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784790928;
	bh=AFz5RfydO1jTo2+swz0NC44J+f8gU4RXievTWy7AGfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQjPdzYggQ4/S8CPSW2juOfhWDmYkDwWqYIdAGRkrNrhRAZfs2qC2nu5jSr4V8GLL
	 89v6dXYsgqtsRFnb6o8fVTsE8s2FU1Z7ATizNl8fpwPf9VUIUZsnnv5zCCxOmDGfxy
	 lj81BytoXdM78ewUQDInIJfdQ14GF8Ir488NVS70=
Date: Thu, 23 Jul 2026 09:15:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: vt: fix memory leak in vc_allocate()
Message-ID: <2026072345-copartner-shrink-9596@gregkh>
References: <20260723070530.117552-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723070530.117552-1-25181214217@stu.xidian.edu.cn>

On Thu, Jul 23, 2026 at 03:05:30PM +0800, Mingyu Wang wrote:
> If the screen buffer allocation fails in vc_allocate(), the error handling
> path jumps to `err_free`. However, this path fails to release the unicode
> screen map attached to `vc->uni_pagedict_loc`.
> 
> During the early stages of vc_allocate(), the unicode screen map is either
> newly allocated via con_set_default_unimap() or shares the default unicode
> map from a previously initialized console (which increments its refcount).
> If the subsequent kzalloc() for the screen buffer fails, the err_free path
> frees the vc structure but leaves the attached uni_pagedict with an
> elevated refcount. This results in a memory leak if that console is later
> deallocated.
> 
> Fix this by calling con_free_unimap(vc) in the err_free path before
> kfree(vc). This safely decrements the refcount and releases the dictionary
> memory if this was the last reference.
> 
> Fixes: 34902b7f2754 ("tty: vt, get rid of weird source code flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

How was this tested?  And how can this ever fail given this happens at
early boot time, right?

thanks,

greg k-h
