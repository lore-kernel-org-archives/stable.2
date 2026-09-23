Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F04427A04;
	Wed, 23 Sep 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186682; cv=none; b=CkltHC4pTeHrnJ3qrZHr+rWFYHH1wzjRNR77baIZ7YROO/5ZYn51+Qd3Csl5UvLtXBeFhC4wUFRVk21dZiDfqK64sC4gQZs+yGpGu1npqogwkNNm92bNMfnA997ZD/iafnkVSPY9eCZp2ZeBXRULH4Bz4NbfOm1GB+l4FeSChXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186682; c=relaxed/simple;
	bh=CmEaMqUVpIN34vHaJRQphzJm1WqRd5N6tRlUIIgGuIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQg298TcGrf5Uq37SST4vuU/7O8eT8JccPXGKOWqKyOgPaCfa2fhRc+DqkFn8Jg5QXgYtQwjX6y2sqF9C1CmGR+JfR0VGWAGIYIgX6j8+b9Mx2Ja7mTW+kUhb3oo2+pwi6VW/zKSSv+vz5Lps34tnWY6EmaaY7/P62FtYCzHIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHwimU1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHwimU1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CD31F00893;
	Wed, 23 Sep 2026 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790186680;
	bh=FyJ7lQWBiZ0DVtX7VlIuPfDSnL37jlsIFX8jiD1fI54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fHwimU1Q2B7cYo9wYchamxxZIJ/i4B7Ss7u6n1595FTKDPC29xF0Wx+aAlbvS1SE7
	 LAI52VmqRAL7ilPfk+psJMtyaeP5dC0otAtfclHQgfhnPe9dqHUvw/CK7fVUmSRGNN
	 5IbWn/6rs970qKlOYvbx6t93Z1+Lc3+HHkxiWWkiwNh3eiI2jk1kC9JWLhD0k4GSAG
	 N3zdVDi2uLj12K5WRucW38eT6Xrw+2YgIdZEXX3Or0fthexyKr6Np9omt+8D92H53X
	 VWqTVr0Her1PeZH8uZ4tTiX5o+SgdvZXLnlW/hSLtS7kR4hQfAhR8mKh+uRn4OWX2F
	 kVG+e9yUHvOng==
Date: Wed, 23 Sep 2026 20:04:36 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
	Wolfram Sang <wsa@kernel.org>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] i2c: xiic: preserve PEC byte length in SMBus
 block read setup
Message-ID: <arPW6xckt7QMpt7C@zenone.zhora.eu>
References: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
 <20260921-i2c-xiic-v5-1-2fca81e810ea@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-i2c-xiic-v5-1-2fca81e810ea@nexthop.ai>

Hi Abdurraham,

On Mon, Sep 21, 2026 at 11:25:36AM -0700, Abdurrahman Hussain wrote:
> xiic_smbus_block_read_setup() recalculates i2c->rx_msg->len based on the
> length byte returned by the device, but historically clobbered the PEC
> byte expectation the SMBus core had baked into msg->len. That dropped
> the PEC byte from the caller's buffer on the normal and chunked
> receive-fifo branches.

...

> Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")

yes, I think the Fixes tag was needed here.

> Cc: stable@vger.kernel.org
> Acked-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

...

> +			/*
> +			 * Undo the setup-time padding before rx_msg is cleared,
> +			 * so the PEC check sees the right byte.
> +			 */
> +			if (i2c->rx_msg && i2c->smbus_actual_len)
> +				i2c->rx_msg->len = i2c->smbus_actual_len;

I think this restore needs to go also in xiic_recv_atomic.

Andi

> +
>  			/* this is the last part of the message */
>  			i2c->rx_msg = NULL;
