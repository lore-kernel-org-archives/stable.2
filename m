Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410186;
	b=j0vtLUtDC1hz7jzJlCEoTEucsCypOvV0/3//V9We4rR9BsEuN1fFDzofYriiod9tyEKe
	 K3kB5spuU8WG47Cblz033R1T5JTpZ0cvxQ9F6E6R4mBWzpC3vwjniDoWMZS6hoNWMIucd
	 rT9VH3Wdfpcvw2NLrotJJfCmQVh2ZBCX4qlX2zesF4+pL0yhOJDGdqttrbbkYgo9/1bBV
	 WWAKF002l6/8lWwRTV2DdzKEirv/ohCPOcQNPwvYsYlaeFEajEJqBXJbTQJvwoMMuj2t+
	 DVZ414FDGt3nEbASFk/Zb8lzc+pkFGJ/9sdXMiSPMQ/9fFMYRhFKByNSNhN07ez6iXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410186;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=txMBHNnDlIN2ZVpqzWAUJtzvCft4A8gUpeRp8AWQt5s=;
	b=NJaIvn2mNILYojm1tjCPdIq+qgy7YmVfk97DYKnm96hkqN8qS34QxkNB/RSn0NcWI9sM
	 VKyuIoKKLkUe7iWsHSx0DoY+OMOq9SCV/nsbOyhru/Na6SxrhiW8lmEhSahCTiPFeocp1
	 ogIBsKuRMfpBgMWRwrNw9FWn/92+tGKHeYWvI4srTtXw0gHYmHJmRK8czcD9sVOnlAF66
	 d50ZEmH66+zsdTqfYC6sBJXwrSDCGzV/Eb/SO6+0ELHQc6MRGX+UT9DWB+6MVxeW2t1se
	 FR96U+v0gztxT3JwUjAXp4M2+90H6HBRYGypnMbLpjcnSFxQvlKm43Fiu3sysDjmAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YjJPFPiv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AD606A31A;
	Mon, 23 Nov 2026 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YjJPFPiv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E61F000C4;
	Mon, 23 Nov 2026 05:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795410185;
	bh=txMBHNnDlIN2ZVpqzWAUJtzvCft4A8gUpeRp8AWQt5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YjJPFPivK5rHjzBuq15FfOdSDx5/k3xRN7KD03ILW0Tj8NH+dDfz6W00o/NUWafvy
	 3jmgxRTNdqibIZ8uR9u1ytI5zF66RpcYOwVVdx9tHxCgH0rc2k6Ko2N3MW0ZB7y6f7
	 hG2xzjNWQQKPfonCi1el7FaCgtgVQf6v+EKkXPWk=
Date: Mon, 23 Nov 2026 06:03:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Iulian Vaideanu <iulian.vaideanu@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Unable to compile 6.12 kernels on SPARC64 since 6.12.105
Message-ID: <2026112346-vagueness-naming-01f0@gregkh>
References: <CAPK=yVMe1Ro=aw_daLCOM9cBATsp6crdgB4wd0ty4vrnxtVKkQ@mail.gmail.com>
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
In-Reply-To: <CAPK=yVMe1Ro=aw_daLCOM9cBATsp6crdgB4wd0ty4vrnxtVKkQ@mail.gmail.com>

On Sun, Nov 22, 2026 at 08:39:18PM +0200, Iulian Vaideanu wrote:
> Hello everyone,
> 
> Ever since 6.12.105 I cannot "make bindeb-pkg" vanilla kernels
> (platform is Debian unstable on bare-metal Netra SPARC T4-1, GCC 16.1
> or 16.2 from Debian ports) - it always ends in the error below in
> fcntl.c, probably brought up by one of the fsnotify-related commits in
> 105.
> 
> Is there anything I can do to work around this?

Can you use 'git bisect' to track down the offending change?

