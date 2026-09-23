Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B63822B1
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184639; cv=none; b=BfEB9r9/RORlst+5nOj+JrFrtjSbwnW5nd684B97VTYOz8lhkxeRDsoEP5Dhk+ZshAMDuZIaRuNZaaY3btW8tQhUPoih7tE3APJPEI09pBfMiabuPx+NkJhXUTppotk3K74KFQaiVO4NeZ2lxvZI8JaCRIGRuVR7PoHHE2JOOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184639; c=relaxed/simple;
	bh=Y0k9yPl6jE4yyUpA4fZVCyPz1XUGeffcgZ9tot1kKcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNLQQ1eZa0Uxz8zIBcNYc2OAo5GWnhqKVpA1HzUFD/Wfg3+cSlU6umq13j0U2h1zqnGlL6axhSitS1WwjDkhX5EZOvX1ii8CBV8nMSW+fyeUPuTOq+JHqkDMWKLOEGrRX/PwczpVVGk+QPwbKcA9+b0zQ9E8zR8wFItC47u50ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th3WcPO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th3WcPO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2AC1F000FF;
	Wed, 23 Sep 2026 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790184637;
	bh=nMTsJFIim5r1Qt5+GRLsacJwv4xPa7nGjJIm8ZL767A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Th3WcPO/FPHh1z/IPQ1ujJJ2k1zQR/X8fmsXgWI43OJgYkQ3yRZJQ1aBMRaXRmyJX
	 5bx8jQFhrdSWW9v4dz7QyL4MTbJAVwrn5EuGXOxMhnGhbkvPRSKoqampDecwvAxscK
	 6AETFPvEL9yKR1Gs/VIssl+HfTCXF3ADuL44bLswWLevmUVikaiExFyFJ0dLiRrDaN
	 nu6uRCOUHmKRTI4EyUgl8TSdWzhS8FwpLB7OooKkpHXZjDk5eIpmzaq59aBjhi6FYT
	 vydu5mdidB5XcT84y7AtI6tGbVLCL5FM3dZZiBfOuBFP3XuVkIeh4fV/4GwZY3sU8v
	 juAJK6CBqxNeg==
Date: Wed, 23 Sep 2026 19:30:31 +0200
From: Gao Xiang <xiang@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wenwu Hou <hwenwur@gmail.com>, sashal@kernel.org,
	stable@vger.kernel.org, xiang@kernel.org, chao@kernel.org,
	zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
	lihongbo22@huawei.com, guochunhai@vivo.com, yinxin.x@bytedance.com,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH stable] erofs: fix large folio race in
 erofs_fscache_req_complete
Message-ID: <arQMt6-Kuc_TwHeT@MacBookPro.fritz.box>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
	Wenwu Hou <hwenwur@gmail.com>, sashal@kernel.org,
	stable@vger.kernel.org, xiang@kernel.org, chao@kernel.org,
	zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
	lihongbo22@huawei.com, guochunhai@vivo.com, yinxin.x@bytedance.com,
	linux-erofs@lists.ozlabs.org
References: <20260923084823.496741-1-hwenwur@gmail.com>
 <2026092320-process-federal-6533@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026092320-process-federal-6533@gregkh>

Hi Greg,

On Wed, Sep 23, 2026 at 11:30:44AM +0200, Greg KH wrote:
> On Wed, Sep 23, 2026 at 04:48:23PM +0800, Wenwu Hou wrote:
> > This patch is for stable only. Commit c37460cd9b2fc ("erofs: remove fscache
> > backend entirely") upstream removed this code.
> 
> We need an ack/review from the maintainers of this code.  And if it's
> removed in newer kernels, why not do the same thing here too?

I hope the old kernels could still support fscache since some important
enterprise users (e.g. xiaomi) are still using "erofs over fscache" with
old kernels for their containers and they still need some time to
switch to the new way "erofs + fanotify" with newer kernels.

The patch looks good to me, for such simple stability fscache fixes,
I hope the fix could be landed into stable kernels:

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
