Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795177222;
	b=jJVgsMg10aIJdjzQgEY8ZwJHlpnE08igFAMor4rCjUFxEVpSKHvH7brAhBU+lIoL3nwS
	 eaJEQRQ7q4mKjnuRABWnWixA1emY3NQCfkR0D2n1ZrnwqEoDVa3AxJxcx538YOLGv2DEV
	 ZRzmYFHBALgHlM1p0lAuvr7FOeJm7wxSqUYYFTT7A7uU0FhUTFesCwynVTX/7jqeCClQe
	 +FaKt0IicBuvHxHHsqqaypie9W6A0BY3ie+Dwcv1S9yxqB6rYuBwPg06pRpRlw8b5OPBp
	 X/gkJLgNfmSpPqVVfu5LfjHs88p9vT8Oi8BNglTbUTo1NSzy3we2V+tc1dkEw7BqEMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
	b=k/RG834GwAzfgVYlNymlpW/7OcdSW85UJIe1jdlvFvGSqwLMZhgxP0sx2WntQmy8ATDG
	 Hh6KEIoAiCZz5W6YvZX+jKWFKUWAPGIHjbXI21wT3D8BjRo9o/XrZKhouw2SNOQ3/kfpG
	 wehd315yhR9QuHZ6j9Is4SWXqC0yBQLhap3ilpJ+6sRnQMg46LsN6f1TcFNgolaJSTxkR
	 6GD6W90fju902GT0dm6BZmkxXTT7BKZOgGImQ7oMq9PjMSrcxc3yc6b25/qJ3xigb5yc1
	 W38u3OiStTYsJfzLRsjjCGAidxeLlorS+Ck4SAt0XvVub38fncnbp/wKrCPhqVCGtyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b="f/v4uMn4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152C60A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4152C60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=f/v4uMn4
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c51373ae637so126825566b.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:20:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795177221; cv=none;
        d=google.com; s=arc-20260327;
        b=iD4ESsU6a5FWZrQIa32q/2JLO2n9UK0IjbEslvrC/OL27CqohR/HfHnMi3Sf+zPEz/
         O43lj0gA8KH0qAjBugm0k+ROYgCBGBIVhqUkBTFctJ0PAg6ZdcHY9HUUchhXxqmxgev8
         zpBkcqWwb69Ntn3RUIsUiMenaUwWHPAqkjfsP+GKGsReE2syI0umgf0DcGRXX7SeypQK
         2pZnTIzaGGCGUaX9hlFtZvBxiArEBctfPBswATHAPkESkArPdrcX6RJFhlNAoehexey/
         8ExfQlECAZbHc8jfGCpuxN7WBzKAts7cffew59kpYKKzpwmMtz8Qg7Zcske2VVQir7CG
         Mnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
        fh=6Z/I9ff6zmsEqRSbv5krPCnt7xn5JHQR2PWCtORATF4=;
        b=Hz0zl3AWi6r+cTmCIU+yQomAo9b2u1736r1W3kANAqRE8jxcQlNQ8QBx122TfNAPJD
         zgIGo1UTOw/9PvyueRqKqB/7nQhaPmeO77DkaXJrK5r/Qba1PHP6tnNybVdbqPBlcKze
         YDwoUpHakFxfmqCmaweYrdFAFt0CVQ/xs5/yF+TH8fMA7UXA8vkRApTilATrmgVwaJuH
         4oI+3gPaStP+JnLxOaKpiSjHJ/89A4GYe6+agwBBKlT2GVxT1WkgJXKPEmtSH0qQeeg9
         XSA4XmQRYNFSA+MABQnIywN2HegEleAdNCkcGWxsbwLT2bbkiVKmgBpKy6Vzf6BvDOPc
         lqkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795177221; x=1795782021; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
        b=f/v4uMn4J3fQGmL3e8hL8H6GpITgmTc+j+FxBSUEKNQWWCcZHMZO2Tt7vAhawDk/7d
         trHE7f0BDEtIUdZzG0iJO3hF5E5gt/NNUkLKDU8QAp8gsYRxWEQ2DYavxXHQbsuyBs3u
         0roHf7zcHoItpEkApyGHqmHVB2Qb3K9j5J9KRFsv/e7xsQwFeNmaP05ELmyRkOzWiO81
         eYleydYZC/heAiZP7H6TM6wz/Y77Eg+n5V3frhEA6xCtCSr4nirpr7hcOxguEDPo3D0N
         aPbLGMINMqBlgpedk0Eg00B24dolXOAKRcSfek/2OLCk2Sj1dKcyQWWu7fifkIeOKbWf
         4p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795177221; x=1795782021;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ida7ZOzQmbAaoOpD67ibDsNtLvf5bm1Iif/aInwM/as=;
        b=AUJ5YOpWMTNyhjeg+knNopQGc9McEVgNC/RW4kvJAzWI+OHZqxdXjSSh2p4VJXzIpM
         EwJmB38QJcJjvVt8qyLdDqtO2FF0e617FeMARI3CetPerjylIG1EY1FfI8d6eVXpb/Dv
         n3n5IgScAFVFZRnTIw0vRSkw5mIaW6kB7OH8wcT4SgCMsEFZQ1hXpbR68M6/KO0XDVlB
         NXkwz+8KpfiX/E2gwBvuNaGay4nNkAiyMLV/aNRjMcPdDcBpRRjKAAc3jIGlLUNwDpUf
         IvugLddzB5/EN1b9EoC4W3T1D61r8IAB1Q1E6TXWOv7LBvsTE+cf7IVdvS5h9XMSVj0d
         CJnQ==
X-Forwarded-Encrypted: i=1; AL+hErExynBkrHb0FMW9s8txYKohcDVofSrJD/TOI9Df8+3aAjlgBvwlefPURuiT7WoqX25p4nUpiXE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kYh/9VOR1KgK6KIN5XedbSMWqkXqEg/pCoPirAWp/WJy+j/8j
	LSc6+RXTgyUwmYZuw4I+hfl+dMRIwEzyvlGuxa4FZ9Y+67SaSEyUKJD7/fuImOScZnjN69iS3f3
	BZcfrLq0tel7ve5sSxTiRzwOqCXe62gkGqKDC+W1Nug==
X-Gm-Gg: AYBFou3nxZmKy5V+5k5MIgfHisrcpvRUpNMx8ILkKie0+Xe6PxA+RYA33i9AakgLEF7
	Ql6V6E6gIOG01lnfjZEHVIiDS6WM/WQU7XZPhumV8sTn62RATPJc7sISv/33/NnwECKDEaxxODu
	O002OOEJGuqrxHIx03cvUZZeWYNHSJezSRxTjOgOkBTaqNHZkf58TgxeoXcptvomOscs4DoWtI0
	jXzjg6WLYSFSC4zhci26IKUc7Mv0lNDThP2BaXDvFUMREwl2w2oK4lYA4f5KM+ugLaJl+BAheoc
	oYW2IUSBesH7RXodBFvNV31sRHUqGZkNHM6speRMjAysCaCLcC39fvZxjSO84ceIi5XfpJqwDHJ
	sWmcRBo1tK/HDXaKZDpzX7MVvzu11gjYNcz62ZZVmH5Izxn45jZos+Co=
X-Received: by 2002:a17:906:1ed1:b0:c51:2fb:a039 with SMTP id
 a640c23a62f3a-c513a850365mr243467866b.12.1795177220590; Fri, 20 Nov 2026
 04:20:20 -0800 (PST)
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
 <avwzid1Ovl4ACkaQ@kernel.org> <avxJ9MxZ0PoWbQTc@kernel.org>
 <avxKqn-PlzJyxVdK@kernel.org> <CAG6=z5sxUo1x6mpotkNZXk=nQYvD2AyMLSDhzD3B3kqxJ1=iaw@mail.gmail.com>
 <av23L5HBpy2gbm3m@kernel.org> <CAG6=z5u+qK3JQ4OwqS8e9ncfcasYPWLQhU9Y4iBFi1pEf0QFuQ@mail.gmail.com>
 <av88MkHFBHTD8Rqe@kernel.org>
In-Reply-To: <av88MkHFBHTD8Rqe@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Fri, 20 Nov 2026 19:20:09 +0700
X-Gm-Features: Aa3M54olXavvLpImCYcikZbsYtV4fjBy_7D-xUAbTEHrCt2I1nTcWgO0yQSHO6c
Message-ID: <CAG6=z5tCq-THqRRgF5vMs0=MNmXMp80g8HiQmbyov0i-9pRFXQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: track the response read position internally, not via
 the file offset
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jaewon Yang <yong010301@gmail.com>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 20, 2026 at 1:13 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 1. ->read_iter and ->write_iter that just return -EINVAL.
> >
> >    Simple, but readv() and single-iovec writev() stop working.
>
> So. What would be the use case for this?

I don't know of a real user, tpm2-tss uses read() and write(). It is
about compatibility: readv() works today and can split a response,
e.g. the 10-byte header into one buffer and the body into another.
writev() is less useful, since a command must fit in one iovec.

> 2 is a bug fix, enabling is a feature. I guess this is the confusion.

Adding ->read_iter for 2 also lets vfs_iter_read() callers such as
Coda reach tpm_common_read(). Their requests look the same as readv(),
so the checks in 2 cannot tell them apart. That's why I sent the read
position fix as v2 first:
https://lore.kernel.org/all/20261120121614.978396-1-rmustafin@cloudlinux.com/

With it, tpm_common_read() ignores *off, so io_uring reads and writes
work correctly. I'm not sure about blocking io_uring on top of that:
it works today, and I can't rule out users, especially of /dev/tpmrm0,
which many processes can open at once. I have 2 implemented and
tested, with -EIO, and can send it if it's needed.

Br,
Rustam
