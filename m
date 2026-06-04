Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674742314F
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581511; cv=none; b=uSn1LbP22hKjRY2m9FI4y/d69Mdn5vjfCQt7TFFVHJqLgAD/IDX4tasowKv5jJPPRTGpWId1zWC/m5rZbTdnLrTSiqXGzNXgwABY9/T1et2M1e/3X6a+utEnH1mVkk064nYcSQm2U+Dn7TYqXbYPukfQEBGuA91mKh1uLXwBNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581511; c=relaxed/simple;
	bh=/HnFc0pEhaFqvMzeJDHoKLbIMqArWy4SS7G8JOfL1/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkoCUjBaq9bPGUVjvvg/i85jRZ/7WYKjoOjMBy+najbENcqEqQj49tUfiH8agNrA4I9nQhGLHEUTepnkTVXtg0+5yiAtWQubSrxDm9vs2Vz/x2LNFpZrpFPtCCtVDFbE2arL0+UgECtw8aJHL2JuK+Jdf/0JaXjstFZRYNzCcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7s1vUmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7s1vUmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75EC1F00893;
	Thu,  4 Jun 2026 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581509;
	bh=QfZUEZtJq5xD8D5XzTbvPsemh4hfP+W6EdQUu4ZgGOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y7s1vUmZAQbSoyamcb83NB6jybiIaATQACiF0BJG3Hgsfww2uDB45PkqeMoiy4UlJ
	 o+1p+RBYgp+kpm8iijlSUO0xPF8U7kl1Uf7SacUcAj/x48K52j8JJL2AhyWYCvO3iD
	 P6kfm2NsK74o6DoVOHKVe4LIdm8beXxxOwKTKdXTOxo6+LRv7xCiaZhFqMbu6Mgb4v
	 qrAakBtfL4IZXfoDpgs8YI6SlBUXF2giTXA4rxM6GU6GiEwT9QKZtCURc6GIAGkZBd
	 Uy3hgeJ4a+xWdX6i0xysf6uSn1lqUOPZXH0abNhWK0cKVoRQK2XWNJEzimRuh31kVt
	 GesUdEsAZayKQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV8aZ-0000000BqiU-2mau;
	Thu, 04 Jun 2026 15:58:27 +0200
Date: Thu, 4 Jun 2026 15:58:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.12.y] USB: serial: cypress_m8: fix memory corruption
 with small endpoint
Message-ID: <aiGEgwjWkP05ipwt@hovoldconsulting.com>
References: <2026060436-tubby-pancreas-41ef@gregkh>
 <20260604135502.3494174-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604135502.3494174-1-sashal@kernel.org>

Hi Sasha,

On Thu, Jun 04, 2026 at 09:55:02AM -0400, Sasha Levin wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> [ Upstream commit e1a9d791fd66ab2431b9e6f6f835823809869047 ]
> 
> Make sure that the interrupt-out endpoint max packet size is at least
> eight bytes to avoid user-controlled slab corruption or NULL-pointer
> dereference should a malicious device report a smaller size.
> 
> Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
> Cc: stable@vger.kernel.org	# 2.6.26
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I sent backports of these earlier today:

	https://lore.kernel.org/all/20260604083636.2650249-1-johan@kernel.org/
	https://lore.kernel.org/all/20260604120758.2769085-1-johan@kernel.org/
	https://lore.kernel.org/all/20260604121133.2771807-1-johan@kernel.org/

Johan
