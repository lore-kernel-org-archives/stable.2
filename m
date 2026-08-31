Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D44B1275;
	Mon, 31 Aug 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191233; cv=none; b=CSqV8tDJ11xs/gaFj41hX8zKqK+IrBrP7eojBMv2KSbOqJyJjPSGd5niwbTjVBo9mPG+3z/D8rqSwNnQgJ9NV4Q3MCqTw5suMq1G8UBLQEBPoYhe1oWpE1adHwlzi/qESbwh9a6xmztfRqpi5aP6POmlW12PHiWbzDaoHCf0PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191233; c=relaxed/simple;
	bh=OhxGGxmaAKtp7SeqWhlc4/jjqs40hTw17vjrraFI7Q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BxunrcRNN3jDzfVuX8MZtHGtCIJfZL38B4aCK7+aZ7jRPnFOVboxb3EF30MbdFnAXb1JTrXddt+vEwW+ACTomxQK4K58sTu71dEGjkqMW6K8IjgZeVgMS15SxSdrXsSkEKv1ZWoC3XxAaUL5yrTfiuoe3kW1TgXV042siXNgC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QrGr5jks; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QrGr5jks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788191228; x=1788450428;
	bh=OhxGGxmaAKtp7SeqWhlc4/jjqs40hTw17vjrraFI7Q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QrGr5jks0Xkp7MoD5gj6dSwYO11odHqx3R1F2iGFSdv0Tvv3MFKhqxot7YovUR+8k
	 0DQIKJFAgHc9Pj3DdkEwFJhrX3EgZ7+HllWcMiDNNPly2UCRHAqgL6gajdT8ZkUUl2
	 VRXqUQUrYgquxvCSA1reGUnjreempDYXQjN/QbtEYSnh5Mdo+eFRU+XP6bo6YkCnuP
	 N2wWnAorEjriu8y7Gn0yn/TsyITesqMkyqO0nvhRrIOgIFfGtkwvJ3Hbmg4kXwh5jC
	 Lpxt9cR5+MIBlmgp8jn9r3O7sjYjxONn804+5mVG/9jFDcqpK3dbH50r9uslzc2icd
	 sP0UCAvBpTPFg==
X-Pm-Submission-Id: 4hYYJp1nyLz2ScNm
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,  "Christoph
 Muellner" <christoph.muellner@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH v7 7/8] iio: accel: mma8452: Fix use-after-free bug in
 error error path
In-Reply-To: <apWI7aYneejpZ-hs@ashevche-desk.local> (Andy Shevchenko's message
	of "Mon, 31 Aug 2026 17:00:13 +0300")
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
	<20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
	<Ym0ler-b-_OyfTN4nbB1NEdMVQkVxjtsv6JqNx7G31ML2HyR9nvFE21NFWNcozTD6nRQST4hhyUU8Opoabqy6A==@protonmail.internalid>
	<apWI7aYneejpZ-hs@ashevche-desk.local>
Date: Mon, 31 Aug 2026 17:47:05 +0200
Message-ID: <87ecfeuwau.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Mon, Aug 31, 2026 at 02:17:10PM +0200, Esben Haabendal wrote:
>> If mma8452_probe() fails in iio_device_register() or later, we could end up
>> with runtime suspend callback being called with a now freed device pointer.
>
>> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
>
> Can this be popped up in the series? I think previous couple of patches are not
> fixes...

Yes, popping it in front of all the other code patches in the series
does not seem to cause problems. I have scheduled that for v8.

/Esben
