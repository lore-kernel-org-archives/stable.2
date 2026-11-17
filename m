Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918904;
	b=gVGVg6hMynZ2OkIBULuGLIHuNQyRO2mUnHTdv0VG9GJF6XUMyiFwG1lgZWL9kdjTVcyk
	 JZE3sG+E+lWZAGmLrOdJ1X8Abv78mqka6rwSX+Uj79pYFeapw/br3xZyKQ3sMYS8TylGr
	 CJ3VYR7o2XbSqDw3cNV4KlcsztA3vcE3KhmNoHcRc+CUjsUxSuAq2fuLbmPnj1wQJC7L5
	 8819d2Js0DP5o6nDDf2O0UbcqdUeZdUNpO3xs/KElqzCMD8O26XlmdZx/nFL8u+DGdcnT
	 PfEuSRj1OiwIeCcxizcr/eLKi8IwhiUWa3Adw4wJ7+CcMzADZGRl8QyVJsAIiACbBJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918904;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DwNMiD1mt8wNJhdYDB5v0+WOkSAHN5ASRcYPM0VYogQ=;
	b=cpKfEcalhMuxjJajph7KoXkbVo6u/lCTidaKRUZlVZT23USu5zk91sdHAG4Zxtq7rz2+
	 +fWnTsirxax3CxATRREOj/JyPGoCVEJ0LNEDvs5JS9cmZtRDa1BHH5TMAyNLNWG6mBT4K
	 EZE57JpHnyu6HhJvJMjSXtfBNQkVQQgApCVtpy4xqVfmYs91nEec7qAFKion3IAY4cF4B
	 tRpAUAKK5UVyJEKRWGyqKql3rtWnQ9j1TISm43SWt2fuD1tu+6Rzoq/W99Pi6F9T6sQug
	 m5E2LPPDQZM7bmWzg5s9H2dZCxcDz3ZV0DNoN3DoSkMrFaDVJRweyvSqjgmt0ybZWzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aV/RjyD3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9BBB8606A31C;
	Tue, 17 Nov 2026 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aV/RjyD3
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A7B3F1F000C4;
	Tue, 17 Nov 2026 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794918904;
	bh=DwNMiD1mt8wNJhdYDB5v0+WOkSAHN5ASRcYPM0VYogQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aV/RjyD3docplm2Ps767K6vpqBSGwAouRbESZWLZ32z2I6dBCiYF2KaCxPUMTbCif
	 0aY6yyEXISOTVV/VZFhCrPoRPjeiE9o/8bIJOPSPQZEQUqo1WX2BPiYLkBt8KSTtMH
	 24Bhv+HAYi9/U2QznKnP00m+qY8BGHTaitzHigUJQRfoqLOwE4UIfLNJaI5kKEYWlW
	 bHwXs+bCl3PW9TUE8KdQq8GeqkDUvfojckr4gvyzOXIWr0oZ090wySSH9zQdOJKEJh
	 UFrclnPOSzV2Heb3NGOR8iKkIZJCsGWzdVA67yh2FS74WBmurdS7arZGPGMUtWQFox
	 tiRtQ/4WhD1pg==
Date: Tue, 17 Nov 2026 14:35:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jaewon Yang <yong010301@gmail.com>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: track the response read position internally, not
 via the file offset
Message-ID: <avxJ9MxZ0PoWbQTc@kernel.org>
References: <alvD5nOP15O5B8Ai@kernel.org>
 <20261117104838.2650999-1-rmustafin@cloudlinux.com>
 <avwzid1Ovl4ACkaQ@kernel.org>
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
In-Reply-To: <avwzid1Ovl4ACkaQ@kernel.org>

On Tue, Nov 17, 2026 at 12:59:25PM +0200, Jarkko Sakkinen wrote:
>  ...

I think this would be more feasible:

        if (current->flags & PF_IO_WORKER)
                return -EIO;

        if ((current->flags & PF_KTHREAD) && current->io_uring)
                return -EIO;

I.e., block io_uring entirely.

Br, Jarkko


