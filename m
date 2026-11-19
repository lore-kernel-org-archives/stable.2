Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111990;
	b=gDTxIbdttU43m8bDNbQDTDqrwYZTuo/ANORNkfWHXz5jwXpAdQlUTNDc+99HWjoHQAWw
	 tbkCnWuSEn1uITz0xm45mVELrGzZvlvBC5TLsrgdfK3A5CWn4JEIzjnYu5DUVEgGoA//X
	 NBgAy/9EuNx2CtVgVARGvtRGLODmDR2XVVDhd2c31k0692R8uo6q0W3XBubOzxNIlyjy4
	 v/n1oAmKwAJR/QvYdjRGcHgUDzHuFisbi6Cu+b6cTxVgDgPOon87GxzXit+Hii5izJ+Rn
	 4UW/2Yoxn4b2t45WYV1B7XUWIas7nI+x8ixLzBFCmZkEKyRk4SCwr5EeCvkZFfm+RuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111990;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0l/dnfvyZFTVql8BQiJjDn2o2opPyCGqJl6f9F2PdGc=;
	b=Sc6h1W2lT1hn1dPsbDBnkbfiSiivRl4/juuolTOWj1l0rdrFHTpESEbDorR6IJ199gW9
	 sAMK/oqawXqBCaSsL3YvKtMPreL1Tr8ujybCvynBsQKf/sngcauZ/I489czcXZikro4Or
	 VYdPsxg5mjjTn+ipPVOMdmSSuJLXXSrJNK4sagPr9zhvOoOARuXdWyBnLwBfAtXL412Yw
	 GhxdKOsFUh2sowesnuWUYRrGVyuXg1coqNjHjVZMkeniXoC5/W+8cn6lBJRdSy8y/PFyC
	 qsUiIv4VBbL1Zkhk8DDwCTf5MswrLY4e+YSH/bTTZ8o2g/4HdcX8WJrPIsOZ6LYstzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtkpVazg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6536C606A334;
	Thu, 19 Nov 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtkpVazg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 786AE1F000C7;
	Thu, 19 Nov 2026 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795111990;
	bh=0l/dnfvyZFTVql8BQiJjDn2o2opPyCGqJl6f9F2PdGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VtkpVazgWigofCaDJAFw+b79+w4RU/sKuL0rJAU/+defwVk0qy1nk2W4YdFgzuQkz
	 9F/NNCykO8CRpSXUT0FnAkOcYNw0oMKXOqEU6jT48YdNTR8Buub5xX8z2zIEcXoDio
	 atUr+xcF4+VrqaJjZDuQ8almzqRm3nxLwaELawl9ZUbEUYjA7D3WNBnoCgGG0KLxwU
	 rb/KlSSza10DyBvuzEP8IIrEBsHE4641F5paXsogQbmIThjMzvepU9El7TAtYlkQ6E
	 dNSDO5/4Codi1mdcd6ylDZNn3umvP+MqKHfC4T9d+zRF7aAfZ6tq0H8JrfeE0CyaYK
	 Tkl25WMh84hog==
Date: Thu, 19 Nov 2026 20:13:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jaewon Yang <yong010301@gmail.com>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: track the response read position internally, not
 via the file offset
Message-ID: <av88MkHFBHTD8Rqe@kernel.org>
References: <alvD5nOP15O5B8Ai@kernel.org>
 <20261117104838.2650999-1-rmustafin@cloudlinux.com>
 <avwzid1Ovl4ACkaQ@kernel.org>
 <avxJ9MxZ0PoWbQTc@kernel.org>
 <avxKqn-PlzJyxVdK@kernel.org>
 <CAG6=z5sxUo1x6mpotkNZXk=nQYvD2AyMLSDhzD3B3kqxJ1=iaw@mail.gmail.com>
 <av23L5HBpy2gbm3m@kernel.org>
 <CAG6=z5u+qK3JQ4OwqS8e9ncfcasYPWLQhU9Y4iBFi1pEf0QFuQ@mail.gmail.com>
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
In-Reply-To: <CAG6=z5u+qK3JQ4OwqS8e9ncfcasYPWLQhU9Y4iBFi1pEf0QFuQ@mail.gmail.com>

On Fri, Nov 20, 2026 at 12:49:37AM +0700, Rustam Mustafin wrote:
> On Wed, Nov 18, 2026 at 9:33 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > I wrote that out of my memory. I did not expect to be exactly out.
> >
> > Block uring.
> 
> Hi Jarkko,
> 
> I looked at three ways to do it:
> 
> 1. ->read_iter and ->write_iter that just return -EINVAL.
> 
>    Simple, but readv() and single-iovec writev() stop working.

So. What would be the use case for this?

> 
> 2. ->read_iter and ->write_iter that keep readv()/writev() working
>    and fail with:
> 
>        if (!is_sync_kiocb(iocb) ||
>            (iocb->ki_flags & IOCB_NOWAIT) ||
>            (current->flags & PF_IO_WORKER))
>                return -EINVAL;
> 
>    The first check catches normal io_uring reads/writes and AIO. The
>    other two are for IORING_OP_READ_MULTISHOT, which uses a sync kiocb.

So given how TPM works (reserved for only one process) I tend to prefer
this. But -EIO should be used. It's as IO failure as it gets.

> 
> 3. A new per-request flag set by io_uring and checked by TPM.
> 
>    Needs io_uring/VFS changes and is harder to backport.
> 
> With 2 and 3, vfs_iter_read() callers such as Coda (which forwards
> reads to a file passed in by its userspace daemon) can reach
> tpm_common_read() with their own offset. Today these calls fail,
> because the TPM files have no ->read_iter.

2 is a bug fix, enabling is a feature. I guess this is the confusion.

> 
> I have 2 implemented and tested. It would also need a check of *off
> in tpm_common_read(), because of the above.
> 
> Which one do you prefer?
> 
> Br,
> Rustam


/Jarkko
