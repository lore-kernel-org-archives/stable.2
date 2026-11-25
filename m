Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626673;
	b=ER0UP53BlDBEiH0O6pUgGSZXEBHNHtBv9ka55KhItFV6XZnbx91JpdHD6r7TkriVUDs+
	 WSQFaLGzVQTDY6zBBSJkJv/cjSa2wNnirXNEvTA8xxBCO07BKLgufxO7lXt6hxc5+jLQo
	 1k37dAy+wSykrdN0pcyTmXgYVxUIWjiqTeGlVreKpgCyOhxtFVQvI2hk5BcrYooqJTyQg
	 Rk4tnbHlK4IDmgwei9OhyHSQluljVx9DcUbRKczjYw12VbQmAlY+HkFnuVeBCkh/8FJ/d
	 2wV/w8SF3QrmvKXD/4/MYscVIUQrB0YQe0UiQZ/5oUzZcaNZsjd9WZ4vCSd/GK8NIVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626673;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R5SZ2u7ZbkMyUYP/ygw5f/CaG43NA7BvjFevu1R+8m4=;
	b=HboZkpF+I1qYFhA7UKVEprGMvRbDxON2x5NfulwBKesZlYhNmDEXsdLV4v7ZVrBc637j
	 yKlkCYueQCaYrPcjWFh7uFI++paugj14VvrA59zoAUQN6lWV6laVOqQVJmk8A0FT00G3S
	 I6DA7Zad4yJLwsNuUPVGipyx4i3HdMov+RzPQpi4dDbkFWnnpwHj71SPFoyMwxBv59sUy
	 YBd3Hc8cSs/JXLgF3CMzXet9mPXjLwUIEsY8PrTQ7FgzhL3bhHjML5PE9+iikICHuJMGF
	 jsCcqZroWy5/m+yc0vzuf1W5bruiTp+gjI1EvCdjsjyBvpLFaVfELqZED6L94AyHBBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="fv/Hwnqu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3C606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fv/Hwnqu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4978C1F0089F;
	Wed, 25 Nov 2026 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795626672;
	bh=R5SZ2u7ZbkMyUYP/ygw5f/CaG43NA7BvjFevu1R+8m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fv/HwnqubW5Yt2GFXXPOQdW8wURylSHVUWo1yM+ZQKJU/oTRqHdr/7Ki5BARgnisL
	 GAfp8QWbSkX4VxeiaLVJlbcAJyl0rEXflDRNvzw63pb2JwjFSqM0BYNRk8N94fJz2i
	 HoH2VtcLEzTDMxU4xbsXjlRIuD5Y5qJNEHEufUXs=
Date: Wed, 25 Nov 2026 18:11:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, cve@kernel.org
Subject: Re: AI tools for CVE backporting/Fixing
Message-ID: <2026112521-paramount-panoramic-2531@gregkh>
References: <CAH+zgeGo9V_DRG_2yRAEw82bk6SMsV_JRxSOM28p7q02oTKE9A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeGo9V_DRG_2yRAEw82bk6SMsV_JRxSOM28p7q02oTKE9A@mail.gmail.com>

On Wed, Nov 25, 2026 at 10:23:33PM +0530, Hardik Gohil wrote:
> Hello All,
> 
> I was wondering if anyone is currently using, or is aware of, AI tools
> that can help with backporting kernel CVE patches or identifying and
> fixing kernel vulnerabilities.
> 
> If you have experience with any such tools or recommendations, please share.

Nothing special is needed, what have you tried that did not work?
