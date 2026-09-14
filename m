Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B857330B07;
	Mon, 14 Sep 2026 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368564; cv=none; b=fBrF5uhZhG0X4qAg2E611sPv7UVr/+sSqLe13i9UmUkdOGYKDR6x/G85XFOGj8edbwCBuyA0DtwolMvND6uu2df/bsIFqaDSSXJPAyyQRDXQj+TqFc6UbiQAtTtFG7EU381nLlr0F/2nJw4GqjYgbOFLhaR/sfgL6oMVT9JH6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368564; c=relaxed/simple;
	bh=NcFXhEBpUe7LwqVZscQRoaZb+gt7yNgo6Ufyy0d0/RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GmY7ypNj6+65BEU+hb4eKsdoLcZw+BaErdE7QNmBPXqpFDBomuC45jJzEQ2OL9HbGCUdO1gWOcfjbcS1Va+RGbvzAv0Kgiq0Bl3pZ8ugQ4stYYydws9MeGR0mWeni7mw3ecRO9cBMpaTkzNqXaFDKGKMbGHgFqhdbjPYRmTF5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fPkoFe6v; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fPkoFe6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789368549; x=1789627749;
	bh=NcFXhEBpUe7LwqVZscQRoaZb+gt7yNgo6Ufyy0d0/RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fPkoFe6v45z9IQTBkbIw3ny6aSESE9DIuILn8zEgKqdl+UT0suAKF6NziVbnjq1Ju
	 DdBttMT1c0HND3rtcv48tZ0hnNd7oSmIJ/xM3A3AZ4nXd4XU3q+C3sxBSODl5S/Usg
	 UkIg5PNgOiuHmRXTgaTZktFwiV0yjBTkpMVXnTLVwWSOz37CmqNrW765gCoQBw3mzF
	 j4JwEQeYHqGqY2FqUG9i7lkPIoBZaI8GItpSRwoqQZaDK6QBSI99CpBqIIbNkAydEW
	 yKPkRCspT0E0sivAMRvSvUYvUUDZU3YClx9aTNbAyVmb8zjOQfZVNWuZU671JyRHv2
	 xrzbkAEJYMxtQ==
X-Pm-Submission-Id: 4hjwjZ02nZz1DFFg
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,  "Rob Herring"
 <robh@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Martin Kepplinger" <martink@posteo.de>,
  "Sean Nyekjaer" <sean@geanix.com>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>,  "Christoph Muellner"
 <christoph.muellner@theobroma-systems.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>,  "Joshua Crofts" <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v8 2/9] iio: accel: mma8452: Fix use-after-free bug in
 error error path
In-Reply-To: <20260914000924.165405fc@jic23-hlaptop>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-2-c17407e22118@geanix.com>
	<kXI4HQkk_ZaBX-zvTfe8llVum_qJweW1i5BNOfVaTMyDMkIDEPFbdlXWyxaHin49O0t-uJE5RPyiUwydItjNjQ==@protonmail.internalid>
	<20260914000924.165405fc@jic23-hlaptop>
Date: Mon, 14 Sep 2026 08:49:05 +0200
Message-ID: <877bkoqqe6.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Mon, 07 Sep 2026 16:50:57 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> If mma8452_probe() fails in iio_device_register() or later, we could end up
>> with runtime suspend callback being called with a now freed device pointer.
>>
>> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> Sashiko calls out some preexisting stuff that is worth a look
> https://sashiko.dev/#/patchset/20260907-mma8452-open-drain-v8-0-c17407e22118%40geanix.com

Yes. And I have a follow-up patch series where I try to address
basically everything sashiko-bot has raised concerns for.

Given the rather large number of issues, and the corresponding large
number of changes needed, I am not planning on adding them to this
series.

> Why freefall mode is set after the iio_device_register() is indeed an interesting
> question. Any idea?

I cannot find any good reason for doing it like that. I am moving the
iio_device_register() call to be the last thing done in .probe() in the
follow-up series, so that the device is fully ready before we expose
user-space API for it.

> As far as it goes this patch is fine. I'm not sure about the other sashiko
> comment about making sure the device is suspended. Given pm_runtime_set_active()
> is called I would assume that one of the register sequences has indeed
> turned on the device (maybe the reset?) and we should be turning it off again.

There is quite a number of issues with runtime pm in this driver. I look
forward to getting feedback to the changes I have made to them :)

/Esben
