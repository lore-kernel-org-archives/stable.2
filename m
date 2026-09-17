Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DF4BD108
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640976; cv=none; b=KmsFWDjw3+k/3/brpBKRj82LgmAhSLfphk7aUHIQhYvxDjHUAcFDw8a2OhCMpfOQXb+AZjFjNNLPPXTyGFzAe5NkN4RIovzoNkqoBmD5FM4GnYH+n7D83bqYf54dP5xvaeoxaNiMdJyt12zYBLN9eBBFpgN4QrmMlznX5j2wRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640976; c=relaxed/simple;
	bh=TWVFx88Eh0h5Xcyoqs+KUYllEsba9hbLe2mXfozijgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af2iv/TIl/2e6Z3yX5eOONgGGByCLEIJLAxc//AeWJAIHkGAFKSaYl6aGE9CWK7gZSz5Od1iB0uVUunQdznlnJECaxqJxhJ2S2qKaGXlSstk0aL6jUVKYgDdYDqIkAkCLL+JzNaVh0R+0fSQSzGI+9FC6i2bfG9NHiq94sEXmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQL2moQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQL2moQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ECA1F000FF;
	Thu, 17 Sep 2026 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789640968;
	bh=bFWVl4yeK6ajWxLvdBcJeBfzLaE4ycyDFezEC648q3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rQL2moQMAXmQ3hcRdQF2WzChvdBUStgxkOli3VDDwhTZVe9S+/LiaT448vvs4IKTJ
	 2MeFmtPJ1IU++5tlzypM4haMUwYS/5HTKPMijId9+/2+tO38y/RPOJZ6LOSgjuJ5hv
	 033fza4gTh7SONo/9uk/D1lgpSwBQPvYlUtzKl+M=
Date: Thu, 17 Sep 2026 11:15:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH 6.18.y 1/2] drm/ttm: Tidy usage of local variables a
 little bit
Message-ID: <2026091753-convene-spousal-e670@gregkh>
References: <aqW40lwCEnQ8NuPH@quatroqueijos.cascardo.eti.br>
 <daily-reply-0005-re-ttm-bo-resource-uaf-6-18@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daily-reply-0005-re-ttm-bo-resource-uaf-6-18@kernel.org>

On Mon, Sep 14, 2026 at 10:03:21PM -0400, Sasha Levin wrote:
> > You need to apply 91d7e9df4259 ("drm/ttm: Fix bo resource use-after-free")
> > too, otherwise this introduces a UAF.
> 
> Agreed, and thanks for catching it. 91d7e9df4259 ("drm/ttm: Fix bo resource
> use-after-free") fixes c06da4b3573a ("drm/ttm: Tidy usage of local variables a
> little bit"), which is not in 6.18.y yet, so it has nothing to apply against
> today. I will take it together with the series rather than on its own, so the
> two land in the same release.

I've done this now, thanks.

greg k-h
