Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095433DFC88;
	Tue, 22 Sep 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067064; cv=none; b=bnIXm0BAkSWhOZFCjlHJ/A3TVHU3av+OlctbXe4ikTuebjMgJvxYC8Zo0UjGSluvvaJM5hKFXSt7EbumJxM6L5QKB8T1F049dMKaEKcOasehf/Gy2Vb2Z78EacJctZ5i27UVRAraEAWGIp+CCpQFxlhOinRdHHktH/gaK/OPweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067064; c=relaxed/simple;
	bh=YKmihOtXQwvFU/pxVMgWX5/kUgobkhdA4eUMXbVYkwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhzgWmJG1rNXYosE+z+EYf79DA0qKlXSp30tKdqvNt98BuZgHkeVFiZMoP1w1/XVYFdVsy3qlTbukOi/fdrqniTY1QnBP4059J5MU4hI/mHtxEmKCLxD+2XD7WALwVvP0kBgfzdcD5VTsKrX22bOuJWXAhQYVWwulgSm1J09/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hkKX5Lpr; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hkKX5Lpr"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 58A8A14C2D6;
	Tue, 22 Sep 2026 10:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1790067060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KVKfbQp3WPaMeYti+Oijt6p3rzWkk7V7JE0fk+1xfJE=;
	b=hkKX5LprM8quVJouJCxw/+YLlRuNfhQpUTEERILasJio86JNFsXkrUkZwbAbChrAu8F1yn
	X0rylClEd2tW0u83Ds5ZYyAd7BZHU1ZXD+PEzF65wCcBQ98nEXaaPZ3WVjxSq8RkoaZwlR
	IgmNdflmUt/iRYnoeRhaMlZw/jJX/sKLxDv+AF9F+riy4ZNCNJu4STIvIzTsfcDfhhW1+J
	CjgCZtzn4MlZKLTUedh5c6E83oTpnFH/0VwAYevORemWT86phy9R6XyM4SgtRPfbCtgvjZ
	Nz7buYL5EUykmTzKpckwYKYYqOiy3g6AZBJJGkSorP9TpcWiRzXwVefXA+ZsnA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ad68f3e2;
	Tue, 22 Sep 2026 08:50:56 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:50:41 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Grzeschik <mgr@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Hyungjung Joo <jhj140711@gmail.com>
Subject: Re: [PATCH 0/7] usb9pfs: stable fixes
Message-ID: <arJBYTbo3Vyagunu@codewreck.org>
References: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>

Michael Grzeschik wrote on Tue, Sep 22, 2026 at 12:25:53AM +0200:
> This is a breakout series with some additional fixes of the
> first series of fixes I did sent out earlier this year.
> 
> https://lore.kernel.org/all/20260319-9pfixes-v1-0-c977a7433185@pengutronix.de/
> 
> It only addresses the stability of the driver and left out
> the interface rework. Therefor I put all changes into a new
> series beginning as v1.

Thanks!
Also thanks for picking up a patch I had missed earlier.
This didn't apply cleanly but nothing a fuzzy `patch` command couldn't
handle (unfortunately sashiko gives up too easily on the whole
series... but there's nothing controversial in here anyway so I won't
ask you to resend)

I fixed a typo in one of the messages but that aside this looks good to
me, I've picked this up and will send to -next in a bit

-- 
Dominique Martinet | Asmadeus
