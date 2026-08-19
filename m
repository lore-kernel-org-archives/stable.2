Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332347728A;
	Wed, 19 Aug 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150773; cv=none; b=sWc94CwvENznUwKOYBY4Qz8G5X/WnGzD9EJJ7xnSJqhZjtTAO+r9saUCX0kUjPbor1k20PHmkhgno8ibpZUqorACVGGb0/BD4jdDFQbF3jf4GunadzuSgr7gnCjOcFXwKAD6x6LpvFDQU9r0FrUnFjchSZL7ISURVZPBEzJvuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150773; c=relaxed/simple;
	bh=kvqovoHR7eSeh+XKn4gVYZDRfUltghh3wryFWVbVrbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV0Yqi6bAeo/pdQdNJkRgmP9KvZnYMNZfTfJYIdSvfGE19lmt+qUxeBrbVDGdYswPf+6a8rjdrBXG4GmRs5nwi2zAjij+dxz2r8mn6tlAYuian8JI20uA/FNAOd+5byyJt0GQc4dBCGchhumx8noSrcgkhzhixVAsvUDiagiHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaAUS+fl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaAUS+fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679BA1F000E9;
	Wed, 19 Aug 2026 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787150769;
	bh=MDQiIWHq7V1ARJ5Q7zqTFzgkwUJOQIVDQgvszjmop6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FaAUS+flxL17U2jQR2lnPhndAGzvGkE/jNGtUX5gg+wUu106Y/sa0noWSTmoooHjO
	 8Ny31M+nQELgfDFN7Q5xqFpWLzQE9s8sph5rfUID9RMfhRI0fyVjLZRzC+7AD2oj2g
	 OfDCEitoAPmZwnx6qkwAY4zNz6aYy4dCpx5HJ9bzyq0O7MBG1StY3s7qlWfPmjp+AA
	 g4wFfQcU5FHxCz/GCtFAhnY/u088o5ZXaF50rFSVwPx3huvfoiBiOxZJJJs93XqWWG
	 KJNtMPQGijXZGlCd5WziRA3jnn7tMNxNEho8IwVqx0ppVbCrjRvm4IdytmX8ho88BK
	 AC6r+Fteic3dA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwhYM-00000001E1h-458W;
	Wed, 19 Aug 2026 16:46:06 +0200
Date: Wed, 19 Aug 2026 16:46:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: vub300: fix Use-After-Free of inactivity_timer on
 disconnect and probe failure
Message-ID: <aoXBrnq9BEsQgTJ_@hovoldconsulting.com>
References: <20260818210322.53266-1-meatuni001@gmail.com>
 <aoW7iR8Rp4hUCtHq@hovoldconsulting.com>
 <CADqcGB=ZbfAkM_90ty7=_QD3eqJd8f7urXKvTnagdv09U9RRAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqcGB=ZbfAkM_90ty7=_QD3eqJd8f7urXKvTnagdv09U9RRAA@mail.gmail.com>

[ Please avoid top-posting when replying on the lists. ]

On Wed, Aug 19, 2026 at 07:33:25PM +0500, Muhammad Bilal wrote:

> You're right, thank you for catching this. I traced through
> vub300_probe() and vub300_inactivity_timer_expired() again: the
> kref_get() taken right before add_timer() is exactly the extra
> reference the timer holds, and the timer callback releases it itself
> and stops rearming once vub300->interface is NULL. So the UAF I
> described can't happen with the code as it stands.
> 
> I should also be upfront that this was flagged by Sashiko, and I did
> not verify the reference counting closely enough myself before sending
> it.

Remember to mention when issues were found (or fixed) by tools like
Sashiko or LLMs generally in the commit message of any future patches as
its useful information for reviewers and maintainers (and as is also
documented as being required).

Johan
