Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD520486E58;
	Thu, 10 Sep 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043993; cv=none; b=pf4Xe6OtczZgLHAwtkrdEZl/w9Fv65G1XbvMh9QHZLR3uTFg7BDiJPKJELSxVN1hCrqEN55WoOphuto1bGjgKnulsO+b22RkivIRHmNcVgMcBxG/7Npqz7v3yEOcdRbCkBvYVv2dCKO9MUHkIvh4v1MfhFBOlbxAJ/gE2AgITqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043993; c=relaxed/simple;
	bh=8EQh6GLR9b/xDOUa/GlOAJ5gLz08KEsKm2sh86IxPyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DysWBJ7V2R8f85hrLjJ/AgmnRuWHrObn5CIJHiaeFZTYH9vetJi7NPgi9mI0UwILvDohuMNkl/CWOBw3LW+u89Bx5kUodhp5iEgxzPi5apaQ3a/hSfSdF6ZG2rHH73b7q4ONxqDIU5zlZ5Y1co7IYFL2B4nbofN/ctoyC9r62IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WThefb1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WThefb1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B61F000FF;
	Thu, 10 Sep 2026 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789043985;
	bh=wXj6w0O4Lcmbd0vOuhqPUgeXUr6MHiTh/ahvOXJKuZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WThefb1DIXtWYi3LrclPDJfGoTi55MecUDw61eMO1bFcpR4EKnHDMJ7+kNH2lON32
	 U93rZC/WH7bAQI/qjYBFeB+Vyh1gUg/f9C2UDVltWK4k1umnG6T4zcOJye204un+y0
	 Pqs1XyZk05NnGrOLzwrfPoSYVfUoZO8WOjZsDI8M=
Date: Thu, 10 Sep 2026 14:39:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, bleung@chromium.org,
	akuchynski@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array
 index
Message-ID: <2026091023-numeric-husband-1b03@gregkh>
References: <20260904234401.2339633-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904234401.2339633-1-jthies@google.com>

On Fri, Sep 04, 2026 at 11:44:01PM +0000, Jameson Thies wrote:
> The UCSI displayport driver indexes the connector's port altmode array
> with the GET_CURRENT_CAM response after checking it is not 0xff. The
> port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
> returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
> not equal to 0xff, the kernel may crash with an array index OOB error.
> 
> Update the UCSI displayport driver to verify the current cam is less
> than UCSI_MAX_ALTMODES before accessing the port altmode array.
> 
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
> Changes in v2:
>  - removed 0xff alt mode assignement when GET_CURRENT_CAM returns an error.
>  - return -EINVAL when alt mode index above UCSI_MAX_ALTMODES is returned.

Does not apply against 7.3-rc2 :(


