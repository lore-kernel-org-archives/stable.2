Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB21E5B68;
	Sat, 15 Aug 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786772281; cv=none; b=iNfuHKxW93saUHfFB/PGkAJxbfnFsr+TJ5+COaT/VjuwCA4EQJ7otlzC3LdBsMyw8uJqzIdj4WlQ4v+8TRwe2IjZibYaGkF1Sld7NVYp/FyBxJ/vYv8GmdTxyKosDWqJean9XJZgwrh9Y+TEVdXggoNgrRysImvqj7p/3W7uOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786772281; c=relaxed/simple;
	bh=znOtKGq9CSBESJoTQuuODs7JUEg/IoIP45OP8FIVOg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW0ojKKLDy4ep2jzXZIzRO1kU/0JuQbEye0MRHBd+/vLiYSV+28cJWiL+V2CV/bOlAOyTY0xPwJgbK5jFfaS1mHGzWrOeMaTum4YPLFFvg2kOEkRo8hM1/O8gpO7Op/nB8626trU/tzuQZOwvsP3RNN5eY6h6DkGz3d42gulsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ljBfxGVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ljBfxGVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCA71F000E9;
	Sat, 15 Aug 2026 05:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786772280;
	bh=bcBhFr9xaSQ8k7Q5Ps8mwB92vV7xY6nRCY1+LlCosoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ljBfxGVBBjDGfWMqN16MozsgkKW/1dTktvkpLTBOJpH+VK6pWbT5XVCa9J1UTdcnt
	 lEkSYwvPmyX0WT08ARQebNOKgsidRsNt7a4iO8CU0WMQEWcEFDMB4SP9ktBpDV1qe/
	 CCWjd7mc2oq42i/bq74el6x797EBjBYtvWOZhIDQ=
Date: Sat, 15 Aug 2026 14:36:24 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Viktor =?iso-8859-1?Q?J=E4gersk=FCpper?= <viktor_jaegerskuepper@freenet.de>
Cc: LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: "Fixes:" tags on commits with Cc: stable
Message-ID: <2026081508-exhale-five-3357@gregkh>
References: <db97cf96-e7c8-437b-9069-0952c62b023a@freenet.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db97cf96-e7c8-437b-9069-0952c62b023a@freenet.de>

On Fri, Aug 14, 2026 at 07:20:57PM +0200, Viktor Jägersküpper wrote:
> Hi,
> 
> regarding a recent fix for AMDGPU which was tagged with Cc: stable, Greg
> wrote that the "Fixes:" tag in that commit was wrong from his point of
> view: It referenced a commit which was not contained in the mainline
> kernel, but only in the drm-next branch (for the next merge window). The
> patch from the referenced commit had been cherry-picked for the mainline
> kernel via the drm-fixes branch, so Greg argued that the "Fixes:" tag
> should have referenced that commit because a reference to a non-mainline
> commit doesn't work with the stable team's tooling, which was confirmed
> by Sasha.
> 
> However, Alex mentioned that some time ago it was determined that the
> "Fixes" tag should reference the original commit (drm-next is upstream
> for drm-fixes I guess) so that you could follow the cherry-pick -x chain.
> 
> As far as I can tell, the documentation doesn't say explicitly what is
> correct. Since this issue might be relevant for more people, I'm asking
> for a clarification so that the issue can be avoided in the future. Most
> likely the documentation should be made clear on this matter.

A Fixes: tag should point to the correct commit that it actually fixes.
When you point to a "future" commit, that just breaks the whole graph
entirely.

Because of this, we know that drm "fixes" are not being applied to
stable kernels properly, which it seems the DRM developers are ok with,
so there's not much more I can say here :(

good luck!

greg k-h
