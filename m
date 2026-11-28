Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795867931;
	b=Vsh22fb3xu5mvkm5gjayef37nY8k9C1jV7b+NJVvcoDbe6aKYsVtRwhuuJgeyHxdDuYm
	 WbdpzDkr2/arhxGiYXD1U21KSz5OleqT5ur6HdzMqPrm4EQzGpVMCczBAMoQBtbnGoYZ7
	 AnHjSEU/ivcSqh9wgKq83Xolw+4JpuCCQy9PMU9VHnmXkpa3Ckuo1E+2W1K3oxkz4qLFF
	 Ln95amXfDTYDZ73qersuZor8l79G04yLuDpDh+shYZhDq0Pqdy85nPTDXT9MR2wYnERL4
	 4E3iu2auw57krb+gD4rLLivXuEX/uFIq3v1s1IfDUy7aCXyNTlGfsbvH8fbiNLnLWkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=l1Lq5An5Z83wHHj2w09+eMh4u8QzdGI1fHGwx9QDitw=;
	b=kqkT+NplEGb5N8lN4kO5RcUvnYGrNPHaCSz+Hq77ySrIE83FuYth9YvjO9YoXyx5ozdM
	 5AJ4TbJQ8wo9gk9lcQOwDADpQTqqEWHsMYGNOy2WPMrMezE/KtkdLniZBzvUxbzqiVaKe
	 Ul0bpQbCUfAh24sBudYx5KXNAKVdGmDB4W1Hv1aD5NPuEceZsbOXaX6SARGJNswDblats
	 vMDQ96nEJW8iwbmUf3iUXJeWmRD3WWM8xA8Va7obnINMObUpV6W7/QvKanW+pOA/Vxtf/
	 6Z2mgDD6N6uGTIy2ej2GneFsHXjWRB5dks9cxE/1h95hWVUF1xULQL1do++Knq59VjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w493UR6P;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2D606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 12:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w493UR6P
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-170135e43c7so13863821c88.0
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795867930; x=1796472730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l1Lq5An5Z83wHHj2w09+eMh4u8QzdGI1fHGwx9QDitw=;
        b=w493UR6PWp0zc1n/spj72CjUtJGSVHNXV7pJHrzQV9co+Hl1YUyI9ZUSZEVEL0GE5e
         166vyA9gxBWxI7Brb+gAZqDOytQqBJGmkYAMS+HhmPH41WklU4Hsz7Bp1NLn/+2kT1ge
         sAPkik6O1L3QGchwWIPKN54RAxk6kTD1EvJHSAZ5z3Ati0huHdNc3bv7PriC6+/K2tGY
         aFd5oHjWtF5L4MslRtAV3rJKmIGkY0OZhWqIvd4oK4UfCcex78VdvqppnASWHQ4BVUjO
         +Uys8M38LzVsVEJ7QNVYa5k1w7Luwwuah8RP7Uy+mr4MKzCQnykJY+i7whqdv8WvYiLn
         r6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795867930; x=1796472730;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1Lq5An5Z83wHHj2w09+eMh4u8QzdGI1fHGwx9QDitw=;
        b=MzomqawSGhfb5QYso505GXWiOF/dPCSRiiwJzY6LXkfXplgtUdCWweo8saM8XEnFcJ
         ZAQV/ctC1sQdadnGgWzEIXt2igtx7T/3Bfn/+3lsQiUu2IreZ+TRZmevPWZ36QMKQ35U
         5A+7QwT/2dWKrhO2Sbrc8yhzK+DaJXqVD+qX1F/G4nqkl/J0hOcuIJKCIhmcYoXSX5Op
         cjWFIjnNzARokeGtyZ3KhlzY7ejUeJry/E0L8VxyXBlAjZ9x80hN0H2kUYynwq57yrXo
         v9wlRTmvGNuDr39Uttkm/D49C5YW7RbcgA9hfTwtLPf4EVQnVqJrTsKzQl7ahBNMqsPC
         1Qhw==
X-Gm-Message-State: APuU4Z+tznAr4V8TltN86M/iyRqrDS+pM4ctqhWtAW2gzbcpJj1Fb9u6
	nDstf2IbGuAQvAjc08xySMlhj/HtJu1vd+TiAY34Z+pBEI2eAUQB6ksl
X-Gm-Gg: AZFdTZc0hB/0EK2DRObEGsOXxeLVRlQ2Ng8+Z5WQxThIiq/SXq4ReXYM7iObHiMKkrF
	EvPPY5fKhpMPf+61JQ5cSoulKGBpKU9C5W8P48xQTv3miUsjtja8xIe4+v9UVbZBoefV1du6lGQ
	kZlrnwnWTeNfLvn2tEIi9El0zkryo0U1eE7Hce+KHXVxaWsVwUnnK7rvDsUM7Uct3pmuC8/EpcG
	cFkTUmvnJwNYrzhezUAuAjzo9V7Q7QWq6oQ8Dl7XhHa/7kp3jzwT3awJRBUvk6DqQymynNsw6YW
	cDyip3SxD8G8G8uy10BFDweYimZB7fddQynozdS0bPWzgXMp5ulnRcouFukoN0BeApb23x6m8YL
	Tk5jLuZaHPx9mQ665zNTgaX7YzUNiaaUHd6DHswEN8xYI3CKliDTEQAmM4t8PQFb05egVEVYC0n
	N3d1fxumNZSplHN/w+hWfc7s76bN5F6Vr6LpLXgIFBbmoKicI940+327RhZv8pEknVeD5yi4uNB
	K+sJvoywt2iCFCnWzMOtbGUjhP8ZYHT7wf7WBxP9krdR7OroW6gesv/z0XtGHo8fPNME6CMrdvC
	i5ZjbBu2JauyZ8EdX7N+UC/men2M7zKiWFRFB4aUzb3z1KwuQPQy31pnhyhg6fmfn0Kk3Zjwv/u
	K6Wu9aS2710iAtfPoKkdC5G3qF/u42uI=
X-Received: by 2002:a05:7022:f50b:b0:1b5:2de3:bcfb with SMTP id a92af1059eb24-1b5568ee8famr28595962c88.25.1795867929960;
        Sat, 28 Nov 2026 04:12:09 -0800 (PST)
Received: from v4bel ([211.209.222.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm102374239eec.11.2026.11.28.04.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 04:12:09 -0800 (PST)
Date: Sat, 28 Nov 2026 21:12:06 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, imv4bel@gmail.com
Subject: Re: [PATCH 7.3.y 1/2] tcp: Do not allow buggy transitions between
 ehash and lhash2.
Message-ID: <awrFFs8P8JmaLJiU@v4bel>
References: <20261125130843.3343543-1-imv4bel@gmail.com>
 <2026-11-26-1-daily-reply-0033@kernel.org>
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
In-Reply-To: <2026-11-26-1-daily-reply-0033@kernel.org>

On Fri, Nov 27, 2026 at 12:01:21PM -0500, Sasha Levin wrote:
> > The following state transitions have long been a playground for
> > syzbot, and recently AI joined in, reporting a lot more bugs.
> 
> Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.
> 
> 7.3, 6.18 and 6.12 already had patch 1 queued, so only patch 2 went there.

It looks like this has been backported to 7.3, 6.18, and 6.12 as well. Thanks.

> On 6.6, 6.1, 5.15 and 5.10 I added 404381b4f105 ("tcp: Set unhashed_state
> in inet_twsk_hashdance_schedule().") between the two, since it fixes
> patch 1.


Best regards,
Hyunwoo Kim
