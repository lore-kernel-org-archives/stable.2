Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919965;
	b=v7kqHsV+xjONblAZRsN4Hq2+JOzbHULMDPrWR/vx7w9Sq4tCCSnHLEbw6Mjw5CaHtCg+
	 t3XF6yVRDNmyE1L67OGzRw1irXQHzXfJHDHcmTOiqnK1rNuNX7yFEMS8kN16J3iv+zC24
	 fQY3Jsak245IvtwbKjTau32sVmMmPKU4XBXf0B9L3VUlyiTh7YfgkId5z90M4VtbGIkum
	 ZayG3DGeuhfhCupTXyTCIUttKWoSR3LghAEQYAgaV8LF1aKmQ3U/VVj/OJF5ScrL/WOau
	 5bqy0LeRIIkoj/1dSh9k8Ml82uDXqAF2M0EQRDkqoMmBTvO9963LrhQL21QlHQVO3Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919965;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=j7R552vhrndcKJ2DIVa+rxbZ26W4ZP4jTvhYdj1Ck8U=;
	b=u/4zkjS66IwfR1Rco1FAwH6GnM1lenUFkJ/tGJ9XsALFIJk1pxxqoRJB1dqSOKMHXZF2
	 YHBg6wqJANGVUSBMuUS1oPZeKPnypBKuRzQymh90h1nJK5O1H2r9hpGB124yDfR/2oLyW
	 GBd8qT1s69Z3tBgO2oiWBIAHPTO1719Rx63RAuxI8+FWOqv/yWd/J/b8IKlt66GvrNi64
	 NqK3a+kKmMvZkH3tBj+Xt/pAufdDN33LsKO7vs1qi0v0fCtiX/rgqKApanx+tTnfoJt3a
	 sBsIMbETV2SDVwITdl0y7AJhR5SwZKcDDJXONErbxhQAAEMhIoT5fxOZ+C9HN770nFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0DPFISB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 34D37606A323;
	Tue, 17 Nov 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0DPFISB
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4FBA21F000C5;
	Tue, 17 Nov 2026 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919964;
	bh=j7R552vhrndcKJ2DIVa+rxbZ26W4ZP4jTvhYdj1Ck8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H0DPFISB9pfAXa9ZwZmYO7w9syYXQsvCH3FiADizmrmYdr5DaoDmUq/TJTJsrIjZE
	 A4BhdujBFesuWynrsPcTNoJQ6ylxFk32r3MRA3Qm2zmHeiGGrAGs87jqvAtRWoqfVD
	 KYTrlzWbrqg7aRuorxkC5CVzUKZJHbuEXIrD8ZNJcvLhPfZFzba5xDmzXG/h0HyICq
	 2OD7Iara0PSS0DrcW5LptRruzNKItQxD2CY/k1bGv+1BqgzzPP+E3RfBuFlVcCzWr/
	 j4YPpQ8ZKeGgC9D6+xswGqIbaLcrWjyqypw4PFHYwp46shKYAcJXhN514YHYMQF0Gv
	 6WvlRh1fI5Beg==
Date: Tue, 17 Nov 2026 14:52:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sinan Turunc <enscrpt@pm.me>
Cc: David Howells <dhowells@redhat.com>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] keys: serialise key instantiation against
 keyctl_chown_key()
Message-ID: <avxOGQOBm5p24nzQ@kernel.org>
References: <20261117123353.1822-1-enscrpt@pm.me>
 <avxNd7uCbLiUAi3A@kernel.org>
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
In-Reply-To: <avxNd7uCbLiUAi3A@kernel.org>

On Tue, Nov 17, 2026 at 02:50:03PM +0200, Jarkko Sakkinen wrote:
> > An AI tool assisted with finding the race, writing the four-line fix and
> > the reproducer, and running the tests. I reviewed the kernel source and the
> > test logs and wrote this commit message myself.
> 
> Irrelevant in the commit message as metaphorically it is now a tool just
> like text editor is a tool.
> 
> I can write a horrific 4chan post with a text editor but if I send it to
> LKML and call it a kernel patch, I don't make claims that it was assisted
> by a text editor and reviewed by me.
> 
> But yeah, I get the commit message better now, thank you.

And on softer side: making a mistake is not a mistake ;-)

This is all about standing behind whatever you submit; not so much about
"performance". I make mistakes all the time.

Br, Jarkko
