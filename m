Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7242048C;
	Mon, 21 Sep 2026 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032304; cv=none; b=kjKhd9NgLfqeXxMkjL4/vVAFQIOX+d93aEWIVMiKeB+uh+wG19q6ry0GjB9V8HyLyifqEEFP7s546tDlzvEQF4w3LYXbxZHekw187UoAufa2r/oF5afgLC/NoyBvYHYmZMzALB44Ce+71P29KYlCDoubCSuXhP9zYoOz//gKwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032304; c=relaxed/simple;
	bh=96F+HosCCV/QhQECXJqPfkaoiYQvQzr0Foq6mOXXfq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkin1ZZBg/FE9Lt5YiQAFJFh5LGBUNNvg3kgy+vcJoDgGn3hH46lI1VVl+Uc4nNCro2DhI82gVGv3NAzMVemEff0Yt4JGDiUKatYK/vb6+x5GalBcyU3WFFxDqrIxRObZHimlxaAG0mAGgEfCGnL9jdp7WhRyNcKS/miWB34LQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcJe/lq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcJe/lq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BA31F000FF;
	Mon, 21 Sep 2026 23:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032303;
	bh=Aygh3cExfS2xIR+EYNHvTANjJUnErDlfiV1qPT7MAQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kcJe/lq0nIr5/SAckf5kN38W5jFTvinz6UIdxG5UtQZkqLnt8MXilbTFY8wnBof5Y
	 t4mA6Z+cblkxEffINUkgxyXKsmRt9qNSX9E8JIe3u2++3gAO/+AmlELNlMctKwgKGE
	 FUxwLqd7coulFZpF2JfbsJdvhi1Up9p4iIXqEOvRnk0rhI8UDi3094pzJidfDKdf6O
	 yBW/7Vm7xeCFvsYClBcofl78tZ4Zt4QsvmwAgO/FNYcXDIkLnpHSmb+MTSzJC2f0Z6
	 SgN7URJ2j7ipVDpe3gIKE6VPjuy2FTCfssDgGUJE4CmV45GGGrKPVdkqeEzJ1waWtN
	 tvSQQqrRQLLuQ==
Date: Mon, 21 Sep 2026 16:11:42 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>, John Stultz <jstultz@google.com>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] pstore: reject persistent RAM zones too small for
 the buffer header
Message-ID: <202609211608.CD32B1FDA@keescook>
References: <20260921202317.70595-1-parri.andrea@gmail.com>
 <20260921202317.70595-3-parri.andrea@gmail.com>
 <202609211431.11176F76@keescook>
 <arGxxfzuU2Fl-c59@andreayoga.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arGxxfzuU2Fl-c59@andreayoga.localdomain>

On Tue, Sep 22, 2026 at 12:38:24AM +0200, Andrea Parri wrote:
> (Dropped anton.vorontsov@linaro.org and john.stultz@linaro.org from Cc,
> both bounced.)

AFAICT, Anton isn't involved any more. But, hey John, you need a .mailmap
entry. :)

> > I wonder if it should return ENOSPC instead, though?
> 
> Fair point: nothing branches on the specific errno, but ENOSPC matches
> the "doesn't fit" convention used elsewhere in ram.c, while EINVAL is
> otherwise reserved for malformed config values.  I'll send a one-line
> patch on top of 1b30df8662ac switching it, unless you'd rather fold it
> in yourself.

I'm happy to fold it in. Thank you!

-Kees

-- 
Kees Cook
