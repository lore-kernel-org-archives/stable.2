Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591084CCDE5;
	Tue,  1 Sep 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266893; cv=none; b=sVWGaQZV3RtdHK6ugRS7sJbqJnX67l9zKXqxHFJ+XrG+SdACM/IAjmyBraH10GgTZmhG6krrx6OKG1BOHew8x1A4TQ8mvYpBI2WfaqNXdvyeqBjc33NrM2E3460njNbyfoYPkcvTHaM4s9axlQykfb32ZFrGqb3BN662kL2+1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266893; c=relaxed/simple;
	bh=9EFCWJHjTAmD0xEm8AAlb2bQ1BRJVQvRl7LW/glFjY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUlEBsAbrU8Ub+NsxM4VwDeXt18o4K1tRAX+6MAZGLMEFZWQqLhXJAEGlvNYjR7n6ci/IaYbmWhpW8REpIxVtlOf2ac+ePT2koDGbnTMx9Fhkfg/obMmLzNIt8IQa7A+7JWDP0W5rUbi25rw4fznPibxNxVZaCNf95+/XBdGluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YKvCQArC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YKvCQArC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uJzmSgIewsVY+wtJ4Y+X41u/Rap55Cy1cNY8gH8L/sY=; b=YKvCQArCKBMOvLtvATkQru6pVr
	YfVLmi0Wmp4vmQdcnbWIaBJxFwiDt+6CTN7N/bF4uKG3v40cR58xM0SudG1lYqzg85opqKpPi4y63
	J983ZXJ9xBTGJiVpD/Ta9FKB3hYQeI1akdfZw5PpOsHVaLt4UmuI45+wq+B6poPyNKlg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1NuF-002M8Q-Qe; Tue, 01 Sep 2026 14:48:03 +0200
Date: Tue, 1 Sep 2026 14:48:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gary Guo <gary@garyguo.net>
Cc: Chunfeng Song <springbreeze@stu.pku.edu.cn>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com,
	kuba@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	hkallweit1@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
Message-ID: <c4740d62-6d51-462a-9d47-0af8477d39e7@lunn.ch>
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
 <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>

> Might be worth mentioning that this is change is only possible since this
> April's bindgen version bump.
> 
> This is a bindgen version that we requested
> https://github.com/rust-lang/rust-bindgen/issues/2674 and available since
> bindgen 0.71.
> 
> This will affect backports.

Probably a FAQ, but what is the policy about toolchain versions for
stable kernels?

       Andrew
