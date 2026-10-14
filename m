Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7135BDC2;
	Wed, 14 Oct 2026 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959715; cv=none; b=XJxTGX1mmtCwxWuVlSAiGMBadtx+bBad27PxXxGS5c4XUs/C2DQ6crEW1CMIvesQddceVqTzqdj7Zt8383fmMzTNz1RTfiNvszTTMS1akIqn+A3zXpbpVMMl68ewY8NIAMVHdgbvr83P2E9dTIfuyDjamlQeJbuj3UvixUwEQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959715; c=relaxed/simple;
	bh=BQgNttVkb16QeUcTFW0k6MEASQtNtJZKCmUafCBWVqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fmPMa0YbeCWuzRTFHCj3efJLlHyEyPQQee1h/TSuIV74sHSmlrzzczt5IMwZLO9KW4VIOKxzyUdhd0lTCIVht15lYFM3OKg+NsEJ5nlVYL7Thh7nWS677dFOQfiKs1pcOOnrONSnnzqzWebhvgFUUVgDb06UJFEa+st5c4bC63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qfwYSl1G; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qfwYSl1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1791959702; x=1792218902;
	bh=BQgNttVkb16QeUcTFW0k6MEASQtNtJZKCmUafCBWVqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qfwYSl1GtV1n5o7XbrnvE7TpFiDXxV4hA1rFPf295HEVxw1EIjyw51XRlTTQnLL4r
	 UhXVVOKfl2qrBVyJEEeHvKB1cpuBO51zvG6r2dRMKCz5nF2rdERXUN7dUjP/lQMM9P
	 4kYGhRw2lFOxuomVtvKpL7Gj09fW5DkO63LYNRfMqdlbgqX0d4CuxYojSwv2bTTEc8
	 dBjhrPGYQHjD2ruXHIyGXZoluTWQGnM9wmSTjguAnAjZzQ8c6gG9+6U42iz1jbPHXh
	 f7HHuW/+T9ihMBteZTL1SIUwWSVtBClMD1bFiyVi/b9SBGcNpior+yP2jlNQ6gWKbs
	 R8rsOAeORCriA==
X-Pm-Submission-Id: 4j4LzS2MgTz1DDXY
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
  <stable@vger.kernel.org>,  "Joshua Crofts" <joshua.crofts1@gmail.com>,
  "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v10 00/10] io: accel: mma8452: Allow open drain
 interrupt pin configuration
In-Reply-To: <20261011140002.6e9d68d3@jic23-hlaptop>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
	<dAyKULwunTSyJswxrFIpB8ECEAybMkvW-mArZ8lYOcKRTbekTIUNXyjnN0kqvequ9qJOPuBSNDdxkJijqhL5Bw==@protonmail.internalid>
	<20261011140002.6e9d68d3@jic23-hlaptop>
Date: Wed, 14 Oct 2026 08:34:59 +0200
Message-ID: <8733u8n624.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Mon, 28 Sep 2026 10:26:16 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> Extend the mma8452 driver with support for configuration of the
>> interrupt line in open-drain mode, which is needed for hardware designs
>> where the interrupt line is shared with other chips.
>>
>> Adding drive-open-drain property to mma8452 device-tree node for such
>> designs to enable switching pin configuration to open-drain mode.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> Applied patches 1-9 to the testing branch of iio.git.
> As mentioned, I think 10 needs a bit more review time.
>
> We may loose sashiko coverage. In theory you can tell it about
> dependencies, but I'm not sure how that works with a temporary
> testing branch.
>
> There are some notes on using message-id: tags in the cover
> letter in https://b4.docs.kernel.org/en/latest/contributor/prep.html
>
> I gather from the LPC session last week that sashiko should work
> with those now.

Cool. But in this case, I guess using message-id or change-id would
be wrong, as it would declare the entire series as a dependency, which
thereby includes the patch that is being sent. But Maybe I could use
patch-id to declare dependency on patches 1-9/10.

/Esben
