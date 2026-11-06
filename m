Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986301;
	b=IRxV/qtQWOdpVXvrCInpP5dtH00GvYgTwQS4TA5AdHbJrHp5aDm61aT1vm9WvzTOvGxh
	 9bjKucSeRN8FrZLQex+/B6DHVK2/rpOQ3Q1wylCopvMe4yN0HjDmlbYyHPIuCcgO9WAQb
	 q6PduRge83Dnk8ABwwZ9T3yEsEQsoOcoTLXXAyLKHfenyKeIP7mWPev14XQnOx9CB5hEN
	 FwCymH6pUiUVaD9gY/nvCmOkI1ADPWqJgPA6qGSuwbSEV37uhMouxJNaBJUVCr8gJgW2p
	 9dBXgNaAkQxxVA+Ujdyvua9Ls7kBWJkgVXuD3H97JjyKjgIJAG4LmQC9fM08+N8+OLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SAsf/HJnla1202h032Zyvwlt1FDI3cas1HI6elwtfA8=;
	b=baGEWsyWT6TZV+FTOV2EGc5rzOe2CkjtJxXYhtvGwgyPKK0qzM3fMdiEtiPfyAIw8Jqh
	 8ZMpgozgSMkCyOgTinbVmwgHQvz0/c7ujUfvlPZE0nmlX9FKsWZpwALX5hteTPDZpLChg
	 /X4ZpvAZ4dO/JMol3ZmNaciUNMW3tnhpvleGjaeRRV+O7VMzgSiyynwRcM3HXNREHngu9
	 tY6F9SlxgTayeMucRPJ1UfcVmM+MYOHrHa5XwePZwSbQvoyNP0TkamU5po+7fqgYZEklz
	 lpbfWvehIP2ojpFJ1lGR2a/eoIf9Rvr6BO0LrDZq56Fem1H6SfltfqGsJe03Uukm5Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4+H+1F6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.71
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA5606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BA5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4+H+1F6
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3ac5c86570aso714671fa.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:31:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793986299; cv=none;
        d=google.com; s=arc-20260327;
        b=r4/K4U6Cokq5j9kWrSs7m1VLgaDzf7n9jFdZvba1+sCgBcaM3O3I8XpBqyDWs3yDyl
         kSbkIVeDiX0dmA2x0HpcqlPNFBEJnPSCmg8v5dN74icswDuzmppiQOmZsxG/WOBIlYzk
         lsGpiHTbwBXEXrASeY4Mrgfet+zItvDFcy8ZWK5sOv17xX01TUDvX1c4Shr8zR5hrUjn
         EylzN07HwDySTcYu84oIdizTBaV6BfaXLfi+dFmvssZdBzjYa0hgKL5IL20WEH5rJ6Wf
         VMcBIANp8WJAhzxPRnAr8gZzE34CUVMtw0VXm6ibF9nmarhczmLHVwO+qwBfztDQcJEG
         OXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SAsf/HJnla1202h032Zyvwlt1FDI3cas1HI6elwtfA8=;
        fh=k//bE99jN2bvZFUwdSpJDLXRDl4eUPIFPcPf6Cb0Nfw=;
        b=bhn5gQOXEO+hbl4GIxHeRRkiN7sQw25RGAaJ8eETKSGyd5VqQzqD/HooMmmS4DCWdW
         ce6+UCjxJ6SJrpUwIOeSfIkhKeDwfpeERM0Q6qUucvQcNfEbH50KwXvSqRQ7ripveZ+P
         i5C/rKKRlLwvqgOhd9uH3vvCR81SFetgcqy9oOJunBiQu4iNDILYu1gD6SCPcKmWTsiP
         ES5R3uHHBZytwaMfjScaKj22HtQh9jy/h2dXyGANgh7quV7G7mtok3UAAS2v3cHJt/N2
         r3VDhMSvDS7vDeEeH+TkQgh886A1uR68Oqi30iLwD/R8pp8D87g2rwqej/3A0pGDVvEd
         I3dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793986299; x=1794591099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SAsf/HJnla1202h032Zyvwlt1FDI3cas1HI6elwtfA8=;
        b=P4+H+1F6M7rJHsIV9+FaNVlWRMbnr0A2JFUp/oXQo+O9VfDSgU3sggrd47kNd3izdz
         d5Mrfaiy+SAtJ0XQs0kQZFEYUKPt0ODDfvzM7p6TXF2c2XAlYfooVzjevL16c3ZblW38
         zXWvcRLTieY09hWod2jDAOopAiTQg3jiidCY4bdAreE7Pu/rNrkTtuyUhUv1okJqgUQO
         fLPxhF59vHCGN75NZIWLwPYa2uU+J+YjSKeDJma3SXKwJSJ4jIRoI3iqyptfowy1cW9b
         V93cb+9pCQ8GCV2N4d/83DzbIW78OTixGals2GDZ02LaNzO1l60H0doOBrBHdhL6YFVd
         I2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986299; x=1794591099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAsf/HJnla1202h032Zyvwlt1FDI3cas1HI6elwtfA8=;
        b=v1GVJlc3nDUU+BuHxzboT1GSU3GHBH80DLBoTMFAN8Ga7sUz4mTVIwI7HkpuRtTob/
         yMDZp9gyN7U+asmdNPB8v5a3+OxBMMvFfU87YEB9BWQ0kOJEH7vIfK42y+uDPBtBg+Oo
         rhevIdLqfBB/SKJmMcVpa79PVqq/fTJMeBGGtQGrPUs6augMEB7OFxPG69GVIZqq8tl2
         WLBqobe64SjLPqRjZC1MD7VbLMmZEBZozAfbRLPVk3bcIYp5NZP6R9F4caOI/NoNsNEK
         VL9Mb247RrsWi/JHOzkYMq6+nHmhKAWIUp4yf4VX2niWOCuZVTnJLPkcQGgIJkAW1WDL
         Pgng==
X-Forwarded-Encrypted: i=1; AL+hErFKhbvskE4Q8J+/pM48W7PdvLAo6+tgmjJZ11jKN8VLldhTSE22GHvJRgD9Iz06rBeazBshTqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iTKLw1k2p6iNGsOno7O8Zz+wUYeNIJQVkuLzmixEQxrVtxf6X
	6oWgHSSwDg/EIVmhJip6mC/OAoNq1Au/7g6/MR/KuXdL75kz4FbbIbO09mj4w6hk/YSpbLhz8UG
	zy20W8g9rcVBcgV3m0VYe6d5DKFNoYV2rlgUA6ZWeQSWV
X-Gm-Gg: AYBFou0u2T0aACnMUTZ+S3K7R19HIriXxJNecNFgY0T5d5+RrR9/0egCDu2k6/hazy2
	0omfuqs1CsVxJ05ty1o6d9lT0Irmpck4EeS52qXlE/IaGKIBUMmmDKH4IszMrwoITNCBNoY44ey
	Utdo3td9i/4HnfKstiGiXdeDZItAu7L99/dGBQm07kwT83J+EfxYLIkY1ImBA9QOwF0eZlN+eUj
	LAIIAe9mzYsySAVZQuxlndYjLN0Hm2j+Hs70Ki9S5kK45VddbpVX4nAMgX8DkSuq0oepzDk1T8d
	5T/8vUgfbjngRa0hEhaa5Ee15j9u1Bnzs8hZAWnavGflgP4nOzQmDL0cVV4zFYqkAxyvKbXF191
	/DaOd/QOa7aMcHapC6w1xLZDRbuWPdAeKmaYieWhK4xl5v7o9D0kRr41Qbg==
X-Received: by 2002:a2e:a107:0:b0:3ac:e00f:6bef with SMTP id
 38308e7fff4ca-3acf3a07eabmr6207661fa.6.1793986298519; Fri, 06 Nov 2026
 09:31:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105061433.1947491-1-bsdhenrymartin@gmail.com> <3f0cf989-c294-44ac-8bf9-11bf69dfee45@kernel.dk>
In-Reply-To: <3f0cf989-c294-44ac-8bf9-11bf69dfee45@kernel.dk>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sat, 7 Nov 2026 01:31:27 +0800
X-Gm-Features: AclHuK8FDdjdShTooQaCgTiT2ZtXnpiQqMTbomZdRqfL2T5bf1xh8VVRWEJU1_M
Message-ID: <CAEnQdOqaGiexk6BcvU+L1xoEFDr1e6sWzm1VuH-JBJJKXhc__Q@mail.gmail.com>
Subject: Re: [PATCH] io_uring/kbuf: fix cross-mm interpretation of provided buffers
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 11/5/26, Jens Axboe wrote:
> This isn't a bug. A ring is shared memory, and anyone with access to it
> can write SQEs that the other side submits, with whatever addresses they
> want. Provided buffers are no different from the addr field in any SQE,
> and the same holds for ring provided buffers which this patch doesn't
> even touch. Sharing a ring with another address space means fully
> trusting it, that's inherent to the design.

Agreed =E2=80=94 the SQE address fields already grant that capability, and
ring provided buffers have the same property, so this adds nothing
beyond what sharing a ring already means.

Thanks for the review,
Henry

Jens Axboe <axboe@kernel.dk> =E4=BA=8E2026=E5=B9=B411=E6=9C=885=E6=97=A5=E5=
=91=A8=E5=9B=9B 21:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/4/26 11:14 PM, Henry Martin wrote:
> > Legacy provided buffers store a raw user virtual address.  It is
> > recorded in io_add_buffers() and later returned verbatim by
> > io_provided_buffer_select().  The consumer (recv, send, read)
> > imports it as a user pointer, so it is resolved in the address
> > space of whichever task issues the request.  Nothing ties a buffer
> > to the address space it was provided from.
> >
> > When a ring is shared between tasks with different address spaces,
> > for example across fork(2) and execve(2), a consuming request reads
> > from or writes to an address chosen by the provider, in the
> > consumer's address space.
> >
> > Record the providing task's mm in each buffer, and refuse selection
> > when the consuming task runs under a different mm.  The buffer stays
> > queued for its owner and the request fails with -ENOBUFS.  The mm
> > reference is held while the buffer is queued.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
>
> This is nonsense.
>
> This isn't a bug. A ring is shared memory, and anyone with access to it
> can write SQEs that the other side submits, with whatever addresses they
> want. Provided buffers are no different from the addr field in any SQE,
> and the same holds for ring provided buffers which this patch doesn't
> even touch. Sharing a ring with another address space means fully
> trusting it, that's inherent to the design.
>
> --
> Jens Axboe
>
