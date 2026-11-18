Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014255;
	b=nG261qwijfx819LklZjzY/HGN0DjAKHYhAp6b5rqWm50XQf17SjuzfQloicI9f9LeUBs
	 S4QeDIsqiJQirQ7E6Ba3dVuPcsUREhB27beYULw3imVusxF7DYOy9Hdsm0GzNIOzDtihV
	 +5J2EP5kMxnmM18qM2cpgfEWT15xnYrZowVjlTrmxIocb0HhIUBUix4XyjFy3O1Uds42S
	 9FpVUTT6uxiaukA1AJ43lNyZQVsIUZO3IaKoKl5EHEyN0HRlZikUEVSML3hxnK15l5SO+
	 B6A36SVYE8U4JUt0azBoC8yR1HeIA7QPlv3q2But++d4KlFCQhJ0rGIdbZQMl13hyaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=Z/tQwtb+guAS1R6/OD9tZmRzv2qN3TXj6uh+KCQvyAk=;
	b=jCNEarizzTGR5G1PWP6aqiAX5Aj9CUucotgzgVlLJsmVP90LjvvcDytFaiD3MWR11q//
	 f3tmMGAschWpDtgiaIkYzXpN7elq6m0oqLx+F+qYMGh9j/gLtwYiSSOoad8C+UpcROw/V
	 djicoBUzyuL9tWnFa2YQbZVqZHFaY9kFv68YT3WaRUPku6wWEwvKPkZmKZD49gIW/6qm8
	 OUg994RgEqxaimh3R/KesLBd2qqpl2DF7Shgsfmr+fY81g9/BEEV2MEn9m360XY41oRQs
	 IWVby2u1sRBdMCT0U5AZ5ayOnJXW3IXpHYDAWmv9MDt2UpuK0VLLvXk7eU4PH2Vji5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZgNY5oh;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DD606A338
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586DD606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZgNY5oh
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c506187deb9so17619966b.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795014254; x=1795619054; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/tQwtb+guAS1R6/OD9tZmRzv2qN3TXj6uh+KCQvyAk=;
        b=BZgNY5ohqoEFQkAOL/iufDJibOewT3UgU2WVfwz5xpbqpBVbkYqnhc5ABRsYqWLPj7
         8GTikK+xnUaXefdEgttPL5Dir2FKlQPUJi8SXvikn6YoJ8UbiIxeNQg7jnDHaaDw3Osc
         7HMiGLt7nV5j86eNOAMOXcwjFXjU5ruEQXU4NglemLKDqQEaYmweQOhUf6y5XignaU7O
         piEJezvPTns6OaohWw2T+dnTPhfD44fRRmw2aW3DQLnvkEuv9wCRY/p7kGA0jZIVhCLa
         ud9DSv7W/UVw0VCagPDTiXYbdGPHJa2o2Mgq0t6CGcMtFx8rf8QAjg9T8icFuXsQLdxF
         VUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014254; x=1795619054;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/tQwtb+guAS1R6/OD9tZmRzv2qN3TXj6uh+KCQvyAk=;
        b=0ymEw7mc1x0cst7CRxQM3TjQBoDktl+yBH0b/Wpz5Oj7lfkFsV7I6qIkllXTrBqLZC
         KmKY8xcbbJ0kh5AGyshyj8Ily54KwW5FCSY8KkNzSzy5dtoB+A5wgEQVdjJyEt1tgrab
         o4OzgH8sd1pRNni1AaDjEM5/3Zyq74N482a58E+Xf8lyGY3015XSOXQu2C2egsTzbk1c
         YcJ5Q7ELHguxYV75EowVOg2Y59vuMc33BgBFxXIy8XxrSEndchrIk8yFyBV4h/xCuCeB
         xa+CiIPRfarg7shLm1FWqox5FKxQ/sdZqO2uOHajbhX5pTIP+fn/A/5aX3ETeu+ge5U/
         C8tg==
X-Forwarded-Encrypted: i=1; AL+hErH0FGSKhl5Kzf3kxVpPGXdNvgMbMfxwcjm6Il4QUPG982ZEbDhNC+Zvk6SjAOe0w0Lp9WWhFrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BViBF6ErPvvxySWxyvLhXWZJ4Ed/D8Rv75QtdZC55JPgKpG2J
	tvhrZDVa+nlO3BjqG+aRuggRbRjLbjS/PeEkU41Zn1wFYwxDq2PGgmrK
X-Gm-Gg: AYBFou2dMUrbhxvtXtj9aJCzzczvPYhC4sCj1P2cTRVpzAu1/4DbrWqdaP27vJ2SqHX
	6vmcLsleTN4nLAMNUJ/1PVlRKp1r3nO+ikLq7p/oz94yz6h7R/8UOGumBVLyXIwwIOLnaj8mVM1
	PDlxUW5kuOEeJ0n+7hEBuI7ljExKEq815wkZfKFy5KtgZp/67rnEVs4fw7iS24CK9OHSPRA2nn0
	cNftJeLGbPTLOv+PEh6k5JvXm3sr46Lqzz++dlSPkoPrT64htRVAJfZnoU3aw6te7Z8GPYQ3Bu7
	Ac+MU6QNRvCuqTNjOAg8zpR01snCg2nB0x+ge0zwRpfpdTQZtE0MC9rxrQylODZ2grfQmpCA4vr
	rsQx9skosP1ssh9aDs9IvD1B+G6Jm/DCWTraBxk9ollchuqFvj5ONvv+HHRJIkWna6fS5juCHyV
	0GgpihhzSt/MH1EuzZypKZsY5ovIYV8Sxo0y98jx11Q2Wf1cvnB6RXC4nI4NW+MQep0O3GoU97D
	Hd66V2ZJDXmBDM77lZfGQ9TQzjXulz/YMA6uZPOUrII/Z1PWqsiqZs4hwbtcpCOEiMHd6FTwjZJ
	0SC2Ie3k8/yqlyB+fnnqskWnHm2jMldBpotRPiYG2b/k8dnSlKuC3Q+99Lpdjl94oUxrfH76zuo
	zZFKnnr/Hm6UxEQ==
X-Received: by 2002:a17:906:7085:b0:c2e:8801:9139 with SMTP id a640c23a62f3a-c510deb9e53mr253754166b.1.1795014253543;
        Wed, 18 Nov 2026 07:04:13 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4d52sm7516566b.14.2026.11.18.07.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:04:12 -0800 (PST)
Message-ID: <b6b45a76699f8b5dcfb2fdb1ee682bac0ed501df.camel@gmail.com>
Subject: Re: [PATCH v3] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?=
	 <michal@nozomi.space>, Paul Dino Jones <paul@spacefreak18.xyz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 18 Nov 2026 16:04:07 +0100
In-Reply-To: <c80644469f01ae6d2ba0339a7a2fcd7c6080c310.camel@gmail.com>
References: <20261104-b4-pidff-rescale-exponent-v3-1-f45e64cf488c@cherr.cc>
	 <c80644469f01ae6d2ba0339a7a2fcd7c6080c310.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-04 at 08:41 +0100, Tomasz Paku=C5=82a wrote:
> On Wed, 2026-11-04 at 03:44 +0800, Shengzhuo Wei wrote:
>=20
> Works as expected. Thanks!

BTW Jiri, I'll re-send this as part of a series shortly as I ended up
doing another big overhaul of most of the driver code. It's currently
waiting for Oleg's review.
