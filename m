Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032438A720;
	Sun, 13 Sep 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789287685; cv=none; b=D1iykcC7xWna3IxZstZfDWBel9IC/KY1gWiprCHEQjqSOvHSkN2ap137bQshSDZn19VtMOKiiqIeu6VYWYFE6Muvc2kFMqLYDVJHhLALAjU0AgSxVMlcgp/dCd2jQA7hGt5W+krPI1Jmj39y3N49/r4IbuaGmznWBEoW38Lp4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789287685; c=relaxed/simple;
	bh=6opBgASTH4c9wtBE0J12MK/g0Dae2SB+t0VczvLDbm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+d5DVT5aV7HOTjtvMRWss9NDX4BEC4/5BK+EhMsyXdsAsx2wMPgamRHs1mJtW/GU+CIJR77+guL7090Oqu9cofsIBKzqlEVQqxh8AHk16+0cIv6KDGd5o3pOAoaKsRZnf2MfAWVZvP3ISwBeGA1TNGC1ehMvgdqg5e3pUomFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=H1vAsHii; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="H1vAsHii"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 54FBA14C2D6;
	Sun, 13 Sep 2026 10:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789287681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6lLAj4jNnUyYWs4m94XCrV0CGJPFSCyUlXJiWNX7/8=;
	b=H1vAsHiiDRNDfWR8BsHB5iA6BF9W7shrK+ZN0w3hjoguZ0MdprkAKMrZsyYuLwpd1vGxoA
	u31fuuA4Ut9U6TC7jZcex2El7gOMpUFuBzmEiY9rRbVdcdc83Fidq53wUpBOBlj3H10wCr
	lPC8xhsyDuTdELo2FleJmCocWJ1YJr0ppGOYXjrO/F3GDvYrWqtCvSp3PupaFSbm4LkG8x
	DwcEU6SHEM89Rq5O3mmtve+s3wI/I645VNYWv5UsfFAhb3FYuePLH8YiPSQTCSbQvNnraQ
	tAPO6AsuZKDsMOXFhs9cOjMvYauLqshkETY7WTTQtMJdYu1ZB1f5AerOFLXRww==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2a8d3203;
	Sun, 13 Sep 2026 08:21:17 +0000 (UTC)
Date: Sun, 13 Sep 2026 17:21:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: v9fs@lists.linux.dev, Latchesar Ionkov <lucho@ionkov.net>,
	Eric Sandeen <sandeen@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix privport option setting wrong RDMA field
Message-ID: <aqZc7upMWGFKdbxW@codewreck.org>
References: <20260703102254.114446-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703102254.114446-1-sgarzare@redhat.com>

Stefano Garzarella wrote on Fri, Jul 03, 2026 at 12:22:54PM +0200:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> While reviewing a patch adding vsock transport to 9p, I noticed that
> since commit 1f3e4142c0eb ("9p: convert to the new mount API"), the
> Opt_privport case incorrectly sets rdma_opts->port instead of
> rdma_opts->privport, so mounting with the privport option overwrites
> the RDMA port number instead of enabling privileged port usage.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Cc: stable@vger.kernel.org
> Cc: sandeen@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Sorry for the delay/thanks for the patch, picked up for 7.4

-- 
Dominique
