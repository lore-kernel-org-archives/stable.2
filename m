Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7D6AD4;
	Wed, 14 Oct 2026 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958938; cv=none; b=keJE6FPyIm5s8uLX2x9vhcMTq/j1/ga49U74bM7at1N6ZaVXBKs7Zay46bdI5n/lb6cawt6LgwAH2FbfktC4RJq3mzXUWNguAFdv3LwP6IWipQkMbjXd+cWzgJvK+zfxhdKbAQwIDHq13Cgngzm0LQGl47LRHsbwFbwtJvIbW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958938; c=relaxed/simple;
	bh=zVFOwxbB3E4WyNM5PAk+G90lPh5f8tZUn++eTVfJwfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=co3tHbT3F0mNfMzbVItgKOFJ0/I8YEJx9S6dFDnZ9uMR10ulVEGPYG0CX2iTHyHiR0FdaCvnJh1exDprPlviaXM6myjGOUgmGjSt6v2msRQ4EkSWLL3bWnS93wSOE483rE745Y5UO3JhVJ9LyNWfGjWBEtwUu6Rf+t9ZcSWrD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qiTnqKh0; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qiTnqKh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1791958923; x=1792218123;
	bh=QoFk0sTVo+1didJCGcFzVD80StcHCyEnGCJt5nv+Nxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qiTnqKh08A+3nCtQvFvhuuGPh2MRmLW9VQgSxgOplQqA6qCtdaSOQLSDTl1PZ3N3Q
	 mZmdhMR0SQbGbfHYMlHjEDU9unGbRigHWgviXLWc7jagtdd5b4Tep0c3F6ztdVeDKu
	 PCsBYtK697Mj+PKOUuxjeUDkE2jj4vtVciJ46lhArtRuYH/ZruTCgs0/EVWMTJkDsB
	 2580wIc5WaoWgVeoqqrjaEkXwDt7aanur0uYxfUprprpTFsAUv9ksmoJvwv/EvgPAw
	 IDmzak27Q02OvXW22CivKpOje1kb3L8NA4ibv0HdqEu2NwcBVA3poKC0KA4yzgVyyE
	 8k8nc9wL1tk2w==
X-Pm-Submission-Id: 4j4LhT2NWzz1DDXY
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
  <stable@vger.kernel.org>
Subject: Re: [PATCH v10 03/10] iio: accel: mma8452: Fix runtime PM bugs in
 mma8452_read()
In-Reply-To: <20261011131946.16bf4ef2@jic23-hlaptop>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
	<20260928-mma8452-open-drain-v10-3-b906fb408386@geanix.com>
	<GeX7K7CYF-lXclqwIekwHIBfSYzjYsnqvMmrM3rjseabSeadIpRDZWUszx0kgtCHnqd7h3ivbFEbn5Q7Go1oBQ==@protonmail.internalid>
	<20261011131946.16bf4ef2@jic23-hlaptop>
Date: Wed, 14 Oct 2026 08:22:00 +0200
Message-ID: <87bj8wn6nr.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Mon, 28 Sep 2026 10:26:19 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> When runtime PM support was added [1], the implementation in mma8452_read()
>> was done incorrectly, as it calls mma8452_drdy() before ensuring runtime pm
>> has set the device active, so it can cause read from STATUS register while
>> device is suspended/off. At the same time, the return value from
>> i2c_smbus_read_i2c_block_data() was discarded, and the function would
>> return the value returned from pm_runtime_put_autosuspend() instead.
>>
>> When the latter bug described above was fixed [2], another bug was
>> introduced, as mma8452_read() would now leak the runtime PM reference
>> counter when i2c_smbus_read_i2c_block_data() failed.
>>
>> This commit corrects this mess.
>>
>> [1] commit 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
>> [2] commit 5bdff291d20c ("iio: accel: mma8452: handle I2C read error(s) in mma8452_read()")
>>
>> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> I suppose not directly relevant to this patch but that
> set_runtime_pm_state() helper is definitely not helping.
> I'd follow up with ripping that out and calling the two runtimme
> pm calls directly.  Then you would be trivially able to use
> ACQUIRE_RUNTIME_PM() etc to reduce complexity in places like this.

I have this queued up pending the merge of this series.

> In more recent drivers I've always pushed back against that
> sort of helper precisely because it stops other sensible refactors.
>
> In general that also follows the common pattern of not checking for
> errors in the put as that trips up on things like !CONFIG_PM and
> is generally not that useful!
>
> Jonathan

/Esben
