Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022015;
	b=smqWWh2pvhMaTJeATSiSbOmdEeC/nc903yGHX1aOTyZn9KSFnoSEzQs7zBE6IcXgymZs
	 nwldtOw2oE6EqKY5F7lEXqltM7qOe7vDs91RYlb4LtUifI20TR+W9xqvpvmfuO7860e9F
	 Fimm24yo0+LOmUG2YrKtVo0C5hKKTGlZ2VJDtbCZfhEtT9OAfb/nhuLvpY7zZm35+xZxF
	 /JzhBCNn/HDN743t2Oq1szgbQJ1lqz+xh9RSDOw79g+oFW3fhkLTw4bs0eSpGIl4ppcZi
	 k8xuOotNwRXpk61CHdxpPUrl5QS/jHbptrt3xioDBahtIxjO/Id4Iwstb77b2E4cRbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4cBtlgSholNnDJWCl4oISQxqxXzBWeFzV9tSbiyzJfM=;
	b=kVcEB9d9jw/3HPRK2fZmavjjVcgIb1YNBUBN9MKDCqrHzUjXfMYvKoUBIfJtl9YOqH2q
	 Z2R0c8UvYJo5WFiuSWcUl+dGQC2bPdC7gI0LSxyFp+KNJRO++VodQS9XSUyj8WYtxqVuk
	 7EnA3r97pSXG8ABE4REamHPhkY1GdLP9XEAVSh06rkRngdRevWqlURvlgHgSXVOR42ozC
	 b2zeBQBc6Sdb22qtWKiLkpje4gEaGMu0uu98RbimeIuEe/h6f4weyCVAcKFmZWyE2ZyXZ
	 MsBn+Seh+hOJ9usZNE4d/p7kxYcZaB6p23SK0OrEQrtaPbmqA4UuxqRReQml73qa1Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqdcq2jA;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9048606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9048606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqdcq2jA
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6756bb1cso832305e9.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795022013; x=1795626813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cBtlgSholNnDJWCl4oISQxqxXzBWeFzV9tSbiyzJfM=;
        b=oqdcq2jAFfgr419IQ26VJOvfkh19c7KAa6r4tiEfQg1KBiSn6h0ksqMe/Rmz3wciw1
         0quzx40LPTfZUhLJTW1ee0GrC4JlIq+b0zjtW+iT3lRjClNv921pA5skjm4rWPHpbyPZ
         JQ/4v9r5zjOFHwUd3C3oiWPv2DDQ6S0y0OYmt3q4obBQ9b+HI2bFeMnyjKVGkRpWQIXc
         Xs2/IPr910LRZgFjogfIX4dtyLrhBn+HJxsegjKI7EWUhlneZ+ig6aq15IQqBURkuhMT
         Mf5IrNBUOh1AMCVn1GqGrce9Ahf8nDBL7kDC0iuZBfiix8y9mxc8CPxwpzwTWTs5noFg
         hjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795022013; x=1795626813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4cBtlgSholNnDJWCl4oISQxqxXzBWeFzV9tSbiyzJfM=;
        b=w+sPClFT50gpsXT9QCkDPteP7P70wYq5S/GYY7WYuQIuENtHtaPsOw/NoeEUL1g/i1
         jkegjCk5SjEYNCk4Iee7Q2ULhQvwCjqVtnb1MHHlZ0wcTG9431qK0srU4DaYytVjVrDp
         QPurms6NNbqOmBi+fI6TbC3FVmc8/HaLG+hbScOTNP6LjpYlJNFacLqwYGw8Qur5ghlN
         TI6EN6ozhpALOWHd0THjGDHwI858CGVZSNoOSdsuy5O3GkEqLn4Dt1fGofcLi850FvNT
         0YCUrwPsHBpbHJh4TO7Dnni6YcK6h/bs1Tpx1JGw3Ymogq+9krGOs6VXWpMa4/ZtV4+F
         pA8Q==
X-Forwarded-Encrypted: i=1; AL+hErHut5I/v2q3OkQobvEb048WuS7aqLcIT+vTepLYqOsepYwjwT7FtogcPB2s4jeZltGlBQ+NGjE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/psafQLjLUyM2zLd9Pr99G0W61LFUXWZgz1pzf9zaV/q0fly3q
	NMZvKXPNALdxEuVnAmM6GtvUbET19tETWa0V//TUONCjTm3rawO7HujO
X-Gm-Gg: AYBFou22/GE1fIQp0IZm4DGnWgPlzkXE2plLV3fgQpbvVAdki+v96YGtZZziuzRPbq1
	QYOjNHNHyU7a8o/xOrMUzOnTqChT/B0m/fN5INu88vanIyNXZxoQi0VFiywSj4eZ5rKDDjMkVFB
	TKIumMvPnP7jyrbu42XDWBTvlPC+bSu8EWSmQlJHdR6gI7EpprFQNH+BodZHD4u9SpqkszBRrFU
	Ovx5iOGzn/nDnYkeV4PYfuZbV8iFMWExQ33RdnSibpAnIblBGYJ9c33bbZmS+jJBOqyJKzhN1lq
	npZo7RsCP/z66L7Sh4iHUzpTvX90ULKwHtHryJ42QXxbxLJ39n2BHiTf5ARd2rvdJOC/yr392DJ
	soOmvPNzxnQuNKj5FFzo5B1Vos12PxsIS0lUv6a/06N70hIoBjgJwB+lBg4G6KoHIQyhYFEiKlg
	R0QHSPxdU1dJybhKFxlDoFeO2XqvgliTwCK3a8AaGSAKCc4TL8YUXQHHFACzukjfp2IyTGnVX9K
	TfFeGvqG5mbMtrCzszuK6ynA6xzPWoraYOuGXbcQOBppYE07adlikAHqaLjEw59To9CoCL9QIJd
	jO0Yke2DwMnPdyINQiM7NYxZnPe3VeO7b83aw+DDdXeT0Ug1Ww==
X-Received: by 2002:a05:600c:524a:b0:4bb:5ad9:50dc with SMTP id 5b1f17b1804b1-4bb7d5783b5mr61295565e9.0.1795022013053;
        Wed, 18 Nov 2026 09:13:33 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8324a0d7sm2940715e9.3.2026.11.18.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:13:32 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: miquel.raynal@bootlin.com
Cc: mwalle@kernel.org,
	pratyush@kernel.org,
	richard@nod.at,
	vigneshr@ti.com,
	takahiro.kuwano@infineon.com,
	tudor.ambarus@linaro.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] mtd: spi-nor: take the flash lock around spi_nor_restore()
Date: Wed, 18 Nov 2026 19:13:20 +0200
Message-Id: <20261118171320.3887035-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bj7mi5gy.fsf@bootlin.com>
References: <20261029210153.3986211-1-itai.handler@gmail.com> <DMYDITU0H48Z.2LA5KF2TFNUY2@kernel.org> <87bj7mi5gy.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed Nov 18, 2026 at 3:23 PM CET, Miquel Raynal wrote:
>>> +	ret = spi_nor_prep_and_lock(nor);
>>> +	if (ret == -ESHUTDOWN)
>>
>> This is actually really hard to follow.
>
> Yes, I tried to review this patch and eventually stopped. Please teach
> your AI to not overengineer its solutions.

Sorry for the time it cost you. That one is on me: I sent it, and I
should have made it simpler before sending it.

v6 is simpler. It follows Michael's sketch: spi_nor_restore() takes
the lock itself and then sets a "restored" flag, and the lock helpers
fail any later operation with -EIO. The extra helper and the special
error code are gone, and the commit message is about half as long.
The diff is longer than v5's only because the _pe and _rd unlock
helpers move up, as Michael asked.

Thanks,
Itai
