Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919086;
	b=hJlWAgZwnhNmTweGUksVyezP7CM0CGqLCmSkzUIZsYp7LjNUjX1UPbCVk0JwVu4RltQA
	 hzbyakM/8TqUfBDHxWfr+VpXY/NMCrDjGendbAvWdt/I+J285e6pV3oF6fwe7h2nxpPLh
	 VZ7BypzcBQHtrysvmL5v3spxusZ/GonHxxrb5UgEbPJ313Fkmn53oVgYcW4YQ+VzdGjua
	 NiOjxqAQOEAALB/l/e2CCQDgrZgtMxyayeKs1EmGiOF7VSCoJEau8aQXTWAo/o/gVE9PB
	 cMPjRjqGiq5TzN2+pafm86JqgAALBJLiLlFu2em17qIZXgb74eC1n5lCCkLmvl6CltQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919086;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O3Eobrwyq5oOakeAIYkUyc+GNwviFP9RCRghw5eCfbo=;
	b=Iw5c6kELl+ACMUHsHSIIPturJsqMqAUuqP9xjPeh6iQjVjuaojX/euDeoFLmfMAU1QHJ
	 yMyvI4I8VhUbxg0yl53zy+Uk2UvGxiFXC+yD2Jf9njCXqIGIgxr8oUnMM88xMlIKLgv7k
	 GV/ldEykTKrL1epNkNa7jeb4FjttLJa7R/xmaACEPZT0h9kTwG3gC5R/Dc9UYbXJK0MI4
	 8boYO46F6Fb9/AL/nBfKA7yOjFuNG+89UClfhxKrXlSlrMaY0sLjgojfhiOYTzNEnZS6X
	 jSugzMm8p6d2UbzXkUkY7i/zuAP9aiSZZme8zQwNQuZd/wPyTgfQbIsf6L0FrwxpaUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7fOeIOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 69551606A31C;
	Tue, 17 Nov 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7fOeIOI
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B754D1F000C4;
	Tue, 17 Nov 2026 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919086;
	bh=O3Eobrwyq5oOakeAIYkUyc+GNwviFP9RCRghw5eCfbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R7fOeIOIRPoY8+oP7zpF/On0647DP/j0922IzQS0EGdYL7zviM3kw2GpZmpgSM4MH
	 xqMr4EnOqxDCoVs7I5IpabgXmVCB593y4wvmknU6ssJc5hMgA8pHdxhnTgyhrU4A+5
	 JFs3VjlHQ9F5qxJoW2/sFS1KlV2d91w9yfbTBx88kZo+4Oi3RFs3zDFkBN5OzjT6D2
	 Vp3WEA+o5Ce3NmNgpGkgg4Ao1lSVo3wDQRhpYtzjmVqWMX+nK62RMuy50NbWYpaQs3
	 Nm++vzc+Q4THgxLWfn5GOSxG7FoEVBaE3yFe1Ez4kgz5c/KBZKxUgo8fI8/sHRkK9V
	 GGLaP1WTFQrkg==
Date: Tue, 17 Nov 2026 14:38:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jaewon Yang <yong010301@gmail.com>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: track the response read position internally, not
 via the file offset
Message-ID: <avxKqn-PlzJyxVdK@kernel.org>
References: <alvD5nOP15O5B8Ai@kernel.org>
 <20261117104838.2650999-1-rmustafin@cloudlinux.com>
 <avwzid1Ovl4ACkaQ@kernel.org>
 <avxJ9MxZ0PoWbQTc@kernel.org>
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
In-Reply-To: <avxJ9MxZ0PoWbQTc@kernel.org>

On Tue, Nov 17, 2026 at 02:35:04PM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 17, 2026 at 12:59:25PM +0200, Jarkko Sakkinen wrote:
> >  ...
> 
> I think this would be more feasible:
> 
>         if (current->flags & PF_IO_WORKER)
>                 return -EIO;
> 
>         if ((current->flags & PF_KTHREAD) && current->io_uring)
>                 return -EIO;
> 
> I.e., block io_uring entirely.

And kselftest can then be extended to address this case (as a
separate patch) making this two-patch patch set.

Short summary would be e.g. (or use your imagination):

"tpm: Do not allow io_uring for /dev/tpm{,rm0}"

Br, Jarkko
