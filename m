Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012402;
	b=fnAHfy0CfKeCd753RZV9dzSxBUxmG0fB5jDVAoYB2U5quND+O5cmPXrwW7HBdLH0OWvZ
	 r5lSAt20Uko6WIU6fhKQf3x9UML/45i3jSqGdHwmStEfWBsY6ZGmVvWDAo7g/xWZr4kSq
	 PLkyTwTcnAp5MZwK8SQiMxuTqxU3A5Fkf5FF4oEcWUvz2XCe382qPHdGex7+5wGtRrmtq
	 qs1jpdW9xLP2SPhM1tp8LsVgHiz5FWgW5GM7+8gNontFNLQPMfkFnzVEKKP62sXmkYQYa
	 VXPFLXExMHLBesGNIgpEuM+7z1jQozAjzYz4QTZlolkWg07heepTuk3zKP/JjcI+jlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012402;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=835DxEnSywtZBMLzRISeZZ0nE8xsVV06SOGlBgREpU0=;
	b=K2eOmYO6sOgSDdXvT+AS5BA0Thre8ATps5nx39Q887gHZkTfK14C6ktJkwUF418MeKwy
	 2+RIPWIqz7oY+sz+y7bfw4Lr3RGP1JVw+LDLOBxN+rGhAZQQVGQHBTl801bc9ZSpHGo7N
	 6czX1mkln7C/iDZFWAKym372IKsxQ4/zCxaZuvKuKGpUoxY18GZlcLH8WyZ1PnFl86EKB
	 kVV+f8BaTHJhodOMrcPwv84F+a5Xvp7kXTr5MmfsDEc0QbizfoaoAbJlxSdwhfjdgCc1a
	 7KPaQqPWiZfMokUVrN2S22Jqg5jJqGvkdT3z92qjIFs6UXTA2XIiS3wYWjVqtTG3O6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoWh0Ry2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C2580606A320;
	Wed, 18 Nov 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoWh0Ry2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0E2741F000C4;
	Wed, 18 Nov 2026 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012402;
	bh=835DxEnSywtZBMLzRISeZZ0nE8xsVV06SOGlBgREpU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PoWh0Ry2OELgScL/i9zOAV/F1Jc0335SKjezvVlYKnJM3YynE5NyqEXZZ+doP5ms5
	 YEz2kYaW38Fxn0DuegeLq48CLz5gVDALFC9ndtDFwX5/K9NwCcOh/ecB9608qi+sa0
	 ihn375kMk1NnpKE91KEhHss0mkWSJXlAWgJELcPMPooZ7p1JAqHkgTx5ZbEWdh+2aW
	 SRhHyPeOL8p8aM6L+xwkRH5hh11fXUHpk6yopJ2MbMW2frCHUryi9ZIWh/gTcWSZqz
	 BHd6m5SkqfiHhZRRW8x5Ixgm7bNQ09NyEf/LV1KWA1UleL63tUNRxOpayMdkM8v6WL
	 4GOwk9UuT6AFA==
Date: Wed, 18 Nov 2026 16:33:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jaewon Yang <yong010301@gmail.com>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: track the response read position internally, not
 via the file offset
Message-ID: <av23L5HBpy2gbm3m@kernel.org>
References: <alvD5nOP15O5B8Ai@kernel.org>
 <20261117104838.2650999-1-rmustafin@cloudlinux.com>
 <avwzid1Ovl4ACkaQ@kernel.org>
 <avxJ9MxZ0PoWbQTc@kernel.org>
 <avxKqn-PlzJyxVdK@kernel.org>
 <CAG6=z5sxUo1x6mpotkNZXk=nQYvD2AyMLSDhzD3B3kqxJ1=iaw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG6=z5sxUo1x6mpotkNZXk=nQYvD2AyMLSDhzD3B3kqxJ1=iaw@mail.gmail.com>

On Wed, Nov 18, 2026 at 04:49:46PM +0700, Rustam Mustafin wrote:
> On Tue, Nov 17, 2026 at 7:38 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Tue, Nov 17, 2026 at 02:35:04PM +0200, Jarkko Sakkinen wrote:
> > > I think this would be more feasible:
> > >
> > >         if (current->flags & PF_IO_WORKER)
> > >                 return -EIO;
> > >
> > >         if ((current->flags & PF_KTHREAD) && current->io_uring)
> > >                 return -EIO;
> > >
> > > I.e., block io_uring entirely.
> 
> Hi Jarkko, thanks for the review.
> 
> These checks do not fully block io_uring. With O_NONBLOCK set and a
> response ready, io_uring calls ->read() inline from the caller's own
> task, where neither PF_IO_WORKER nor PF_KTHREAD is set.
> loop_rw_iter() declines the inline attempt only when the file lacks
> O_NONBLOCK:
> 
>     if ((kiocb->ki_flags & IOCB_NOWAIT) &&
>         !(kiocb->ki_filp->f_flags & O_NONBLOCK))
>         return -EAGAIN;
> 
> I built a kernel with both checks applied and the injected offset
> still reaches tpm_common_read():
> 
>     BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
>     Read of size 16 at addr ffff88810c3455d2 by task python3/134
>     Call Trace:
>     _copy_to_user+0x4b/0x70
>     tpm_common_read+0x1e6/0x360
>     loop_rw_iter+0x235/0x5a0
>     __io_read+0xc6e/0x11a0
>     io_read+0x8a/0x180
> 
> Reproducer:
> - open("/dev/tpm0", O_RDWR | O_NONBLOCK)
> - write() a command, then poll() until POLLIN
> - submit IORING_OP_READ with sqe->off = 0x1400, without IOSQE_ASYNC
> (this is how tpm2-tss opens the device O_RDWR | O_NONBLOCK).
> 
> Checking current->io_uring alone would catch the inline path, but
> then a process that uses io_uring for anything else would also lose
> plain read()/write() on the device.
> 
> For v2 I propose:
> 
> 1. The read position fix, with your review comments applied.
> 2. stream_open() instead of nonseekable_open(), on top of 1. With
>     FMODE_STREAM both the VFS and io_uring pass a NULL offset to the
>     driver. This follows c5bf68fe0c86 ("*: convert stream-like files
>     from nonseekable_open -> stream_open").
> 3. A kselftest: lseek() and pread() fail with -ESPIPE, chunked reads
>     of a TPM2_GetCapability(TPM_PT_FAMILY_INDICATOR) response match a
>     one-shot read, and an io_uring read with an explicit sqe->off
>     returns the start of the response.
> 
> Br,
> Rustam

I wrote that out of my memory. I did not expect to be exactly out.

Block uring.

Br, Jarkko
