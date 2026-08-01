Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17DE36F8E4
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605893; cv=none; b=EzJMF4TNweAviGKbNcgSHgUmtB0uNTXMPuapQFGt3llWuqsoGWRZP6rKOi7XffTqea+bzRsCKo3FpiaRhyL/zLJ5uJGT90K3F6UoyOzmbsDtBqtORPjr4YCg2dlARlq+PawU4mKrw8Z0eA3NuPWNlrVZqk9/ypkhSqzp4irA41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605893; c=relaxed/simple;
	bh=h1I5cBGaL4NNtruvUDMk6k72yunOA/sUN+iC6Di/G7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UcogRpAFgLsVRwMRVXyLs1Lo86914tEPHAb4faxvqVV47UQEEpnj++3EOS0tfTMmb2DFCDxUe+AVRLIkAWE5e9C0S4H7It1sAQ1NoOTz/xi1KS4hWbJEABQRQprVwRjT9vn6TV8ruaJUZhHfbdt/ya8j0eBEC4IioDPi+c7Rbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGgsdVI6; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGgsdVI6"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso646730f8f.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785605890; x=1786210690; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3nDM0mc96Bzr18k4xoBHNsXxvKjDpatYOwOhRrLaoyo=;
        b=mGgsdVI6YR+M1FrcqYnt02Rc/Y6TDJiSbOtcpg9qQhYb3gX3LcDq7b50KPjgOXraAq
         cCtEJQhPKQsAOdEHqUTajSXGtrUsGOH7TY5ZpDwezW4+utkwxAXSs/ATE0x3BFIKs/ar
         JoCbExesPFxGzYMprEhIw91wrN6PNauKjXXGDdYT1oPGOJ2SnzWqaojmns3DQunFOcca
         /SQlzIKrgGm/9pchfYIChDj1KRS0PbksPIHmAMMzw/RGxfqyiGh1qRhG7T3bRIXVCmsd
         wlso9lP0WFhVUh4i1WeVluz/kJgs/NU3YGDlK7iIKff8nUa74XCBWUjkJtR5Mufv0sOW
         ZANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785605890; x=1786210690;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nDM0mc96Bzr18k4xoBHNsXxvKjDpatYOwOhRrLaoyo=;
        b=SYzaAKxegrjHI24+6Jv1tZ0lz4SVvzypXkIkp8vujwnu4n+TEKp2Rx8GTQaiVxR0Tl
         7sKr9GfqehVyx36zmgtAsHnF1B4EFZlcokN2ILDN9yaBbtbX6WanO5r+Elc3TXBc2PCX
         SgY6EWvitcAtHSK3CaYSUpCQwMIux1cwlSkNB0VcIJ0VLocBmmldaQMz4XggXWQqxgez
         itDs0Y0xiZwy84NwM85/j6ABjl8bZr8EarPNPKHQgGmOmrDI7YdTZWfcWmQj6oEVeMtI
         WcO86YPz91IeaSBRfyAsD0N7uA1ZQv+yrPa+LKIFL3kVHvM4kXnpUkfZM0HJncEFKsL7
         x3Ig==
X-Forwarded-Encrypted: i=1; AHgh+RpzRrX2yLDDn4HGXJw0Ip44YNsZLFgdb4WnHXKoOSWlL5uGE8kP5sFC/VwFTsh0PVzFtjfBCiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2Tm75v2x5ZMX1Ad+/2RBOAWGTPXK5eCjYY+4KCVpOFz/yCg3
	Amy2UxShTHM0d54fSuSghwZSNNpL9ich57sEfPlCvOx9MQZCFWi/8GVC
X-Gm-Gg: AR+sD10tUHKc7Cvn4AM0M3PdCgH8xusIheyPMVcB3iQt6hbAAzIjo/9qEu2IBohQCLP
	ilH/qgWIwGz4LH8fCZiuUi/t0fzKQiCwqfePyqBEzyBFvRnyOm9fERSDsesmg94VL2mg5ASJgPy
	z+WVgXy8yQMUIAUn2hpiIM6417UTEU6VCXzzQUjqv6TTwV4hQYo/BmAO85ts3QbFTYEw6HiuuSA
	rJNV7jE1q8qTVjNJnWGzIjCN8zb76U+g+o18jsE8HnO9inDx+sNJxHuhgIQ7UhEFW0L1HQzvYyw
	TdySE/vj0C1SkrmGAxGHYXKTIKmDrkyIC41Nr7sGY9oYT9ev3hHW8N3ddbt9YxfM5APbgcP5pRj
	pLBnlgon9SAZXo5rUOQUGTgkI8myLosFb2hW9CzMGJLOKT4G5ntiHZBSbseuDpDq+ZcMNAURNDJ
	9MO/mJI6xswr0rEP5g1lOiszSUA2KySy1hRyHzrB0U0a+k+SUx9LAg1wFpcpohys7bdiwfygCyO
	iGBqoWyJDqjn7RfYqJF6w6vHXLfStR0lhGV0S7EyM/DpdgH3n1mPj+bOYRE6++Qx6dH3u4oY8Ph
	sIB0goS+m6QmP5Oy5AFIEO0Im/E=
X-Received: by 2002:a5d:4acf:0:b0:47d:f441:5f93 with SMTP id ffacd0b85a97d-47fd72c560bmr6890615f8f.25.1785605889988;
        Sat, 01 Aug 2026 10:38:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d17f2sm20504660f8f.2.2026.08.01.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 19:38:08 +0200
Message-Id: <DKDSGKU7WKI2.3UV1GEZW2VZWY@gmail.com>
Cc: <fsverity@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Jiri
 Olsa" <jolsa@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260731003925.2728977-1-ebiggers@kernel.org>
 <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com> <20260801171549.GB3567@quark>
 <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>
In-Reply-To: <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>

On Sat Aug 1, 2026 at 7:35 PM CEST, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 1, 2026 at 7:15 PM CEST, Eric Biggers wrote:
>> On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
>>> > Also correctly handle sizes over INT_MAX, which previously caused an
>>> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
>>> >
>>>
>>> I guess this occurs when using file dynptrs? Otherwise the size is capp=
ed to
>>> DYNPTR_SIZE_MASK.
>>
>> Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
>> So this particular issue might be unreachable.  Still seems like a good
>> idea to match the u64 type that __bpf_dynptr_size() returns though.
>>
>
> I don't see this in patchwork, so you might have to resend this with [PAT=
CH
> bpf-next] subject again to trigger CI if you want this to go through bpf =
tree.
>

Sorry, [PATCH bpf], rather.

>> - Eric

