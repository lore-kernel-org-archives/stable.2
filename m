Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE404E73AF;
	Fri, 18 Sep 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731668; cv=none; b=ruP7Jj+DuZorfL/oqTLs3nppe0XgFZt0sbAFJllqv6BXYkG81h00eeMJnwH9rqY0qPg+qLwSBM9DhX9gECvgyq9cpBseH76Yj2nvIkOy7YGLXRYlueWU1DL22R7P58/k9oCtQSSD/wRLICu+tJxrsyKU8Aep6wjG1uVyJ9a6OYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731668; c=relaxed/simple;
	bh=f0TQ9fRKwaKo3/+QIg/236j82WzlkDKwZyW4jLVI83E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPs+mljXw/DQhtz8ESwfAdbUZ/sbQjCuWxu2DJWriIc6lsSdAOhg1/3QHrSH+csw+y9PO0oRl/Rzk2X4uhh5r1sPnuwxrRxojShe2v21ZPgahW+ZdHUAaL0NuF2pInKhpVa9LICRTzBQHQBJ0hw8ME7XhZHDNRFJu8+GwX/EpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3Eb1LF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Eb1LF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C251F000FF;
	Fri, 18 Sep 2026 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731666;
	bh=17R6oFD+3Rnrfxtpg17YJHuJIg2RwIFi6BsTJ4tzPn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3Eb1LF5xIfv5CC9dcWyV9WJplo6pnReNATJjE16JrFRB0gwhEbCZ/IbIS5rQ4aXo
	 8jQ+PaVFOAG1hBJwo59xaYCVy03gkbBrIkPviwv1PCHM9Q9LF15i6UyBOkSWFA7J1P
	 xFYtdls8HG+fX4wlIjFE2Lc1vpba1lLrZoGQ4InvamkGTbMyN5fT1Fyce7Ccd7K8Xk
	 pJeWZfWCg9KM0JU4pzwFfiLHuT2Pjb6AQhJE7GUUyke9pxneZc2/GtJ+R8xnQPsskw
	 8wBzRFBx57hqhPrG4Yu4JIj73nKDbUD93qaRtNgtNpoaAM1qcaUo2LFmzxxJwywjAX
	 fGF7MicbN5tNg==
Date: Fri, 18 Sep 2026 13:41:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, robh@kernel.org, saravanak@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] of: unittest: Fix of_symbols reference leak in
 of_unittest_overlay_high_level()
Message-ID: <20260918-transparent-normal-spider-b2c565@quoll>
References: <20260917125717.2152371-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917125717.2152371-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 12:57:17PM +0000, Wentao Liang wrote:
> of_get_child_by_name() returns a node with an elevated reference count,
> but the function never drops it: neither on the early return for an
> illegal node name, nor on the normal return, nor on the err_unlock
> path. Add the missing of_node_put() calls.
> 
> Fixes: 81d0848fc8d2 ("of: Add unit tests for applying overlays")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Why are you sending 10 separate patches, one by one, not a proper
patchset? It's the same as with Guangshuo Li.

Look:
https://lore.kernel.org/all/?q=f%3AWentao+Liang+%3Cvulab%40iscas.ac.cn%3E

Absolutely nothing is threaded. No way for a subsystem maintainer to for
example drop one comment for entire subsystem. Instead you ask
maintainer to reply TO EACH of the patches.

Best regards,
Krzysztof

