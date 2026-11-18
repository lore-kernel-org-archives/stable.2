Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995755;
	b=fNA+YHhrM0rJf0Q/XoyS+DE5HrwWWH+n4VsuBjF96TuapFeVUFsWV8xTvHMNl2eR02yq
	 lPUmK4vIg4bluCPmETA1OuZfDZKJHtyN7bsDyYH5XMjLJC8uoyrUoLZrR/2PcukNMY1zC
	 iGlVOIURzOTImcS6qv68HahNtTOjH+rIeDzv3R0XNkQpL0q56Suc12oKNRSe/wY1BQ30/
	 ijrdVOLzmNJsbfLvFYnGihd8SOcTmIcSOAZjh0s+/Zh0s+2T6Im3m5ViHVL91KDRr1NjT
	 08rCXFKqdwJZOkSU5TZNZ8Hh2w8ViBVpMutMwi+gEBLQMmg6hoBvGPFqYKsLu6zfbhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
	b=F9A+z6iSuFX60WEDf7l6iVeumfiFEZNhG+ZAine4zvk3PPHKWl4qprs1StjN3J4r6TcC
	 q8AHgTT9og+h0pejydS3ctocrsFgGpJIm4FoxGDRzf6iO+DGBL6kS2QkYFRGGigJ5PMCL
	 E2zrk6+YgfPXfZVIjgZrF21jj0XN6l2yy1z3bWLCQ/n3koxpu9/LvEQ1Irgv6t4TV5QHn
	 /fdnMiCvWPHHTn4OzZ1n/y6Z7Q2xxhsMFZJjXMiYF1BeMNgfYCZtWGNq6Ya608/LRPbac
	 gXStlgM3hTpGK1avCxaEnZQHM/oJr7RCI7UHAHHw+dAB/dY/meghOSe+kFhXNq6P1bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=bFysKzKl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21DF606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E21DF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=bFysKzKl
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso1263208a12.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794995753; cv=none;
        d=google.com; s=arc-20260327;
        b=GEt5j1izPGnK0I/eCq8B2Ey7Z4LPCYHDHxOih7I8yQltoxePMdAuVkwTRfxVUdPATU
         D3pDtRacBoEl7U+nQ0lF4feY1QKbQxAY23Cw9u5i6pFlYf8l0XWPf6camq2oavoouqb3
         aizukO8b72PsdGA0TP3a/ehzWAj3BU1jFjSMZ/RwBnLTPfq/0Bup51X/SztFhnMKXM96
         qqbj/ZiWaKRnAAVobx4M5wPfw1SyBDClZieRMsdNk0PypZI9SPeCUADjvUW00mq1IWej
         RvJStM+n0zK1JqY6swDgCa46q6AlgxdyKgV/unP3Rgm0H0NqGMrDSxSh4ChZYng1v8z7
         RcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
        fh=/EIuqOk8lW1JzNcC0fkeYEDlQJJRIBzIkeWl1MK3FCs=;
        b=GgK3YQ4XL3b2Vnu6/O8ka1aQBkY57Eu5Rqu27LEfCvtfYfNypX3VFHR8WkTTe1sOGo
         XDiZSXe9NB0mbjb2SqUvztMfqUN7uFGoP/1yPm3XmbY+cxHFAjxtqVbBnRSvONrCngDQ
         N/TCtgp+oRQSbNTUbWasubgsmnCGeN/9g/gY/a0LoXseUdSbcVbAhMBqRl59jkTwxt00
         brq+4lAsol7NnHWnDG6Q2JHVd4losjet8av9md4r84crYxDhrVIST+cKU90RhP/fVfXZ
         oyMkBCwJWlBHp8yKdpGb1UlVXzaIhUfw170KZrfwRYLlCHl7omeJ7VfUw+Q8/oOUGBLO
         jkRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794995753; x=1795600553; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
        b=bFysKzKl3BMCNocpAfYC7/aJh1MOAWQ7YzzDrZYZ334ZSPk6IEeETAjh8QuZ+4lQfK
         /iYRw8ji1Fxtl+cU4Yj1D3rPtz59p1vxdURIiPCbLfUsx8xUR/QDNc/v3TT0UKnpBi5g
         +aj0EqyD7G8XCLGfE/3v9Xg6h/3huxJc8IsD7w+yW3uhhKhMni2MFJy1l8yy0WHcXvCO
         ypUitwLhyW1wq1zd0EN1lC3xRiiGt+nZYTWh9e6G1TXiMMnUWDIpqMN+4is9A0OO/XAQ
         Da74g0FrWvFw9BgnCS/xMD6YEFyad6sA658faJZ26qpB3OWeVSUMWdSzhrhMvPrdA291
         Vx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794995753; x=1795600553;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YT4Ew11jfkdMKzaiNmNTlrlUPIMOKEMpL6JNzVMVnPY=;
        b=1TP6EcEFg4g1vVVS9R1n4TkpJIXQ3fUvigLW7CTRp0IRbOIb/eP1pQolYQg3UEw81g
         LpO/iaBbX0MkVfkyPp0lWJgKgCYgaX5ndw++IkN/ckgw2+3VCZRVMc0k/Y2A339T5zFp
         vIvDB41ALTAG420Wng95/+UBLln3lTseI5l9zKDXSAtGHNodp7LZcb55sOI7Cxy5ruQv
         A09U3ZknMRgkhiZE4NNXO6CCBbruDvT6vS6/O5IpEyYEdJ2TqcMPyJDxJIFJBHEgBCem
         g9kxbDHc7Vii2skIpNQJwn3y7XcgEFBLFr1Ktw5ubfpvD8zKk8yucWRu2Jpz08n6rVID
         Lx4Q==
X-Forwarded-Encrypted: i=1; AL+hErHzJcw7nE3V/Xh+cHAk4xHpcQ/fmvjHdJx2N+Cm/5NTdBhTbljpHRXDDwzIqC7fE9G/nAF0+1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7Nf9gtnr/ckmtKU5uNFtVOsAnKCtKhf2ILAC5wvVa4zyKLneY
	rK0V+zHfuEN3HWd/08DS3lVn4gqWN+ui8q3J4c4xd7VotLjez85XHg5wF0/ObMK0SlDWtOb+cTK
	iudS7rFkUq7Onqy5frYZCtaaRdpXrAyT2tq0E6nfZrYF5bEa/jeMSj1MnYg==
X-Gm-Gg: AYBFou2R02AfDYpjWkb7PJ9azhS2z4w58cXzf6nyVDyds4bZ0nBJ5oaqrHzD10LIteO
	q60rDn06BTqB+QB0AANYFtny5vPIJi3KIefxw4IKrMpzQ1koIdskwg7HFgPqNPkFtCeN5nfq7cA
	2sThYz2WEtexMBxI0o38nW4XWsU/YM+MoufeZlQeHYwhlDUPBSbx64fsPzGXpeq93Wkf0DHCe4S
	eDAlSPvhqjBRDyrmGagyhmu7TKEAViDg+xQAJkPin6pWIXr9i0ALyhga+En7iDRDLIbaDJO+N9x
	6wDYWrueKu6TgLS7drdgKpKZN6D+1HhCo8XXhjMwXnB9cCezFLT0WjmkOmsbKv9cKAOPhnKVdSn
	6qvsiahdxjKRGsqei4VkxQg16puZzd1qztf3D/ikZ6eNBTlHHl4Hpv/c=
X-Received: by 2002:a17:907:960a:b0:c40:4965:72cb with SMTP id
 a640c23a62f3a-c510e148c2amr181497666b.21.1794995753370; Wed, 18 Nov 2026
 01:55:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <alvD5nOP15O5B8Ai@kernel.org> <20261117104838.2650999-1-rmustafin@cloudlinux.com>
 <avwzid1Ovl4ACkaQ@kernel.org> <avxJ9MxZ0PoWbQTc@kernel.org> <avxKqn-PlzJyxVdK@kernel.org>
In-Reply-To: <avxKqn-PlzJyxVdK@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Wed, 18 Nov 2026 16:55:42 +0700
X-Gm-Features: AclHuK_OB-KbT-AGKLoVYFZj4MHc_UtbK05YckQfXNXzeGf1DWEJlXVBx-HXIJw
Message-ID: <CAG6=z5uvRmJ38iCOeAOKjjVfpfSXJK8Ta-MmCMNmCWqkqiw6Bw@mail.gmail.com>
Subject: Re: [PATCH] tpm: track the response read position internally, not via
 the file offset
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jaewon Yang <yong010301@gmail.com>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 7:38 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> On Tue, Nov 17, 2026 at 02:35:04PM +0200, Jarkko Sakkinen wrote:
> > I think this would be more feasible:
> >
> >         if (current->flags & PF_IO_WORKER)
> >                 return -EIO;
> >
> >         if ((current->flags & PF_KTHREAD) && current->io_uring)
> >                 return -EIO;
> >
> > I.e., block io_uring entirely.

Hi Jarkko, thanks for the review.

These checks do not fully block io_uring. With O_NONBLOCK set and a
response ready, io_uring calls ->read() inline from the caller's own
task, where neither PF_IO_WORKER nor PF_KTHREAD is set.
loop_rw_iter() declines the inline attempt only when the file lacks
O_NONBLOCK:

    if ((kiocb->ki_flags & IOCB_NOWAIT) &&
        !(kiocb->ki_filp->f_flags & O_NONBLOCK))
        return -EAGAIN;

I built a kernel with both checks applied and the injected offset
still reaches tpm_common_read():

    BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
    Read of size 16 at addr ffff88810c3455d2 by task python3/134
    Call Trace:
    _copy_to_user+0x4b/0x70
    tpm_common_read+0x1e6/0x360
    loop_rw_iter+0x235/0x5a0
    __io_read+0xc6e/0x11a0
    io_read+0x8a/0x180

Reproducer:
- open("/dev/tpm0", O_RDWR | O_NONBLOCK)
- write() a command, then poll() until POLLIN
- submit IORING_OP_READ with sqe->off = 0x1400, without IOSQE_ASYNC
(this is how tpm2-tss opens the device O_RDWR | O_NONBLOCK).

Checking current->io_uring alone would catch the inline path, but
then a process that uses io_uring for anything else would also lose
plain read()/write() on the device.

For v2 I propose:

1. The read position fix, with your review comments applied.
2. stream_open() instead of nonseekable_open(), on top of 1. With
   FMODE_STREAM both the VFS and io_uring pass a NULL offset to the
   driver. This follows c5bf68fe0c86 ("*: convert stream-like files
   from nonseekable_open -> stream_open").
3. A kselftest: lseek() and pread() fail with -ESPIPE, chunked reads
   of a TPM2_GetCapability(TPM_PT_FAMILY_INDICATOR) response match a
   one-shot read, and an io_uring read with an explicit sqe->off
   returns the start of the response.

Br,
Rustam
