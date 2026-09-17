Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC64562BD;
	Thu, 17 Sep 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635745; cv=none; b=DjKOXzb3vZToqYEysCMc/dSjRZCybqsfp5FSTStbM2PDoKExPni8RONcnz2ma94tmTnX2RrYmAjS5mHKE1n286NPanHFKyHR3Mf6VE8btPvNKgw0cacgYW1sqTIdaZWaak7LC5O2fwbm+ot3VRmd/G3bKqkv3+qK1ImfTLzYyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635745; c=relaxed/simple;
	bh=Wno923ToPl+/+0rAHe74cFf0MJ/yvzIIqEp3PBOuFaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKoL5Os9wkorJl4FVe0MoZ67j2zLoET5KfqgOXuZFb6yDr1OtWBKRe3qVdq8iHl+SNcBL1XwlZcJUpCw6ksU/TxA7h3zH8T0kM8Re+sklCwEiYxUercF65H0ENRTE1+QNPaV1QV9DkazpNHS1KJ4lYO9M7qly054fAEh1cytA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d9ynEs1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9ynEs1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8CD1F000FF;
	Thu, 17 Sep 2026 09:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789635743;
	bh=igoj2VRxY/FZ0/3e7a/DLo4Ki5liE+w2ZU6XaBdXBhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d9ynEs1FG6gFN6/poYpiCX5yPVC/DD4Fvd2sePv0gucxJe9v4O23gO7hioLaU82fY
	 QbP8W6reE+//GYIFICWsXt9lJBZImuYpyXBOYhwvotWGE6eZoNoBjGC9/Bzp6vO1/u
	 +MLJ7eWNwLGT7NpdYPzGWye35HZehIBrK+YIzZi8=
Date: Thu, 17 Sep 2026 10:00:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: stable@vger.kernel.org, andi.shyti@kernel.org, dhowells@redhat.com,
	wsa@kernel.org, rostedt@goodmis.org, khali@linux-fr.org,
	linux-i2c@vger.kernel.org, bestswngs@gmail.com
Subject: Re: [STABLE REQUEST] i2c: smbus: reject oversized block transfers in
 the common path
Message-ID: <2026091720-negotiate-hardwood-0998@gregkh>
References: <q6ksjepw4p2f3mboxtgavsxkdaee2f4xivqhczsasorea633ur@sk3xiccv7sxz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q6ksjepw4p2f3mboxtgavsxkdaee2f4xivqhczsasorea633ur@sk3xiccv7sxz>

On Wed, Sep 16, 2026 at 04:46:54PM -0700, Xiang Mei wrote:
> Hi stable team,
> 
> Could you please consider backporting upstream commit
> 
> 3051cd060fa496df42954291fa2306ed2eab4ecc
> ("i2c: smbus: reject oversized block transfers in the common path")
> 
> for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.
> 
> It prevents oversized user-controlled SMBus block lengths from reaching
> tracepoint memcpy operations and native driver callbacks, fixing
> out-of-bounds accesses.
> 
> The fix has been in mainline since May 7 but is still absent from the
> longterm branches.
> 
> The upstream commit applies cleanly to all of these branches.

Now queued up, thanks.

greg k-h
