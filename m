Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229953D0C5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871324; cv=pass; b=O7m1e+9l2pRFemzDsfO3yeeA9j5HNJKKK3/OTbNVf/HsRag119MGjPHk/93+QcMAxMvZUGxbb4PyYkyJKHP7lzVCih9uP47WpeEXTfXotqHfMz1uKfoQn4m+V7Za4KoFzE9mJ2qMVllfvhzb9wv4mfGlP5QsgwHkLGTM5c93ILY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871324; c=relaxed/simple;
	bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJZGumDf1LlHoS5NP4S2fd0NvKGKUZGH197mGTvb+wJHE39nqu7kKZNdS3G/uBOMKWx2amsySTRgtKoe5AsFscjCUOnEv1nXp6r/BIBFubodaEDrDhHj23ZjBJefYnxZ8CgeEUngC0WTOsA8IxakiPuEg7A7u81OzBHm5B8jj18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPln5Zp3; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPln5Zp3"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c197e7e4e94so739477466b.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 05:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788871321; cv=none;
        d=google.com; s=arc-20260327;
        b=rBmVL5VEYBFtyLrcsDvlxsi0AD4oOccZFVfSywXkFCmILqNJqu4HQNzG17aXJk1RGb
         X1xZmFVdVL0gA2Q1H6c9/zuSnRlEUMOQ+rbhPfPg6EKlMp7lNafucLL0t7r8k/q6GNRM
         JnIiGJhPYhU2xD4yZFrQ3RO9vWgnhob2nTPh6CvOHdRsZZV4PyAnMPhnAEG9LrvfKei+
         jmf8nFLUdYmsxYJin3zlZK1t1OMvOyM7NNHBpMZ2cqpIrOiOG8sSSwCgFKpwOlvbFYDL
         gJZRSdOmJ1Z8vyldwzBt3xuiDQeuxdjO8Dn5GAtZODzoXu8S9C8oKqlkW0uneP7Ddesx
         ljhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
        fh=CERL+mUBC7tNzPMA/C0qCqVNHl4sfh7E9huwsA8JbFE=;
        b=qYwZ4K+A2Xxg7ZwpAsulYbG849P0DM59SXU5O+SbbizamyRJ1DvaLdIgJlVWul8+qJ
         M0HdmXcfSZuVCXU/xWKZdsbUoQz6IcAI+gYEuXoiAxKJLAy4KZcBq5X9P0iN+WSRCU/P
         uTcnoO3Hi7bc6x4IV31XIah4MWR8eHMMCPse+lORws583y6c1m5U31m29BNziJUtBRQq
         a2kTjXJ/kSNQY9SAabZQZ/aaAvuUv5/Nbz39/BqncMkJnLsTR+GqdWObMxmzDqujgRGf
         VG/+YT8J4wfHh7n8Y2diGCPqQxHjmNTHLNFLESBykdBAnQrc+CDjHiyYjhpcMkEpHx2B
         b5SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788871321; x=1789476121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
        b=hPln5Zp3VVx4vs2pVzL4csIiFAbHnF3Hja+WUxbfU5mD5AWmppMCIVB4nAERESixV5
         3IYV7rqGZR6inPt+16Vc6ZtwRCDHjYUJ/kcmBf9CHPPjyTdLAnF3O8cumPFops1UMNW7
         JydV98T4ZEbVbcwLpTf5X17h/WPT+PMFc2Igc4aE7iQY0DiOW6rfyxUIs8QIylQ6PigJ
         YPWWI/TH7j40y7jJZS+gSl5qmaa3u49SFkYrO9k5lDlC81mPun0Ejp50v2vUQaH0qiXA
         CTOWch/1QEqi1iTVrBIeiurtjl6VUXcJBb8BrJnYZbXA9tQfYdwCKNPm5aqckandgYJO
         4inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871321; x=1789476121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoFrigmlvBCol4gAOv1BVVUy6nOClXwHsZRUnMO/Rck=;
        b=FqGx74Fx/syusunMra1cPC1geNG9RFolN+RF3Tbw7nLihN+JkFDHfNJ3AhWvX6I8L/
         omI8O4uHVm4td3yExnOwk1EhGeB/ZS6huoOT3NtsJP18AodemiXMFuwuVxEoZrh+7+QF
         RSKAfV0Zoif/ZgCYusyqx2XAxxeceqZ/4SURDnlIIHrEKvwpCg0Uz/omXDYuesxdriuj
         lDKfx58eJKl7hPMl7Ezg6R6LmniGMzsPilYNFJMN+TVr8DniUkUM0V11OnS0za27LP2A
         yT6NLILkttsoSJYD2eSXXbcaHRv8YG/fX8D9k3PbqCknIVX4ouuFTprxs4aLiMKYHeRp
         r+CA==
X-Forwarded-Encrypted: i=1; AKwUvBxqc6YwjHYGc2Ky7zVrssdyteVbp2rLbqHVgibesIHdIeBGUM9QsxyPOM7AoOeVgoVdZAzjiNg=@vger.kernel.org
X-Gm-Message-State: AFuF++lCS+8V9nxLNkMG4F+kaCYX1liUDICHyB+bTyzLAAn4SrorRdpj
	/q3zmwW8q11PobaT6vEwGW+w64sY0mSyBWrf8tJvZ7GqtWxiLPmmKL9OxjkDQm5afEZn1J1rJ0h
	8WU0vgMpXqY8yqTEYoqcGRzqImm59gk4=
X-Gm-Gg: AYBFou3tXP86hL3GP12qYtkNumb8dSzpb0hpqWIxH4m7Z4h3aikJbyFMAgmb1KoBfLq
	qQCx+0ErKCubiaLttTJEfKn42jjloYpHnIiJ+3/IBR4NVCmc94tK2ZvXjk0STSNaReUKMd5VPXQ
	JZ8ExEKBHvtrWYvI/8An0mN34cRMprljx/YnZHDzqA0fV24K9yy9RWNuyuNezgVE91SXe03HY/r
	ZngEa2EgYofYtgCcjAobFHFfgTkqXZWok7bZwPCkpZTfgigqiqHULN4sC3x3YKkxDlAiA15BKul
	I5Zr53nFCo4bSEPqDl0eQEOumFikHHT3Rntv+zZcrttVZILZCKgmK71eIfjQEzOhQu+7yTkZgSq
	bLpngnRRnm/GnPQ/9eTQnwCfqyxv3seNXxOTJzJTSIaeVbayvsRDY2v+JraJN5bhDGu6ibonDTS
	wn+nP9Y1+SiD7aUWij9dAt4al+f/extQ==
X-Received: by 2002:a17:907:a892:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c260c988d8cmr1050021866b.12.1788871321161; Tue, 08 Sep 2026
 05:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908114047.1360-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260908114047.1360-1-joshua.crofts1@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 8 Sep 2026 15:41:23 +0300
X-Gm-Features: AcwNN1WS1TCR78p_ZCpT7YYJ99OzAPGWGJrL9p5fNGsCglr8Gtv7IcE3tK5sR_c
Message-ID: <CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE macro
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, 
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 2:41=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
>
> The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TABLE()
> macro.

Is this a problem?

--=20
With Best Regards,
Andy Shevchenko
