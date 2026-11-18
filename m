Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014380;
	b=Ywpf6IFbxwLuE/3zmL2yCcIcik/UT/KHEZGrZc6lYpT7QDYZeI1HU7sZXJdBU+ICPmk9
	 GXLb+BoM8epnU+DwSYDMhaltzpJmGHm84TD64HQUaZ01DaYiIx0WIG4LInaQtDYZhPI8e
	 WNpUYvxS6zBFal6e43jal70lSLbtOZ5rjyBcNrHYkaUjeTNIz4oBWKR69Fpy0hRBuyf0C
	 733W8Ke0N01HGX2X1cAeUnfznp5PHDycak72Ow5WoAScU/4nix5kgNwV9gGT85QccilvW
	 DpvYrTOkK+icK5p8nXHmzTSpT5sZjklkGdob2Uk9S+Yt3FkQ//HPKCe4gp2n2l9kq7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=tKPUcQCwUJ0o16oWcFk1SSJYCflKgF3hlVLSRCArcVc=;
	b=Gix83mPmbnVw9/ZhoifdYgeqVN3pBXqGyK1tKsfYQGj6RrU46GTVpOuAnF/l5tgP1j1S
	 ZOhvr2E3N+vCoNIRnwWiJvi08ifV6MOlWcjMXSyrF90PTjV6/8BRZXp4LUG1XGws3dkqx
	 mkg8fHJJohJo/UB2Amdg0pbUfV4UXHHDLmsJ/K0U15vqW8R7PMtsTWGApZMwG59kEqm/1
	 ZaF/lCECJZmcBGKCyiikSiD6/k30udQE5DOwI9upxL+ONkqaWW2W/oPGWsRGWLg7UIjsF
	 9UjM24cRj2Ejz10Y4QxPiLgB7+VvpHob7v5f+0f9mPukWQHVW1frDqaS0XYxfs9wUzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oazsg+Kk;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADA606A339
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FADA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oazsg+Kk
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-381d542bc29so2107404eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795014379; x=1795619179; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tKPUcQCwUJ0o16oWcFk1SSJYCflKgF3hlVLSRCArcVc=;
        b=oazsg+Kk9ACdNFN3l7hy2qrJxFy5DmqqWudZXT2Ok3anHQMm83IXM/en8tYt/ko5DI
         YIJsIWv4Qxmtotwhu8i8Zaqg6jleeUeXuNwDX5NleJJKFaFf4I+kkAdN9/19ZQqwf7Wh
         5mA8AI6yT3WG5bCugUx8bwYrQVOvYWZ000hGFMXwJr9kLJ//tp3XsKDgtQkLJEEFkhRa
         g6KbCBxFVIgixRK2xvZWa+dQPi5dSlPOnSkO6Ro3WOnKtdngBVvK/fiRZtkI6ICpESWM
         bhXYH0UbMWTWdpKmwSE78M4yJ8yWSsJk3rZZrzekB0zlTVPfHMcPR2duimRPtlIIochU
         mIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014379; x=1795619179;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKPUcQCwUJ0o16oWcFk1SSJYCflKgF3hlVLSRCArcVc=;
        b=WbW4WA7i3e9n0O8kTLJfeH1xOS5qGp1+Mv1wmITotGhPwEfflt/2fLbhyftaDCzFyX
         jECOwiuGcfulkSJhwgbHQb0Td22ZA6BKZsGVDORBHbqxWeP2GD0x8nh/YC6BBZAsM2Or
         VcGc5uhx5nmaBq4yKFGnTrOVEwDHVJnZ+HA9I03If9A/XQAafmp8H6x9vaKyWwpPNr18
         Xc1b5kYTno4bOrxaqVkHv630APWhCKp8W3V/l7Lwjik5Mj2ACIm72VptegPXHmOPgv5V
         om7vAC75H7LrwlzNP5GyWy6j7kFZ+rv/ignZNuUm09UzpmgG3Obva/MLgmrwlgQT7mT/
         P6vw==
X-Forwarded-Encrypted: i=1; AL+hErGGhwxLBU4JY7D6KQZfzbyGOkB93iasbHXOrKfrFqpeXB4k72WDJGfFMK1E8NKcun/mTya3akw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+VcbRVxfUl3/Kgvtb1/P45gu4+RgJT/xSZ/+EPiL7BD32mGxE
	1xcJJ5ffKtYd7Qt5n642ommopyWxmovUlhC8KvTdzugcXbQ1nbRDACdr
X-Gm-Gg: AZFdTZdQPtJMtLJ97p0STnOVVqE+20ey1DTiqYl+l3vBJzYHe91YMCexEXvPXLj21j9
	lYYWES6rxmhrB6Mp+OIupKajuokOh4oLGxynLEMYNdLuohG6GiDHBAoekBC2uQYg9ogB7RDte0G
	EDBp31CM4Lx6QzOSAJL5oqHppCX/A6j19KKWNF1gQK9dBTzN+HKgt+Zsb58gi6ajqedO8Dp+TjE
	yOBMOBhSJ0YQck1tWUVBGftCLhfD+pi/3uYf9GbjnyRpqtxqTYsV22CN/SkWrUziO8T0KZi8zfz
	fcVu7MN19txXNSZaYz/cLOevTiOkLheaROsQp9FkoozgwzQS2i3wI03A1ZxM+6if7Ecqf93pKAV
	YImvysWvRp+SrzXB/fFCZq3D/VaheEJQzKXnsRkEfaSnmlRs1PLUgvGfavau7pjbgxm92LyqJXR
	4A54ulqn7S+G191HCu1p/xzqGpW0R9+r7/ZSzBCJEf6XirRSXrZK++uM3H6+1b3YCH5+as2iNwP
	w8+liNeChZARY4ieDixQgD5I1bANW7ZZaQzVebWh+FLOK8IW6zzgenbafckKJnfkxL2UTM=
X-Received: by 2002:a05:7300:cca9:b0:375:dc5b:4400 with SMTP id 5a478bee46e88-3827dd05a5amr2957513eec.1.1795014379070;
        Wed, 18 Nov 2026 07:06:19 -0800 (PST)
Received: from [172.21.0.2] (vldb.skku.ac.kr. [115.145.173.180])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6df02adsm9897638eec.14.2026.11.18.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:06:18 -0800 (PST)
Date: Wed, 18 Nov 2026 07:06:18 -0800 (PST)
From: Kyuwon Cho <kyuwoncho18@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net v3 2/2] tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()
In-Reply-To: <20261118144249.358481-2-jiayuan.chen@linux.dev>
References: <20261118144249.358481-1-jiayuan.chen@linux.dev>
 <20261118144249.358481-2-jiayuan.chen@linux.dev>
Message-ID: <179501434217.2486727.13336571553047162527@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 10:42:38PM +0800, Jiayuan Chen wrote:
> icsk_backoff is used as a shift amount in inet_csk_rto_backoff():
>
> 	u64 when = (u64)icsk->icsk_rto << icsk->icsk_backoff;
>
> It can go past 63 on the paths of both callers:

I tested the zero window probe path with the reproducer from my report,
an orphaned socket that keeps probing a zero window. Without the series,
v7.4-rc3 shows the UBSAN report, but with both v3 patches applied, it is
gone.

Tested-by: Kyuwon Cho <kyuwoncho18@gmail.com>

Thanks,
Kyuwon Cho
