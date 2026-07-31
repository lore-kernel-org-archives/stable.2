Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF535E1A9
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477793; cv=none; b=ZhOQGHX8Xyl4uW+LllJreN4dQ4Sps6JMPYkPu5RBSxjI8cGc2mdv5za7uBK/Kxq+LpFsomHGblEW6ZpjNIt8Ee7kCUA3jgG12V1yRNM3/7l2d2VTIcIBxVwzm9YF5ZSP6BbbuudPP3u2ht6qAkJyOMVlsARJ1++MMv+talq3IVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477793; c=relaxed/simple;
	bh=3EAMUARaAZZrV7rJiQHLESiPm9D+Mvq5TGvgs/pk4po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOCvNtJyyjn8ujNnb63B0TKIeJ5qVLCqzQijdxkjgsoVmNeXKHeRVl/AjPqO8gOInz8iZ0PE3QPyRSCZSC9DEpv25iUhA42OVIDPZXSm5KFXW3pJ+qSLs3fOoIkKCtHETNIBpBOR7pyWvaH+g8FUzjHVgzQst6Vy68f4YR5HNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ni6HhHhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ni6HhHhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6901F000E9;
	Fri, 31 Jul 2026 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785477791;
	bh=2dmswlRKrYC6X+myQd52OBypTe70oUHawhizLzBJH0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ni6HhHhyF33afRH1mGlr/tndvUvbSLzNzm+kcAzj/nmNjkK6dkhBjWnz+2+wIbGEc
	 kvETr/mxxWiKgj0gpF+WFbTIuGoNNx5m7gSvs1YiN51balLyVpvKxzgc18QNNYZirK
	 YNzjEbpdHnD0LTxD7tVi0qjaZePimMP4M1Oc86tU=
Date: Fri, 31 Jul 2026 08:02:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
Message-ID: <2026073157-demystify-frolic-d787@gregkh>
References: <BN9PR12MB5146DD3D2AA3DFEF175A7948F7C92@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5146DD3D2AA3DFEF175A7948F7C92@BN9PR12MB5146.namprd12.prod.outlook.com>

On Thu, Jul 30, 2026 at 10:19:11PM +0000, Deucher, Alexander wrote:
> AMD General
> 
> Please cherry-pick commit 84c4c36acd5c ("drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1").  The commit had a cc for stable, but it has not landed in the stable trees yet.

It's been queued up and in the -rc releases that went out yesterday, is
the version there somehow incorrect?

And DRM patches do take longer to get into stable releases, due to how
the DRM tree handles stable patches (i.e. the crazy cherry-pick from a
future tree into an older branch), and so it takes me a long time to
unwind that mess every -rc1 release.  But this is a well-known issue...

thanks,

greg k-h
