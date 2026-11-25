Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795595080;
	b=cEwaMSlv5kNj06JaTdhumFhGZXnP+2WL8Ws4PAYRENSCLTgmfQ807HDlxJd2wpUsfDnH
	 x26PMH/RqzfE9mEV6nvs3IOksoTFU83ZULruR+htY4CIdgpvH77GjxzxKqD6q7WkxPUls
	 Rz39bC1iItD2YQPs8/9EwMmEvD53K17m099wTcknEJs4WorSPWK6OJUeGBY56bgiRBa/L
	 ThskfiAFXjqJMxsByAFSkgZq3w30wLP5wsCGFjtGIkag8ntbbWm+s3LO8jZ2GQfc2r33c
	 OX/xp9cktEZlzNhpZbsIqZj0Sy0r8YdtOTt4C/MjCvsTaS+/sctQ5ZIva+YIc8VWhdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=+OgTYY8n6yc3qcbD3zimkqKD2AWn/72ixSa4WihkrKk=;
	b=x0K7mDuDMbVOwVcTjLsLVp/Ngz8v5/jL0V/Tibrdo/8KiUZ/LLer0goAz6EK1FVV+4iA
	 WtSSiZVOFJ8HNaR8XvPAkJ3bO92nKBMibW38zqlhs0fTW76MKDE1YQTCF8WJwAbmwyjWF
	 wymw9oJa6Xt6SSRncaT2ZyH/vFiG7E3lX/UMNySHT2gR9CZcH9AqpWDAJk2TTlehehB9m
	 QW9NzG4HBs4jjEGV31NPGEJ9i473gZRBzO6fG4sMMweBytxzFUuo91BKoZ1KrkDnWshqf
	 Pzbr7i3kh3rMc9KMbJBQ3lffBn9xK5BLblNpDP7EEYw7lFCgH5tW1TIuqHJPCDjTriA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JYnBbibw;
	arc=fail smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC810606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC810606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JYnBbibw
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c506a231b88so745446866b.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:24:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795595078; cv=none;
        d=google.com; s=arc-20260327;
        b=JZnIXlqQXm82FJZYMLQvCFng7wsRgDffrOI13oq0KPUDiPLVrnwCzmLQY8KA65WAAb
         sx3eDWKqVfzMXz5vLu6QBe2Dp2x6gV3eDZRZyGMpbENZ+2rwb7ULfP+Pq2KPyn0M/Gob
         jCa2QoUtj2a8wOyzK92yQP3+5KNoR7LVQSjp7FS1GK1ZRIn6VLW8Fk5qlenPG77O1DQ5
         9s7ZoJ9VoqAaIc7z8U0pR+h3j81BebLCTeSC2WZWCqwWzQUVpxOjap8nlFI4Qe4VWYXj
         4ZYTowjX9I+DnmawmF9n5pJPrguJRl4sHk6wquztnAQtB+S4dePkKlCV2TNUjkuAEvsy
         kxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:references:in-reply-to
         :dkim-signature;
        bh=+OgTYY8n6yc3qcbD3zimkqKD2AWn/72ixSa4WihkrKk=;
        fh=/2W6HSBBbveIwLsECtVk7BoDNiU3956zFWTqF5QaDLw=;
        b=JU7lV3StSaZc//tDv3iG8uC00BXn5WoI63nRKyLLtg65NkXPkg3LVthk8Ktwjj65vx
         VsQO6bxw/CllTRX+dmxsiekG/ON3ehFVrBa8zoLqmcAvtvN3dNi4/IvG0/Ho0bjtw2XS
         mabAANPBLdaELdXzlmL1kpChlOro9gZCf0A/aLIC210H00RJEfNhcjU2WF9QP5f0ePBh
         8IGruv55qLjvkOr/LsLAZ1GDHUDPHWgNE8DS/8FKWDkBhspPguY1571Wh8hd6yGi5ZTK
         vJLBuz/XF1z5GBXX3d8rQLcOoUTHSYGAHIhaNQUi1kpkxQrzm1rQ04pN/7q90p7Tickx
         DMBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795595078; x=1796199878; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OgTYY8n6yc3qcbD3zimkqKD2AWn/72ixSa4WihkrKk=;
        b=JYnBbibwmphUIXBEAUa/kCRgqceDjAv/l0WaihxjyopfKawc6bFPMZ7cTmF1eUTr+L
         TTTNgbOLg/4QD020Cx7XQt8dIw/AjE7UoUpmYOgEe+tNmFWjvyo9bA/bvacvwqZmcTyq
         K1ML8TTAed1Ce7U87SlAAPCyU/VCU9Dy7KoXVTVlFqCPjY4yFZUWcvCvHc/PgjuldAwX
         JPgWJ6HbXqGHBqXuaqCtwdvgJ1326sNr4ew0JiCNoeLtluQUnE2Ri5S5hnGSNlCRp9La
         T3ZJquk487Xd8+GyuVbvi7Gqkn1rVwCQQZRLf0u/upQ5wKeu6zZ3GeQcGzgIa5481Xfq
         gSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795595078; x=1796199878;
        h=content-type:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+OgTYY8n6yc3qcbD3zimkqKD2AWn/72ixSa4WihkrKk=;
        b=VaPbekzyZq5nU3OPMvJEHmoCEhfRqVoalZ+DvJJnL9PitZuMJoOnZwH/bxK0XZ7+xh
         5sqVzAsOHWy15cRS/xuGGjaJ+8/RRvPxTIUHGuhxIMKxMrZQG/P899pvioh1QP4mMzy6
         B9kk8hKIxf6Eo5Cp626uxFzE9s5TaAZhExjrwfNa5xA4+6lvLJrlgFHNOTfYqqKmU9A+
         sphhNM+03TxCOsm8rYe8vNA2nNRLaDEUd7GdIvXRPms46U5WLIhJj0O9E0F/ANThOT+h
         gZWjS7oTRSj6qb9iU1scl0Qp6574bLYI2Fen2lGl3rO1OHr6L8M0uJBjkCusgazf4gM0
         wGwg==
X-Forwarded-Encrypted: i=1; AL+hErFGSy6XIFTrSiPez4oDB7TZwvLr3BLpchKNUUYIlwL7hlKqPQhZHFxI4IZxwlMCop7OSGkjYzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3fDLD1aYcjxafFHJC8hG9iuijJuJsp3Tts89WpjoKdsGbiUMn
	sjUuBVzCawsXcdDyD/GTb2i3iJoopFDJmjFvOMXjmwSsP8XI+uG6j9OPrrBiFtjjxAurQtbBK+i
	7BOMi6Ma88F+itLNnD1XOwMk8YlYIh/o=
X-Gm-Gg: AZFdTZfTgAin1hevAIvYdAgzmctEYnkJ/8WDCrwpYkIqVZB09cVDESbmiZ/A1lCluPS
	vJffZPvW1Iz4qFGdTwkMHX6xJ+TVjIf4iSnmf+aXTc6Zn5fHHMlaIe0vM+R5XMeDcsGXo/Rk3BN
	n5aRrFj2/Kx5FOOKNC9HRxrjgvSoaSqy6Sxz3TWGLwGJHN3YzO4VQZjZOMkQjQzCgEqxk+BKgNX
	lqZTXtqDZZPfw0l3J34gTQ1ofaSSnofFdPGnDFPi7d5Llk1XhwCdVBFaV+JTuC6cq34iuj05pDX
	pBYFgfjeXsCnJPV3L+pnkCaNT6Ca3ayQtRfXElZnGViZ1DzGSoTegcSz55uN4qGSt9FK9Cjp6z8
	TBCdos1Qf6pCDWZ6RXD2jyFBltqeFmDfid6H70A==
X-Received: by 2002:a17:907:fd15:b0:c40:9e84:942a with SMTP id
 a640c23a62f3a-c513aade153mr1426627166b.48.1795595077992; Wed, 25 Nov 2026
 00:24:37 -0800 (PST)
Received: from 1087654160852 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 08:24:37 +0000
In-Reply-To: <20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe>
References: <20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Eduard Aliman <edialiman20@gmail.com>
Date: Wed, 25 Nov 2026 08:24:37 +0000
X-Gm-Features: Aa3M54o67SCsnlpq9AQJICAL3atDqUTbJibGMy_iK-r2wySf-JoH44j30Oevkfs
Message-ID: <CAA4HgY+tuBiz06+uq0nfBVfzmVCVPatb+9LGdFN8L3jOPSNfqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] platform/x86: ideapad-laptop: Trigger the EC on
 YMC events following Windows behavior
To: Rong Zhang <i@rong.moe>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
	Andrew Kallmeyer <kallmeyeras@gmail.com>, Eduard Aliman <edialiman20@gmail.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahir Faisal <mahirfaisalantiq33@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rong,

I tested this v2 series (patches 1-7/7) on top of Linux 7.3.4 (Fedora 45)
with ymc_ec_trigger=1 on a Lenovo Yoga 7 14ARP8, and it completely fixes
the issue: folding into tablet mode now physically turns off the keyboard
backlight, and unfolding restores it, matching Windows 11 behavior.

Tested-by: Eduard Aliman <edialiman20@gmail.com>

Could you also add a DMI quirk entry for this model (matching
DMI_SYS_VENDOR / DMI_PRODUCT_VERSION as in patch 7/7) so it works out of
the box without setting ymc_ec_trigger=1 manually?

DMI info on this machine:
  sys_vendor: LENOVO
  product_name: 82YM
  product_version: Yoga 7 14ARP8

Thanks a lot for tracking this down!

Best regards,
Eduard Aliman
